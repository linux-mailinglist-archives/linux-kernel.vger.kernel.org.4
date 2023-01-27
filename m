Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC0E67EAD8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbjA0QZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbjA0QYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:24:39 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABBC84183
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:24:32 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id kt9-20020a1709079d0900b00877f4df5aceso3729773ejc.21
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+ZA1LVGRnTSLVUFMxUOcf61woTjOoeoiKjydCG1Ukv0=;
        b=fYvcrw82fbpBOjdM7Tufn3QIumdGltcGOVcJOL3P91Mb+xN6AWlMaU0wegl4Bp5KLz
         oNHmAmw9YROlzBPiV0oWvxpRdsFJcDiqZ7aSNfalpbRwE0u7DdLVObfFpbFnn2ofMWSZ
         dn48cTiy+XGJ1NtCdRitiY7fn40MvVkGGeg+HdRJvaxsy1nKpxfFjKR+73oBXa+uENDb
         ninwsim5zsfTBvw+FSH4bUOiwB32kJknPOY3XrWX6tGbwgDQlPNsCfNi8C5fU4tsQn0A
         lu9VjPCECckHi2eIpzFGrrg+7W32eKTyjhD0TsX0d5tXIrnuh2a9yftLUCIgSPMKhYqV
         mYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ZA1LVGRnTSLVUFMxUOcf61woTjOoeoiKjydCG1Ukv0=;
        b=qKcy2+4BnmPwEelzH5Kd4sZQANmYkfzyuQc0IIf0N4zeQBJw6yq+3f0pcszoUwtIF4
         zRBo4hLTMOuh0j2DgWikE65Ertzu26kLwvWSWfr2GUDh19NFzoDP4NiZe6iO7NXAlvIl
         CDGKNz4IMNPtbHvrggzQtVTBmadvjmKtgxaJHYhUz1PO1WO9Ir+qC687Ehq7B9qLiEvD
         mcjVs7e/FON2rjpK9+fGoqwACyQtGET7BLbRZBTppDIiIojXDk0tMlkDwEiWXzKRN8Ce
         lLxC30j4O4a1xjcqf+zuBTKr2XwzZJcRfQgdGDh9MwTHP/IGQLW5GBB3TiOmxFJ/bqgO
         ZXkA==
X-Gm-Message-State: AO0yUKXgrYYYd2E7ZkUglHfujArT5PjY/Hiz8Fx8BUhcxXiJpA+YWhDt
        hCTNdS+BBw550zHsTKYTLOYbElET+g==
X-Google-Smtp-Source: AK7set8YHy438BZhhkjF7XYU2ntCzTZyFaOVgFf6XEuswyclRtH3xR47q+7qczMrGZHXmH37zPgtdrEU5g==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:19a:e00e:4f5d:59d8])
 (user=elver job=sendgmr) by 2002:a05:6402:b63:b0:4a0:e4bd:6ea4 with SMTP id
 cb3-20020a0564020b6300b004a0e4bd6ea4mr1477810edb.35.1674836671255; Fri, 27
 Jan 2023 08:24:31 -0800 (PST)
Date:   Fri, 27 Jan 2023 17:24:09 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127162409.2505312-1-elver@google.com>
Subject: [PATCH v2] perf: Allow restricted kernel breakpoints on user addresses
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Konovalov <andreyknvl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the creation of restricted breakpoint perf events that also fire
in the kernel (perf_event_attr::exclude_kernel=0), if:

  1. No sample information is requested; samples may contain IPs,
     registers, or other information that may disclose kernel addresses.

  2. The breakpoint (viz. data watchpoint) is on a user address.

The rules constrain the allowable perf events such that no sensitive
kernel information can be disclosed.

Despite no explicit kernel information disclosure, the following
questions may need answers:

 1. Q: Is obtaining information that the kernel accessed a particular
    user's known memory location revealing new information?

    A: Given the kernel's user space ABI, there should be no "surprise
    accesses" to user space memory in the first place.

 2. Q: Does causing breakpoints on user memory accesses by the kernel
    potentially impact timing in a sensitive way?

    A: Since hardware breakpoints trigger regardless of the state of
    perf_event_attr::exclude_kernel, but are filtered in the perf
    subsystem, this possibility already exists independent of the
    proposed change.

Motivation:  Data breakpoints on user addresses that also fire in the
kernel provide complete coverage to track and debug accesses, not just
in user space but also through the kernel. For example, tracking where
user space invokes syscalls with pointers to specific memory.

Breakpoints can be used for more complex dynamic analysis, such as race
detection, memory-safety error detection, or data-flow analysis. Larger
deployment by linking such dynamic analysis into binaries in production
only becomes possible when no additional capabilities are required by
unprivileged users. To improve coverage, it should then also be possible
to enable breakpoints on user addresses that fire in the kernel with no
additional capabilities.

Acked-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---

Changelog
~~~~~~~~~

v2:
* Commit message (motivation, more explanation).
* Apply ack.

v1: https://lkml.kernel.org/r/20220902100057.404817-1-elver@google.com
* Rebase.

RFC: https://lkml.kernel.org/r/20220601093502.364142-1-elver@google.com
---
 include/linux/perf_event.h |  8 +-------
 kernel/events/core.c       | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index c6a3bac76966..a95a6b889b00 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1463,13 +1463,7 @@ static inline int perf_is_paranoid(void)
 	return sysctl_perf_event_paranoid > -1;
 }
 
-static inline int perf_allow_kernel(struct perf_event_attr *attr)
-{
-	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable())
-		return -EACCES;
-
-	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
-}
+extern int perf_allow_kernel(struct perf_event_attr *attr);
 
 static inline int perf_allow_cpu(struct perf_event_attr *attr)
 {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index d56328e5080e..0f1fc9aef294 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3174,6 +3174,12 @@ static int perf_event_modify_attr(struct perf_event *event,
 		return -EOPNOTSUPP;
 	}
 
+	if (!event->attr.exclude_kernel) {
+		err = perf_allow_kernel(attr);
+		if (err)
+			return err;
+	}
+
 	WARN_ON_ONCE(event->ctx->parent_ctx);
 
 	mutex_lock(&event->child_mutex);
@@ -12289,6 +12295,38 @@ perf_check_permission(struct perf_event_attr *attr, struct task_struct *task)
 	return is_capable || ptrace_may_access(task, ptrace_mode);
 }
 
+/*
+ * Check if unprivileged users are allowed to set up breakpoints on user
+ * addresses that also count when the kernel accesses them.
+ */
+static bool perf_allow_kernel_breakpoint(struct perf_event_attr *attr)
+{
+	if (attr->type != PERF_TYPE_BREAKPOINT)
+		return false;
+
+	/*
+	 * The sample may contain IPs, registers, or other information that may
+	 * disclose kernel addresses or timing information. Disallow any kind of
+	 * additional sample information.
+	 */
+	if (attr->sample_type)
+		return false;
+
+	/*
+	 * Only allow kernel breakpoints on user addresses.
+	 */
+	return access_ok((void __user *)(unsigned long)attr->bp_addr, attr->bp_len);
+}
+
+int perf_allow_kernel(struct perf_event_attr *attr)
+{
+	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable() &&
+	    !perf_allow_kernel_breakpoint(attr))
+		return -EACCES;
+
+	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
+}
+
 /**
  * sys_perf_event_open - open a performance event, associate it to a task/cpu
  *
-- 
2.39.1.456.gfc5497dd1b-goog

