Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B861737B31
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjFUGQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjFUGQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:16:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F231730
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687328159; x=1718864159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6wfThIJKa88l/0KfHTo8J6towRQs0GBms/PPJa4Tx1E=;
  b=kbyLWPgnq1saU85n4U60M4M0IzCCdqD85WjW17V68vfUEBp16rs9TFdg
   PQ0nSOy+eUttZDUXDqykxc6WoVxFumkPNqlxQrdQ+d6DyPaGU6HkFzbvC
   QG66Ukac78EKiX6kihzQrMgotf13FYbxRQNm02bMYXoOrs5hVAZobVMff
   jXkezJZEcsm6IZRd9c3W6H7Twxu9XS/XnPJYRoWFZXm2MgXbHkQa/T4Pi
   N1VaU2q23xizCKeaOQ9mhydq4zCqgc8VrUvvV2BrFViTzm6b9OXI35EVj
   hC9AjqZNBbmq5qBLpIXRE9R+K1Sxvlwfv7aiDCpi9kqNJn0PcpP7722pZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="349814438"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="349814438"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 23:15:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="714327557"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="714327557"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga002.jf.intel.com with ESMTP; 20 Jun 2023 23:15:57 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 2/3] firmware: stratix10-svc: extend for single certificate
Date:   Wed, 21 Jun 2023 14:15:07 +0800
Message-Id: <20230621061508.1429913-3-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230621061508.1429913-1-tien.sung.ang@intel.com>
References: <20230621061508.1429913-1-tien.sung.ang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ang Tien Sung <tien.sung.ang@intel.com>

Extend Intel service layer driver to support a single certificate to allow
unauthenticated updates to the PTS counter.
PTS = Pseudo Time Stamp

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---
 drivers/firmware/stratix10-svc.c               | 11 +++++++++++
 include/linux/firmware/intel/stratix10-smc.h   | 18 ++++++++++++++++++
 .../firmware/intel/stratix10-svc-client.h      |  5 +++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index a277fe9c4db4..be0a39900570 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -329,6 +329,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_FCS_DATA_ENCRYPTION:
 	case COMMAND_FCS_DATA_DECRYPTION:
 	case COMMAND_FCS_PSGSIGMA_TEARDOWN:
+	case COMMAND_FCS_COUNTER_SET_PREAUTHORIZED:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		break;
 	case COMMAND_RECONFIG_DATA_SUBMIT:
@@ -524,8 +525,17 @@ static int svc_normal_to_secure_thread(void *data)
 			a1 = (unsigned long)pdata->paddr;
 			a2 = (unsigned long)pdata->size;
 			break;
+		case COMMAND_FCS_COUNTER_SET_PREAUTHORIZED:
+			a0 = INTEL_SIP_SMC_FCS_COUNTER_SET_PREAUTHORIZED;
+			a1 = pdata->arg[0];
+			a2 = pdata->arg[1];
+			a3 = pdata->arg[2];
+			break;
 		case COMMAND_FCS_GET_PROVISION_DATA:
 			a0 = INTEL_SIP_SMC_FCS_GET_PROVISION_DATA;
+			a1 = 0;
+			a2 = 0;
+			break;
 		case COMMAND_FCS_PSGSIGMA_TEARDOWN:
 			a0 = INTEL_SIP_SMC_FCS_PSGSIGMA_TEARDOWN;
 			a1 = pdata->arg[0];
@@ -633,6 +643,7 @@ static int svc_normal_to_secure_thread(void *data)
 			case COMMAND_FCS_GET_CHIP_ID:
 			case COMMAND_FCS_ATTESTATION_SUBKEY:
 			case COMMAND_FCS_ATTESTATION_MEASUREMENTS:
+			case COMMAND_FCS_COUNTER_SET_PREAUTHORIZED:
 				cbdata->status = BIT(SVC_STATUS_INVALID_PARAM);
 				cbdata->kaddr1 = NULL;
 				cbdata->kaddr2 = NULL;
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index d9f0251256e9..8f92a55ba51d 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -594,6 +594,24 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FUNCID_FCS_GET_PROVISION_DATA 94
 #define INTEL_SIP_SMC_FCS_GET_PROVISION_DATA \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_PROVISION_DATA)
+/**
+ * Request INTEL_SIP_SMC_FCS_COUNTER_SET_PREAUTHORIZED
+ * Sync call to update counter value w/o signed certificate
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_COUNTER_SET_PREAUTHORIZED
+ * a1 counter type
+ * a2 counter value
+ * a3 test bit
+ * a3-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK or INTEL_SIP_SMC_STATUS_ERROR
+ * a1-a4 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_COUNTER_SET_PREAUTHORIZED 95
+#define INTEL_SIP_SMC_FCS_COUNTER_SET_PREAUTHORIZED \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_COUNTER_SET_PREAUTHORIZED)
 
 /**
  * Request INTEL_SIP_SMC_FCS_PSGSIGMA_TEARDOWN
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 5346967dd2fe..4703f6c486a1 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -139,6 +139,10 @@ struct stratix10_svc_chan;
  * @COMMAND_FCS_RANDOM_NUMBER_GEN: generate a random number, return status
  * is SVC_STATUS_OK, SVC_STATUS_ERROR
  *
+ * @COMMAND_FCS_COUNTER_SET_PREAUTHORIZED: update the counter value for
+ * the selected counter without the signed certificate, return status is
+ * SVC_STATUS_OK, or SVC_STATUS_ERROR
+ *
  * @COMMAND_FCS_PSGSIGMA_TEARDOWN: tear down all previous black key
  * provision sessions and delete keys assicated with those sessions,
  * return status is SVC_STATUS_SUBMITTED or SVC_STATUS_ERROR
@@ -175,6 +179,7 @@ enum stratix10_svc_command_code {
 	COMMAND_FCS_DATA_ENCRYPTION,
 	COMMAND_FCS_DATA_DECRYPTION,
 	COMMAND_FCS_RANDOM_NUMBER_GEN,
+	COMMAND_FCS_COUNTER_SET_PREAUTHORIZED,
 	/* for Attestation */
 	COMMAND_FCS_PSGSIGMA_TEARDOWN = 30,
 	COMMAND_FCS_GET_CHIP_ID,
-- 
2.25.1

