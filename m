Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3614364A8E1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbiLLUte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLLUtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:49:32 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925CA1057A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:49:31 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v8so14884523edi.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=45jhvye7rjPdF2QoJZQM1/16j/qti5bhbagOzYCEDeA=;
        b=D183ykkoG7Vfv8r9MQu/pRlJ6PM8KQceZcmeMzXN4qYYcjRubwI18McsWgKh649P/z
         5PBwgRwjqI2oSAc78js9fibch5QpSPvyJXNe2wBk1ZYfIVkPuzm99CeKpuQvOz6kC+lc
         GFPH2wrxOR0Ol39BtBY5V9lWxF+VrUUyt5YdhPzys4SW9WyhT/EuSjfBA6B4t1hDQ8it
         Q0t0fH1Ik7Le3/hvc9RyH9spv4n/QIwn3w56/2WQimNo7Gy2xUYNVuNma5CjBfcqKrOn
         TFaLlP8famH/MrjWyvaa2+vo2Wvtv6+Y35RCGSWTuQ7+FUspiT8fy6hA6DcdBv1T8WU5
         pEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45jhvye7rjPdF2QoJZQM1/16j/qti5bhbagOzYCEDeA=;
        b=oPUJ6albaL0qQ/Zp9AqD/aaTSVbsSBBiSMen4UOr+MbrjbOQyOaQoj/SlRZem0fEL8
         Y3MCkELDtn52np1+4VbqSgxIEkzxGEq14YlknGbEACLBx78gjTuAYgqHk4WNwyxhEhgD
         StUn1oh+fKfAV0GgEL6I3I9iF4BavWMhuta+MfmSOzA3RDidgXUIR+ruRI3IAc6uNQiT
         FkwWFal36XN2OVqYdy1AJYdELJHy0q7M/cjz2/up0fLhkX7enOZ92IHEa3E9pL2sBFrm
         JsCxvzOVwuGMQ1U4N3Tx8HrcItVWzjDAHjj0MRx+Iamrsjnt4Tbp4oy0+IJkF22yJA1S
         qNIw==
X-Gm-Message-State: ANoB5plK5Jso2R0BwuSRBDwZVusRfFL14rJlEZ1Co1o8orsNnlMWW82h
        L89ZmiFh2Ci1woqsIn2IhgAVDIChhOY=
X-Google-Smtp-Source: AA0mqf4ysWAFu0AP6vtGUawShsukq9vAT+6e4Odvd/9lQJPGhuZlcV0XZkxvpucU5P5n2ts21DU9PQ==
X-Received: by 2002:a50:ee8b:0:b0:46c:b25a:6d7f with SMTP id f11-20020a50ee8b000000b0046cb25a6d7fmr15504062edr.8.1670878170216;
        Mon, 12 Dec 2022 12:49:30 -0800 (PST)
Received: from gmail.com (1F2EF155.nat.pool.telekom.hu. [31.46.241.85])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090608c700b0078d9cd0d2d6sm3770060eje.11.2022.12.12.12.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 12:49:29 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 12 Dec 2022 21:49:27 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [GIT PULL] scheduler changes for v6.2
Message-ID: <Y5eT13pECzbv96Uu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest scheduler tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2022-12-12

   # HEAD: d6962c4fe8f96f7d384d6489b6b5ab5bf3e35991 sched: Clear ttwu_pending after enqueue_task()

Scheduler changes for v6.2:

 - Implement persistent user-requested affinity: introduce affinity_context::user_mask
   and unconditionally preserve the user-requested CPU affinity masks, for long-lived
   tasks to better interact with cpusets & CPU hotplug events over longer timespans,
   without destroying the original affinity intent if the underlying topology changes.

 - Uclamp updates: fix relationship between uclamp and fits_capacity()

 - PSI fixes

 - Misc fixes & updates.

 Thanks,

	Ingo

------------------>
Chengming Zhou (2):
      sched/psi: Fix avgs_work re-arm in psi_avgs_work()
      sched/psi: Use task->psi_flags to clear in CPU migration

Hao Lee (1):
      sched/psi: Fix possible missing or delayed pending event

Pierre Gondois (1):
      sched/fair: Check if prev_cpu has highest spare cap in feec()

Qais Yousef (9):
      sched/uclamp: Fix relationship between uclamp and migration margin
      sched/uclamp: Make task_fits_capacity() use util_fits_cpu()
      sched/uclamp: Fix fits_capacity() check in feec()
      sched/uclamp: Make select_idle_capacity() use util_fits_cpu()
      sched/uclamp: Make asym_fits_capacity() use util_fits_cpu()
      sched/uclamp: Make cpu_overutilized() use util_fits_cpu()
      sched/uclamp: Cater for uclamp in find_energy_efficient_cpu()'s early exit condition
      sched/fair: Detect capacity inversion
      sched/fair: Consider capacity inversion in util_fits_cpu()

Suren Baghdasaryan (1):
      sched/psi: Stop relying on timer_pending() for poll_work rescheduling

Tianchen Ding (1):
      sched: Clear ttwu_pending after enqueue_task()

Waiman Long (5):
      sched: Add __releases annotations to affine_move_task()
      sched: Introduce affinity_context
      sched: Always preserve the user requested cpumask
      sched: Enforce user requested affinity
      sched: Always clear user_cpus_ptr in do_set_cpus_allowed()


 include/linux/psi_types.h |   4 +
 include/linux/sched.h     |   3 -
 kernel/sched/core.c       | 259 ++++++++++++++++++++++++---------------
 kernel/sched/deadline.c   |   7 +-
 kernel/sched/fair.c       | 303 ++++++++++++++++++++++++++++++++++++++++------
 kernel/sched/psi.c        | 100 ++++++++++++---
 kernel/sched/sched.h      |  92 ++++++++++++--
 kernel/sched/stats.h      |  22 +---
 8 files changed, 607 insertions(+), 183 deletions(-)
