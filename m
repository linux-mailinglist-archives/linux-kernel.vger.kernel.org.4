Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A61265905B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbiL2SZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbiL2SY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:24:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F168713F7E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:24:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F28E165C;
        Thu, 29 Dec 2022 10:25:07 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE5A23F71A;
        Thu, 29 Dec 2022 10:24:23 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        cristian.marussi@arm.com
Subject: [PATCH v6 16/17] firmware: arm_scmi: Add Raw mode coexistence support
Date:   Thu, 29 Dec 2022 18:22:52 +0000
Message-Id: <20221229182253.948175-17-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221229182253.948175-1-cristian.marussi@arm.com>
References: <20221229182253.948175-1-cristian.marussi@arm.com>
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
v5 --> v6
- fix error path for RAW Coex on scmi_probe
---
 drivers/firmware/arm_scmi/Kconfig    | 10 ++++++++++
 drivers/firmware/arm_scmi/bus.c      |  3 ++-
 drivers/firmware/arm_scmi/driver.c   | 11 ++++++++++-
 drivers/firmware/arm_scmi/raw_mode.c |  5 ++++-
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index 3b4f9e92b1e3..ea0f5083ac47 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -45,6 +45,16 @@ config ARM_SCMI_RAW_MODE_SUPPORT
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
diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 8601d75f5b9b..68cc4b4290c1 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -59,7 +59,8 @@ static int scmi_protocol_device_request(const struct scmi_device_id *id_table)
 	pr_debug("Requesting SCMI device (%s) for protocol %x\n",
 		 id_table->name, id_table->protocol_id);
 
-	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
+	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) &&
+	    !IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT_COEX)) {
 		pr_warn("SCMI Raw mode active. Rejecting '%s'/0x%02X\n",
 			id_table->name, id_table->protocol_id);
 		return -EINVAL;
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 2a4f6024e090..da60f218aed9 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2708,10 +2708,19 @@ static int scmi_probe(struct platform_device *pdev)
 				dev_err(dev, "Failed to initialize SCMI RAW Mode !\n");
 
 				ret = PTR_ERR(info->raw);
+			}
+
+			if (!IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT_COEX)) {
+				if (!ret)
+					return ret;
+				/*
+				 * Bail out if we failed to init raw mode and
+				 * RAW_MODE_SUPPORT_COEX was not configured.
+				 */
 				goto clear_dev_req_notifier;
 			}
 
-			return 0;
+			dev_info(dev, "SCMI RAW Mode COEX enabled !\n");
 		}
 	}
 
diff --git a/drivers/firmware/arm_scmi/raw_mode.c b/drivers/firmware/arm_scmi/raw_mode.c
index a9a8b250d070..b2dff852e4b4 100644
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
  *
-- 
2.34.1

