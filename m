Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A05B73AF0C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 05:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjFWDXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 23:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjFWDWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 23:22:13 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9AB2697
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 20:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687490515; x=1719026515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hq4P7oMXDJteC8thcBd8DVIP7ZYxQmSDqqK/97TRRuU=;
  b=bMjVCKNCmECk2tw7FCUFp3JKFhLr5Ab5X9a5Ds9ebxbYwvgKzqQIQHOK
   vpXDUB/vgXndZRaxXYhjC7fP34kZC2ByWbgEh8misYYaVT3t4AvT+O53M
   w8kjttkAepsXz42AdFYYHM5dgUVqLpsIh+Of3NvHrOAyY4Z7D2zTVZ8H8
   39Abq2meCxinh6B7Snq3f+xGdCbUN7958cpnSj0wSs2u0YtfFuCkg9wKc
   OygeGBK/CmnZKu9p8RRwmGIWLg+SNgcWqRc9ZFMkXVjjq1eVANU78dwJK
   d65ki70NOs+s9utQ/qWs38OOvK8acRfDk5acgaaeFN663x90V0oD8RKQ8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="359539593"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="359539593"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 20:21:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="692526503"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="692526503"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2023 20:21:49 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 11/12] firmware: stratix10-svc: public key request
Date:   Fri, 23 Jun 2023 11:20:28 +0800
Message-Id: <20230623032029.1755017-12-tien.sung.ang@intel.com>
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

To support the request to get the public key.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---
 drivers/firmware/stratix10-svc.c              | 19 ++++++++
 include/linux/firmware/intel/stratix10-smc.h  | 48 +++++++++++++++++++
 .../firmware/intel/stratix10-svc-client.h     |  6 +++
 3 files changed, 73 insertions(+)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index e56cc82fb531..2e57f166c55a 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -338,6 +338,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_FCS_CRYPTO_ECDSA_SHA2_DATA_SIGNING_INIT:
 	case COMMAND_FCS_CRYPTO_ECDSA_HASH_VERIFY_INIT:
 	case COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_INIT:
+	case COMMAND_FCS_CRYPTO_ECDSA_GET_PUBLIC_KEY_INIT:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		break;
 	case COMMAND_RECONFIG_DATA_SUBMIT:
@@ -385,6 +386,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_FCS_CRYPTO_ECDSA_HASH_VERIFY_FINALIZE:
 	case COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_UPDATE:
 	case COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_FINALIZE:
+	case COMMAND_FCS_CRYPTO_ECDSA_GET_PUBLIC_KEY_FINALIZE:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		cb_data->kaddr2 = svc_pa_to_va(res.a2);
 		cb_data->kaddr3 = &res.a3;
@@ -755,6 +757,21 @@ static int svc_normal_to_secure_thread(void *data)
 			a6 = (unsigned long)pdata->size_output;
 			a7 = pdata->arg[2];
 			break;
+		case COMMAND_FCS_CRYPTO_ECDSA_GET_PUBLIC_KEY_INIT:
+			a0 = INTEL_SIP_SMC_FCS_ECDSA_GET_PUBLIC_KEY_INIT;
+			a1 = pdata->arg[0];
+			a2 = pdata->arg[1];
+			a3 = pdata->arg[2];
+			a4 = pdata->arg[3];
+			a5 = pdata->arg[4];
+			break;
+		case COMMAND_FCS_CRYPTO_ECDSA_GET_PUBLIC_KEY_FINALIZE:
+			a0 = INTEL_SIP_SMC_FCS_ECDSA_GET_PUBLIC_KEY_FINALIZE;
+			a1 = pdata->arg[0];
+			a2 = pdata->arg[1];
+			a3 = (unsigned long)pdata->paddr_output;
+			a4 = (unsigned long)pdata->size_output;
+			break;
 		/* for polling */
 		case COMMAND_POLL_SERVICE_STATUS:
 			a0 = INTEL_SIP_SMC_SERVICE_COMPLETED;
@@ -860,6 +877,8 @@ static int svc_normal_to_secure_thread(void *data)
 			case COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_INIT:
 			case COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_UPDATE:
 			case COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_FINALIZE:
+			case COMMAND_FCS_CRYPTO_ECDSA_GET_PUBLIC_KEY_INIT:
+			case COMMAND_FCS_CRYPTO_ECDSA_GET_PUBLIC_KEY_FINALIZE:
 				cbdata->status = BIT(SVC_STATUS_INVALID_PARAM);
 				cbdata->kaddr1 = NULL;
 				cbdata->kaddr2 = NULL;
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index 0176d963f876..b82e1ec0bc73 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -1203,4 +1203,52 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_ECDSA_SHA2_DATA_SIGNATURE_V
 #define INTEL_SIP_SMC_FUNCID_FCS_ECDSA_SHA2_DATA_SIGNATURE_VERIFY_FINALIZE 136
 #define INTEL_SIP_SMC_FCS_ECDSA_SHA2_DATA_SIGNATURE_VERIFY_FINALIZE \
 INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_ECDSA_SHA2_DATA_SIGNATURE_VERIFY_FINALIZE)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_ECDSA_GET_PUBLIC_KEY_INIT
+ * Sync call to send the request to get the public key
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_ECDSA_GET_PUBLIC_KEY_INIT
+ * a1 session ID
+ * a2 context ID
+ * a3 key UID
+ * a4 size of crypto parameter data
+ * a5 crypto parameter data
+ *      3:0     EE algorithm
+ *      63:4    not used
+ * a6-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox errors if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ * a2-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_ECDSA_GET_PUBLIC_KEY_INIT 137
+#define INTEL_SIP_SMC_FCS_ECDSA_GET_PUBLIC_KEY_INIT \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_ECDSA_GET_PUBLIC_KEY_INIT)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_ECDSA_GET_PUBLIC_KEY_FINALIZE
+ * Sync call to send the request to get the public key
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_ECDSA_GET_PUBLIC_KEY_FINALIZE
+ * a1 session ID
+ * a2 context ID
+ * a3 physical address of response data
+ * a4 size of response data
+ * a5-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox errors if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ * a2 physical address of response data
+ * a3 size of response data
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_FCS_ECDSA_GET_PUBLIC_KEY_FINALIZE 139
+#define INTEL_SIP_SMC_FCS_ECDSA_GET_PUBLIC_KEY_FINALIZE \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_FCS_ECDSA_GET_PUBLIC_KEY_FINALIZE)
 #endif
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index db5ee0d1b9ab..467eca23ca79 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -184,6 +184,10 @@ struct stratix10_svc_chan;
  * send digital signature verify request,
  * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
  *
+ * @COMMAND_FCS_CRYPTO_ECDSA_GET_PUBLIC_KEY (INIT and FINALIZE): send the
+ * request to get the public key, return status is SVC_STATUS_OK or
+ * SVC_STATUS_ERROR
+ *
  */
 enum stratix10_svc_command_code {
 	/* for FPGA */
@@ -236,6 +240,8 @@ enum stratix10_svc_command_code {
 	COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_INIT,
 	COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_UPDATE,
 	COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_FINALIZE,
+	COMMAND_FCS_CRYPTO_ECDSA_GET_PUBLIC_KEY_INIT,
+	COMMAND_FCS_CRYPTO_ECDSA_GET_PUBLIC_KEY_FINALIZE,
 	/* Non-mailbox SMC Call */
 	COMMAND_SMC_SVC_VERSION = 200,
 };
-- 
2.25.1

