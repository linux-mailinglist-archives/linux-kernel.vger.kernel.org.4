Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496A361890C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 20:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiKCTyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 15:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiKCTxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:53:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1DA6B7C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 12:53:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C869023A;
        Thu,  3 Nov 2022 12:53:27 -0700 (PDT)
Received: from e120937-lin.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C40B3F534;
        Thu,  3 Nov 2022 12:53:19 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        cristian.marussi@arm.com
Subject: [PATCH v5 14/14] firmware: arm_scmi: Add Raw mode coexistence support
Date:   Thu,  3 Nov 2022 19:52:25 +0000
Message-Id: <20221103195225.1028864-15-cristian.marussi@arm.com>
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

When Raw support is enabled and configured in coexistence mode the normal
SCMI drivers are allowed to register with the SCMI core and operate as
usual alongside the Raw operations.

SCMI Normal and Raw messages will be kept segregated from each other, but
only at the transaction level: any further possible interference at the
protocol layer will have instead to be handled by the user to attain
reliable results while using Raw transactions.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/Kconfig    | 10 ++++++++++
 drivers/firmware/arm_scmi/driver.c   | 12 +++++++++---
 drivers/firmware/arm_scmi/raw_mode.c |  5 ++++-
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index ab726a92ac2f..743f53fbe2f8 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -36,6 +36,16 @@ config ARM_SCMI_RAW_MODE_SUPPORT
 	  order to avoid unexpected interactions with the SCMI Raw message
 	  flow. If unsure say N.
 
+config ARM_SCMI_RAW_MODE_SUPPORT_COEX
+	bool "Allow SCMI Raw mode coexistence with normal SCMI stack"
+	depends on ARM_SCMI_RAW_MODE_SUPPORT
+	help
+	  Allow SCMI Raw transmission mode to coexist with normal SCMI stack.
+
+	  This will allow regular SCMI drivers to register with the core and
+	  operate normally, thing which could make an SCMI test suite using the
+	  SCMI Raw mode support unreliable. If unsure, say N.
+
 config ARM_SCMI_HAVE_TRANSPORT
 	bool
 	help
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 9f8e5d42c7aa..9a5bd8526738 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2415,7 +2415,8 @@ int scmi_protocol_device_request(const struct scmi_device_id *id_table)
 	pr_debug("Requesting SCMI device (%s) for protocol %x\n",
 		 id_table->name, id_table->protocol_id);
 
-	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
+	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) &&
+	    !IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT_COEX)) {
 		pr_warn("SCMI Raw mode active. Rejecting '%s'/0x%02X\n",
 			id_table->name, id_table->protocol_id);
 		return -EINVAL;
@@ -2644,15 +2645,20 @@ static int scmi_probe(struct platform_device *pdev)
 		goto clear_txrx_setup;
 
 	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
+		int ret = 0;
+
 		info->raw = scmi_raw_mode_init(handle, scmi_raw_top_dentry,
 					       info->desc,
 					       info->tx_minfo.max_msg);
 		if (IS_ERR(info->raw)) {
 			dev_err(dev, "Failed to initialize SCMI RAW Mode !\n");
-			return PTR_ERR(info->raw);
+			ret = PTR_ERR(info->raw);
 		}
 
-		return 0;
+		if (!IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT_COEX))
+			return ret;
+
+		dev_info(dev, "SCMI RAW Mode COEX enabled !\n");
 	}
 
 	if (scmi_notification_init(handle))
diff --git a/drivers/firmware/arm_scmi/raw_mode.c b/drivers/firmware/arm_scmi/raw_mode.c
index deb345c740c5..edab6158f81e 100644
--- a/drivers/firmware/arm_scmi/raw_mode.c
+++ b/drivers/firmware/arm_scmi/raw_mode.c
@@ -26,7 +26,10 @@
  * In order to avoid possible interferences between the SCMI Raw transactions
  * originated from a test-suite and the normal operations of the SCMI drivers,
  * when Raw mode is enabled, by default, all the regular SCMI drivers are
- * inhibited.
+ * inhibited, unless CONFIG_ARM_SCMI_RAW_MODE_SUPPORT_COEX is enabled: in this
+ * latter case the regular SCMI stack drivers will be loaded as usual and it is
+ * up to the user of this interface to take care of manually inhibiting the
+ * regular SCMI drivers in order to avoid interferences during the test runs.
  *
  * The exposed API is as follows.
  * All defined SCMI instances are rooted under a common top scmi_raw debugfs
-- 
2.34.1

