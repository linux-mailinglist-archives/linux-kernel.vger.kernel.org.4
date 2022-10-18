Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A71603624
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiJRWn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJRWnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:43:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC212B7EFB;
        Tue, 18 Oct 2022 15:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666133002; x=1697669002;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zWvHJetWpppRStA6AG4OaC92ypSl7IYvhj8e+oaUAaQ=;
  b=Thnu00hbPhYD3IoDfZb2W00AB0MnQOhz0vFgBN3ZqOdrVYIqgX0LGJZ4
   vJ9meUL4tTkzD2qoeYCn0eCT5EwwZGKgTCarzkYjRjiuGq3YfsRiXuZec
   4t6QZTYvuKZv4Ne5tovgJ44yiqHxcQRSw/yJtmCl1o+scQfy33iA7/HJJ
   Awr7h0nJ0ALUlvUQrHk2YgPevyPuO+aeBUlfpw88fDVY/SZvV124D6TIc
   z9ClYv1A/LoQaVZjms33sEAtdHf8GGfgut162JWjW7pfdOfC4DHhFRcMC
   kO+qH4QDAr4ekol0hG1Ves2UJh+zAmUXyirCv8Q2uUzu+ewoDPWQ1MZz0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="332798221"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="332798221"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 15:43:22 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="771453683"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="771453683"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 15:43:21 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org,
        md.iqbal.hossain@intel.com, haitao.huang@intel.com,
        linux-sgx@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86/sgx: Reduce delay and interference of enclave release
Date:   Tue, 18 Oct 2022 15:42:47 -0700
Message-Id: <06a5f478d3bfaa57954954c82dd5d4040450171d.1666130846.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 8795359e35bc ("x86/sgx: Silence softlockup detection when
releasing large enclaves") introduced a cond_resched() during enclave
release where the EREMOVE instruction is applied to every 4k enclave
page. Giving other tasks an opportunity to run while tearing down a
large enclave placates the soft lockup detector but Iqbal found
that the fix causes a 25% performance degradation of a workload
run using Gramine.

Gramine maintains a 1:1 mapping between processes and SGX enclaves.
That means if a workload in an enclave creates a subprocess then
Gramine creates a duplicate enclave for that subprocess to run in.
The consequence is that the release of the enclave used to run
the subprocess can impact the performance of the workload that is
run in the original enclave, especially in large enclaves when
SGX2 is not in use.

The workload run by Iqbal behaves as follows:
Create enclave (enclave "A")
/* Initialize workload in enclave "A" */
Create enclave (enclave "B")
/* Run subprocess in enclave "B" and send result to enclave "A" */
Release enclave (enclave "B")
/* Run workload in enclave "A" */
Release enclave (enclave "A")

The performance impact of releasing enclave "B" in the above scenario
is amplified when there is a lot of SGX memory and the enclave size
matches the SGX memory. When there is 128GB SGX memory and an enclave
size of 128GB, from the time enclave "B" starts the 128GB SGX memory
is oversubscribed with a combined demand for 256GB from the two
enclaves.

Before commit 8795359e35bc ("x86/sgx: Silence softlockup detection when
releasing large enclaves") enclave release was done in a tight loop
without giving other tasks a chance to run. Even though the system
experienced soft lockups the workload (run in enclave "A") obtained
good performance numbers because when the workload started running
there was no interference.

Commit 8795359e35bc ("x86/sgx: Silence softlockup detection when
releasing large enclaves") gave other tasks opportunity to run while an
enclave is released. The impact of this in this scenario is that while
enclave "B" is released and needing to access each page that belongs
to it in order to run the SGX EREMOVE instruction on it, enclave "A"
is attempting to run the workload needing to access the enclave
pages that belong to it. This causes a lot of swapping due to the
demand for the oversubscribed SGX memory. Longer latencies are
experienced by the workload in enclave "A" while enclave "B" is
released.

Improve the performance of enclave release while still avoiding the
soft lockup detector with two enhancements:
- Only call cond_resched() after XA_CHECK_SCHED iterations.
- Use the xarray advanced API to keep the xarray locked for
  XA_CHECK_SCHED iterations instead of locking and unlocking
  at every iteration.

This batching solution is copied from sgx_encl_may_map() that
also iterates through all enclave pages using this technique.

With this enhancement the workload experiences a 5%
performance degradation when compared to a kernel without
commit 8795359e35bc ("x86/sgx: Silence softlockup detection when
releasing large enclaves"), an improvement to the reported 25%
degradation, while still placating the soft lockup detector.

Scenarios with poor performance are still possible even with these
enhancements. For example, short workloads creating sub processes
while running in large enclaves. Further performance improvements
are pursued in user space through avoiding to create duplicate enclaves
for certain sub processes, and using SGX2 that will do lazy allocation
of pages as needed so enclaves created for sub processes start quickly
and release quickly.

Fixes: 8795359e35bc ("x86/sgx: Silence softlockup detection when releasing large enclaves")
Reported-by: Md Iqbal Hossain <md.iqbal.hossain@intel.com>
Tested-by: Md Iqbal Hossain <md.iqbal.hossain@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---

I do not know if this qualifies as stable material.

 arch/x86/kernel/cpu/sgx/encl.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 1ec20807de1e..f7365c278525 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -682,9 +682,12 @@ void sgx_encl_release(struct kref *ref)
 	struct sgx_encl *encl = container_of(ref, struct sgx_encl, refcount);
 	struct sgx_va_page *va_page;
 	struct sgx_encl_page *entry;
-	unsigned long index;
+	unsigned long count = 0;
+
+	XA_STATE(xas, &encl->page_array, PFN_DOWN(encl->base));
 
-	xa_for_each(&encl->page_array, index, entry) {
+	xas_lock(&xas);
+	xas_for_each(&xas, entry, PFN_DOWN(encl->base + encl->size  - 1)) {
 		if (entry->epc_page) {
 			/*
 			 * The page and its radix tree entry cannot be freed
@@ -699,9 +702,20 @@ void sgx_encl_release(struct kref *ref)
 		}
 
 		kfree(entry);
-		/* Invoke scheduler to prevent soft lockups. */
-		cond_resched();
+		/*
+		 * Invoke scheduler on every XA_CHECK_SCHED iteration
+		 * to prevent soft lockups.
+		 */
+		if (!(++count % XA_CHECK_SCHED)) {
+			xas_pause(&xas);
+			xas_unlock(&xas);
+
+			cond_resched();
+
+			xas_lock(&xas);
+		}
 	}
+	xas_unlock(&xas);
 
 	xa_destroy(&encl->page_array);
 
-- 
2.34.1

