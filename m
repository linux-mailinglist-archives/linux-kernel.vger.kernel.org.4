Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41A76AF6A5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjCGUYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjCGUXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:23:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2397EA0B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:23:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2BEC614DF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 20:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1252FC433EF;
        Tue,  7 Mar 2023 20:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678220616;
        bh=Hyj1AzwSvpLlh1c+5n8He7fqMvxbQ+81FBS9Lk+fweU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KPzHXOuv7fRzzZAIoUsTGBHAIQ+kSCElxymLxPu3KJJQFNFj82hJ+TYhuGIuXD9SU
         5jvKSpZiiM7iokRN/p15cNZ5Y1R05X/yXWYbdEvptAkHN5EP8931cZnErgzj4OA9G7
         Lv2qZ7Ypn+ZVkwh/kpAy9lTEk3yYqLAph4r0mHH+icyhcyOwGzrRWwJU9dcsWaNNdC
         WH1MYjzvL7pb39MXGy8dHxZ8PTlLSFPRGPGTxbG8YOtTXyLsZiX8/n7zb1VYerk1b/
         FwfMBTwbUOH+WsKVtcIGg5qVxBJYVebxSfIxTgvaKluWdhva5CvdN3OPSTNs+uDmYe
         i09pITodsp17Q==
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/8] soc: microchip: mpfs: simplify error handling in mpfs_blocking_transaction()
Date:   Tue,  7 Mar 2023 20:22:57 +0000
Message-Id: <20230307202257.1762151-8-conor@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307202257.1762151-1-conor@kernel.org>
References: <20230307202257.1762151-1-conor@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1912; i=conor.dooley@microchip.com; h=from:subject; bh=TiTo00L6NEuRkl9W6QwqcYPRUYBdT9OXo1cRIbTtbsQ=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCnsc4W3n14zrYEnhHdHxbpXh8XmqTFZx2T1bdjlEeM57 zj7Ab3QjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEykdRsjw2JPr/llRYzH+bbz 5hX98zlQnnWbfefuAytTfq6ZyVP8MpCRYf+rqHO7WuoyNql/u3MxxbOc0/Xaasmgd4xLfA1/9M9 IZQcA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The error handling has a kinda weird nested-if setup that is not really
adding anything. Switch it to more of an early return arrangement as a
predatory step for adding different handing for timeouts and failed
services.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/soc/microchip/mpfs-sys-controller.c | 27 ++++++++++-----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/microchip/mpfs-sys-controller.c
index 738ecd624d64..e61ba9b7aae3 100644
--- a/drivers/soc/microchip/mpfs-sys-controller.c
+++ b/drivers/soc/microchip/mpfs-sys-controller.c
@@ -32,28 +32,27 @@ struct mpfs_sys_controller {
 int mpfs_blocking_transaction(struct mpfs_sys_controller *sys_controller, struct mpfs_mss_msg *msg)
 {
 	unsigned long timeout = msecs_to_jiffies(MPFS_SYS_CTRL_TIMEOUT_MS);
-	int ret, err;
+	int ret;
 
-	err = mutex_lock_interruptible(&transaction_lock);
-	if (err)
-		return err;
+	ret = mutex_lock_interruptible(&transaction_lock);
+	if (ret)
+		return ret;
 
 	reinit_completion(&sys_controller->c);
 
 	ret = mbox_send_message(sys_controller->chan, msg);
-	if (ret >= 0) {
-		if (wait_for_completion_timeout(&sys_controller->c, timeout)) {
-			ret = 0;
-		} else {
-			ret = -ETIMEDOUT;
-			dev_warn(sys_controller->client.dev,
-				 "MPFS sys controller transaction timeout\n");
-		}
+	if (ret < 0)
+		goto out;
+
+	if (!wait_for_completion_timeout(&sys_controller->c, timeout)) {
+		ret = -ETIMEDOUT;
+		dev_warn(sys_controller->client.dev, "MPFS sys controller transaction timeout\n");
 	} else {
-		dev_err(sys_controller->client.dev,
-			"mpfs sys controller transaction returned %d\n", ret);
+		/* mbox_send_message() returns positive integers on success */
+		ret = 0;
 	}
 
+out:
 	mutex_unlock(&transaction_lock);
 
 	return ret;
-- 
2.39.2

