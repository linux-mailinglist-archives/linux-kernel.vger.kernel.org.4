Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3056248A0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiKJRul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiKJRuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:50:25 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487222FC30
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:50:23 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso1657313wmo.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ySpaS8Fkj5Miw0XHBXwZ3O8DcUQ428wDyrUI4Txxz7I=;
        b=hf1Bmm3qTQNsSIOlKLTd6ZGi0sOW06EIWnJhpFoBtnO4ELVAcPyLDmB/C+/Kenmi+O
         /a5SepUDLDQT2hP91MYsYZqSRuLuGrZtsGKJdsOQ5etk4yXI/epOeIVHbWRVOLlbDCRP
         gyVszqcKDTWCGw3Ylbn/k6Uua0S2q/81i5sd9xTvZ+OKl1UtNTDTI5NjaQ4Vwzq2QClT
         YGF7pfamPZ0CgQ9nr1d1lXDQwtLCuDQfLyW+urIORrM9MxNrnhJgdY6wyuJUn07CyZrF
         qnKVR0a3ULjrVM1pU3jdXZRCArdlJfLLFnFP3aeHdTfjV/5QEvArJXzAXUBDguTmKNq9
         YFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ySpaS8Fkj5Miw0XHBXwZ3O8DcUQ428wDyrUI4Txxz7I=;
        b=Pimn2pXwi16McZiORGsFcmzclRAJ9SLGRILSlNGhU9rbVk1qdRkw1kEJ0DXUucOFlc
         V1MbLFZljFGpuUhWEsa4NozbaYtNxfbVuyNCJhcgWUJDZPqS/UEMO2YtmLpT9//IXimt
         u643JN43a9mFHJGAMJ2ZOTzcv5+5kLXaMkQQWoXSIW0IS9dT5V3GLftn5SY3/Azs0xCL
         zUF7RyWybGC6qW/Z+X55/H5wxSw19bUFbCfbbrMDeMweClrodzJFgIk5m266riWIJHfo
         IiDn5uqjIOUHfv/XxUJBHvCOOgmHvHB4gzrzg0dje1eqCYNKF8BT8aYIdwzPeeiSD7Wq
         QWpQ==
X-Gm-Message-State: ACrzQf3IxmXFUzmuFZqX4OgbSHYJrGBEfPfJLwMcKe2z4zZVV9Asip01
        DudlOVurmOLCWynm1Mxy3hbGGg==
X-Google-Smtp-Source: AMsMyM7hOOOoUmMalY8zq9nSfZAhpcNSfUp4ITdwGvVktUNybH5dBzhHvKYVgE7TmRIlq8rN1uIjAQ==
X-Received: by 2002:a05:600c:818:b0:3cf:7385:7609 with SMTP id k24-20020a05600c081800b003cf73857609mr38335386wmp.186.1668102621748;
        Thu, 10 Nov 2022 09:50:21 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:342a:468f:562a:9cc4])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c4e8600b003cfc02ab8basm6514677wmq.33.2022.11.10.09.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:50:20 -0800 (PST)
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
Subject: [PATCH v8 3/9] sched/core: Propagate parent task's latency requirements to the child task
Date:   Thu, 10 Nov 2022 18:50:03 +0100
Message-Id: <20221110175009.18458-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221110175009.18458-1-vincent.guittot@linaro.org>
References: <20221110175009.18458-1-vincent.guittot@linaro.org>
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
index 02dc1b8e3cb6..54544353025b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4559,6 +4559,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
 
+		p->latency_nice = DEFAULT_LATENCY_NICE;
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
 		 * fulfilled its duty:
-- 
2.17.1

