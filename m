Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB46E654628
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 19:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiLVSvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 13:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiLVSv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:51:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98F8723EB9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:51:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FBFC1FB;
        Thu, 22 Dec 2022 10:52:00 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3859C3FA32;
        Thu, 22 Dec 2022 10:51:18 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, Ludvig.Parsson@axis.com,
        cristian.marussi@arm.com
Subject: [PATCH 9/9] firmware: arm_scmi: Split bus and driver into distinct modules
Date:   Thu, 22 Dec 2022 18:50:49 +0000
Message-Id: <20221222185049.737625-10-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221222185049.737625-1-cristian.marussi@arm.com>
References: <20221222185049.737625-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the SCMI bus on its own as a distinct module initialized at
subsys_initcall level when builtin.

Keep the SCMI driver core stack, together with any configured transport,
in a different module initialized as module_init level.

SCMI Drivers initialization remain unchanged at module_init level.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/Makefile |  8 ++++++--
 drivers/firmware/arm_scmi/bus.c    | 15 ++++++++++++---
 drivers/firmware/arm_scmi/common.h |  2 --
 drivers/firmware/arm_scmi/driver.c |  6 +-----
 4 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 9ea86f8cc8f7..f0596c386c62 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 scmi-bus-y = bus.o
+scmi-core-objs := $(scmi-bus-y)
+
 scmi-driver-y = driver.o notify.o
 scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) += mailbox.o
@@ -8,9 +10,11 @@ scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
-scmi-module-objs := $(scmi-bus-y) $(scmi-driver-y) $(scmi-protocols-y) \
-		    $(scmi-transport-y)
+scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
+
+obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
+
 obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) += scmi_pm_domain.o
 obj-$(CONFIG_ARM_SCMI_POWER_CONTROL) += scmi_power_control.o
 
diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 190999a658b2..6228f1581fe3 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -476,18 +476,21 @@ static void scmi_devices_unregister(void)
 	bus_for_each_dev(&scmi_bus_type, NULL, NULL, __scmi_devices_unregister);
 }
 
-int __init scmi_bus_init(void)
+static int __init scmi_bus_init(void)
 {
 	int retval;
 
 	retval = bus_register(&scmi_bus_type);
 	if (retval)
-		pr_err("scmi protocol bus register failed (%d)\n", retval);
+		pr_err("SCMI protocol bus register failed (%d)\n", retval);
+
+	pr_info("SCMI protocol bus registered\n");
 
 	return retval;
 }
+subsys_initcall(scmi_bus_init);
 
-void __exit scmi_bus_exit(void)
+static void __exit scmi_bus_exit(void)
 {
 	/*
 	 * Destroy all remaining devices: just in case the drivers were
@@ -497,3 +500,9 @@ void __exit scmi_bus_exit(void)
 	bus_unregister(&scmi_bus_type);
 	ida_destroy(&scmi_bus_id);
 }
+module_exit(scmi_bus_exit);
+
+MODULE_ALIAS("scmi-core");
+MODULE_AUTHOR("Sudeep Holla <sudeep.holla@arm.com>");
+MODULE_DESCRIPTION("ARM SCMI protocol bus");
+MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 19726a037991..80f63fc8ca14 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -99,8 +99,6 @@ scmi_revision_area_get(const struct scmi_protocol_handle *ph);
 void scmi_setup_protocol_implemented(const struct scmi_protocol_handle *ph,
 				     u8 *prot_imp);
 
-int __init scmi_bus_init(void);
-void __exit scmi_bus_exit(void);
 extern struct bus_type scmi_bus_type;
 
 #define SCMI_BUS_NOTIFY_DEVICE_REQUEST		0
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 115baaa4aca9..50267eef10fa 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2638,8 +2638,6 @@ static int __init scmi_driver_init(void)
 	if (WARN_ON(!IS_ENABLED(CONFIG_ARM_SCMI_HAVE_TRANSPORT)))
 		return -EINVAL;
 
-	scmi_bus_init();
-
 	/* Initialize any compiled-in transport which provided an init/exit */
 	ret = scmi_transports_init();
 	if (ret)
@@ -2658,7 +2656,7 @@ static int __init scmi_driver_init(void)
 
 	return platform_driver_register(&scmi_driver);
 }
-subsys_initcall(scmi_driver_init);
+module_init(scmi_driver_init);
 
 static void __exit scmi_driver_exit(void)
 {
@@ -2673,8 +2671,6 @@ static void __exit scmi_driver_exit(void)
 	scmi_system_unregister();
 	scmi_powercap_unregister();
 
-	scmi_bus_exit();
-
 	scmi_transports_exit();
 
 	platform_driver_unregister(&scmi_driver);
-- 
2.34.1

