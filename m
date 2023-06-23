Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C1073AF08
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 05:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjFWDWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 23:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjFWDWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 23:22:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAA82724
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 20:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687490502; x=1719026502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OjyOW4z1iOvPHyVDnDhWdJMyjEMrfHJF21db+3PPqaw=;
  b=SmFrLK9KGOjOmDWE9yPBnTNiY+n0fR/Gw+7SJ1WUt/97nuqEHvD3CGXg
   B3MkuwUdoWKEKmPDuOZwenWLA4khXeqQ+ZuhiGABNKUhZRB3KPYj2dbrG
   GJm4DVq92r24jU+QfE/vhloWW0XGkri1+gKhYsG3eZ2Bg4xL2erZhkN1R
   UoYu9uRuFwFVnagoJB0+Va26ZsA9oB081eBYIfbKKcHtupY/3lB7yOiU9
   I5fSIhVfyYLEwDTb8Q/bAjWCn06Cw3AQdZOtyd2Wk6ufBafix6bUpRmjw
   kvk8nKNuXeq5x2hY+QrVGRp/nfLQYQ8aXHG4bLCrqU767RCept9XOwpPz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="359539574"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="359539574"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 20:21:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="692526474"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="692526474"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2023 20:21:41 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 07/12] firmware: stratix10-svc: ECDSA Hash signing
Date:   Fri, 23 Jun 2023 11:20:24 +0800
Message-Id: <20230623032029.1755017-8-tien.sung.ang@intel.com>
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

To support command to send a digital signature signing request
on a data blob.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---
 drivers/firmware/stratix10-svc.c              | 21 ++++++++
 include/linux/firmware/intel/stratix10-smc.h  | 49 +++++++++++++++++++
 .../firmware/intel/stratix10-svc-client.h     |  7 ++-
 3 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index f8d23b8d2f62..642478ce2855 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -334,6 +334,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_FCS_CRYPTO_AES_CRYPT_INIT:
 	case COMMAND_FCS_CRYPTO_GET_DIGEST_INIT:
 	case COMMAND_FCS_CRYPTO_MAC_VERIFY_INIT:
+	case COMMAND_FCS_CRYPTO_ECDSA_HASH_SIGNING_INIT:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		break;
 	case COMMAND_RECONFIG_DATA_SUBMIT:
@@ -375,6 +376,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_FCS_CRYPTO_GET_DIGEST_FINALIZE:
 	case COMMAND_FCS_CRYPTO_MAC_VERIFY_UPDATE:
 	case COMMAND_FCS_CRYPTO_MAC_VERIFY_FINALIZE:
+	case COMMAND_FCS_CRYPTO_ECDSA_HASH_SIGNING_FINALIZE:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		cb_data->kaddr2 = svc_pa_to_va(res.a2);
 		cb_data->kaddr3 = &res.a3;
@@ -657,6 +659,23 @@ static int svc_normal_to_secure_thread(void *data)
 			a7 = pdata->arg[2];
 			break;
 
+		case COMMAND_FCS_CRYPTO_ECDSA_HASH_SIGNING_INIT:
+			a0 = INTEL_SIP_SMC_FCS_ECDSA_HASH_SIGNING_INIT;
+			a1 = pdata->arg[0];
+			a2 = pdata->arg[1];
+			a3 = pdata->arg[2];
+			a4 = pdata->arg[3];
+			a5 = pdata->arg[4];
+			break;
+		case COMMAND_FCS_CRYPTO_ECDSA_HASH_SIGNING_FINALIZE:
+			a0 = INTEL_SIP_SMC_FCS_ECDSA_HASH_SIGNING_FINALIZE;
+			a1 = pdata->arg[0];
+			a2 = pdata->arg[1];
+			a3 = (unsigned long)pdata->paddr;
+			a4 = (unsigned long)pdata->size;
+			a5 = (unsigned long)pdata->paddr_output;
+			a6 = (unsigned long)pdata->size_output;
+			break;
 		/* for polling */
 		case COMMAND_POLL_SERVICE_STATUS:
 			a0 = INTEL_SIP_SMC_SERVICE_COMPLETED;
@@ -752,6 +771,8 @@ static int svc_normal_to_secure_thread(void *data)
 			case COMMAND_FCS_CRYPTO_MAC_VERIFY_UPDATE:
 			case COMMAND_FCS_CRYPTO_MAC_VERIFY_FINALIZE:
 
+			case COMMAND_FCS_CRYPTO_ECDSA_HASH_SIGNING_INIT:
+			case COMMAND_FCS_CRYPTO_ECDSA_HASH_SIGNING_FINALIZE:
 				cbdata->status = BIT(SVC_STATUS_INVALID_PARAM);
 				cbdata->kaddr1 = NULL;
 				cbdata->kaddr2 = NULL;
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index 25ca40607ebc..3283269daf45 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -956,4 +956,53 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FCS_MAC_VERIFY_FINALIZE \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_MAC_VERIFY_FINALIZE)
 
+/**
+ * Request INTEL_SIP_SMC_FCS_ECDSA_HASH_SIGNING_INIT
+ * Sync call to sends digital signature signing request on a data blob
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_ECDSA_HASH_SIGNING_INIT
+ * a1 session ID
+ * a2 context ID
+ * a3 key UID
+ * a4 size of crypto parameter data
+ * a5 size of crypto parameter data
+ *      3:0     ECC algoritim
+ *      63:4    not used
+ * a6-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox errors if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ * a2-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_ECDSA_HASH_SIGNING_INIT 125
+#define INTEL_SIP_SMC_FCS_ECDSA_HASH_SIGNING_INIT \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_ECDSA_HASH_SIGNING_INIT)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_ECDSA_HASH_SIGNING_FINALIZE
+ * Sync call to sends digital signature signing request on a data blob
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_ECDSA_HASH_SIGNING_FINALIZE
+ * a1 session ID
+ * a2 context ID
+ * a3 physical address of source
+ * a4 size of source
+ * a5 physical address of destation
+ * a6 size of destation
+ * a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox errors if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ * a2 physical address of response data
+ * a3 size of response data
+ */
+#define INTEL_SIP_SMC_FUNCID_ECDSA_HASH_SIGNING_FINALIZE 127
+#define INTEL_SIP_SMC_FCS_ECDSA_HASH_SIGNING_FINALIZE \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_ECDSA_HASH_SIGNING_FINALIZE)
 #endif
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 7f04fae175ed..9569a55fb3ab 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -168,6 +168,10 @@ struct stratix10_svc_chan;
  * the integrity and authenticity of a blob, return status is
  * SVC_STATUS_OK or SVC_STATUS_ERROR
  *
+ * @COMMAND_FCS_CRYPTO_ECDSA_HASH_SIGNING (INIT and FINALIZE): send
+ * digital signature signing request on a data blob, return status is
+ * SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
  */
 enum stratix10_svc_command_code {
 	/* for FPGA */
@@ -210,7 +214,8 @@ enum stratix10_svc_command_code {
 	COMMAND_FCS_CRYPTO_MAC_VERIFY_INIT,
 	COMMAND_FCS_CRYPTO_MAC_VERIFY_UPDATE,
 	COMMAND_FCS_CRYPTO_MAC_VERIFY_FINALIZE,
-
+	COMMAND_FCS_CRYPTO_ECDSA_HASH_SIGNING_INIT,
+	COMMAND_FCS_CRYPTO_ECDSA_HASH_SIGNING_FINALIZE,
 	/* Non-mailbox SMC Call */
 	COMMAND_SMC_SVC_VERSION = 200,
 };
-- 
2.25.1

