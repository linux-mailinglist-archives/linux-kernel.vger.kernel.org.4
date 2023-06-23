Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073DF73AF03
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 05:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjFWDVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 23:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjFWDVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 23:21:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500182133
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 20:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687490491; x=1719026491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7uqHMesjwNSATPgmYGe9fn/6baJBzjRSwP3wJIogJB0=;
  b=VU7DpCi4rST9rd143mdjgCnYDlRLBFrb5gAyhxARck3FioKdmEDy8gML
   0qvwq820C11/QWW1nDVBHqE05iYFMsVc/iQuZBgzxaPp3WYnUumwXMpnO
   9NGJslQAYBRJ/KzDciOBynpq0X8V/uv2llY3GR1tcEHcg2hy5qDv69gIj
   TEN2vK/bBiWE/BorWEsWw71yh3PEi//ObHKdQ65cw0kbJSvDp4P64USgA
   oeNNWC+Kpdzi0SK2FT9bR7nzywQNx8XlJj9Jic8+rnFRyopn5sF5mGdVm
   KlcM7ubccpkOSepoO/fhKxYanO0WAF2phQ5gRBMQox7u+pFQnttFBQLpD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="359539552"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="359539552"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 20:21:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="692526433"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="692526433"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2023 20:21:28 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 02/12] firmware: stratix10-svc: crypto key management
Date:   Fri, 23 Jun 2023 11:20:19 +0800
Message-Id: <20230623032029.1755017-3-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230623032029.1755017-1-tien.sung.ang@intel.com>
References: <20230623032029.1755017-1-tien.sung.ang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ang Tien Sung <tien.sung.ang@intel.com>

To support the new SDM crypto service key management. The commands support
importing of crypto service keys to the device, exporting the crypto
service keys from the device to the user, removal of the crypto service
keys on the device and lastly a query to retrieve the public key
information. All commands above must be preceded with a open session id
command.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---
 drivers/firmware/stratix10-svc.c              | 35 +++++++
 include/linux/firmware/intel/stratix10-smc.h  | 97 +++++++++++++++++++
 .../firmware/intel/stratix10-svc-client.h     | 17 ++++
 3 files changed, 149 insertions(+)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 536288534d73..fc9d982cbdb1 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -329,6 +329,8 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_FCS_DATA_ENCRYPTION:
 	case COMMAND_FCS_DATA_DECRYPTION:
 	case COMMAND_FCS_CRYPTO_CLOSE_SESSION:
+	case COMMAND_FCS_CRYPTO_IMPORT_KEY:
+	case COMMAND_FCS_CRYPTO_REMOVE_KEY:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		break;
 	case COMMAND_RECONFIG_DATA_SUBMIT:
@@ -362,6 +364,12 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 		cb_data->kaddr2 = svc_pa_to_va(res.a2);
 		cb_data->kaddr3 = &res.a3;
 		break;
+	case COMMAND_FCS_CRYPTO_EXPORT_KEY:
+	case COMMAND_FCS_CRYPTO_GET_KEY_INFO:
+		cb_data->status = BIT(SVC_STATUS_OK);
+		cb_data->kaddr2 = svc_pa_to_va(res.a2);
+		cb_data->kaddr3 = &res.a3;
+		break;
 	case COMMAND_FCS_CRYPTO_OPEN_SESSION:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		cb_data->kaddr2 = &res.a2;
@@ -534,6 +542,31 @@ static int svc_normal_to_secure_thread(void *data)
 			a2 = 0;
 			break;
 
+		/* for service key management */
+		case COMMAND_FCS_CRYPTO_IMPORT_KEY:
+			a0 = INTEL_SIP_SMC_FCS_IMPORT_CRYPTO_SERVICE_KEY;
+			a1 = (unsigned long)pdata->paddr;
+			a2 = (unsigned long)pdata->size;
+			break;
+		case COMMAND_FCS_CRYPTO_EXPORT_KEY:
+			a0 = INTEL_SIP_SMC_FCS_EXPORT_CRYPTO_SERVICE_KEY;
+			a1 = pdata->arg[0];
+			a2 = pdata->arg[1];
+			a3 = (unsigned long)pdata->paddr_output;
+			a4 = (unsigned long)pdata->size_output;
+			break;
+		case COMMAND_FCS_CRYPTO_REMOVE_KEY:
+			a0 = INTEL_SIP_SMC_FCS_REMOVE_CRYPTO_SERVICE_KEY;
+			a1 = pdata->arg[0];
+			a2 = pdata->arg[1];
+			break;
+		case COMMAND_FCS_CRYPTO_GET_KEY_INFO:
+			a0 = INTEL_SIP_SMC_FCS_GET_CRYPTO_SERVICE_KEY_INFO;
+			a1 = pdata->arg[0];
+			a2 = pdata->arg[1];
+			a3 = (unsigned long)pdata->paddr_output;
+			a4 = (unsigned long)pdata->size_output;
+			break;
 		/* for polling */
 		case COMMAND_POLL_SERVICE_STATUS:
 			a0 = INTEL_SIP_SMC_SERVICE_COMPLETED;
@@ -615,6 +648,8 @@ static int svc_normal_to_secure_thread(void *data)
 			case COMMAND_FCS_RANDOM_NUMBER_GEN:
 			case COMMAND_FCS_CRYPTO_OPEN_SESSION:
 			case COMMAND_FCS_CRYPTO_CLOSE_SESSION:
+			case COMMAND_FCS_CRYPTO_IMPORT_KEY:
+			case COMMAND_FCS_CRYPTO_EXPORT_KEY:
 				cbdata->status = BIT(SVC_STATUS_INVALID_PARAM);
 				cbdata->kaddr1 = NULL;
 				cbdata->kaddr2 = NULL;
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index d78f258d3a46..ff1e66df2d0d 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -632,4 +632,101 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FUNCID_FCS_CLOSE_CRYPTO_SERVICE_SESSION 111
 #define INTEL_SIP_SMC_FCS_CLOSE_CRYPTO_SERVICE_SESSION \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_CLOSE_CRYPTO_SERVICE_SESSION)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_IMPORT_CRYPTO_SERVICE_KEY
+ * Async call to import crypto service key to the device
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_IMPORT_CRYPTO_SERVICE_KEY
+ * a1 physical address of the service key object with header
+ * a3 size of the service key object
+ * a4-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_ERROR or
+ *      INTEL_SIP_SMC_STATUS_REJECTED
+ * a1-3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_IMPORT_CRYPTO_SERVICE_KEY 112
+#define INTEL_SIP_SMC_FCS_IMPORT_CRYPTO_SERVICE_KEY \
+	INTEL_SIP_SMC_STD_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_IMPORT_CRYPTO_SERVICE_KEY)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_EXPORT_CRYPTO_SERVICE_KEY
+ * Sync call to export crypto service key from the device
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_EXPORT_CRYPTO_SERVICE_KEY
+ * a1 session ID
+ * a2 key UID
+ * a3 physical address of the exported service key object
+ * a4 size of the exported service key object, max is (88 words + 3 header words)
+ * a5-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox and status errors if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ *      31:24 -- reserved
+ *      23:16 -- import/export/removal status error
+ *      15:11 -- reserved
+ *      10:0  -- mailbox error
+ * a2 physical address of the exported service key object
+ * a3 size of the exported service key object
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_EXPORT_CRYPTO_SERVICE_KEY 113
+#define INTEL_SIP_SMC_FCS_EXPORT_CRYPTO_SERVICE_KEY \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_EXPORT_CRYPTO_SERVICE_KEY)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_REMOVE_CRYPTO_SERVICE_KEY
+ * Sync call to remove the crypto service kers from the device
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_REMOVE_CRYPTO_SERVICE_KEY
+ * a1 session ID
+ * a2 key UID
+ * a3-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox and status errors if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ *	31:24 -- reserved
+ *	23:16 -- import/export/removal status error
+ *	15:11 -- reserved
+ *	10:0  -- mailbox error
+ * a2-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_REMOVE_CRYPTO_SERVICE_KEY 114
+#define INTEL_SIP_SMC_FCS_REMOVE_CRYPTO_SERVICE_KEY \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_REMOVE_CRYPTO_SERVICE_KEY)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_GET_CRYPTO_SERVICE_KEY_INFO
+ * Sync call to query the crypto service keys on the device
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_GET_CRYPTO_SERVICE_KEY_INFO
+ * a1 session ID
+ * a2 key UID
+ * a3 physical address of the response data
+ * a4 max size of the response data (36 words with header)
+ * a3-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox and status errors if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ *	31:24 -- reserved
+ *	23:16 -- import/export/removal status error
+ *	15:11 -- reserved
+ *	10:0  -- mailbox error
+ * a2 physical address of the response data
+ * a3 size of the response data
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_GET_CRYPTO_SERVICE_KEY_INFO 115
+#define INTEL_SIP_SMC_FCS_GET_CRYPTO_SERVICE_KEY_INFO \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_CRYPTO_SERVICE_KEY_INFO)
 #endif
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 44e92390526f..84685918c5d2 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -144,6 +144,19 @@ struct stratix10_svc_chan;
  *
  * @COMMAND_FCS_CRYPTO_CLOSE_SESSION: close the crypto service session(s),
  * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
+ * @COMMAND_FCS_CRYPTO_IMPORT_KEY: import the crypto service key object,
+ * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
+ * @COMMAND_FCS_CRYPTO_EXPORT_KEY: export the crypto service key object,
+ * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
+ * @COMMAND_FCS_CRYPTO_REMOVE_KEY: remove the crypto service key object
+ * from the device, return status is SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
+ * @COMMAND_FCS_CRYPTO_GET_KEY_INFO: get the crypto service key object
+ * info, return status is SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
  */
 enum stratix10_svc_command_code {
 	/* for FPGA */
@@ -173,6 +186,10 @@ enum stratix10_svc_command_code {
 	/* for crypto service */
 	COMMAND_FCS_CRYPTO_OPEN_SESSION = 50,
 	COMMAND_FCS_CRYPTO_CLOSE_SESSION,
+	COMMAND_FCS_CRYPTO_IMPORT_KEY,
+	COMMAND_FCS_CRYPTO_EXPORT_KEY,
+	COMMAND_FCS_CRYPTO_REMOVE_KEY,
+	COMMAND_FCS_CRYPTO_GET_KEY_INFO,
 	/* Non-mailbox SMC Call */
 	COMMAND_SMC_SVC_VERSION = 200,
 };
-- 
2.25.1

