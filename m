Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D04C73AF0A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 05:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjFWDWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 23:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjFWDWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 23:22:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA0F2133
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 20:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687490507; x=1719026507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oPZMNCcDc1MASeclK4Cfw3PvR0IDGN44juKg+G0J/c0=;
  b=lcr2tvyrpWd4oGaA3hfhJ3+3roVxOXn7jMz3CBkTYlGbcQH7g8Pdeti0
   ZrkIPWiuuWzhINhoudxPkmgW7LlbP0hTAr/vzVtQ2h1KqqWfcqPTvQ0N6
   uMwmAcNNXnu8VLKjzokUWNiWFYbqMoDjbqvEoVG+uGKvPzng5l3sxNJCZ
   N3oiGvqq90jskGX3KmaiR8rQqm+ksKCYTYzhJIn8ER1vLM3yNuMsjG0UD
   Clu41vPDr3h/fG2myCVzDQVBRBKdL2E1zyw2cCedVcaJYryPB/YbtTdUE
   /orPNsxInKWNrXF9YKUJuEBBScuY2jGzELF79bnfYdn295ZTCcYoJFIXC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="359539581"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="359539581"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 20:21:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="692526486"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="692526486"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2023 20:21:45 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 09/12] firmware: stratix10-svc: hash signature verification
Date:   Fri, 23 Jun 2023 11:20:26 +0800
Message-Id: <20230623032029.1755017-10-tien.sung.ang@intel.com>
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

To support digital signature verification request with pre-calculated
hash.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---
 drivers/firmware/stratix10-svc.c              | 21 ++++++++
 include/linux/firmware/intel/stratix10-smc.h  | 48 +++++++++++++++++++
 .../firmware/intel/stratix10-svc-client.h     |  6 +++
 3 files changed, 75 insertions(+)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index ccb8f314b624..12f0137c450e 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -336,6 +336,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_FCS_CRYPTO_MAC_VERIFY_INIT:
 	case COMMAND_FCS_CRYPTO_ECDSA_HASH_SIGNING_INIT:
 	case COMMAND_FCS_CRYPTO_ECDSA_SHA2_DATA_SIGNING_INIT:
+	case COMMAND_FCS_CRYPTO_ECDSA_HASH_VERIFY_INIT:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		break;
 	case COMMAND_RECONFIG_DATA_SUBMIT:
@@ -380,6 +381,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_FCS_CRYPTO_ECDSA_HASH_SIGNING_FINALIZE:
 	case COMMAND_FCS_CRYPTO_ECDSA_SHA2_DATA_SIGNING_UPDATE:
 	case COMMAND_FCS_CRYPTO_ECDSA_SHA2_DATA_SIGNING_FINALIZE:
+	case COMMAND_FCS_CRYPTO_ECDSA_HASH_VERIFY_FINALIZE:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		cb_data->kaddr2 = svc_pa_to_va(res.a2);
 		cb_data->kaddr3 = &res.a3;
@@ -705,6 +707,23 @@ static int svc_normal_to_secure_thread(void *data)
 			a5 = (unsigned long)pdata->paddr_output;
 			a6 = (unsigned long)pdata->size_output;
 			break;
+		case COMMAND_FCS_CRYPTO_ECDSA_HASH_VERIFY_INIT:
+			a0 = INTEL_SIP_SMC_FCS_ECDSA_HASH_SIGNATURE_VERIFY_INIT;
+			a1 = pdata->arg[0];
+			a2 = pdata->arg[1];
+			a3 = pdata->arg[2];
+			a4 = pdata->arg[3];
+			a5 = pdata->arg[4];
+			break;
+		case COMMAND_FCS_CRYPTO_ECDSA_HASH_VERIFY_FINALIZE:
+			a0 = INTEL_SIP_SMC_FCS_ECDSA_HASH_SIGNATURE_VERIFY_FINALIZE;
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
@@ -805,6 +824,8 @@ static int svc_normal_to_secure_thread(void *data)
 			case COMMAND_FCS_CRYPTO_ECDSA_SHA2_DATA_SIGNING_INIT:
 			case COMMAND_FCS_CRYPTO_ECDSA_SHA2_DATA_SIGNING_UPDATE:
 			case COMMAND_FCS_CRYPTO_ECDSA_SHA2_DATA_SIGNING_FINALIZE:
+			case COMMAND_FCS_CRYPTO_ECDSA_HASH_VERIFY_INIT:
+			case COMMAND_FCS_CRYPTO_ECDSA_HASH_VERIFY_FINALIZE:
 				cbdata->status = BIT(SVC_STATUS_INVALID_PARAM);
 				cbdata->kaddr1 = NULL;
 				cbdata->kaddr2 = NULL;
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index 3bd814916f3e..3a03bcb638bb 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -1080,4 +1080,52 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FUNCID_ECDSA_SHA2_DATA_SIGNING_FINALIZE 130
 #define INTEL_SIP_SMC_FCS_ECDSA_SHA2_DATA_SIGNING_FINALIZE \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_ECDSA_SHA2_DATA_SIGNING_FINALIZE)
+/**
+ * Request INTEL_SIP_SMC_FCS_ECDSA_HASH_SIGNATURE_VERIFY_INIT
+ * Sync call to sends digital signature verify request with precalculated hash
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_ECDSA_HASH_SIGNATURE_VERIFY_INIT
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
+#define INTEL_SIP_SMC_FUNCID_ECDSA_HASH_SIGNATURE_VERIFY_INIT 131
+#define INTEL_SIP_SMC_FCS_ECDSA_HASH_SIGNATURE_VERIFY_INIT \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_ECDSA_HASH_SIGNATURE_VERIFY_INIT)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_ECDSA_HASH_SIGNATURE_VERIFY_FINALIZE
+ * Sync call to sends digital signature verify request with precalculated hash
+ *
+ * a0 INTEL_SIP_SMC_FCS_ECDSA_HASH_SIGNATURE_VERIFY_FINALIZE
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
+#define INTEL_SIP_SMC_FUNCID_FCS_ECDSA_HASH_SIGNATURE_VERIFY_FINALIZE 133
+#define INTEL_SIP_SMC_FCS_ECDSA_HASH_SIGNATURE_VERIFY_FINALIZE \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_ECDSA_HASH_SIGNATURE_VERIFY_FINALIZE)
 #endif
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 875e6e13632e..59de7a27d825 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -176,6 +176,10 @@ struct stratix10_svc_chan;
  * send SHA2 digital signature signing request on a data blob,
  * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
  *
+ * @COMMAND_FCS_CRYPTO_ECDSA_HASH_VERIFY (INIT and FINALIZE): send
+ * digital signature verify request with precalculated hash, return status is
+ * SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
  */
 enum stratix10_svc_command_code {
 	/* for FPGA */
@@ -223,6 +227,8 @@ enum stratix10_svc_command_code {
 	COMMAND_FCS_CRYPTO_ECDSA_SHA2_DATA_SIGNING_INIT,
 	COMMAND_FCS_CRYPTO_ECDSA_SHA2_DATA_SIGNING_UPDATE,
 	COMMAND_FCS_CRYPTO_ECDSA_SHA2_DATA_SIGNING_FINALIZE,
+	COMMAND_FCS_CRYPTO_ECDSA_HASH_VERIFY_INIT,
+	COMMAND_FCS_CRYPTO_ECDSA_HASH_VERIFY_FINALIZE,
 	/* Non-mailbox SMC Call */
 	COMMAND_SMC_SVC_VERSION = 200,
 };
-- 
2.25.1

