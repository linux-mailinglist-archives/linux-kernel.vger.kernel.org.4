Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4536174E330
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjGKBQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjGKBPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:15:42 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04E3E7E;
        Mon, 10 Jul 2023 18:15:09 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b89d47ffb6so25381935ad.2;
        Mon, 10 Jul 2023 18:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038090; x=1691630090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2e74yKiD1GP4JSsaEgtSqPs4JUBepDUVhW+XcttqhGw=;
        b=Pzta31qMNhTRql7Wz7V3nXTZZpmLL57spGS90WpzoNAuasKQtYTqSF2764wJl211wR
         zwWyHF0jrc+6KlcGwmCiZnaGiYsa4CViuQ6WZ2CUtpiUjUBTd/T8qwkLvh+6xYNp2+KS
         j2cE824dlDLeuwprfGB/yN44HJr0p2U4zcacqkuDkni/3YNqfUd0DS4jyO30ViGA4za5
         9zgz62PcKi5vopqRsp0rs/GgtcI+lxsPjQBcpIaWDSe6agFwiQ8PXzhyCd/XVtOfptbZ
         o7el6zxX/gcUWZ/AMUHYCTlfwWWBOJU92q3rYN5jkYxQYj42fsOhxt6rvAHS/s81ZVc9
         3Tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038090; x=1691630090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2e74yKiD1GP4JSsaEgtSqPs4JUBepDUVhW+XcttqhGw=;
        b=Psq0xssmCa2JWePdLSR9nIMdyhZohD4cgkWrWnr8liPVASO9Bf0EpEFqPuOpidSMrW
         LjokkNRIJwta4FPYbJethbdrb4t5mUdYZ9veK5KblIpqyxQuo+DluMAhyq0qu+W8E4uL
         bqjLTJh3o6iL4wAmhHajtT6OnbHqYRjw9Q/8/9V27yD2qfMJbBYL27pO0Dr0cjkjU+8h
         JZYOhR2YTFyVBBCTxaJfAeMShErvWFySpfu15/NgGdWF/VEI3Jh2UeoyVY91Dsy7LzEh
         1BGxxp1tpy9HxvIuYsOuP43ZM4ekqqzRFCCEFbwu/rGzeOaaYnAKezZUAmeONzZO06jg
         ZrkA==
X-Gm-Message-State: ABy/qLaPsZHAq8fKFWQuBrlbHl8cQSmlwBIWWNif+K7zxPkjjtAIAOZX
        Wd5NHUrJmgBwM4uNvV7Y3QE=
X-Google-Smtp-Source: APBJJlFzSm90HaNfAIYvRTDnLan6y1zKhlfRS8mkIX0nN2XArENLKAcSHEe91x46KM8mgri34WY/cQ==
X-Received: by 2002:a17:902:efcd:b0:1b6:72af:623d with SMTP id ja13-20020a170902efcd00b001b672af623dmr10356532plb.55.1689038090386;
        Mon, 10 Jul 2023 18:14:50 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id x18-20020a170902ea9200b001b9cb27e07dsm520475plb.45.2023.07.10.18.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:14:50 -0700 (PDT)
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
Subject: [PATCH 17/34] sched_ext: Allow BPF schedulers to switch all eligible tasks into sched_ext
Date:   Mon, 10 Jul 2023 15:13:35 -1000
Message-ID: <20230711011412.100319-18-tj@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711011412.100319-1-tj@kernel.org>
References: <20230711011412.100319-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, to use sched_ext, each task has to be put into sched_ext using
sched_setscheduler(2). However, some BPF schedulers and use cases might
prefer to service all eligible tasks.

This patch adds a new kfunc helper, scx_bpf_switch_all(), that BPF
schedulers can call from ops.init() to switch all SCHED_NORMAL, SCHED_BATCH
and SCHED_IDLE tasks into sched_ext. This has the benefit that the scheduler
swaps are transparent to the users and applications. As we know that CFS is
not being used when scx_bpf_switch_all() is used, we can also disable hot
path entry points with static_branches.

Both the simple and qmap example schedulers are updated to switch all tasks
by default to ease testing. '-p' option is added which enables the original
behavior of switching only tasks which are explicitly on SCHED_EXT.

v2: In the example schedulers, switch all tasks by default.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Barret Rhoden <brho@google.com>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/core.c              |  8 +++---
 kernel/sched/ext.c               | 43 ++++++++++++++++++++++++++++++++
 kernel/sched/ext.h               |  5 ++++
 tools/sched_ext/scx_common.bpf.h |  1 +
 tools/sched_ext/scx_qmap.bpf.c   |  9 +++++++
 tools/sched_ext/scx_qmap.c       |  8 ++++--
 tools/sched_ext/scx_simple.bpf.c | 10 ++++++++
 tools/sched_ext/scx_simple.c     |  8 ++++--
 8 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c8528cbfeb57..c976a36dd642 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1226,7 +1226,7 @@ bool sched_can_stop_tick(struct rq *rq)
 	 * if there's more than one we need the tick for involuntary
 	 * preemption.
 	 */
-	if (rq->nr_running > 1)
+	if (!scx_switched_all() && rq->nr_running > 1)
 		return false;
 
 	return true;
@@ -5690,8 +5690,10 @@ void scheduler_tick(void)
 	perf_event_task_tick();
 
 #ifdef CONFIG_SMP
-	rq->idle_balance = idle_cpu(cpu);
-	trigger_load_balance(rq);
+	if (!scx_switched_all()) {
+		rq->idle_balance = idle_cpu(cpu);
+		trigger_load_balance(rq);
+	}
 #endif
 }
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d5ef8809e05f..6cb3412cee9f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -73,6 +73,10 @@ static DEFINE_MUTEX(scx_ops_enable_mutex);
 DEFINE_STATIC_KEY_FALSE(__scx_ops_enabled);
 DEFINE_STATIC_PERCPU_RWSEM(scx_fork_rwsem);
 static atomic_t scx_ops_enable_state_var = ATOMIC_INIT(SCX_OPS_DISABLED);
+static bool scx_switch_all_req;
+static bool scx_switching_all;
+DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
+
 static struct sched_ext_ops scx_ops;
 static bool scx_warned_zero_slice;
 
@@ -2056,6 +2060,8 @@ bool task_should_scx(struct task_struct *p)
 {
 	if (!scx_enabled() || scx_ops_disabling())
 		return false;
+	if (READ_ONCE(scx_switching_all))
+		return true;
 	return p->policy == SCHED_EXT;
 }
 
@@ -2183,6 +2189,9 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	 */
 	mutex_lock(&scx_ops_enable_mutex);
 
+	static_branch_disable(&__scx_switched_all);
+	WRITE_ONCE(scx_switching_all, false);
+
 	/* avoid racing against fork */
 	cpus_read_lock();
 	percpu_down_write(&scx_fork_rwsem);
@@ -2366,6 +2375,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 	 */
 	cpus_read_lock();
 
+	scx_switch_all_req = false;
 	if (scx_ops.init) {
 		ret = SCX_CALL_OP_RET(SCX_KF_INIT, init);
 		if (ret) {
@@ -2481,6 +2491,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 	 * transitions here are synchronized against sched_ext_free() through
 	 * scx_tasks_lock.
 	 */
+	WRITE_ONCE(scx_switching_all, scx_switch_all_req);
+
 	scx_task_iter_init(&sti);
 	while ((p = scx_task_iter_next_filtered_locked(&sti))) {
 		if (READ_ONCE(p->__state) != TASK_DEAD) {
@@ -2512,6 +2524,9 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 		goto err_disable;
 	}
 
+	if (scx_switch_all_req)
+		static_branch_enable_cpuslocked(&__scx_switched_all);
+
 	cpus_read_unlock();
 	mutex_unlock(&scx_ops_enable_mutex);
 
@@ -2546,6 +2561,9 @@ static int scx_debug_show(struct seq_file *m, void *v)
 	mutex_lock(&scx_ops_enable_mutex);
 	seq_printf(m, "%-30s: %s\n", "ops", scx_ops.name);
 	seq_printf(m, "%-30s: %ld\n", "enabled", scx_enabled());
+	seq_printf(m, "%-30s: %d\n", "switching_all",
+		   READ_ONCE(scx_switching_all));
+	seq_printf(m, "%-30s: %ld\n", "switched_all", scx_switched_all());
 	seq_printf(m, "%-30s: %s\n", "enable_state",
 		   scx_ops_enable_state_str[scx_ops_enable_state()]);
 	seq_printf(m, "%-30s: %llu\n", "nr_rejected",
@@ -2797,6 +2815,29 @@ __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in vmlinux BTF");
 
+/**
+ * scx_bpf_switch_all - Switch all tasks into SCX
+ *
+ * Switch all existing and future non-dl/rt tasks to SCX. This can only be
+ * called from ops.init(), and actual switching is performed asynchronously.
+ */
+void scx_bpf_switch_all(void)
+{
+	if (!scx_kf_allowed(SCX_KF_INIT))
+		return;
+
+	scx_switch_all_req = true;
+}
+
+BTF_SET8_START(scx_kfunc_ids_init)
+BTF_ID_FLAGS(func, scx_bpf_switch_all)
+BTF_SET8_END(scx_kfunc_ids_init)
+
+static const struct btf_kfunc_id_set scx_kfunc_set_init = {
+	.owner			= THIS_MODULE,
+	.set			= &scx_kfunc_ids_init,
+};
+
 /**
  * scx_bpf_create_dsq - Create a custom DSQ
  * @dsq_id: DSQ to create
@@ -3292,6 +3333,8 @@ static int __init register_ext_kfuncs(void)
 	 * check using scx_kf_allowed().
 	 */
 	if ((ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					     &scx_kfunc_set_init)) ||
+	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					     &scx_kfunc_set_sleepable)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					     &scx_kfunc_set_enqueue_dispatch)) ||
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 444a917d27b1..c32f14bb981c 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -75,7 +75,9 @@ extern unsigned long scx_watchdog_timeout;
 extern unsigned long scx_watchdog_timestamp;
 
 DECLARE_STATIC_KEY_FALSE(__scx_ops_enabled);
+DECLARE_STATIC_KEY_FALSE(__scx_switched_all);
 #define scx_enabled()		static_branch_unlikely(&__scx_ops_enabled)
+#define scx_switched_all()	static_branch_unlikely(&__scx_switched_all)
 
 static inline bool task_on_scx(struct task_struct *p)
 {
@@ -115,6 +117,8 @@ static inline void scx_notify_sched_tick(void)
 static inline const struct sched_class *next_active_class(const struct sched_class *class)
 {
 	class++;
+	if (scx_switched_all() && class == &fair_sched_class)
+		class++;
 	if (!scx_enabled() && class == &ext_sched_class)
 		class++;
 	return class;
@@ -137,6 +141,7 @@ static inline const struct sched_class *next_active_class(const struct sched_cla
 #else	/* CONFIG_SCHED_CLASS_EXT */
 
 #define scx_enabled()		false
+#define scx_switched_all()	false
 
 static inline bool task_on_scx(struct task_struct *p) { return false; }
 static inline void scx_pre_fork(struct task_struct *p) {}
diff --git a/tools/sched_ext/scx_common.bpf.h b/tools/sched_ext/scx_common.bpf.h
index 8b8502afcce3..0e6d7d3e2d27 100644
--- a/tools/sched_ext/scx_common.bpf.h
+++ b/tools/sched_ext/scx_common.bpf.h
@@ -53,6 +53,7 @@ void ___scx_bpf_error_format_checker(const char *fmt, ...) {}
 	___scx_bpf_error_format_checker(fmt, ##args);				\
 })
 
+void scx_bpf_switch_all(void) __ksym;
 s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
 bool scx_bpf_consume(u64 dsq_id) __ksym;
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index d0bc67095062..da43f962ab4e 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -25,6 +25,7 @@
 char _license[] SEC("license") = "GPL";
 
 const volatile u64 slice_ns = SCX_SLICE_DFL;
+const volatile bool switch_partial;
 const volatile u32 stall_user_nth;
 const volatile u32 stall_kernel_nth;
 const volatile s32 disallow_tgid;
@@ -239,6 +240,13 @@ s32 BPF_STRUCT_OPS(qmap_prep_enable, struct task_struct *p,
 		return -ENOMEM;
 }
 
+s32 BPF_STRUCT_OPS(qmap_init)
+{
+	if (!switch_partial)
+		scx_bpf_switch_all();
+	return 0;
+}
+
 void BPF_STRUCT_OPS(qmap_exit, struct scx_exit_info *ei)
 {
 	uei_record(&uei, ei);
@@ -251,6 +259,7 @@ struct sched_ext_ops qmap_ops = {
 	.dequeue		= (void *)qmap_dequeue,
 	.dispatch		= (void *)qmap_dispatch,
 	.prep_enable		= (void *)qmap_prep_enable,
+	.init			= (void *)qmap_init,
 	.exit			= (void *)qmap_exit,
 	.timeout_ms		= 5000U,
 	.name			= "qmap",
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 5f50f889ea18..3444e3597b19 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -20,13 +20,14 @@ const char help_fmt[] =
 "\n"
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
-"Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-d PID]\n"
+"Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-d PID] [-p]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
 "  -t COUNT      Stall every COUNT'th user thread\n"
 "  -T COUNT      Stall every COUNT'th kernel thread\n"
 "  -d PID        Disallow a process from switching into SCHED_EXT (-1 for self)\n"
+"  -p            Switch only tasks on SCHED_EXT policy intead of all\n"
 "  -h            Display this help and exit\n";
 
 static volatile int exit_req;
@@ -50,7 +51,7 @@ int main(int argc, char **argv)
 	skel = scx_qmap__open();
 	assert(skel);
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:d:h")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:d:ph")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -69,6 +70,9 @@ int main(int argc, char **argv)
 			if (skel->rodata->disallow_tgid < 0)
 				skel->rodata->disallow_tgid = getpid();
 			break;
+		case 'p':
+			skel->rodata->switch_partial = true;
+			break;
 		default:
 			fprintf(stderr, help_fmt, basename(argv[0]));
 			return opt != 'h';
diff --git a/tools/sched_ext/scx_simple.bpf.c b/tools/sched_ext/scx_simple.bpf.c
index 9326124a32fa..6302a4ea9ea5 100644
--- a/tools/sched_ext/scx_simple.bpf.c
+++ b/tools/sched_ext/scx_simple.bpf.c
@@ -15,6 +15,8 @@
 
 char _license[] SEC("license") = "GPL";
 
+const volatile bool switch_partial;
+
 struct user_exit_info uei;
 
 struct {
@@ -43,6 +45,13 @@ void BPF_STRUCT_OPS(simple_enqueue, struct task_struct *p, u64 enq_flags)
 	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
 }
 
+s32 BPF_STRUCT_OPS(simple_init)
+{
+	if (!switch_partial)
+		scx_bpf_switch_all();
+	return 0;
+}
+
 void BPF_STRUCT_OPS(simple_exit, struct scx_exit_info *ei)
 {
 	uei_record(&uei, ei);
@@ -51,6 +60,7 @@ void BPF_STRUCT_OPS(simple_exit, struct scx_exit_info *ei)
 SEC(".struct_ops.link")
 struct sched_ext_ops simple_ops = {
 	.enqueue		= (void *)simple_enqueue,
+	.init			= (void *)simple_init,
 	.exit			= (void *)simple_exit,
 	.name			= "simple",
 };
diff --git a/tools/sched_ext/scx_simple.c b/tools/sched_ext/scx_simple.c
index 9ba38ba1e71f..1e507c0a35cd 100644
--- a/tools/sched_ext/scx_simple.c
+++ b/tools/sched_ext/scx_simple.c
@@ -19,8 +19,9 @@ const char help_fmt[] =
 "\n"
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
-"Usage: %s\n"
+"Usage: %s [-p]\n"
 "\n"
+"  -p            Switch only tasks on SCHED_EXT policy intead of all\n"
 "  -h            Display this help and exit\n";
 
 static volatile int exit_req;
@@ -64,8 +65,11 @@ int main(int argc, char **argv)
 	skel = scx_simple__open();
 	assert(skel);
 
-	while ((opt = getopt(argc, argv, "h")) != -1) {
+	while ((opt = getopt(argc, argv, "ph")) != -1) {
 		switch (opt) {
+		case 'p':
+			skel->rodata->switch_partial = true;
+			break;
 		default:
 			fprintf(stderr, help_fmt, basename(argv[0]));
 			return opt != 'h';
-- 
2.41.0

