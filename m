Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297A473AF0B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 05:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjFWDWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 23:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjFWDWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 23:22:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D2A268C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 20:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687490511; x=1719026511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kJUyfkAjs4zCc6RR50ufhWeT6wCXXSm6Lsad7x6U5sc=;
  b=Rg93zze9UKyZOjoCW6p2SOH3fzagj0sfzZleRpbyObv/lmYYcbdOMEmH
   RCsb+7MDlqk6aLPTUHeoGqFhaZnKalC63O1bPyjHXjrzWXwMnlI8o3Ej4
   6y5uJWGHWZsIr6EuZOdP4ylWukr3OQMmImqh/ZaCtWUydoNJ2K/jqJoxV
   P/YDxb0bf04lGg5NwUQZm1gafYqfHbIKNPKq+/UZLI3r8RV727vAVQ5Li
   o6EZxXCfiitL7prhoOzC9TjpA59rNoEMQSNJ5AHKyHwF82MXBeg2L8old
   7FLlsANjnOjpY9Eb3LWKcdI7MkP6nTVj+h6G6Toozwa5omQVJt9ZEHyL+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="359539587"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="359539587"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 20:21:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="692526496"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="692526496"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2023 20:21:47 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 10/12] firmware: stratix10-svc: SHA2 signature verification
Date:   Fri, 23 Jun 2023 11:20:27 +0800
Message-Id: <20230623032029.1755017-11-tien.sung.ang@intel.com>
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

Supports digital signature verify request for SHA2. The whole blob
crypto process might be split into multiple commands or stages INIT,
UPDATE and FINALIZE.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---
 drivers/firmware/stratix10-svc.c              | 34 +++++++++
 include/linux/firmware/intel/stratix10-smc.h  | 75 +++++++++++++++++++
 .../firmware/intel/stratix10-svc-client.h     |  7 ++
 3 files changed, 116 insertions(+)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 12f0137c450e..e56cc82fb531 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -337,6 +337,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_FCS_CRYPTO_ECDSA_HASH_SIGNING_INIT:
 	case COMMAND_FCS_CRYPTO_ECDSA_SHA2_DATA_SIGNING_INIT:
 	case COMMAND_FCS_CRYPTO_ECDSA_HASH_VERIFY_INIT:
+	case COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_INIT:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		break;
 	case COMMAND_RECONFIG_DATA_SUBMIT:
@@ -382,6 +383,8 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_FCS_CRYPTO_ECDSA_SHA2_DATA_SIGNING_UPDATE:
 	case COMMAND_FCS_CRYPTO_ECDSA_SHA2_DATA_SIGNING_FINALIZE:
 	case COMMAND_FCS_CRYPTO_ECDSA_HASH_VERIFY_FINALIZE:
+	case COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_UPDATE:
+	case COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_FINALIZE:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		cb_data->kaddr2 = svc_pa_to_va(res.a2);
 		cb_data->kaddr3 = &res.a3;
@@ -724,6 +727,34 @@ static int svc_normal_to_secure_thread(void *data)
 			a5 = (unsigned long)pdata->paddr_output;
 			a6 = (unsigned long)pdata->size_output;
 			break;
+		case COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_INIT:
+			a0 = INTEL_SIP_SMC_FCS_ECDSA_SHA2_DATA_SIGNATURE_VERIFY_INIT;
+			a1 = pdata->arg[0];
+			a2 = pdata->arg[1];
+			a3 = pdata->arg[2];
+			a4 = pdata->arg[3];
+			a5 = pdata->arg[4];
+			break;
+		case COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_UPDATE:
+			a0 = INTEL_SIP_SMC_FCS_ECDSA_SHA2_DATA_SIGNATURE_VERIFY_UPDATE;
+			a1 = pdata->arg[0];
+			a2 = pdata->arg[1];
+			a3 = (unsigned long)pdata->paddr;
+			a4 = (unsigned long)pdata->size;
+			a5 = (unsigned long)pdata->paddr_output;
+			a6 = (unsigned long)pdata->size_output;
+			a7 = pdata->arg[2];
+			break;
+		case COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_FINALIZE:
+			a0 = INTEL_SIP_SMC_FCS_ECDSA_SHA2_DATA_SIGNATURE_VERIFY_FINALIZE;
+			a1 = pdata->arg[0];
+			a2 = pdata->arg[1];
+			a3 = (unsigned long)pdata->paddr;
+			a4 = (unsigned long)pdata->size;
+			a5 = (unsigned long)pdata->paddr_output;
+			a6 = (unsigned long)pdata->size_output;
+			a7 = pdata->arg[2];
+			break;
 		/* for polling */
 		case COMMAND_POLL_SERVICE_STATUS:
 			a0 = INTEL_SIP_SMC_SERVICE_COMPLETED;
@@ -826,6 +857,9 @@ static int svc_normal_to_secure_thread(void *data)
 			case COMMAND_FCS_CRYPTO_ECDSA_SHA2_DATA_SIGNING_FINALIZE:
 			case COMMAND_FCS_CRYPTO_ECDSA_HASH_VERIFY_INIT:
 			case COMMAND_FCS_CRYPTO_ECDSA_HASH_VERIFY_FINALIZE:
+			case COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_INIT:
+			case COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_UPDATE:
+			case COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_FINALIZE:
 				cbdata->status = BIT(SVC_STATUS_INVALID_PARAM);
 				cbdata->kaddr1 = NULL;
 				cbdata->kaddr2 = NULL;
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index 3a03bcb638bb..0176d963f876 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -1128,4 +1128,79 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FUNCID_FCS_ECDSA_HASH_SIGNATURE_VERIFY_FINALIZE 133
 #define INTEL_SIP_SMC_FCS_ECDSA_HASH_SIGNATURE_VERIFY_FINALIZE \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_ECDSA_HASH_SIGNATURE_VERIFY_FINALIZE)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_ECDSA_SHA2_DATA_SIGNATURE_VERIFY_INIT
+ * Sync call to send digital signature verify request
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_ECDSA_SHA2_DATA_SIGNATURE_VERIFY_INIT
+ * a1 session ID
+ * a2 context ID
+ * a3 key UID
+ * a4 size of crypto parameter data
+ * a5 crypto parameter data
+ *      3:0     ECC algorithm
+ *      63:4    not used
+ * a6-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox errors if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ * a2-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_ECDSA_SHA2_DATA_SIGNATURE_VERIFY_INIT 134
+#define INTEL_SIP_SMC_FCS_ECDSA_SHA2_DATA_SIGNATURE_VERIFY_INIT \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_ECDSA_SHA2_DATA_SIGNATURE_VERIFY_INIT)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_ECDSA_SHA2_DATA_SIGNATURE_VERIFY_UPDATE
+ * Sync call to send digital signature verify request
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_ECDSA_SHA2_DATA_SIGNATURE_VERIFY_UPDATE
+ * a1 session ID
+ * a2 context ID
+ * a3 physical address of source (contain user data)
+ * a4 size of source
+ * a5 physical address of destination
+ * a6 size of destination
+ * a7 size of user data
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox errors if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ * a2 physical address of response data
+ * a3 size of response data
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_ECDSA_SHA2_DATA_SIGNATURE_VERIFY_UPDATE 135
+#define INTEL_SIP_SMC_FCS_ECDSA_SHA2_DATA_SIGNATURE_VERIFY_UPDATE \
+INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_ECDSA_SHA2_DATA_SIGNATURE_VERIFY_UPDATE)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_ECDSA_SHA2_DATA_SIGNATURE_VERIFY_FINALIZE
+ * Sync call to send digital signature verify request
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_ECDSA_SHA2_DATA_SIGNATURE_VERIFY_FINALIZE
+ * a1 session ID
+ * a2 context ID
+ * a3 physical address of source
+ * a4 size of source
+ * a5 physical address of destation
+ * a6 size of destation
+ * a7 size of user data
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox errors if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ * a2 physical address of response data
+ * a3 size of response data
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_ECDSA_SHA2_DATA_SIGNATURE_VERIFY_FINALIZE 136
+#define INTEL_SIP_SMC_FCS_ECDSA_SHA2_DATA_SIGNATURE_VERIFY_FINALIZE \
+INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_ECDSA_SHA2_DATA_SIGNATURE_VERIFY_FINALIZE)
 #endif
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 59de7a27d825..db5ee0d1b9ab 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -180,6 +180,10 @@ struct stratix10_svc_chan;
  * digital signature verify request with precalculated hash, return status is
  * SVC_STATUS_OK or SVC_STATUS_ERROR
  *
+ * @COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY (INIT, UPDATE and FINALIZE):
+ * send digital signature verify request,
+ * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
  */
 enum stratix10_svc_command_code {
 	/* for FPGA */
@@ -229,6 +233,9 @@ enum stratix10_svc_command_code {
 	COMMAND_FCS_CRYPTO_ECDSA_SHA2_DATA_SIGNING_FINALIZE,
 	COMMAND_FCS_CRYPTO_ECDSA_HASH_VERIFY_INIT,
 	COMMAND_FCS_CRYPTO_ECDSA_HASH_VERIFY_FINALIZE,
+	COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_INIT,
+	COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_UPDATE,
+	COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_FINALIZE,
 	/* Non-mailbox SMC Call */
 	COMMAND_SMC_SVC_VERSION = 200,
 };
-- 
2.25.1

