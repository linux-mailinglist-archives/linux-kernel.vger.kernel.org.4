Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2A85F3895
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 00:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiJCWEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 18:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJCWEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:04:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02FC5F89;
        Mon,  3 Oct 2022 15:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664834681; x=1696370681;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b2TVdQR0wcN0WlAJV+kk7tAVgQKAON4eNa7JV7pnZQ0=;
  b=GRgAwq75bhTOSDcMl76lSGcDRcEdpS7yUoLe80owFuZ+KlALvXs08FvH
   tRMzQpqWsCu8q7Igm6xvVOYuFNBwTWPUihOIqOFmW+zp/1ka2CZCml+c/
   jTvayAQV4Z+zH3wcudIANez9NPseIt4hq/oE8iOhn7WrxmatUs5i9GI7s
   pasOl6140mqwh70BRaPejPMEhmIOKxRhaGWmGD3V2lVqB1FJVPXn61O+p
   PBeIrs6bqWynzBz61Bjp4cnPN2Xk+Sxn1ZPyrrSka3foamUJTDfv8ccJ9
   ne4tEvzwL4z3ofgOblvV/4aQjjD/N3ZBYVIilCzv+l+KdSjDMp6ny1RIY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="366869169"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="366869169"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 15:04:40 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="686310953"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="686310953"
Received: from jparcemo-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.93.75])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 15:04:39 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     linux-sgx@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, jarkko@kernel.org,
        tony.luck@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] x86/sgx: Start the ksgxd() at the end of sgx_init()
Date:   Tue,  4 Oct 2022 11:04:27 +1300
Message-Id: <94169ef79db0695d7b42d2a78565e8dceb64cf3e.1664834225.git.kai.huang@intel.com>
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

The ksgxd() kernel thread basically does two things: 1) sanitize all EPC
pages; 2) start the page reclaimer.  Currently it is created and started
before initializing both the native SGX driver and the KVM driver, but
there's no reason to do that.  It only needs to be started when at least
one of the native and the KVM driver has been initialized.

Move creating and running the ksgxd() to the end of sgx_init() after at
least one of the native and the KVM driver has been initialized.  Also,
when kernel fails to create the ksgxd(), opportunistically improve the
behaviour to not disable SGX completely, but to continue to sanitize EPC
pages and run w/o reclaimer.  This allows SGX to continue to work when
kernel is not running out of EPC (this is especially reasonable for KVM
virtual EPC driver as virtual EPC pages cannot be reclaimed anyway).

With above change, just remove the sgx_page_reclaimer_init() and open
code its logic at the end of sgx_init() as this way is more clear.

Signed-off-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 41 ++++++++++++++++------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 0aad028f04d4..713ca09f6d6e 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -420,19 +420,6 @@ static int ksgxd(void *p)
 	return 0;
 }
 
-static bool __init sgx_page_reclaimer_init(void)
-{
-	struct task_struct *tsk;
-
-	tsk = kthread_run(ksgxd, NULL, "ksgxd");
-	if (IS_ERR(tsk))
-		return false;
-
-	ksgxd_tsk = tsk;
-
-	return true;
-}
-
 bool current_is_ksgxd(void)
 {
 	return current == ksgxd_tsk;
@@ -921,14 +908,9 @@ static int __init sgx_init(void)
 	if (!sgx_page_cache_init())
 		return -ENOMEM;
 
-	if (!sgx_page_reclaimer_init()) {
-		ret = -ENOMEM;
-		goto err_page_cache;
-	}
-
 	ret = misc_register(&sgx_dev_provision);
 	if (ret)
-		goto err_kthread;
+		goto err_page_cache;
 
 	/*
 	 * Always try to initialize the native *and* KVM drivers.
@@ -943,14 +925,29 @@ static int __init sgx_init(void)
 	if (sgx_vepc_init() && ret)
 		goto err_provision;
 
+	/*
+	 * At least one of the native and the KVM driver has been
+	 * initialized.  Start the ksgxd().
+	 */
+	ksgxd_tsk = kthread_run(ksgxd, NULL, "ksgxd");
+
+	/*
+	 * If unable to create the ksgxd() thread, don't disable
+	 * SGX completely.  Instead, continue to sanitize all EPC
+	 * pages and run w/o reclaimer.
+	 */
+	if (IS_ERR(ksgxd_tsk)) {
+		ksgxd_tsk = NULL;
+		__sgx_sanitize_pages(&sgx_dirty_page_list);
+		WARN_ON(__sgx_sanitize_pages(&sgx_dirty_page_list));
+		pr_info("Running SGX w/o EPC page reclaimer.\n");
+	}
+
 	return 0;
 
 err_provision:
 	misc_deregister(&sgx_dev_provision);
 
-err_kthread:
-	kthread_stop(ksgxd_tsk);
-
 err_page_cache:
 	for (i = 0; i < sgx_nr_epc_sections; i++) {
 		vfree(sgx_epc_sections[i].pages);
-- 
2.37.1

