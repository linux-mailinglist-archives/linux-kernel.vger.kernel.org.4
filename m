Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02CC6F4FFC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 08:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjECGN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 02:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjECGN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 02:13:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C8230CB;
        Tue,  2 May 2023 23:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683094437; x=1714630437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Ighfp5E/Al9/svQfOrOI4+bSPRt3bo1pMOcWF2LXzY=;
  b=B5/1WF3vjY6wUlRkzI2POCJQ7nvvueUC7Q30ZkxnlHqGhGUNHsLn9j2c
   yYw+RFURjeVVIey7raVKtnQftJH8sGCZRCBKrdMw0qW3Vj6etzy1pvKim
   jHdQlIQe1s0IBsgFTUIIOTdkYCAIqSnsNOQETuJSUhQqqBQhACjovzm2B
   2hurSXq37jOHy9bubqdlwpSTcgJYDvnGZF2n2G5tVXafvhhcOZqcRu+vt
   FIc74wImzOqui3jgSTKLZ4082xeyVkyyGYdkEnJJ2bEAArfkUIGRt7/tO
   AIPloNpI3XvkmUCZfeWzJtSC5gyW9BKOQ0ecK/uM6NFV3HF/5zdvkQu/7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="328205845"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="328205845"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 23:13:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="690574181"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="690574181"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by orsmga007.jf.intel.com with ESMTP; 02 May 2023 23:13:54 -0700
From:   niravkumar.l.rabara@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
Subject: [PATCH 1/2] firmware: stratix10-svc: Add command to get SEU error info
Date:   Wed,  3 May 2023 14:09:59 +0800
Message-Id: <20230503061000.3279381-2-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230503061000.3279381-1-niravkumar.l.rabara@intel.com>
References: <20230503061000.3279381-1-niravkumar.l.rabara@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Introduce a new command to get Single Event Upset Error information.

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 include/linux/firmware/intel/stratix10-smc.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index a718f853d457..7eb1799e8d8a 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -595,4 +595,24 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FCS_GET_PROVISION_DATA \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_PROVISION_DATA)
 
+/**
+ * Request INTEL_SIP_SMC_READ_SEU_ERR
+ * Sync call to get Single Event Upsate Error information
+ * SEU detects both corrected and uncorrected error
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_READ_SEU_ERR
+ * a1-7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 error count of response data
+ * a2 sector address of response data
+ * a3 error data
+ */
+#define INTEL_SIP_SMC_FUNCID_SEU_ERR_STATUS 143
+#define INTEL_SIP_SMC_READ_SEU_ERR \
+		INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_SEU_ERR_STATUS)
+
 #endif
-- 
2.25.1

