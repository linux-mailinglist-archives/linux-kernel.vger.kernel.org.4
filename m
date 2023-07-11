Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136B774E354
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjGKBSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjGKBRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:17:23 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679E1E75;
        Mon, 10 Jul 2023 18:16:08 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666ecf9a081so4500219b3a.2;
        Mon, 10 Jul 2023 18:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038125; x=1691630125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=005G6dRTpW9v+kIN6j9B2wybdX7kaszEnIz/dz8iGW0=;
        b=Tc94Q+DrbnK2CY1OLCQVmWjg5mU3Mq84b83FLAggJ0q2UOGIcu3z/LFZhZEWKtpaK5
         BLhWiObjt5cTreeAAPCRIVLON7kX91AFdAMgpIpelJybNwCmpRH2HYX4fWmahmat1LJW
         /wusIxkQQw/0KgjKNVsx1Myh6qaqL8ldymdWB20QDI0I+KMRitpVdekR27hBk5Cz2OhK
         mLjCTXSKbxxCZzMegm89R+AIf8wdbWoU/8/tKGXolpl9sWAGnp2eqqaWrq+aWSlBpCs7
         wCyfoNWfBOvlUUzYQxKkqzjo1GkXkkv77pLJ7dJgrq1Z5o6RLsqa2sPo0aezhzxO1h+X
         R6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038125; x=1691630125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=005G6dRTpW9v+kIN6j9B2wybdX7kaszEnIz/dz8iGW0=;
        b=O6CDl+Xkq7lrwwKJyean50Sl7ogaV2d6aeGJ4ph8Gu57ODR8Ks5Mb2u4X659gd/e1O
         KqRVAGozVLusuc+YeAz/1xV2GbC+Wq45AGzcmoWkQ68rYYJPjvNbDWYLSuVFX494pqMD
         oTl+vFs4uGKveuj60qBXcKqkC85JujyIbSdoMZnDWUo1vF4s/mat+Sz4briXtKxO95ER
         rAzJuYRfbWsJ7sLw7u24FDxJjuVudXHik2RVZAKzMvfxdhpSMOF0R0Hiz1QW8BCFk7w7
         t2pzxRTmbNG3CRmHyLW6ZrfaAGIQ6YSaDMjOYMs+YrBVeajxNnzHrNz7hcULr5WO2586
         WETw==
X-Gm-Message-State: ABy/qLadPlxy9V1RJlWEivt2VU+GZYzJrBH7UPK1nuV8pP/lQNNB1NDK
        lJIi42u37MzU4iXhLHHBFsQ=
X-Google-Smtp-Source: APBJJlEDbU6ywZKk+hkbpSDufXKo2UpCrr4vGznVchph2ki66OydX3rwYUp3/HZo5KhZlo+Ke3nInQ==
X-Received: by 2002:a05:6a21:328c:b0:115:83f:fce1 with SMTP id yt12-20020a056a21328c00b00115083ffce1mr18578618pzb.5.1689038124766;
        Mon, 10 Jul 2023 18:15:24 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id b3-20020a170903228300b001b8528da516sm511995plh.116.2023.07.10.18.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:15:24 -0700 (PDT)
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
Subject: [PATCH 34/34] sched_ext: Add a rust userspace hybrid example scheduler
Date:   Mon, 10 Jul 2023 15:13:52 -1000
Message-ID: <20230711011412.100319-35-tj@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711011412.100319-1-tj@kernel.org>
References: <20230711011412.100319-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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

v4: * tools/sched_ext/atropos renamed to tools/sched_ext/scx_atropos for
      consistency.

    * LoadBalancer sometimes couldn't converge on balanced state due to
      restrictions it put on each balancing operation. Fixed.

    * Topology information refactored into struct Topology and Tuner is
      added. Tuner runs in shorter cycles (100ms) than LoadBalancer and
      dynamically adjusts scheduling behaviors, currently, based on the
      per-domain utilization states.

    * ->select_cpu() has been revamped. Combined with other improvements,
      this allows atropos to outperform CFS in various sub-saturation
      scenarios when tested with fio over dm-crypt.

    * Many minor code cleanups and improvements.

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
 tools/sched_ext/Makefile                      |   13 +-
 tools/sched_ext/scx_atropos/.gitignore        |    3 +
 tools/sched_ext/scx_atropos/Cargo.toml        |   27 +
 tools/sched_ext/scx_atropos/build.rs          |   70 +
 tools/sched_ext/scx_atropos/rustfmt.toml      |    8 +
 .../sched_ext/scx_atropos/src/atropos_sys.rs  |   10 +
 .../scx_atropos/src/bpf/atropos.bpf.c         |  978 ++++++++++++++
 tools/sched_ext/scx_atropos/src/bpf/atropos.h |   64 +
 tools/sched_ext/scx_atropos/src/main.rs       | 1196 +++++++++++++++++
 9 files changed, 2367 insertions(+), 2 deletions(-)
 create mode 100644 tools/sched_ext/scx_atropos/.gitignore
 create mode 100644 tools/sched_ext/scx_atropos/Cargo.toml
 create mode 100644 tools/sched_ext/scx_atropos/build.rs
 create mode 100644 tools/sched_ext/scx_atropos/rustfmt.toml
 create mode 100644 tools/sched_ext/scx_atropos/src/atropos_sys.rs
 create mode 100644 tools/sched_ext/scx_atropos/src/bpf/atropos.bpf.c
 create mode 100644 tools/sched_ext/scx_atropos/src/bpf/atropos.h
 create mode 100644 tools/sched_ext/scx_atropos/src/main.rs

diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
index 092c3859228f..1515ff9cce7f 100644
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
@@ -115,7 +117,7 @@ BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH)					\
 	     -Wall -Wno-compare-distinct-pointer-types				\
 	     -O2 -mcpu=v3
 
-all: scx_simple scx_qmap scx_central scx_pair scx_flatcg scx_userland
+all: scx_simple scx_qmap scx_central scx_pair scx_flatcg scx_userland scx_atropos
 
 # sort removes libbpf duplicates when not cross-building
 MAKE_DIRS := $(sort $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf		\
@@ -190,12 +192,19 @@ scx_userland: scx_userland.c scx_userland.skel.h scx_userland.h user_exit_info.h
 	$(CC) $(CFLAGS) -c $< -o $@.o
 	$(CC) -o $@ $@.o $(HOST_BPFOBJ) $(LDFLAGS)
 
+scx_atropos: export RUSTFLAGS = -C link-args=-lzstd -C link-args=-lz -C link-args=-lelf -L $(BPFOBJ_DIR)
+scx_atropos: export ATROPOS_CLANG = $(CLANG)
+scx_atropos: export ATROPOS_BPF_CFLAGS = $(BPF_CFLAGS)
+scx_atropos: $(INCLUDE_DIR)/vmlinux.h
+	cargo build --manifest-path=scx_atropos/Cargo.toml $(CARGOFLAGS)
+
 clean:
+	cargo clean --manifest-path=scx_atropos/Cargo.toml
 	rm -rf $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)
 	rm -f *.o *.bpf.o *.skel.h *.subskel.h
 	rm -f scx_simple scx_qmap scx_central scx_pair scx_flatcg scx_userland
 
-.PHONY: all clean
+.PHONY: all scx_atropos clean
 
 # delete failed targets
 .DELETE_ON_ERROR:
diff --git a/tools/sched_ext/scx_atropos/.gitignore b/tools/sched_ext/scx_atropos/.gitignore
new file mode 100644
index 000000000000..186dba259ec2
--- /dev/null
+++ b/tools/sched_ext/scx_atropos/.gitignore
@@ -0,0 +1,3 @@
+src/bpf/.output
+Cargo.lock
+target
diff --git a/tools/sched_ext/scx_atropos/Cargo.toml b/tools/sched_ext/scx_atropos/Cargo.toml
new file mode 100644
index 000000000000..a5ab02cb55f8
--- /dev/null
+++ b/tools/sched_ext/scx_atropos/Cargo.toml
@@ -0,0 +1,27 @@
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
+hex = "0.4.3"
+libbpf-rs = "0.19.1"
+libbpf-sys = { version = "1.0.4", features = ["novendor", "static"] }
+libc = "0.2.137"
+log = "0.4.17"
+ordered-float = "3.4.0"
+simplelog = "0.12.0"
+
+[build-dependencies]
+bindgen = { version = "0.61.0" }
+libbpf-cargo = "0.13.0"
+
+[features]
+enable_backtrace = []
diff --git a/tools/sched_ext/scx_atropos/build.rs b/tools/sched_ext/scx_atropos/build.rs
new file mode 100644
index 000000000000..26e792c5e17e
--- /dev/null
+++ b/tools/sched_ext/scx_atropos/build.rs
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
diff --git a/tools/sched_ext/scx_atropos/rustfmt.toml b/tools/sched_ext/scx_atropos/rustfmt.toml
new file mode 100644
index 000000000000..b7258ed0a8d8
--- /dev/null
+++ b/tools/sched_ext/scx_atropos/rustfmt.toml
@@ -0,0 +1,8 @@
+# Get help on options with `rustfmt --help=config`
+# Please keep these in alphabetical order.
+edition = "2021"
+group_imports = "StdExternalCrate"
+imports_granularity = "Item"
+merge_derives = false
+use_field_init_shorthand = true
+version = "Two"
diff --git a/tools/sched_ext/scx_atropos/src/atropos_sys.rs b/tools/sched_ext/scx_atropos/src/atropos_sys.rs
new file mode 100644
index 000000000000..bbeaf856d40e
--- /dev/null
+++ b/tools/sched_ext/scx_atropos/src/atropos_sys.rs
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
diff --git a/tools/sched_ext/scx_atropos/src/bpf/atropos.bpf.c b/tools/sched_ext/scx_atropos/src/bpf/atropos.bpf.c
new file mode 100644
index 000000000000..118fe728e886
--- /dev/null
+++ b/tools/sched_ext/scx_atropos/src/bpf/atropos.bpf.c
@@ -0,0 +1,978 @@
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
+const volatile __u64 slice_ns = SCX_SLICE_DFL;
+
+/*
+ * Exit info
+ */
+int exit_type = SCX_EXIT_NONE;
+char exit_msg[SCX_EXIT_MSG_LEN];
+
+/*
+ * Per-CPU context
+ */
+struct pcpu_ctx {
+	__u32 dom_rr_cur; /* used when scanning other doms */
+
+	/* libbpf-rs does not respect the alignment, so pad out the struct explicitly */
+	__u8 _padding[CACHELINE_SIZE - sizeof(u32)];
+} __attribute__((aligned(CACHELINE_SIZE)));
+
+struct pcpu_ctx pcpu_ctx[MAX_CPUS];
+
+/*
+ * Domain context
+ */
+struct dom_ctx {
+	struct bpf_cpumask __kptr *cpumask;
+	struct bpf_cpumask __kptr *direct_greedy_cpumask;
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
+/*
+ * Userspace tuner will frequently update the following struct with tuning
+ * parameters and bump its gen. refresh_tune_params() converts them into forms
+ * that can be used directly in the scheduling paths.
+ */
+struct tune_input{
+	__u64 gen;
+	__u64 direct_greedy_cpumask[MAX_CPUS / 64];
+	__u64 kick_greedy_cpumask[MAX_CPUS / 64];
+} tune_input;
+
+__u64 tune_params_gen;
+private(A) struct bpf_cpumask __kptr *direct_greedy_cpumask;
+private(A) struct bpf_cpumask __kptr *kick_greedy_cpumask;
+
+static inline bool vtime_before(u64 a, u64 b)
+{
+	return (s64)(a - b) < 0;
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
+static void refresh_tune_params(void)
+{
+	s32 cpu;
+
+	if (tune_params_gen == tune_input.gen)
+		return;
+
+	tune_params_gen = tune_input.gen;
+
+	bpf_for(cpu, 0, nr_cpus) {
+		u32 dom_id = cpu_to_dom_id(cpu);
+		struct dom_ctx *domc;
+
+		if (!(domc = bpf_map_lookup_elem(&dom_ctx, &dom_id))) {
+			scx_bpf_error("Failed to lookup dom[%u]", dom_id);
+			return;
+		}
+
+		if (tune_input.direct_greedy_cpumask[cpu / 64] & (1LLU << (cpu % 64))) {
+			if (direct_greedy_cpumask)
+				bpf_cpumask_set_cpu(cpu, direct_greedy_cpumask);
+			if (domc->direct_greedy_cpumask)
+				bpf_cpumask_set_cpu(cpu, domc->direct_greedy_cpumask);
+		} else {
+			if (direct_greedy_cpumask)
+				bpf_cpumask_clear_cpu(cpu, direct_greedy_cpumask);
+			if (domc->direct_greedy_cpumask)
+				bpf_cpumask_clear_cpu(cpu, domc->direct_greedy_cpumask);
+		}
+
+		if (tune_input.kick_greedy_cpumask[cpu / 64] & (1LLU << (cpu % 64))) {
+			if (kick_greedy_cpumask)
+				bpf_cpumask_set_cpu(cpu, kick_greedy_cpumask);
+		} else {
+			if (kick_greedy_cpumask)
+				bpf_cpumask_clear_cpu(cpu, kick_greedy_cpumask);
+		}
+	}
+}
+
+static bool task_set_domain(struct task_ctx *task_ctx, struct task_struct *p,
+			    u32 new_dom_id, bool init_dsq_vtime)
+{
+	struct dom_ctx *old_domc, *new_domc;
+	struct bpf_cpumask *d_cpumask, *t_cpumask;
+	u32 old_dom_id = task_ctx->dom_id;
+	s64 vtime_delta;
+
+	old_domc = bpf_map_lookup_elem(&dom_ctx, &old_dom_id);
+	if (!old_domc) {
+		scx_bpf_error("Failed to lookup old dom%u", old_dom_id);
+		return false;
+	}
+
+	if (init_dsq_vtime)
+		vtime_delta = 0;
+	else
+		vtime_delta = p->scx.dsq_vtime - old_domc->vtime_now;
+
+	new_domc = bpf_map_lookup_elem(&dom_ctx, &new_dom_id);
+	if (!new_domc) {
+		scx_bpf_error("Failed to lookup new dom%u", new_dom_id);
+		return false;
+	}
+
+	d_cpumask = new_domc->cpumask;
+	if (!d_cpumask) {
+		scx_bpf_error("Failed to get dom%u cpumask kptr",
+			      new_dom_id);
+		return false;
+	}
+
+	t_cpumask = task_ctx->cpumask;
+	if (!t_cpumask) {
+		scx_bpf_error("Failed to look up task cpumask");
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
+	return task_ctx->dom_id == new_dom_id;
+}
+
+s32 BPF_STRUCT_OPS(atropos_select_cpu, struct task_struct *p, s32 prev_cpu,
+		   u64 wake_flags)
+{
+	struct cpumask *idle_smtmask = scx_bpf_get_idle_smtmask();
+	struct task_ctx *task_ctx;
+	struct bpf_cpumask *p_cpumask;
+	pid_t pid = p->pid;
+	bool prev_domestic, has_idle_cores;
+	s32 cpu;
+
+	refresh_tune_params();
+
+	if (!(task_ctx = bpf_map_lookup_elem(&task_data, &pid)) ||
+	    !(p_cpumask = task_ctx->cpumask))
+		goto enoent;
+
+	if (kthreads_local &&
+	    (p->flags & PF_KTHREAD) && p->nr_cpus_allowed == 1) {
+		cpu = prev_cpu;
+		stat_add(ATROPOS_STAT_DIRECT_DISPATCH, 1);
+		goto direct;
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
+				goto enoent;
+			}
+			d_cpumask = domc->cpumask;
+			if (!d_cpumask) {
+				scx_bpf_error("Failed to acquire dom%u cpumask kptr",
+					      task_ctx->dom_id);
+				goto enoent;
+			}
+
+			idle_cpumask = scx_bpf_get_idle_cpumask();
+
+			has_idle = bpf_cpumask_intersects((const struct cpumask *)d_cpumask,
+							  idle_cpumask);
+
+			scx_bpf_put_idle_cpumask(idle_cpumask);
+
+			if (has_idle) {
+				cpu = bpf_get_smp_processor_id();
+				if (bpf_cpumask_test_cpu(cpu, p->cpus_ptr)) {
+					stat_add(ATROPOS_STAT_WAKE_SYNC, 1);
+					goto direct;
+				}
+			}
+		}
+	}
+
+	/* If only one CPU is allowed, dispatch */
+	if (p->nr_cpus_allowed == 1) {
+		stat_add(ATROPOS_STAT_PINNED, 1);
+		cpu = prev_cpu;
+		goto direct;
+	}
+
+	has_idle_cores = !bpf_cpumask_empty(idle_smtmask);
+
+	/* did @p get pulled out to a foreign domain by e.g. greedy execution? */
+	prev_domestic = bpf_cpumask_test_cpu(prev_cpu,
+					     (const struct cpumask *)p_cpumask);
+
+	/*
+	 * See if we want to keep @prev_cpu. We want to keep @prev_cpu if the
+	 * whole physical core is idle. If the sibling[s] are busy, it's likely
+	 * more advantageous to look for wholly idle cores first.
+	 */
+	if (prev_domestic) {
+		if (bpf_cpumask_test_cpu(prev_cpu, idle_smtmask) &&
+		    scx_bpf_test_and_clear_cpu_idle(prev_cpu)) {
+			stat_add(ATROPOS_STAT_PREV_IDLE, 1);
+			cpu = prev_cpu;
+			goto direct;
+		}
+	} else {
+		/*
+		 * @prev_cpu is foreign. Linger iff the domain isn't too busy as
+		 * indicated by direct_greedy_cpumask. There may also be an idle
+		 * CPU in the domestic domain
+		 */
+		if (direct_greedy_cpumask &&
+		    bpf_cpumask_test_cpu(prev_cpu, (const struct cpumask *)
+					 direct_greedy_cpumask) &&
+		    bpf_cpumask_test_cpu(prev_cpu, idle_smtmask) &&
+		    scx_bpf_test_and_clear_cpu_idle(prev_cpu)) {
+			stat_add(ATROPOS_STAT_GREEDY_IDLE, 1);
+			cpu = prev_cpu;
+			goto direct;
+		}
+	}
+
+	/*
+	 * @prev_cpu didn't work out. Let's see whether there's an idle CPU @p
+	 * can be directly dispatched to. We'll first try to find the best idle
+	 * domestic CPU and then move onto foreign.
+	 */
+
+	/* If there is a domestic idle core, dispatch directly */
+	if (has_idle_cores) {
+		cpu = scx_bpf_pick_idle_cpu((const struct cpumask *)p_cpumask,
+					    SCX_PICK_IDLE_CORE);
+		if (cpu >= 0) {
+			stat_add(ATROPOS_STAT_DIRECT_DISPATCH, 1);
+			goto direct;
+		}
+	}
+
+	/*
+	 * If @prev_cpu was domestic and is idle itself even though the core
+	 * isn't, picking @prev_cpu may improve L1/2 locality.
+	 */
+	if (prev_domestic && scx_bpf_test_and_clear_cpu_idle(prev_cpu)) {
+		stat_add(ATROPOS_STAT_DIRECT_DISPATCH, 1);
+		cpu = prev_cpu;
+		goto direct;
+	}
+
+	/* If there is any domestic idle CPU, dispatch directly */
+	cpu = scx_bpf_pick_idle_cpu((const struct cpumask *)p_cpumask, 0);
+	if (cpu >= 0) {
+		stat_add(ATROPOS_STAT_DIRECT_DISPATCH, 1);
+		goto direct;
+	}
+
+	/*
+	 * Domestic domain is fully booked. If there are CPUs which are idle and
+	 * under-utilized, ignore domain boundaries and push the task there. Try
+	 * to find an idle core first.
+	 */
+	if (task_ctx->all_cpus && direct_greedy_cpumask &&
+	    !bpf_cpumask_empty((const struct cpumask *)direct_greedy_cpumask)) {
+		u32 dom_id = cpu_to_dom_id(prev_cpu);
+		struct dom_ctx *domc;
+
+		if (!(domc = bpf_map_lookup_elem(&dom_ctx, &dom_id))) {
+			scx_bpf_error("Failed to lookup dom[%u]", dom_id);
+			goto enoent;
+		}
+
+		/* Try to find an idle core in the previous and then any domain */
+		if (has_idle_cores) {
+			if (domc->direct_greedy_cpumask) {
+				cpu = scx_bpf_pick_idle_cpu((const struct cpumask *)
+							    domc->direct_greedy_cpumask,
+							    SCX_PICK_IDLE_CORE);
+				if (cpu >= 0) {
+					stat_add(ATROPOS_STAT_DIRECT_GREEDY, 1);
+					goto direct;
+				}
+			}
+
+			if (direct_greedy_cpumask) {
+				cpu = scx_bpf_pick_idle_cpu((const struct cpumask *)
+							    direct_greedy_cpumask,
+							    SCX_PICK_IDLE_CORE);
+				if (cpu >= 0) {
+					stat_add(ATROPOS_STAT_DIRECT_GREEDY_FAR, 1);
+					goto direct;
+				}
+			}
+		}
+
+		/*
+		 * No idle core. Is there any idle CPU?
+		 */
+		if (domc->direct_greedy_cpumask) {
+			cpu = scx_bpf_pick_idle_cpu((const struct cpumask *)
+						    domc->direct_greedy_cpumask, 0);
+			if (cpu >= 0) {
+				stat_add(ATROPOS_STAT_DIRECT_GREEDY, 1);
+				goto direct;
+			}
+		}
+
+		if (direct_greedy_cpumask) {
+			cpu = scx_bpf_pick_idle_cpu((const struct cpumask *)
+						    direct_greedy_cpumask, 0);
+			if (cpu >= 0) {
+				stat_add(ATROPOS_STAT_DIRECT_GREEDY_FAR, 1);
+				goto direct;
+			}
+		}
+	}
+
+	/*
+	 * We're going to queue on the domestic domain's DSQ. @prev_cpu may be
+	 * in a different domain. Returning an out-of-domain CPU can lead to
+	 * stalls as all in-domain CPUs may be idle by the time @p gets
+	 * enqueued.
+	 */
+	if (prev_domestic)
+		cpu = prev_cpu;
+	else
+		cpu = scx_bpf_pick_any_cpu((const struct cpumask *)p_cpumask, 0);
+
+	scx_bpf_put_idle_cpumask(idle_smtmask);
+	return cpu;
+
+direct:
+	task_ctx->dispatch_local = true;
+	scx_bpf_put_idle_cpumask(idle_smtmask);
+	return cpu;
+
+enoent:
+	scx_bpf_put_idle_cpumask(idle_smtmask);
+	return -ENOENT;
+}
+
+void BPF_STRUCT_OPS(atropos_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	struct task_ctx *task_ctx;
+	struct bpf_cpumask *p_cpumask;
+	pid_t pid = p->pid;
+	u32 *new_dom;
+	s32 cpu;
+
+	if (!(task_ctx = bpf_map_lookup_elem(&task_data, &pid)) ||
+	    !(p_cpumask = task_ctx->cpumask)) {
+		scx_bpf_error("Failed to lookup task_ctx or cpumask");
+		return;
+	}
+
+	/*
+	 * Migrate @p to a new domain if requested by userland through lb_data.
+	 */
+	new_dom = bpf_map_lookup_elem(&lb_data, &pid);
+	if (new_dom && *new_dom != task_ctx->dom_id &&
+	    task_set_domain(task_ctx, p, *new_dom, false)) {
+		stat_add(ATROPOS_STAT_LOAD_BALANCE, 1);
+		task_ctx->dispatch_local = false;
+		cpu = scx_bpf_pick_any_cpu((const struct cpumask *)p_cpumask, 0);
+		if (cpu >= 0)
+			scx_bpf_kick_cpu(cpu, 0);
+		goto dom_queue;
+	}
+
+	if (task_ctx->dispatch_local) {
+		task_ctx->dispatch_local = false;
+		scx_bpf_dispatch(p, SCX_DSQ_LOCAL, slice_ns, enq_flags);
+		return;
+	}
+
+	/*
+	 * @p is about to be queued on its domain's dsq. However, @p may be on a
+	 * foreign CPU due to a greedy execution and not have gone through
+	 * ->select_cpu() if it's being enqueued e.g. after slice exhaustion. If
+	 * so, @p would be queued on its domain's dsq but none of the CPUs in
+	 * the domain would be woken up which can induce temporary execution
+	 * stalls. Kick a domestic CPU if @p is on a foreign domain.
+	 */
+	if (!bpf_cpumask_test_cpu(scx_bpf_task_cpu(p), (const struct cpumask *)p_cpumask)) {
+		cpu = scx_bpf_pick_any_cpu((const struct cpumask *)p_cpumask, 0);
+		scx_bpf_kick_cpu(cpu, 0);
+		stat_add(ATROPOS_STAT_REPATRIATE, 1);
+	}
+
+dom_queue:
+	if (fifo_sched) {
+		scx_bpf_dispatch(p, task_ctx->dom_id, slice_ns,
+				 enq_flags);
+	} else {
+		u64 vtime = p->scx.dsq_vtime;
+		u32 dom_id = task_ctx->dom_id;
+		struct dom_ctx *domc;
+
+		domc = bpf_map_lookup_elem(&dom_ctx, &dom_id);
+		if (!domc) {
+			scx_bpf_error("Failed to lookup dom[%u]", dom_id);
+			return;
+		}
+
+		/*
+		 * Limit the amount of budget that an idling task can accumulate
+		 * to one slice.
+		 */
+		if (vtime_before(vtime, domc->vtime_now - slice_ns))
+			vtime = domc->vtime_now - slice_ns;
+
+		scx_bpf_dispatch_vtime(p, task_ctx->dom_id, slice_ns, vtime,
+				       enq_flags);
+	}
+
+	/*
+	 * If there are CPUs which are idle and not saturated, wake them up to
+	 * see whether they'd be able to steal the just queued task. This path
+	 * is taken only if DIRECT_GREEDY didn't trigger in select_cpu().
+	 *
+	 * While both mechanisms serve very similar purposes, DIRECT_GREEDY
+	 * emplaces the task in a foreign CPU directly while KICK_GREEDY just
+	 * wakes up a foreign CPU which will then first try to execute from its
+	 * domestic domain first before snooping foreign ones.
+	 *
+	 * While KICK_GREEDY is a more expensive way of accelerating greedy
+	 * execution, DIRECT_GREEDY shows negative performance impacts when the
+	 * CPUs are highly loaded while KICK_GREEDY doesn't. Even under fairly
+	 * high utilization, KICK_GREEDY can slightly improve work-conservation.
+	 */
+	if (task_ctx->all_cpus && kick_greedy_cpumask) {
+		cpu = scx_bpf_pick_idle_cpu((const struct cpumask *)
+					    kick_greedy_cpumask, 0);
+		if (cpu >= 0) {
+			stat_add(ATROPOS_STAT_KICK_GREEDY, 1);
+			scx_bpf_kick_cpu(cpu, 0);
+		}
+	}
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
+	struct task_ctx *task_ctx;
+	pid_t pid = p->pid;
+
+	if (!(task_ctx = bpf_map_lookup_elem(&task_data, &pid))) {
+		scx_bpf_error("Failed to lookup task_ctx");
+		return;
+	}
+
+	task_ctx->runnable_at = bpf_ktime_get_ns();
+	task_ctx->is_kworker = p->flags & PF_WQ_WORKER;
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
+		scx_bpf_error("Failed to lookup task_ctx");
+		return;
+	}
+	dom_id = taskc->dom_id;
+
+	domc = bpf_map_lookup_elem(&dom_ctx, &dom_id);
+	if (!domc) {
+		scx_bpf_error("Failed to lookup dom[%u]", dom_id);
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
+	p->scx.dsq_vtime += (slice_ns - p->scx.slice) * 100 / p->scx.weight;
+}
+
+void BPF_STRUCT_OPS(atropos_quiescent, struct task_struct *p, u64 deq_flags)
+{
+	struct task_ctx *task_ctx;
+	pid_t pid = p->pid;
+
+	if (!(task_ctx = bpf_map_lookup_elem(&task_data, &pid))) {
+		scx_bpf_error("Failed to lookup task_ctx");
+		return;
+	}
+
+	task_ctx->runnable_for += bpf_ktime_get_ns() - task_ctx->runnable_at;
+	task_ctx->runnable_at = 0;
+}
+
+void BPF_STRUCT_OPS(atropos_set_weight, struct task_struct *p, u32 weight)
+{
+	struct task_ctx *task_ctx;
+	pid_t pid = p->pid;
+
+	if (!(task_ctx = bpf_map_lookup_elem(&task_data, &pid))) {
+		scx_bpf_error("Failed to lookup task_ctx");
+		return;
+	}
+
+	task_ctx->weight = weight;
+}
+
+static u32 task_pick_domain(struct task_ctx *task_ctx, struct task_struct *p,
+			    const struct cpumask *cpumask)
+{
+	s32 cpu = bpf_get_smp_processor_id();
+	u32 first_dom = MAX_DOMS, dom;
+
+	if (cpu < 0 || cpu >= MAX_CPUS)
+		return MAX_DOMS;
+
+	task_ctx->dom_mask = 0;
+
+	dom = pcpu_ctx[cpu].dom_rr_cur++;
+	bpf_repeat(nr_doms) {
+		dom = (dom + 1) % nr_doms;
+		if (cpumask_intersects_domain(cpumask, dom)) {
+			task_ctx->dom_mask |= 1LLU << dom;
+			/*
+			 * AsThe starting point is round-robin'd and the first
+			 * match should be spread across all the domains.
+			 */
+			if (first_dom == MAX_DOMS)
+				first_dom = dom;
+		}
+	}
+
+	return first_dom;
+}
+
+static void task_pick_and_set_domain(struct task_ctx *task_ctx,
+				     struct task_struct *p,
+				     const struct cpumask *cpumask,
+				     bool init_dsq_vtime)
+{
+	u32 dom_id = 0;
+
+	if (nr_doms > 1)
+		dom_id = task_pick_domain(task_ctx, p, cpumask);
+
+	if (!task_set_domain(task_ctx, p, dom_id, init_dsq_vtime))
+		scx_bpf_error("Failed to set dom%d for %s[%d]",
+			      dom_id, p->comm, p->pid);
+}
+
+void BPF_STRUCT_OPS(atropos_set_cpumask, struct task_struct *p,
+		    const struct cpumask *cpumask)
+{
+	struct task_ctx *task_ctx;
+	pid_t pid = p->pid;
+
+	if (!(task_ctx = bpf_map_lookup_elem(&task_data, &pid))) {
+		scx_bpf_error("Failed to lookup task_ctx for %s[%d]",
+			      p->comm, pid);
+		return;
+	}
+
+	task_pick_and_set_domain(task_ctx, p, cpumask, false);
+	task_ctx->all_cpus = bpf_cpumask_full(cpumask);
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
+	task_pick_and_set_domain(map_value, p, p->cpus_ptr, true);
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
+static s32 create_dom(u32 dom_id)
+{
+	struct dom_ctx domc_init = {}, *domc;
+	struct bpf_cpumask *cpumask;
+	u32 cpu;
+	s32 ret;
+
+	ret = scx_bpf_create_dsq(dom_id, -1);
+	if (ret < 0) {
+		scx_bpf_error("Failed to create dsq %u (%d)", dom_id, ret);
+		return ret;
+	}
+
+	ret = bpf_map_update_elem(&dom_ctx, &dom_id, &domc_init, 0);
+	if (ret) {
+		scx_bpf_error("Failed to add dom_ctx entry %u (%d)", dom_id, ret);
+		return ret;
+	}
+
+	domc = bpf_map_lookup_elem(&dom_ctx, &dom_id);
+	if (!domc) {
+		/* Should never happen, we just inserted it above. */
+		scx_bpf_error("No dom%u", dom_id);
+		return -ENOENT;
+	}
+
+	cpumask = bpf_cpumask_create();
+	if (!cpumask) {
+		scx_bpf_error("Failed to create BPF cpumask for domain %u", dom_id);
+		return -ENOMEM;
+	}
+
+	for (cpu = 0; cpu < MAX_CPUS; cpu++) {
+		const volatile __u64 *dmask;
+
+		dmask = MEMBER_VPTR(dom_cpumasks, [dom_id][cpu / 64]);
+		if (!dmask) {
+			scx_bpf_error("array index error");
+			bpf_cpumask_release(cpumask);
+			return -ENOENT;
+		}
+
+		if (*dmask & (1LLU << (cpu % 64)))
+			bpf_cpumask_set_cpu(cpu, cpumask);
+	}
+
+	cpumask = bpf_kptr_xchg(&domc->cpumask, cpumask);
+	if (cpumask) {
+		scx_bpf_error("Domain %u cpumask already present", dom_id);
+		bpf_cpumask_release(cpumask);
+		return -EEXIST;
+	}
+
+	cpumask = bpf_cpumask_create();
+	if (!cpumask) {
+		scx_bpf_error("Failed to create BPF cpumask for domain %u",
+			      dom_id);
+		return -ENOMEM;
+	}
+
+	cpumask = bpf_kptr_xchg(&domc->direct_greedy_cpumask, cpumask);
+	if (cpumask) {
+		scx_bpf_error("Domain %u direct_greedy_cpumask already present",
+			      dom_id);
+		bpf_cpumask_release(cpumask);
+		return -EEXIST;
+	}
+
+	return 0;
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(atropos_init)
+{
+	struct bpf_cpumask *cpumask;
+	s32 i, ret;
+
+	if (!switch_partial)
+		scx_bpf_switch_all();
+
+	bpf_for(i, 0, nr_doms) {
+		ret = create_dom(i);
+		if (ret)
+			return ret;
+	}
+
+	for (u32 i = 0; i < nr_cpus; i++)
+		pcpu_ctx[i].dom_rr_cur = i;
+
+	cpumask = bpf_cpumask_create();
+	if (!cpumask)
+		return -ENOMEM;
+	cpumask = bpf_kptr_xchg(&direct_greedy_cpumask, cpumask);
+	if (cpumask)
+		bpf_cpumask_release(cpumask);
+
+	cpumask = bpf_cpumask_create();
+	if (!cpumask)
+		return -ENOMEM;
+	cpumask = bpf_kptr_xchg(&kick_greedy_cpumask, cpumask);
+	if (cpumask)
+		bpf_cpumask_release(cpumask);
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
+SEC(".struct_ops.link")
+struct sched_ext_ops atropos = {
+	.select_cpu		= (void *)atropos_select_cpu,
+	.enqueue		= (void *)atropos_enqueue,
+	.dispatch		= (void *)atropos_dispatch,
+	.runnable		= (void *)atropos_runnable,
+	.running		= (void *)atropos_running,
+	.stopping		= (void *)atropos_stopping,
+	.quiescent		= (void *)atropos_quiescent,
+	.set_weight		= (void *)atropos_set_weight,
+	.set_cpumask		= (void *)atropos_set_cpumask,
+	.prep_enable		= (void *)atropos_prep_enable,
+	.disable		= (void *)atropos_disable,
+	.init			= (void *)atropos_init,
+	.exit			= (void *)atropos_exit,
+	.name			= "atropos",
+};
diff --git a/tools/sched_ext/scx_atropos/src/bpf/atropos.h b/tools/sched_ext/scx_atropos/src/bpf/atropos.h
new file mode 100644
index 000000000000..894782e32fa1
--- /dev/null
+++ b/tools/sched_ext/scx_atropos/src/bpf/atropos.h
@@ -0,0 +1,64 @@
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
+	/* The following fields add up to all dispatched tasks */
+	ATROPOS_STAT_WAKE_SYNC,
+	ATROPOS_STAT_PREV_IDLE,
+	ATROPOS_STAT_GREEDY_IDLE,
+	ATROPOS_STAT_PINNED,
+	ATROPOS_STAT_DIRECT_DISPATCH,
+	ATROPOS_STAT_DIRECT_GREEDY,
+	ATROPOS_STAT_DIRECT_GREEDY_FAR,
+	ATROPOS_STAT_DSQ_DISPATCH,
+	ATROPOS_STAT_GREEDY,
+
+	/* Extra stats that don't contribute to total */
+	ATROPOS_STAT_REPATRIATE,
+	ATROPOS_STAT_KICK_GREEDY,
+	ATROPOS_STAT_LOAD_BALANCE,
+
+	/* Errors */
+	ATROPOS_STAT_TASK_GET_ERR,
+
+	ATROPOS_NR_STATS,
+};
+
+struct task_ctx {
+	/* The domains this task can run on */
+	unsigned long long dom_mask;
+
+	struct bpf_cpumask __kptr *cpumask;
+	unsigned int dom_id;
+	unsigned int weight;
+	unsigned long long runnable_at;
+	unsigned long long runnable_for;
+
+	/* The task is a workqueue worker thread */
+	bool is_kworker;
+
+	/* Allowed on all CPUs and eligible for DIRECT_GREEDY optimization */
+	bool all_cpus;
+
+	/* select_cpu() telling enqueue() to queue directly on the DSQ */
+	bool dispatch_local;
+};
+
+#endif /* __ATROPOS_H */
diff --git a/tools/sched_ext/scx_atropos/src/main.rs b/tools/sched_ext/scx_atropos/src/main.rs
new file mode 100644
index 000000000000..6d8ea6f4ef3c
--- /dev/null
+++ b/tools/sched_ext/scx_atropos/src/main.rs
@@ -0,0 +1,1196 @@
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
+use std::collections::BTreeMap;
+use std::collections::BTreeSet;
+use std::ffi::CStr;
+use std::ops::Bound::Included;
+use std::ops::Bound::Unbounded;
+use std::sync::atomic::AtomicBool;
+use std::sync::atomic::Ordering;
+use std::sync::Arc;
+use std::time::Duration;
+use std::time::Instant;
+
+use anyhow::anyhow;
+use anyhow::bail;
+use anyhow::Context;
+use anyhow::Result;
+use bitvec::prelude::*;
+use clap::Parser;
+use log::info;
+use log::trace;
+use log::warn;
+use ordered_float::OrderedFloat;
+
+/// Atropos is a multi-domain BPF / userspace hybrid scheduler where the BPF
+/// part does simple round robin in each domain and the userspace part
+/// calculates the load factor of each domain and tells the BPF part how to load
+/// balance the domains.
+///
+/// This scheduler demonstrates dividing scheduling logic between BPF and
+/// userspace and using rust to build the userspace part. An earlier variant of
+/// this scheduler was used to balance across six domains, each representing a
+/// chiplet in a six-chiplet AMD processor, and could match the performance of
+/// production setup using CFS.
+///
+/// WARNING: Atropos currently assumes that all domains have equal
+/// processing power and at similar distances from each other. This
+/// limitation will be removed in the future.
+#[derive(Debug, Parser)]
+struct Opts {
+    /// Scheduling slice duration in microseconds.
+    #[clap(short = 's', long, default_value = "20000")]
+    slice_us: u64,
+
+    /// Monitoring and load balance interval in seconds.
+    #[clap(short = 'i', long, default_value = "2.0")]
+    interval: f64,
+
+    /// Tuner runs at higher frequency than the load balancer to dynamically
+    /// tune scheduling behavior. Tuning interval in seconds.
+    #[clap(short = 'I', long, default_value = "0.1")]
+    tune_interval: f64,
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
+    #[clap(short = 'g', long, default_value = "1")]
+    greedy_threshold: u32,
+
+    /// The load decay factor. Every interval, the existing load is decayed
+    /// by this factor and new load is added. Must be in the range [0.0,
+    /// 0.99]. The smaller the value, the more sensitive load calculation
+    /// is to recent changes. When 0.0, history is ignored and the load
+    /// value from the latest period is used directly.
+    #[clap(long, default_value = "0.5")]
+    load_decay_factor: f64,
+
+    /// Disable load balancing. Unless disabled, periodically userspace will
+    /// calculate the load factor of each domain and instruct BPF which
+    /// processes to move.
+    #[clap(long, action = clap::ArgAction::SetTrue)]
+    no_load_balance: bool,
+
+    /// Put per-cpu kthreads directly into local dsq's.
+    #[clap(short = 'k', long, action = clap::ArgAction::SetTrue)]
+    kthreads_local: bool,
+
+    /// In recent kernels (>=v6.6), the kernel is responsible for balancing
+    /// kworkers across L3 cache domains. Exclude them from load-balancing
+    /// to avoid conflicting operations. Greedy executions still apply.
+    #[clap(short = 'b', long, action = clap::ArgAction::SetTrue)]
+    balanced_kworkers: bool,
+
+    /// Use FIFO scheduling instead of weighted vtime scheduling.
+    #[clap(short = 'f', long, action = clap::ArgAction::SetTrue)]
+    fifo_sched: bool,
+
+    /// Idle CPUs with utilization lower than this will get remote tasks
+    /// directly pushed on them. 0 disables, 100 enables always.
+    #[clap(short = 'D', long, default_value = "90.0")]
+    direct_greedy_under: f64,
+
+    /// Idle CPUs with utilization lower than this may get kicked to
+    /// accelerate stealing when a task is queued on a saturated remote
+    /// domain. 0 disables, 100 enables always.
+    #[clap(short = 'K', long, default_value = "100.0")]
+    kick_greedy_under: f64,
+
+    /// If specified, only tasks which have their scheduling policy set to
+    /// SCHED_EXT using sched_setscheduler(2) are switched. Otherwise, all
+    /// tasks are switched.
+    #[clap(short = 'p', long, action = clap::ArgAction::SetTrue)]
+    partial: bool,
+
+    /// Enable verbose output including libbpf details. Specify multiple
+    /// times to increase verbosity.
+    #[clap(short = 'v', long, action = clap::ArgAction::Count)]
+    verbose: u8,
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
+fn format_cpumask(cpumask: &[u64], nr_cpus: usize) -> String {
+    cpumask
+        .iter()
+        .take((nr_cpus + 64) / 64)
+        .rev()
+        .fold(String::new(), |acc, x| format!("{} {:016X}", acc, x))
+}
+
+// Neither procfs or fb_procfs can determine per-CPU utilization reliably
+// with CPU hot[un]plugs. Roll our own.
+//
+// https://github.com/eminence/procfs/issues/274
+// https://github.com/facebookincubator/below/issues/8190
+#[derive(Clone, Debug, Default)]
+struct MyCpuStat {
+    user: u64,
+    nice: u64,
+    system: u64,
+    idle: u64,
+    iowait: u64,
+    irq: u64,
+    softirq: u64,
+    steal: u64,
+}
+
+impl MyCpuStat {
+    fn busy_and_total(&self) -> (u64, u64) {
+        let busy = self.user + self.system + self.nice + self.irq + self.softirq + self.steal;
+        (busy, self.idle + busy + self.iowait)
+    }
+
+    fn calc_util(&self, prev: &MyCpuStat) -> f64 {
+        let (curr_busy, curr_total) = self.busy_and_total();
+        let (prev_busy, prev_total) = prev.busy_and_total();
+        let busy = curr_busy - prev_busy;
+        let total = curr_total - prev_total;
+        if total > 0 {
+            ((busy as f64) / (total as f64)).clamp(0.0, 1.0)
+        } else {
+            1.0
+        }
+    }
+}
+
+#[derive(Clone, Debug, Default)]
+struct MyProcStat {
+    total: MyCpuStat,
+    cpus: BTreeMap<usize, MyCpuStat>,
+}
+
+impl MyProcStat {
+    fn read() -> Result<Self> {
+        let mut result: MyProcStat = Default::default();
+        for line in std::fs::read_to_string("/proc/stat")?.lines() {
+            let mut toks = line.split_whitespace();
+
+            let key = toks.next().ok_or(anyhow!("no key"))?;
+            if !key.starts_with("cpu") {
+                break;
+            }
+
+            let cputime = MyCpuStat {
+                user: toks.next().ok_or(anyhow!("missing"))?.parse::<u64>()?,
+                nice: toks.next().ok_or(anyhow!("missing"))?.parse::<u64>()?,
+                system: toks.next().ok_or(anyhow!("missing"))?.parse::<u64>()?,
+                idle: toks.next().ok_or(anyhow!("missing"))?.parse::<u64>()?,
+                iowait: toks.next().ok_or(anyhow!("missing"))?.parse::<u64>()?,
+                irq: toks.next().ok_or(anyhow!("missing"))?.parse::<u64>()?,
+                softirq: toks.next().ok_or(anyhow!("missing"))?.parse::<u64>()?,
+                steal: toks.next().ok_or(anyhow!("missing"))?.parse::<u64>()?,
+            };
+
+            if key.len() == 3 {
+                result.total = cputime;
+            } else {
+                result.cpus.insert(key[3..].parse::<usize>()?, cputime);
+            }
+        }
+        Ok(result)
+    }
+}
+
+#[derive(Debug)]
+struct Topology {
+    nr_cpus: usize,
+    nr_doms: usize,
+    dom_cpus: Vec<BitVec<u64, Lsb0>>,
+    cpu_dom: Vec<Option<usize>>,
+}
+
+impl Topology {
+    fn from_cpumasks(cpumasks: &[String], nr_cpus: usize) -> Result<Self> {
+        if cpumasks.len() > atropos_sys::MAX_DOMS as usize {
+            bail!(
+                "Number of requested domains ({}) is greater than MAX_DOMS ({})",
+                cpumasks.len(),
+                atropos_sys::MAX_DOMS
+            );
+        }
+        let mut cpu_dom = vec![None; nr_cpus];
+        let mut dom_cpus =
+            vec![bitvec![u64, Lsb0; 0; atropos_sys::MAX_CPUS as usize]; cpumasks.len()];
+        for (dom, cpumask) in cpumasks.iter().enumerate() {
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
+                    if let Some(other_dom) = cpu_dom[cpu] {
+                        bail!(
+                            "Found cpu ({}) with domain ({}) but also in cpumask ({})",
+                            cpu,
+                            other_dom,
+                            cpumask
+                        );
+                    }
+                    cpu_dom[cpu] = Some(dom);
+                    dom_cpus[dom].set(cpu, true);
+                }
+            }
+            dom_cpus[dom].set_uninitialized(false);
+        }
+
+        for (cpu, dom) in cpu_dom.iter().enumerate() {
+            if dom.is_none() {
+                bail!(
+                    "CPU {} not assigned to any domain. Make sure it is covered by some --cpumasks argument.",
+                    cpu
+                );
+            }
+        }
+
+        Ok(Self {
+            nr_cpus,
+            nr_doms: dom_cpus.len(),
+            dom_cpus,
+            cpu_dom,
+        })
+    }
+
+    fn from_cache_level(level: u32, nr_cpus: usize) -> Result<Self> {
+        let mut cpu_to_cache = vec![]; // (cpu_id, Option<cache_id>)
+        let mut cache_ids = BTreeSet::<usize>::new();
+        let mut nr_offline = 0;
+
+        // Build cpu -> cache ID mapping.
+        for cpu in 0..nr_cpus {
+            let path = format!("/sys/devices/system/cpu/cpu{}/cache/index{}/id", cpu, level);
+            let id = match std::fs::read_to_string(&path) {
+                Ok(val) => Some(val.trim().parse::<usize>().with_context(|| {
+                    format!("Failed to parse {:?}'s content {:?}", &path, &val)
+                })?),
+                Err(e) if e.kind() == std::io::ErrorKind::NotFound => {
+                    nr_offline += 1;
+                    None
+                }
+                Err(e) => return Err(e).with_context(|| format!("Failed to open {:?}", &path)),
+            };
+
+            cpu_to_cache.push(id);
+            if id.is_some() {
+                cache_ids.insert(id.unwrap());
+            }
+        }
+
+        info!(
+            "CPUs: online/possible = {}/{}",
+            nr_cpus - nr_offline,
+            nr_cpus
+        );
+
+        // Cache IDs may have holes. Assign consecutive domain IDs to
+        // existing cache IDs.
+        let mut cache_to_dom = BTreeMap::<usize, usize>::new();
+        let mut nr_doms = 0;
+        for cache_id in cache_ids.iter() {
+            cache_to_dom.insert(*cache_id, nr_doms);
+            nr_doms += 1;
+        }
+
+        if nr_doms > atropos_sys::MAX_DOMS as usize {
+            bail!(
+                "Total number of doms {} is greater than MAX_DOMS ({})",
+                nr_doms,
+                atropos_sys::MAX_DOMS
+            );
+        }
+
+        // Build and return dom -> cpumask and cpu -> dom mappings.
+        let mut dom_cpus =
+            vec![bitvec![u64, Lsb0; 0; atropos_sys::MAX_CPUS as usize]; nr_doms as usize];
+        let mut cpu_dom = vec![];
+
+        for cpu in 0..nr_cpus {
+            match cpu_to_cache[cpu] {
+                Some(cache_id) => {
+                    let dom_id = cache_to_dom[&cache_id];
+                    dom_cpus[dom_id].set(cpu, true);
+                    cpu_dom.push(Some(dom_id));
+                }
+                None => {
+                    dom_cpus[0].set(cpu, true);
+                    cpu_dom.push(None);
+                }
+            }
+        }
+
+        Ok(Self {
+            nr_cpus,
+            nr_doms: dom_cpus.len(),
+            dom_cpus,
+            cpu_dom,
+        })
+    }
+}
+
+struct Tuner {
+    top: Arc<Topology>,
+    direct_greedy_under: f64,
+    kick_greedy_under: f64,
+    prev_cpu_stats: BTreeMap<usize, MyCpuStat>,
+    dom_utils: Vec<f64>,
+}
+
+impl Tuner {
+    fn new(top: Arc<Topology>, opts: &Opts) -> Result<Self> {
+        Ok(Self {
+            direct_greedy_under: opts.direct_greedy_under / 100.0,
+            kick_greedy_under: opts.kick_greedy_under / 100.0,
+            prev_cpu_stats: MyProcStat::read()?.cpus,
+            dom_utils: vec![0.0; top.nr_doms],
+            top,
+        })
+    }
+
+    fn step(&mut self, skel: &mut AtroposSkel) -> Result<()> {
+        let curr_cpu_stats = MyProcStat::read()?.cpus;
+        let ti = &mut skel.bss().tune_input;
+        let mut dom_nr_cpus = vec![0; self.top.nr_doms];
+        let mut dom_util_sum = vec![0.0; self.top.nr_doms];
+
+        for cpu in 0..self.top.nr_cpus {
+            // None domain indicates the CPU was offline during
+            // initialization and None MyCpuStat indicates the CPU has gone
+            // down since then. Ignore both.
+            if let (Some(dom), Some(curr), Some(prev)) = (
+                self.top.cpu_dom[cpu],
+                curr_cpu_stats.get(&cpu),
+                self.prev_cpu_stats.get(&cpu),
+            ) {
+                dom_nr_cpus[dom] += 1;
+                dom_util_sum[dom] += curr.calc_util(prev);
+            }
+        }
+
+        for dom in 0..self.top.nr_doms {
+            // Calculate the domain avg util. If there are no active CPUs,
+            // it doesn't really matter. Go with 0.0 as that's less likely
+            // to confuse users.
+            let util = match dom_nr_cpus[dom] {
+                0 => 0.0,
+                nr => dom_util_sum[dom] / nr as f64,
+            };
+
+            self.dom_utils[dom] = util;
+
+            // This could be implemented better.
+            let update_dom_bits = |target: &mut [u64; 8], val: bool| {
+                for cpu in 0..self.top.nr_cpus {
+                    if let Some(cdom) = self.top.cpu_dom[cpu] {
+                        if cdom == dom {
+                            if val {
+                                target[cpu / 64] |= 1u64 << (cpu % 64);
+                            } else {
+                                target[cpu / 64] &= !(1u64 << (cpu % 64));
+                            }
+                        }
+                    }
+                }
+            };
+
+            update_dom_bits(
+                &mut ti.direct_greedy_cpumask,
+                self.direct_greedy_under > 0.99999 || util < self.direct_greedy_under,
+            );
+            update_dom_bits(
+                &mut ti.kick_greedy_cpumask,
+                self.kick_greedy_under > 0.99999 || util < self.kick_greedy_under,
+            );
+        }
+
+        ti.gen += 1;
+        self.prev_cpu_stats = curr_cpu_stats;
+        Ok(())
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
+    is_kworker: bool,
+}
+
+struct LoadBalancer<'a, 'b, 'c> {
+    maps: AtroposMapsMut<'a>,
+    top: Arc<Topology>,
+    task_loads: &'b mut BTreeMap<i32, TaskLoad>,
+    load_decay_factor: f64,
+    skip_kworkers: bool,
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
+    // If imbalance gets higher than this ratio, try to balance the loads.
+    const LOAD_IMBAL_HIGH_RATIO: f64 = 0.10;
+
+    // Aim to transfer this fraction of the imbalance on each round. We want
+    // to be gradual to avoid unnecessary oscillations. While this can delay
+    // convergence, greedy execution should be able to bridge the temporary
+    // gap.
+    const LOAD_IMBAL_XFER_TARGET_RATIO: f64 = 0.50;
+
+    // Don't push out more than this ratio of load on each round. While this
+    // overlaps with XFER_TARGET_RATIO, XFER_TARGET_RATIO only defines the
+    // target and doesn't limit the total load. As long as the transfer
+    // reduces load imbalance between the two involved domains, it'd happily
+    // transfer whatever amount that can be transferred. This limit is used
+    // as the safety cap to avoid draining a given domain too much in a
+    // single round.
+    const LOAD_IMBAL_PUSH_MAX_RATIO: f64 = 0.50;
+
+    fn new(
+        maps: AtroposMapsMut<'a>,
+        top: Arc<Topology>,
+        task_loads: &'b mut BTreeMap<i32, TaskLoad>,
+        load_decay_factor: f64,
+        skip_kworkers: bool,
+        nr_lb_data_errors: &'c mut u64,
+    ) -> Self {
+        Self {
+            maps,
+            task_loads,
+            load_decay_factor,
+            skip_kworkers,
+
+            tasks_by_load: (0..top.nr_doms).map(|_| BTreeMap::<_, _>::new()).collect(),
+            load_avg: 0f64,
+            dom_loads: vec![0.0; top.nr_doms],
+
+            imbal: vec![0.0; top.nr_doms],
+            doms_to_pull: BTreeMap::new(),
+            doms_to_push: BTreeMap::new(),
+
+            nr_lb_data_errors,
+
+            top,
+        }
+    }
+
+    fn read_task_loads(&mut self, period: Duration) -> Result<()> {
+        let now_mono = now_monotonic();
+        let task_data = self.maps.task_data();
+        let mut this_task_loads = BTreeMap::<i32, TaskLoad>::new();
+        let mut load_sum = 0.0f64;
+        self.dom_loads = vec![0f64; self.top.nr_doms];
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
+                        is_kworker: task_ctx.is_kworker,
+                    },
+                );
+            }
+        }
+
+        self.load_avg = load_sum / self.top.nr_doms as f64;
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
+    fn find_first_candidate<'d, I>(
+        tasks_by_load: I,
+        pull_dom: u32,
+        skip_kworkers: bool,
+    ) -> Option<(f64, &'d TaskInfo)>
+    where
+        I: IntoIterator<Item = (&'d OrderedFloat<f64>, &'d TaskInfo)>,
+    {
+        match tasks_by_load
+            .into_iter()
+            .skip_while(|(_, task)| {
+                task.migrated.get()
+                    || (task.dom_mask & (1 << pull_dom) == 0)
+                    || (skip_kworkers && task.is_kworker)
+            })
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
+        let to_xfer = to_pull.min(to_push) * Self::LOAD_IMBAL_XFER_TARGET_RATIO;
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
+        // reduce the load imbalance between the two closest to $to_xfer.
+        // IOW, pick a task which has the closest load value to $to_xfer
+        // that can be migrated. Find such task by locating the first
+        // migratable task while scanning left from $to_xfer and the
+        // counterpart while scanning right and picking the better of the
+        // two.
+        let (load, task, new_imbal) = match (
+            Self::find_first_candidate(
+                self.tasks_by_load[push_dom as usize]
+                    .range((Unbounded, Included(&OrderedFloat(to_xfer))))
+                    .rev(),
+                pull_dom,
+                self.skip_kworkers,
+            ),
+            Self::find_first_candidate(
+                self.tasks_by_load[push_dom as usize]
+                    .range((Included(&OrderedFloat(to_xfer)), Unbounded)),
+                pull_dom,
+                self.skip_kworkers,
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
+        if old_imbal < new_imbal {
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
+    sched_interval: Duration,
+    tune_interval: Duration,
+    load_decay_factor: f64,
+    balance_load: bool,
+    balanced_kworkers: bool,
+
+    top: Arc<Topology>,
+
+    prev_at: Instant,
+    prev_total_cpu: MyCpuStat,
+    task_loads: BTreeMap<i32, TaskLoad>,
+
+    nr_lb_data_errors: u64,
+
+    tuner: Tuner,
+}
+
+impl<'a> Scheduler<'a> {
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
+        let top = Arc::new(if opts.cpumasks.len() > 0 {
+            Topology::from_cpumasks(&opts.cpumasks, nr_cpus)?
+        } else {
+            Topology::from_cache_level(opts.cache_level, nr_cpus)?
+        });
+
+        skel.rodata().nr_doms = top.nr_doms as u32;
+        skel.rodata().nr_cpus = top.nr_cpus as u32;
+
+        for (cpu, dom) in top.cpu_dom.iter().enumerate() {
+            skel.rodata().cpu_dom_id_map[cpu] = dom.unwrap_or(0) as u32;
+        }
+
+        for (dom, cpus) in top.dom_cpus.iter().enumerate() {
+            let raw_cpus_slice = cpus.as_raw_slice();
+            let dom_cpumask_slice = &mut skel.rodata().dom_cpumasks[dom];
+            let (left, _) = dom_cpumask_slice.split_at_mut(raw_cpus_slice.len());
+            left.clone_from_slice(cpus.as_raw_slice());
+            info!(
+                "DOM[{:02}] cpumask{} ({} cpus)",
+                dom,
+                &format_cpumask(dom_cpumask_slice, nr_cpus),
+                cpus.count_ones()
+            );
+        }
+
+        skel.rodata().slice_ns = opts.slice_us * 1000;
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
+        let prev_total_cpu = MyProcStat::read()?.total;
+
+        Ok(Self {
+            skel,
+            struct_ops, // should be held to keep it attached
+
+            sched_interval: Duration::from_secs_f64(opts.interval),
+            tune_interval: Duration::from_secs_f64(opts.tune_interval),
+            load_decay_factor: opts.load_decay_factor.clamp(0.0, 0.99),
+            balance_load: !opts.no_load_balance,
+            balanced_kworkers: opts.balanced_kworkers,
+
+            top: top.clone(),
+
+            prev_at: Instant::now(),
+            prev_total_cpu,
+            task_loads: BTreeMap::new(),
+
+            nr_lb_data_errors: 0,
+
+            tuner: Tuner::new(top, opts)?,
+        })
+    }
+
+    fn get_cpu_busy(&mut self) -> Result<f64> {
+        let total_cpu = MyProcStat::read()?.total;
+        let busy = total_cpu.calc_util(&self.prev_total_cpu);
+        self.prev_total_cpu = total_cpu;
+        Ok(busy)
+    }
+
+    fn read_bpf_stats(&mut self) -> Result<Vec<u64>> {
+        let mut maps = self.skel.maps_mut();
+        let stats_map = maps.stats();
+        let mut stats: Vec<u64> = Vec::new();
+        let zero_vec = vec![vec![0u8; stats_map.value_size() as usize]; self.top.nr_cpus];
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
+        &mut self,
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
+            + stat(atropos_sys::stat_idx_ATROPOS_STAT_GREEDY_IDLE)
+            + stat(atropos_sys::stat_idx_ATROPOS_STAT_PINNED)
+            + stat(atropos_sys::stat_idx_ATROPOS_STAT_DIRECT_DISPATCH)
+            + stat(atropos_sys::stat_idx_ATROPOS_STAT_DIRECT_GREEDY)
+            + stat(atropos_sys::stat_idx_ATROPOS_STAT_DIRECT_GREEDY_FAR)
+            + stat(atropos_sys::stat_idx_ATROPOS_STAT_DSQ_DISPATCH)
+            + stat(atropos_sys::stat_idx_ATROPOS_STAT_GREEDY);
+
+        info!(
+            "cpu={:7.2} bal={} load_avg={:8.2} task_err={} lb_data_err={} proc={:?}ms",
+            cpu_busy * 100.0,
+            stats[atropos_sys::stat_idx_ATROPOS_STAT_LOAD_BALANCE as usize],
+            load_avg,
+            stats[atropos_sys::stat_idx_ATROPOS_STAT_TASK_GET_ERR as usize],
+            self.nr_lb_data_errors,
+            processing_dur.as_millis(),
+        );
+
+        let stat_pct = |idx| stat(idx) as f64 / total as f64 * 100.0;
+
+        info!(
+            "tot={:7} wsync={:5.2} prev_idle={:5.2} greedy_idle={:5.2} pin={:5.2}",
+            total,
+            stat_pct(atropos_sys::stat_idx_ATROPOS_STAT_WAKE_SYNC),
+            stat_pct(atropos_sys::stat_idx_ATROPOS_STAT_PREV_IDLE),
+            stat_pct(atropos_sys::stat_idx_ATROPOS_STAT_GREEDY_IDLE),
+            stat_pct(atropos_sys::stat_idx_ATROPOS_STAT_PINNED),
+        );
+
+        info!(
+            "dir={:5.2} dir_greedy={:5.2} dir_greedy_far={:5.2}",
+            stat_pct(atropos_sys::stat_idx_ATROPOS_STAT_DIRECT_DISPATCH),
+            stat_pct(atropos_sys::stat_idx_ATROPOS_STAT_DIRECT_GREEDY),
+            stat_pct(atropos_sys::stat_idx_ATROPOS_STAT_DIRECT_GREEDY_FAR),
+        );
+
+        info!(
+            "dsq={:5.2} greedy={:5.2} kick_greedy={:5.2} rep={:5.2}",
+            stat_pct(atropos_sys::stat_idx_ATROPOS_STAT_DSQ_DISPATCH),
+            stat_pct(atropos_sys::stat_idx_ATROPOS_STAT_GREEDY),
+            stat_pct(atropos_sys::stat_idx_ATROPOS_STAT_KICK_GREEDY),
+            stat_pct(atropos_sys::stat_idx_ATROPOS_STAT_REPATRIATE),
+        );
+
+        let ti = &self.skel.bss().tune_input;
+        info!(
+            "direct_greedy_cpumask={}",
+            format_cpumask(&ti.direct_greedy_cpumask, self.top.nr_cpus)
+        );
+        info!(
+            "  kick_greedy_cpumask={}",
+            format_cpumask(&ti.kick_greedy_cpumask, self.top.nr_cpus)
+        );
+
+        for i in 0..self.top.nr_doms {
+            info!(
+                "DOM[{:02}] util={:6.2} load={:8.2} imbal={}",
+                i,
+                self.tuner.dom_utils[i] * 100.0,
+                dom_loads[i],
+                if imbal[i] == 0.0 {
+                    format!("{:9.2}", 0.0)
+                } else {
+                    format!("{:+9.2}", imbal[i])
+                },
+            );
+        }
+    }
+
+    fn lb_step(&mut self) -> Result<()> {
+        let started_at = Instant::now();
+        let bpf_stats = self.read_bpf_stats()?;
+        let cpu_busy = self.get_cpu_busy()?;
+
+        let mut lb = LoadBalancer::new(
+            self.skel.maps_mut(),
+            self.top.clone(),
+            &mut self.task_loads,
+            self.load_decay_factor,
+            self.balanced_kworkers,
+            &mut self.nr_lb_data_errors,
+        );
+
+        lb.read_task_loads(started_at.duration_since(self.prev_at))?;
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
+            Instant::now().duration_since(started_at),
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
+
+    fn run(&mut self, shutdown: Arc<AtomicBool>) -> Result<()> {
+        let now = Instant::now();
+        let mut next_tune_at = now + self.tune_interval;
+        let mut next_sched_at = now + self.sched_interval;
+
+        while !shutdown.load(Ordering::Relaxed) && self.read_bpf_exit_type() == 0 {
+            let now = Instant::now();
+
+            if now >= next_tune_at {
+                self.tuner.step(&mut self.skel)?;
+                next_tune_at += self.tune_interval;
+                if next_tune_at < now {
+                    next_tune_at = now + self.tune_interval;
+                }
+            }
+
+            if now >= next_sched_at {
+                self.lb_step()?;
+                next_sched_at += self.sched_interval;
+                if next_sched_at < now {
+                    next_sched_at = now + self.sched_interval;
+                }
+            }
+
+            std::thread::sleep(
+                next_sched_at
+                    .min(next_tune_at)
+                    .duration_since(Instant::now()),
+            );
+        }
+
+        self.report_bpf_exit_type()
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
+    let mut sched = Scheduler::init(&opts)?;
+
+    let shutdown = Arc::new(AtomicBool::new(false));
+    let shutdown_clone = shutdown.clone();
+    ctrlc::set_handler(move || {
+        shutdown_clone.store(true, Ordering::Relaxed);
+    })
+    .context("Error setting Ctrl-C handler")?;
+
+    sched.run(shutdown)
+}
-- 
2.41.0

