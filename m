Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39506747B9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjASX7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjASX7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:59:10 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECEEA101D;
        Thu, 19 Jan 2023 15:58:46 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id s4so2977606qtx.6;
        Thu, 19 Jan 2023 15:58:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZoVMmJF8Zsjaz+7RCAKJwmMurWbPmCAcZuKJOCBBD4U=;
        b=fAHWPvxM6mcdsqxZNo+IvtyxVqDNqDSZpDaaop7Ih8NvUggAg4rmErnY2JoU9goToC
         Uklel1aXxevazeJO+Bb6gO0Y0tiFQevuXYhpycQqyvVK7RI+bg1C1lkfmg/ibA+tFoqG
         lemnGR/EPOvN//pTqaj3gTRmf/OVmH95gorx2eD6heAoALMgh394XYtuVBFeBlWVtQgU
         Ku3RoGSP/cTZTwY6GnRUQy2sxtpF0sa2mgE7L200T1ErHBbOrCEQvey1T491m6QWzy0Q
         MFVe6f2sPGGbi57Om5FJzn/OTHjWAdxHckqkdTkZS9HDhK7UhU9cfwWcTSGMREuOVKRZ
         DAfw==
X-Gm-Message-State: AFqh2koAuO1rqC9HpbHB/d7cR162w1PpJBzVav2FDapoxTQrGxLHnCNj
        pHx2TH93L9I7vNOAyiJtWkMz1gR/KTuu1rJD
X-Google-Smtp-Source: AMrXdXuXAvVFn9pz52rACHt0tkM1+UNeEbW2Dg0JxBT50fJg3AmPQKohzjNsZ5oyntjodgJvW+yWzw==
X-Received: by 2002:ac8:58c3:0:b0:3b6:2c85:6fe8 with SMTP id u3-20020ac858c3000000b003b62c856fe8mr21009860qta.53.1674172725029;
        Thu, 19 Jan 2023 15:58:45 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id o5-20020a05620a2a0500b006f9e103260dsm25574531qkp.91.2023.01.19.15.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:58:44 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next 6/8] selftests/bpf: Add selftest suite for cpumask kfuncs
Date:   Thu, 19 Jan 2023 17:58:31 -0600
Message-Id: <20230119235833.2948341-7-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119235833.2948341-1-void@manifault.com>
References: <20230119235833.2948341-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent patch added a new set of kfuncs for allocating, freeing,
manipulating, and querying cpumasks. This patch adds a new 'cpumask'
selftest suite which verifies their behavior.

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../selftests/bpf/prog_tests/cpumask.c        |  74 +++
 .../selftests/bpf/progs/cpumask_common.h      | 114 +++++
 .../selftests/bpf/progs/cpumask_failure.c     | 125 +++++
 .../selftests/bpf/progs/cpumask_success.c     | 426 ++++++++++++++++++
 5 files changed, 740 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cpumask.c
 create mode 100644 tools/testing/selftests/bpf/progs/cpumask_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/cpumask_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/cpumask_success.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index 1cf5b94cda30..4c2c58e9c4e5 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -13,6 +13,7 @@ cgroup_hierarchical_stats                # JIT does not support calling kernel f
 cgrp_kfunc                               # JIT does not support calling kernel function
 cgrp_local_storage                       # prog_attach unexpected error: -524                                          (trampoline)
 core_read_macros                         # unknown func bpf_probe_read#4                                               (overlapping)
+cpumask                                  # JIT does not support calling kernel function
 d_path                                   # failed to auto-attach program 'prog_stat': -524                             (trampoline)
 decap_sanity                             # JIT does not support calling kernel function                                (kfunc)
 deny_namespace                           # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask.c b/tools/testing/selftests/bpf/prog_tests/cpumask.c
new file mode 100644
index 000000000000..5fbe457c4ebe
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cpumask.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include "cpumask_failure.skel.h"
+#include "cpumask_success.skel.h"
+
+static const char * const cpumask_success_testcases[] = {
+	"test_alloc_free_cpumask",
+	"test_set_clear_cpu",
+	"test_setall_clear_cpu",
+	"test_first_firstzero_cpu",
+	"test_test_and_set_clear",
+	"test_and_or_xor",
+	"test_intersects_subset",
+	"test_copy_any_anyand",
+	"test_insert_leave",
+	"test_insert_remove_release",
+	"test_insert_kptr_get_release",
+};
+
+static void verify_success(const char *prog_name)
+{
+	struct cpumask_success *skel;
+	struct bpf_program *prog;
+	struct bpf_link *link = NULL;
+	pid_t child_pid;
+	int status;
+
+	skel = cpumask_success__open();
+	if (!ASSERT_OK_PTR(skel, "cpumask_success__open"))
+		return;
+
+	skel->bss->pid = getpid();
+	skel->bss->nr_cpus = libbpf_num_possible_cpus();
+
+	cpumask_success__load(skel);
+	if (!ASSERT_OK_PTR(skel, "cpumask_success__load"))
+		goto cleanup;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto cleanup;
+
+	link = bpf_program__attach(prog);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
+		goto cleanup;
+
+	child_pid = fork();
+	if (!ASSERT_GT(child_pid, -1, "child_pid"))
+		goto cleanup;
+	if (child_pid == 0)
+		_exit(0);
+	waitpid(child_pid, &status, 0);
+	ASSERT_OK(skel->bss->err, "post_wait_err");
+
+cleanup:
+	bpf_link__destroy(link);
+	cpumask_success__destroy(skel);
+}
+
+void test_cpumask(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cpumask_success_testcases); i++) {
+		if (!test__start_subtest(cpumask_success_testcases[i]))
+			continue;
+
+		verify_success(cpumask_success_testcases[i]);
+	}
+
+	RUN_TESTS(cpumask_failure);
+}
diff --git a/tools/testing/selftests/bpf/progs/cpumask_common.h b/tools/testing/selftests/bpf/progs/cpumask_common.h
new file mode 100644
index 000000000000..ad34f3b602be
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cpumask_common.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#ifndef _CPUMASK_COMMON_H
+#define _CPUMASK_COMMON_H
+
+#include "errno.h"
+#include <stdbool.h>
+
+int err;
+
+struct __cpumask_map_value {
+	struct bpf_cpumask __kptr_ref * cpumask;
+};
+
+struct array_map {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct __cpumask_map_value);
+	__uint(max_entries, 1);
+} __cpumask_map SEC(".maps");
+
+struct bpf_cpumask *bpf_cpumask_create(void) __ksym;
+void bpf_cpumask_release(struct bpf_cpumask *cpumask) __ksym;
+struct bpf_cpumask *bpf_cpumask_acquire(struct bpf_cpumask *cpumask) __ksym;
+struct bpf_cpumask *bpf_cpumask_kptr_get(struct bpf_cpumask **cpumask) __ksym;
+u32 bpf_cpumask_first(const struct cpumask *cpumask) __ksym;
+u32 bpf_cpumask_first_zero(const struct cpumask *cpumask) __ksym;
+void bpf_cpumask_set_cpu(u32 cpu, struct bpf_cpumask *cpumask) __ksym;
+void bpf_cpumask_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask) __ksym;
+bool bpf_cpumask_test_cpu(u32 cpu, const struct cpumask *cpumask) __ksym;
+bool bpf_cpumask_test_and_set_cpu(u32 cpu, struct bpf_cpumask *cpumask) __ksym;
+bool bpf_cpumask_test_and_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask) __ksym;
+void bpf_cpumask_setall(struct bpf_cpumask *cpumask) __ksym;
+void bpf_cpumask_clear(struct bpf_cpumask *cpumask) __ksym;
+bool bpf_cpumask_and(struct bpf_cpumask *cpumask,
+		     const struct cpumask *src1,
+		     const struct cpumask *src2) __ksym;
+void bpf_cpumask_or(struct bpf_cpumask *cpumask,
+		    const struct cpumask *src1,
+		    const struct cpumask *src2) __ksym;
+void bpf_cpumask_xor(struct bpf_cpumask *cpumask,
+		     const struct cpumask *src1,
+		     const struct cpumask *src2) __ksym;
+bool bpf_cpumask_equal(const struct cpumask *src1, const struct cpumask *src2) __ksym;
+bool bpf_cpumask_intersects(const struct cpumask *src1, const struct cpumask *src2) __ksym;
+bool bpf_cpumask_subset(const struct cpumask *src1, const struct cpumask *src2) __ksym;
+bool bpf_cpumask_empty(const struct cpumask *cpumask) __ksym;
+bool bpf_cpumask_full(const struct cpumask *cpumask) __ksym;
+void bpf_cpumask_copy(struct bpf_cpumask *dst, const struct cpumask *src) __ksym;
+u32 bpf_cpumask_any(const struct cpumask *src) __ksym;
+u32 bpf_cpumask_any_and(const struct cpumask *src1, const struct cpumask *src2) __ksym;
+
+static inline const struct cpumask *cast(struct bpf_cpumask *cpumask)
+{
+	return (const struct cpumask *)cpumask;
+}
+
+static inline struct bpf_cpumask *create_cpumask(void)
+{
+	struct bpf_cpumask *cpumask;
+
+	cpumask = bpf_cpumask_create();
+	if (!cpumask) {
+		err = 1;
+		return NULL;
+	}
+
+	if (!bpf_cpumask_empty(cast(cpumask))) {
+		err = 2;
+		bpf_cpumask_release(cpumask);
+		return NULL;
+	}
+
+	return cpumask;
+}
+
+static inline struct __cpumask_map_value *cpumask_map_value_lookup(void)
+{
+	u32 key = 0;
+
+	return bpf_map_lookup_elem(&__cpumask_map, &key);
+}
+
+static inline int cpumask_map_insert(struct bpf_cpumask *mask)
+{
+	struct __cpumask_map_value local, *v;
+	long status;
+	struct bpf_cpumask *old;
+	u32 key = 0;
+
+	local.cpumask = NULL;
+	status = bpf_map_update_elem(&__cpumask_map, &key, &local, 0);
+	if (status) {
+		bpf_cpumask_release(mask);
+		return status;
+	}
+
+	v = bpf_map_lookup_elem(&__cpumask_map, &key);
+	if (!v) {
+		bpf_cpumask_release(mask);
+		return -ENOENT;
+	}
+
+	old = bpf_kptr_xchg(&v->cpumask, mask);
+	if (old) {
+		bpf_cpumask_release(old);
+		return -EEXIST;
+	}
+
+	return 0;
+}
+
+#endif /* _CPUMASK_COMMON_H */
diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/testing/selftests/bpf/progs/cpumask_failure.c
new file mode 100644
index 000000000000..8a6ac7a91e92
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#include "cpumask_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+/* Prototype for all of the program trace events below:
+ *
+ * TRACE_EVENT(task_newtask,
+ *         TP_PROTO(struct task_struct *p, u64 clone_flags)
+ */
+
+SEC("tp_btf/task_newtask")
+__failure __msg("Unreleased reference")
+int BPF_PROG(test_alloc_no_release, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *cpumask;
+
+	cpumask = create_cpumask();
+
+	/* cpumask is never released. */
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+__failure __msg("NULL pointer passed to trusted arg0")
+int BPF_PROG(test_alloc_double_release, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *cpumask;
+
+	cpumask = create_cpumask();
+
+	/* cpumask is released twice. */
+	bpf_cpumask_release(cpumask);
+	bpf_cpumask_release(cpumask);
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+__failure __msg("bpf_cpumask_acquire args#0 expected pointer to STRUCT bpf_cpumask")
+int BPF_PROG(test_acquire_wrong_cpumask, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *cpumask;
+
+	/* Can't acquire a non-struct bpf_cpumask. */
+	cpumask = bpf_cpumask_acquire((struct bpf_cpumask *)task->cpus_ptr);
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+__failure __msg("bpf_cpumask_set_cpu args#1 expected pointer to STRUCT bpf_cpumask")
+int BPF_PROG(test_mutate_cpumask, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *cpumask;
+
+	/* Can't set the CPU of a non-struct bpf_cpumask. */
+	bpf_cpumask_set_cpu(0, (struct bpf_cpumask *)task->cpus_ptr);
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+__failure __msg("Unreleased reference")
+int BPF_PROG(test_insert_remove_no_release, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *cpumask;
+	struct __cpumask_map_value *v;
+
+	cpumask = create_cpumask();
+	if (!cpumask)
+		return 0;
+
+	if (cpumask_map_insert(cpumask))
+		return 0;
+
+	v = cpumask_map_value_lookup();
+	if (!v)
+		return 0;
+
+	cpumask = bpf_kptr_xchg(&v->cpumask, NULL);
+
+	/* cpumask is never released. */
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+__failure __msg("Unreleased reference")
+int BPF_PROG(test_kptr_get_no_release, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *cpumask;
+	struct __cpumask_map_value *v;
+
+	cpumask = create_cpumask();
+	if (!cpumask)
+		return 0;
+
+	if (cpumask_map_insert(cpumask))
+		return 0;
+
+	v = cpumask_map_value_lookup();
+	if (!v)
+		return 0;
+
+	cpumask = bpf_cpumask_kptr_get(&v->cpumask);
+
+	/* cpumask is never released. */
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+__failure __msg("NULL pointer passed to trusted arg0")
+int BPF_PROG(test_cpumask_null, struct task_struct *task, u64 clone_flags)
+{
+	bpf_cpumask_empty(NULL);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
new file mode 100644
index 000000000000..1d38bc65d4b0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -0,0 +1,426 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#include "cpumask_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+int pid, nr_cpus;
+
+static bool is_test_task(void)
+{
+	int cur_pid = bpf_get_current_pid_tgid() >> 32;
+
+	return pid == cur_pid;
+}
+
+static bool create_cpumask_set(struct bpf_cpumask **out1,
+			       struct bpf_cpumask **out2,
+			       struct bpf_cpumask **out3,
+			       struct bpf_cpumask **out4)
+{
+	struct bpf_cpumask *mask1, *mask2, *mask3, *mask4;
+
+	mask1 = create_cpumask();
+	if (!mask1)
+		return false;
+
+	mask2 = create_cpumask();
+	if (!mask2) {
+		bpf_cpumask_release(mask1);
+		err = 3;
+		return false;
+	}
+
+	mask3 = create_cpumask();
+	if (!mask3) {
+		bpf_cpumask_release(mask1);
+		bpf_cpumask_release(mask2);
+		err = 4;
+		return false;
+	}
+
+	mask4 = create_cpumask();
+	if (!mask4) {
+		bpf_cpumask_release(mask1);
+		bpf_cpumask_release(mask2);
+		bpf_cpumask_release(mask3);
+		err = 5;
+		return false;
+	}
+
+	*out1 = mask1;
+	*out2 = mask2;
+	*out3 = mask3;
+	*out4 = mask4;
+
+	return true;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_alloc_free_cpumask, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *cpumask;
+
+	if (!is_test_task())
+		return 0;
+
+	cpumask = create_cpumask();
+	if (!cpumask)
+		return 0;
+
+	bpf_cpumask_release(cpumask);
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_set_clear_cpu, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *cpumask;
+
+	if (!is_test_task())
+		return 0;
+
+	cpumask = create_cpumask();
+	if (!cpumask)
+		return 0;
+
+	bpf_cpumask_set_cpu(0, cpumask);
+	if (!bpf_cpumask_test_cpu(0, cast(cpumask))) {
+		err = 3;
+		goto release_exit;
+	}
+
+	bpf_cpumask_clear_cpu(0, cpumask);
+	if (bpf_cpumask_test_cpu(0, cast(cpumask))) {
+		err = 4;
+		goto release_exit;
+	}
+
+release_exit:
+	bpf_cpumask_release(cpumask);
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_setall_clear_cpu, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *cpumask;
+
+	if (!is_test_task())
+		return 0;
+
+	cpumask = create_cpumask();
+	if (!cpumask)
+		return 0;
+
+	bpf_cpumask_setall(cpumask);
+	if (!bpf_cpumask_full(cast(cpumask))) {
+		err = 3;
+		goto release_exit;
+	}
+
+	bpf_cpumask_clear(cpumask);
+	if (!bpf_cpumask_empty(cast(cpumask))) {
+		err = 4;
+		goto release_exit;
+	}
+
+release_exit:
+	bpf_cpumask_release(cpumask);
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_first_firstzero_cpu, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *cpumask;
+
+	if (!is_test_task())
+		return 0;
+
+	cpumask = create_cpumask();
+	if (!cpumask)
+		return 0;
+
+	if (bpf_cpumask_first(cast(cpumask)) < nr_cpus) {
+		err = 3;
+		goto release_exit;
+	}
+
+	if (bpf_cpumask_first_zero(cast(cpumask)) != 0) {
+		bpf_printk("first zero: %d", bpf_cpumask_first_zero(cast(cpumask)));
+		err = 4;
+		goto release_exit;
+	}
+
+	bpf_cpumask_set_cpu(0, cpumask);
+	if (bpf_cpumask_first(cast(cpumask)) != 0) {
+		err = 5;
+		goto release_exit;
+	}
+
+	if (bpf_cpumask_first_zero(cast(cpumask)) != 1) {
+		err = 6;
+		goto release_exit;
+	}
+
+release_exit:
+	bpf_cpumask_release(cpumask);
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_test_and_set_clear, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *cpumask;
+
+	if (!is_test_task())
+		return 0;
+
+	cpumask = create_cpumask();
+	if (!cpumask)
+		return 0;
+
+	if (bpf_cpumask_test_and_set_cpu(0, cpumask)) {
+		err = 3;
+		goto release_exit;
+	}
+
+	if (!bpf_cpumask_test_and_set_cpu(0, cpumask)) {
+		err = 4;
+		goto release_exit;
+	}
+
+	if (!bpf_cpumask_test_and_clear_cpu(0, cpumask)) {
+		err = 5;
+		goto release_exit;
+	}
+
+release_exit:
+	bpf_cpumask_release(cpumask);
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_and_or_xor, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *mask1, *mask2, *dst1, *dst2;
+
+	if (!is_test_task())
+		return 0;
+
+	if (!create_cpumask_set(&mask1, &mask2, &dst1, &dst2))
+		return 0;
+
+	bpf_cpumask_set_cpu(0, mask1);
+	bpf_cpumask_set_cpu(1, mask2);
+
+	if (bpf_cpumask_and(dst1, cast(mask1), cast(mask2))) {
+		err = 6;
+		goto release_exit;
+	}
+	if (!bpf_cpumask_empty(cast(dst1))) {
+		err = 7;
+		goto release_exit;
+	}
+
+	bpf_cpumask_or(dst1, cast(mask1), cast(mask2));
+	if (!bpf_cpumask_test_cpu(0, cast(dst1))) {
+		err = 8;
+		goto release_exit;
+	}
+	if (!bpf_cpumask_test_cpu(1, cast(dst1))) {
+		err = 9;
+		goto release_exit;
+	}
+
+	bpf_cpumask_xor(dst2, cast(mask1), cast(mask2));
+	if (!bpf_cpumask_equal(cast(dst1), cast(dst2))) {
+		err = 10;
+		goto release_exit;
+	}
+
+release_exit:
+	bpf_cpumask_release(mask1);
+	bpf_cpumask_release(mask2);
+	bpf_cpumask_release(dst1);
+	bpf_cpumask_release(dst2);
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_intersects_subset, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *mask1, *mask2, *dst1, *dst2;
+
+	if (!is_test_task())
+		return 0;
+
+	if (!create_cpumask_set(&mask1, &mask2, &dst1, &dst2))
+		return 0;
+
+	bpf_cpumask_set_cpu(0, mask1);
+	bpf_cpumask_set_cpu(1, mask2);
+	if (bpf_cpumask_intersects(cast(mask1), cast(mask2))) {
+		err = 6;
+		goto release_exit;
+	}
+
+	bpf_cpumask_or(dst1, cast(mask1), cast(mask2));
+	if (!bpf_cpumask_subset(cast(mask1), cast(dst1))) {
+		err = 7;
+		goto release_exit;
+	}
+
+	if (!bpf_cpumask_subset(cast(mask2), cast(dst1))) {
+		err = 8;
+		goto release_exit;
+	}
+
+	if (bpf_cpumask_subset(cast(dst1), cast(mask1))) {
+		err = 9;
+		goto release_exit;
+	}
+
+release_exit:
+	bpf_cpumask_release(mask1);
+	bpf_cpumask_release(mask2);
+	bpf_cpumask_release(dst1);
+	bpf_cpumask_release(dst2);
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_copy_any_anyand, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *mask1, *mask2, *dst1, *dst2;
+	u32 cpu;
+
+	if (!is_test_task())
+		return 0;
+
+	if (!create_cpumask_set(&mask1, &mask2, &dst1, &dst2))
+		return 0;
+
+	bpf_cpumask_set_cpu(0, mask1);
+	bpf_cpumask_set_cpu(1, mask2);
+	bpf_cpumask_or(dst1, cast(mask1), cast(mask2));
+
+	cpu = bpf_cpumask_any(cast(mask1));
+	if (cpu != 0) {
+		err = 6;
+		goto release_exit;
+	}
+
+	cpu = bpf_cpumask_any(cast(dst2));
+	if (cpu < nr_cpus) {
+		err = 7;
+		goto release_exit;
+	}
+
+	bpf_cpumask_copy(dst2, cast(dst1));
+	if (!bpf_cpumask_equal(cast(dst1), cast(dst2))) {
+		err = 8;
+		goto release_exit;
+	}
+
+	cpu = bpf_cpumask_any(cast(dst2));
+	if (cpu > 1) {
+		err = 9;
+		goto release_exit;
+	}
+
+	cpu = bpf_cpumask_any_and(cast(mask1), cast(mask2));
+	if (cpu < nr_cpus) {
+		err = 10;
+		goto release_exit;
+	}
+
+release_exit:
+	bpf_cpumask_release(mask1);
+	bpf_cpumask_release(mask2);
+	bpf_cpumask_release(dst1);
+	bpf_cpumask_release(dst2);
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_insert_leave, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *cpumask;
+	struct __cpumask_map_value *v;
+
+	cpumask = create_cpumask();
+	if (!cpumask)
+		return 0;
+
+	if (cpumask_map_insert(cpumask))
+		err = 3;
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_insert_remove_release, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *cpumask;
+	struct __cpumask_map_value *v;
+
+	cpumask = create_cpumask();
+	if (!cpumask)
+		return 0;
+
+	if (cpumask_map_insert(cpumask)) {
+		err = 3;
+		return 0;
+	}
+
+	v = cpumask_map_value_lookup();
+	if (!v) {
+		err = 4;
+		return 0;
+	}
+
+	cpumask = bpf_kptr_xchg(&v->cpumask, NULL);
+	if (cpumask)
+		bpf_cpumask_release(cpumask);
+	else
+		err = 5;
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_insert_kptr_get_release, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *cpumask;
+	struct __cpumask_map_value *v;
+
+	cpumask = create_cpumask();
+	if (!cpumask)
+		return 0;
+
+	if (cpumask_map_insert(cpumask)) {
+		err = 3;
+		return 0;
+	}
+
+	v = cpumask_map_value_lookup();
+	if (!v) {
+		err = 4;
+		return 0;
+	}
+
+	cpumask = bpf_cpumask_kptr_get(&v->cpumask);
+	if (cpumask)
+		bpf_cpumask_release(cpumask);
+	else
+		err = 5;
+
+	return 0;
+}
-- 
2.39.0

