Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9749B613F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiJaUpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJaUpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:45:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49F1DF65;
        Mon, 31 Oct 2022 13:45:02 -0700 (PDT)
Date:   Mon, 31 Oct 2022 20:44:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667249100;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XkDdGu72/P40astMLGgkv09ig0AakkD+rRXnY9q8B1M=;
        b=E5uS4jAOQJx1nnAbdA1bYBIDsIbhVVtVH4SGAqZ10yeAk6kov5r4MMsKEBN9hBcl+S6Yux
        0jOj1PdavRh4Tv95Li16e2RQurEextr3bD9V8lYWeqCxZ4PzioaGH141PrDyN7rSYEPD+i
        uJBVzME0LGXdohA0N96hKvHkzC6FFDlyPxbW2ujqaFprCbIaPvbXrFQ/i+IGm7W7RUajVM
        ydCFSQW5b7AeyYq4GNQDIcPCgVynmr8CX4UtjlsL1gM2/iYEbA9ACNOoeI7V2sURasSH2V
        6KJu/LMMc7/iPzGG/ExRWn7Tl4aSjPtWLqlHGKADKw7g6d2Em4MqQH8X+ysM/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667249100;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XkDdGu72/P40astMLGgkv09ig0AakkD+rRXnY9q8B1M=;
        b=oI96AXTdJQxnYfCj3hfVbTTVvEk+3NOXBGp6BH5kT7HSbeS6BXeY/38zg9Y4w6FI9TGMQc
        OX3dmSwFfiDnqpAQ==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Reduce delay and interference of enclave release
Cc:     Md Iqbal Hossain <md.iqbal.hossain@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166724909921.7716.18230627806708514201.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     7b72c823ddf8aaaec4e9fb28e6fbe4d511e7dad1
Gitweb:        https://git.kernel.org/tip/7b72c823ddf8aaaec4e9fb28e6fbe4d511e7dad1
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Mon, 31 Oct 2022 10:29:58 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 31 Oct 2022 13:40:35 -07:00

x86/sgx: Reduce delay and interference of enclave release

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
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Md Iqbal Hossain <md.iqbal.hossain@intel.com>
Link: https://lore.kernel.org/all/00efa80dd9e35dc85753e1c5edb0344ac07bb1f0.1667236485.git.reinette.chatre%40intel.com
---
 arch/x86/kernel/cpu/sgx/encl.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 1ec2080..2c25825 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -680,11 +680,15 @@ const struct vm_operations_struct sgx_vm_ops = {
 void sgx_encl_release(struct kref *ref)
 {
 	struct sgx_encl *encl = container_of(ref, struct sgx_encl, refcount);
+	unsigned long max_page_index = PFN_DOWN(encl->base + encl->size - 1);
 	struct sgx_va_page *va_page;
 	struct sgx_encl_page *entry;
-	unsigned long index;
+	unsigned long count = 0;
+
+	XA_STATE(xas, &encl->page_array, PFN_DOWN(encl->base));
 
-	xa_for_each(&encl->page_array, index, entry) {
+	xas_lock(&xas);
+	xas_for_each(&xas, entry, max_page_index) {
 		if (entry->epc_page) {
 			/*
 			 * The page and its radix tree entry cannot be freed
@@ -699,9 +703,20 @@ void sgx_encl_release(struct kref *ref)
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
 
