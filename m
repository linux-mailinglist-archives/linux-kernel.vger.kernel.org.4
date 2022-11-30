Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD1663D081
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbiK3I0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbiK3IZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:25:22 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46B06F834;
        Wed, 30 Nov 2022 00:24:16 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b11so15051067pjp.2;
        Wed, 30 Nov 2022 00:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66r3FbV6ja5J9RWEoQ0luoafR1ZXpTMI7gq+vFqLhwQ=;
        b=UtP55JpGfH0eUD2B0TTW8KtnRfoX/Tdy6I8C3ZBgapt3FF9J1QHDw/VaSHB5XZeKwZ
         PIy12c0XTViNnVedEgkHnhhFAg+6fUM4TYXzMtz86dy/z2B/LCfMQD0pdDj1nVr5UJgV
         k7jJ6BUc4h7ljteEFj1mnjj9ORLKKPpFOdEYoupO5JCc0a1L7ALy/UKzaLjmevtYMP1W
         WmLNbMDKUGb+WChdJsCXZDs0EqEWNBp3SiRpQ75mOJQmQy8SmxjZGGMQiCGCIKZaw4bT
         raaxZb1AJMd8k4SLBWrntvxFq/5x+KYoKrSqAZncBh5yT7seCFcOwq7hRPxJuatZNvH4
         kCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=66r3FbV6ja5J9RWEoQ0luoafR1ZXpTMI7gq+vFqLhwQ=;
        b=GdmKINWVBrL+v9oJWDc0xh79ff9D0T0hr/IQ0O2qtS0ZHBf/HXpcNYaMb90oa4Xy0c
         0JFCqjmEoWdVTYI/RUOtFCi4jApynKEGJzjwptH1xpUsM9VM/EOZO0DaoO64Xc8btmhS
         2YdW7VxGFpi76CLgQ3kNSKwUpLosi9tE2weE2kjDnd03+93tG9bmdtiuIsyU+GCuW38A
         7uYMFwQKp3day3FNQ3LcBI2JtCq9AHX4gSrsmmDBLVAqz1amUmZNcSplWPQwOrzD4le0
         FPuwyNdjqYkPK8LWeb9wCsfzxluoWgTXv7Htw8gOf9T0HrdWCBqcwFv6uXgmnRczEMuO
         OSOg==
X-Gm-Message-State: ANoB5pn5aaNhz0zsIRww7TfzJdG2RIkmxy1IVhlS7Nud483tIVm/7b31
        tmozD5leG16TrdHx9VmaW98=
X-Google-Smtp-Source: AA0mqf4jdahVC7Kj92kgq6ruInCu+Gd+q3scD841KYbIRceeyRpwJS/WoS+AGO5m67nOq7sw0OD4ug==
X-Received: by 2002:a17:902:f80b:b0:188:4e75:7365 with SMTP id ix11-20020a170902f80b00b001884e757365mr43291661plb.102.1669796651883;
        Wed, 30 Nov 2022 00:24:11 -0800 (PST)
Received: from localhost ([2600:380:4a00:1415:d028:b547:7d35:7b0b])
        by smtp.gmail.com with ESMTPSA id o13-20020a17090a0a0d00b0021896fa945asm2589253pjo.15.2022.11.30.00.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:24:11 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 16/31] sched_ext: Add scx_example_dummy and scx_example_qmap example schedulers
Date:   Tue, 29 Nov 2022 22:22:58 -1000
Message-Id: <20221130082313.3241517-17-tj@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130082313.3241517-1-tj@kernel.org>
References: <20221130082313.3241517-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two simple example BPF schedulers - dummy and qmap.

* dummy: In terms of scheduling, it behaves identical to not having any
  operation implemented at all. The two operations it implements are only to
  improve visibility and exit handling. On certain homogeneous
  configurations, this actually can perform pretty well.

* qmap: A fixed five level priority scheduler to demonstrate queueing PIDs
  on BPF maps for scheduling. While not very practical, this is useful as a
  simple example and will be used to demonstrate different features.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 tools/sched_ext/.gitignore              |   5 +
 tools/sched_ext/Makefile                | 187 +++++++++++++++++++
 tools/sched_ext/gnu/stubs.h             |   1 +
 tools/sched_ext/scx_common.bpf.h        | 117 ++++++++++++
 tools/sched_ext/scx_example_dummy.bpf.c |  56 ++++++
 tools/sched_ext/scx_example_dummy.c     |  93 ++++++++++
 tools/sched_ext/scx_example_qmap.bpf.c  | 228 ++++++++++++++++++++++++
 tools/sched_ext/scx_example_qmap.c      |  84 +++++++++
 tools/sched_ext/user_exit_info.h        |  50 ++++++
 9 files changed, 821 insertions(+)
 create mode 100644 tools/sched_ext/.gitignore
 create mode 100644 tools/sched_ext/Makefile
 create mode 100644 tools/sched_ext/gnu/stubs.h
 create mode 100644 tools/sched_ext/scx_common.bpf.h
 create mode 100644 tools/sched_ext/scx_example_dummy.bpf.c
 create mode 100644 tools/sched_ext/scx_example_dummy.c
 create mode 100644 tools/sched_ext/scx_example_qmap.bpf.c
 create mode 100644 tools/sched_ext/scx_example_qmap.c
 create mode 100644 tools/sched_ext/user_exit_info.h

diff --git a/tools/sched_ext/.gitignore b/tools/sched_ext/.gitignore
new file mode 100644
index 000000000000..6734f7fd9324
--- /dev/null
+++ b/tools/sched_ext/.gitignore
@@ -0,0 +1,5 @@
+scx_example_dummy
+scx_example_qmap
+*.skel.h
+*.subskel.h
+/tools/
diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
new file mode 100644
index 000000000000..db99745e566d
--- /dev/null
+++ b/tools/sched_ext/Makefile
@@ -0,0 +1,187 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+include ../build/Build.include
+include ../scripts/Makefile.arch
+include ../scripts/Makefile.include
+
+ifneq ($(LLVM),)
+ifneq ($(filter %/,$(LLVM)),)
+LLVM_PREFIX := $(LLVM)
+else ifneq ($(filter -%,$(LLVM)),)
+LLVM_SUFFIX := $(LLVM)
+endif
+
+CLANG_TARGET_FLAGS_arm          := arm-linux-gnueabi
+CLANG_TARGET_FLAGS_arm64        := aarch64-linux-gnu
+CLANG_TARGET_FLAGS_hexagon      := hexagon-linux-musl
+CLANG_TARGET_FLAGS_m68k         := m68k-linux-gnu
+CLANG_TARGET_FLAGS_mips         := mipsel-linux-gnu
+CLANG_TARGET_FLAGS_powerpc      := powerpc64le-linux-gnu
+CLANG_TARGET_FLAGS_riscv        := riscv64-linux-gnu
+CLANG_TARGET_FLAGS_s390         := s390x-linux-gnu
+CLANG_TARGET_FLAGS_x86          := x86_64-linux-gnu
+CLANG_TARGET_FLAGS              := $(CLANG_TARGET_FLAGS_$(ARCH))
+
+ifeq ($(CROSS_COMPILE),)
+ifeq ($(CLANG_TARGET_FLAGS),)
+$(error Specify CROSS_COMPILE or add '--target=' option to lib.mk
+else
+CLANG_FLAGS     += --target=$(CLANG_TARGET_FLAGS)
+endif # CLANG_TARGET_FLAGS
+else
+CLANG_FLAGS     += --target=$(notdir $(CROSS_COMPILE:%-=%))
+endif # CROSS_COMPILE
+
+CC := $(LLVM_PREFIX)clang$(LLVM_SUFFIX) $(CLANG_FLAGS) -fintegrated-as
+else
+CC := $(CROSS_COMPILE)gcc
+endif # LLVM
+
+CURDIR := $(abspath .)
+TOOLSDIR := $(abspath ..)
+LIBDIR := $(TOOLSDIR)/lib
+BPFDIR := $(LIBDIR)/bpf
+TOOLSINCDIR := $(TOOLSDIR)/include
+BPFTOOLDIR := $(TOOLSDIR)/bpf/bpftool
+APIDIR := $(TOOLSINCDIR)/uapi
+GENDIR := $(abspath ../../include/generated)
+GENHDR := $(GENDIR)/autoconf.h
+
+SCRATCH_DIR := $(CURDIR)/tools
+BUILD_DIR := $(SCRATCH_DIR)/build
+INCLUDE_DIR := $(SCRATCH_DIR)/include
+BPFOBJ := $(BUILD_DIR)/libbpf/libbpf.a
+ifneq ($(CROSS_COMPILE),)
+HOST_BUILD_DIR		:= $(BUILD_DIR)/host
+HOST_SCRATCH_DIR	:= host-tools
+HOST_INCLUDE_DIR	:= $(HOST_SCRATCH_DIR)/include
+else
+HOST_BUILD_DIR		:= $(BUILD_DIR)
+HOST_SCRATCH_DIR	:= $(SCRATCH_DIR)
+HOST_INCLUDE_DIR	:= $(INCLUDE_DIR)
+endif
+HOST_BPFOBJ := $(HOST_BUILD_DIR)/libbpf/libbpf.a
+RESOLVE_BTFIDS := $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
+DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
+
+VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)					\
+		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)		\
+		     ../../vmlinux						\
+		     /sys/kernel/btf/vmlinux					\
+		     /boot/vmlinux-$(shell uname -r)
+VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
+ifeq ($(VMLINUX_BTF),)
+$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)")
+endif
+
+BPFTOOL ?= $(DEFAULT_BPFTOOL)
+
+ifneq ($(wildcard $(GENHDR)),)
+  GENFLAGS := -DHAVE_GENHDR
+endif
+
+CFLAGS += -g -O2 -rdynamic -pthread -Wall -Werror $(GENFLAGS)			\
+	  -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)				\
+	  -I$(TOOLSINCDIR) -I$(APIDIR)
+
+# Silence some warnings when compiled with clang
+ifneq ($(LLVM),)
+CFLAGS += -Wno-unused-command-line-argument
+endif
+
+LDFLAGS = -lelf -lz
+
+IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null |				\
+			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
+
+# Get Clang's default includes on this system, as opposed to those seen by
+# '-target bpf'. This fixes "missing" files on some architectures/distros,
+# such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
+#
+# Use '-idirafter': Don't interfere with include mechanics except where the
+# build would have failed anyways.
+define get_sys_includes
+$(shell $(1) -v -E - </dev/null 2>&1 \
+	| sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
+$(shell $(1) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{printf("-D__riscv_xlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}')
+endef
+
+BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH)					\
+	     $(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)		\
+	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)				\
+	     -I../../include							\
+	     $(call get_sys_includes,$(CLANG))					\
+	     -Wno-compare-distinct-pointer-types				\
+	     -O2 -mcpu=v3
+
+all: scx_example_dummy scx_example_qmap
+
+# sort removes libbpf duplicates when not cross-building
+MAKE_DIRS := $(sort $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf		\
+	       $(HOST_BUILD_DIR)/bpftool $(HOST_BUILD_DIR)/resolve_btfids	\
+	       $(INCLUDE_DIR))
+
+$(MAKE_DIRS):
+	$(call msg,MKDIR,,$@)
+	$(Q)mkdir -p $@
+
+$(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)			\
+	   $(APIDIR)/linux/bpf.h						\
+	   | $(BUILD_DIR)/libbpf
+	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/	\
+		    EXTRA_CFLAGS='-g -O0'					\
+		    DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
+
+$(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)	\
+		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
+	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)				\
+		    ARCH= CROSS_COMPILE= CC=$(HOSTCC) LD=$(HOSTLD)		\
+		    EXTRA_CFLAGS='-g -O0'					\
+		    OUTPUT=$(HOST_BUILD_DIR)/bpftool/				\
+		    LIBBPF_OUTPUT=$(HOST_BUILD_DIR)/libbpf/			\
+		    LIBBPF_DESTDIR=$(HOST_SCRATCH_DIR)/				\
+		    prefix= DESTDIR=$(HOST_SCRATCH_DIR)/ install-bin
+
+$(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
+ifeq ($(VMLINUX_H),)
+	$(call msg,GEN,,$@)
+	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
+else
+	$(call msg,CP,,$@)
+	$(Q)cp "$(VMLINUX_H)" $@
+endif
+
+%.bpf.o: %.bpf.c $(INCLUDE_DIR)/vmlinux.h scx_common.bpf.h user_exit_info.h	\
+	| $(BPFOBJ)
+	$(call msg,CLNG-BPF,,$@)
+	$(Q)$(CLANG) $(BPF_CFLAGS) -target bpf -c $< -o $@
+
+%.skel.h: %.bpf.o $(BPFTOOL)
+	$(call msg,GEN-SKEL,,$@)
+	$(Q)$(BPFTOOL) gen object $(<:.o=.linked1.o) $<
+	$(Q)$(BPFTOOL) gen object $(<:.o=.linked2.o) $(<:.o=.linked1.o)
+	$(Q)$(BPFTOOL) gen object $(<:.o=.linked3.o) $(<:.o=.linked2.o)
+	$(Q)diff $(<:.o=.linked2.o) $(<:.o=.linked3.o)
+	$(Q)$(BPFTOOL) gen skeleton $(<:.o=.linked3.o) name $(<:.bpf.o=) > $@
+	$(Q)$(BPFTOOL) gen subskeleton $(<:.o=.linked3.o) name $(<:.bpf.o=) > $(@:.skel.h=.subskel.h)
+
+scx_example_dummy: scx_example_dummy.c scx_example_dummy.skel.h user_exit_info.h
+	$(CC) $(CFLAGS) -c $< -o $@.o
+	$(CC) -o $@ $@.o $(HOST_BPFOBJ) $(LDFLAGS)
+
+scx_example_qmap: scx_example_qmap.c scx_example_qmap.skel.h user_exit_info.h
+	$(CC) $(CFLAGS) -c $< -o $@.o
+	$(CC) -o $@ $@.o $(HOST_BPFOBJ) $(LDFLAGS)
+
+clean:
+	rm -rf $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)
+	rm -f *.o *.bpf.o *.skel.h *.subskel.h
+	rm -f scx_example_dummy scx_example_qmap
+
+.PHONY: all clean
+
+# delete failed targets
+.DELETE_ON_ERROR:
+
+# keep intermediate (.skel.h, .bpf.o, etc) targets
+.SECONDARY:
diff --git a/tools/sched_ext/gnu/stubs.h b/tools/sched_ext/gnu/stubs.h
new file mode 100644
index 000000000000..719225b16626
--- /dev/null
+++ b/tools/sched_ext/gnu/stubs.h
@@ -0,0 +1 @@
+/* dummy .h to trick /usr/include/features.h to work with 'clang -target bpf' */
diff --git a/tools/sched_ext/scx_common.bpf.h b/tools/sched_ext/scx_common.bpf.h
new file mode 100644
index 000000000000..4cfbbee38d9a
--- /dev/null
+++ b/tools/sched_ext/scx_common.bpf.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#ifndef __SCHED_EXT_COMMON_BPF_H
+#define __SCHED_EXT_COMMON_BPF_H
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <linux/errno.h>
+#include "user_exit_info.h"
+
+/*
+ * Earlier versions of clang/pahole lost upper 32bits in 64bit enums which can
+ * lead to really confusing misbehaviors. Let's trigger a build failure.
+ */
+static inline void ___vmlinux_h_sanity_check___(void)
+{
+	_Static_assert(SCX_DSQ_FLAG_BUILTIN,
+		       "bpftool generated vmlinux.h is missing high bits for 64bit enums, upgrade clang and pahole");
+}
+
+extern void scx_bpf_error_bstr(char *fmt, unsigned long long *data, u32 data_len) __ksym;
+
+static inline __attribute__((format(printf, 1, 2)))
+void ___scx_bpf_error_format_checker(const char *fmt, ...) {}
+
+/*
+ * scx_bpf_error() wraps the scx_bpf_error_bstr() kfunc with variadic arguments
+ * instead of an array of u64. Note that __param[] must have at least one
+ * element to keep the verifier happy.
+ */
+#define scx_bpf_error(fmt, args...)						\
+({										\
+	static char ___fmt[] = fmt;						\
+	unsigned long long ___param[___bpf_narg(args) ?: 1] = {};		\
+										\
+	_Pragma("GCC diagnostic push")						\
+	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")			\
+	___bpf_fill(___param, args);						\
+	_Pragma("GCC diagnostic pop")						\
+										\
+	scx_bpf_error_bstr(___fmt, ___param, sizeof(___param));			\
+										\
+	___scx_bpf_error_format_checker(fmt, ##args);				\
+})
+
+extern s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
+extern bool scx_bpf_consume(u64 dsq_id) __ksym;
+extern u32 scx_bpf_dispatch_nr_slots(void) __ksym;
+extern void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym;
+extern s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
+extern bool scx_bpf_test_and_clear_cpu_idle(s32 cpu) __ksym;
+extern s32 scx_bpf_pick_idle_cpu(const cpumask_t *cpus_allowed) __ksym;
+extern void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
+extern bool scx_bpf_task_running(const struct task_struct *p) __ksym;
+extern s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
+
+/* XXX - temporary ones to be replaced by generic BPF helpers */
+extern struct cgroup *scx_bpf_task_cgroup(const struct task_struct *p) __ksym;
+extern struct task_struct *scx_bpf_find_task_by_pid(s32 pid) __ksym;
+extern s32 scx_bpf_pick_idle_cpu_untyped(unsigned long cpus_allowed) __ksym;
+extern bool scx_bpf_has_idle_cpus_among(const struct cpumask *cpus_allowed) __ksym;
+extern bool scx_bpf_has_idle_cpus_among_untyped(unsigned long cpus_allowed) __ksym;
+extern s32 scx_bpf_cpumask_test_cpu(s32 cpu, const struct cpumask *cpumask) __ksym;
+extern s32 scx_bpf_cpumask_first(const struct cpumask *cpus_allowed) __ksym;
+extern s32 scx_bpf_cpumask_first_untyped(unsigned long cpus_allowed) __ksym;
+extern bool scx_bpf_cpumask_intersects(const struct cpumask *src1p, const struct cpumask *src2p) __ksym;
+
+#define PF_KTHREAD			0x00200000	/* I am a kernel thread */
+#define PF_EXITING			0x00000004
+#define CLOCK_MONOTONIC			1
+
+#define BPF_STRUCT_OPS(name, args...)						\
+SEC("struct_ops/"#name)								\
+BPF_PROG(name, ##args)
+
+/**
+ * MEMBER_VPTR - Obtain the verified pointer to a struct or array member
+ * @base: struct or array to index
+ * @member: dereferenced member (e.g. ->field, [idx0][idx1], ...)
+ *
+ * The verifier often gets confused by the instruction sequence the compiler
+ * generates for indexing struct fields or arrays. This macro forces the
+ * compiler to generate a code sequence which first calculates the byte offset,
+ * checks it against the struct or array size and add that byte offset to
+ * generate the pointer to the member to help the verifier.
+ *
+ * Ideally, we want to abort if the calculated offset is out-of-bounds. However,
+ * BPF currently doesn't support abort, so evaluate to NULL instead. The caller
+ * must check for NULL and take appropriate action to appease the verifier. To
+ * avoid confusing the verifier, it's best to check for NULL and dereference
+ * immediately.
+ *
+ *	vptr = MEMBER_VPTR(my_array, [i][j]);
+ *	if (!vptr)
+ *		return error;
+ *	*vptr = new_value;
+ */
+#define MEMBER_VPTR(base, member) (typeof(base member) *)({			\
+	u64 __base = (u64)base;							\
+	u64 __addr = (u64)&(base member) - __base;				\
+	asm volatile (								\
+		"if %0 <= %[max] goto +2\n"					\
+		"%0 = 0\n"							\
+		"goto +1\n"							\
+		"%0 += %1\n"							\
+		: "+r"(__addr)							\
+		: "r"(__base),							\
+		  [max]"i"(sizeof(base) - sizeof(base member)));		\
+	__addr;									\
+})
+
+#endif	/* __SCHED_EXT_COMMON_BPF_H */
diff --git a/tools/sched_ext/scx_example_dummy.bpf.c b/tools/sched_ext/scx_example_dummy.bpf.c
new file mode 100644
index 000000000000..ac7b490b5a39
--- /dev/null
+++ b/tools/sched_ext/scx_example_dummy.bpf.c
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A minimal dummy scheduler.
+ *
+ * In terms of scheduling, this behaves the same as not specifying any ops at
+ * all - a global FIFO. The only things it adds are the following niceties:
+ *
+ * - Statistics tracking how many are queued to local and global dsq's.
+ * - Termination notification for userspace.
+ *
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#include "scx_common.bpf.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct user_exit_info uei;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(u32));
+	__uint(value_size, sizeof(u64));
+	__uint(max_entries, 2);			/* [local, global] */
+} stats SEC(".maps");
+
+static void stat_inc(u32 idx)
+{
+	u64 *cnt_p = bpf_map_lookup_elem(&stats, &idx);
+	if (cnt_p)
+		(*cnt_p)++;
+}
+
+void BPF_STRUCT_OPS(dummy_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	if (enq_flags & SCX_ENQ_LOCAL) {
+		stat_inc(0);
+		scx_bpf_dispatch(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
+	} else {
+		stat_inc(1);
+		scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+	}
+}
+
+void BPF_STRUCT_OPS(dummy_exit, struct scx_exit_info *ei)
+{
+	uei_record(&uei, ei);
+}
+
+SEC(".struct_ops")
+struct sched_ext_ops dummy_ops = {
+	.enqueue		= (void *)dummy_enqueue,
+	.exit			= (void *)dummy_exit,
+	.name			= "dummy",
+};
diff --git a/tools/sched_ext/scx_example_dummy.c b/tools/sched_ext/scx_example_dummy.c
new file mode 100644
index 000000000000..72881c881830
--- /dev/null
+++ b/tools/sched_ext/scx_example_dummy.c
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <unistd.h>
+#include <signal.h>
+#include <assert.h>
+#include <libgen.h>
+#include <bpf/bpf.h>
+#include "user_exit_info.h"
+#include "scx_example_dummy.skel.h"
+
+const char help_fmt[] =
+"A minimal dummy sched_ext scheduler.\n"
+"\n"
+"See the top-level comment in .bpf.c for more details.\n"
+"\n"
+"Usage: %s\n"
+"\n"
+"  -h            Display this help and exit\n";
+
+static volatile int exit_req;
+
+static void sigint_handler(int dummy)
+{
+	exit_req = 1;
+}
+
+static void read_stats(struct scx_example_dummy *skel, u64 *stats)
+{
+	int nr_cpus = libbpf_num_possible_cpus();
+	u64 cnts[2][nr_cpus];
+	u32 idx;
+
+	memset(stats, 0, sizeof(stats[0]) * 2);
+
+	for (idx = 0; idx < 2; idx++) {
+		int ret, cpu;
+
+		ret = bpf_map_lookup_elem(bpf_map__fd(skel->maps.stats),
+					  &idx, cnts[idx]);
+		if (ret < 0)
+			continue;
+		for (cpu = 0; cpu < nr_cpus; cpu++)
+			stats[idx] += cnts[idx][cpu];
+	}
+}
+
+int main(int argc, char **argv)
+{
+	struct scx_example_dummy *skel;
+	struct bpf_link *link;
+	u32 opt;
+
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
+
+	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
+
+	skel = scx_example_dummy__open();
+	assert(skel);
+
+	while ((opt = getopt(argc, argv, "h")) != -1) {
+		switch (opt) {
+		default:
+			fprintf(stderr, help_fmt, basename(argv[0]));
+			return opt != 'h';
+		}
+	}
+
+	assert(!scx_example_dummy__load(skel));
+
+	link = bpf_map__attach_struct_ops(skel->maps.dummy_ops);
+	assert(link);
+
+	while (!exit_req && !uei_exited(&skel->bss->uei)) {
+		u64 stats[2];
+
+		read_stats(skel, stats);
+		printf("local=%lu global=%lu\n", stats[0], stats[1]);
+		fflush(stdout);
+		sleep(1);
+	}
+
+	bpf_link__destroy(link);
+	uei_print(&skel->bss->uei);
+	scx_example_dummy__destroy(skel);
+	return 0;
+}
diff --git a/tools/sched_ext/scx_example_qmap.bpf.c b/tools/sched_ext/scx_example_qmap.bpf.c
new file mode 100644
index 000000000000..742c866d2a8e
--- /dev/null
+++ b/tools/sched_ext/scx_example_qmap.bpf.c
@@ -0,0 +1,228 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A simple five-level FIFO queue scheduler.
+ *
+ * There are five FIFOs implemented using BPF_MAP_TYPE_QUEUE. A task gets
+ * assigned to one depending on its compound weight. Each CPU round robins
+ * through the FIFOs and dispatches more from FIFOs with higher indices - 1 from
+ * queue0, 2 from queue1, 4 from queue2 and so on.
+ *
+ * This scheduler demonstrates:
+ *
+ * - BPF-side queueing using PIDs.
+ * - Sleepable per-task storage allocation using ops.prep_enable().
+ *
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#include "scx_common.bpf.h"
+#include <linux/sched/prio.h>
+
+char _license[] SEC("license") = "GPL";
+
+const volatile u64 slice_ns = SCX_SLICE_DFL;
+
+u32 test_error_cnt;
+
+struct user_exit_info uei;
+
+struct qmap {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, 4096);
+	__type(value, u32);
+} queue0 SEC(".maps"),
+  queue1 SEC(".maps"),
+  queue2 SEC(".maps"),
+  queue3 SEC(".maps"),
+  queue4 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 5);
+	__type(key, int);
+	__array(values, struct qmap);
+} queue_arr SEC(".maps") = {
+	.values = {
+		[0] = &queue0,
+		[1] = &queue1,
+		[2] = &queue2,
+		[3] = &queue3,
+		[4] = &queue4,
+	},
+};
+
+/* Per-task scheduling context */
+struct task_ctx {
+	bool	force_local;	/* Dispatch directly to local_dsq */
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct task_ctx);
+} task_ctx_stor SEC(".maps");
+
+/* Per-cpu dispatch index and remaining count */
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 2);
+	__type(key, u32);
+	__type(value, u64);
+} dispatch_idx_cnt SEC(".maps");
+
+/* Statistics */
+unsigned long nr_enqueued, nr_dispatched, nr_reenqueued;
+
+s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	struct task_ctx *tctx;
+	s32 cpu;
+
+	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+	if (!tctx) {
+		scx_bpf_error("task_ctx lookup failed");
+		return -ESRCH;
+	}
+
+	if (p->nr_cpus_allowed == 1 ||
+	    scx_bpf_test_and_clear_cpu_idle(prev_cpu)) {
+		tctx->force_local = true;
+		return prev_cpu;
+	}
+
+	cpu = scx_bpf_pick_idle_cpu(p->cpus_ptr);
+	if (cpu >= 0)
+		return cpu;
+
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	struct task_ctx *tctx;
+	u32 pid = p->pid;
+	int idx;
+	void *ring;
+
+	if (test_error_cnt && !--test_error_cnt)
+		scx_bpf_error("test triggering error");
+
+	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+	if (!tctx) {
+		scx_bpf_error("task_ctx lookup failed");
+		return;
+	}
+
+	/* Is select_cpu() is telling us to enqueue locally? */
+	if (tctx->force_local) {
+		tctx->force_local = false;
+		scx_bpf_dispatch(p, SCX_DSQ_LOCAL, slice_ns, enq_flags);
+		return;
+	}
+
+	/* Coarsely map the compount weight to a FIFO. */
+	if (p->scx.weight <= 25)
+		idx = 0;
+	else if (p->scx.weight <= 50)
+		idx = 1;
+	else if (p->scx.weight < 200)
+		idx = 2;
+	else if (p->scx.weight < 400)
+		idx = 3;
+	else
+		idx = 4;
+
+	ring = bpf_map_lookup_elem(&queue_arr, &idx);
+	if (!ring) {
+		scx_bpf_error("failed to find ring %d", idx);
+		return;
+	}
+
+	/* Queue on the selected FIFO. If the FIFO overflows, punt to global. */
+	if (bpf_map_push_elem(ring, &pid, 0)) {
+		scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, slice_ns, enq_flags);
+		return;
+	}
+
+	__sync_fetch_and_add(&nr_enqueued, 1);
+}
+
+void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
+{
+	u32 zero = 0, one = 1;
+	u64 *idx = bpf_map_lookup_elem(&dispatch_idx_cnt, &zero);
+	u64 *cnt = bpf_map_lookup_elem(&dispatch_idx_cnt, &one);
+	void *fifo;
+	s32 pid;
+	int i;
+
+	if (!idx || !cnt) {
+		scx_bpf_error("failed to lookup idx[%p], cnt[%p]", idx, cnt);
+		return;
+	}
+
+	for (i = 0; i < 5; i++) {
+		/* Advance the dispatch cursor and pick the fifo. */
+		if (!*cnt) {
+			*idx = (*idx + 1) % 5;
+			*cnt = 1 << *idx;
+		}
+		(*cnt)--;
+
+		fifo = bpf_map_lookup_elem(&queue_arr, idx);
+		if (!fifo) {
+			scx_bpf_error("failed to find ring %llu", *idx);
+			return;
+		}
+
+		/* Dispatch or advance. */
+		if (!bpf_map_pop_elem(fifo, &pid)) {
+			struct task_struct *p;
+
+			p = scx_bpf_find_task_by_pid(pid);
+			if (p) {
+				__sync_fetch_and_add(&nr_dispatched, 1);
+				scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, slice_ns, 0);
+				return;
+			}
+		}
+
+		*cnt = 0;
+	}
+}
+
+s32 BPF_STRUCT_OPS(qmap_prep_enable, struct task_struct *p,
+		   struct scx_enable_args *args)
+{
+	/*
+	 * @p is new. Let's ensure that its task_ctx is available. We can sleep
+	 * in this function and the following will automatically use GFP_KERNEL.
+	 */
+	if (bpf_task_storage_get(&task_ctx_stor, p, 0,
+				 BPF_LOCAL_STORAGE_GET_F_CREATE))
+		return 0;
+	else
+		return -ENOMEM;
+}
+
+void BPF_STRUCT_OPS(qmap_exit, struct scx_exit_info *ei)
+{
+	uei_record(&uei, ei);
+}
+
+SEC(".struct_ops")
+struct sched_ext_ops qmap_ops = {
+	.select_cpu		= (void *)qmap_select_cpu,
+	.enqueue		= (void *)qmap_enqueue,
+	/*
+	 * The queue map doesn't support removal and sched_ext can handle
+	 * spurious dispatches. Let's be lazy and not bother with dequeueing.
+	 */
+	.dispatch		= (void *)qmap_dispatch,
+	.prep_enable		= (void *)qmap_prep_enable,
+	.exit			= (void *)qmap_exit,
+	.name			= "qmap",
+};
diff --git a/tools/sched_ext/scx_example_qmap.c b/tools/sched_ext/scx_example_qmap.c
new file mode 100644
index 000000000000..c5a208533404
--- /dev/null
+++ b/tools/sched_ext/scx_example_qmap.c
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <signal.h>
+#include <assert.h>
+#include <libgen.h>
+#include <bpf/bpf.h>
+#include "user_exit_info.h"
+#include "scx_example_qmap.skel.h"
+
+const char help_fmt[] =
+"A simple five-level FIFO queue sched_ext scheduler.\n"
+"\n"
+"See the top-level comment in .bpf.c for more details.\n"
+"\n"
+"Usage: %s [-s SLICE_US] [-e COUNT]\n"
+"\n"
+"  -s SLICE_US   Override slice duration\n"
+"  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
+"  -h            Display this help and exit\n";
+
+static volatile int exit_req;
+
+static void sigint_handler(int dummy)
+{
+	exit_req = 1;
+}
+
+int main(int argc, char **argv)
+{
+	struct scx_example_qmap *skel;
+	struct bpf_link *link;
+	int opt;
+
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
+
+	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
+
+	skel = scx_example_qmap__open();
+	assert(skel);
+
+	while ((opt = getopt(argc, argv, "hs:e:tTd:")) != -1) {
+		switch (opt) {
+		case 's':
+			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
+			break;
+		case 'e':
+			skel->bss->test_error_cnt = strtoull(optarg, NULL, 0);
+			break;
+		default:
+			fprintf(stderr, help_fmt, basename(argv[0]));
+			return opt != 'h';
+		}
+	}
+
+	assert(!scx_example_qmap__load(skel));
+
+	link = bpf_map__attach_struct_ops(skel->maps.qmap_ops);
+	assert(link);
+
+	while (!exit_req && !uei_exited(&skel->bss->uei)) {
+		long nr_enqueued = skel->bss->nr_enqueued;
+		long nr_dispatched = skel->bss->nr_dispatched;
+
+		printf("enq=%lu, dsp=%lu, delta=%ld, reenq=%lu\n",
+		       nr_enqueued, nr_dispatched, nr_enqueued - nr_dispatched,
+		       skel->bss->nr_reenqueued);
+		fflush(stdout);
+		sleep(1);
+	}
+
+	bpf_link__destroy(link);
+	uei_print(&skel->bss->uei);
+	scx_example_qmap__destroy(skel);
+	return 0;
+}
diff --git a/tools/sched_ext/user_exit_info.h b/tools/sched_ext/user_exit_info.h
new file mode 100644
index 000000000000..e701ef0e0b86
--- /dev/null
+++ b/tools/sched_ext/user_exit_info.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Define struct user_exit_info which is shared between BPF and userspace parts
+ * to communicate exit status and other information.
+ *
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#ifndef __USER_EXIT_INFO_H
+#define __USER_EXIT_INFO_H
+
+struct user_exit_info {
+	int		type;
+	char		reason[128];
+	char		msg[1024];
+};
+
+#ifdef __bpf__
+
+#include "vmlinux.h"
+#include <bpf/bpf_core_read.h>
+
+static inline void uei_record(struct user_exit_info *uei,
+			      const struct scx_exit_info *ei)
+{
+	bpf_probe_read_kernel_str(uei->reason, sizeof(uei->reason), ei->reason);
+	bpf_probe_read_kernel_str(uei->msg, sizeof(uei->msg), ei->msg);
+	/* use __sync to force memory barrier */
+	__sync_val_compare_and_swap(&uei->type, uei->type, ei->type);
+}
+
+#else	/* !__bpf__ */
+
+static inline bool uei_exited(struct user_exit_info *uei)
+{
+	/* use __sync to force memory barrier */
+	return __sync_val_compare_and_swap(&uei->type, -1, -1);
+}
+
+static inline void uei_print(const struct user_exit_info *uei)
+{
+	fprintf(stderr, "EXIT: %s", uei->reason);
+	if (uei->msg[0] != '\0')
+		fprintf(stderr, " (%s)", uei->msg);
+	fputs("\n", stderr);
+}
+
+#endif	/* __bpf__ */
+#endif	/* __USER_EXIT_INFO_H */
-- 
2.38.1

