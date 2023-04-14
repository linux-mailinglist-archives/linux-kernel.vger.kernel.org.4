Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32046E1E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDNIXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjDNIXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:23:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E408E30FD;
        Fri, 14 Apr 2023 01:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681460603; x=1712996603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lKhCyQDrP3SWVP+Mn5U2yqr9K7pd2gf6DvLZAJNWAYw=;
  b=C3us+nhnfk6/hNhlG/JKbd6WhQY7SlftA2qG84jea3PzKO6PBZOro3t7
   CTpxnRp0Myxx28XiTcFjz8AeHDjB1Iit49Ar4GNCBHzjxeADod5FNVWK/
   JrSV3q754ooJ03E5CuqxCUnwZZwauXiw9uOXgZt4MQeW2a4v5WhlnpUP7
   d759Twsp25xR73lwo8kBGU5DNXNbEdwwPSXULeA/sIE2C8Exxev+zPTxA
   dUA4JAcDqBxOaM+U/4S/WErqZ+XZSmlUGgnLcTl811De0HR6e9sprLE97
   6tR4YleFLbvHkZ1xw8914v9Mp8GLqXD0AafSD4Nec2qW7RUa0GlKCeDkN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="430708091"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="430708091"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 01:23:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="683267456"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="683267456"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.34.252])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 01:23:20 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/5] perf: Add ioctl to emit sideband events
Date:   Fri, 14 Apr 2023 11:22:56 +0300
Message-Id: <20230414082300.34798-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414082300.34798-1-adrian.hunter@intel.com>
References: <20230414082300.34798-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf tools currently read /proc to get this information, but that
races with changes made by the kernel.

Add an ioctl to output status-only sideband events for a currently
active event on the current CPU. Using timestamps, these status-only
sideband events will be correctly ordered with respect to "real"
sideband events.

The assumption is a user will:
	- open and enable a dummy event to track sideband events
	- call the new ioctl to get sideband information for currently
	  running processes as needed
	- enable the remaining selected events

The initial sideband events to be supported will be: fork, namespaces, comm
and mmap.

Add a new misc flag PERF_RECORD_MISC_STATUS_ONLY to differentiate "real"
sideband events from status-only sideband events.

The limitation that the event must be active is significant. The ioctl
caller must either:
	i)  For a CPU context, set CPU affinity to the correct CPU.
	    Note, obviously that would not need to be done for system-wide
	    tracing on all CPUs. It would also only need to be done for the
	    period of tracing when the ioctl is to be used.
	ii) Use an event opened for the current process on all CPUs.
	    Note, if such an additional event is needed, it would also use
	    additional memory from the user's perf_event_mlock_kb /
	    RLIMIT_MEMLOCK limit.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 include/uapi/linux/perf_event.h | 19 ++++++-
 kernel/events/core.c            | 87 ++++++++++++++++++++++++++++++++-
 2 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 37675437b768..d44fb0f65484 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -541,6 +541,18 @@ struct perf_event_query_bpf {
 	__u32	ids[];
 };
 
+enum perf_event_emit_flag {
+	PERF_EVENT_EMIT_FORK		= 1U << 0,
+	PERF_EVENT_EMIT_NAMESPACES	= 1U << 1,
+	PERF_EVENT_EMIT_COMM		= 1U << 2,
+	PERF_EVENT_EMIT_MMAP		= 1U << 3,
+};
+
+struct perf_event_pid_sb {
+	__u32	pid;
+	__u32	emit_flags; /* Refer perf_event_emit_flag */
+};
+
 /*
  * Ioctls that can be done on a perf event fd:
  */
@@ -556,6 +568,7 @@ struct perf_event_query_bpf {
 #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
 #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
 #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
+#define PERF_EVENT_IOC_EMIT_SIDEBAND		_IOW('$', 12, struct perf_event_pid_sb *)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
@@ -743,12 +756,13 @@ struct perf_event_mmap_page {
  * The current state of perf_event_header::misc bits usage:
  * ('|' used bit, '-' unused bit)
  *
- *  012         CDEF
- *  |||---------||||
+ *  012        BCDEF
+ *  |||--------|||||
  *
  *  Where:
  *    0-2     CPUMODE_MASK
  *
+ *    B       STATUS_ONLY
  *    C       PROC_MAP_PARSE_TIMEOUT
  *    D       MMAP_DATA / COMM_EXEC / FORK_EXEC / SWITCH_OUT
  *    E       MMAP_BUILD_ID / EXACT_IP / SCHED_OUT_PREEMPT
@@ -763,6 +777,7 @@ struct perf_event_mmap_page {
 #define PERF_RECORD_MISC_GUEST_KERNEL		(4 << 0)
 #define PERF_RECORD_MISC_GUEST_USER		(5 << 0)
 
+#define PERF_RECORD_MISC_STATUS_ONLY		(1 << 11)
 /*
  * Indicates that /proc/PID/maps parsing are truncated by time out.
  */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index fb3e436bcd4a..5cbcc6851587 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5797,6 +5797,7 @@ static int perf_event_set_output(struct perf_event *event,
 static int perf_event_set_filter(struct perf_event *event, void __user *arg);
 static int perf_copy_attr(struct perf_event_attr __user *uattr,
 			  struct perf_event_attr *attr);
+static int perf_event_emit_sideband(struct perf_event *event, void __user *arg);
 
 static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned long arg)
 {
@@ -5924,6 +5925,9 @@ static long perf_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	if (ret)
 		return ret;
 
+	if (cmd == PERF_EVENT_IOC_EMIT_SIDEBAND)
+		return perf_event_emit_sideband(event, (void __user *)arg);
+
 	ctx = perf_event_ctx_lock(event);
 	ret = _perf_ioctl(event, cmd, arg);
 	perf_event_ctx_unlock(event, ctx);
@@ -5940,6 +5944,7 @@ static long perf_compat_ioctl(struct file *file, unsigned int cmd,
 	case _IOC_NR(PERF_EVENT_IOC_ID):
 	case _IOC_NR(PERF_EVENT_IOC_QUERY_BPF):
 	case _IOC_NR(PERF_EVENT_IOC_MODIFY_ATTRIBUTES):
+	case _IOC_NR(PERF_EVENT_IOC_EMIT_SIDEBAND):
 		/* Fix up pointer size (usually 4 -> 8 in 32-on-64-bit case */
 		if (_IOC_SIZE(cmd) == sizeof(compat_uptr_t)) {
 			cmd &= ~IOCSIZE_MASK;
@@ -12277,7 +12282,7 @@ perf_check_permission(struct perf_event_attr *attr, struct task_struct *task)
 	unsigned int ptrace_mode = PTRACE_MODE_READ_REALCREDS;
 	bool is_capable = perfmon_capable();
 
-	if (attr->sigtrap) {
+	if (attr && attr->sigtrap) {
 		/*
 		 * perf_event_attr::sigtrap sends signals to the other task.
 		 * Require the current task to also have CAP_KILL.
@@ -12810,6 +12815,86 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 }
 EXPORT_SYMBOL_GPL(perf_event_create_kernel_counter);
 
+static int perf_event_emit_fork(struct perf_event *event, struct task_struct *task)
+{
+	return -EINVAL;
+}
+
+static int perf_event_emit_namespaces(struct perf_event *event, struct task_struct *task)
+{
+	return -EINVAL;
+}
+
+static int perf_event_emit_comm(struct perf_event *event, struct task_struct *task)
+{
+	return -EINVAL;
+}
+
+static int perf_event_emit_mmap(struct perf_event *event, struct task_struct *task)
+{
+	return -EINVAL;
+}
+
+static int perf_event_emit_sideband(struct perf_event *event, void __user *arg)
+{
+	struct perf_event_pid_sb pid_sb;
+	struct perf_event_context *ctx;
+	struct task_struct *task;
+	int err;
+
+	if (copy_from_user(&pid_sb, arg, sizeof(pid_sb)))
+		return -EFAULT;
+
+	if (pid_sb.emit_flags & ~(PERF_EVENT_EMIT_FORK |
+				  PERF_EVENT_EMIT_NAMESPACES |
+				  PERF_EVENT_EMIT_COMM |
+				  PERF_EVENT_EMIT_MMAP))
+		return -EINVAL;
+
+	task = find_lively_task_by_vpid(pid_sb.pid);
+	if (IS_ERR(task))
+		return PTR_ERR(task);
+
+	err = down_read_interruptible(&task->signal->exec_update_lock);
+	if (err)
+		goto out_put_task;
+
+	/* Validate access to pid (same as perf_event_open) */
+	err = -EACCES;
+	if (!perf_check_permission(NULL, task))
+		goto out_cred;
+
+	ctx = perf_event_ctx_lock(event);
+
+	if (pid_sb.emit_flags & PERF_EVENT_EMIT_FORK) {
+		err = perf_event_emit_fork(event, task);
+		if (err)
+			goto out_ctx;
+	}
+	if (pid_sb.emit_flags & PERF_EVENT_EMIT_NAMESPACES) {
+		err = perf_event_emit_namespaces(event, task);
+		if (err)
+			goto out_ctx;
+	}
+	if (pid_sb.emit_flags & PERF_EVENT_EMIT_COMM) {
+		err = perf_event_emit_comm(event, task);
+		if (err)
+			goto out_ctx;
+	}
+	if (pid_sb.emit_flags & PERF_EVENT_EMIT_MMAP) {
+		err = perf_event_emit_mmap(event, task);
+		if (err)
+			goto out_ctx;
+	}
+out_ctx:
+	perf_event_ctx_unlock(event, ctx);
+out_cred:
+	up_read(&task->signal->exec_update_lock);
+out_put_task:
+	put_task_struct(task);
+	return err;
+}
+
 static void __perf_pmu_remove(struct perf_event_context *ctx,
 			      int cpu, struct pmu *pmu,
 			      struct perf_event_groups *groups,
-- 
2.34.1

