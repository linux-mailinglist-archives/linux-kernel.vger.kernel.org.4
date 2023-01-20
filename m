Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C99675784
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjATOkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjATOkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:40:17 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634586E0E7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 06:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674225590; x=1705761590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vswoNz7W4YNtXxpN9gjNGU8G3StYy1AGUcDydMeUCxM=;
  b=bK31pkgEuuSPXb3/EEDRxHgHic9PnYXuJ/KB24lAfvxeaE8OVVlyL0XC
   q1ek2DhVIpyJJ8Zv4WyFe1D02qYmSXnLgOFki52oj2dXIY626gRf9ddmK
   il1Dg1k/Q7Q6u6451SKfl1sEDbJPqfmdHwVtBUrEzWV43vWb8mcYVKbLE
   Ip9w7HOMZLhKDE6Tqvcktc7Iq3cO5LhJ+8AWpZ+gqyopT1JVyDbUUkEMi
   NsXh1LRclUl8NkZO9jAKL5RI1yrepSFzOuPQwmAorterThbfzVSaTRfHo
   oen41dCExY6fEuufDHN9Qo26U7HbTDN5CxOPhxUE2dcx1iBT9wLDgDbIu
   A==;
X-IronPort-AV: E=Sophos;i="5.97,232,1669100400"; 
   d="scan'208";a="196713315"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2023 07:38:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 07:38:17 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Fri, 20 Jan 2023 07:38:16 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/7] soc: microchip: mpfs: use a consistent completion timeout
Date:   Fri, 20 Jan 2023 14:37:33 +0000
Message-ID: <20230120143734.3438755-6-conor.dooley@microchip.com>
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

Completion timeouts use jiffies, so passing a number directly will
produce inconsistent timeouts depending on config. Define the timeout in
ms and convert it to jiffies instead.

Since a define is being created where one previously did not exist,
pick a suitable timeout duration. Most services will complete nearly
immediately, but those relating to image verification and re-programming
the FPGA take significant amounts of time. 30 seconds is a suitable
timeout for those situations, although most services will complete in
under 100 ms.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/soc/microchip/mpfs-sys-controller.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/microchip/mpfs-sys-controller.c
index 12039cb38b33..e76a5e38f655 100644
--- a/drivers/soc/microchip/mpfs-sys-controller.c
+++ b/drivers/soc/microchip/mpfs-sys-controller.c
@@ -11,12 +11,19 @@
 #include <linux/slab.h>
 #include <linux/kref.h>
 #include <linux/module.h>
+#include <linux/jiffies.h>
 #include <linux/interrupt.h>
 #include <linux/of_platform.h>
 #include <linux/mailbox_client.h>
 #include <linux/platform_device.h>
 #include <soc/microchip/mpfs.h>
 
+/*
+ * This timeout must be long, as some services (example: image authentication)
+ * take many seconds to complete
+ */
+#define MPFS_SYS_CTRL_TIMEOUT_MS 30000
+
 static DEFINE_MUTEX(transaction_lock);
 
 struct mpfs_sys_controller {
@@ -28,6 +35,7 @@ struct mpfs_sys_controller {
 
 int mpfs_blocking_transaction(struct mpfs_sys_controller *sys_controller, struct mpfs_mss_msg *msg)
 {
+	unsigned long timeout = msecs_to_jiffies(MPFS_SYS_CTRL_TIMEOUT_MS);
 	int ret, err;
 
 	err = mutex_lock_interruptible(&transaction_lock);
@@ -38,7 +46,7 @@ int mpfs_blocking_transaction(struct mpfs_sys_controller *sys_controller, struct
 
 	ret = mbox_send_message(sys_controller->chan, msg);
 	if (ret >= 0) {
-		if (wait_for_completion_timeout(&sys_controller->c, HZ)) {
+		if (wait_for_completion_timeout(&sys_controller->c, timeout)) {
 			ret = 0;
 		} else {
 			ret = -ETIMEDOUT;
-- 
2.39.0

