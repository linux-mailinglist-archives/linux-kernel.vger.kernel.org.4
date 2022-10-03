Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE255F3897
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 00:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiJCWFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 18:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiJCWEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:04:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B7763F4;
        Mon,  3 Oct 2022 15:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664834682; x=1696370682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6WwR4lJkD9myqJbkioJF7WxCYyfmYMBhp6kUNpLwcZg=;
  b=Z1OmKhcd1YBJzWwuALgAHsxI2ArVx57u6ltPX50bpGPtI4jCZV+vzlQd
   aTX+13GfUejHloIJmDEqo/dE4/er1QMDnIE7hzOWP3hy9BJIgBPfSGOEU
   KTluyq9q7uJxsQ6MVzrctlpwn8rLm8wDEkgOUsUbQxcogeT+1pZc+SAmf
   5PS9V8bx3rHOFVMky1Bbpt213Y5KVz6IZYBHibB0+/zu5og611DvZYuZx
   WCg26X7C0n9Sk1D2/NeWeZOZoAkERIOOyLUVoiZLxKAE+ghDqmjsXv2Pd
   Dm/3uBli/e7iGtaEo9IAEihZ96YskzFJK1y5EL0JM6TPWAHXmAW/GSHS3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="366869173"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="366869173"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 15:04:42 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="686310962"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="686310962"
Received: from jparcemo-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.93.75])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 15:04:40 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     linux-sgx@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, jarkko@kernel.org,
        tony.luck@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] x86/sgx: Only run the reclaimer when the native SGX driver is enabled
Date:   Tue,  4 Oct 2022 11:04:28 +1300
Message-Id: <0dd24e5549bbdee8580c2495f1df93798aadfd11.1664834225.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1664834225.git.kai.huang@intel.com>
References: <cover.1664834225.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the EPC pages assigned to KVM guests cannot be reclaimed, so
there's no point to run the reclaimer when the native SGX driver is not
enabled.

Add a function to indicate whether the native SGX driver has been
initialized, and in ksgxd(), avoid running the reclaimer when it is
false.

In sgx_drv_init(), move the register of "/dev/sgx_enclave" misc device
before initializing sgx_attributes_reserved_mask (and the other two
masks) so that the new function can just use it to determine whether the
SGX driver has been initialized w/o introducing a new boolean.

Signed-off-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/kernel/cpu/sgx/driver.c | 13 +++++++++----
 arch/x86/kernel/cpu/sgx/driver.h |  1 +
 arch/x86/kernel/cpu/sgx/main.c   | 11 ++++++++++-
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
index aa9b8b868867..b5e754632eed 100644
--- a/arch/x86/kernel/cpu/sgx/driver.c
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -160,6 +160,10 @@ int __init sgx_drv_init(void)
 		return -ENODEV;
 	}
 
+	ret = misc_register(&sgx_dev_enclave);
+	if (ret)
+		return ret;
+
 	sgx_misc_reserved_mask = ~ebx | SGX_MISC_RESERVED_MASK;
 
 	cpuid_count(SGX_CPUID, 1, &eax, &ebx, &ecx, &edx);
@@ -172,9 +176,10 @@ int __init sgx_drv_init(void)
 		sgx_xfrm_reserved_mask = ~xfrm_mask;
 	}
 
-	ret = misc_register(&sgx_dev_enclave);
-	if (ret)
-		return ret;
-
 	return 0;
 }
+
+bool sgx_drv_inited(void)
+{
+	return !!sgx_attributes_reserved_mask;
+}
diff --git a/arch/x86/kernel/cpu/sgx/driver.h b/arch/x86/kernel/cpu/sgx/driver.h
index 4eddb4d571ef..159cc066e9cb 100644
--- a/arch/x86/kernel/cpu/sgx/driver.h
+++ b/arch/x86/kernel/cpu/sgx/driver.h
@@ -25,5 +25,6 @@ extern const struct file_operations sgx_provision_fops;
 long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg);
 
 int sgx_drv_init(void);
+bool sgx_drv_inited(void);
 
 #endif /* __ARCH_X86_SGX_DRIVER_H__ */
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 713ca09f6d6e..0fdbc490b0f8 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -403,6 +403,14 @@ static int ksgxd(void *p)
 	__sgx_sanitize_pages(&sgx_dirty_page_list);
 	WARN_ON(__sgx_sanitize_pages(&sgx_dirty_page_list));
 
+	/*
+	 * EPC pages assigned to KVM guests cannot be reclaimed.  There's
+	 * no reason to run the reclaimer if the native SGX driver isn't
+	 * initialized successfully (i.e. on the machines w/o SGX_LC).
+	 */
+	if (!sgx_drv_inited())
+		return 0;
+
 	while (!kthread_should_stop()) {
 		if (try_to_freeze())
 			continue;
@@ -940,7 +948,8 @@ static int __init sgx_init(void)
 		ksgxd_tsk = NULL;
 		__sgx_sanitize_pages(&sgx_dirty_page_list);
 		WARN_ON(__sgx_sanitize_pages(&sgx_dirty_page_list));
-		pr_info("Running SGX w/o EPC page reclaimer.\n");
+		if (sgx_drv_inited())
+			pr_info("Running native SGX driver w/o EPC page reclaimer.\n");
 	}
 
 	return 0;
-- 
2.37.1

