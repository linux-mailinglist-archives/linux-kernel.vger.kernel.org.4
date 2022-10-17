Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA48A601358
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJQQY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJQQYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:24:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA1E24BE5;
        Mon, 17 Oct 2022 09:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666023893; x=1697559893;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4R89BSmAMFrRQ1rbp8RHr7lLvOERqv6UEHJTCyKVdZY=;
  b=hSJawlH68KFODyuv2R8mU3t6XnUfDY8tFARj4kx55Mh4sOkvGI2mu6jf
   eKhJO1JOka9cA4L4Z6zGUCH+s7luXCK4uKtcsQF53SnHvJuYKecn4gint
   d7fXQtE1XZVeHBEeobxlY844VKZpr9TFRt6rJSnCOfkvJ8jZnN/yQpD+j
   dqDSaWq0qZzZq0xj9h68Bt4Y0WWU0jxDsC6IEuOokYQut7KR53wPu5m6Z
   X2AAayJ7OPa4wi7b/JZ+4zgKDyV7DTNVEMlV20IbX7bl8M/bUJvUUtEsI
   xsAxLcOmhk3paI76Vw1Jf9ACmCtG+XTUg+zgt+D/nJteoC+mixia1W//N
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="367873200"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="367873200"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 09:24:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="733220984"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="733220984"
Received: from tdx-lm.sh.intel.com ([10.239.53.27])
  by fmsmga002.fm.intel.com with ESMTP; 17 Oct 2022 09:24:50 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     seanjc@google.com, pbonzini@redhat.com
Cc:     dmatlack@google.com, vipinsh@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v1] KVM: selftests: name the threads
Date:   Tue, 18 Oct 2022 00:24:48 +0800
Message-Id: <20221017162448.257173-1-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Name the threads to facilitate debugging, performance tuning,
runtime pining etc. pthread_create_with_name is used to create
general threads with user specified name, and kvm_vcpu_thread_create
is used to create vcpu threads with name in "vcpu##id" format.

An example is shown below reported from "top". With naming the
vcpu threads, the per-vcpu info becomes more noticeable.

PID  USER PR  NI VIRT    RES  SHR  S  %CPU  %MEM TIME+   COMMAND
4464 root 20  0  4248684 4.0g 1628 R  99.9  26.2 0:50.97 dirty_log_perf_
4467 root 20  0  4248684 4.0g 1628 R  99.9  26.2 0:50.93 vcpu0
4469 root 20  0  4248684 4.0g 1628 R  99.9  26.2 0:50.93 vcpu2
4470 root 20  0  4248684 4.0g 1628 R  99.9  26.2 0:50.94 vcpu3
4468 root 20  0  4248684 4.0g 1628 R  99.7  26.2 0:50.93 vcpu1

pthread.h is included in kvm_util.h, so remove it from the files
that have already included kvm_util.h.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 .../selftests/kvm/aarch64/arch_timer.c        | 16 ++-----
 .../selftests/kvm/access_tracking_perf_test.c |  1 -
 .../selftests/kvm/demand_paging_test.c        |  5 +-
 .../selftests/kvm/dirty_log_perf_test.c       |  1 -
 tools/testing/selftests/kvm/dirty_log_test.c  |  2 +-
 .../selftests/kvm/hardware_disable_test.c     | 17 ++-----
 .../testing/selftests/kvm/include/kvm_util.h  |  8 ++++
 .../selftests/kvm/include/perf_test_util.h    |  2 -
 .../selftests/kvm/kvm_page_table_test.c       |  5 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 47 +++++++++++++++++++
 .../selftests/kvm/lib/perf_test_util.c        |  3 +-
 .../selftests/kvm/max_guest_memory_test.c     |  4 +-
 .../kvm/memslot_modification_stress_test.c    |  1 -
 .../testing/selftests/kvm/memslot_perf_test.c |  3 +-
 tools/testing/selftests/kvm/rseq_test.c       |  5 +-
 .../selftests/kvm/set_memory_region_test.c    |  3 +-
 tools/testing/selftests/kvm/steal_time.c      |  4 +-
 .../selftests/kvm/x86_64/mmio_warning_test.c  |  3 +-
 .../selftests/kvm/x86_64/sev_migrate_tests.c  |  1 -
 .../selftests/kvm/x86_64/tsc_scaling_sync.c   |  4 +-
 .../kvm/x86_64/ucna_injection_test.c          |  1 -
 .../selftests/kvm/x86_64/xapic_ipi_test.c     | 10 ++--
 22 files changed, 85 insertions(+), 61 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
index 574eb73f0e90..14f56327ca28 100644
--- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
+++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
@@ -23,7 +23,6 @@
 #define _GNU_SOURCE
 
 #include <stdlib.h>
-#include <pthread.h>
 #include <linux/kvm.h>
 #include <linux/sizes.h>
 #include <linux/bitmap.h>
@@ -314,28 +313,23 @@ static void test_run(struct kvm_vm *vm)
 {
 	pthread_t pt_vcpu_migration;
 	unsigned int i;
-	int ret;
 
 	pthread_mutex_init(&vcpu_done_map_lock, NULL);
 	vcpu_done_map = bitmap_zalloc(test_args.nr_vcpus);
 	TEST_ASSERT(vcpu_done_map, "Failed to allocate vcpu done bitmap\n");
 
-	for (i = 0; i < (unsigned long)test_args.nr_vcpus; i++) {
-		ret = pthread_create(&pt_vcpu_run[i], NULL, test_vcpu_run,
-				     (void *)(unsigned long)i);
-		TEST_ASSERT(!ret, "Failed to create vCPU-%d pthread\n", i);
-	}
+	for (i = 0; i < (unsigned long)test_args.nr_vcpus; i++)
+		kvm_create_vcpu_thread(&pt_vcpu_run[i], NULL,
+				test_vcpu_run, (void *)(unsigned long)i, i);
 
 	/* Spawn a thread to control the vCPU migrations */
 	if (test_args.migration_freq_ms) {
 		srand(time(NULL));
 
-		ret = pthread_create(&pt_vcpu_migration, NULL,
-					test_vcpu_migration, NULL);
-		TEST_ASSERT(!ret, "Failed to create the migration pthread\n");
+		pthread_create_with_name(&pt_vcpu_migration, NULL,
+				test_vcpu_migration, NULL, "control-thread");
 	}
 
-
 	for (i = 0; i < test_args.nr_vcpus; i++)
 		pthread_join(pt_vcpu_run[i], NULL);
 
diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
index 76c583a07ea2..b61ecc907d61 100644
--- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
+++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
@@ -37,7 +37,6 @@
  */
 #include <inttypes.h>
 #include <limits.h>
-#include <pthread.h>
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 779ae54f89c4..f75d531008e8 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -14,7 +14,6 @@
 #include <stdlib.h>
 #include <time.h>
 #include <poll.h>
-#include <pthread.h>
 #include <linux/userfaultfd.h>
 #include <sys/syscall.h>
 
@@ -260,8 +259,8 @@ static void setup_demand_paging(struct kvm_vm *vm,
 	uffd_args->uffd = uffd;
 	uffd_args->pipefd = pipefd;
 	uffd_args->delay = uffd_delay;
-	pthread_create(uffd_handler_thread, NULL, uffd_handler_thread_fn,
-		       uffd_args);
+	pthread_create_with_name(uffd_handler_thread, NULL,
+		uffd_handler_thread_fn, uffd_args, "uffd-handler-thread");
 
 	PER_VCPU_DEBUG("Created uffd thread for HVA range [%p, %p)\n",
 		       hva, hva + len);
diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index f99e39a672d3..5cf9080b3864 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -11,7 +11,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <pthread.h>
 #include <linux/bitmap.h>
 
 #include "kvm_util.h"
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index b5234d6efbe1..c7a30b4dd33a 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -772,7 +772,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	host_clear_count = 0;
 	host_track_next_count = 0;
 
-	pthread_create(&vcpu_thread, NULL, vcpu_worker, vcpu);
+	kvm_create_vcpu_thread(&vcpu_thread, NULL, vcpu_worker, vcpu, 0);
 
 	while (iteration < p->iterations) {
 		/* Give the vcpu thread some time to dirty some pages */
diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
index f5d59b9934f1..c22b8445a809 100644
--- a/tools/testing/selftests/kvm/hardware_disable_test.c
+++ b/tools/testing/selftests/kvm/hardware_disable_test.c
@@ -8,7 +8,6 @@
 #define _GNU_SOURCE
 
 #include <fcntl.h>
-#include <pthread.h>
 #include <semaphore.h>
 #include <stdint.h>
 #include <stdlib.h>
@@ -59,15 +58,6 @@ static void *sleeping_thread(void *arg)
 	pthread_exit(NULL);
 }
 
-static inline void check_create_thread(pthread_t *thread, pthread_attr_t *attr,
-				       void *(*f)(void *), void *arg)
-{
-	int r;
-
-	r = pthread_create(thread, attr, f, arg);
-	TEST_ASSERT(r == 0, "%s: failed to create thread", __func__);
-}
-
 static inline void check_set_affinity(pthread_t thread, cpu_set_t *cpu_set)
 {
 	int r;
@@ -104,12 +94,13 @@ static void run_test(uint32_t run)
 	for (i = 0; i < VCPU_NUM; ++i) {
 		vcpu = vm_vcpu_add(vm, i, guest_code);
 
-		check_create_thread(&threads[i], NULL, run_vcpu, vcpu);
+		kvm_create_vcpu_thread(&threads[i], NULL, run_vcpu, vcpu, i);
 		check_set_affinity(threads[i], &cpu_set);
 
 		for (j = 0; j < SLEEPING_THREAD_NUM; ++j) {
-			check_create_thread(&throw_away, NULL, sleeping_thread,
-					    (void *)NULL);
+			pthread_create_with_name(&throw_away, NULL,
+						 sleeping_thread, (void *)NULL,
+						 "sleeping-thread");
 			check_set_affinity(throw_away, &cpu_set);
 		}
 	}
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index c9286811a4cb..b7f0295d928e 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -7,7 +7,15 @@
 #ifndef SELFTEST_KVM_UTIL_H
 #define SELFTEST_KVM_UTIL_H
 
+#include <pthread.h>
+
 #include "kvm_util_base.h"
 #include "ucall_common.h"
 
+void pthread_create_with_name(pthread_t *thread, const pthread_attr_t *attr,
+			void *(*start_routine)(void *), void *arg, char *name);
+
+void kvm_create_vcpu_thread(pthread_t *thread, const pthread_attr_t *attr,
+		void *(*start_routine)(void *), void *arg, int vcpu_id);
+
 #endif /* SELFTEST_KVM_UTIL_H */
diff --git a/tools/testing/selftests/kvm/include/perf_test_util.h b/tools/testing/selftests/kvm/include/perf_test_util.h
index eaa88df0555a..cb6971c8740f 100644
--- a/tools/testing/selftests/kvm/include/perf_test_util.h
+++ b/tools/testing/selftests/kvm/include/perf_test_util.h
@@ -8,8 +8,6 @@
 #ifndef SELFTEST_KVM_PERF_TEST_UTIL_H
 #define SELFTEST_KVM_PERF_TEST_UTIL_H
 
-#include <pthread.h>
-
 #include "kvm_util.h"
 
 /* Default guest test virtual memory offset */
diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
index f42c6ac6d71d..1e41dca7f67d 100644
--- a/tools/testing/selftests/kvm/kvm_page_table_test.c
+++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
@@ -14,7 +14,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-#include <pthread.h>
 #include <semaphore.h>
 
 #include "test_util.h"
@@ -359,8 +358,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	*current_stage = KVM_BEFORE_MAPPINGS;
 
 	for (i = 0; i < nr_vcpus; i++)
-		pthread_create(&vcpu_threads[i], NULL, vcpu_worker,
-			       test_args.vcpus[i]);
+		kvm_create_vcpu_thread(&vcpu_threads[i], NULL,
+				       vcpu_worker, test_args.vcpus[i], i);
 
 	vcpus_complete_new_stage(*current_stage);
 	pr_info("Started all vCPUs successfully\n");
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index f1cb1627161f..c252c912f1ba 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2021,3 +2021,50 @@ void __vm_get_stat(struct kvm_vm *vm, const char *stat_name, uint64_t *data,
 		break;
 	}
 }
+
+/*
+ * Create a named thread
+ *
+ * Input Args:
+ *   attr - the attributes for the new thread
+ *   start_routine - the routine to run in the thread context
+ *   arg - the argument passed to start_routine
+ *   name - the name of the thread
+ *
+ * Output Args:
+ *   thread - the thread to be created
+ *
+ * Create a thread with user specified name.
+ */
+void pthread_create_with_name(pthread_t *thread, const pthread_attr_t *attr,
+			void *(*start_routine)(void *), void *arg, char *name)
+{
+	int r;
+
+	r = pthread_create(thread, attr, start_routine, arg);
+	TEST_ASSERT(!r, "thread(%s) creation failed, r = %d", name, r);
+	pthread_setname_np(*thread, name);
+}
+
+/*
+ * Create a vcpu thread
+ *
+ * Input Args:
+ *   attr - the attributes for the new thread
+ *   start_routine - the routine to run in the thread context
+ *   arg - the argument passed to start_routine
+ *   vcpu_id - the id of the vcpu
+ *
+ * Output Args:
+ *   thread - the thread to be created
+ *
+ * Create a vcpu thread with the name in "vcpu##id" format.
+ */
+void kvm_create_vcpu_thread(pthread_t *thread, const pthread_attr_t *attr,
+			void *(*start_routine)(void *), void *arg, int vcpu_id)
+{
+	char vcpu_name[6];
+
+	sprintf(vcpu_name, "%s%d", "vcpu", vcpu_id);
+	pthread_create_with_name(thread, attr, start_routine, arg, vcpu_name);
+}
diff --git a/tools/testing/selftests/kvm/lib/perf_test_util.c b/tools/testing/selftests/kvm/lib/perf_test_util.c
index 9618b37c66f7..4e57181daffc 100644
--- a/tools/testing/selftests/kvm/lib/perf_test_util.c
+++ b/tools/testing/selftests/kvm/lib/perf_test_util.c
@@ -274,7 +274,8 @@ void perf_test_start_vcpu_threads(int nr_vcpus,
 		vcpu->vcpu_idx = i;
 		WRITE_ONCE(vcpu->running, false);
 
-		pthread_create(&vcpu->thread, NULL, vcpu_thread_main, vcpu);
+		kvm_create_vcpu_thread(&vcpu->thread, NULL,
+				       vcpu_thread_main, vcpu, i);
 	}
 
 	for (i = 0; i < nr_vcpus; i++) {
diff --git a/tools/testing/selftests/kvm/max_guest_memory_test.c b/tools/testing/selftests/kvm/max_guest_memory_test.c
index 9a6e4f3ad6b5..04524694e2b6 100644
--- a/tools/testing/selftests/kvm/max_guest_memory_test.c
+++ b/tools/testing/selftests/kvm/max_guest_memory_test.c
@@ -3,7 +3,6 @@
 
 #include <stdio.h>
 #include <stdlib.h>
-#include <pthread.h>
 #include <semaphore.h>
 #include <sys/types.h>
 #include <signal.h>
@@ -110,7 +109,8 @@ static pthread_t *spawn_workers(struct kvm_vm *vm, struct kvm_vcpu **vcpus,
 		info[i].vcpu = vcpus[i];
 		info[i].start_gpa = gpa;
 		info[i].end_gpa = gpa + nr_bytes;
-		pthread_create(&threads[i], NULL, vcpu_worker, &info[i]);
+		kvm_create_vcpu_thread(&threads[i], NULL,
+				       vcpu_worker, &info[i], i);
 	}
 	return threads;
 }
diff --git a/tools/testing/selftests/kvm/memslot_modification_stress_test.c b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
index 6ee7e1dde404..769300181597 100644
--- a/tools/testing/selftests/kvm/memslot_modification_stress_test.c
+++ b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
@@ -16,7 +16,6 @@
 #include <asm/unistd.h>
 #include <time.h>
 #include <poll.h>
-#include <pthread.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/userfaultfd.h>
diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testing/selftests/kvm/memslot_perf_test.c
index 44995446d942..041a07acba3d 100644
--- a/tools/testing/selftests/kvm/memslot_perf_test.c
+++ b/tools/testing/selftests/kvm/memslot_perf_test.c
@@ -6,7 +6,6 @@
  *
  * Basic guest setup / host vCPU thread code lifted from set_memory_region_test.
  */
-#include <pthread.h>
 #include <sched.h>
 #include <semaphore.h>
 #include <stdatomic.h>
@@ -332,7 +331,7 @@ static void launch_vm(struct vm_data *data)
 {
 	pr_info_v("Launching the test VM\n");
 
-	pthread_create(&data->vcpu_thread, NULL, vcpu_worker, data);
+	kvm_create_vcpu_thread(&data->vcpu_thread, NULL, vcpu_worker, data, 0);
 
 	/* Ensure the guest thread is spun up. */
 	wait_for_vcpu();
diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index 6f88da7e60be..11e0b1b7abb1 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -2,7 +2,6 @@
 #define _GNU_SOURCE /* for program_invocation_short_name */
 #include <errno.h>
 #include <fcntl.h>
-#include <pthread.h>
 #include <sched.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -226,8 +225,8 @@ int main(int argc, char *argv[])
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 	ucall_init(vm, NULL);
 
-	pthread_create(&migration_thread, NULL, migration_worker,
-		       (void *)(unsigned long)syscall(SYS_gettid));
+	pthread_create_with_name(&migration_thread, NULL, migration_worker,
+	       (void *)(unsigned long)syscall(SYS_gettid), "migration-thread");
 
 	for (i = 0; !done; i++) {
 		vcpu_run(vcpu);
diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index 0d55f508d595..4c9ab5595a22 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE /* for program_invocation_short_name */
 #include <fcntl.h>
-#include <pthread.h>
 #include <sched.h>
 #include <semaphore.h>
 #include <signal.h>
@@ -134,7 +133,7 @@ static struct kvm_vm *spawn_vm(struct kvm_vcpu **vcpu, pthread_t *vcpu_thread,
 	hva = addr_gpa2hva(vm, MEM_REGION_GPA);
 	memset(hva, 0, 2 * 4096);
 
-	pthread_create(vcpu_thread, NULL, vcpu_worker, *vcpu);
+	kvm_create_vcpu_thread(vcpu_thread, NULL, vcpu_worker, *vcpu, 0);
 
 	/* Ensure the guest thread is spun up. */
 	wait_for_vcpu();
diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index db8967f1a17b..be93a333ce04 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -8,7 +8,6 @@
 #include <stdio.h>
 #include <time.h>
 #include <sched.h>
-#include <pthread.h>
 #include <linux/kernel.h>
 #include <asm/kvm.h>
 #include <asm/kvm_para.h>
@@ -290,7 +289,8 @@ int main(int ac, char **av)
 
 		/* Steal time from the VCPU. The steal time thread has the same CPU affinity as the VCPUs. */
 		run_delay = get_run_delay();
-		pthread_create(&thread, &attr, do_steal_time, NULL);
+		pthread_create_with_name(&thread, &attr, do_steal_time,
+					 NULL, "steal-time-thread");
 		do
 			sched_yield();
 		while (get_run_delay() - run_delay < MIN_RUN_DELAY_NS);
diff --git a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
index fb02581953a3..abbd5a4f2828 100644
--- a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
+++ b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
@@ -16,7 +16,6 @@
 #include <kvm_util.h>
 #include <linux/kvm.h>
 #include <processor.h>
-#include <pthread.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -69,7 +68,7 @@ void test(void)
 	tc.run = run;
 	srand(getpid());
 	for (i = 0; i < NTHREAD; i++) {
-		pthread_create(&th[i], NULL, thr, (void *)(uintptr_t)&tc);
+		kvm_create_vcpu_thread(&th[i], NULL, thr, (void *)(uintptr_t)&tc, i);
 		usleep(rand() % 10000);
 	}
 	for (i = 0; i < NTHREAD; i++)
diff --git a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
index c7ef97561038..b00ba08a19eb 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
@@ -5,7 +5,6 @@
 #include <sys/ioctl.h>
 #include <stdlib.h>
 #include <errno.h>
-#include <pthread.h>
 
 #include "test_util.h"
 #include "kvm_util.h"
diff --git a/tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c b/tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c
index 47139aab7408..a6511c399173 100644
--- a/tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c
+++ b/tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c
@@ -15,7 +15,6 @@
 #include <time.h>
 #include <sched.h>
 #include <signal.h>
-#include <pthread.h>
 
 #define NR_TEST_VCPUS 20
 
@@ -102,7 +101,8 @@ int main(int argc, char *argv[])
 	pthread_t cpu_threads[NR_TEST_VCPUS];
 	unsigned long cpu;
 	for (cpu = 0; cpu < NR_TEST_VCPUS; cpu++)
-		pthread_create(&cpu_threads[cpu], NULL, run_vcpu, (void *)cpu);
+		kvm_create_vcpu_thread(&cpu_threads[cpu], NULL,
+				       run_vcpu, (void *)cpu, cpu);
 
 	unsigned long failures = 0;
 	for (cpu = 0; cpu < NR_TEST_VCPUS; cpu++) {
diff --git a/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c b/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
index a897c7fd8abe..24a89a3a11db 100644
--- a/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
+++ b/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
@@ -19,7 +19,6 @@
  */
 
 #define _GNU_SOURCE /* for program_invocation_short_name */
-#include <pthread.h>
 #include <inttypes.h>
 #include <string.h>
 #include <time.h>
diff --git a/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c
index 3d272d7f961e..8bdef8e0f2b0 100644
--- a/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c
@@ -22,7 +22,6 @@
 
 #define _GNU_SOURCE /* for program_invocation_short_name */
 #include <getopt.h>
-#include <pthread.h>
 #include <inttypes.h>
 #include <string.h>
 #include <time.h>
@@ -393,7 +392,6 @@ void get_cmdline_args(int argc, char *argv[], int *run_secs,
 
 int main(int argc, char *argv[])
 {
-	int r;
 	int wait_secs;
 	const int max_halter_wait = 10;
 	int run_secs = 0;
@@ -436,9 +434,8 @@ int main(int argc, char *argv[])
 	params[1].pipis_rcvd = pipis_rcvd;
 
 	/* Start halter vCPU thread and wait for it to execute first HLT. */
-	r = pthread_create(&threads[0], NULL, vcpu_thread, &params[0]);
-	TEST_ASSERT(r == 0,
-		    "pthread_create halter failed errno=%d", errno);
+	kvm_create_vcpu_thread(&threads[0], NULL,
+			       vcpu_thread, &params[0], 0);
 	fprintf(stderr, "Halter vCPU thread started\n");
 
 	wait_secs = 0;
@@ -455,8 +452,7 @@ int main(int argc, char *argv[])
 		"Halter vCPU thread reported its APIC ID: %u after %d seconds.\n",
 		data->halter_apic_id, wait_secs);
 
-	r = pthread_create(&threads[1], NULL, vcpu_thread, &params[1]);
-	TEST_ASSERT(r == 0, "pthread_create sender failed errno=%d", errno);
+	kvm_create_vcpu_thread(&threads[1], NULL, vcpu_thread, &params[1], 1);
 
 	fprintf(stderr,
 		"IPI sender vCPU thread started. Letting vCPUs run for %d seconds.\n",
-- 
2.27.0

