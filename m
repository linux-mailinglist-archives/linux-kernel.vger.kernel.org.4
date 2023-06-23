Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8CE73AF0D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 05:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjFWDXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 23:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjFWDWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 23:22:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64AA2959
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 20:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687490519; x=1719026519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JGaUbiFyr+kR1QKcmR79gvD78omTiKV6G3JZ78Q4XnY=;
  b=lhL98+Byftz6lBz9bZmJ2F5fs8e6Ozr2eRo3yQIKIiYBeu64981P/O4z
   3q9v4VpJJGN8bEMWMgOqnCwx2xfV2B8DLDl2BrFYW0+QWGWSiWvLyIcro
   oYMhTiYsKt9gR6vz7JlOu+Zw0fem8awoYDmNvOVHZh/IDb1ptqwThEeMo
   5BG4mjpK7EcbdQ+0YXTIeV229uIIcT6CaZvxRPcKJYhUpBRb0nkAD+9ws
   v3XzKDK/aca3CpAb/bqSA+XhE0coKLu++bgwPvFMAh3dp64FBqH0PrjLm
   gScJqVMXxfthqRTLdj/J8RDdAEGX6NwGH61UP+RNZmKRzTD47KV6oriFe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="359539597"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="359539597"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 20:21:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="692526516"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="692526516"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2023 20:21:51 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 12/12] firmware: stratix10-svc: ECDH request
Date:   Fri, 23 Jun 2023 11:20:29 +0800
Message-Id: <20230623032029.1755017-13-tien.sung.ang@intel.com>
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

Update to support ECDH request.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---
 drivers/firmware/stratix10-svc.c              | 21 ++++++++
 include/linux/firmware/intel/stratix10-smc.h  | 52 +++++++++++++++++++
 .../firmware/intel/stratix10-svc-client.h     |  6 +++
 3 files changed, 79 insertions(+)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 2e57f166c55a..507aead32ee4 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -339,6 +339,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_FCS_CRYPTO_ECDSA_HASH_VERIFY_INIT:
 	case COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_INIT:
 	case COMMAND_FCS_CRYPTO_ECDSA_GET_PUBLIC_KEY_INIT:
+	case COMMAND_FCS_CRYPTO_ECDH_REQUEST_INIT:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		break;
 	case COMMAND_RECONFIG_DATA_SUBMIT:
@@ -387,6 +388,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_UPDATE:
 	case COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_FINALIZE:
 	case COMMAND_FCS_CRYPTO_ECDSA_GET_PUBLIC_KEY_FINALIZE:
+	case COMMAND_FCS_CRYPTO_ECDH_REQUEST_FINALIZE:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		cb_data->kaddr2 = svc_pa_to_va(res.a2);
 		cb_data->kaddr3 = &res.a3;
@@ -772,6 +774,23 @@ static int svc_normal_to_secure_thread(void *data)
 			a3 = (unsigned long)pdata->paddr_output;
 			a4 = (unsigned long)pdata->size_output;
 			break;
+		case COMMAND_FCS_CRYPTO_ECDH_REQUEST_INIT:
+			a0 = INTEL_SIP_SMC_FCS_ECDH_INIT;
+			a1 = pdata->arg[0];
+			a2 = pdata->arg[1];
+			a3 = pdata->arg[2];
+			a4 = pdata->arg[3];
+			a5 = pdata->arg[4];
+			break;
+		case COMMAND_FCS_CRYPTO_ECDH_REQUEST_FINALIZE:
+			a0 = INTEL_SIP_SMC_FCS_ECDH_FINALIZE;
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
@@ -879,6 +898,8 @@ static int svc_normal_to_secure_thread(void *data)
 			case COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_FINALIZE:
 			case COMMAND_FCS_CRYPTO_ECDSA_GET_PUBLIC_KEY_INIT:
 			case COMMAND_FCS_CRYPTO_ECDSA_GET_PUBLIC_KEY_FINALIZE:
+			case COMMAND_FCS_CRYPTO_ECDH_REQUEST_INIT:
+			case COMMAND_FCS_CRYPTO_ECDH_REQUEST_FINALIZE:
 				cbdata->status = BIT(SVC_STATUS_INVALID_PARAM);
 				cbdata->kaddr1 = NULL;
 				cbdata->kaddr2 = NULL;
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index b82e1ec0bc73..194e5ad076bf 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -1251,4 +1251,56 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_ECDSA_SHA2_DATA_SIGNATURE_V
 #define INTEL_SIP_SMC_FUNCID_FCS_FCS_ECDSA_GET_PUBLIC_KEY_FINALIZE 139
 #define INTEL_SIP_SMC_FCS_ECDSA_GET_PUBLIC_KEY_FINALIZE \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_FCS_ECDSA_GET_PUBLIC_KEY_FINALIZE)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_ECDH_INIT
+ * Sync call to send the request on generating a share secret on
+ * Diffie-Hellman key exchange
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_ECDH_INIT
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
+#define INTEL_SIP_SMC_FUNCID_FCS_ECDH_INIT 140
+#define INTEL_SIP_SMC_FCS_ECDH_INIT \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_ECDH_INIT)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_ECDH_FINALIZE
+ * Sync call to send the request on generating a share secret on
+ * Diffie-Hellman key exchange
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_ECDH_FINALIZE
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
+#define INTEL_SIP_SMC_FUNCID_FCS_ECDH_FINALIZE 142
+#define INTEL_SIP_SMC_FCS_ECDH_FINALIZE \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_ECDH_FINALIZE)
 #endif
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 467eca23ca79..0d846b07ab14 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -188,6 +188,10 @@ struct stratix10_svc_chan;
  * request to get the public key, return status is SVC_STATUS_OK or
  * SVC_STATUS_ERROR
  *
+ * @COMMAND_FCS_CRYPTO_ECDH_REQUEST (INIT and FINALIZE): send the request
+ * on generating a share secret on Diffie-Hellman key exchange, return
+ * status is SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
  */
 enum stratix10_svc_command_code {
 	/* for FPGA */
@@ -242,6 +246,8 @@ enum stratix10_svc_command_code {
 	COMMAND_FCS_CRYPTO_ECDSA_SHA2_VERIFY_FINALIZE,
 	COMMAND_FCS_CRYPTO_ECDSA_GET_PUBLIC_KEY_INIT,
 	COMMAND_FCS_CRYPTO_ECDSA_GET_PUBLIC_KEY_FINALIZE,
+	COMMAND_FCS_CRYPTO_ECDH_REQUEST_INIT,
+	COMMAND_FCS_CRYPTO_ECDH_REQUEST_FINALIZE,
 	/* Non-mailbox SMC Call */
 	COMMAND_SMC_SVC_VERSION = 200,
 };
-- 
2.25.1

