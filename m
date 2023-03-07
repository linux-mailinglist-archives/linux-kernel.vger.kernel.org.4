Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983BE6AF6A4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjCGUYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjCGUXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:23:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554B2521EB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:23:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1C4DB81A1A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 20:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D51C4339C;
        Tue,  7 Mar 2023 20:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678220614;
        bh=9ftp4XSRep9CAFGl5I/cGlZ4Bn7VzUhE3/7xrZNvJco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wd5oeeEbSyUVMox8/3SeOUbDKlFtbRdeXF9mclqCpw3C4RnGRUW3XkI4N2cQdqeMY
         HNTa4jT6BBHAtJSRSvItJ1s8d7UqoDawunE6T9glEmXXSGzkD3HYZqbduxk3M/u37C
         2wkPwVEXGAmIMWF2/c7wbstNCL+ZoMdneRmFxcUFV2oOleV3cYKJM6tfkCCgBu5JWN
         e0vnSP1I6/mzgHXfIiZQNn3dsVPi8Lv0a81dfvHleVpEYgurCq8cKcYvpwd+9rIKll
         vWnqJwVaVsdH0fZ1FmGTV1ZBEniEB2CSWgg+lu2fiwP1mgDh9XpsAi2M4v3knia7p5
         u3gGVujZx1eRw==
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/8] soc: microchip: mpfs: use a consistent completion timeout
Date:   Tue,  7 Mar 2023 20:22:56 +0000
Message-Id: <20230307202257.1762151-7-conor@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307202257.1762151-1-conor@kernel.org>
References: <20230307202257.1762151-1-conor@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1695; i=conor.dooley@microchip.com; h=from:subject; bh=ZbvEWn53vw1ASCu/srw+heRkVpLXaO8RXoKnQ2EVF7c=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCnsc4W7eJJZMt9POxp7cEmjxazMm1nzXhSmnGC8ucvtv dYXc8OQjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzk71+Gv+JJD104p1R3PxHg KNmxu0fdrmunZcLsV8eU4y3+z6vyqmFkuDPx/z6e+7YL3Y/vtTPUlrh/at7B+hKBfsXvEhPkC5s +cQMA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
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

Completion timeouts use jiffies, so passing a number directly will
produce inconsistent timeouts depending on config. Define the timeout in
ms and convert it to jiffies instead.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/soc/microchip/mpfs-sys-controller.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/microchip/mpfs-sys-controller.c
index 12039cb38b33..738ecd624d64 100644
--- a/drivers/soc/microchip/mpfs-sys-controller.c
+++ b/drivers/soc/microchip/mpfs-sys-controller.c
@@ -11,12 +11,15 @@
 #include <linux/slab.h>
 #include <linux/kref.h>
 #include <linux/module.h>
+#include <linux/jiffies.h>
 #include <linux/interrupt.h>
 #include <linux/of_platform.h>
 #include <linux/mailbox_client.h>
 #include <linux/platform_device.h>
 #include <soc/microchip/mpfs.h>
 
+#define MPFS_SYS_CTRL_TIMEOUT_MS 100
+
 static DEFINE_MUTEX(transaction_lock);
 
 struct mpfs_sys_controller {
@@ -28,6 +31,7 @@ struct mpfs_sys_controller {
 
 int mpfs_blocking_transaction(struct mpfs_sys_controller *sys_controller, struct mpfs_mss_msg *msg)
 {
+	unsigned long timeout = msecs_to_jiffies(MPFS_SYS_CTRL_TIMEOUT_MS);
 	int ret, err;
 
 	err = mutex_lock_interruptible(&transaction_lock);
@@ -38,7 +42,7 @@ int mpfs_blocking_transaction(struct mpfs_sys_controller *sys_controller, struct
 
 	ret = mbox_send_message(sys_controller->chan, msg);
 	if (ret >= 0) {
-		if (wait_for_completion_timeout(&sys_controller->c, HZ)) {
+		if (wait_for_completion_timeout(&sys_controller->c, timeout)) {
 			ret = 0;
 		} else {
 			ret = -ETIMEDOUT;
-- 
2.39.2

