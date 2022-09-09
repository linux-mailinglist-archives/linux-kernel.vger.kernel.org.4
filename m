Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC9F5B3896
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiIINEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiIINDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:03:20 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2AC696F5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 06:03:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id e15so162215wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 06:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=rlyri6gFQXbjH6qaw2UpG7VLO1J+noZ/tZbnqvT/NqA=;
        b=hSQpx/vphpHkQs39vs9BDtqrWFMFnPic+HPynK8XcJzdxRGKV9EwhS4i3t+PofmJzd
         b12BfAivvKi/iwuwFVGOyulbrtU0jObl35cg6XWYYtA14S+162Xhrj8iSL3N3d2dGClJ
         VV43PPqpxWISAfoIiiPgPS8qP88oUg8lzOq9TofhhCV1KNJ3rDbx0mf0mJJqN/HCvoId
         DDqPB2ISeRNbTCl7rN9rZHsqzreF8AtqfOoSwLLeR5UuJ46zBNngIiVfcfTbpsGSstz6
         9RE4x22HGLyrP7sVFn1KDiNissQZQIgxu4gWIidnPrG0l0Ng22Q7Ib7eGxUivVkK5ElA
         XHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rlyri6gFQXbjH6qaw2UpG7VLO1J+noZ/tZbnqvT/NqA=;
        b=kcUiMFy6YiQPUDcjhQ6E8Pl3m8vDGNmYM988ih065Lzcpg3BjDAyzAPhhdLNrpCGq3
         XiSk/kd1y7nBkNtfejE96HhfvnXu77bCQKYDLUcRLV7MWI1hZyKsprlAJkqMvxZxz9Ht
         XC1fzyr5KgLiTitZuKBKVGuZwD9PtcipEAOX8mSDq+JYavsQV5Z257gciCngD8/RVXLA
         VWzeYLqr2L87SU+NcshhOcCQ5R+5mqQrzbeS5biTBZthfMl3z3wGa4RnZL0mcIwytumG
         yCATjrSmXrtDWGmY4ckR5kVJwp2rZi/V0qFPFlH583B8iRrWkOkE0weoNEmpyXeyZMB+
         SMrg==
X-Gm-Message-State: ACgBeo36043zO2ukbSVWti626EdiEwGRBs9VPOok+s7Y57uplykvQIBW
        /8XZKQMUdDXjns4FMaspBkEcNg==
X-Google-Smtp-Source: AA6agR76kOGvyPCMLTmHnGhkRdQAP3O/7XvJLAwjU1LsD0LXyUpQ1A4jr0gDj3JR1lXALEaZo3Cmhw==
X-Received: by 2002:a05:600c:410d:b0:3a6:1db8:b419 with SMTP id j13-20020a05600c410d00b003a61db8b419mr5405856wmi.119.1662728597787;
        Fri, 09 Sep 2022 06:03:17 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:c6e:e86:ab92:92b7])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c3b0a00b003a5f4fccd4asm569909wms.35.2022.09.09.06.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 06:03:16 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 2/8] sched/core: Propagate parent task's latency requirements to the child task
Date:   Fri,  9 Sep 2022 15:03:03 +0200
Message-Id: <20220909130309.25458-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909130309.25458-1-vincent.guittot@linaro.org>
References: <20220909130309.25458-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 kernel/sched/core.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/init/init_task.c b/init/init_task.c
index 73cc8f03511a..225d11a39bc9 100644
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
index 603a80ec9b0e..3c5fb04f00e1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4511,6 +4511,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	 */
 	p->prio = current->normal_prio;
 
+	/* Propagate the parent's latency requirements to the child as well */
+	p->latency_nice = current->latency_nice;
+
 	uclamp_fork(p);
 
 	/*
@@ -4527,6 +4530,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
 
+		p->latency_nice = DEFAULT_LATENCY_NICE;
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
 		 * fulfilled its duty:
-- 
2.17.1

