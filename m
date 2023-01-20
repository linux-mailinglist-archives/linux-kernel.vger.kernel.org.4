Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B1B67578A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjATOkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjATOke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:40:34 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178002A14C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 06:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674225605; x=1705761605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oYx+ncPt3aXXBAx6eIW+t/dOXcIk5sAoEFiHLkKETcY=;
  b=zQaHWIH9n/1VWrZ95QPeUIsJ1l80G2GhUyXIRB+aSirK7CDFEf9XVpTq
   eyBTqPLx6Zq/9tAtgcjHfu5cHXMCzbzvvVm6cB/JH5XqYbmPpJoO/bNlK
   EeS3K8uPqJaL7Tt2aBm370+EbEQCB8cRswaNDpFwFstxl7asvbdr6IHpH
   vhzn/DYin6dFqjM7TFI/SzbMoECKVOeJbFZGn3iPr4fx1bwJ5C7W6uno8
   Xj/i3OOO11Z3VOqswHrzAHR5h9pci5ySP/XDlh57g8l2Ptd+jkauwuVmi
   Awb3D0ZWfXfB1nzr8Fl2WS/OAGfiTFecmr+HuU0gkNAuA54ZwRVgzl8Xf
   A==;
X-IronPort-AV: E=Sophos;i="5.97,232,1669100400"; 
   d="scan'208";a="197471546"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2023 07:38:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 07:38:19 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Fri, 20 Jan 2023 07:38:18 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 7/7] soc: microchip: mpfs: handle timeouts and failed services differently
Date:   Fri, 20 Jan 2023 14:37:35 +0000
Message-ID: <20230120143734.3438755-8-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120143734.3438755-1-conor.dooley@microchip.com>
References: <20230120143734.3438755-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The system controller will only deliver an interrupt if a service
succeeds. This leaves us in the unfortunate position with current code
where there is no way to differentiate between a legitimate timeout
where the service has not completed & where it has completed, but
failed.

mbox_send_message() has its own completion, and it will time out of the
system controller does not lower the busy flag. In this case, a timeout
has occurred and the error can be propagated back to the caller.

If the busy flag is lowered, but no interrupt has arrived to trigger the
rx callback, the service can be deemed to have failed. Report EBADMSG in
this case so that callers can differentiate.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/soc/microchip/mpfs-sys-controller.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/microchip/mpfs-sys-controller.c
index da9cfeda6f78..2dd100ab21b1 100644
--- a/drivers/soc/microchip/mpfs-sys-controller.c
+++ b/drivers/soc/microchip/mpfs-sys-controller.c
@@ -45,14 +45,25 @@ int mpfs_blocking_transaction(struct mpfs_sys_controller *sys_controller, struct
 	reinit_completion(&sys_controller->c);
 
 	ret = mbox_send_message(sys_controller->chan, msg);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_warn(sys_controller->client.dev,
+			 "MPFS sys controller service timeout\n");
 		goto out;
+	}
 
 	ret = 0; /* mbox_send_message returns positive integers on success */
+
+	/*
+	 * Unfortunately, the system controller will only deliver an interrupt
+	 * if a service succeeds. mbox_send_message() will block until the busy
+	 * flag is gone. If the busy flag is gone but no interrupt has arrived
+	 * to trigger the rx callback then the service can be deemed to have
+	 * failed.
+	 */
 	if (!wait_for_completion_timeout(&sys_controller->c, timeout)) {
-		ret = -ETIMEDOUT;
+		ret = -EBADMSG;
 		dev_warn(sys_controller->client.dev,
-			 "MPFS sys controller transaction timeout\n");
+			 "MPFS sys controller service failed\n");
 	}
 
 out:
@@ -110,6 +121,7 @@ static int mpfs_sys_controller_probe(struct platform_device *pdev)
 	sys_controller->client.dev = dev;
 	sys_controller->client.rx_callback = rx_callback;
 	sys_controller->client.tx_block = 1U;
+	sys_controller->client.tx_tout = msecs_to_jiffies(MPFS_SYS_CTRL_TIMEOUT_MS);
 
 	sys_controller->chan = mbox_request_channel(&sys_controller->client, 0);
 	if (IS_ERR(sys_controller->chan)) {
-- 
2.39.0

