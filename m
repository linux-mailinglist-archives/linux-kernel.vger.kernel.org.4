Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCB862FFF6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiKRWW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiKRWVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:21:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A5AB855C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:21:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E54B6279E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 22:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF7CC433C1;
        Fri, 18 Nov 2022 22:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668810069;
        bh=K4TWLp30MXq/vlUO4bYw+Yxu6jQkHHR0g0VL9tJJy0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aHlBYrVzekL56zjVEHQIDbk21QpS5JB4djm47cUUTIl9N3czKaqcJCOvQ371Efp7X
         bgEg21np2uyEsEIkbB/bOUB1AKsw3qRwD+WlYzSuULyunEDetNHGpgT4TDLoguKwgo
         7Od7J0jF97Jqk3sQtrikDjxMUZic+fpnByt5H1C7bg15QvTMr1txfzVNqeBYg6LGJ5
         P/noDLVDp84yQ9rHJdJz2LqpPVKJN9r4r1hd1RJ+jlw74jjgg6qZ8HA4W5fGPUFYpJ
         1Nde3oLOLxmIUyn7Ne8u1Ay2F8rG0S5Zf0zQcohRJaYsBk8uGktrrbtNG1FChQNU91
         deNda9hb8pYZQ==
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mailbox: mpfs: read the system controller's status
Date:   Fri, 18 Nov 2022 22:20:44 +0000
Message-Id: <20221118222043.1214776-3-conor@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221118222043.1214776-1-conor@kernel.org>
References: <20221118222043.1214776-1-conor@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Some services explicitly return an error code in their response, but
others rely on the system controller to set a status in its status
register. The meaning of the bits varies based on what service is
requested, so pass it back up to the driver that requested the service
in the first place. The field in the message struct already existed, but
was unused until now.

If the system controller is busy, in which case we should never actually
be in the interrupt handler, or if the service fails the mailbox itself
should not be read. Callers should check the status before operating on
the response.

Fixes: 83d7b1560810 ("mbox: add polarfire soc system controller mailbox")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/mailbox/mailbox-mpfs.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/mailbox-mpfs.c b/drivers/mailbox/mailbox-mpfs.c
index cfacb3f320a6..6b99abac0b11 100644
--- a/drivers/mailbox/mailbox-mpfs.c
+++ b/drivers/mailbox/mailbox-mpfs.c
@@ -2,7 +2,7 @@
 /*
  * Microchip PolarFire SoC (MPFS) system controller/mailbox controller driver
  *
- * Copyright (c) 2020 Microchip Corporation. All rights reserved.
+ * Copyright (c) 2020-2022 Microchip Corporation. All rights reserved.
  *
  * Author: Conor Dooley <conor.dooley@microchip.com>
  *
@@ -23,6 +23,8 @@
 #define MAILBOX_REG_OFFSET		0x800u
 #define MSS_SYS_MAILBOX_DATA_OFFSET	0u
 #define SCB_MASK_WIDTH			16u
+#define SCB_STATUS_SHIFT		16u
+#define SCB_STATUS_MASK			GENMASK(31, SCB_STATUS_SHIFT)
 
 /* SCBCTRL service control register */
 
@@ -130,13 +132,38 @@ static void mpfs_mbox_rx_data(struct mbox_chan *chan)
 	struct mpfs_mbox *mbox = (struct mpfs_mbox *)chan->con_priv;
 	struct mpfs_mss_response *response = mbox->response;
 	u16 num_words = ALIGN((response->resp_size), (4)) / 4U;
-	u32 i;
+	u32 i, status;
 
 	if (!response->resp_msg) {
 		dev_err(mbox->dev, "failed to assign memory for response %d\n", -ENOMEM);
 		return;
 	}
 
+	/*
+	 * The status is stored in bits 31:16 of the SERVICES_SR register.
+	 * It is only valid when BUSY == 0.
+	 * We should *never* get an interrupt while the controller is
+	 * still in the busy state. If we do, something has gone badly
+	 * wrong & the content of the mailbox would not be valid.
+	 */
+	if (mpfs_mbox_busy(mbox)) {
+		dev_err(mbox->dev, "got an interrupt but system controller is busy\n");
+		response->resp_status = 0xDEAD;
+		return;
+	}
+
+	status = readl_relaxed(mbox->ctrl_base + SERVICES_SR_OFFSET);
+
+	/*
+	 * If the status of the individual servers is non-zero, the service has
+	 * failed. The contents of the mailbox at this point are not be valid,
+	 * so don't bother reading them. Set the status so that the driver
+	 * implementing the service can handle the result.
+	 */
+	response->resp_status = (status & SCB_STATUS_MASK) >> SCB_STATUS_SHIFT;
+	if (response->resp_status)
+		return;
+
 	if (!mpfs_mbox_busy(mbox)) {
 		for (i = 0; i < num_words; i++) {
 			response->resp_msg[i] =
-- 
2.37.2

