Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155D16BF46A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjCQVhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjCQVgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:36:44 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375DA4D61E;
        Fri, 17 Mar 2023 14:35:53 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id le6so6656759plb.12;
        Fri, 17 Mar 2023 14:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfPZRaQhAGV0+TtwXcTY1QoPs114DP7+uwpO1Fv/2Zk=;
        b=XS+tueJnHC4weybJL77Vcq5V76nkonB5LBf+xd6zIvZLQJmc8xKmuTToja+lWDavjN
         ziI1N9xdhP0KeXYj78f+BuvP5kCDFZ1RSzffwwSQ8NvnxYHYBB+r7uEDigSoRYUIp8jX
         sEHrFKXL8/pSVkWz0hWRlkKdJclhr+84AADyOrz7eLFemGpuXTWxAYZxdUE0iCahIXhJ
         w3I+E74MwGBMBPYSwDiEKnOl6xbU57ETplgNa7huX3q20YAenQdBBGNGqVNoXbhxSAAz
         TuP/GdhfO+eVD6XRpsQ/7AT794CevcqrlMNTSF6Z04HGLvVPQ2CHF38bxBdHqlSZTqaY
         1vUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tfPZRaQhAGV0+TtwXcTY1QoPs114DP7+uwpO1Fv/2Zk=;
        b=4WlspRL53vVSxEdVHqSdEKMVIttM/NWwU4ybzO7+TXWJqn3Gkax6+HF9v/ZoQaxNUU
         4qxjaEy7rwMaGzqMZb/qVHMJLeCnBmxIaXcacwday6tfpVB5vDX/8W16PftGMm0BiV6T
         gC0OdaudKLWY/hh7byKjHsbhSh3buPZttnZ2LrRjhrzUjH5IL/Xs9ARkQofaebgStXrQ
         ZU21sqCfvXFpbdR1GwxujoNGI/lnE2tpz/egEzgDdDqTrqBXzuxvBi75AzM8j4lBumx9
         gbZxmI09YZqZVFWIf0yb2Sg42Pnj0h1m5R9L0YJEkOohFLBtFtrAVBCqE2av+9KvDPUP
         sXcw==
X-Gm-Message-State: AO0yUKVMF9Ot1OoVq5LKZIuY9sMMOppDf+a7XVBRnsGTGq5GfSJN2ttq
        xIss7OfAwSTDfpl6xCDDvOw=
X-Google-Smtp-Source: AK7set/yGarvH/ZEgoERiTYPHL6Z2wFbc+F/CK5kIG4kUQjl9AAQvbb/5tBnYagqW3TUhVLg9YA3dg==
X-Received: by 2002:a17:903:1111:b0:1a1:903f:de61 with SMTP id n17-20020a170903111100b001a1903fde61mr8271945plh.63.1679088881383;
        Fri, 17 Mar 2023 14:34:41 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id je19-20020a170903265300b0019f3e339fb4sm1973148plb.187.2023.03.17.14.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:34:41 -0700 (PDT)
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
Subject: [PATCH 32/32] sched_ext: Add a rust userspace hybrid example scheduler
Date:   Fri, 17 Mar 2023 11:33:33 -1000
Message-Id: <20230317213333.2174969-33-tj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317213333.2174969-1-tj@kernel.org>
References: <20230317213333.2174969-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Schatzberg <dschatzberg@meta.com>

Atropos is a multi-domain BPF / userspace hybrid scheduler where the BPF
part does simple round robin in each domain and the userspace part
calculates the load factor of each domain and tells the BPF part how to load
balance the domains.

This scheduler demonstrates dividing scheduling logic between BPF and
userspace and using rust to build the userspace part. An earlier variant of
this scheduler was used to balance across six domains, each representing a
chiplet in a six-chiplet AMD processor, and could match the performance of
production setup using CFS.

v3: * The userspace code is substantially restructured and rewritten. The
      binary is renamed to scx_atropos and can now figure out the domain
      topology automatically based on L3 cache configuration. The LB logic
      which was rather broken in the previous postings are revamped and
      should behave better.

    * Updated to support weighted vtime scheduling (can be turned off with
      --fifo-sched). Added a couple options (--slice_us, --kthreads-local)
      to modify scheduling behaviors.

    * Converted to use BPF inline iterators.

v2: * Updated to use generic BPF cpumask helpers.

Signed-off-by: Dan Schatzberg <dschatzberg@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/Makefile                      |  13 +-
 tools/sched_ext/atropos/.gitignore            |   3 +
 tools/sched_ext/atropos/Cargo.toml            |  28 +
 tools/sched_ext/atropos/build.rs              |  70 ++
 tools/sched_ext/atropos/rustfmt.toml          |   8 +
 tools/sched_ext/atropos/src/atropos_sys.rs    |  10 +
 tools/sched_ext/atropos/src/bpf/atropos.bpf.c | 751 ++++++++++++++
 tools/sched_ext/atropos/src/bpf/atropos.h     |  44 +
 tools/sched_ext/atropos/src/main.rs           | 942 ++++++++++++++++++
 9 files changed, 1867 insertions(+), 2 deletions(-)
 create mode 100644 tools/sched_ext/atropos/.gitignore
 create mode 100644 tools/sched_ext/atropos/Cargo.toml
 create mode 100644 tools/sched_ext/atropos/build.rs
 create mode 100644 tools/sched_ext/atropos/rustfmt.toml
 create mode 100644 tools/sched_ext/atropos/src/atropos_sys.rs
 create mode 100644 tools/sched_ext/atropos/src/bpf/atropos.bpf.c
 create mode 100644 tools/sched_ext/atropos/src/bpf/atropos.h
 create mode 100644 tools/sched_ext/atropos/src/main.rs

diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
index 71b5809243e3..73c43782837d 100644
--- a/tools/sched_ext/Makefile
+++ b/tools/sched_ext/Makefile
@@ -85,6 +85,8 @@ CFLAGS += -g -O2 -rdynamic -pthread -Wall -Werror $(GENFLAGS)			\
 	  -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)				\
 	  -I$(TOOLSINCDIR) -I$(APIDIR)
 
+CARGOFLAGS := --release
+
 # Silence some warnings when compiled with clang
 ifneq ($(LLVM),)
 CFLAGS += -Wno-unused-command-line-argument
@@ -116,7 +118,7 @@ BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH)					\
 	     -O2 -mcpu=v3
 
 all: scx_example_simple scx_example_qmap scx_example_central scx_example_pair	\
-     scx_example_flatcg scx_example_userland
+     scx_example_flatcg scx_example_userland atropos
 
 # sort removes libbpf duplicates when not cross-building
 MAKE_DIRS := $(sort $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf		\
@@ -192,13 +194,20 @@ scx_example_userland: scx_example_userland.c scx_example_userland.skel.h	\
 	$(CC) $(CFLAGS) -c $< -o $@.o
 	$(CC) -o $@ $@.o $(HOST_BPFOBJ) $(LDFLAGS)
 
+atropos: export RUSTFLAGS = -C link-args=-lzstd -C link-args=-lz -C link-args=-lelf -L $(BPFOBJ_DIR)
+atropos: export ATROPOS_CLANG = $(CLANG)
+atropos: export ATROPOS_BPF_CFLAGS = $(BPF_CFLAGS)
+atropos: $(INCLUDE_DIR)/vmlinux.h
+	cargo build --manifest-path=atropos/Cargo.toml $(CARGOFLAGS)
+
 clean:
+	cargo clean --manifest-path=atropos/Cargo.toml
 	rm -rf $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)
 	rm -f *.o *.bpf.o *.skel.h *.subskel.h
 	rm -f scx_example_simple scx_example_qmap scx_example_central		\
 	      scx_example_pair scx_example_flatcg scx_example_userland
 
-.PHONY: all clean
+.PHONY: all atropos clean
 
 # delete failed targets
 .DELETE_ON_ERROR:
diff --git a/tools/sched_ext/atropos/.gitignore b/tools/sched_ext/atropos/.gitignore
new file mode 100644
index 000000000000..186dba259ec2
--- /dev/null
+++ b/tools/sched_ext/atropos/.gitignore
@@ -0,0 +1,3 @@
+src/bpf/.output
+Cargo.lock
+target
diff --git a/tools/sched_ext/atropos/Cargo.toml b/tools/sched_ext/atropos/Cargo.toml
new file mode 100644
index 000000000000..7462a836d53d
--- /dev/null
+++ b/tools/sched_ext/atropos/Cargo.toml
@@ -0,0 +1,28 @@
+[package]
+name = "scx_atropos"
+version = "0.5.0"
+authors = ["Dan Schatzberg <dschatzberg@meta.com>", "Meta"]
+edition = "2021"
+description = "Userspace scheduling with BPF"
+license = "GPL-2.0-only"
+
+[dependencies]
+anyhow = "1.0.65"
+bitvec = { version = "1.0", features = ["serde"] }
+clap = { version = "4.1", features = ["derive", "env", "unicode", "wrap_help"] }
+ctrlc = { version = "3.1", features = ["termination"] }
+fb_procfs = { git = "https://github.com/facebookincubator/below.git", rev = "f305730"}
+hex = "0.4.3"
+libbpf-rs = "0.19.1"
+libbpf-sys = { version = "1.0.4", features = ["novendor", "static"] }
+libc = "0.2.137"
+log = "0.4.17"
+ordered-float = "3.4.0"
+simplelog = "0.12.0"
+
+[build-dependencies]
+bindgen = { version = "0.61.0", features = ["logging", "static"], default-features = false }
+libbpf-cargo = "0.13.0"
+
+[features]
+enable_backtrace = []
diff --git a/tools/sched_ext/atropos/build.rs b/tools/sched_ext/atropos/build.rs
new file mode 100644
index 000000000000..26e792c5e17e
--- /dev/null
+++ b/tools/sched_ext/atropos/build.rs
@@ -0,0 +1,70 @@
+// Copyright (c) Meta Platforms, Inc. and affiliates.
+
+// This software may be used and distributed according to the terms of the
+// GNU General Public License version 2.
+extern crate bindgen;
+
+use std::env;
+use std::fs::create_dir_all;
+use std::path::Path;
+use std::path::PathBuf;
+
+use libbpf_cargo::SkeletonBuilder;
+
+const HEADER_PATH: &str = "src/bpf/atropos.h";
+
+fn bindgen_atropos() {
+    // Tell cargo to invalidate the built crate whenever the wrapper changes
+    println!("cargo:rerun-if-changed={}", HEADER_PATH);
+
+    // The bindgen::Builder is the main entry point
+    // to bindgen, and lets you build up options for
+    // the resulting bindings.
+    let bindings = bindgen::Builder::default()
+        // The input header we would like to generate
+        // bindings for.
+        .header(HEADER_PATH)
+        // Tell cargo to invalidate the built crate whenever any of the
+        // included header files changed.
+        .parse_callbacks(Box::new(bindgen::CargoCallbacks))
+        // Finish the builder and generate the bindings.
+        .generate()
+        // Unwrap the Result and panic on failure.
+        .expect("Unable to generate bindings");
+
+    // Write the bindings to the $OUT_DIR/bindings.rs file.
+    let out_path = PathBuf::from(env::var("OUT_DIR").unwrap());
+    bindings
+        .write_to_file(out_path.join("atropos-sys.rs"))
+        .expect("Couldn't write bindings!");
+}
+
+fn gen_bpf_sched(name: &str) {
+    let bpf_cflags = env::var("ATROPOS_BPF_CFLAGS").unwrap();
+    let clang = env::var("ATROPOS_CLANG").unwrap();
+    eprintln!("{}", clang);
+    let outpath = format!("./src/bpf/.output/{}.skel.rs", name);
+    let skel = Path::new(&outpath);
+    let src = format!("./src/bpf/{}.bpf.c", name);
+    SkeletonBuilder::new()
+        .source(src.clone())
+        .clang(clang)
+        .clang_args(bpf_cflags)
+        .build_and_generate(&skel)
+        .unwrap();
+    println!("cargo:rerun-if-changed={}", src);
+}
+
+fn main() {
+    bindgen_atropos();
+    // It's unfortunate we cannot use `OUT_DIR` to store the generated skeleton.
+    // Reasons are because the generated skeleton contains compiler attributes
+    // that cannot be `include!()`ed via macro. And we cannot use the `#[path = "..."]`
+    // trick either because you cannot yet `concat!(env!("OUT_DIR"), "/skel.rs")` inside
+    // the path attribute either (see https://github.com/rust-lang/rust/pull/83366).
+    //
+    // However, there is hope! When the above feature stabilizes we can clean this
+    // all up.
+    create_dir_all("./src/bpf/.output").unwrap();
+    gen_bpf_sched("atropos");
+}
diff --git a/tools/sched_ext/atropos/rustfmt.toml b/tools/sched_ext/atropos/rustfmt.toml
new file mode 100644
index 000000000000..b7258ed0a8d8
--- /dev/null
+++ b/tools/sched_ext/atropos/rustfmt.toml
@@ -0,0 +1,8 @@
+# Get help on options with `rustfmt --help=config`
+# Please keep these in alphabetical order.
+edition = "2021"
+group_imports = "StdExternalCrate"
+imports_granularity = "Item"
+merge_derives = false
+use_field_init_shorthand = true
+version = "Two"
diff --git a/tools/sched_ext/atropos/src/atropos_sys.rs b/tools/sched_ext/atropos/src/atropos_sys.rs
new file mode 100644
index 000000000000..bbeaf856d40e
--- /dev/null
+++ b/tools/sched_ext/atropos/src/atropos_sys.rs
@@ -0,0 +1,10 @@
+// Copyright (c) Meta Platforms, Inc. and affiliates.
+
+// This software may be used and distributed according to the terms of the
+// GNU General Public License version 2.
+#![allow(non_upper_case_globals)]
+#![allow(non_camel_case_types)]
+#![allow(non_snake_case)]
+#![allow(dead_code)]
+
+include!(concat!(env!("OUT_DIR"), "/atropos-sys.rs"));
diff --git a/tools/sched_ext/atropos/src/bpf/atropos.bpf.c b/tools/sched_ext/atropos/src/bpf/atropos.bpf.c
new file mode 100644
index 000000000000..c26ecf0e77a8
--- /dev/null
+++ b/tools/sched_ext/atropos/src/bpf/atropos.bpf.c
@@ -0,0 +1,751 @@
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+/*
+ * This software may be used and distributed according to the terms of the
+ * GNU General Public License version 2.
+ *
+ * Atropos is a multi-domain BPF / userspace hybrid scheduler where the BPF
+ * part does simple round robin in each domain and the userspace part
+ * calculates the load factor of each domain and tells the BPF part how to load
+ * balance the domains.
+ *
+ * Every task has an entry in the task_data map which lists which domain the
+ * task belongs to. When a task first enters the system (atropos_prep_enable),
+ * they are round-robined to a domain.
+ *
+ * atropos_select_cpu is the primary scheduling logic, invoked when a task
+ * becomes runnable. The lb_data map is populated by userspace to inform the BPF
+ * scheduler that a task should be migrated to a new domain. Otherwise, the task
+ * is scheduled in priority order as follows:
+ * * The current core if the task was woken up synchronously and there are idle
+ *   cpus in the system
+ * * The previous core, if idle
+ * * The pinned-to core if the task is pinned to a specific core
+ * * Any idle cpu in the domain
+ *
+ * If none of the above conditions are met, then the task is enqueued to a
+ * dispatch queue corresponding to the domain (atropos_enqueue).
+ *
+ * atropos_dispatch will attempt to consume a task from its domain's
+ * corresponding dispatch queue (this occurs after scheduling any tasks directly
+ * assigned to it due to the logic in atropos_select_cpu). If no task is found,
+ * then greedy load stealing will attempt to find a task on another dispatch
+ * queue to run.
+ *
+ * Load balancing is almost entirely handled by userspace. BPF populates the
+ * task weight, dom mask and current dom in the task_data map and executes the
+ * load balance based on userspace populating the lb_data map.
+ */
+#include "../../../scx_common.bpf.h"
+#include "atropos.h"
+
+#include <errno.h>
+#include <stdbool.h>
+#include <string.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+/*
+ * const volatiles are set during initialization and treated as consts by the
+ * jit compiler.
+ */
+
+/*
+ * Domains and cpus
+ */
+const volatile __u32 nr_doms = 32;	/* !0 for veristat, set during init */
+const volatile __u32 nr_cpus = 64;	/* !0 for veristat, set during init */
+const volatile __u32 cpu_dom_id_map[MAX_CPUS];
+const volatile __u64 dom_cpumasks[MAX_DOMS][MAX_CPUS / 64];
+
+const volatile bool kthreads_local;
+const volatile bool fifo_sched;
+const volatile bool switch_partial;
+const volatile __u32 greedy_threshold;
+
+/* base slice duration */
+const volatile __u64 slice_us = 20000;
+
+/*
+ * Exit info
+ */
+int exit_type = SCX_EXIT_NONE;
+char exit_msg[SCX_EXIT_MSG_LEN];
+
+struct pcpu_ctx {
+	__u32 dom_rr_cur; /* used when scanning other doms */
+
+	/* libbpf-rs does not respect the alignment, so pad out the struct explicitly */
+	__u8 _padding[CACHELINE_SIZE - sizeof(u64)];
+} __attribute__((aligned(CACHELINE_SIZE)));
+
+struct pcpu_ctx pcpu_ctx[MAX_CPUS];
+
+/*
+ * Domain context
+ */
+struct dom_ctx {
+	struct bpf_cpumask __kptr *cpumask;
+	u64 vtime_now;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, u32);
+	__type(value, struct dom_ctx);
+	__uint(max_entries, MAX_DOMS);
+	__uint(map_flags, 0);
+} dom_ctx SEC(".maps");
+
+/*
+ * Statistics
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(u32));
+	__uint(value_size, sizeof(u64));
+	__uint(max_entries, ATROPOS_NR_STATS);
+} stats SEC(".maps");
+
+static inline void stat_add(enum stat_idx idx, u64 addend)
+{
+	u32 idx_v = idx;
+
+	u64 *cnt_p = bpf_map_lookup_elem(&stats, &idx_v);
+	if (cnt_p)
+		(*cnt_p) += addend;
+}
+
+/* Map pid -> task_ctx */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, pid_t);
+	__type(value, struct task_ctx);
+	__uint(max_entries, 1000000);
+	__uint(map_flags, 0);
+} task_data SEC(".maps");
+
+/*
+ * This is populated from userspace to indicate which pids should be reassigned
+ * to new doms.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, pid_t);
+	__type(value, u32);
+	__uint(max_entries, 1000);
+	__uint(map_flags, 0);
+} lb_data SEC(".maps");
+
+static inline bool vtime_before(u64 a, u64 b)
+{
+	return (s64)(a - b) < 0;
+}
+
+static bool task_set_dsq(struct task_ctx *task_ctx, struct task_struct *p,
+			 u32 new_dom_id)
+{
+	struct dom_ctx *old_domc, *new_domc;
+	struct bpf_cpumask *d_cpumask, *t_cpumask;
+	u32 old_dom_id = task_ctx->dom_id;
+	s64 vtime_delta;
+
+	old_domc = bpf_map_lookup_elem(&dom_ctx, &old_dom_id);
+	if (!old_domc) {
+		scx_bpf_error("No dom%u", old_dom_id);
+		return false;
+	}
+
+	vtime_delta = p->scx.dsq_vtime - old_domc->vtime_now;
+
+	new_domc = bpf_map_lookup_elem(&dom_ctx, &new_dom_id);
+	if (!new_domc) {
+		scx_bpf_error("No dom%u", new_dom_id);
+		return false;
+	}
+
+	d_cpumask = bpf_cpumask_kptr_get(&new_domc->cpumask);
+	if (!d_cpumask) {
+		scx_bpf_error("Failed to get domain %u cpumask kptr",
+			      new_dom_id);
+		return false;
+	}
+
+	t_cpumask = bpf_cpumask_kptr_get(&task_ctx->cpumask);
+	if (!t_cpumask) {
+		scx_bpf_error("Failed to look up task cpumask");
+		bpf_cpumask_release(d_cpumask);
+		return false;
+	}
+
+	/*
+	 * set_cpumask might have happened between userspace requesting LB and
+	 * here and @p might not be able to run in @dom_id anymore. Verify.
+	 */
+	if (bpf_cpumask_intersects((const struct cpumask *)d_cpumask,
+				   p->cpus_ptr)) {
+		p->scx.dsq_vtime = new_domc->vtime_now + vtime_delta;
+		task_ctx->dom_id = new_dom_id;
+		bpf_cpumask_and(t_cpumask, (const struct cpumask *)d_cpumask,
+				p->cpus_ptr);
+	}
+
+	bpf_cpumask_release(d_cpumask);
+	bpf_cpumask_release(t_cpumask);
+
+	return task_ctx->dom_id == new_dom_id;
+}
+
+s32 BPF_STRUCT_OPS(atropos_select_cpu, struct task_struct *p, int prev_cpu,
+		   u32 wake_flags)
+{
+	s32 cpu;
+	pid_t pid = p->pid;
+	struct task_ctx *task_ctx = bpf_map_lookup_elem(&task_data, &pid);
+	struct bpf_cpumask *p_cpumask;
+
+	if (!task_ctx)
+		return -ENOENT;
+
+	if (kthreads_local &&
+	    (p->flags & PF_KTHREAD) && p->nr_cpus_allowed == 1) {
+		cpu = prev_cpu;
+		stat_add(ATROPOS_STAT_DIRECT_DISPATCH, 1);
+		goto local;
+	}
+
+	/*
+	 * If WAKE_SYNC and the machine isn't fully saturated, wake up @p to the
+	 * local dsq of the waker.
+	 */
+	if (p->nr_cpus_allowed > 1 && (wake_flags & SCX_WAKE_SYNC)) {
+		struct task_struct *current = (void *)bpf_get_current_task();
+
+		if (!(BPF_CORE_READ(current, flags) & PF_EXITING) &&
+		    task_ctx->dom_id < MAX_DOMS) {
+			struct dom_ctx *domc;
+			struct bpf_cpumask *d_cpumask;
+			const struct cpumask *idle_cpumask;
+			bool has_idle;
+
+			domc = bpf_map_lookup_elem(&dom_ctx, &task_ctx->dom_id);
+			if (!domc) {
+				scx_bpf_error("Failed to find dom%u",
+					      task_ctx->dom_id);
+				return prev_cpu;
+			}
+			d_cpumask = bpf_cpumask_kptr_get(&domc->cpumask);
+			if (!d_cpumask) {
+				scx_bpf_error("Failed to acquire domain %u cpumask kptr",
+					      task_ctx->dom_id);
+				return prev_cpu;
+			}
+
+			idle_cpumask = scx_bpf_get_idle_cpumask();
+
+			has_idle = bpf_cpumask_intersects((const struct cpumask *)d_cpumask,
+							  idle_cpumask);
+
+			bpf_cpumask_release(d_cpumask);
+			scx_bpf_put_idle_cpumask(idle_cpumask);
+
+			if (has_idle) {
+				cpu = bpf_get_smp_processor_id();
+				if (bpf_cpumask_test_cpu(cpu, p->cpus_ptr)) {
+					stat_add(ATROPOS_STAT_WAKE_SYNC, 1);
+					goto local;
+				}
+			}
+		}
+	}
+
+	/* if the previous CPU is idle, dispatch directly to it */
+	if (scx_bpf_test_and_clear_cpu_idle(prev_cpu)) {
+		stat_add(ATROPOS_STAT_PREV_IDLE, 1);
+		cpu = prev_cpu;
+		goto local;
+	}
+
+	/* If only one core is allowed, dispatch */
+	if (p->nr_cpus_allowed == 1) {
+		stat_add(ATROPOS_STAT_PINNED, 1);
+		cpu = prev_cpu;
+		goto local;
+	}
+
+	p_cpumask = bpf_cpumask_kptr_get(&task_ctx->cpumask);
+	if (!p_cpumask)
+		return -ENOENT;
+
+	/* If there is an eligible idle CPU, dispatch directly */
+	cpu = scx_bpf_pick_idle_cpu((const struct cpumask *)p_cpumask);
+	if (cpu >= 0) {
+		bpf_cpumask_release(p_cpumask);
+		stat_add(ATROPOS_STAT_DIRECT_DISPATCH, 1);
+		goto local;
+	}
+
+	/*
+	 * @prev_cpu may be in a different domain. Returning an out-of-domain
+	 * CPU can lead to stalls as all in-domain CPUs may be idle by the time
+	 * @p gets enqueued.
+	 */
+	if (bpf_cpumask_test_cpu(prev_cpu, (const struct cpumask *)p_cpumask))
+		cpu = prev_cpu;
+	else
+		cpu = bpf_cpumask_any((const struct cpumask *)p_cpumask);
+
+	bpf_cpumask_release(p_cpumask);
+	return cpu;
+
+local:
+	task_ctx->dispatch_local = true;
+	return cpu;
+}
+
+void BPF_STRUCT_OPS(atropos_enqueue, struct task_struct *p, u32 enq_flags)
+{
+	pid_t pid = p->pid;
+	struct task_ctx *task_ctx = bpf_map_lookup_elem(&task_data, &pid);
+	u32 *new_dom;
+
+	if (!task_ctx) {
+		scx_bpf_error("No task_ctx[%d]", pid);
+		return;
+	}
+
+	new_dom = bpf_map_lookup_elem(&lb_data, &pid);
+	if (new_dom && *new_dom != task_ctx->dom_id &&
+	    task_set_dsq(task_ctx, p, *new_dom)) {
+		struct bpf_cpumask *p_cpumask;
+		s32 cpu;
+
+		stat_add(ATROPOS_STAT_LOAD_BALANCE, 1);
+
+		/*
+		 * If dispatch_local is set, We own @p's idle state but we are
+		 * not gonna put the task in the associated local dsq which can
+		 * cause the CPU to stall. Kick it.
+		 */
+		if (task_ctx->dispatch_local) {
+			task_ctx->dispatch_local = false;
+			scx_bpf_kick_cpu(scx_bpf_task_cpu(p), 0);
+		}
+
+		p_cpumask = bpf_cpumask_kptr_get(&task_ctx->cpumask);
+		if (!p_cpumask) {
+			scx_bpf_error("Failed to get task_ctx->cpumask");
+			return;
+		}
+		cpu = scx_bpf_pick_idle_cpu((const struct cpumask *)p_cpumask);
+		bpf_cpumask_release(p_cpumask);
+
+		if (cpu >= 0)
+			scx_bpf_kick_cpu(cpu, 0);
+	}
+
+	if (task_ctx->dispatch_local) {
+		task_ctx->dispatch_local = false;
+		scx_bpf_dispatch(p, SCX_DSQ_LOCAL, slice_us * 1000, enq_flags);
+		return;
+	}
+
+	if (fifo_sched) {
+		scx_bpf_dispatch(p, task_ctx->dom_id, slice_us * 1000,
+				 enq_flags);
+	} else {
+		u64 vtime = p->scx.dsq_vtime;
+		u32 dom_id = task_ctx->dom_id;
+		struct dom_ctx *domc;
+
+		domc = bpf_map_lookup_elem(&dom_ctx, &dom_id);
+		if (!domc) {
+			scx_bpf_error("No dom[%u]", dom_id);
+			return;
+		}
+
+		/*
+		 * Limit the amount of budget that an idling task can accumulate
+		 * to one slice.
+		 */
+		if (vtime_before(vtime, domc->vtime_now - slice_us * 1000))
+			vtime = domc->vtime_now - slice_us * 1000;
+
+		scx_bpf_dispatch_vtime(p, task_ctx->dom_id, SCX_SLICE_DFL, vtime,
+				       enq_flags);
+	}
+}
+
+static u32 cpu_to_dom_id(s32 cpu)
+{
+	const volatile u32 *dom_idp;
+
+	if (nr_doms <= 1)
+		return 0;
+
+	dom_idp = MEMBER_VPTR(cpu_dom_id_map, [cpu]);
+	if (!dom_idp)
+		return MAX_DOMS;
+
+	return *dom_idp;
+}
+
+static bool cpumask_intersects_domain(const struct cpumask *cpumask, u32 dom_id)
+{
+	s32 cpu;
+
+	if (dom_id >= MAX_DOMS)
+		return false;
+
+	bpf_for(cpu, 0, nr_cpus) {
+		if (bpf_cpumask_test_cpu(cpu, cpumask) &&
+		    (dom_cpumasks[dom_id][cpu / 64] & (1LLU << (cpu % 64))))
+			return true;
+	}
+	return false;
+}
+
+static u32 dom_rr_next(s32 cpu)
+{
+	struct pcpu_ctx *pcpuc;
+	u32 dom_id;
+
+	pcpuc = MEMBER_VPTR(pcpu_ctx, [cpu]);
+	if (!pcpuc)
+		return 0;
+
+	dom_id = (pcpuc->dom_rr_cur + 1) % nr_doms;
+
+	if (dom_id == cpu_to_dom_id(cpu))
+		dom_id = (dom_id + 1) % nr_doms;
+
+	pcpuc->dom_rr_cur = dom_id;
+	return dom_id;
+}
+
+void BPF_STRUCT_OPS(atropos_dispatch, s32 cpu, struct task_struct *prev)
+{
+	u32 dom = cpu_to_dom_id(cpu);
+
+	if (scx_bpf_consume(dom)) {
+		stat_add(ATROPOS_STAT_DSQ_DISPATCH, 1);
+		return;
+	}
+
+	if (!greedy_threshold)
+		return;
+
+	bpf_repeat(nr_doms - 1) {
+		u32 dom_id = dom_rr_next(cpu);
+
+		if (scx_bpf_dsq_nr_queued(dom_id) >= greedy_threshold &&
+		    scx_bpf_consume(dom_id)) {
+			stat_add(ATROPOS_STAT_GREEDY, 1);
+			break;
+		}
+	}
+}
+
+void BPF_STRUCT_OPS(atropos_runnable, struct task_struct *p, u64 enq_flags)
+{
+	pid_t pid = p->pid;
+	struct task_ctx *task_ctx = bpf_map_lookup_elem(&task_data, &pid);
+
+	if (!task_ctx) {
+		scx_bpf_error("No task_ctx[%d]", pid);
+		return;
+	}
+
+	task_ctx->runnable_at = bpf_ktime_get_ns();
+}
+
+void BPF_STRUCT_OPS(atropos_running, struct task_struct *p)
+{
+	struct task_ctx *taskc;
+	struct dom_ctx *domc;
+	pid_t pid = p->pid;
+	u32 dom_id;
+
+	if (fifo_sched)
+		return;
+
+	taskc = bpf_map_lookup_elem(&task_data, &pid);
+	if (!taskc) {
+		scx_bpf_error("No task_ctx[%d]", pid);
+		return;
+	}
+	dom_id = taskc->dom_id;
+
+	domc = bpf_map_lookup_elem(&dom_ctx, &dom_id);
+	if (!domc) {
+		scx_bpf_error("No dom[%u]", dom_id);
+		return;
+	}
+
+	/*
+	 * Global vtime always progresses forward as tasks start executing. The
+	 * test and update can be performed concurrently from multiple CPUs and
+	 * thus racy. Any error should be contained and temporary. Let's just
+	 * live with it.
+	 */
+	if (vtime_before(domc->vtime_now, p->scx.dsq_vtime))
+		domc->vtime_now = p->scx.dsq_vtime;
+}
+
+void BPF_STRUCT_OPS(atropos_stopping, struct task_struct *p, bool runnable)
+{
+	if (fifo_sched)
+		return;
+
+	/* scale the execution time by the inverse of the weight and charge */
+	p->scx.dsq_vtime += (SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
+}
+
+void BPF_STRUCT_OPS(atropos_quiescent, struct task_struct *p, u64 deq_flags)
+{
+	pid_t pid = p->pid;
+	struct task_ctx *task_ctx = bpf_map_lookup_elem(&task_data, &pid);
+
+	if (!task_ctx) {
+		scx_bpf_error("No task_ctx[%d]", pid);
+		return;
+	}
+
+	task_ctx->runnable_for += bpf_ktime_get_ns() - task_ctx->runnable_at;
+	task_ctx->runnable_at = 0;
+}
+
+void BPF_STRUCT_OPS(atropos_set_weight, struct task_struct *p, u32 weight)
+{
+	pid_t pid = p->pid;
+	struct task_ctx *task_ctx = bpf_map_lookup_elem(&task_data, &pid);
+
+	if (!task_ctx) {
+		scx_bpf_error("No task_ctx[%d]", pid);
+		return;
+	}
+
+	task_ctx->weight = weight;
+}
+
+struct pick_task_domain_loop_ctx {
+	struct task_struct *p;
+	const struct cpumask *cpumask;
+	u64 dom_mask;
+	u32 dom_rr_base;
+	u32 dom_id;
+};
+
+static int pick_task_domain_loopfn(u32 idx, void *data)
+{
+	struct pick_task_domain_loop_ctx *lctx = data;
+	u32 dom_id = (lctx->dom_rr_base + idx) % nr_doms;
+
+	if (dom_id >= MAX_DOMS)
+		return 1;
+
+	if (cpumask_intersects_domain(lctx->cpumask, dom_id)) {
+		lctx->dom_mask |= 1LLU << dom_id;
+		if (lctx->dom_id == MAX_DOMS)
+			lctx->dom_id = dom_id;
+	}
+	return 0;
+}
+
+static u32 pick_task_domain(struct task_ctx *task_ctx, struct task_struct *p,
+			    const struct cpumask *cpumask)
+{
+	struct pick_task_domain_loop_ctx lctx = {
+		.p = p,
+		.cpumask = cpumask,
+		.dom_id = MAX_DOMS,
+	};
+	s32 cpu = bpf_get_smp_processor_id();
+
+	if (cpu < 0 || cpu >= MAX_CPUS)
+		return MAX_DOMS;
+
+	lctx.dom_rr_base = ++(pcpu_ctx[cpu].dom_rr_cur);
+
+	bpf_loop(nr_doms, pick_task_domain_loopfn, &lctx, 0);
+	task_ctx->dom_mask = lctx.dom_mask;
+
+	return lctx.dom_id;
+}
+
+static void task_set_domain(struct task_ctx *task_ctx, struct task_struct *p,
+			    const struct cpumask *cpumask)
+{
+	u32 dom_id = 0;
+
+	if (nr_doms > 1)
+		dom_id = pick_task_domain(task_ctx, p, cpumask);
+
+	if (!task_set_dsq(task_ctx, p, dom_id))
+		scx_bpf_error("Failed to set domain %d for %s[%d]",
+			      dom_id, p->comm, p->pid);
+}
+
+void BPF_STRUCT_OPS(atropos_set_cpumask, struct task_struct *p,
+		    const struct cpumask *cpumask)
+{
+	pid_t pid = p->pid;
+	struct task_ctx *task_ctx = bpf_map_lookup_elem(&task_data, &pid);
+	if (!task_ctx) {
+		scx_bpf_error("No task_ctx[%d]", pid);
+		return;
+	}
+
+	task_set_domain(task_ctx, p, cpumask);
+}
+
+s32 BPF_STRUCT_OPS(atropos_prep_enable, struct task_struct *p,
+		   struct scx_enable_args *args)
+{
+	struct bpf_cpumask *cpumask;
+	struct task_ctx task_ctx, *map_value;
+	long ret;
+	pid_t pid;
+
+	memset(&task_ctx, 0, sizeof(task_ctx));
+
+	pid = p->pid;
+	ret = bpf_map_update_elem(&task_data, &pid, &task_ctx, BPF_NOEXIST);
+	if (ret) {
+		stat_add(ATROPOS_STAT_TASK_GET_ERR, 1);
+		return ret;
+	}
+
+	/*
+	 * Read the entry from the map immediately so we can add the cpumask
+	 * with bpf_kptr_xchg().
+	 */
+	map_value = bpf_map_lookup_elem(&task_data, &pid);
+	if (!map_value)
+		/* Should never happen -- it was just inserted above. */
+		return -EINVAL;
+
+	cpumask = bpf_cpumask_create();
+	if (!cpumask) {
+		bpf_map_delete_elem(&task_data, &pid);
+		return -ENOMEM;
+	}
+
+	cpumask = bpf_kptr_xchg(&map_value->cpumask, cpumask);
+	if (cpumask) {
+		/* Should never happen as we just inserted it above. */
+		bpf_cpumask_release(cpumask);
+		bpf_map_delete_elem(&task_data, &pid);
+		return -EINVAL;
+	}
+
+	task_set_domain(map_value, p, p->cpus_ptr);
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(atropos_disable, struct task_struct *p)
+{
+	pid_t pid = p->pid;
+	long ret = bpf_map_delete_elem(&task_data, &pid);
+	if (ret) {
+		stat_add(ATROPOS_STAT_TASK_GET_ERR, 1);
+		return;
+	}
+}
+
+static int create_dom_dsq(u32 idx, void *data)
+{
+	struct dom_ctx domc_init = {}, *domc;
+	struct bpf_cpumask *cpumask;
+	u32 cpu, dom_id = idx;
+	s32 ret;
+
+	ret = scx_bpf_create_dsq(dom_id, -1);
+	if (ret < 0) {
+		scx_bpf_error("Failed to create dsq %u (%d)", dom_id, ret);
+		return 1;
+	}
+
+	ret = bpf_map_update_elem(&dom_ctx, &dom_id, &domc_init, 0);
+	if (ret) {
+		scx_bpf_error("Failed to add dom_ctx entry %u (%d)", dom_id, ret);
+		return 1;
+	}
+
+	domc = bpf_map_lookup_elem(&dom_ctx, &dom_id);
+	if (!domc) {
+		/* Should never happen, we just inserted it above. */
+		scx_bpf_error("No dom%u", dom_id);
+		return 1;
+	}
+
+	cpumask = bpf_cpumask_create();
+	if (!cpumask) {
+		scx_bpf_error("Failed to create BPF cpumask for domain %u", dom_id);
+		return 1;
+	}
+
+	for (cpu = 0; cpu < MAX_CPUS; cpu++) {
+		const volatile __u64 *dmask;
+
+		dmask = MEMBER_VPTR(dom_cpumasks, [dom_id][cpu / 64]);
+		if (!dmask) {
+			scx_bpf_error("array index error");
+			bpf_cpumask_release(cpumask);
+			return 1;
+		}
+
+		if (*dmask & (1LLU << (cpu % 64)))
+			bpf_cpumask_set_cpu(cpu, cpumask);
+	}
+
+	cpumask = bpf_kptr_xchg(&domc->cpumask, cpumask);
+	if (cpumask) {
+		scx_bpf_error("Domain %u was already present", dom_id);
+		bpf_cpumask_release(cpumask);
+		return 1;
+	}
+
+	return 0;
+}
+
+int BPF_STRUCT_OPS_SLEEPABLE(atropos_init)
+{
+	if (!switch_partial)
+		scx_bpf_switch_all();
+
+	bpf_loop(nr_doms, create_dom_dsq, NULL, 0);
+
+	for (u32 i = 0; i < nr_cpus; i++)
+		pcpu_ctx[i].dom_rr_cur = i;
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(atropos_exit, struct scx_exit_info *ei)
+{
+	bpf_probe_read_kernel_str(exit_msg, sizeof(exit_msg), ei->msg);
+	exit_type = ei->type;
+}
+
+SEC(".struct_ops")
+struct sched_ext_ops atropos = {
+	.select_cpu = (void *)atropos_select_cpu,
+	.enqueue = (void *)atropos_enqueue,
+	.dispatch = (void *)atropos_dispatch,
+	.runnable = (void *)atropos_runnable,
+	.running = (void *)atropos_running,
+	.stopping = (void *)atropos_stopping,
+	.quiescent = (void *)atropos_quiescent,
+	.set_weight = (void *)atropos_set_weight,
+	.set_cpumask = (void *)atropos_set_cpumask,
+	.prep_enable = (void *)atropos_prep_enable,
+	.disable = (void *)atropos_disable,
+	.init = (void *)atropos_init,
+	.exit = (void *)atropos_exit,
+	.flags = 0,
+	.name = "atropos",
+};
diff --git a/tools/sched_ext/atropos/src/bpf/atropos.h b/tools/sched_ext/atropos/src/bpf/atropos.h
new file mode 100644
index 000000000000..addf29ca104a
--- /dev/null
+++ b/tools/sched_ext/atropos/src/bpf/atropos.h
@@ -0,0 +1,44 @@
+// Copyright (c) Meta Platforms, Inc. and affiliates.
+
+// This software may be used and distributed according to the terms of the
+// GNU General Public License version 2.
+#ifndef __ATROPOS_H
+#define __ATROPOS_H
+
+#include <stdbool.h>
+#ifndef __kptr
+#ifdef __KERNEL__
+#error "__kptr_ref not defined in the kernel"
+#endif
+#define __kptr
+#endif
+
+#define	MAX_CPUS 512
+#define	MAX_DOMS 64 /* limited to avoid complex bitmask ops */
+#define	CACHELINE_SIZE 64
+
+/* Statistics */
+enum stat_idx {
+	ATROPOS_STAT_TASK_GET_ERR,
+	ATROPOS_STAT_WAKE_SYNC,
+	ATROPOS_STAT_PREV_IDLE,
+	ATROPOS_STAT_PINNED,
+	ATROPOS_STAT_DIRECT_DISPATCH,
+	ATROPOS_STAT_DSQ_DISPATCH,
+	ATROPOS_STAT_GREEDY,
+	ATROPOS_STAT_LOAD_BALANCE,
+	ATROPOS_STAT_LAST_TASK,
+	ATROPOS_NR_STATS,
+};
+
+struct task_ctx {
+	unsigned long long dom_mask; /* the domains this task can run on */
+	struct bpf_cpumask __kptr *cpumask;
+	unsigned int dom_id;
+	unsigned int weight;
+	unsigned long long runnable_at;
+	unsigned long long runnable_for;
+	bool dispatch_local;
+};
+
+#endif /* __ATROPOS_H */
diff --git a/tools/sched_ext/atropos/src/main.rs b/tools/sched_ext/atropos/src/main.rs
new file mode 100644
index 000000000000..0d313662f713
--- /dev/null
+++ b/tools/sched_ext/atropos/src/main.rs
@@ -0,0 +1,942 @@
+// Copyright (c) Meta Platforms, Inc. and affiliates.
+
+// This software may be used and distributed according to the terms of the
+// GNU General Public License version 2.
+#[path = "bpf/.output/atropos.skel.rs"]
+mod atropos;
+pub use atropos::*;
+pub mod atropos_sys;
+
+use std::cell::Cell;
+use std::collections::{BTreeMap, BTreeSet};
+use std::ffi::CStr;
+use std::ops::Bound::{Included, Unbounded};
+use std::sync::atomic::{AtomicBool, Ordering};
+use std::sync::Arc;
+use std::time::{Duration, SystemTime};
+
+use ::fb_procfs as procfs;
+use anyhow::{anyhow, bail, Context, Result};
+use bitvec::prelude::*;
+use clap::Parser;
+use log::{info, trace, warn};
+use ordered_float::OrderedFloat;
+
+/// Atropos is a multi-domain BPF / userspace hybrid scheduler where the BPF
+/// part does simple round robin in each domain and the userspace part
+/// calculates the load factor of each domain and tells the BPF part how to load
+/// balance the domains.
+
+/// This scheduler demonstrates dividing scheduling logic between BPF and
+/// userspace and using rust to build the userspace part. An earlier variant of
+/// this scheduler was used to balance across six domains, each representing a
+/// chiplet in a six-chiplet AMD processor, and could match the performance of
+/// production setup using CFS.
+#[derive(Debug, Parser)]
+struct Opts {
+    /// Scheduling slice duration in microseconds.
+    #[clap(short, long, default_value = "20000")]
+    slice_us: u64,
+
+    /// Monitoring and load balance interval in seconds.
+    #[clap(short, long, default_value = "2.0")]
+    interval: f64,
+
+    /// Build domains according to how CPUs are grouped at this cache level
+    /// as determined by /sys/devices/system/cpu/cpuX/cache/indexI/id.
+    #[clap(short = 'c', long, default_value = "3")]
+    cache_level: u32,
+
+    /// Instead of using cache locality, set the cpumask for each domain
+    /// manually, provide multiple --cpumasks, one for each domain. E.g.
+    /// --cpumasks 0xff_00ff --cpumasks 0xff00 will create two domains with
+    /// the corresponding CPUs belonging to each domain. Each CPU must
+    /// belong to precisely one domain.
+    #[clap(short = 'C', long, num_args = 1.., conflicts_with = "cache_level")]
+    cpumasks: Vec<String>,
+
+    /// When non-zero, enable greedy task stealing. When a domain is idle, a
+    /// cpu will attempt to steal tasks from a domain with at least
+    /// greedy_threshold tasks enqueued. These tasks aren't permanently
+    /// stolen from the domain.
+    #[clap(short, long, default_value = "4")]
+    greedy_threshold: u32,
+
+    /// The load decay factor. Every interval, the existing load is decayed
+    /// by this factor and new load is added. Must be in the range [0.0,
+    /// 0.99]. The smaller the value, the more sensitive load calculation
+    /// is to recent changes. When 0.0, history is ignored and the load
+    /// value from the latest period is used directly.
+    #[clap(short, long, default_value = "0.5")]
+    load_decay_factor: f64,
+
+    /// Disable load balancing. Unless disabled, periodically userspace will
+    /// calculate the load factor of each domain and instruct BPF which
+    /// processes to move.
+    #[clap(short, long, action = clap::ArgAction::SetTrue)]
+    no_load_balance: bool,
+
+    /// Put per-cpu kthreads directly into local dsq's.
+    #[clap(short, long, action = clap::ArgAction::SetTrue)]
+    kthreads_local: bool,
+
+    /// Use FIFO scheduling instead of weighted vtime scheduling.
+    #[clap(short, long, action = clap::ArgAction::SetTrue)]
+    fifo_sched: bool,
+
+    /// If specified, only tasks which have their scheduling policy set to
+    /// SCHED_EXT using sched_setscheduler(2) are switched. Otherwise, all
+    /// tasks are switched.
+    #[clap(short, long, action = clap::ArgAction::SetTrue)]
+    partial: bool,
+
+    /// Enable verbose output including libbpf details. Specify multiple
+    /// times to increase verbosity.
+    #[clap(short, long, action = clap::ArgAction::Count)]
+    verbose: u8,
+}
+
+fn read_total_cpu(reader: &mut procfs::ProcReader) -> Result<procfs::CpuStat> {
+    Ok(reader
+        .read_stat()
+        .context("Failed to read procfs")?
+        .total_cpu
+        .ok_or_else(|| anyhow!("Could not read total cpu stat in proc"))?)
+}
+
+fn now_monotonic() -> u64 {
+    let mut time = libc::timespec {
+        tv_sec: 0,
+        tv_nsec: 0,
+    };
+    let ret = unsafe { libc::clock_gettime(libc::CLOCK_MONOTONIC, &mut time) };
+    assert!(ret == 0);
+    time.tv_sec as u64 * 1_000_000_000 + time.tv_nsec as u64
+}
+
+fn clear_map(map: &mut libbpf_rs::Map) {
+    // XXX: libbpf_rs has some design flaw that make it impossible to
+    // delete while iterating despite it being safe so we alias it here
+    let deleter: &mut libbpf_rs::Map = unsafe { &mut *(map as *mut _) };
+    for key in map.keys() {
+        let _ = deleter.delete(&key);
+    }
+}
+
+#[derive(Debug)]
+struct TaskLoad {
+    runnable_for: u64,
+    load: f64,
+}
+
+#[derive(Debug)]
+struct TaskInfo {
+    pid: i32,
+    dom_mask: u64,
+    migrated: Cell<bool>,
+}
+
+struct LoadBalancer<'a, 'b, 'c> {
+    maps: AtroposMapsMut<'a>,
+    task_loads: &'b mut BTreeMap<i32, TaskLoad>,
+    nr_doms: usize,
+    load_decay_factor: f64,
+
+    tasks_by_load: Vec<BTreeMap<OrderedFloat<f64>, TaskInfo>>,
+    load_avg: f64,
+    dom_loads: Vec<f64>,
+
+    imbal: Vec<f64>,
+    doms_to_push: BTreeMap<OrderedFloat<f64>, u32>,
+    doms_to_pull: BTreeMap<OrderedFloat<f64>, u32>,
+
+    nr_lb_data_errors: &'c mut u64,
+}
+
+impl<'a, 'b, 'c> LoadBalancer<'a, 'b, 'c> {
+    const LOAD_IMBAL_HIGH_RATIO: f64 = 0.10;
+    const LOAD_IMBAL_REDUCTION_MIN_RATIO: f64 = 0.1;
+    const LOAD_IMBAL_PUSH_MAX_RATIO: f64 = 0.50;
+
+    fn new(
+        maps: AtroposMapsMut<'a>,
+        task_loads: &'b mut BTreeMap<i32, TaskLoad>,
+        nr_doms: usize,
+        load_decay_factor: f64,
+        nr_lb_data_errors: &'c mut u64,
+    ) -> Self {
+        Self {
+            maps,
+            task_loads,
+            nr_doms,
+            load_decay_factor,
+
+            tasks_by_load: (0..nr_doms).map(|_| BTreeMap::<_, _>::new()).collect(),
+            load_avg: 0f64,
+            dom_loads: vec![0.0; nr_doms],
+
+            imbal: vec![0.0; nr_doms],
+            doms_to_pull: BTreeMap::new(),
+            doms_to_push: BTreeMap::new(),
+
+            nr_lb_data_errors,
+        }
+    }
+
+    fn read_task_loads(&mut self, period: Duration) -> Result<()> {
+        let now_mono = now_monotonic();
+        let task_data = self.maps.task_data();
+        let mut this_task_loads = BTreeMap::<i32, TaskLoad>::new();
+        let mut load_sum = 0.0f64;
+        self.dom_loads = vec![0f64; self.nr_doms];
+
+        for key in task_data.keys() {
+            if let Some(task_ctx_vec) = task_data
+                .lookup(&key, libbpf_rs::MapFlags::ANY)
+                .context("Failed to lookup task_data")?
+            {
+                let task_ctx =
+                    unsafe { &*(task_ctx_vec.as_slice().as_ptr() as *const atropos_sys::task_ctx) };
+                let pid = i32::from_ne_bytes(
+                    key.as_slice()
+                        .try_into()
+                        .context("Invalid key length in task_data map")?,
+                );
+
+                let (this_at, this_for, weight) = unsafe {
+                    (
+                        std::ptr::read_volatile(&task_ctx.runnable_at as *const u64),
+                        std::ptr::read_volatile(&task_ctx.runnable_for as *const u64),
+                        std::ptr::read_volatile(&task_ctx.weight as *const u32),
+                    )
+                };
+
+                let (mut delta, prev_load) = match self.task_loads.get(&pid) {
+                    Some(prev) => (this_for - prev.runnable_for, Some(prev.load)),
+                    None => (this_for, None),
+                };
+
+                // Non-zero this_at indicates that the task is currently
+                // runnable. Note that we read runnable_at and runnable_for
+                // without any synchronization and there is a small window
+                // where we end up misaccounting. While this can cause
+                // temporary error, it's unlikely to cause any noticeable
+                // misbehavior especially given the load value clamping.
+                if this_at > 0 && this_at < now_mono {
+                    delta += now_mono - this_at;
+                }
+
+                delta = delta.min(period.as_nanos() as u64);
+                let this_load = (weight as f64 * delta as f64 / period.as_nanos() as f64)
+                    .clamp(0.0, weight as f64);
+
+                let this_load = match prev_load {
+                    Some(prev_load) => {
+                        prev_load * self.load_decay_factor
+                            + this_load * (1.0 - self.load_decay_factor)
+                    }
+                    None => this_load,
+                };
+
+                this_task_loads.insert(
+                    pid,
+                    TaskLoad {
+                        runnable_for: this_for,
+                        load: this_load,
+                    },
+                );
+
+                load_sum += this_load;
+                self.dom_loads[task_ctx.dom_id as usize] += this_load;
+                // Only record pids that are eligible for load balancing
+                if task_ctx.dom_mask == (1u64 << task_ctx.dom_id) {
+                    continue;
+                }
+                self.tasks_by_load[task_ctx.dom_id as usize].insert(
+                    OrderedFloat(this_load),
+                    TaskInfo {
+                        pid,
+                        dom_mask: task_ctx.dom_mask,
+                        migrated: Cell::new(false),
+                    },
+                );
+            }
+        }
+
+        self.load_avg = load_sum / self.nr_doms as f64;
+        *self.task_loads = this_task_loads;
+        Ok(())
+    }
+
+    // To balance dom loads we identify doms with lower and higher load than average
+    fn calculate_dom_load_balance(&mut self) -> Result<()> {
+        for (dom, dom_load) in self.dom_loads.iter().enumerate() {
+            let imbal = dom_load - self.load_avg;
+            if imbal.abs() >= self.load_avg * Self::LOAD_IMBAL_HIGH_RATIO {
+                if imbal > 0f64 {
+                    self.doms_to_push.insert(OrderedFloat(imbal), dom as u32);
+                } else {
+                    self.doms_to_pull.insert(OrderedFloat(-imbal), dom as u32);
+                }
+                self.imbal[dom] = imbal;
+            }
+        }
+        Ok(())
+    }
+
+    // Find the first candidate pid which hasn't already been migrated and
+    // can run in @pull_dom.
+    fn find_first_candidate<'d, I>(tasks_by_load: I, pull_dom: u32) -> Option<(f64, &'d TaskInfo)>
+    where
+        I: IntoIterator<Item = (&'d OrderedFloat<f64>, &'d TaskInfo)>,
+    {
+        match tasks_by_load
+            .into_iter()
+            .skip_while(|(_, task)| task.migrated.get() || task.dom_mask & (1 << pull_dom) == 0)
+            .next()
+        {
+            Some((OrderedFloat(load), task)) => Some((*load, task)),
+            None => None,
+        }
+    }
+
+    fn pick_victim(
+        &self,
+        (push_dom, to_push): (u32, f64),
+        (pull_dom, to_pull): (u32, f64),
+    ) -> Option<(&TaskInfo, f64)> {
+        let to_xfer = to_pull.min(to_push);
+
+        trace!(
+            "considering dom {}@{:.2} -> {}@{:.2}",
+            push_dom,
+            to_push,
+            pull_dom,
+            to_pull
+        );
+
+        let calc_new_imbal = |xfer: f64| (to_push - xfer).abs() + (to_pull - xfer).abs();
+
+        trace!(
+            "to_xfer={:.2} tasks_by_load={:?}",
+            to_xfer,
+            &self.tasks_by_load[push_dom as usize]
+        );
+
+        // We want to pick a task to transfer from push_dom to pull_dom to
+        // maximize the reduction of load imbalance between the two. IOW,
+        // pick a task which has the closest load value to $to_xfer that can
+        // be migrated. Find such task by locating the first migratable task
+        // while scanning left from $to_xfer and the counterpart while
+        // scanning right and picking the better of the two.
+        let (load, task, new_imbal) = match (
+            Self::find_first_candidate(
+                self.tasks_by_load[push_dom as usize]
+                    .range((Unbounded, Included(&OrderedFloat(to_xfer))))
+                    .rev(),
+                pull_dom,
+            ),
+            Self::find_first_candidate(
+                self.tasks_by_load[push_dom as usize]
+                    .range((Included(&OrderedFloat(to_xfer)), Unbounded)),
+                pull_dom,
+            ),
+        ) {
+            (None, None) => return None,
+            (Some((load, task)), None) | (None, Some((load, task))) => {
+                (load, task, calc_new_imbal(load))
+            }
+            (Some((load0, task0)), Some((load1, task1))) => {
+                let (new_imbal0, new_imbal1) = (calc_new_imbal(load0), calc_new_imbal(load1));
+                if new_imbal0 <= new_imbal1 {
+                    (load0, task0, new_imbal0)
+                } else {
+                    (load1, task1, new_imbal1)
+                }
+            }
+        };
+
+        // If the best candidate can't reduce the imbalance, there's nothing
+        // to do for this pair.
+        let old_imbal = to_push + to_pull;
+        if old_imbal * (1.0 - Self::LOAD_IMBAL_REDUCTION_MIN_RATIO) < new_imbal {
+            trace!(
+                "skipping pid {}, dom {} -> {} won't improve imbal {:.2} -> {:.2}",
+                task.pid,
+                push_dom,
+                pull_dom,
+                old_imbal,
+                new_imbal
+            );
+            return None;
+        }
+
+        trace!(
+            "migrating pid {}, dom {} -> {}, imbal={:.2} -> {:.2}",
+            task.pid,
+            push_dom,
+            pull_dom,
+            old_imbal,
+            new_imbal,
+        );
+
+        Some((task, load))
+    }
+
+    // Actually execute the load balancing. Concretely this writes pid -> dom
+    // entries into the lb_data map for bpf side to consume.
+    fn load_balance(&mut self) -> Result<()> {
+        clear_map(self.maps.lb_data());
+
+        trace!("imbal={:?}", &self.imbal);
+        trace!("doms_to_push={:?}", &self.doms_to_push);
+        trace!("doms_to_pull={:?}", &self.doms_to_pull);
+
+        // Push from the most imbalanced to least.
+        while let Some((OrderedFloat(mut to_push), push_dom)) = self.doms_to_push.pop_last() {
+            let push_max = self.dom_loads[push_dom as usize] * Self::LOAD_IMBAL_PUSH_MAX_RATIO;
+            let mut pushed = 0f64;
+
+            // Transfer tasks from push_dom to reduce imbalance.
+            loop {
+                let last_pushed = pushed;
+
+                // Pull from the most imbalaned to least.
+                let mut doms_to_pull = BTreeMap::<_, _>::new();
+                std::mem::swap(&mut self.doms_to_pull, &mut doms_to_pull);
+                let mut pull_doms = doms_to_pull.into_iter().rev().collect::<Vec<(_, _)>>();
+
+                for (to_pull, pull_dom) in pull_doms.iter_mut() {
+                    if let Some((task, load)) =
+                        self.pick_victim((push_dom, to_push), (*pull_dom, f64::from(*to_pull)))
+                    {
+                        // Execute migration.
+                        task.migrated.set(true);
+                        to_push -= load;
+                        *to_pull -= load;
+                        pushed += load;
+
+                        // Ask BPF code to execute the migration.
+                        let pid = task.pid;
+                        let cpid = (pid as libc::pid_t).to_ne_bytes();
+                        if let Err(e) = self.maps.lb_data().update(
+                            &cpid,
+                            &pull_dom.to_ne_bytes(),
+                            libbpf_rs::MapFlags::NO_EXIST,
+                        ) {
+                            warn!(
+                                "Failed to update lb_data map for pid={} error={:?}",
+                                pid, &e
+                            );
+                            *self.nr_lb_data_errors += 1;
+                        }
+
+                        // Always break after a successful migration so that
+                        // the pulling domains are always considered in the
+                        // descending imbalance order.
+                        break;
+                    }
+                }
+
+                pull_doms
+                    .into_iter()
+                    .map(|(k, v)| self.doms_to_pull.insert(k, v))
+                    .count();
+
+                // Stop repeating if nothing got transferred or pushed enough.
+                if pushed == last_pushed || pushed >= push_max {
+                    break;
+                }
+            }
+        }
+        Ok(())
+    }
+}
+
+struct Scheduler<'a> {
+    skel: AtroposSkel<'a>,
+    struct_ops: Option<libbpf_rs::Link>,
+
+    nr_cpus: usize,
+    nr_doms: usize,
+    load_decay_factor: f64,
+    balance_load: bool,
+
+    proc_reader: procfs::ProcReader,
+
+    prev_at: SystemTime,
+    prev_total_cpu: procfs::CpuStat,
+    task_loads: BTreeMap<i32, TaskLoad>,
+
+    nr_lb_data_errors: u64,
+}
+
+impl<'a> Scheduler<'a> {
+    // Returns Vec of cpuset for each dq and a vec of dq for each cpu
+    fn parse_cpusets(
+        cpumasks: &[String],
+        nr_cpus: usize,
+    ) -> Result<(Vec<BitVec<u64, Lsb0>>, Vec<i32>)> {
+        if cpumasks.len() > atropos_sys::MAX_DOMS as usize {
+            bail!(
+                "Number of requested DSQs ({}) is greater than MAX_DOMS ({})",
+                cpumasks.len(),
+                atropos_sys::MAX_DOMS
+            );
+        }
+        let mut cpus = vec![-1i32; nr_cpus];
+        let mut cpusets =
+            vec![bitvec![u64, Lsb0; 0; atropos_sys::MAX_CPUS as usize]; cpumasks.len()];
+        for (dq, cpumask) in cpumasks.iter().enumerate() {
+            let hex_str = {
+                let mut tmp_str = cpumask
+                    .strip_prefix("0x")
+                    .unwrap_or(cpumask)
+                    .replace('_', "");
+                if tmp_str.len() % 2 != 0 {
+                    tmp_str = "0".to_string() + &tmp_str;
+                }
+                tmp_str
+            };
+            let byte_vec = hex::decode(&hex_str)
+                .with_context(|| format!("Failed to parse cpumask: {}", cpumask))?;
+
+            for (index, &val) in byte_vec.iter().rev().enumerate() {
+                let mut v = val;
+                while v != 0 {
+                    let lsb = v.trailing_zeros() as usize;
+                    v &= !(1 << lsb);
+                    let cpu = index * 8 + lsb;
+                    if cpu > nr_cpus {
+                        bail!(
+                            concat!(
+                                "Found cpu ({}) in cpumask ({}) which is larger",
+                                " than the number of cpus on the machine ({})"
+                            ),
+                            cpu,
+                            cpumask,
+                            nr_cpus
+                        );
+                    }
+                    if cpus[cpu] != -1 {
+                        bail!(
+                            "Found cpu ({}) with dq ({}) but also in cpumask ({})",
+                            cpu,
+                            cpus[cpu],
+                            cpumask
+                        );
+                    }
+                    cpus[cpu] = dq as i32;
+                    cpusets[dq].set(cpu, true);
+                }
+            }
+            cpusets[dq].set_uninitialized(false);
+        }
+
+        for (cpu, &dq) in cpus.iter().enumerate() {
+            if dq < 0 {
+                bail!(
+                "Cpu {} not assigned to any dq. Make sure it is covered by some --cpumasks argument.",
+                cpu
+            );
+            }
+        }
+
+        Ok((cpusets, cpus))
+    }
+
+    // Returns Vec of cpuset for each dq and a vec of dq for each cpu
+    fn cpusets_from_cache(
+        level: u32,
+        nr_cpus: usize,
+    ) -> Result<(Vec<BitVec<u64, Lsb0>>, Vec<i32>)> {
+        let mut cpu_to_cache = vec![]; // (cpu_id, cache_id)
+        let mut cache_ids = BTreeSet::<u32>::new();
+        let mut nr_not_found = 0;
+
+        // Build cpu -> cache ID mapping.
+        for cpu in 0..nr_cpus {
+            let path = format!("/sys/devices/system/cpu/cpu{}/cache/index{}/id", cpu, level);
+            let id = match std::fs::read_to_string(&path) {
+                Ok(val) => val
+                    .trim()
+                    .parse::<u32>()
+                    .with_context(|| format!("Failed to parse {:?}'s content {:?}", &path, &val))?,
+                Err(e) if e.kind() == std::io::ErrorKind::NotFound => {
+                    nr_not_found += 1;
+                    0
+                }
+                Err(e) => return Err(e).with_context(|| format!("Failed to open {:?}", &path)),
+            };
+
+            cpu_to_cache.push(id);
+            cache_ids.insert(id);
+        }
+
+        if nr_not_found > 1 {
+            warn!(
+                "Couldn't determine level {} cache IDs for {} CPUs out of {}, assigned to cache ID 0",
+                level, nr_not_found, nr_cpus
+            );
+        }
+
+        // Cache IDs may have holes. Assign consecutive domain IDs to
+        // existing cache IDs.
+        let mut cache_to_dom = BTreeMap::<u32, u32>::new();
+        let mut nr_doms = 0;
+        for cache_id in cache_ids.iter() {
+            cache_to_dom.insert(*cache_id, nr_doms);
+            nr_doms += 1;
+        }
+
+        if nr_doms > atropos_sys::MAX_DOMS {
+            bail!(
+                "Total number of doms {} is greater than MAX_DOMS ({})",
+                nr_doms,
+                atropos_sys::MAX_DOMS
+            );
+        }
+
+        // Build and return dom -> cpumask and cpu -> dom mappings.
+        let mut cpusets =
+            vec![bitvec![u64, Lsb0; 0; atropos_sys::MAX_CPUS as usize]; nr_doms as usize];
+        let mut cpu_to_dom = vec![];
+
+        for cpu in 0..nr_cpus {
+            let dom_id = cache_to_dom[&cpu_to_cache[cpu]];
+            cpusets[dom_id as usize].set(cpu, true);
+            cpu_to_dom.push(dom_id as i32);
+        }
+
+        Ok((cpusets, cpu_to_dom))
+    }
+
+    fn init(opts: &Opts) -> Result<Self> {
+        // Open the BPF prog first for verification.
+        let mut skel_builder = AtroposSkelBuilder::default();
+        skel_builder.obj_builder.debug(opts.verbose > 0);
+        let mut skel = skel_builder.open().context("Failed to open BPF program")?;
+
+        let nr_cpus = libbpf_rs::num_possible_cpus().unwrap();
+        if nr_cpus > atropos_sys::MAX_CPUS as usize {
+            bail!(
+                "nr_cpus ({}) is greater than MAX_CPUS ({})",
+                nr_cpus,
+                atropos_sys::MAX_CPUS
+            );
+        }
+
+        // Initialize skel according to @opts.
+        let (cpusets, cpus) = if opts.cpumasks.len() > 0 {
+            Self::parse_cpusets(&opts.cpumasks, nr_cpus)?
+        } else {
+            Self::cpusets_from_cache(opts.cache_level, nr_cpus)?
+        };
+        let nr_doms = cpusets.len();
+        skel.rodata().nr_doms = nr_doms as u32;
+        skel.rodata().nr_cpus = nr_cpus as u32;
+
+        for (cpu, dom) in cpus.iter().enumerate() {
+            skel.rodata().cpu_dom_id_map[cpu] = *dom as u32;
+        }
+
+        for (dom, cpuset) in cpusets.iter().enumerate() {
+            let raw_cpuset_slice = cpuset.as_raw_slice();
+            let dom_cpumask_slice = &mut skel.rodata().dom_cpumasks[dom];
+            let (left, _) = dom_cpumask_slice.split_at_mut(raw_cpuset_slice.len());
+            left.clone_from_slice(cpuset.as_raw_slice());
+            let cpumask_str = dom_cpumask_slice
+                .iter()
+                .take((nr_cpus + 63) / 64)
+                .rev()
+                .fold(String::new(), |acc, x| format!("{} {:016X}", acc, x));
+            info!(
+                "DOM[{:02}] cpumask{} ({} cpus)",
+                dom,
+                &cpumask_str,
+                cpuset.count_ones()
+            );
+        }
+
+        skel.rodata().slice_us = opts.slice_us;
+        skel.rodata().kthreads_local = opts.kthreads_local;
+        skel.rodata().fifo_sched = opts.fifo_sched;
+        skel.rodata().switch_partial = opts.partial;
+        skel.rodata().greedy_threshold = opts.greedy_threshold;
+
+        // Attach.
+        let mut skel = skel.load().context("Failed to load BPF program")?;
+        skel.attach().context("Failed to attach BPF program")?;
+        let struct_ops = Some(
+            skel.maps_mut()
+                .atropos()
+                .attach_struct_ops()
+                .context("Failed to attach atropos struct ops")?,
+        );
+        info!("Atropos Scheduler Attached");
+
+        // Other stuff.
+        let mut proc_reader = procfs::ProcReader::new();
+        let prev_total_cpu = read_total_cpu(&mut proc_reader)?;
+
+        Ok(Self {
+            skel,
+            struct_ops, // should be held to keep it attached
+
+            nr_cpus,
+            nr_doms,
+            load_decay_factor: opts.load_decay_factor.clamp(0.0, 0.99),
+            balance_load: !opts.no_load_balance,
+
+            proc_reader,
+
+            prev_at: SystemTime::now(),
+            prev_total_cpu,
+            task_loads: BTreeMap::new(),
+
+            nr_lb_data_errors: 0,
+        })
+    }
+
+    fn get_cpu_busy(&mut self) -> Result<f64> {
+        let total_cpu = read_total_cpu(&mut self.proc_reader)?;
+        let busy = match (&self.prev_total_cpu, &total_cpu) {
+            (
+                procfs::CpuStat {
+                    user_usec: Some(prev_user),
+                    nice_usec: Some(prev_nice),
+                    system_usec: Some(prev_system),
+                    idle_usec: Some(prev_idle),
+                    iowait_usec: Some(prev_iowait),
+                    irq_usec: Some(prev_irq),
+                    softirq_usec: Some(prev_softirq),
+                    stolen_usec: Some(prev_stolen),
+                    guest_usec: _,
+                    guest_nice_usec: _,
+                },
+                procfs::CpuStat {
+                    user_usec: Some(curr_user),
+                    nice_usec: Some(curr_nice),
+                    system_usec: Some(curr_system),
+                    idle_usec: Some(curr_idle),
+                    iowait_usec: Some(curr_iowait),
+                    irq_usec: Some(curr_irq),
+                    softirq_usec: Some(curr_softirq),
+                    stolen_usec: Some(curr_stolen),
+                    guest_usec: _,
+                    guest_nice_usec: _,
+                },
+            ) => {
+                let idle_usec = curr_idle - prev_idle;
+                let iowait_usec = curr_iowait - prev_iowait;
+                let user_usec = curr_user - prev_user;
+                let system_usec = curr_system - prev_system;
+                let nice_usec = curr_nice - prev_nice;
+                let irq_usec = curr_irq - prev_irq;
+                let softirq_usec = curr_softirq - prev_softirq;
+                let stolen_usec = curr_stolen - prev_stolen;
+
+                let busy_usec =
+                    user_usec + system_usec + nice_usec + irq_usec + softirq_usec + stolen_usec;
+                let total_usec = idle_usec + busy_usec + iowait_usec;
+                busy_usec as f64 / total_usec as f64
+            }
+            _ => {
+                bail!("Some procfs stats are not populated!");
+            }
+        };
+
+        self.prev_total_cpu = total_cpu;
+        Ok(busy)
+    }
+
+    fn read_bpf_stats(&mut self) -> Result<Vec<u64>> {
+        let mut maps = self.skel.maps_mut();
+        let stats_map = maps.stats();
+        let mut stats: Vec<u64> = Vec::new();
+        let zero_vec = vec![vec![0u8; stats_map.value_size() as usize]; self.nr_cpus];
+
+        for stat in 0..atropos_sys::stat_idx_ATROPOS_NR_STATS {
+            let cpu_stat_vec = stats_map
+                .lookup_percpu(&(stat as u32).to_ne_bytes(), libbpf_rs::MapFlags::ANY)
+                .with_context(|| format!("Failed to lookup stat {}", stat))?
+                .expect("per-cpu stat should exist");
+            let sum = cpu_stat_vec
+                .iter()
+                .map(|val| {
+                    u64::from_ne_bytes(
+                        val.as_slice()
+                            .try_into()
+                            .expect("Invalid value length in stat map"),
+                    )
+                })
+                .sum();
+            stats_map
+                .update_percpu(
+                    &(stat as u32).to_ne_bytes(),
+                    &zero_vec,
+                    libbpf_rs::MapFlags::ANY,
+                )
+                .context("Failed to zero stat")?;
+            stats.push(sum);
+        }
+        Ok(stats)
+    }
+
+    fn report(
+        &self,
+        stats: &Vec<u64>,
+        cpu_busy: f64,
+        processing_dur: Duration,
+        load_avg: f64,
+        dom_loads: &Vec<f64>,
+        imbal: &Vec<f64>,
+    ) {
+        let stat = |idx| stats[idx as usize];
+        let total = stat(atropos_sys::stat_idx_ATROPOS_STAT_WAKE_SYNC)
+            + stat(atropos_sys::stat_idx_ATROPOS_STAT_PREV_IDLE)
+            + stat(atropos_sys::stat_idx_ATROPOS_STAT_PINNED)
+            + stat(atropos_sys::stat_idx_ATROPOS_STAT_DIRECT_DISPATCH)
+            + stat(atropos_sys::stat_idx_ATROPOS_STAT_DSQ_DISPATCH)
+            + stat(atropos_sys::stat_idx_ATROPOS_STAT_GREEDY)
+            + stat(atropos_sys::stat_idx_ATROPOS_STAT_LAST_TASK);
+
+        info!(
+            "cpu={:6.1} load_avg={:7.1} bal={} task_err={} lb_data_err={} proc={:?}ms",
+            cpu_busy * 100.0,
+            load_avg,
+            stats[atropos_sys::stat_idx_ATROPOS_STAT_LOAD_BALANCE as usize],
+            stats[atropos_sys::stat_idx_ATROPOS_STAT_TASK_GET_ERR as usize],
+            self.nr_lb_data_errors,
+            processing_dur.as_millis(),
+        );
+
+        let stat_pct = |idx| stat(idx) as f64 / total as f64 * 100.0;
+
+        info!(
+            "tot={:6} wsync={:4.1} prev_idle={:4.1} pin={:4.1} dir={:4.1} dq={:4.1} greedy={:4.1}",
+            total,
+            stat_pct(atropos_sys::stat_idx_ATROPOS_STAT_WAKE_SYNC),
+            stat_pct(atropos_sys::stat_idx_ATROPOS_STAT_PREV_IDLE),
+            stat_pct(atropos_sys::stat_idx_ATROPOS_STAT_PINNED),
+            stat_pct(atropos_sys::stat_idx_ATROPOS_STAT_DIRECT_DISPATCH),
+            stat_pct(atropos_sys::stat_idx_ATROPOS_STAT_DSQ_DISPATCH),
+            stat_pct(atropos_sys::stat_idx_ATROPOS_STAT_GREEDY),
+        );
+
+        for i in 0..self.nr_doms {
+            info!(
+                "DOM[{:02}] load={:7.1} to_pull={:7.1} to_push={:7.1}",
+                i,
+                dom_loads[i],
+                if imbal[i] < 0.0 { -imbal[i] } else { 0.0 },
+                if imbal[i] > 0.0 { imbal[i] } else { 0.0 },
+            );
+        }
+    }
+
+    fn step(&mut self) -> Result<()> {
+        let started_at = std::time::SystemTime::now();
+        let bpf_stats = self.read_bpf_stats()?;
+        let cpu_busy = self.get_cpu_busy()?;
+
+        let mut lb = LoadBalancer::new(
+            self.skel.maps_mut(),
+            &mut self.task_loads,
+            self.nr_doms,
+            self.load_decay_factor,
+            &mut self.nr_lb_data_errors,
+        );
+
+        lb.read_task_loads(started_at.duration_since(self.prev_at)?)?;
+        lb.calculate_dom_load_balance()?;
+
+        if self.balance_load {
+            lb.load_balance()?;
+        }
+
+        // Extract fields needed for reporting and drop lb to release
+        // mutable borrows.
+        let (load_avg, dom_loads, imbal) = (lb.load_avg, lb.dom_loads, lb.imbal);
+
+        self.report(
+            &bpf_stats,
+            cpu_busy,
+            std::time::SystemTime::now().duration_since(started_at)?,
+            load_avg,
+            &dom_loads,
+            &imbal,
+        );
+
+        self.prev_at = started_at;
+        Ok(())
+    }
+
+    fn read_bpf_exit_type(&mut self) -> i32 {
+        unsafe { std::ptr::read_volatile(&self.skel.bss().exit_type as *const _) }
+    }
+
+    fn report_bpf_exit_type(&mut self) -> Result<()> {
+        // Report msg if EXT_OPS_EXIT_ERROR.
+        match self.read_bpf_exit_type() {
+            0 => Ok(()),
+            etype if etype == 2 => {
+                let cstr = unsafe { CStr::from_ptr(self.skel.bss().exit_msg.as_ptr() as *const _) };
+                let msg = cstr
+                    .to_str()
+                    .context("Failed to convert exit msg to string")
+                    .unwrap();
+                bail!("BPF exit_type={} msg={}", etype, msg);
+            }
+            etype => {
+                info!("BPF exit_type={}", etype);
+                Ok(())
+            }
+        }
+    }
+}
+
+impl<'a> Drop for Scheduler<'a> {
+    fn drop(&mut self) {
+        if let Some(struct_ops) = self.struct_ops.take() {
+            drop(struct_ops);
+        }
+    }
+}
+
+fn main() -> Result<()> {
+    let opts = Opts::parse();
+
+    let llv = match opts.verbose {
+        0 => simplelog::LevelFilter::Info,
+        1 => simplelog::LevelFilter::Debug,
+        _ => simplelog::LevelFilter::Trace,
+    };
+    let mut lcfg = simplelog::ConfigBuilder::new();
+    lcfg.set_time_level(simplelog::LevelFilter::Error)
+        .set_location_level(simplelog::LevelFilter::Off)
+        .set_target_level(simplelog::LevelFilter::Off)
+        .set_thread_level(simplelog::LevelFilter::Off);
+    simplelog::TermLogger::init(
+        llv,
+        lcfg.build(),
+        simplelog::TerminalMode::Stderr,
+        simplelog::ColorChoice::Auto,
+    )?;
+
+    let shutdown = Arc::new(AtomicBool::new(false));
+    let shutdown_clone = shutdown.clone();
+    ctrlc::set_handler(move || {
+        shutdown_clone.store(true, Ordering::Relaxed);
+    })
+    .context("Error setting Ctrl-C handler")?;
+
+    let mut sched = Scheduler::init(&opts)?;
+
+    while !shutdown.load(Ordering::Relaxed) && sched.read_bpf_exit_type() == 0 {
+        std::thread::sleep(Duration::from_secs_f64(opts.interval));
+        sched.step()?;
+    }
+
+    sched.report_bpf_exit_type()
+}
-- 
2.39.2

