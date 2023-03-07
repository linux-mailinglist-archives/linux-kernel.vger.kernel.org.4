Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9196AF6A7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjCGUYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjCGUXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:23:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319758A6D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:23:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC507614DF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 20:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C12C4339C;
        Tue,  7 Mar 2023 20:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678220618;
        bh=zda+VbG39EuOmqkJEqNyN6EQjdt58w158b+x94tcTtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rNTBs9H86YYrMsI6GY62OKUY/zA+Y/N4//bAkoDBohiDpxWf3xg5Fvuj3jmSgnsYy
         847gso8bU/q2cYiZE1keCVkfpHTHzYgfdyc6i3gXwOSHZlJMhBxhvQcmp294dgO1Y9
         smnUpiczFeYWtJuG2zo+5N/mlJgtdI86csYALnq6rArW+1GY5n3ET2TQkw+GmLp8Rm
         okAAtihHtRyVci0pm0STHpam0M/ms20FbdLvXCBtfrFYs1tgcDkRljYzMuJg/8ncup
         2u8Z9OH5FbscqGPaPbNu6lDIodWhb4KXVwMZOJivlCSvi6gM8fYhZneZIrGkPAL9hY
         /brzgVWQSitJA==
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/8] soc: microchip: mpfs: handle timeouts and failed services differently
Date:   Tue,  7 Mar 2023 20:22:58 +0000
Message-Id: <20230307202257.1762151-9-conor@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307202257.1762151-1-conor@kernel.org>
References: <20230307202257.1762151-1-conor@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3200; i=conor.dooley@microchip.com; h=from:subject; bh=pwrSJrBRsgiePyr0G5aY+e8m9Q0BM9VvEVyERBwr1ik=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCnsc4V5zm27ymprZ7VAkrUva0X8rPMu97a4F7ucz+T22 /UxbM6+jlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEykgJeRYfpcZy2PGvs1v1cf urPvW+3Mp3MMjA9oXX7pJvrqyvvgW38Z/pe+cf/f52Ir4R5w0Vrc+t/E/v1Sq/i2zS4umpD0t4r 1CRsA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The system controller will only deliver an interrupt if a service
succeeds. This leaves us in the unfortunate position with current code
where there is no way to differentiate between a legitimate timeout
where the service has not completed & where it has completed, but
failed.

mbox_send_message() has its own completion, and it will time out of the
system controller does not lower the busy flag. In this case, a timeout
has occurred and the error can be propagated back to the caller.

If the busy flag is lowered, but no interrupt has arrived to trigger the
rx callback, the service can be deemed to have failed. Report -EBADMSG
in this case so that callers can differentiate.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/soc/microchip/mpfs-sys-controller.c | 27 +++++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/microchip/mpfs-sys-controller.c
index e61ba9b7aae3..ceaeebc1fc6b 100644
--- a/drivers/soc/microchip/mpfs-sys-controller.c
+++ b/drivers/soc/microchip/mpfs-sys-controller.c
@@ -18,7 +18,11 @@
 #include <linux/platform_device.h>
 #include <soc/microchip/mpfs.h>
 
-#define MPFS_SYS_CTRL_TIMEOUT_MS 100
+/*
+ * This timeout must be long, as some services (example: image authentication)
+ * take significant time to complete
+ */
+#define MPFS_SYS_CTRL_TIMEOUT_MS 30000
 
 static DEFINE_MUTEX(transaction_lock);
 
@@ -41,14 +45,26 @@ int mpfs_blocking_transaction(struct mpfs_sys_controller *sys_controller, struct
 	reinit_completion(&sys_controller->c);
 
 	ret = mbox_send_message(sys_controller->chan, msg);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_warn(sys_controller->client.dev, "MPFS sys controller service timeout\n");
 		goto out;
+	}
 
+	/*
+	 * Unfortunately, the system controller will only deliver an interrupt
+	 * if a service succeeds. mbox_send_message() will block until the busy
+	 * flag is gone. If the busy flag is gone but no interrupt has arrived
+	 * to trigger the rx callback then the service can be deemed to have
+	 * failed.
+	 * The caller can then interrogate msg::response::resp_status to
+	 * determine the cause of the failure.
+	 * mbox_send_message() returns positive integers in the success path, so
+	 * ret needs to be cleared if we do get an interrupt.
+	 */
 	if (!wait_for_completion_timeout(&sys_controller->c, timeout)) {
-		ret = -ETIMEDOUT;
-		dev_warn(sys_controller->client.dev, "MPFS sys controller transaction timeout\n");
+		ret = -EBADMSG;
+		dev_warn(sys_controller->client.dev, "MPFS sys controller service failed\n");
 	} else {
-		/* mbox_send_message() returns positive integers on success */
 		ret = 0;
 	}
 
@@ -107,6 +123,7 @@ static int mpfs_sys_controller_probe(struct platform_device *pdev)
 	sys_controller->client.dev = dev;
 	sys_controller->client.rx_callback = rx_callback;
 	sys_controller->client.tx_block = 1U;
+	sys_controller->client.tx_tout = msecs_to_jiffies(MPFS_SYS_CTRL_TIMEOUT_MS);
 
 	sys_controller->chan = mbox_request_channel(&sys_controller->client, 0);
 	if (IS_ERR(sys_controller->chan)) {
-- 
2.39.2

