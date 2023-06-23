Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894CC73AF04
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 05:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjFWDV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 23:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjFWDVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 23:21:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFD32696
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 20:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687490494; x=1719026494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CIWWmSlGkGHoBzub+TtEEhu3hqnVO2BGDrgczveZwYQ=;
  b=JelzpU8hJttOf2Hm1YVRjqlxS4pDqrFmigxaMeQOCbCxRCk7JpgAlj/J
   G82GZ30Epn3C3Ln4s5SxxvSbhY1Bylg6GvlEH15kswPQKbZaBe6oipCMJ
   hEgTKZLVNuu6u2/i1174QqdHIn7H9NSmuQjuB4dJVK3avhVDgFupGtoyt
   epsBhdmhqbqNX81HspPVZM31pPEbY7U1e6r3/2ewKPaRUgPSYSp/OeB2w
   ku7EtXqWX7wS4N2QWW7tqDoNBUkj5rwPXqa1B6XuoRZtvAJNDkkmZ5WqV
   QHG1WgG6MiZFrhlamJoWEHY/+kdDsq0WxIVdjzG0Ux6/vXRUC2EuWarnT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="359539559"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="359539559"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 20:21:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="692526443"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="692526443"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2023 20:21:32 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 03/12] firmware: stratix10-svc: AES encrypt and decrypt
Date:   Fri, 23 Jun 2023 11:20:20 +0800
Message-Id: <20230623032029.1755017-4-tien.sung.ang@intel.com>
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

One of the new crypto services introduced for AES encryption and
decryption. It is dependent on open/close crypto session commands
and crypto service key commands.
An import of the AES 128/256bit crypto service key before starting
an AES service is required. This command sends a request to encrypt
or decrypt a blob. The blob could be split into multiple commands
based on the crypto process stage that is INIT, UPDATE and
FINALIZE.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---
 drivers/firmware/stratix10-svc.c              | 34 +++++++++
 include/linux/firmware/intel/stratix10-smc.h  | 70 +++++++++++++++++++
 .../firmware/intel/stratix10-svc-client.h     |  7 ++
 3 files changed, 111 insertions(+)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index fc9d982cbdb1..d7a11f7a43f3 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -331,6 +331,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_FCS_CRYPTO_CLOSE_SESSION:
 	case COMMAND_FCS_CRYPTO_IMPORT_KEY:
 	case COMMAND_FCS_CRYPTO_REMOVE_KEY:
+	case COMMAND_FCS_CRYPTO_AES_CRYPT_INIT:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		break;
 	case COMMAND_RECONFIG_DATA_SUBMIT:
@@ -366,6 +367,8 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 		break;
 	case COMMAND_FCS_CRYPTO_EXPORT_KEY:
 	case COMMAND_FCS_CRYPTO_GET_KEY_INFO:
+	case COMMAND_FCS_CRYPTO_AES_CRYPT_UPDATE:
+	case COMMAND_FCS_CRYPTO_AES_CRYPT_FINALIZE:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		cb_data->kaddr2 = svc_pa_to_va(res.a2);
 		cb_data->kaddr3 = &res.a3;
@@ -567,6 +570,32 @@ static int svc_normal_to_secure_thread(void *data)
 			a3 = (unsigned long)pdata->paddr_output;
 			a4 = (unsigned long)pdata->size_output;
 			break;
+		case COMMAND_FCS_CRYPTO_AES_CRYPT_INIT:
+			a0 = INTEL_SIP_SMC_FCS_AES_CRYPTO_INIT;
+			a1 = pdata->arg[0];
+			a2 = pdata->arg[1];
+			a3 = pdata->arg[2];
+			a4 = (unsigned long)pdata->paddr;
+			a5 = (unsigned long)pdata->size;
+			break;
+		case COMMAND_FCS_CRYPTO_AES_CRYPT_UPDATE:
+			a0 = INTEL_SIP_SMC_FCS_AES_CRYPTO_UPDATE;
+			a1 = pdata->arg[0];
+			a2 = pdata->arg[1];
+			a3 = (unsigned long)pdata->paddr;
+			a4 = (unsigned long)pdata->size;
+			a5 = (unsigned long)pdata->paddr_output;
+			a6 = (unsigned long)pdata->size_output;
+			break;
+		case COMMAND_FCS_CRYPTO_AES_CRYPT_FINALIZE:
+			a0 = INTEL_SIP_SMC_FCS_AES_CRYPTO_FINALIZE;
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
@@ -650,6 +679,11 @@ static int svc_normal_to_secure_thread(void *data)
 			case COMMAND_FCS_CRYPTO_CLOSE_SESSION:
 			case COMMAND_FCS_CRYPTO_IMPORT_KEY:
 			case COMMAND_FCS_CRYPTO_EXPORT_KEY:
+			case COMMAND_FCS_CRYPTO_REMOVE_KEY:
+			case COMMAND_FCS_CRYPTO_GET_KEY_INFO:
+			case COMMAND_FCS_CRYPTO_AES_CRYPT_INIT:
+			case COMMAND_FCS_CRYPTO_AES_CRYPT_UPDATE:
+			case COMMAND_FCS_CRYPTO_AES_CRYPT_FINALIZE:
 				cbdata->status = BIT(SVC_STATUS_INVALID_PARAM);
 				cbdata->kaddr1 = NULL;
 				cbdata->kaddr2 = NULL;
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index ff1e66df2d0d..b2f2a7268a0c 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -729,4 +729,74 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FUNCID_FCS_GET_CRYPTO_SERVICE_KEY_INFO 115
 #define INTEL_SIP_SMC_FCS_GET_CRYPTO_SERVICE_KEY_INFO \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_CRYPTO_SERVICE_KEY_INFO)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_AES_CRYPTO_INIT
+ * Sync call to initialize AES crypto operation
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_AES_CRYPTO_INIT
+ * a1 session ID
+ * a2 context ID
+ * a3 key UID
+ * a4 physical address of AES crypto parameter data (include block mode,
+ *    encrypt/decrypt, IV fields
+ * a5 size of AES crypto parameter data
+ * a6-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox errors if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ * a2-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_AES_CRYPTO_INIT 116
+#define INTEL_SIP_SMC_FCS_AES_CRYPTO_INIT \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_AES_CRYPTO_INIT)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_AES_CRYPTO_UPDATE
+ * Sync call to decrypt/encrypt a data block
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_AES_CRYPTO_UPDATE
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
+ * a1-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_AES_CRYPTO_UPDATE 117
+#define INTEL_SIP_SMC_FCS_AES_CRYPTO_UPDATE \
+	INTEL_SIP_SMC_STD_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_AES_CRYPTO_UPDATE)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_AES_CRYPTO_FINALIZE
+ * Sync call to decrypt/encrypt a data block
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_AES_CRYPTO_FINALIZE
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
+ * a1-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_AES_CRYPTO_FINALIZE 118
+#define INTEL_SIP_SMC_FCS_AES_CRYPTO_FINALIZE \
+	INTEL_SIP_SMC_STD_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_AES_CRYPTO_FINALIZE)
 #endif
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 84685918c5d2..2d4a016468ae 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -157,6 +157,10 @@ struct stratix10_svc_chan;
  * @COMMAND_FCS_CRYPTO_GET_KEY_INFO: get the crypto service key object
  * info, return status is SVC_STATUS_OK or SVC_STATUS_ERROR
  *
+ * @COMMAND_FCS_CRYPTO_AES_CRYPT: sends request to encrypt or decrypt a
+ * data block, return status is SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
+ *
  */
 enum stratix10_svc_command_code {
 	/* for FPGA */
@@ -190,6 +194,9 @@ enum stratix10_svc_command_code {
 	COMMAND_FCS_CRYPTO_EXPORT_KEY,
 	COMMAND_FCS_CRYPTO_REMOVE_KEY,
 	COMMAND_FCS_CRYPTO_GET_KEY_INFO,
+	COMMAND_FCS_CRYPTO_AES_CRYPT_INIT,
+	COMMAND_FCS_CRYPTO_AES_CRYPT_UPDATE,
+	COMMAND_FCS_CRYPTO_AES_CRYPT_FINALIZE,
 	/* Non-mailbox SMC Call */
 	COMMAND_SMC_SVC_VERSION = 200,
 };
-- 
2.25.1

