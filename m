Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FAB610D64
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiJ1Jf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJ1JfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:35:06 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2EA52E58
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:35:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso6137705wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Oeg4H6o/dcPx5AQqGWzAkKIEqb6LjGQnX/XTYoDflfQ=;
        b=HctYI/C7VcSDtt3f/hIEQL/8vpU0BuX0Hwu9pgY55Md1D7JqQ6c+9U39THwyDbF6BH
         T6EUa274nL0DFvpqVPcPS+0JWT6vm/Z6ky+KN7M9+ZoFjbK8/wb31oHPihhIlLM5dgHE
         dq+hFK7F2pLw5hnKH5vKGh9GlEc2KONNX6iPbzjnXyKuAA8+JnAS6Bw0idMMnswjxL38
         Ouw5JhFh9Nh6TQBRW5pOBdSgAhOCj1RdJ4w+HkvBQvD/mp+iBfQj1vXDCETu6/UNdfsB
         obg2Zh7vwDrbqNjjjYenQwZhkpkxUONDoeWf/xPWqpqlGPCqOFjWY+V752dNYIFJHAro
         T98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oeg4H6o/dcPx5AQqGWzAkKIEqb6LjGQnX/XTYoDflfQ=;
        b=EZwSdmwaQ2+pOja3YfzTtw6vfMfNTk/PZRldhIk03DyqK7KqLENHiY8eY/oOgG1cek
         lOEazsLcPRw4H0VYJThHtaVBLspyMSf0TR844u2ij6sSJ/A3kL5/HIANgjrJLkhB+jyc
         NHd117p0DTNgQhXf29OX+erWH46+CLKyusr1ydfeUZmm/4V4IcxuthJnYZALN53HRXdv
         kRJSvpaYXxEuBiDKp33H9j4YCpE8cyDU+0Fzi7s7gU0UgpDz9XsX/dCOpWUU66Zk6hLN
         N1VtkSX7VSkRy4oxAU3y3rJQLgTjm9D1jtVOLnt2l0nCEAUTEOo1jaG5DJXxlLcqBnRs
         /F5Q==
X-Gm-Message-State: ACrzQf2syE9nuOGtdWkxR4RKHulHk5M0WZMnqgCE4wquPaBmjNtZbsyh
        yRaFExEGpBx00N+AypSWHf0yFw==
X-Google-Smtp-Source: AMsMyM45PTAucK12EKuGrQvxLrfjpzn8/VrOlBGQIqApr8MXGU9nq+pBKaowDZQbEO1m3YjWLBxV7g==
X-Received: by 2002:a05:6000:2a7:b0:22f:bb40:83f8 with SMTP id l7-20020a05600002a700b0022fbb4083f8mr34795320wry.288.1666949702527;
        Fri, 28 Oct 2022 02:35:02 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:c12b:b448:f0a9:83ef])
        by smtp.gmail.com with ESMTPSA id k3-20020a05600c1c8300b003c6b7f5567csm10909426wms.0.2022.10.28.02.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 02:35:01 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v7 4/9] sched: Allow sched_{get,set}attr to change latency_nice of the task
Date:   Fri, 28 Oct 2022 11:33:58 +0200
Message-Id: <20221028093403.6673-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221028093403.6673-1-vincent.guittot@linaro.org>
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Parth Shah <parth@linux.ibm.com>

Introduce the latency_nice attribute to sched_attr and provide a
mechanism to change the value with the use of sched_setattr/sched_getattr
syscall.

Also add new flag "SCHED_FLAG_LATENCY_NICE" to hint the change in
latency_nice of the task on every sched_setattr syscall.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
[rebase and add a dedicated __setscheduler_latency ]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/uapi/linux/sched.h       |  4 +++-
 include/uapi/linux/sched/types.h | 19 +++++++++++++++++++
 kernel/sched/core.c              | 24 ++++++++++++++++++++++++
 tools/include/uapi/linux/sched.h |  4 +++-
 4 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 3bac0a8ceab2..b2e932c25be6 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -132,6 +132,7 @@ struct clone_args {
 #define SCHED_FLAG_KEEP_PARAMS		0x10
 #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
 #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+#define SCHED_FLAG_LATENCY_NICE		0x80
 
 #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
 				 SCHED_FLAG_KEEP_PARAMS)
@@ -143,6 +144,7 @@ struct clone_args {
 			 SCHED_FLAG_RECLAIM		| \
 			 SCHED_FLAG_DL_OVERRUN		| \
 			 SCHED_FLAG_KEEP_ALL		| \
-			 SCHED_FLAG_UTIL_CLAMP)
+			 SCHED_FLAG_UTIL_CLAMP		| \
+			 SCHED_FLAG_LATENCY_NICE)
 
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
index f2c4589d4dbf..db1e8199e8c8 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -10,6 +10,7 @@ struct sched_param {
 
 #define SCHED_ATTR_SIZE_VER0	48	/* sizeof first published struct */
 #define SCHED_ATTR_SIZE_VER1	56	/* add: util_{min,max} */
+#define SCHED_ATTR_SIZE_VER2	60	/* add: latency_nice */
 
 /*
  * Extended scheduling parameters data structure.
@@ -98,6 +99,22 @@ struct sched_param {
  * scheduled on a CPU with no more capacity than the specified value.
  *
  * A task utilization boundary can be reset by setting the attribute to -1.
+ *
+ * Latency Tolerance Attributes
+ * ===========================
+ *
+ * A subset of sched_attr attributes allows to specify the relative latency
+ * requirements of a task with respect to the other tasks running/queued in the
+ * system.
+ *
+ * @ sched_latency_nice	task's latency_nice value
+ *
+ * The latency_nice of a task can have any value in a range of
+ * [MIN_LATENCY_NICE..MAX_LATENCY_NICE].
+ *
+ * A task with latency_nice with the value of LATENCY_NICE_MIN can be
+ * taken for a task requiring a lower latency as opposed to the task with
+ * higher latency_nice.
  */
 struct sched_attr {
 	__u32 size;
@@ -120,6 +137,8 @@ struct sched_attr {
 	__u32 sched_util_min;
 	__u32 sched_util_max;
 
+	/* latency requirement hints */
+	__s32 sched_latency_nice;
 };
 
 #endif /* _UAPI_LINUX_SCHED_TYPES_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 54544353025b..b2accc9da4fe 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7318,6 +7318,14 @@ static void __setscheduler_params(struct task_struct *p,
 	p->rt_priority = attr->sched_priority;
 	p->normal_prio = normal_prio(p);
 	set_load_weight(p, true);
+
+}
+
+static void __setscheduler_latency(struct task_struct *p,
+		const struct sched_attr *attr)
+{
+	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE)
+		p->latency_nice = attr->sched_latency_nice;
 }
 
 /*
@@ -7460,6 +7468,13 @@ static int __sched_setscheduler(struct task_struct *p,
 			return retval;
 	}
 
+	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE) {
+		if (attr->sched_latency_nice > MAX_LATENCY_NICE)
+			return -EINVAL;
+		if (attr->sched_latency_nice < MIN_LATENCY_NICE)
+			return -EINVAL;
+	}
+
 	if (pi)
 		cpuset_read_lock();
 
@@ -7494,6 +7509,9 @@ static int __sched_setscheduler(struct task_struct *p,
 			goto change;
 		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
 			goto change;
+		if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE &&
+		    attr->sched_latency_nice != p->latency_nice)
+			goto change;
 
 		p->sched_reset_on_fork = reset_on_fork;
 		retval = 0;
@@ -7582,6 +7600,7 @@ static int __sched_setscheduler(struct task_struct *p,
 		__setscheduler_params(p, attr);
 		__setscheduler_prio(p, newprio);
 	}
+	__setscheduler_latency(p, attr);
 	__setscheduler_uclamp(p, attr);
 
 	if (queued) {
@@ -7792,6 +7811,9 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
 	    size < SCHED_ATTR_SIZE_VER1)
 		return -EINVAL;
 
+	if ((attr->sched_flags & SCHED_FLAG_LATENCY_NICE) &&
+	    size < SCHED_ATTR_SIZE_VER2)
+		return -EINVAL;
 	/*
 	 * XXX: Do we want to be lenient like existing syscalls; or do we want
 	 * to be strict and return an error on out-of-bounds values?
@@ -8029,6 +8051,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	get_params(p, &kattr);
 	kattr.sched_flags &= SCHED_FLAG_ALL;
 
+	kattr.sched_latency_nice = p->latency_nice;
+
 #ifdef CONFIG_UCLAMP_TASK
 	/*
 	 * This could race with another potential updater, but this is fine
diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index 3bac0a8ceab2..b2e932c25be6 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -132,6 +132,7 @@ struct clone_args {
 #define SCHED_FLAG_KEEP_PARAMS		0x10
 #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
 #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+#define SCHED_FLAG_LATENCY_NICE		0x80
 
 #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
 				 SCHED_FLAG_KEEP_PARAMS)
@@ -143,6 +144,7 @@ struct clone_args {
 			 SCHED_FLAG_RECLAIM		| \
 			 SCHED_FLAG_DL_OVERRUN		| \
 			 SCHED_FLAG_KEEP_ALL		| \
-			 SCHED_FLAG_UTIL_CLAMP)
+			 SCHED_FLAG_UTIL_CLAMP		| \
+			 SCHED_FLAG_LATENCY_NICE)
 
 #endif /* _UAPI_LINUX_SCHED_H */
-- 
2.17.1

