Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32446AFF71
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjCHHHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCHHGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:06:53 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8519BA2F04;
        Tue,  7 Mar 2023 23:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678259205; x=1709795205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nHC2S8VQU/i3DgShSFHJyWHqj0biVys2rxofZiFuJkg=;
  b=HH2wroMqxTzOjxUH+ytFV+pdJEpUryJMI+3W7d0c/Igg/T7qw55PUzr+
   XSjZSNUvMYp6jDgNuQpDSfivBMZf9vCvhmThbB438R1ZO1YggJQIAcQ5u
   IZQHK4NcSYFu4vURXAtbOYkv5tiQxYO6f3HLn0ukIEEMOfwhaYq8CzA1J
   tFteEpCPrcMYBpZhhE8+p9wkx/RArB1x+NSJ/1VBw5M8DTNd+n8dEju9K
   J/O/RTeF1i64IMM746lx3kbvDO/1HtKcYJw4XxExdokIs6OiuCPbS/y6p
   fzKGQMjyd8pt1lBwwMfk9FDkQLnCAA/QsoPXFOl+/zTee9OftuqY7SjSO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="333553967"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="333553967"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 23:06:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="850986377"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="850986377"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga005.jf.intel.com with ESMTP; 07 Mar 2023 23:06:43 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Pragya Tanwar <pragya.tanwar@intel.com>
Subject: [PATCH v2 1/8] platform/x86: ISST: Add support for MSR 0x54
Date:   Tue,  7 Mar 2023 23:06:35 -0800
Message-Id: <20230308070642.1727167-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230308070642.1727167-1-srinivas.pandruvada@linux.intel.com>
References: <20230308070642.1727167-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To map Linux CPU numbering scheme to hardware CPU numbering scheme
MSR 0x53 is getting used. But for new generation of CPUs, this MSR
is not valid. Since this is model specific MSR, this is possible.

A new MSR 0x54 is defined for this purpose. User space can use the
API version to distinguish format from MSR 0x53.

Intel speed select utility is updated to use the new format based
on the API version.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Pragya Tanwar <pragya.tanwar@intel.com>
---
v2
- Don't do any format conversion, let user space do this

 .../intel/speed_select_if/isst_if_common.c    | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 19e671500f00..e0572a29212e 100644
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
 
@@ -411,11 +418,20 @@ static int isst_if_cpu_online(unsigned int cpu)
 		isst_cpu_info[cpu].pci_dev[1] = _isst_if_get_pci_dev(cpu, 1, 30, 1);
 	}
 
+	if (isst_hpm_support) {
+
+		ret = rdmsrl_safe(MSR_PM_LOGICAL_ID, &data);
+		if (!ret)
+			goto set_punit_id;
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
@@ -704,6 +720,12 @@ static struct miscdevice isst_if_char_driver = {
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
@@ -711,6 +733,12 @@ static int isst_misc_reg(void)
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
2.34.1

