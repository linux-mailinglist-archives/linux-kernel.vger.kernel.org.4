Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D409362A01F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbiKORTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237837AbiKORTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:19:13 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F080114012
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:19:05 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso13622221wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DgoNBUoh3xxz3SNc31PO9TCe3YvH8+92yCBAOfiBBfg=;
        b=hR92ngdMg3GykIaP4ffe1GgO/tIUL6mOpgZJ4oKmccAUk9tP3gLq8vTiWyYjvolGJt
         vvF65JA347Yel2JzgD9Eneke7KfoUhrcJfPS1h1S/DlCWD6MPARG60Dn14vEwcaXxntV
         OT4pTEJqdz5Ycg4ITjVaH4ip0DLAy+YZ3huhT3MwNPuKmXz+XoXGqhTFBwpn6TlBoCcj
         D0OmDVl48lyoIgYYcgsLtwpATXsq0XWf9bLIEw0LFwQEE3ZlTw2iByPZDsTAj9tGUjgx
         10O/fz1E0RMU/rO8/RngXp/ukrAmD7/1uidZXTiyDnQN/KZNv8LVOnPPcP0ecCIS7NsJ
         23kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DgoNBUoh3xxz3SNc31PO9TCe3YvH8+92yCBAOfiBBfg=;
        b=cZ+umRTK4WfkpcYJ1Jo3gvHiNaks/Kl5067b5L1W6Gk0uf4vHeSIxvBnWsbyzLowr7
         MzFTnf5GyTOw3N5GlcLzBLBAfs7Lp7pM3cD6ajnWw3AJfGm6taCpy5e+5NY+gjYpmz46
         6Qlkt44PqAWD39KL178unWOmWWTbtZuhCXFbnPjLnGVZ8q7+AcRnvyyeWFcnuhF/h0/c
         fH2mrgRGb25Tvfp+dnE/svHd15qGLZWC6K1nafThh6URXFt2njEoAc+5FPfWemVPJgan
         cLtYBOF/Rgku3+/YKHN5fs4JMA4dd4fmM9hvIxB5axTApcJ3bpJio8bJdjEYz2BS9Jfi
         6Q8w==
X-Gm-Message-State: ANoB5plJ3eEnsKP1NH+PdYXDNW46yDpwFCOcLD6GZQtiX/YUpNRXsi1V
        /VkMW/mj66nGS1JWxX68VQyFgA==
X-Google-Smtp-Source: AA0mqf4UlrX5D8DgBA1b4vkwpHc3w/tK1dpXtXCJyr65p3JMv5dgCg9uvTJM8CS+sJ2rK6vOYn0ZHg==
X-Received: by 2002:a7b:c394:0:b0:3cf:b545:596 with SMTP id s20-20020a7bc394000000b003cfb5450596mr1198667wmj.49.1668532744320;
        Tue, 15 Nov 2022 09:19:04 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:91c8:7496:8b73:811f])
        by smtp.gmail.com with ESMTPSA id bg40-20020a05600c3ca800b003cf78aafdd7sm16846461wmb.39.2022.11.15.09.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 09:19:03 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v9 3/9] sched/core: Propagate parent task's latency requirements to the child task
Date:   Tue, 15 Nov 2022 18:18:45 +0100
Message-Id: <20221115171851.835-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221115171851.835-1-vincent.guittot@linaro.org>
References: <20221115171851.835-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Parth Shah <parth@linux.ibm.com>

Clone parent task's latency_nice attribute to the forked child task.

Reset the latency_nice value to default value when the child task is
set to sched_reset_on_fork.

Also, initialize init_task.latency_nice value with DEFAULT_LATENCY_NICE
value

Signed-off-by: Parth Shah <parth@linux.ibm.com>
[rebase]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 init/init_task.c    | 1 +
 kernel/sched/core.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/init/init_task.c b/init/init_task.c
index ff6c4b9bfe6b..7dd71dd2d261 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -78,6 +78,7 @@ struct task_struct init_task
 	.prio		= MAX_PRIO - 20,
 	.static_prio	= MAX_PRIO - 20,
 	.normal_prio	= MAX_PRIO - 20,
+	.latency_nice	= DEFAULT_LATENCY_NICE,
 	.policy		= SCHED_NORMAL,
 	.cpus_ptr	= &init_task.cpus_mask,
 	.user_cpus_ptr	= NULL,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 07ac08caf019..8c84c652853b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4592,6 +4592,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
 
+		p->latency_nice = DEFAULT_LATENCY_NICE;
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
 		 * fulfilled its duty:
-- 
2.17.1

