Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1D673AF02
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 05:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjFWDVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 23:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjFWDVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 23:21:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294C92130
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 20:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687490484; x=1719026484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kmp1QjDF1a/y20HCub4INyRcK4yxS5vrH5TX6x2YbYc=;
  b=nNm6q3buCEdSTlalalW0b0MnidC7vvlefl12ql4M3w7775gdD4VRfExF
   J8HIN214fZTL7+JhJwoKju9ijAur1UfpBS4lEpdYlksnmUCT32BV6A/VD
   KkUyXFCmpqYygXCGB3Bqo4OvYkvtB8YGMU8kN3faz5HPZZ0lsmhJmLmKH
   xmKBnJCk7vmIVg6rel85+PkCFNOg3iFrGGMk5ZfoO9r0lhMpsf5m12dEb
   zGSP9NUMqCVMS1Fu+NEyMDdTyztWAezuF7BVi8coIB7/miTyrJBgUQxct
   JaW6XWXO4UNuhj8peXwK0QN0LoZysQ3+671787kDoqjfnlAw7K8gSXug9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="359539541"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="359539541"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 20:21:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="692526415"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="692526415"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2023 20:21:22 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 01/12] firmware: stratix10-svc: support open & close crypto session
Date:   Fri, 23 Jun 2023 11:20:18 +0800
Message-Id: <20230623032029.1755017-2-tien.sung.ang@intel.com>
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

Support open & close the crypto service session.
COMMAND_FCS_CRYPTO_OPEN_SESSION command requests to open
and establish a crypto service session with SDM and returns a
session id.
COMMAND_FCS_CRYPTO_CLOSE_SESSION command closes a crypto
session wiht SDM with the given session id.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---
 drivers/firmware/stratix10-svc.c              | 18 +++++++++
 include/linux/firmware/intel/stratix10-smc.h  | 37 +++++++++++++++++++
 .../firmware/intel/stratix10-svc-client.h     |  9 +++++
 3 files changed, 64 insertions(+)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 80f4e2d14e04..536288534d73 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -328,6 +328,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_FCS_SEND_CERTIFICATE:
 	case COMMAND_FCS_DATA_ENCRYPTION:
 	case COMMAND_FCS_DATA_DECRYPTION:
+	case COMMAND_FCS_CRYPTO_CLOSE_SESSION:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		break;
 	case COMMAND_RECONFIG_DATA_SUBMIT:
@@ -361,6 +362,10 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 		cb_data->kaddr2 = svc_pa_to_va(res.a2);
 		cb_data->kaddr3 = &res.a3;
 		break;
+	case COMMAND_FCS_CRYPTO_OPEN_SESSION:
+		cb_data->status = BIT(SVC_STATUS_OK);
+		cb_data->kaddr2 = &res.a2;
+		break;
 	default:
 		pr_warn("it shouldn't happen\n");
 		break;
@@ -517,6 +522,17 @@ static int svc_normal_to_secure_thread(void *data)
 			a1 = (unsigned long)pdata->paddr;
 			a2 = 0;
 			break;
+		/* for crypto service */
+		case COMMAND_FCS_CRYPTO_OPEN_SESSION:
+			a0 = INTEL_SIP_SMC_FCS_OPEN_CRYPTO_SERVICE_SESSION;
+			a1 = 0;
+			a2 = 0;
+			break;
+		case COMMAND_FCS_CRYPTO_CLOSE_SESSION:
+			a0 = INTEL_SIP_SMC_FCS_CLOSE_CRYPTO_SERVICE_SESSION;
+			a1 = pdata->arg[0];
+			a2 = 0;
+			break;
 
 		/* for polling */
 		case COMMAND_POLL_SERVICE_STATUS:
@@ -597,6 +613,8 @@ static int svc_normal_to_secure_thread(void *data)
 			case COMMAND_FCS_DATA_ENCRYPTION:
 			case COMMAND_FCS_DATA_DECRYPTION:
 			case COMMAND_FCS_RANDOM_NUMBER_GEN:
+			case COMMAND_FCS_CRYPTO_OPEN_SESSION:
+			case COMMAND_FCS_CRYPTO_CLOSE_SESSION:
 				cbdata->status = BIT(SVC_STATUS_INVALID_PARAM);
 				cbdata->kaddr1 = NULL;
 				cbdata->kaddr2 = NULL;
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index a718f853d457..d78f258d3a46 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -595,4 +595,41 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FCS_GET_PROVISION_DATA \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_PROVISION_DATA)
 
+/**
+ * Request INTEL_SIP_SMC_FCS_OPEN_CRYPTO_SERVICE_SESSION
+ * Sync call to open and establish a crypto service session with firmware
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_OPEN_CRYPTO_SERVICE_SESSION
+ * a1-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox error if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ * a2 session ID
+ * a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_OPEN_CRYPTO_SERVICE_SESSION 110
+#define INTEL_SIP_SMC_FCS_OPEN_CRYPTO_SERVICE_SESSION \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_OPEN_CRYPTO_SERVICE_SESSION)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_CLOSE_CRYPTO_SERVICE_SESSION
+ * Sync call to close a service session
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_CLOSE_CRYPTO_SERVICE_SESSION
+ * a1 session ID
+ * a2-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox error if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ * a2-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_CLOSE_CRYPTO_SERVICE_SESSION 111
+#define INTEL_SIP_SMC_FCS_CLOSE_CRYPTO_SERVICE_SESSION \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_CLOSE_CRYPTO_SERVICE_SESSION)
 #endif
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 0c16037fd08d..44e92390526f 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -138,6 +138,12 @@ struct stratix10_svc_chan;
  *
  * @COMMAND_FCS_RANDOM_NUMBER_GEN: generate a random number, return status
  * is SVC_STATUS_OK, SVC_STATUS_ERROR
+ *
+ * @COMMAND_FCS_CRYPTO_OPEN_SESSION: open the crypto service session(s),
+ * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
+ * @COMMAND_FCS_CRYPTO_CLOSE_SESSION: close the crypto service session(s),
+ * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
  */
 enum stratix10_svc_command_code {
 	/* for FPGA */
@@ -164,6 +170,9 @@ enum stratix10_svc_command_code {
 	COMMAND_FCS_RANDOM_NUMBER_GEN,
 	/* for general status poll */
 	COMMAND_POLL_SERVICE_STATUS = 40,
+	/* for crypto service */
+	COMMAND_FCS_CRYPTO_OPEN_SESSION = 50,
+	COMMAND_FCS_CRYPTO_CLOSE_SESSION,
 	/* Non-mailbox SMC Call */
 	COMMAND_SMC_SVC_VERSION = 200,
 };
-- 
2.25.1

