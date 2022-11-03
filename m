Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FB261890F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 20:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiKCTy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 15:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiKCTxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:53:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D2ED20187
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 12:53:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F2B412FC;
        Thu,  3 Nov 2022 12:53:23 -0700 (PDT)
Received: from e120937-lin.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D9663F534;
        Thu,  3 Nov 2022 12:53:14 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        cristian.marussi@arm.com
Subject: [PATCH v5 12/14] firmware: arm_scmi: Create Raw debugfs root dentry
Date:   Thu,  3 Nov 2022 19:52:23 +0000
Message-Id: <20221103195225.1028864-13-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103195225.1028864-1-cristian.marussi@arm.com>
References: <20221103195225.1028864-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create common root debugfs dentry at driver initialization time.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index c5bc67a9c103..bbb43b65cbfd 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -14,8 +14,11 @@
  * Copyright (C) 2018-2021 ARM Ltd.
  */
 
+#define pr_fmt(fmt) "SCMI - " fmt
+
 #include <linux/bitmap.h>
 #include <linux/device.h>
+#include <linux/debugfs.h>
 #include <linux/export.h>
 #include <linux/idr.h>
 #include <linux/io.h>
@@ -154,6 +157,8 @@ struct scmi_info {
 	int users;
 };
 
+static struct dentry *scmi_raw_top_dentry;
+
 #define handle_to_scmi_info(h)	container_of(h, struct scmi_info, handle)
 
 void scmi_notification_instance_data_set(const struct scmi_handle *handle,
@@ -2839,6 +2844,14 @@ static int __init scmi_driver_init(void)
 	if (WARN_ON(!IS_ENABLED(CONFIG_ARM_SCMI_HAVE_TRANSPORT)))
 		return -EINVAL;
 
+	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
+		scmi_raw_top_dentry = debugfs_create_dir("scmi_raw", NULL);
+		if (IS_ERR(scmi_raw_top_dentry)) {
+			pr_err("Could NOT create RAW top dentry.\n");
+			scmi_raw_top_dentry = NULL;
+		}
+	}
+
 	scmi_bus_init();
 
 	/* Initialize any compiled-in transport which provided an init/exit */
@@ -2863,6 +2876,9 @@ subsys_initcall(scmi_driver_init);
 
 static void __exit scmi_driver_exit(void)
 {
+	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT))
+		debugfs_remove_recursive(scmi_raw_top_dentry);
+
 	scmi_base_unregister();
 
 	scmi_clock_unregister();
-- 
2.34.1

