Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8BF692EB0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 07:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjBKGd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 01:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjBKGdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 01:33:16 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A4D7D3F7;
        Fri, 10 Feb 2023 22:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676097191; x=1707633191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Us6l5p+v8jL+t/MyyHBtgCABnzmncxnoWwM45k1g67c=;
  b=UGStmIDk/mAnqkzQgvsxrIWd9c1oFKbzljt0qZ4wsyiCXwXaaCAvZTFB
   jfz6fBMmzewqZSV/osMTd97Ud8vvHCF8ZJoPFfev8NV/nNYHayLgslSxx
   3sNcLS+z2GDBLbwGkDGkNh+a0eseuqPfego2BQsiZwcf2I2Z1BQYXPcyW
   fMy4nt2Q9RQGlPKefXC/oMqBGVsKwJu8+iO4KQaJ1GRYTfg3a2fO8L+Bq
   J9Yo/TwgFEHgydswC7EDDVqTR5EDeyoCbUVTL36BfI8hxM6zjYV/eBWYo
   Ua/fPc+JrzBxySVdqecjWZNVrc33C77jB09qANDCjtYLH0Oazpf/WMSBG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="310223207"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="310223207"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 22:33:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="997171767"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="997171767"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga005.fm.intel.com with ESMTP; 10 Feb 2023 22:33:01 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 05/12] platform/x86: ISST: Add support for MSR 0x54
Date:   Fri, 10 Feb 2023 22:32:50 -0800
Message-Id: <20230211063257.311746-6-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230211063257.311746-1-srinivas.pandruvada@linux.intel.com>
References: <20230211063257.311746-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To map Linux CPU numbering scheme to hardware CPU numbering scheme
MSR 0x53 is getting used. But for new generation of CPUs, this MSR
is not valid. Since this is model specific MSR, this is possible.

A new MSR 0x54 is defined. Use this MSR and convert the IOCTL format
to match existing MSR 0x53, in this case user spaces don't need to
be aware of this change.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/speed_select_if/isst_if_common.c    | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 60e58b0b3835..97d1b4566535 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -19,9 +19,13 @@
 #include <linux/uaccess.h>
 #include <uapi/linux/isst_if.h>
 
+#include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
+
 #include "isst_if_common.h"
 
 #define MSR_THREAD_ID_INFO	0x53
+#define MSR_PM_LOGICAL_ID	0x54
 #define MSR_CPU_BUS_NUMBER	0x128
 
 static struct isst_if_cmd_cb punit_callbacks[ISST_IF_DEV_MAX];
@@ -31,6 +35,7 @@ static int punit_msr_white_list[] = {
 	MSR_CONFIG_TDP_CONTROL,
 	MSR_TURBO_RATIO_LIMIT1,
 	MSR_TURBO_RATIO_LIMIT2,
+	MSR_PM_LOGICAL_ID,
 };
 
 struct isst_valid_cmd_ranges {
@@ -73,6 +78,8 @@ struct isst_cmd {
 	u32 param;
 };
 
+static bool isst_hpm_support;
+
 static DECLARE_HASHTABLE(isst_hash, 8);
 static DEFINE_MUTEX(isst_hash_lock);
 
@@ -411,11 +418,43 @@ static int isst_if_cpu_online(unsigned int cpu)
 		isst_cpu_info[cpu].pci_dev[1] = _isst_if_get_pci_dev(cpu, 1, 30, 1);
 	}
 
+	if (isst_hpm_support) {
+		u64 raw_data;
+
+		ret = rdmsrl_safe(MSR_PM_LOGICAL_ID, &raw_data);
+		if (!ret) {
+			/*
+			 * Use the same format as MSR 53, for user space harmony
+			 *  Format
+			 *	Bit 0 – thread ID
+			 *	Bit 8:1 – core ID
+			 *	Bit 13:9 – Compute domain ID (aka die ID)
+			 * From the MSR 0x54 format
+			 *	[15:11] PM_DOMAIN_ID
+			 *	[10:3] MODULE_ID (aka IDI_AGENT_ID)
+			 *	[2:0] LP_ID (We don't care about these bits we only
+			 *			care die and core id
+			 *	For Atom:
+			 *		[2] Always 0
+			 *		[1:0] core ID within module
+			 *	For Core
+			 *		[2:1] Always 0
+			 *		[0] thread ID
+			 */
+			data = (raw_data >> 11) & 0x1f;
+			data <<= 9;
+			data |= (((raw_data >> 3) & 0xff) << 1);
+			goto set_punit_id;
+		}
+	}
+
 	ret = rdmsrl_safe(MSR_THREAD_ID_INFO, &data);
 	if (ret) {
 		isst_cpu_info[cpu].punit_cpu_id = -1;
 		return ret;
 	}
+
+set_punit_id:
 	isst_cpu_info[cpu].punit_cpu_id = data;
 
 	isst_restore_msr_local(cpu);
@@ -704,6 +743,12 @@ static struct miscdevice isst_if_char_driver = {
 	.fops		= &isst_if_char_driver_ops,
 };
 
+static const struct x86_cpu_id hpm_cpu_ids[] = {
+	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(SIERRAFOREST_X,	NULL),
+	{}
+};
+
 static int isst_misc_reg(void)
 {
 	mutex_lock(&punit_misc_dev_reg_lock);
@@ -711,6 +756,12 @@ static int isst_misc_reg(void)
 		goto unlock_exit;
 
 	if (!misc_usage_count) {
+		const struct x86_cpu_id *id;
+
+		id = x86_match_cpu(hpm_cpu_ids);
+		if (id)
+			isst_hpm_support = true;
+
 		misc_device_ret = isst_if_cpu_info_init();
 		if (misc_device_ret)
 			goto unlock_exit;
-- 
2.39.1

