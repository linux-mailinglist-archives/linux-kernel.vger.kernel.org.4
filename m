Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BE0683504
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjAaSS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjAaSS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:18:26 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF612BF23
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:18:25 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id az7-20020a056a02004700b004ec117e57cfso2264112pgb.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pgKsZ0Bh25hFzhxXEJXQv/JsnUoHDVhjIiyIEzL41Jo=;
        b=Z2g50fe+CPZFO8tMIw/E1VLxD/KIRZsbBWBSJkEePWsRp8qIJl6CfO9RIXcHppw0xO
         L7tmqW9D1Et7+msz1GbU6hW2yP+8u0uN8lKgY1QkAl5qtAP+jtZ/lWnRpsXOYG/HbrUf
         EQPAeJwJxzrJNVgjd723NayafHeUco/ZKhLANbbCmL/+x94unnQg4DRrIySQQ2c/dcmn
         LT6P0NTkr5KKRrZIbsKX2rRAZf/ctRYzibrF7Pi0nbIh8yYj8PcbV1K6B0mdd3miU81K
         WUaXRmc/6Su7QKYv9b7bXRuS7EJZ6hO/aF0Ft2R4uyzrslddQSLFkwnVjap/Dp1a/j5J
         sb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pgKsZ0Bh25hFzhxXEJXQv/JsnUoHDVhjIiyIEzL41Jo=;
        b=YKgkuildD3L24PzQW7iujOjChMRIXhrSYVcDQXoGRupkjOWB7EKiOwg+jTM2UTTzqP
         iW8C0MmvbRPeMCEHnEup2ri//bDyjs2UAT/dP33O+Ufxgk5ZY8EF1qwrlLyiAvKH+wA6
         zPHBM/Ehm0d3045o8g7BQzdvm62shzrrxzGMpSYF40CrU0jrB0JyCxv/u5FHux9b6Lpu
         /pddh3q8lKEhTnRzPCDDxCu4dcmWx1QqPUaBAJwAvcsFh8FbnFepviv5pDm/PEWzZXx8
         jXhvC+09vMdjisDkdb70Z0MMDvxPSos5ado6mmHzngmiOLmv5+FC7m7Jfc/ya3rt9Czs
         idYQ==
X-Gm-Message-State: AFqh2kpgMCNzEqQrs8pfqTbg8KfHH75vxpeVSstswhDxULRQf25R4u35
        To1Cf7tkwC52mqszIpWUfY0Lu0Cs5eGINKpJpqOAzRHM1nFS/DJ2Y6p15fCRe7+kGZBEkj3d6XT
        lHKIqvtaIuK06lFBFaEvjSPM4/gLVmcy+/3IDzQoV2q3APPIwnj23/3yeRpUF0PA+Zxi0p0tA
X-Google-Smtp-Source: AMrXdXt2mgvQk+ozaOnEaWBZ++pO4SrDZ9D7gvElphQShUHl5v6pQijVXHnc6yt3xPyBTQR4wKS3To/7osiF
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a62:1989:0:b0:58d:ae61:c14b with SMTP id
 131-20020a621989000000b0058dae61c14bmr6820820pfz.51.1675189105091; Tue, 31
 Jan 2023 10:18:25 -0800 (PST)
Date:   Tue, 31 Jan 2023 18:18:19 +0000
In-Reply-To: <20230131181820.179033-1-bgardon@google.com>
Mime-Version: 1.0
References: <20230131181820.179033-1-bgardon@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230131181820.179033-2-bgardon@google.com>
Subject: [PATCH V5 1/2] selftests: KVM: Move dirty logging functions to memstress.(c|h)
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move some helper functions from dirty_log_perf_test.c to the memstress
library so that they can be used in a future commit which tests page
splitting during dirty logging.

Reviewed-by: Vipin Sharma <vipinsh@google.com>

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../selftests/kvm/dirty_log_perf_test.c       | 84 ++-----------------
 .../testing/selftests/kvm/include/memstress.h |  8 ++
 tools/testing/selftests/kvm/lib/memstress.c   | 72 ++++++++++++++++
 3 files changed, 87 insertions(+), 77 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index e9d6d1aecf89c..416719e205183 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -136,77 +136,6 @@ struct test_params {
 	bool random_access;
 };
 
-static void toggle_dirty_logging(struct kvm_vm *vm, int slots, bool enable)
-{
-	int i;
-
-	for (i = 0; i < slots; i++) {
-		int slot = MEMSTRESS_MEM_SLOT_INDEX + i;
-		int flags = enable ? KVM_MEM_LOG_DIRTY_PAGES : 0;
-
-		vm_mem_region_set_flags(vm, slot, flags);
-	}
-}
-
-static inline void enable_dirty_logging(struct kvm_vm *vm, int slots)
-{
-	toggle_dirty_logging(vm, slots, true);
-}
-
-static inline void disable_dirty_logging(struct kvm_vm *vm, int slots)
-{
-	toggle_dirty_logging(vm, slots, false);
-}
-
-static void get_dirty_log(struct kvm_vm *vm, unsigned long *bitmaps[], int slots)
-{
-	int i;
-
-	for (i = 0; i < slots; i++) {
-		int slot = MEMSTRESS_MEM_SLOT_INDEX + i;
-
-		kvm_vm_get_dirty_log(vm, slot, bitmaps[i]);
-	}
-}
-
-static void clear_dirty_log(struct kvm_vm *vm, unsigned long *bitmaps[],
-			    int slots, uint64_t pages_per_slot)
-{
-	int i;
-
-	for (i = 0; i < slots; i++) {
-		int slot = MEMSTRESS_MEM_SLOT_INDEX + i;
-
-		kvm_vm_clear_dirty_log(vm, slot, bitmaps[i], 0, pages_per_slot);
-	}
-}
-
-static unsigned long **alloc_bitmaps(int slots, uint64_t pages_per_slot)
-{
-	unsigned long **bitmaps;
-	int i;
-
-	bitmaps = malloc(slots * sizeof(bitmaps[0]));
-	TEST_ASSERT(bitmaps, "Failed to allocate bitmaps array.");
-
-	for (i = 0; i < slots; i++) {
-		bitmaps[i] = bitmap_zalloc(pages_per_slot);
-		TEST_ASSERT(bitmaps[i], "Failed to allocate slot bitmap.");
-	}
-
-	return bitmaps;
-}
-
-static void free_bitmaps(unsigned long *bitmaps[], int slots)
-{
-	int i;
-
-	for (i = 0; i < slots; i++)
-		free(bitmaps[i]);
-
-	free(bitmaps);
-}
-
 static void run_test(enum vm_guest_mode mode, void *arg)
 {
 	struct test_params *p = arg;
@@ -236,7 +165,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	host_num_pages = vm_num_host_pages(mode, guest_num_pages);
 	pages_per_slot = host_num_pages / p->slots;
 
-	bitmaps = alloc_bitmaps(p->slots, pages_per_slot);
+	bitmaps = memstress_alloc_bitmaps(p->slots, pages_per_slot);
 
 	if (dirty_log_manual_caps)
 		vm_enable_cap(vm, KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2,
@@ -277,7 +206,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	/* Enable dirty logging */
 	clock_gettime(CLOCK_MONOTONIC, &start);
-	enable_dirty_logging(vm, p->slots);
+	memstress_enable_dirty_logging(vm, p->slots);
 	ts_diff = timespec_elapsed(start);
 	pr_info("Enabling dirty logging time: %ld.%.9lds\n\n",
 		ts_diff.tv_sec, ts_diff.tv_nsec);
@@ -306,7 +235,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 			iteration, ts_diff.tv_sec, ts_diff.tv_nsec);
 
 		clock_gettime(CLOCK_MONOTONIC, &start);
-		get_dirty_log(vm, bitmaps, p->slots);
+		memstress_get_dirty_log(vm, bitmaps, p->slots);
 		ts_diff = timespec_elapsed(start);
 		get_dirty_log_total = timespec_add(get_dirty_log_total,
 						   ts_diff);
@@ -315,7 +244,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 		if (dirty_log_manual_caps) {
 			clock_gettime(CLOCK_MONOTONIC, &start);
-			clear_dirty_log(vm, bitmaps, p->slots, pages_per_slot);
+			memstress_clear_dirty_log(vm, bitmaps, p->slots,
+						  pages_per_slot);
 			ts_diff = timespec_elapsed(start);
 			clear_dirty_log_total = timespec_add(clear_dirty_log_total,
 							     ts_diff);
@@ -334,7 +264,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	/* Disable dirty logging */
 	clock_gettime(CLOCK_MONOTONIC, &start);
-	disable_dirty_logging(vm, p->slots);
+	memstress_disable_dirty_logging(vm, p->slots);
 	ts_diff = timespec_elapsed(start);
 	pr_info("Disabling dirty logging time: %ld.%.9lds\n",
 		ts_diff.tv_sec, ts_diff.tv_nsec);
@@ -359,7 +289,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 			clear_dirty_log_total.tv_nsec, avg.tv_sec, avg.tv_nsec);
 	}
 
-	free_bitmaps(bitmaps, p->slots);
+	memstress_free_bitmaps(bitmaps, p->slots);
 	arch_cleanup_vm(vm);
 	memstress_destroy_vm(vm);
 }
diff --git a/tools/testing/selftests/kvm/include/memstress.h b/tools/testing/selftests/kvm/include/memstress.h
index 72e3e358ef7bd..ce4e603050eaa 100644
--- a/tools/testing/selftests/kvm/include/memstress.h
+++ b/tools/testing/selftests/kvm/include/memstress.h
@@ -72,4 +72,12 @@ void memstress_guest_code(uint32_t vcpu_id);
 uint64_t memstress_nested_pages(int nr_vcpus);
 void memstress_setup_nested(struct kvm_vm *vm, int nr_vcpus, struct kvm_vcpu *vcpus[]);
 
+void memstress_enable_dirty_logging(struct kvm_vm *vm, int slots);
+void memstress_disable_dirty_logging(struct kvm_vm *vm, int slots);
+void memstress_get_dirty_log(struct kvm_vm *vm, unsigned long *bitmaps[], int slots);
+void memstress_clear_dirty_log(struct kvm_vm *vm, unsigned long *bitmaps[],
+			       int slots, uint64_t pages_per_slot);
+unsigned long **memstress_alloc_bitmaps(int slots, uint64_t pages_per_slot);
+void memstress_free_bitmaps(unsigned long *bitmaps[], int slots);
+
 #endif /* SELFTEST_KVM_MEMSTRESS_H */
diff --git a/tools/testing/selftests/kvm/lib/memstress.c b/tools/testing/selftests/kvm/lib/memstress.c
index 5f1d3173c238c..3632956c6bcf5 100644
--- a/tools/testing/selftests/kvm/lib/memstress.c
+++ b/tools/testing/selftests/kvm/lib/memstress.c
@@ -5,6 +5,7 @@
 #define _GNU_SOURCE
 
 #include <inttypes.h>
+#include <linux/bitmap.h>
 
 #include "kvm_util.h"
 #include "memstress.h"
@@ -320,3 +321,74 @@ void memstress_join_vcpu_threads(int nr_vcpus)
 	for (i = 0; i < nr_vcpus; i++)
 		pthread_join(vcpu_threads[i].thread, NULL);
 }
+
+static void toggle_dirty_logging(struct kvm_vm *vm, int slots, bool enable)
+{
+	int i;
+
+	for (i = 0; i < slots; i++) {
+		int slot = MEMSTRESS_MEM_SLOT_INDEX + i;
+		int flags = enable ? KVM_MEM_LOG_DIRTY_PAGES : 0;
+
+		vm_mem_region_set_flags(vm, slot, flags);
+	}
+}
+
+void memstress_enable_dirty_logging(struct kvm_vm *vm, int slots)
+{
+	toggle_dirty_logging(vm, slots, true);
+}
+
+void memstress_disable_dirty_logging(struct kvm_vm *vm, int slots)
+{
+	toggle_dirty_logging(vm, slots, false);
+}
+
+void memstress_get_dirty_log(struct kvm_vm *vm, unsigned long *bitmaps[], int slots)
+{
+	int i;
+
+	for (i = 0; i < slots; i++) {
+		int slot = MEMSTRESS_MEM_SLOT_INDEX + i;
+
+		kvm_vm_get_dirty_log(vm, slot, bitmaps[i]);
+	}
+}
+
+void memstress_clear_dirty_log(struct kvm_vm *vm, unsigned long *bitmaps[],
+			       int slots, uint64_t pages_per_slot)
+{
+	int i;
+
+	for (i = 0; i < slots; i++) {
+		int slot = MEMSTRESS_MEM_SLOT_INDEX + i;
+
+		kvm_vm_clear_dirty_log(vm, slot, bitmaps[i], 0, pages_per_slot);
+	}
+}
+
+unsigned long **memstress_alloc_bitmaps(int slots, uint64_t pages_per_slot)
+{
+	unsigned long **bitmaps;
+	int i;
+
+	bitmaps = malloc(slots * sizeof(bitmaps[0]));
+	TEST_ASSERT(bitmaps, "Failed to allocate bitmaps array.");
+
+	for (i = 0; i < slots; i++) {
+		bitmaps[i] = bitmap_zalloc(pages_per_slot);
+		TEST_ASSERT(bitmaps[i], "Failed to allocate slot bitmap.");
+	}
+
+	return bitmaps;
+}
+
+void memstress_free_bitmaps(unsigned long *bitmaps[], int slots)
+{
+	int i;
+
+	for (i = 0; i < slots; i++)
+		free(bitmaps[i]);
+
+	free(bitmaps);
+}
-- 
2.39.1.456.gfc5497dd1b-goog

