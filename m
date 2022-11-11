Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9DD624FD2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 02:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiKKBnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 20:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbiKKBnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 20:43:03 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3527264A1A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:43:02 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id n1-20020a170902f60100b00179c0a5c51fso2518738plg.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A70ttVGQMOKDF3CtwbEP7dFS6RlwzWxaqYrCszdXb9I=;
        b=n8lmG3TDWSQIW3LA7yfI5DfompWxwbTB4GDsiI8p7e7Vs3jqxzt/7w6Tk8Ry44QkBA
         10xq7yccwTXyT4BhAvUvOTEQjPVuzq0vU+8YyIlfhgQTWiRX+3oHKJsXhd3GmmDpd9W0
         LJ6yeXG0YLamprlSvK59UNFH1BaSz511cBKKxhRPubOYjTUSap5M6jt33EKmGnL5Wkpk
         TgHzEkol4MNFwJlArBpfnMcPr5KzD/iukDvyrbxJUxH8wIOTUrB2KqFtFE28S2fEx2EO
         K8M2mHK8cSFrjJ4kKDYRxrkfti4Ob1Syi1n1L5Xy5oWBbibWcqJPa3xcATNVrBT6usOH
         y7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A70ttVGQMOKDF3CtwbEP7dFS6RlwzWxaqYrCszdXb9I=;
        b=yOqj+NTDHrKkMLVHLXNTk/K0HQViESZvO+xTSWWLs82jKLO8UyMcFUYZ1KCrEv5lJ0
         x08LkrmmWgvD7thoETazwtpP0Hjf8ZikOB1KhkUG4Vj2Hj9dFr8AOlUvpJGgQU+c7n7a
         ra2DPJTyQXPev6K3MbunRnpvwERC1dbSPntZkWeU3sb0loIPUnVp1J1dLkY/s4lj9jHN
         ZK8r1IuxOzK7pQ6bR/Dh3RzeO3swqQsL9RnkjsBpnXYs5BLa0NpO0bnuLP0S3hwV8IOS
         ZMxuZOtAs6NsnMv1LU78uX77ejHcXTsaJ9VJr4oEfMVSYvWW7P3iztR6dEt1i5JyPDvS
         wzkQ==
X-Gm-Message-State: ANoB5pk5whBgyIL6p1Mjc96n41x8RBd+FQ6iStHM5PCIBLaLAk0ZxkK4
        mN6jbrh+YIQcYFwb9eEoMcgMb9n88L3gQbWO
X-Google-Smtp-Source: AA0mqf4uaznKLX/gQxxZf10jCSIa2b77KKRNW876PDThac9/udiqvV3V8is7oc7SclU4XTWdlXEZ0XSfoCQdTEPa
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:aa7:9ec7:0:b0:56e:3a98:f02 with SMTP id
 r7-20020aa79ec7000000b0056e3a980f02mr275131pfq.53.1668130981696; Thu, 10 Nov
 2022 17:43:01 -0800 (PST)
Date:   Fri, 11 Nov 2022 01:42:42 +0000
In-Reply-To: <20221111014244.1714148-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221111014244.1714148-1-vannapurve@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221111014244.1714148-5-vannapurve@google.com>
Subject: [V1 PATCH 4/6] KVM: selftests: x86: Execute VMs with private memory
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
        ricarkol@google.com, aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, chao.p.peng@linux.intel.com,
        yu.c.zhang@linux.intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, michael.roth@amd.com, qperret@google.com,
        steven.price@arm.com, ak@linux.intel.com, david@redhat.com,
        luto@kernel.org, vbabka@suse.cz, marcorr@google.com,
        erdemaktas@google.com, pgonda@google.com, nikunj@amd.com,
        seanjc@google.com, diviness@google.com, maz@kernel.org,
        dmatlack@google.com, axelrasmussen@google.com,
        maciej.szmigiero@oracle.com, mizhang@google.com,
        bgardon@google.com, ackerleytng@google.com,
        Vishal Annapurve <vannapurve@google.com>
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

Introduce a set of APIs to execute VM with private memslots.

Host userspace APIs for:
1) Setting up and executing VM having private memslots
2) Backing/unbacking guest private memory

Guest APIs for:
1) Changing memory mapping type

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../kvm/include/x86_64/private_mem.h          |  37 +++
 .../selftests/kvm/lib/x86_64/private_mem.c    | 211 ++++++++++++++++++
 3 files changed, 249 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/private_mem.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/private_mem.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 0172eb6cb6ee..57385ad58527 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -53,6 +53,7 @@ LIBKVM_STRING += lib/string_override.c
 LIBKVM_x86_64 += lib/x86_64/apic.c
 LIBKVM_x86_64 += lib/x86_64/handlers.S
 LIBKVM_x86_64 += lib/x86_64/perf_test_util.c
+LIBKVM_x86_64 += lib/x86_64/private_mem.c
 LIBKVM_x86_64 += lib/x86_64/processor.c
 LIBKVM_x86_64 += lib/x86_64/svm.c
 LIBKVM_x86_64 += lib/x86_64/ucall.c
diff --git a/tools/testing/selftests/kvm/include/x86_64/private_mem.h b/tools/testing/selftests/kvm/include/x86_64/private_mem.h
new file mode 100644
index 000000000000..e556ded971fd
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86_64/private_mem.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2022, Google LLC.
+ */
+
+#ifndef SELFTEST_KVM_PRIVATE_MEM_H
+#define SELFTEST_KVM_PRIVATE_MEM_H
+
+#include <stdint.h>
+#include <kvm_util.h>
+
+void kvm_hypercall_map_shared(uint64_t gpa, uint64_t size);
+void kvm_hypercall_map_private(uint64_t gpa, uint64_t size);
+
+void vm_unback_private_mem(struct kvm_vm *vm, uint64_t gpa, uint64_t size);
+
+void vm_allocate_private_mem(struct kvm_vm *vm, uint64_t gpa, uint64_t size);
+
+typedef void (*guest_code_fn)(void);
+typedef void (*io_exit_handler)(struct kvm_vm *vm, uint32_t uc_arg1);
+
+struct test_setup_info {
+	uint64_t test_area_gpa;
+	uint64_t test_area_size;
+	uint32_t test_area_slot;
+};
+
+struct vm_setup_info {
+	enum vm_mem_backing_src_type test_mem_src;
+	struct test_setup_info test_info;
+	guest_code_fn guest_fn;
+	io_exit_handler ioexit_cb;
+};
+
+void execute_vm_with_private_test_mem(struct vm_setup_info *info);
+
+#endif /* SELFTEST_KVM_PRIVATE_MEM_H */
diff --git a/tools/testing/selftests/kvm/lib/x86_64/private_mem.c b/tools/testing/selftests/kvm/lib/x86_64/private_mem.c
new file mode 100644
index 000000000000..3076cae81804
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86_64/private_mem.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * tools/testing/selftests/kvm/lib/kvm_util.c
+ *
+ * Copyright (C) 2022, Google LLC.
+ */
+#define _GNU_SOURCE /* for program_invocation_name */
+#include <fcntl.h>
+#include <limits.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/kvm_para.h>
+
+#include <test_util.h>
+#include <kvm_util.h>
+#include <private_mem.h>
+#include <processor.h>
+
+static inline uint64_t __kvm_hypercall_map_gpa_range(uint64_t gpa, uint64_t size,
+	uint64_t flags)
+{
+	return kvm_hypercall(KVM_HC_MAP_GPA_RANGE, gpa, size >> PAGE_SHIFT, flags, 0);
+}
+
+static inline void kvm_hypercall_map_gpa_range(uint64_t gpa, uint64_t size,
+	uint64_t flags)
+{
+	uint64_t ret;
+
+	GUEST_ASSERT_2(IS_PAGE_ALIGNED(gpa) && IS_PAGE_ALIGNED(size), gpa, size);
+
+	ret = __kvm_hypercall_map_gpa_range(gpa, size, flags);
+	GUEST_ASSERT_1(!ret, ret);
+}
+
+void kvm_hypercall_map_shared(uint64_t gpa, uint64_t size)
+{
+	kvm_hypercall_map_gpa_range(gpa, size, KVM_MAP_GPA_RANGE_DECRYPTED);
+}
+
+void kvm_hypercall_map_private(uint64_t gpa, uint64_t size)
+{
+	kvm_hypercall_map_gpa_range(gpa, size, KVM_MAP_GPA_RANGE_ENCRYPTED);
+}
+
+static void vm_update_private_mem(struct kvm_vm *vm, uint64_t gpa, uint64_t size,
+	bool unback_mem)
+{
+	int restricted_fd;
+	uint64_t restricted_fd_offset, guest_phys_base, fd_offset;
+	struct kvm_enc_region enc_region;
+	struct kvm_userspace_memory_region_ext *region_ext;
+	struct kvm_userspace_memory_region *region;
+	int fallocate_mode = 0;
+	int ret;
+
+	region_ext = kvm_userspace_memory_region_ext_find(vm, gpa, gpa + size);
+	TEST_ASSERT(region_ext != NULL, "Region not found");
+	region = &region_ext->region;
+	TEST_ASSERT(region->flags & KVM_MEM_PRIVATE,
+		"Can not update private memfd for non-private memslot\n");
+	restricted_fd = region_ext->restricted_fd;
+	restricted_fd_offset = region_ext->restricted_offset;
+	guest_phys_base = region->guest_phys_addr;
+	fd_offset = restricted_fd_offset + (gpa - guest_phys_base);
+
+	if (unback_mem)
+		fallocate_mode = (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
+
+	printf("restricted_fd %d fallocate_mode 0x%x for offset 0x%lx size 0x%lx\n",
+		restricted_fd, fallocate_mode, fd_offset, size);
+	ret = fallocate(restricted_fd, fallocate_mode, fd_offset, size);
+	TEST_ASSERT(ret == 0, "fallocate failed\n");
+	enc_region.addr = gpa;
+	enc_region.size = size;
+	if (unback_mem) {
+		printf("undoing encryption for gpa 0x%lx size 0x%lx\n", gpa, size);
+		vm_ioctl(vm, KVM_MEMORY_ENCRYPT_UNREG_REGION, &enc_region);
+	} else {
+		printf("doing encryption for gpa 0x%lx size 0x%lx\n", gpa, size);
+		vm_ioctl(vm, KVM_MEMORY_ENCRYPT_REG_REGION, &enc_region);
+	}
+}
+
+void vm_unback_private_mem(struct kvm_vm *vm, uint64_t gpa, uint64_t size)
+{
+	vm_update_private_mem(vm, gpa, size, true);
+}
+
+void vm_allocate_private_mem(struct kvm_vm *vm, uint64_t gpa, uint64_t size)
+{
+	vm_update_private_mem(vm, gpa, size, false);
+}
+
+static void handle_vm_exit_map_gpa_hypercall(struct kvm_vm *vm,
+				struct kvm_vcpu *vcpu)
+{
+	uint64_t gpa, npages, attrs, size;
+
+	TEST_ASSERT(vcpu->run->hypercall.nr == KVM_HC_MAP_GPA_RANGE,
+		"Unhandled Hypercall %lld\n", vcpu->run->hypercall.nr);
+	gpa = vcpu->run->hypercall.args[0];
+	npages = vcpu->run->hypercall.args[1];
+	size = npages << MIN_PAGE_SHIFT;
+	attrs = vcpu->run->hypercall.args[2];
+	pr_info("Explicit conversion off 0x%lx size 0x%lx to %s\n", gpa, size,
+		(attrs & KVM_MAP_GPA_RANGE_ENCRYPTED) ? "private" : "shared");
+
+	if (attrs & KVM_MAP_GPA_RANGE_ENCRYPTED)
+		vm_allocate_private_mem(vm, gpa, size);
+	else
+		vm_unback_private_mem(vm, gpa, size);
+
+	vcpu->run->hypercall.ret = 0;
+}
+
+static void vcpu_work(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
+	struct vm_setup_info *info)
+{
+	struct ucall uc;
+	uint64_t cmd;
+
+	/*
+	 * Loop until the guest is done.
+	 */
+
+	while (true) {
+		vcpu_run(vcpu);
+
+		if (vcpu->run->exit_reason == KVM_EXIT_IO) {
+			cmd = get_ucall(vcpu, &uc);
+			if (cmd != UCALL_SYNC)
+				break;
+
+			TEST_ASSERT(info->ioexit_cb, "ioexit cb not present");
+			info->ioexit_cb(vm, uc.args[1]);
+			continue;
+		}
+
+		if (vcpu->run->exit_reason == KVM_EXIT_HYPERCALL) {
+			handle_vm_exit_map_gpa_hypercall(vm, vcpu);
+			continue;
+		}
+
+		TEST_FAIL("Unhandled VCPU exit reason %d\n",
+			vcpu->run->exit_reason);
+		break;
+	}
+
+	if (vcpu->run->exit_reason == KVM_EXIT_IO && cmd == UCALL_ABORT)
+		TEST_FAIL("%s at %s:%ld, val = %lu", (const char *)uc.args[0],
+			  __FILE__, uc.args[1], uc.args[2]);
+}
+
+/*
+ * Execute guest vm with private memory memslots.
+ *
+ * Input Args:
+ *   info - pointer to a structure containing information about setting up a VM
+ *     with private memslots
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Function called by host userspace logic in selftests to execute guest vm
+ * logic. It will install test_mem_slot : containing the region of memory that
+ * would be used to test private/shared memory accesses to a memory backed by
+ * private memslots
+ */
+void execute_vm_with_private_test_mem(struct vm_setup_info *info)
+{
+	struct kvm_vm *vm;
+	struct kvm_enable_cap cap;
+	struct kvm_vcpu *vcpu;
+	uint64_t test_area_gpa, test_area_size;
+	struct test_setup_info *test_info = &info->test_info;
+
+	TEST_ASSERT(info->guest_fn, "guest_fn not present");
+	vm = vm_create_with_one_vcpu(&vcpu, info->guest_fn);
+
+	vm_check_cap(vm, KVM_CAP_EXIT_HYPERCALL);
+	cap.cap = KVM_CAP_EXIT_HYPERCALL;
+	cap.flags = 0;
+	cap.args[0] = (1 << KVM_HC_MAP_GPA_RANGE);
+	vm_ioctl(vm, KVM_ENABLE_CAP, &cap);
+
+	TEST_ASSERT(test_info->test_area_size, "Test mem size not present");
+
+	test_area_size = test_info->test_area_size;
+	test_area_gpa = test_info->test_area_gpa;
+	vm_userspace_mem_region_add(vm, info->test_mem_src, test_area_gpa,
+		test_info->test_area_slot, test_area_size / vm->page_size,
+		KVM_MEM_PRIVATE);
+	vm_allocate_private_mem(vm, test_area_gpa, test_area_size);
+
+	pr_info("Mapping test memory pages 0x%zx page_size 0x%x\n",
+		test_area_size/vm->page_size, vm->page_size);
+	virt_map(vm, test_area_gpa, test_area_gpa, test_area_size/vm->page_size);
+
+	vcpu_work(vm, vcpu, info);
+
+	kvm_vm_free(vm);
+}
-- 
2.38.1.431.g37b22c650d-goog

