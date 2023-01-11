Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E99E665CDE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbjAKNq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjAKNqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:46:21 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40496265
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673444755; x=1704980755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YmvtEgsExmKnHFKrtsTC1qEk3keDAXMIHIB9CsFESV4=;
  b=DiijypHa7U81PoTg+Wr23aa0/TGNT2bfODEbzF0bDge4omZlrRrTOmVm
   ZH4JCUL0anpHrYJIQjUrax03exEDa5MnT0j4FlA+sdyOcP021DU4CvbCT
   Vy07/lztFIs1mcdHi4msnIdITR+aunpJI7fE9gn3y+mkr9L/sXoDVE+Wo
   PlxWOnKFjLj/MkyG+9XdR2E1A4AJdARitsj9jQah2lUVvr4ZjhvphwMGB
   ObMEj3IXuFKw5SB7aY9UI4a8PKxxK3rygpk4fIvmn7kNcfACE/G9OjOl7
   idpLvc6c+mLSUuk9T5uoqCiKkI2FW2e/3h2Xgi09O0wRRsTF9QmSFK1hw
   A==;
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="207325803"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jan 2023 06:45:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 06:45:55 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Wed, 11 Jan 2023 06:45:54 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 5/7] soc: microchip: mpfs: use a consistent completion timeout
Date:   Wed, 11 Jan 2023 13:45:11 +0000
Message-ID: <20230111134513.2495510-6-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111134513.2495510-1-conor.dooley@microchip.com>
References: <20230111134513.2495510-1-conor.dooley@microchip.com>
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
2.39.0

