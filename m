Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B300D61DFA3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 00:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiKEXYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 19:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKEXYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 19:24:06 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB3F1056C
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 16:24:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k8so11553545wrh.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 16:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7iv8I6eP4SLMzvMeYp3mAqg/SVOw9qU757WKwm27nSg=;
        b=1QLwUcPAdz79LiiHTnkRyRQV+oc/KbR5/O4ZzliGbo7Tm/WCXtcC4Er3IbMj9r38Le
         L8zq2U8mwRVaEvLSjAZ0X2X5aBbxwLR6ZtS1gPxqfHRomjrQy+Sl/zyBmadzaNrENiNy
         PBM5XmhSmAxl9aGlxckQn1Cp111mIVZWjunatKZM5LlWeHKw6fSJBkPUNu7EKxtt8T1S
         YGskxD1UvhTvVGBFiKUhSGsd51LT3/q5WaDEUMoLaJHhyYkaUnR/O50bj3MhELhRk1mm
         O4MgQw11MNFk66JxU0dsdFpfH6yO5KilASj32wGg8oGgo+ipXBd38HoNw7ZjnO6ERFbN
         FA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7iv8I6eP4SLMzvMeYp3mAqg/SVOw9qU757WKwm27nSg=;
        b=Po4W2AkRqZUkizi0Mj/CSVzUH5JzgS1Z6fCjT9PIJJdSGiXAR92QEpozOZIMuYBXka
         ffMKSldHwvCdJCKKG4kg71xu0xAudbG1hjv3jOUHwdafLQ2iA2FKmk0ssJm2JIUC3fPv
         hSUM6/GYmclN4tT3IZfhTnrF9HDc2fajNaYitoH9Nyxfv7vdFUu1exmK0toUm+OIZX4g
         JMBhawXLDC0ej2bLkOON4JCVHkaO+dli6ApHPV558SJ5dQpyRK52yO3g9BPnD6y4V5G4
         vxHOqNb+i2UJu4g/h0e3UFjujLjpnkzXhsBd3Im8Wr9VBi6YDYKVXeZr04NhFnS4E/0j
         Ug6w==
X-Gm-Message-State: ACrzQf3vlWGc2QwbmoYTY75/fY59jj7Qdu1/MMAhzsh/DLwc5x8UWUOJ
        1q7BMRaiiPlZhw8s+Z/hOlwHXg==
X-Google-Smtp-Source: AMsMyM658srXyXC2DQlUQvU1AhNgct9f6M2AV3RtMk1Ocw3dVzkd0izYTacPlejIksmJvkk1V1Y9cQ==
X-Received: by 2002:a5d:414c:0:b0:236:b8ba:ebdf with SMTP id c12-20020a5d414c000000b00236b8baebdfmr24600687wrq.415.1667690641388;
        Sat, 05 Nov 2022 16:24:01 -0700 (PDT)
Received: from localhost.localdomain (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id m3-20020a05600c3b0300b003cf47556f21sm7420496wms.2.2022.11.05.16.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 16:24:01 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Paul Bone <pbone@mozilla.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH] Documentation: sched: Add a new sched-util-clamp.rst
Date:   Sat,  5 Nov 2022 23:23:43 +0000
Message-Id: <20221105232343.887199-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qais Yousef <qais.yousef@arm.com>

The new util clamp feature needs a document explaining what it is and
how to use it. The new document hopefully covers everything one needs to
know about uclamp.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---

Hopefully a not bad first attempt at explaining everything uclamp; what it is
and how to use it.

I have repeated some ideas to help re-enforce them to the readers who're new to
the concept.


 Documentation/scheduler/sched-util-clamp.rst | 678 +++++++++++++++++++
 1 file changed, 678 insertions(+)
 create mode 100644 Documentation/scheduler/sched-util-clamp.rst

diff --git a/Documentation/scheduler/sched-util-clamp.rst b/Documentation/scheduler/sched-util-clamp.rst
new file mode 100644
index 000000000000..e75b69767afb
--- /dev/null
+++ b/Documentation/scheduler/sched-util-clamp.rst
@@ -0,0 +1,678 @@
+====================
+Utilization Clamping
+====================
+
+1.  INTRODUCTION
+================
+
+Utilization clamping is a scheduler feature that allows user space to help in
+managing the performance requirement of tasks. It was introduced in v5.3
+release. The CGroup support was merged in v5.4.
+
+It is often referred to as util clamp and uclamp. You'll find all variations
+used interchangeably in this documentation and in the source code.
+
+Uclamp is a hinting mechanism that allows the scheduler to understand the
+performance requirements and restrictions of the tasks. Hence help it make
+a better placement decision. And when schedutil cpufreq governor is used, util
+clamp will influence the frequency selection as well.
+
+Since scheduler and schedutil are both driven by PELT (util_avg) signals, util
+clamp acts on that to achieve its goal by clamping the signal to a certain
+point; hence the name. I.e: by clamping utilization we are making the system
+run at a certain performance point.
+
+The right way to view util clamp is as a mechanism to make performance
+constraints request/hint. It consists of two components:
+
+        * UCLAMP_MIN, which sets a lower bound.
+        * UCLAMP_MAX, which sets an upper bound.
+
+These two bounds will ensure a task will operate within this performance range
+of the system. UCLAMP_MIN implies boosting a task, while UCLAMP_MAX implies
+capping a task.
+
+One can tell the system (scheduler) that some tasks require a minimum
+performance point to operate at to deliver the desired user experience. Or one
+can tell the system that some tasks should be restricted from consuming too
+much resources and should NOT go above a specific performance point. Viewing
+the uclamp values as performance points rather than utilization is a better
+abstraction from user space point of view.
+
+As an example, a game can use util clamp to form a feedback loop with its
+perceived FPS. It can dynamically increase the minimum performance point
+required by its display pipeline to ensure no frame is dropped. It can also
+dynamically 'prime' up these tasks if it knows in the coming few 100ms
+a computationally intensive scene is about to happen.
+
+On mobile hardware where the capability of the devices varies a lot, this
+dynamic feedback loop offers a great flexibility in ensuring best user
+experience given the capabilities of any system.
+
+Of course a static configuration is possible too. The exact usage will depend
+on the system, application and the desired outcome.
+
+Another example is in Android where tasks are classified as background,
+foreground, top-app, etc. Util clamp can be used to constraint how much
+resources background tasks are consuming by capping the performance point they
+can run at. This constraint helps reserve resources for important tasks, like
+the ones belonging to the currently active app (top-app group). Beside this
+helps in limiting how much power they consume. This can be more obvious in
+heterogeneous systems; the constraint will help bias the background tasks to
+stay on the little cores which will ensure that:
+
+        1. The big cores are free to run top-app tasks immediately. top-app
+           tasks are the tasks the user is currently interacting with, hence
+           the most important tasks in the system.
+        2. They don't run on a power hungry core and drain battery even if they
+           are CPU intensive tasks.
+
+By making these uclamp performance requests, or rather hints, user space can
+ensure system resources are used optimally to deliver the best user experience
+the system is capable of.
+
+Another use case is to help with overcoming the ramp up latency inherit in how
+scheduler utilization signal is calculated.
+
+A busy task for instance that requires to run at maximum performance point will
+suffer a delay of ~200ms (PELT HALFIFE = 32ms) for the scheduler to realize
+that. This is known to affect workloads like gaming on mobile devices where
+frames will drop due to slow response time to select the higher frequency
+required for the tasks to finish their work in time.
+
+The overall visible effect goes beyond better perceived user
+experience/performance and stretches to help achieve a better overall
+performance/watt if used effectively.
+
+User space can form a feedback loop with thermal subsystem too to ensure the
+device doesn't heat up to the point where it will throttle.
+
+Both SCHED_NORMAL/OTHER and SCHED_FIFO/RR honour uclamp requests/hints.
+
+In SCHED_FIFO/RR case, uclamp gives the option to run RT tasks at any
+performance point rather than being tied to MAX frequency all the time. Which
+can be useful on general purpose systems that run on battery powered devices.
+
+Note that by design RT tasks don't have per-task PELT signal and must always
+run at a constant frequency to combat undeterministic DVFS rampup delays.
+
+Note that using schedutil always implies a single delay to modify the frequency
+when an RT task wakes up. This cost is unchanged by using uclamp. Uclamp only
+helps picking what frequency to request instead of schedutil always requesting
+MAX for all RT tasks.
+
+See section 3.4 for default values and 3.4.1 on how to change RT tasks default
+value.
+
+2.  DESIGN:
+===========
+
+Util clamp is a property of every task in the system. It sets the boundaries of
+its utilization signal; acting as a bias mechanism that influences certain
+decisions within the scheduler.
+
+The actual utilization signal of a task is never clamped in reality. If you
+inspect PELT signals at any point of time you should continue to see them as
+they are intact. Clamping happens only when needed, e.g: when a task wakes up
+and the scheduler needs to select a suitable CPU for it to run on.
+
+Since the goal of util clamp is to allow requesting a minimum and maximum
+performance point for a task to run on, it must be able to influence the
+frequency selection as well as task placement to be most effective. Both of
+which have implications on the utilization value at rq level, which brings us
+to the main design challenge.
+
+When a task wakes up on an rq, the utilization signal of the rq will be
+impacted by the uclamp settings of all the tasks enqueued on it. For example if
+a task requests to run at UTIL_MIN = 512, then the util signal of the rq needs
+to respect this request as well as all other requests from all of the enqueued
+tasks.
+
+To be able to aggregate the util clamp value of all the tasks attached to the
+rq, uclamp must do some housekeeping at every enqueue/dequeue, which is the
+scheduler hot path. Hence care must be taken since any slow down will have
+significant impact on a lot of use cases and could hinder its usability in
+practice.
+
+The way this is handled is by dividing the utilization range into buckets
+(struct uclamp_bucket) which allows us to reduce the search space from every
+task on the rq to only a subset of tasks on the top-most bucket.
+
+When a task is enqueued, we increment a counter in the matching bucket. And on
+dequeue we decrement it. This makes keeping track of the effective uclamp value
+at rq level a lot easier.
+
+As we enqueue and dequeue tasks we keep track of the current effective uclamp
+value of the rq. See section 2.1 for details on how this works.
+
+Later at any path that wants to identify the effective uclamp value of the rq,
+it will simply need to read this effective uclamp value of the rq at that exact
+moment of time it needs to take a decision.
+
+For task placement case, only Energy Aware and Capacity Aware Scheduling
+(EAS/CAS) make use of uclamp for now. This implies heterogeneous systems only.
+When a task wakes up, the scheduler will look at the current effective uclamp
+value of every rq and compare it with the potential new value if the task were
+to be enqueued there. Favoring the rq that will end up with the most energy
+efficient combination.
+
+Similarly in schedutil, when it needs to make a frequency update it will look
+at the current effective uclamp value of the rq which is influenced by the set
+of tasks currently enqueued there and select the appropriate frequency that
+will honour uclamp requests.
+
+Other paths like setting overutilization state (which effectively disables EAS)
+make use of uclamp as well. Such cases are considered necessary housekeeping to
+allow the 2 main use cases above and will not be covered in detail here as they
+could change with implementation details.
+
+2.1  BUCKETS:
+-------------
+
+                           [struct rq]
+
+(bottom)                                                    (top)
+
+  0                                                          1024
+  |                                                           |
+  +-----------+-----------+-----------+----   ----+-----------+
+  |  Bucket 0 |  Bucket 1 |  Bucket 2 |    ...    |  Bucket N |
+  +-----------+-----------+-----------+----   ----+-----------+
+     :           :                                   :
+     +- p0       +- p3                               +- p4
+     :                                               :
+     +- p1                                           +- p5
+     :
+     +- p2
+
+
+DISCLAMER:
+   The diagram above is an illustration rather than a true depiction of the
+   internal data structure.
+
+To reduce the search space when trying to decide the effective uclamp value of
+an rq as tasks are enqueued/dequeued, the whole utilization range is divided
+into N buckets where N is configured at compile time by setting
+CONFIG_UCLAMP_BUCKETS_COUNT. By default it is set to 5.
+
+The rq has a bucket for each uclamp_id: [UCLAMP_MIN, UCLAMP_MAX].
+
+The range of each bucket is 1024/N. For example for the default value of 5 we
+will have 5 buckets, each of which will cover the following range:
+
+        DELTA = round_closest(1024/5) = 204.8 = 205
+
+        Bucket 0: [0:204]
+        Bucket 1: [205:409]
+        Bucket 2: [410:614]
+        Bucket 3: [615:819]
+        Bucket 4: [820:1024]
+
+When a task p
+
+        p->uclamp[UCLAMP_MIN] = 300
+        p->uclamp[UCLAMP_MAX] = 1024
+
+is enqueued into the rq, Bucket 1 will be incremented for UCLAMP_MIN and Bucket
+4 will be incremented for UCLAMP_MAX to reflect the fact the rq has a task in
+this range.
+
+The rq then keeps track of its current effective uclamp value for each
+uclamp_id.
+
+When a task p is enqueued, the rq value changes as follows:
+
+        // update bucket logic goes here
+        rq->uclamp[UCLAMP_MIN] = max(rq->uclamp[UCLAMP_MIN], p->uclamp[UCLAMP_MIN])
+        // repeat for UCLAMP_MAX
+
+When a task is p dequeued the rq value changes as follows:
+
+        // update bucket logic goes here
+        rq->uclamp[UCLAMP_MIN] = search_top_bucket_for_highest_value()
+        // repeat for UCLAMP_MAX
+
+When all buckets are empty, the rq uclamp values are reset to system defaults.
+See section 3.4 for default values.
+
+
+2.2  MAX AGGREGATION:
+---------------------
+
+Util clamp is tuned to honour the request for the task that requires the
+highest performance point.
+
+When multiple tasks are attached to the same rq, then util clamp must make sure
+the task that needs the highest performance point gets it even if there's
+another task that doesn't need it or is disallowed from reaching this point.
+
+For example, if there are multiple tasks attached to an rq with the following
+values:
+
+        p0->uclamp[UCLAMP_MIN] = 300
+        p0->uclamp[UCLAMP_MAX] = 900
+
+        p1->uclamp[UCLAMP_MIN] = 500
+        p1->uclamp[UCLAMP_MAX] = 500
+
+then assuming both p0 and p1 are enqueued to the same rq
+
+        rq->uclamp[UCLAMP_MIN] = max(300, 500) = 500
+        rq->uclamp[UCLAMP_MAX] = max(900, 500) = 900
+
+As we shall see in section 5.1, this max aggregation is the cause of one of the
+limitations when using util clamp. Particularly for UCLAMP_MAX hint when user
+space would like to save power.
+
+2.3  HIERARCHICAL AGGREGATION:
+------------------------------
+
+As stated earlier, util clamp is a property of every task in the system. But
+the actual applied (effective) value can be influenced by more than just the
+request made by the task or another actor on its behalf (middleware library).
+
+The effective util clamp value of any task is restricted as follows:
+
+  1. By the uclamp settings defined by the cgroup CPU controller it is attached
+     to, if any.
+  2. The restricted value in (1) is then further restricted by the system wide
+     uclamp settings.
+
+Section 3 discusses the interfaces and will expand further on that.
+
+For now suffice to say that if a task makes a request, its actual effective
+value will have to adhere to some restrictions imposed by cgroup and system
+wide settings.
+
+The system will still accept the request even if effectively will look
+different; but as soon as the task moves to a different cgroup or a sysadmin
+modifies the system settings, it'll be able to get what it wants if the new
+settings allows it.
+
+In other words, this aggregation will not cause an error when a task changes
+its uclamp values. It just might not be able to achieve it based on those
+factors.
+
+2.4  Range:
+-----------
+
+Uclamp performance request follow the utilization range: [0:1024] inclusive.
+
+For cgroup interface percentage is used: [0:100] inclusive.
+You can use 'max' instead of 100 like other cgroup interfaces.
+
+3.  INTERFACES:
+===============
+
+3.1  PER TASK INTERFACE:
+------------------------
+
+sched_setattr() syscall was extended to accept two new fields:
+
+* sched_util_min: requests the minimum performance point the system should run
+                  at when this task is running. Or lower performance bound.
+* sched_util_max: requests the maximum performance point the system should run
+                  at when this task is running. Or upper performance bound.
+
+For example:
+
+        attr->sched_util_min = 40% * 1024;
+        attr->sched_util_max = 80% * 1024;
+
+Will tell the system that when task @p is running, it should try its best to
+ensure it starts at a performance point no less than 40% of maximum system's
+capability.
+
+And if the task runs for a long enough time so that its actual utilization goes
+above 80%, then it should not cause the system to operate at a performance
+point higher than that.
+
+The special value -1 is used to reset the uclamp settings to the system
+default.
+
+Note that resetting the uclamp value to system default using -1 is not the same
+as setting the uclamp value to system default.
+
+        attr->sched_util_min = -1  // p0 is reset to system default e.g: 0
+
+        not the same as
+
+        attr->sched_util_min = 0   // p0 is set to 0, the fact it is the same
+                                   // as system default is irrelevant
+
+This distinction is important because as we shall see in system interfaces, the
+default value for RT could be changed. SCHED_NORMAL/OTHER might gain similar
+knobs too in the future.
+
+3.2  CGROUP INTERFACE:
+----------------------
+
+There are two uclamp related values in the CPU cgroup controller:
+
+* cpu.uclamp.min
+* cpu.uclamp.max
+
+When a task is attached to a CPU controller, its uclamp values will be impacted
+as follows:
+
+* cpu.uclamp.min is a protection as described in section 3-3 in
+  Documentation/admin-guide/cgroup-v2.rst.
+
+  If a task uclamp_min value is lower than cpu.uclamp.min, then the task will
+  inherit the cgroup cpu.uclamp.min value.
+
+  In a cgroup hierarchy, effective cpu.uclamp.min is the max of (child,
+  parent).
+
+* cpu.uclamp.max is a limit as described in section 3-2 in
+  Documentation/admin-guide/cgroup-v2.rst.
+
+  If a task uclamp_max value is higher than cpu.uclamp.max, then the task will
+  inherit the cgroup cpu.uclamp.max value.
+
+  In a cgroup hierarchy, effective cpu.uclamp.max is the min of (child,
+  parent).
+
+For example:
+
+        p0->uclamp[UCLAMP_MIN] = // system default;
+        p0->uclamp[UCLAMP_MAX] = // system default;
+
+        p1->uclamp[UCLAMP_MIN] = 40% * 1024;
+        p1->uclamp[UCLAMP_MAX] = 50% * 1024;
+
+        cgroup0->cpu.uclamp.min = 20% * 1024;
+        cgroup0->cpu.uclamp.max = 60% * 1024;
+
+        cgroup1->cpu.uclamp.min = 60% * 1024;
+        cgroup1->cpu.uclamp.max = 100% * 1024;
+
+when p0 and p1 are attached to cgroup0
+
+        p0->uclamp[UCLAMP_MIN] = cgroup0->cpu.uclamp.min = 20% * 1024;
+        p0->uclamp[UCLAMP_MAX] = cgroup0->cpu.uclamp.max = 60% * 1024;
+
+        p1->uclamp[UCLAMP_MIN] = 40% * 1024; // intact
+        p1->uclamp[UCLAMP_MAX] = 50% * 1024; // intact
+
+when p0 and p1 are attached to cgroup1
+
+        p0->uclamp[UCLAMP_MIN] = cgroup1->cpu.uclamp.min = 60% * 1024;
+        p0->uclamp[UCLAMP_MAX] = cgroup1->cpu.uclamp.max = 100% * 1024;
+
+        p1->uclamp[UCLAMP_MIN] = cgroup1->cpu.uclamp.min = 60% * 1024;
+        p1->uclamp[UCLAMP_MAX] = 50% * 1024; // intact
+
+Note that cgroup interfaces allows cpu.uclamp.max value to be lower than
+cpu.uclamp.min. Other interfaces don't allow that.
+
+3.3  SYSTEM INTERFACE:
+----------------------
+
+3.3.1  sched_util_clamp_min:
+----------------------------
+
+System wide limit of allowed UCLAMP_MIN range. By default set to 1024, which
+means tasks are allowed to reach an effective UCLAMP_MIN value in the range of
+[0:1024].
+
+By changing it to 512 for example the effective allowed range reduces to
+[0:512].
+
+This is useful to restrict how much boosting tasks are allowed to acquire.
+
+Requests from tasks to go above this point will still succeed, but effectively
+they won't be achieved until this value is >= p->uclamp[UCLAMP_MIN].
+
+The value must be smaller than or equal to sched_util_clamp_max.
+
+3.3.2  sched_util_clamp_max:
+----------------------------
+
+System wide limit of allowed UCLAMP_MAX range. By default set to 1024, which
+means tasks are allowed to reach an effective UCLAMP_MAX value in the range of
+[0:1024].
+
+By changing it to 512 for example the effective allowed range reduces to
+[0:512]. The visible impact of this is that no task can run above 512, which in
+return means that all rqs are restricted too. IOW, the whole system is capped
+to half its performance capacity.
+
+This is useful to restrict the overall maximum performance point of the system.
+
+Can be handy to limit performance when running low on battery.
+
+Requests from tasks to go above this point will still succeed, but effectively
+they won't be achieved until this value is >= p->uclamp[UCLAMP_MAX].
+
+The value must be greater than or equal to sched_util_clamp_min.
+
+3.4  DEFAULT VALUES:
+----------------------
+
+By default all SCHED_NORMAL/SCHED_OTHER tasks are initialized to:
+
+        p_fair->uclamp[UCLAMP_MIN] = 0
+        p_fair->uclamp[UCLAMP_MAX] = 1024
+
+That is no boosting or restriction on any task. These default values can't be
+changed at boot or runtime. No argument was made yet as to why we should
+provide this, but can be added in the future.
+
+For SCHED_FIFO/SCHED_RR tasks:
+
+        p_rt->uclamp[UCLAMP_MIN] = 1024
+        p_rt->uclamp[UCLAMP_MAX] = 1024
+
+That is by default they're boosted to run at the maximum performance point of
+the system which retains the historical behavior of the RT tasks.
+
+RT tasks default uclamp_min value can be modified at boot or runtime via
+sysctl. See section 3.4.1.
+
+3.4.1  sched_util_clamp_min_rt_default:
+---------------------------------------
+
+Running RT tasks at maximum performance point is expensive on battery powered
+devices and not necessary. To allow system designers to offer good performance
+guarantees for RT tasks without pushing it all the way to maximum performance
+point, this sysctl knob allows tuning the best boost value to address the
+system requirement without burning power running at maximum performance point
+all the time.
+
+Application designers are encouraged to use the per task util clamp interface
+to ensure they are performance and power aware. Ideally this knob should be set
+to 0 by system designers and leave the task of managing performance
+requirements to the apps themselves.
+
+4.  HOW TO USE UTIL CLAMP:
+==========================
+
+Util clamp promotes the concept of user space assisted power and performance
+management. At the scheduler level the info required to make the best decision
+are non existent. But with util clamp user space can hint to the scheduler to
+make better decision about task placement and frequency selection.
+
+Best results are achieved by not making any assumptions about the system the
+application is running on and to use it in conjunction with a feedback loop to
+dynamically monitor and adjust. Ultimately this will allow for a better user
+experience at a better perf/watt.
+
+For some systems and use cases, static setup will help to achieve good results.
+Portability will be a problem in this case. After all how much work one can do
+at 100, 200 or 1024 is unknown and a special property of every system. Unless
+there's a specific target system, static setup should be avoided.
+
+All in all there are enough possibilities to create a whole framework based on
+util clamp or self contained app that makes use of it directly.
+
+4.1  BOOST IMPORTANT AND DVFS-LATENCY-SENSITIVE TASKS:
+------------------------------------------------------
+
+A GUI task might not be busy to warrant driving the frequency high when it
+wakes up. But it requires to finish its work within a specific period of time
+to deliver the desired user experience. The right frequency it requires at
+wakeup will be system dependent. On some underpowered systems it will be high,
+on other overpowered ones, it will be low or 0.
+
+This task can increase its UCLAMP_MIN value every time it misses a deadline to
+ensure on next wake up it runs at a higher performance point. It should try to
+approach the lowest UCLAMP_MIN value that allows to meet its deadline on any
+particular system to achieve the best possible perf/watt for that system.
+
+On heterogeneous systems, it might be important for this task to run on
+a bigger CPU.
+
+Generally it is advised to perceive the input as performance level or point
+which will imply both task placement and frequency selection.
+
+4.2  CAP BACKGROUND TASKS:
+--------------------------
+
+Like explained for Android case in the introduction. Any app can lower
+UCLAMP_MAX for some background tasks that don't care about performance but
+could end up being busy and consume unnecessary system resources on the system.
+
+4.3  POWERSAVE MODE:
+--------------------
+
+sched_util_clamp_max system wide interface can be used to limit all tasks from
+operating at the higher performance points which are usually energy
+inefficient.
+
+This is not unique to uclamp as one can achieve the same by reducing max
+frequency of the cpufreq governor. It can be considered a more convenient
+alternative interface.
+
+4.4  PER APP PERFORMANCE RESTRICTIONS:
+--------------------------------------
+
+Middleware/Utility can provide the user an option to set UCLAMP_MIN/MAX for an
+app every time it is executed to guarantee a minimum performance point and/or
+limit it from draining system power at the cost of reduced performance for
+these apps.
+
+If you want to prevent your laptop from heating up while on the go from
+compiling the kernel and happy to sacrifice performance to save power, but
+still would like to keep your browser performance intact; uclamp enables that.
+
+5.  LIMITATIONS:
+================
+
+5.1  CAPPING FREQUENCY WITH UCLAMP_MAX FAILS UNDER CERTAIN CONDITIONS:
+----------------------------------------------------------------------
+
+If task p0 is capped to run at 512
+
+        p0->uclamp[UCLAMP_MAX] = 512
+
+is sharing the rq with p1 which is free to run at any performance point
+
+        p1->uclamp[UCLAMP_MAX] = 1024
+
+then due to max aggregation the rq will be allowed to reach max performance
+point
+
+        rq->uclamp[UCLAMP_MAX] = max(512, 1024) = 1024
+
+Assuming both p0 and p1 have UCLAMP_MIN = 0, then the frequency selection for
+the rq will depend on the actual utilization value of the tasks.
+
+If p1 is a small task but p0 is a CPU intensive task, then due to the fact that
+both are running at the same rq, p1 will cause the frequency capping to be left
+from the rq although p1, which is allowed to run at any performance point,
+doesn't actually need to run at that frequency.
+
+5.2  UCLAMP_MAX CAN BREAK PELT (UTIL_AVG) SIGNAL
+------------------------------------------------
+
+PELT assumes that frequency will always increase as the signals grow to ensure
+there's always some idle time on the CPU. But with UCLAMP_MAX, we will prevent
+this frequency increase which can lead to no idle time in some circumstances.
+When there's no idle time, then a task will look like a busy loop, which would
+result in util_avg being 1024.
+
+Combing with issue described in 5.2, this an lead to unwanted frequency spikes
+when severely capped tasks share the rq with a small non capped task.
+
+As an example if task p
+
+        p0->util_avg = 300
+        p0->uclamp[UCLAMP_MAX] = 0
+
+wakes up on an idle CPU, then it will run at min frequency this CPU is capable
+of.
+
+        rq->uclamp[UCLAMP_MAX] = 0
+
+If the ratio of Fmax/Fmin is 3, then
+
+        300 * (Fmax/Fmin) = 900
+
+Which indicates the CPU will still see idle time since 900 is < 1024. The
+_actual_ util_avg will NOT be 900 though. It will be higher than 300, but won't
+approach 900. As long as there's idle time, p->util_avg updates will be off by
+a some margin, but not proportional to Fmax/Fmin.
+
+        p0->util_avg = 300 + small_error
+
+Now if the ratio of Fmax/Fmin is 4, then
+
+        300 * (Fmax/Fmin) = 1200
+
+which is higher than 1024 and indicates that the CPU has no idle time. When
+this happens, then the _actual_ util_avg will become 1024.
+
+        p0->util_avg = 1024
+
+If task p1 wakes up on this CPU
+
+        p1->util_avg = 200
+        p1->uclamp[UCLAMP_MAX] = 1024
+
+then the effective UCLAMP_MAX for the CPU will be 1024 according to max
+aggregation rule. But since the capped p0 task was running and throttled
+severely, then the rq->util_avg will be 1024.
+
+        p0->util_avg = 1024
+        p1->util_avg = 200
+
+        rq->util_avg = 1024
+        rq->uclamp[UCLAMP_MAX] = 1024
+
+Hence lead to a frequency spike since if p0 wasn't throttled we should get
+
+        p0->util_avg = 300
+        p1->util_avg = 200
+
+        rq->util_avg = 500
+
+and run somewhere near mid performance point of that CPU, not the Fmax we get.
+
+5.3  SCHEDUTIL RESPONSE TIME ISSUES:
+------------------------------------
+
+schedutil has three limitations:
+
+        1. Hardware takes non-zero time to respond to any frequency change
+           request. On some platforms can be in the order of few ms.
+        2. Non fast-switch systems require a worker deadline thread to wake up
+           and perform the frequency change, which adds measurable overhead.
+        3. schedutil rate_limit_us drops any requests during this rate_limit_us
+           window.
+
+If a relatively small task is doing critical job and requires a certain
+performance point when it wakes up and starts running, then all these
+limitations will prevent it from getting what it wants in the time scale it
+expects.
+
+This limitation is not only impactful when using uclamp, but will be more
+prevalent as we no longer gradually ramp up or down. We could easily be
+jumping between frequencies depending on the order tasks wake up, and their
+respective uclamp values.
+
+We regard that as a limitation of the capabilities of the underlying system
+itself.
+
+There is room to improve the behavior of schedutil rate_limit_us, but not much
+to be done for 1 or 2. They are considered hard limitations of the system.
-- 
2.25.1

