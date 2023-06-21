Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78B7737B42
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjFUGQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjFUGQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:16:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F29219AE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687328166; x=1718864166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xTemgDyUVU74ty8gHYSw+QMVcpkS1VCopLSY1kfavFs=;
  b=WGU+c55MHGbbwF4GsGtk6sBI8l57dw4Nrxtvmgp/A/wBDOO35848cRgr
   f1rDceF63/u1zkhVLe1en2jUs0QzK+MJgnQ9gR0i389nYm7JmhY0VgtFO
   TbwwmOkE8pio8eduJKO7qC3Xydnbsv2y6hgeSbd3tnacTRBmv1WPqPrcS
   EjlHwP8IVu4EbGwX8QJ2IGIL0TEDxfehm+4jIi4SX77jTmSajGY+rA18s
   0iv1regUUXluxbqt1QsfV9fQs3Y6mnmP7euWFshzT6eATCwDGbL5VQE4k
   99nF203lLQ5rWki53PsXFIKdo501EKhgkBoTksKgy1K28hJUvw6wraEqL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="349814474"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="349814474"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 23:16:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="714327603"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="714327603"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga002.jf.intel.com with ESMTP; 20 Jun 2023 23:16:04 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 3/3] firmware: stratix10-svc: extend to support new FPGA attestation
Date:   Wed, 21 Jun 2023 14:15:08 +0800
Message-Id: <20230621061508.1429913-4-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230621061508.1429913-1-tien.sung.ang@intel.com>
References: <20230621061508.1429913-1-tien.sung.ang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ang Tien Sung <tien.sung.ang@intel.com>

Support the new FPGA attestation get_certificate and
certificate_reload features.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---
 drivers/firmware/stratix10-svc.c              | 15 +++++++
 include/linux/firmware/intel/stratix10-smc.h  | 45 +++++++++++++++++++
 .../firmware/intel/stratix10-svc-client.h     |  9 ++++
 3 files changed, 69 insertions(+)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index be0a39900570..403a660f1df7 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -330,6 +330,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_FCS_DATA_DECRYPTION:
 	case COMMAND_FCS_PSGSIGMA_TEARDOWN:
 	case COMMAND_FCS_COUNTER_SET_PREAUTHORIZED:
+	case COMMAND_FCS_ATTESTATION_CERTIFICATE_RELOAD:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		break;
 	case COMMAND_RECONFIG_DATA_SUBMIT:
@@ -370,6 +371,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 		break;
 	case COMMAND_FCS_ATTESTATION_SUBKEY:
 	case COMMAND_FCS_ATTESTATION_MEASUREMENTS:
+	case COMMAND_FCS_ATTESTATION_CERTIFICATE:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		cb_data->kaddr2 = svc_pa_to_va(res.a2);
 		cb_data->kaddr3 = &res.a3;
@@ -560,6 +562,17 @@ static int svc_normal_to_secure_thread(void *data)
 			a3 = (unsigned long)pdata->paddr_output;
 			a4 = (unsigned long)pdata->size_output;
 			break;
+		case COMMAND_FCS_ATTESTATION_CERTIFICATE:
+			a0 = INTEL_SIP_SMC_FCS_GET_ATTESTATION_CERTIFICATE;
+			a1 = pdata->arg[0];
+			a2 = (unsigned long)pdata->paddr_output;
+			a3 = (unsigned long)pdata->size_output;
+			break;
+		case COMMAND_FCS_ATTESTATION_CERTIFICATE_RELOAD:
+			a0 = INTEL_SIP_SMC_FCS_CREATE_CERTIFICATE_ON_RELOAD;
+			a1 = pdata->arg[0];
+			a2 = 0;
+			break;
 		/* for polling */
 		case COMMAND_POLL_SERVICE_STATUS:
 			a0 = INTEL_SIP_SMC_SERVICE_COMPLETED;
@@ -644,6 +657,8 @@ static int svc_normal_to_secure_thread(void *data)
 			case COMMAND_FCS_ATTESTATION_SUBKEY:
 			case COMMAND_FCS_ATTESTATION_MEASUREMENTS:
 			case COMMAND_FCS_COUNTER_SET_PREAUTHORIZED:
+			case COMMAND_FCS_ATTESTATION_CERTIFICATE:
+			case COMMAND_FCS_ATTESTATION_CERTIFICATE_RELOAD:
 				cbdata->status = BIT(SVC_STATUS_INVALID_PARAM);
 				cbdata->kaddr1 = NULL;
 				cbdata->kaddr2 = NULL;
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index 8f92a55ba51d..ddfffda6ba0e 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -67,6 +67,9 @@
  *
  * INTEL_SIP_SMC_RSU_ERROR:
  * There is error during the process of remote status update request.
+ *
+ * INTEL_SIP_SMC_STATUS_NOT_SUPPORTED:
+ * Secure monitor software doesn't support the request
  */
 #define INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION		0xFFFFFFFF
 #define INTEL_SIP_SMC_STATUS_OK				0x0
@@ -74,6 +77,7 @@
 #define INTEL_SIP_SMC_STATUS_REJECTED			0x2
 #define INTEL_SIP_SMC_STATUS_ERROR			0x4
 #define INTEL_SIP_SMC_RSU_ERROR				0x7
+#define INTEL_SIP_SMC_STATUS_NOT_SUPPORTED		0x8
 
 /**
  * Request INTEL_SIP_SMC_FPGA_CONFIG_START
@@ -696,4 +700,45 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FUNCID_FCS_ATTESTATION_MEASUREMENTS 103
 #define INTEL_SIP_SMC_FCS_ATTESTATION_MEASUREMENTS \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_ATTESTATION_MEASUREMENTS)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_GET_ATTESTATION_CERTIFICATE
+ * Sync call to get device attestation certificate
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_GET_ATTESTATION_CERTIFICATE
+ * a1 the type of certificate request
+ * a2 the physical address which holds certificate response data
+ * a3 the size of the certificate response data
+ * a4-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox error if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ * a2 physical address of the requested certificate
+ * a3 sized of the requested certificate
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_GET_ATTESTATION_CERTIFICATE 104
+#define INTEL_SIP_SMC_FCS_GET_ATTESTATION_CERTIFICATE \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_ATTESTATION_CERTIFICATE)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_CREATE_CERTIFICATE_ON_RELOAD
+ * Sync call to specify what certificate is to be generated
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_CREATE_CERTIFICATE_ON_RELOAD
+ * a1 the type of certificat request
+ * a2-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox error if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ * a2-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_CREATE_CERTIFICATE_ON_RELOAD 105
+#define INTEL_SIP_SMC_FCS_CREATE_CERTIFICATE_ON_RELOAD \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_CREATE_CERTIFICATE_ON_RELOAD)
 #endif
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 4703f6c486a1..f3b0a69114fd 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -155,6 +155,13 @@ struct stratix10_svc_chan;
  *
  * @COMMAND_FCS_ATTESTATION_MEASUREMENTS: to get device's attestation
  * measurements, return status is SVC_STATUS_SUBMITTED or SVC_STATUS_ERROR
+ *
+ * @COMMAND_FCS_ATTESTATION_CERTIFICATE: get FPGA attestation certificate,
+ * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
+ * @COMMAND_FCS_ATTESTATION_CERTIFICATE_RELOAD: reload FPGA attestation
+ * certificate, return status is SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
  */
 enum stratix10_svc_command_code {
 	/* for FPGA */
@@ -185,6 +192,8 @@ enum stratix10_svc_command_code {
 	COMMAND_FCS_GET_CHIP_ID,
 	COMMAND_FCS_ATTESTATION_SUBKEY,
 	COMMAND_FCS_ATTESTATION_MEASUREMENTS,
+	COMMAND_FCS_ATTESTATION_CERTIFICATE,
+	COMMAND_FCS_ATTESTATION_CERTIFICATE_RELOAD,
 	/* for general status poll */
 	COMMAND_POLL_SERVICE_STATUS = 40,
 	/* Non-mailbox SMC Call */
-- 
2.25.1

