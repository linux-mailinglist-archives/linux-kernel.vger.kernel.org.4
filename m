Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A6F73AF06
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 05:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjFWDWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 23:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjFWDVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 23:21:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BB726B7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 20:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687490498; x=1719026498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ysOjzgSBbsJ37keiM+QeH3cmLpI89ZIgSZglaTDZeSE=;
  b=XzzqgQRzsRkWXM1z73YcHmiCy1Hn/A091TbLR0lyo7OkFV5EBqNMA5Jy
   R40Kkznuwwg7Cdnt2fU6qu07ST7qJdju2APKmua0udV8oW1wl5JuA7Avl
   dhgWXK4opZpQHF0J7491U7UCqrwq3Mpl91S3AJwf5h9EIBw1zhVfS59Hf
   8125rrN283r/hV86tp1DCJI8T0lmg/+2s5zfUcsAs+mc+vuyiLwhtJ4P+
   tWQgr5upuqcaVvLORCUAJa+CFqt5merhsNJ4MzI8fVI1kqL0oMMmjhvJC
   r5ZFCLZhAfXsko9R2g0bIHuMe51WAVzYmuUI496zJQ82k7n80SM2k/pXq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="359539563"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="359539563"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 20:21:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="692526455"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="692526455"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2023 20:21:36 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 05/12] firmware: stratix10-svc: SHA-2 digest
Date:   Fri, 23 Jun 2023 11:20:22 +0800
Message-Id: <20230623032029.1755017-6-tien.sung.ang@intel.com>
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

To support the request of a SHA-2 hash digest on a blob. If the input
has a key, the output shall be a key-hash digest. The whole
blob data could be split into multiple commands using the INIT,
UPDATE and FINALIZE commands.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---
 drivers/firmware/stratix10-svc.c              | 32 ++++++++
 include/linux/firmware/intel/stratix10-smc.h  | 76 +++++++++++++++++++
 .../firmware/intel/stratix10-svc-client.h     |  7 ++
 3 files changed, 115 insertions(+)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 37f188a1e927..24f727017756 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -332,6 +332,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_FCS_CRYPTO_IMPORT_KEY:
 	case COMMAND_FCS_CRYPTO_REMOVE_KEY:
 	case COMMAND_FCS_CRYPTO_AES_CRYPT_INIT:
+	case COMMAND_FCS_CRYPTO_GET_DIGEST_INIT:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		break;
 	case COMMAND_RECONFIG_DATA_SUBMIT:
@@ -369,6 +370,8 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_FCS_CRYPTO_GET_KEY_INFO:
 	case COMMAND_FCS_CRYPTO_AES_CRYPT_UPDATE:
 	case COMMAND_FCS_CRYPTO_AES_CRYPT_FINALIZE:
+	case COMMAND_FCS_CRYPTO_GET_DIGEST_UPDATE:
+	case COMMAND_FCS_CRYPTO_GET_DIGEST_FINALIZE:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		cb_data->kaddr2 = svc_pa_to_va(res.a2);
 		cb_data->kaddr3 = &res.a3;
@@ -596,6 +599,32 @@ static int svc_normal_to_secure_thread(void *data)
 			a5 = (unsigned long)pdata->paddr_output;
 			a6 = (unsigned long)pdata->size_output;
 			break;
+		case COMMAND_FCS_CRYPTO_GET_DIGEST_INIT:
+			a0 = INTEL_SIP_SMC_FCS_GET_DIGEST_INIT;
+			a1 = pdata->arg[0];
+			a2 = pdata->arg[1];
+			a3 = pdata->arg[2];
+			a4 = pdata->arg[3];
+			a5 = pdata->arg[4];
+			break;
+		case COMMAND_FCS_CRYPTO_GET_DIGEST_UPDATE:
+			a0 = INTEL_SIP_SMC_FCS_GET_DIGEST_UPDATE;
+			a1 = pdata->arg[0];
+			a2 = pdata->arg[1];
+			a3 = (unsigned long)pdata->paddr;
+			a4 = (unsigned long)pdata->size;
+			a5 = (unsigned long)pdata->paddr_output;
+			a6 = (unsigned long)pdata->size_output;
+			break;
+		case COMMAND_FCS_CRYPTO_GET_DIGEST_FINALIZE:
+			a0 = INTEL_SIP_SMC_FCS_GET_DIGEST_FINALIZE;
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
@@ -684,6 +713,9 @@ static int svc_normal_to_secure_thread(void *data)
 			case COMMAND_FCS_CRYPTO_AES_CRYPT_INIT:
 			case COMMAND_FCS_CRYPTO_AES_CRYPT_UPDATE:
 			case COMMAND_FCS_CRYPTO_AES_CRYPT_FINALIZE:
+			case COMMAND_FCS_CRYPTO_GET_DIGEST_INIT:
+			case COMMAND_FCS_CRYPTO_GET_DIGEST_UPDATE:
+			case COMMAND_FCS_CRYPTO_GET_DIGEST_FINALIZE:
 				cbdata->status = BIT(SVC_STATUS_INVALID_PARAM);
 				cbdata->kaddr1 = NULL;
 				cbdata->kaddr2 = NULL;
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index b2f2a7268a0c..47dbef588412 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -799,4 +799,80 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FUNCID_FCS_AES_CRYPTO_FINALIZE 118
 #define INTEL_SIP_SMC_FCS_AES_CRYPTO_FINALIZE \
 	INTEL_SIP_SMC_STD_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_AES_CRYPTO_FINALIZE)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_GET_DIGEST_INIT
+ * Sync call to request the SHA-2 hash digest on a blob
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_GET_DIGEST_INIT
+ * a1 session ID
+ * a2 context ID
+ * a3 key UID
+ * a4 size of crypto parameter data
+ * a5 the crypto parameter
+ *	3:0     SHA operation mode
+ *	7:4     digist size
+ *	63:8    not used
+ * a6-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox errors if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ * a2-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_GET_DIGEST_INIT 119
+#define INTEL_SIP_SMC_FCS_GET_DIGEST_INIT \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_DIGEST_INIT)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_GET_DIGEST_UPDATE
+ * Sync call to request the SHA-2 hash digest on a blob
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_GET_DIGEST_UPDATE
+ * a1 session ID
+ * a2 context ID
+ * a3 physical address of source
+ * a4 size of source
+ * a5 physical address of destination
+ * a6 size of destination
+ * a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox errors if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ * a2 physical address of response data
+ * a3 size of response data
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_GET_DIGEST_UPDATE 120
+#define INTEL_SIP_SMC_FCS_GET_DIGEST_UPDATE \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_DIGEST_UPDATE)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_GET_DIGEST_FINALIZE
+ * Sync call to request the SHA-2 hash digest on a blob
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_GET_DIGEST_FINALIZE
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
+#define INTEL_SIP_SMC_FUNCID_FCS_GET_DIGEST_FINALIZE 121
+#define INTEL_SIP_SMC_FCS_GET_DIGEST_FINALIZE \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_DIGEST_FINALIZE)
 #endif
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index bdcdc895993d..48c34def9ac6 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -160,6 +160,10 @@ struct stratix10_svc_chan;
  * @COMMAND_FCS_CRYPTO_AES_CRYPT: sends request to encrypt or decrypt a
  * data block, return status is SVC_STATUS_OK or SVC_STATUS_ERROR
  *
+ * @COMMAND_FCS_CRYPTO_GET_DIGEST (INIT, UPDATE and FINALIZE): request
+ * the SHA-2 hash digest on a data block,
+ * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
  *
  */
 enum stratix10_svc_command_code {
@@ -197,6 +201,9 @@ enum stratix10_svc_command_code {
 	COMMAND_FCS_CRYPTO_AES_CRYPT_INIT,
 	COMMAND_FCS_CRYPTO_AES_CRYPT_UPDATE,
 	COMMAND_FCS_CRYPTO_AES_CRYPT_FINALIZE,
+	COMMAND_FCS_CRYPTO_GET_DIGEST_INIT,
+	COMMAND_FCS_CRYPTO_GET_DIGEST_UPDATE,
+	COMMAND_FCS_CRYPTO_GET_DIGEST_FINALIZE,
 	/* Non-mailbox SMC Call */
 	COMMAND_SMC_SVC_VERSION = 200,
 };
-- 
2.25.1

