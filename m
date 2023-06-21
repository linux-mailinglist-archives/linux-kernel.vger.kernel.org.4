Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBB7737B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjFUGQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjFUGP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:15:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4291735
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687328155; x=1718864155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=blgGkk6NJsHNnTTut4LN7PpjYxihY3+YGEr7VV47fcU=;
  b=EekFo0IkM8lMrokVJxMFzL7kU/KG9g73Pi2Ae7XuzHcfWtRuiwoXIxJM
   zHKFLp/d4AlzDwzUdKeAEe+Yl0Xz7tyNpwfXw+36qz4iSe3TiYLqXKDBy
   O0JbPY3WfaLE4Yw8vIP6Hid/JpjolK1+dCXbaXWSfrm+MTHjNQok3eKpE
   LlZH14DYFjfYItD/IqPKxboNqPgbChnwQXYG/O7648dYlcLHo7XNpvWHG
   N2d+MFIWWTJ6CR2lgSb7OhOhvUvKJxcKrQuZWe7WKeUyXa773S8gb7Iip
   Q3UqxtlRmEkRmS1/8fAaP2OK10BYF8O3SRzOJ+NE8wQYEmJ32X4npEfkU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="349814426"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="349814426"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 23:15:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="714327529"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="714327529"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga002.jf.intel.com with ESMTP; 20 Jun 2023 23:15:53 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 1/3] firmware: stratix10-svc: extend svc for attestation
Date:   Wed, 21 Jun 2023 14:15:06 +0800
Message-Id: <20230621061508.1429913-2-tien.sung.ang@intel.com>
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

Extend Intel service layer driver to support FPGA attestation features on
Intel FPGA SoC platforms, which makes sure the trustworthiness of FPGA
images currently running on a FPGA device.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---
 drivers/firmware/stratix10-svc.c              | 40 ++++++++-
 include/linux/firmware/intel/stratix10-smc.h  | 85 ++++++++++++++++++-
 .../firmware/intel/stratix10-svc-client.h     | 18 ++++
 3 files changed, 140 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 80f4e2d14e04..a277fe9c4db4 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -328,6 +328,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_FCS_SEND_CERTIFICATE:
 	case COMMAND_FCS_DATA_ENCRYPTION:
 	case COMMAND_FCS_DATA_DECRYPTION:
+	case COMMAND_FCS_PSGSIGMA_TEARDOWN:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		break;
 	case COMMAND_RECONFIG_DATA_SUBMIT:
@@ -361,6 +362,17 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 		cb_data->kaddr2 = svc_pa_to_va(res.a2);
 		cb_data->kaddr3 = &res.a3;
 		break;
+	case COMMAND_FCS_GET_CHIP_ID:
+		cb_data->status = BIT(SVC_STATUS_OK);
+		cb_data->kaddr2 = &res.a2;
+		cb_data->kaddr3 = &res.a3;
+		break;
+	case COMMAND_FCS_ATTESTATION_SUBKEY:
+	case COMMAND_FCS_ATTESTATION_MEASUREMENTS:
+		cb_data->status = BIT(SVC_STATUS_OK);
+		cb_data->kaddr2 = svc_pa_to_va(res.a2);
+		cb_data->kaddr3 = &res.a3;
+		break;
 	default:
 		pr_warn("it shouldn't happen\n");
 		break;
@@ -514,10 +526,30 @@ static int svc_normal_to_secure_thread(void *data)
 			break;
 		case COMMAND_FCS_GET_PROVISION_DATA:
 			a0 = INTEL_SIP_SMC_FCS_GET_PROVISION_DATA;
-			a1 = (unsigned long)pdata->paddr;
+		case COMMAND_FCS_PSGSIGMA_TEARDOWN:
+			a0 = INTEL_SIP_SMC_FCS_PSGSIGMA_TEARDOWN;
+			a1 = pdata->arg[0];
 			a2 = 0;
 			break;
-
+		case COMMAND_FCS_GET_CHIP_ID:
+			a0 = INTEL_SIP_SMC_FCS_CHIP_ID;
+			a1 = 0;
+			a2 = 0;
+			break;
+		case COMMAND_FCS_ATTESTATION_SUBKEY:
+			a0 = INTEL_SIP_SMC_FCS_ATTESTATION_SUBKEY;
+			a1 = (unsigned long)pdata->paddr;
+			a2 = (unsigned long)pdata->size;
+			a3 = (unsigned long)pdata->paddr_output;
+			a4 = (unsigned long)pdata->size_output;
+			break;
+		case COMMAND_FCS_ATTESTATION_MEASUREMENTS:
+			a0 = INTEL_SIP_SMC_FCS_ATTESTATION_MEASUREMENTS;
+			a1 = (unsigned long)pdata->paddr;
+			a2 = (unsigned long)pdata->size;
+			a3 = (unsigned long)pdata->paddr_output;
+			a4 = (unsigned long)pdata->size_output;
+			break;
 		/* for polling */
 		case COMMAND_POLL_SERVICE_STATUS:
 			a0 = INTEL_SIP_SMC_SERVICE_COMPLETED;
@@ -597,6 +629,10 @@ static int svc_normal_to_secure_thread(void *data)
 			case COMMAND_FCS_DATA_ENCRYPTION:
 			case COMMAND_FCS_DATA_DECRYPTION:
 			case COMMAND_FCS_RANDOM_NUMBER_GEN:
+			case COMMAND_FCS_PSGSIGMA_TEARDOWN:
+			case COMMAND_FCS_GET_CHIP_ID:
+			case COMMAND_FCS_ATTESTATION_SUBKEY:
+			case COMMAND_FCS_ATTESTATION_MEASUREMENTS:
 				cbdata->status = BIT(SVC_STATUS_INVALID_PARAM);
 				cbdata->kaddr1 = NULL;
 				cbdata->kaddr2 = NULL;
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index a718f853d457..d9f0251256e9 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -464,7 +464,7 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
  */
 #define INTEL_SIP_SMC_FUNCID_FIRMWARE_VERSION 31
 #define INTEL_SIP_SMC_FIRMWARE_VERSION \
-        INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FIRMWARE_VERSION)
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FIRMWARE_VERSION)
 
 /**
  * Request INTEL_SIP_SMC_SVC_VERSION
@@ -595,4 +595,87 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FCS_GET_PROVISION_DATA \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_PROVISION_DATA)
 
+/**
+ * Request INTEL_SIP_SMC_FCS_PSGSIGMA_TEARDOWN
+ * Sync call to tear down all previous black key provision sessions and to
+ * delete keys assicated with those sessions
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_PSGSIGMA_TEARDOWN
+ * a1 the session ID
+ * a2-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_ERROR or
+ *    INTEL_SIP_SMC_STATUS_REJECTED
+ * a1 mailbox error if a0 is INTEL_SIP_SMC_STATUS_ERROR,
+ *    not used if a0 is INTEL_SIP_SMC_STATUS_OK or
+ *    INTEL_SIP_SMC_STATUS_REJECTED
+ * a2-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_PSGSIGMA_TEARDOWN 100
+#define INTEL_SIP_SMC_FCS_PSGSIGMA_TEARDOWN \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_PSGSIGMA_TEARDOWN)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_CHIP_ID
+ * Sync call to get the device ID
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_CHIP_ID
+ * a1-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_ERROR or
+ *    INTEL_SIP_SMC_STATUS_REJECTED
+ * a1 mailbox error if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ * a2 retrieved chipID value low 32 bits
+ * a3 retrieved chipID value high 32 bits
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_CHIP_ID 101
+#define INTEL_SIP_SMC_FCS_CHIP_ID \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_CHIP_ID)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_ATTESTATION_SUBKEY
+ * Sync call to the device attestation subkey
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_ATTESTATION_SUBKEY
+ * a1 physical address of subkey command data
+ * a2 subkey command data size
+ * a3 physical address of to be filled subkey response data
+ * a4 subkey response data size
+ * a5-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, or INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox error if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ * a2 physical address of the filled subkey response data
+ * a3 size of the filled subkey response dat
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_ATTESTATION_SUBKEY 102
+#define INTEL_SIP_SMC_FCS_ATTESTATION_SUBKEY \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_ATTESTATION_SUBKEY)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_ATTESTATION_MEASUREMENTS
+ * Async call to get device attestation measurements
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_ATTESTATION_MEASUREMENTS
+ * a1 physical address of measurement command data
+ * a2 measurement command data size
+ * a3 physical address of to be filled measurement response data
+ * a4 measurement response data size
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, or INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox error if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ * a2 physical address of the filled subkey measurement data
+ * a3 size of the filled subkey measurement data
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_ATTESTATION_MEASUREMENTS 103
+#define INTEL_SIP_SMC_FCS_ATTESTATION_MEASUREMENTS \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_ATTESTATION_MEASUREMENTS)
 #endif
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 0c16037fd08d..5346967dd2fe 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -138,6 +138,19 @@ struct stratix10_svc_chan;
  *
  * @COMMAND_FCS_RANDOM_NUMBER_GEN: generate a random number, return status
  * is SVC_STATUS_OK, SVC_STATUS_ERROR
+ *
+ * @COMMAND_FCS_PSGSIGMA_TEARDOWN: tear down all previous black key
+ * provision sessions and delete keys assicated with those sessions,
+ * return status is SVC_STATUS_SUBMITTED or SVC_STATUS_ERROR
+ *
+ * @COMMAND_FCS_GET_CHIP_ID: get the device's chip ID, return status is
+ * SVC_STATUS_SUBMITTED or SVC_STATUS_ERROR
+ *
+ * @COMMAND_FCS_ATTESTATION_SUBKEY: get device's attestation subkey,
+ * return status is SVC_STATUS_SUBMITTED or SVC_STATUS_ERROR
+ *
+ * @COMMAND_FCS_ATTESTATION_MEASUREMENTS: to get device's attestation
+ * measurements, return status is SVC_STATUS_SUBMITTED or SVC_STATUS_ERROR
  */
 enum stratix10_svc_command_code {
 	/* for FPGA */
@@ -162,6 +175,11 @@ enum stratix10_svc_command_code {
 	COMMAND_FCS_DATA_ENCRYPTION,
 	COMMAND_FCS_DATA_DECRYPTION,
 	COMMAND_FCS_RANDOM_NUMBER_GEN,
+	/* for Attestation */
+	COMMAND_FCS_PSGSIGMA_TEARDOWN = 30,
+	COMMAND_FCS_GET_CHIP_ID,
+	COMMAND_FCS_ATTESTATION_SUBKEY,
+	COMMAND_FCS_ATTESTATION_MEASUREMENTS,
 	/* for general status poll */
 	COMMAND_POLL_SERVICE_STATUS = 40,
 	/* Non-mailbox SMC Call */
-- 
2.25.1

