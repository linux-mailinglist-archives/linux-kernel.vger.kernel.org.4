Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162786080AE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 23:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiJUVTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 17:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiJUVSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 17:18:47 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA742A4E29
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 14:18:34 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id il7-20020a17090b164700b0020d1029ceaaso4749763pjb.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 14:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T7kxPR9BlRIjzoKc+0ht99Q2Dk0EHdE778/74XTTiPw=;
        b=quSmY0wZwBh/jf1uHg2pkg0cdZIJpr+v1oL1KCCGxim+ySz2rvH1x+s1e5h7yNB1JW
         Im03C1t7sBQ1fLv3aWJQDhOD1aweJ+/JE9IRHQNCH9hrzM09Giovi36NSc/Rhnipv2Ru
         rIIBWL+VXcmZzZnxoVxiwrDh7DC0+TCLfiRopHVg8EkL3OKnWAObKg8suH7Ad24R8xNg
         7WgXkg5ikphJvhQlJjUs6jSvLsIKE86gE81UMMsSPWJmUr03kTtZHxHLg0JocMakx/Ir
         FyIPlZ4B6xK/MOvc7rXPp1GdPwvGyHOYIH+9jJ4jZGIkjJE66RyLJjkRO163UosZMsuX
         fJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7kxPR9BlRIjzoKc+0ht99Q2Dk0EHdE778/74XTTiPw=;
        b=47gEOgOGN5r1Pow9j02p6PvUMl9eJgmS+yrluMnAh3eMsXnjLh0lRxksrszytmmEXX
         +x2FHhk/9DCLMCUoQaeh3VpDM+cL/yg8x5I0uNYArlOiDfo1JVGDDKpN3JP6UyaFXwHR
         I3lsO4rHfBmIONdV9Aw4ojvrfB9ey24rBnxPgj+y1ZTFMQacX/HbT2R2+TlptmuG+fnz
         /IRxED+GlDbG/klh5nAb0W66J5bGsCPDYZ5Kfbmx3c56K/Ken9AU8Q5ZisoxTSMGKzdf
         yTENd6Y71mC32k6aOtQH+/G/3kxB3TOxJyD8Cf7XqvutixZpf8QjEQIjH73iqDN9WPY7
         o3zQ==
X-Gm-Message-State: ACrzQf1HzvUdDa6JuX0lXO/jcN0vcQccOwhVDa8jztZ3opnN1QEboNiE
        vZA/4fEshgQhZZ13c+G9nQ5sb1eDR/NK
X-Google-Smtp-Source: AMsMyM6IGHat3GSWB9s0UzJLkDG4AfTe9WExLy3fwJI6ZC6nKs/Iv6/drhRhOLrgJN3EORyHP+Hp02eQ37XI
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:903:247:b0:179:b5e1:54b7 with SMTP id
 j7-20020a170903024700b00179b5e154b7mr21116838plh.84.1666387113402; Fri, 21
 Oct 2022 14:18:33 -0700 (PDT)
Date:   Fri, 21 Oct 2022 14:18:16 -0700
In-Reply-To: <20221021211816.1525201-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20221021211816.1525201-1-vipinsh@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021211816.1525201-6-vipinsh@google.com>
Subject: [PATCH v6 5/5] KVM: selftests: Allowing running dirty_log_perf_test
 on specific CPUs
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com
Cc:     andrew.jones@linux.dev, wei.w.wang@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
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

Add a command line option, -c, to pin vCPUs to physical CPUs (pCPUs),
i.e.  to force vCPUs to run on specific pCPUs.

Requirement to implement this feature came in discussion on the patch
"Make page tables for eager page splitting NUMA aware"
https://lore.kernel.org/lkml/YuhPT2drgqL+osLl@google.com/

This feature is useful as it provides a way to analyze performance based
on the vCPUs and dirty log worker locations, like on the different NUMA
nodes or on the same NUMA nodes.

To keep things simple, implementation is intentionally very limited,
either all of the vCPUs will be pinned followed by an optional main
thread or nothing will be pinned.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Suggested-by: David Matlack <dmatlack@google.com>
---
 .../selftests/kvm/dirty_log_perf_test.c       | 22 ++++++-
 .../selftests/kvm/include/perf_test_util.h    |  6 ++
 .../selftests/kvm/lib/perf_test_util.c        | 65 ++++++++++++++++++-
 3 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index 618598ddd993..35504b36b126 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -353,7 +353,7 @@ static void help(char *name)
 	puts("");
 	printf("usage: %s [-h] [-i iterations] [-p offset] [-g] "
 	       "[-m mode] [-n] [-b vcpu bytes] [-v vcpus] [-o] [-s mem type]"
-	       "[-x memslots]\n", name);
+	       "[-x memslots] [-c physical cpus to run test on]\n", name);
 	puts("");
 	printf(" -i: specify iteration counts (default: %"PRIu64")\n",
 	       TEST_HOST_LOOP_N);
@@ -383,6 +383,17 @@ static void help(char *name)
 	backing_src_help("-s");
 	printf(" -x: Split the memory region into this number of memslots.\n"
 	       "     (default: 1)\n");
+	printf(" -c: Pin tasks to physical CPUs.  Takes a list of comma separated\n"
+	       "     values (target pCPU), one for each vCPU, plus an optional\n"
+	       "     entry for the main application task (specified via entry\n"
+	       "     <nr_vcpus + 1>).  If used, entries must be provided for all\n"
+	       "     vCPUs, i.e. pinning vCPUs is all or nothing.\n\n"
+	       "     E.g. to create 3 vCPUs, pin vCPU0=>pCPU22, vCPU1=>pCPU23,\n"
+	       "     vCPU2=>pCPU24, and pin the application task to pCPU50:\n\n"
+	       "         ./dirty_log_perf_test -v 3 -c 22,23,24,50\n\n"
+	       "     To leave the application task unpinned, drop the final entry:\n\n"
+	       "         ./dirty_log_perf_test -v 3 -c 22,23,24\n\n"
+	       "     (default: no pinning)\n");
 	puts("");
 	exit(0);
 }
@@ -390,6 +401,7 @@ static void help(char *name)
 int main(int argc, char *argv[])
 {
 	int max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
+	const char *pcpu_list = NULL;
 	struct test_params p = {
 		.iterations = TEST_HOST_LOOP_N,
 		.wr_fract = 1,
@@ -406,11 +418,14 @@ int main(int argc, char *argv[])
 
 	guest_modes_append_default();
 
-	while ((opt = getopt(argc, argv, "b:ef:ghi:m:nop:s:v:x:")) != -1) {
+	while ((opt = getopt(argc, argv, "b:c:ef:ghi:m:nop:s:v:x:")) != -1) {
 		switch (opt) {
 		case 'b':
 			guest_percpu_mem_size = parse_size(optarg);
 			break;
+		case 'c':
+			pcpu_list = optarg;
+			break;
 		case 'e':
 			/* 'e' is for evil. */
 			run_vcpus_while_disabling_dirty_logging = true;
@@ -456,6 +471,9 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (pcpu_list)
+		perf_test_setup_pinning(pcpu_list, nr_vcpus);
+
 	TEST_ASSERT(p.iterations >= 2, "The test should have at least two iterations");
 
 	pr_info("Test iterations: %"PRIu64"\n",	p.iterations);
diff --git a/tools/testing/selftests/kvm/include/perf_test_util.h b/tools/testing/selftests/kvm/include/perf_test_util.h
index eaa88df0555a..ccfe3b9dc6bd 100644
--- a/tools/testing/selftests/kvm/include/perf_test_util.h
+++ b/tools/testing/selftests/kvm/include/perf_test_util.h
@@ -27,6 +27,8 @@ struct perf_test_vcpu_args {
 	/* Only used by the host userspace part of the vCPU thread */
 	struct kvm_vcpu *vcpu;
 	int vcpu_idx;
+	/* The pCPU to which this vCPU is pinned. Only valid if pin_vcpus is true. */
+	uint32_t pcpu;
 };
 
 struct perf_test_args {
@@ -39,6 +41,8 @@ struct perf_test_args {
 
 	/* Run vCPUs in L2 instead of L1, if the architecture supports it. */
 	bool nested;
+	/* True if all vCPUs are pinned to pCPUs */
+	bool pin_vcpus;
 
 	struct perf_test_vcpu_args vcpu_args[KVM_MAX_VCPUS];
 };
@@ -60,4 +64,6 @@ void perf_test_guest_code(uint32_t vcpu_id);
 uint64_t perf_test_nested_pages(int nr_vcpus);
 void perf_test_setup_nested(struct kvm_vm *vm, int nr_vcpus, struct kvm_vcpu *vcpus[]);
 
+void perf_test_setup_pinning(const char *pcpus_string, int nr_vcpus);
+
 #endif /* SELFTEST_KVM_PERF_TEST_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/perf_test_util.c b/tools/testing/selftests/kvm/lib/perf_test_util.c
index 9618b37c66f7..520d1f896d61 100644
--- a/tools/testing/selftests/kvm/lib/perf_test_util.c
+++ b/tools/testing/selftests/kvm/lib/perf_test_util.c
@@ -2,7 +2,10 @@
 /*
  * Copyright (C) 2020, Google LLC.
  */
+#define _GNU_SOURCE
+
 #include <inttypes.h>
+#include <sched.h>
 
 #include "kvm_util.h"
 #include "perf_test_util.h"
@@ -240,10 +243,27 @@ void __weak perf_test_setup_nested(struct kvm_vm *vm, int nr_vcpus, struct kvm_v
 	exit(KSFT_SKIP);
 }
 
+static void pin_this_task_to_pcpu(uint32_t pcpu)
+{
+	cpu_set_t mask;
+	int r;
+
+	CPU_ZERO(&mask);
+	CPU_SET(pcpu, &mask);
+	r = sched_setaffinity(0, sizeof(mask), &mask);
+	TEST_ASSERT(!r, "sched_setaffinity() failed for pCPU '%u'.\n", pcpu);
+}
+
 static void *vcpu_thread_main(void *data)
 {
+	struct perf_test_vcpu_args *vcpu_args;
 	struct vcpu_thread *vcpu = data;
 
+	vcpu_args = &perf_test_args.vcpu_args[vcpu->vcpu_idx];
+
+	if (perf_test_args.pin_vcpus)
+		pin_this_task_to_pcpu(vcpu_args->pcpu);
+
 	WRITE_ONCE(vcpu->running, true);
 
 	/*
@@ -255,7 +275,7 @@ static void *vcpu_thread_main(void *data)
 	while (!READ_ONCE(all_vcpu_threads_running))
 		;
 
-	vcpu_thread_fn(&perf_test_args.vcpu_args[vcpu->vcpu_idx]);
+	vcpu_thread_fn(vcpu_args);
 
 	return NULL;
 }
@@ -292,3 +312,46 @@ void perf_test_join_vcpu_threads(int nr_vcpus)
 	for (i = 0; i < nr_vcpus; i++)
 		pthread_join(vcpu_threads[i].thread, NULL);
 }
+
+static uint32_t parse_pcpu(const char *cpu_str, const cpu_set_t *allowed_mask)
+{
+	uint32_t pcpu = atoi_non_negative(cpu_str);
+
+	TEST_ASSERT(CPU_ISSET(pcpu, allowed_mask),
+		    "Not allowed to run on pCPU '%d', check cgroups?\n", pcpu);
+	return pcpu;
+}
+
+void perf_test_setup_pinning(const char *pcpus_string, int nr_vcpus)
+{
+	cpu_set_t allowed_mask;
+	char *cpu, *cpu_list;
+	char delim[2] = ",";
+	int i, r;
+
+	cpu_list = strdup(pcpus_string);
+	TEST_ASSERT(cpu_list, "strdup() allocation failed.\n");
+
+	r = sched_getaffinity(0, sizeof(allowed_mask), &allowed_mask);
+	TEST_ASSERT(!r, "sched_getaffinity() failed");
+
+	cpu = strtok(cpu_list, delim);
+
+	/* 1. Get all pcpus for vcpus. */
+	for (i = 0; i < nr_vcpus; i++) {
+		TEST_ASSERT(cpu, "pCPU not provided for vCPU '%d'\n", i);
+		perf_test_args.vcpu_args[i].pcpu = parse_pcpu(cpu, &allowed_mask);
+		cpu = strtok(NULL, delim);
+	}
+
+	perf_test_args.pin_vcpus = true;
+
+	/* 2. Check if the main worker needs to be pinned. */
+	if (cpu) {
+		pin_this_task_to_pcpu(parse_pcpu(cpu, &allowed_mask));
+		cpu = strtok(NULL, delim);
+	}
+
+	TEST_ASSERT(!cpu, "pCPU list contains trailing garbage characters '%s'", cpu);
+	free(cpu_list);
+}
-- 
2.38.0.135.g90850a2211-goog

