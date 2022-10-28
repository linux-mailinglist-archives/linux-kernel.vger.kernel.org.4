Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A28A610B66
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiJ1Hhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiJ1HhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:37:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25921BE1D6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:37:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z14so5830391wrn.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zy7QY6HAum4eocAiGxC3tA1yZA7zRnpZ3kdrW18hPm0=;
        b=VLe7YWFtcwIvALbj2GLX0Md1taqlPqb82YAbGh6QGYJTtbgEU4+3dtSWNFLSgbx4yI
         Qcf+VVGUxYSdtKyLIa2gsj0R8gSwuvBup3mvo3kxxwRd5fG4iRv5/QX0+eL4DwnWTO4g
         MkD/YgWag9h/tQRxFb8J5LFYNcvMwxyE9LE8tZTH4g+mTPTiGSr1P6d6XPrbeVJtIV6x
         IElsLB2eVc/pEcwJctzSOAUEW6AnvJ7u46WxgstpyX6Gz5ztSRaaiSejyLA0uXfvZ0O9
         PADRkkwSJ+bMoZ+wjjzRbzYZdOnJOr/n/2AOhr1eP/oJncvK5Ez2CuZkHMax1j+RWhzW
         n0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zy7QY6HAum4eocAiGxC3tA1yZA7zRnpZ3kdrW18hPm0=;
        b=durP6NWS6xyMHERg+qt48ojJXfGbBGYdh8MP9mLsPvkfi9AqikYDqLtifbbbRcIFK2
         KOcaCrvOAgK8jWF55Lp5SEnh2HchnFuzLCHpOyuqIbsHHOSL7yXVO4+2rcX7MDu2vGmj
         4xiKE3lIHDfbSZVpzhaWTWXaEMB+l4xSgPRWasFKO/9TvRUCfGhKM8qWzVxwB1YTzC3N
         WQ/k1YkezT3bOL1I8wZaolOI32B0k6c8AtNkiIZKD4SsGzPvFHUFx8CM08Sxrfmk2lll
         RO2BB6+B8VovrDpaiBxNo/IZYIXdf3ztQWNR+nGnFONmH4VGf6SgLLfQLl53JaUDsV7P
         GyDA==
X-Gm-Message-State: ACrzQf2z4Z6Rp5vGutjc8I+PbgS3PpN0irzh5Vz6fOq2lLJ+N1K26CIB
        jItzwnDv+eZTfpyHoSjnxufiqg==
X-Google-Smtp-Source: AMsMyM4NkPXOtECnCO73M+jfHHao2mIlnfaYbWEpgJYS+B4wV6AiB4hsyVIkyuBZ+igb4hxRS/JO5g==
X-Received: by 2002:adf:ec8a:0:b0:236:5b80:da83 with SMTP id z10-20020adfec8a000000b002365b80da83mr20949051wrn.509.1666942627666;
        Fri, 28 Oct 2022 00:37:07 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:c12b:b448:f0a9:83ef])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b003b47e8a5d22sm7783129wmq.23.2022.10.28.00.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 00:37:06 -0700 (PDT)
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
Subject: [PATCH v6 9/9] sched/fair: remove check_preempt_from_others
Date:   Fri, 28 Oct 2022 09:36:37 +0200
Message-Id: <20221028073637.31195-10-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221028073637.31195-1-vincent.guittot@linaro.org>
References: <20221028073637.31195-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the dedicated latency list, we don't have to take care of this special
case anymore as pick_next_entity checks for a runnable latency sensitive
task.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c28992b7d1a6..9a421b49dbfd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5802,35 +5802,6 @@ static int sched_idle_cpu(int cpu)
 }
 #endif
 
-static void set_next_buddy(struct sched_entity *se);
-
-static void check_preempt_from_others(struct cfs_rq *cfs, struct sched_entity *se)
-{
-	struct sched_entity *next;
-
-	if (se->latency_offset >= 0)
-		return;
-
-	if (cfs->nr_running <= 1)
-		return;
-	/*
-	 * When waking from another class, we don't need to check to preempt at
-	 * wakeup and don't set next buddy as a candidate for being picked in
-	 * priority.
-	 * In case of simultaneous wakeup when current is another class, the
-	 * latency sensitive tasks lost opportunity to preempt non sensitive
-	 * tasks which woke up simultaneously.
-	 */
-
-	if (cfs->next)
-		next = cfs->next;
-	else
-		next = __pick_first_entity(cfs);
-
-	if (next && wakeup_preempt_entity(next, se) == 1)
-		set_next_buddy(se);
-}
-
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
@@ -5917,15 +5888,14 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!task_new)
 		update_overutilized_status(rq);
 
-	if (rq->curr->sched_class != &fair_sched_class)
-		check_preempt_from_others(cfs_rq_of(&p->se), &p->se);
-
 enqueue_throttle:
 	assert_list_leaf_cfs_rq(rq);
 
 	hrtick_update(rq);
 }
 
+static void set_next_buddy(struct sched_entity *se);
+
 /*
  * The dequeue_task method is called before nr_running is
  * decreased. We remove the task from the rbtree and
-- 
2.17.1

