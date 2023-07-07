Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E40774AC72
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjGGIE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjGGIE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:04:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24143170C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 01:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688717066; x=1720253066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ueADtJqxoyNqdjFUUjZp6Vw7c9mnY+aYtssylW9Ip58=;
  b=VxHKHhZlW+l4pB8T6ielYbPqSO6iODdXUPi9VFN4zxNiHJ06VNYAiRol
   T0vDdhrYmkZWZ4+HEhKlL7eOuhfgNhUZaBuxoZfu9i4l3NSOPLhOwkKt0
   fAKE1T4zpWRVNN7mFl1rsjFPAW0v5eETo6nWNT6dd8/zwInH2tFIhXBdw
   2qUeI3mGkOfeC/tlWhdpASHGN/LEm4KzeC3ExKY06hhaYlnMOEtxNmE2i
   +Rmw41rG2y+9CuH+wX8BsM7iV8q6G3fts0qurdC7n0ShladUrnO8dZ5pw
   bWEAuUIkQNOe80qsIUvlpGYr1LCgnTqOqSwkiGx0Rf8Ypo+Cx6DvGGqHi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="429896775"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="429896775"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 01:04:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="844019395"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="844019395"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by orsmga004.jf.intel.com with ESMTP; 07 Jul 2023 01:04:23 -0700
From:   kah.jing.lee@intel.com
To:     dinguyen@kernel.org
Cc:     linux-kernel@vger.kernel.org, radu.bacrau@intel.com,
        tien.sung.ang@intel.com, Teh Wen Ping <wen.ping.teh@intel.com>,
        Kah Jing Lee <kah.jing.lee@intel.com>
Subject: [PATCH 1/2 RESEND] firmware: stratix10-svc: Generic Mailbox Command
Date:   Fri,  7 Jul 2023 16:03:06 +0800
Message-Id: <20230707080305.1722983-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230707080112.1722827-1-kah.jing.lee@intel.com>
References: <20230707080112.1722827-1-kah.jing.lee@intel.com>
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

From: Teh Wen Ping <wen.ping.teh@intel.com>

Add generic mailbox command that can support SDM command. User can use this
command to send SDM mailbox command. User have to specified an input file
which contain the command data and an output file for SDM response to be
copied over.

Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
---
 drivers/firmware/stratix10-svc.c              | 18 +++++++++++++
 include/linux/firmware/intel/stratix10-smc.h  | 25 +++++++++++++++++++
 .../firmware/intel/stratix10-svc-client.h     |  5 ++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 2d674126160f..430e8bf0bca9 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -37,6 +37,7 @@
 #define SVC_NUM_CHANNEL				3
 #define FPGA_CONFIG_DATA_CLAIM_TIMEOUT_MS	200
 #define FPGA_CONFIG_STATUS_TIMEOUT_SEC		30
+#define BYTE_TO_WORD_SIZE              4
 
 /* stratix10 service layer clients */
 #define STRATIX10_RSU				"stratix10-rsu"
@@ -361,6 +362,13 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 		cb_data->kaddr2 = svc_pa_to_va(res.a2);
 		cb_data->kaddr3 = &res.a3;
 		break;
+	case COMMAND_MBOX_SEND_CMD:
+		cb_data->status = BIT(SVC_STATUS_OK);
+		cb_data->kaddr1 = &res.a1;
+		/* SDM return size in u32 word. Convert size to u8 */
+		res.a2 = res.a2 * BYTE_TO_WORD_SIZE;
+		cb_data->kaddr2 = &res.a2;
+		break;
 	default:
 		pr_warn("it shouldn't happen\n");
 		break;
@@ -534,6 +542,15 @@ static int svc_normal_to_secure_thread(void *data)
 			a1 = 0;
 			a2 = 0;
 			break;
+		case COMMAND_MBOX_SEND_CMD:
+			a0 = INTEL_SIP_SMC_MBOX_SEND_CMD;
+			a1 = pdata->arg[0];
+			a2 = (unsigned long)pdata->paddr;
+			a3 = (unsigned long)pdata->size / BYTE_TO_WORD_SIZE;
+			a4 = pdata->arg[1];
+			a5 = (unsigned long)pdata->paddr_output;
+			a6 = (unsigned long)pdata->size_output / BYTE_TO_WORD_SIZE;
+			break;
 		default:
 			pr_warn("it shouldn't happen\n");
 			break;
@@ -597,6 +614,7 @@ static int svc_normal_to_secure_thread(void *data)
 			case COMMAND_FCS_DATA_ENCRYPTION:
 			case COMMAND_FCS_DATA_DECRYPTION:
 			case COMMAND_FCS_RANDOM_NUMBER_GEN:
+			case COMMAND_MBOX_SEND_CMD:
 				cbdata->status = BIT(SVC_STATUS_INVALID_PARAM);
 				cbdata->kaddr1 = NULL;
 				cbdata->kaddr2 = NULL;
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index a718f853d457..ee80ca4bb0d0 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -466,6 +466,31 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FIRMWARE_VERSION \
         INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FIRMWARE_VERSION)
 
+/**
+ * SMC call protocol for Mailbox, starting FUNCID from 60
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_MBOX_SEND_CMD
+ * a1 mailbox command code
+ * a2 physical address that contain mailbox command data (not include header)
+ * a3 mailbox command data size in word
+ * a4 set to 0 for CASUAL, set to 1 for URGENT
+ * a5 physical address for secure firmware to put response data
+ *    (not include header)
+ * a6 maximum size in word of physical address to store response data
+ * a7 not used
+ *
+ * Return status
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_REJECTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox error code
+ * a2 response data length in word
+ * a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_MBOX_SEND_CMD 60
+	#define INTEL_SIP_SMC_MBOX_SEND_CMD \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_MBOX_SEND_CMD)
+
 /**
  * Request INTEL_SIP_SMC_SVC_VERSION
  *
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 0c16037fd08d..60ed82112680 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -118,6 +118,9 @@ struct stratix10_svc_chan;
  * @COMMAND_SMC_SVC_VERSION: Non-mailbox SMC SVC API Version,
  * return status is SVC_STATUS_OK
  *
+ * @COMMAND_MBOX_SEND_CMD: send generic mailbox command, return status is
+ * SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
  * @COMMAND_RSU_DCMF_STATUS: query firmware for the DCMF status
  * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
  *
@@ -164,6 +167,8 @@ enum stratix10_svc_command_code {
 	COMMAND_FCS_RANDOM_NUMBER_GEN,
 	/* for general status poll */
 	COMMAND_POLL_SERVICE_STATUS = 40,
+	/* for generic mailbox send command */
+	COMMAND_MBOX_SEND_CMD = 100,
 	/* Non-mailbox SMC Call */
 	COMMAND_SMC_SVC_VERSION = 200,
 };
-- 
2.25.1

