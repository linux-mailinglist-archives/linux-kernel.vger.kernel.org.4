Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A6F6FBA0C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbjEHVkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjEHVkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:40:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5C37ED8;
        Mon,  8 May 2023 14:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683581985; x=1715117985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c0yLqjAEo06WoNbwU3eOWjPeohGtA8deoJ8duhdEEos=;
  b=C5OtaWG/3yTsLwa8BzPBWaEf6F+q+MXjigwbmzYqerBvXN8aRDGJjcDu
   H9HyiFNYttm2plzutroYD7mfCR3XxodTR/ayrUTaWpXyObwJvkvj1nlXS
   VAy3Grrgh6l/raW4LDB7tQSHqX037UScxyvKVF2VNqrzuvtlsrz4XuKMA
   YBV4kgONfOZiFkQSXhG8oFL0lONTtGrQKdo3SrBrk6lCOGo2jsdqoxzS/
   /GmueKfM1i3g+fbpwFHd6Uu1eFoQEUoCri68Fc6tSVPAgnLUCc2AtFX4C
   tWA0XIAHUGlTBs/sIKAmTQCqcRaD9JunJ+SwhlMZxdinfaoOCzJmjFvnq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="349796681"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="349796681"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 14:38:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="945018713"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="945018713"
Received: from linux-builds1.an.intel.com ([10.122.105.32])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 14:38:56 -0700
From:   dinh.nguyen@linux.intel.com
To:     linux-hwmon@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, Dinh Nguyen <dinh.nguyen@linux.intel.com>
Subject: [PATCHv2 2/6] firmware: stratix10-svc: add method for reading voltage and temperature
Date:   Mon,  8 May 2023 16:28:48 -0500
Message-Id: <20230508212852.8413-2-dinh.nguyen@linux.intel.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230508212852.8413-1-dinh.nguyen@linux.intel.com>
References: <20230508212852.8413-1-dinh.nguyen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinh Nguyen <dinh.nguyen@linux.intel.com>

Add support for the hardware monitor driver to use the service driver
the ability to read voltage and temperature from the SDM.

Signed-off-by: Dinh Nguyen <dinh.nguyen@linux.intel.com>
---
 drivers/firmware/stratix10-svc.c              | 18 +++++++++-
 include/linux/firmware/intel/stratix10-smc.h  | 34 +++++++++++++++++++
 .../firmware/intel/stratix10-svc-client.h     |  6 ++++
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index bde1f543f529..cc1b8b441c37 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -340,6 +340,8 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_RSU_MAX_RETRY:
 	case COMMAND_RSU_DCMF_STATUS:
 	case COMMAND_FIRMWARE_VERSION:
+	case COMMAND_HWMON_READTEMP:
+	case COMMAND_HWMON_READVOLT:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		cb_data->kaddr1 = &res.a1;
 		break;
@@ -517,7 +519,17 @@ static int svc_normal_to_secure_thread(void *data)
 			a1 = (unsigned long)pdata->paddr;
 			a2 = 0;
 			break;
-
+		/* for HWMON */
+		case COMMAND_HWMON_READTEMP:
+			a0 = INTEL_SIP_SMC_HWMON_READTEMP;
+			a1 = pdata->arg[0];
+			a2 = 0;
+			break;
+		case COMMAND_HWMON_READVOLT:
+			a0 = INTEL_SIP_SMC_HWMON_READVOLT;
+			a1 = pdata->arg[0];
+			a2 = 0;
+			break;
 		/* for polling */
 		case COMMAND_POLL_SERVICE_STATUS:
 			a0 = INTEL_SIP_SMC_SERVICE_COMPLETED;
@@ -1182,6 +1194,10 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	chans[2].name = SVC_CLIENT_FCS;
 	spin_lock_init(&chans[2].lock);
 
+	chans[3].ctrl = controller;
+	chans[3].name = SVC_CLIENT_HWMON;
+	spin_lock_init(&chans[3].lock);
+
 	list_add_tail(&controller->node, &svc_ctrl);
 	platform_set_drvdata(pdev, controller);
 
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index a718f853d457..b944ec4b2b2f 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -595,4 +595,38 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FCS_GET_PROVISION_DATA \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_PROVISION_DATA)
 
+/**
+ * Request INTEL_SIP_SMC_HWMON_READTEMP
+ * Sync call to request temperature
+ *
+ * Call register usage:
+ * a0 Temperature Channel
+ * a1-a7 not used
+ *
+ * Return status
+ * a0 INTEL_SIP_SMC_STATUS_OK
+ * a1 Temperature Value
+ * a2-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_HWMON_READTEMP 32
+#define INTEL_SIP_SMC_HWMON_READTEMP \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_HWMON_READTEMP)
+
+/**
+ * Request INTEL_SIP_SMC_HWMON_READVOLT
+ * Sync call to request voltage
+ *
+ * Call register usage:
+ * a0 Voltage Channel
+ * a1-a7 not used
+ *
+ * Return status
+ * a0 INTEL_SIP_SMC_STATUS_OK
+ * a1 Voltage Value
+ * a2-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_HWMON_READVOLT 33
+#define INTEL_SIP_SMC_HWMON_READVOLT \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_HWMON_READVOLT)
+
 #endif
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 0c16037fd08d..343970dcc2d2 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -11,10 +11,12 @@
  *
  * fpga: for FPGA configuration
  * rsu: for remote status update
+ * hwmon: for hardware monitoring (voltage and temperature)
  */
 #define SVC_CLIENT_FPGA			"fpga"
 #define SVC_CLIENT_RSU			"rsu"
 #define SVC_CLIENT_FCS			"fcs"
+#define SVC_CLIENT_HWMON		"hwmon"
 
 /*
  * Status of the sent command, in bit number
@@ -70,6 +72,7 @@
 #define SVC_RSU_REQUEST_TIMEOUT_MS              300
 #define SVC_FCS_REQUEST_TIMEOUT_MS		2000
 #define SVC_COMPLETED_TIMEOUT_MS		30000
+#define SVC_HWMON_REQUEST_TIMEOUT_MS		300
 
 struct stratix10_svc_chan;
 
@@ -164,6 +167,9 @@ enum stratix10_svc_command_code {
 	COMMAND_FCS_RANDOM_NUMBER_GEN,
 	/* for general status poll */
 	COMMAND_POLL_SERVICE_STATUS = 40,
+	/* for HWMON */
+	COMMAND_HWMON_READTEMP,
+	COMMAND_HWMON_READVOLT,
 	/* Non-mailbox SMC Call */
 	COMMAND_SMC_SVC_VERSION = 200,
 };
-- 
2.40.0

