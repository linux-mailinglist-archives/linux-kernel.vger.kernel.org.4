Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18152704DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjEPMWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjEPMWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:22:09 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B02530F1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:22:07 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50db7ec8188so13437246a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1684239725; x=1686831725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDvSzF7eFHvldf+F8B0EAJefAcI+szYaDeqPAOVVxnA=;
        b=Me5vW3mGX149xX/rbimM22Ywtfg6BI7CDY4N+UNdAN/qi3aTJZZQ4TgkpFibpDSO9+
         S0QWc9KSQvb/94s4HG5cAbn27P6Ttb6l/hMvmiCxznwdMtffxTv0DirXukAvH+BBzDCB
         KyoOuxDMGFve+fgzbXzUYzl6nqw9KZMauKqX7sGdWtzgNn5mQVCOa4M/jH1dAWRfSXnl
         UIbK3EhyVVEplIV1LRTGteDRQt6MGxui7nqQRjtGMDKvJt6tcQl7282xUjszByF9DJkR
         u/yNB5YKij23ZYGW5DtpPj5caGQQd/V6HiWRPoTehcJGwgQSfLrp6BNPlVpIZdDzGaIw
         UOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684239725; x=1686831725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDvSzF7eFHvldf+F8B0EAJefAcI+szYaDeqPAOVVxnA=;
        b=FdgvS1KXgfySAo2++aLc77+aVtWAolPf7ezGQFjoOoRbSvIAgY2r32L7QSa2bgceAS
         NZLTooD2QcJEyCRqfCwZnhT95yQyd0F7I4/VtVkmnmNiS/VIxM0P0K+WM/ld3Zgz87Ls
         Ogv2dUFo6SmIZss5OVcnF0IFacJIwPvwzF2jVa/uqbnz9KevF/Z0QCFMMAXHu2avg1m5
         KF20+yYRP+cAlWYh2n5Mqh1wAnIUaskezQk5VM9d2YyI5bH7em0a05wh30g32XjxkhdG
         aQWeGuYLA+x6DXSgPdpjWvSP0bFCekSP8Q5bKpVoSBZ99HmyFJYGdihImFIfuXM6jvBX
         I1kg==
X-Gm-Message-State: AC+VfDy7Kvo8DUMTSd7qAOauKxWNHy64WfaepMccr+Jtn+rAW37i806f
        8B5MBYZufeBEjkhW92QLjG3i44Q0k6rsnt393wM=
X-Google-Smtp-Source: ACHHUZ65vYQ4QXaFf1yiJccB33WZZZQhORecTVGgtKm+Mo+JIXng8QroXzvR7g3ThzdxEpjqn3eZsQ==
X-Received: by 2002:a05:6402:414:b0:50b:c0ce:d55 with SMTP id q20-20020a056402041400b0050bc0ce0d55mr25801498edv.3.1684239725269;
        Tue, 16 May 2023 05:22:05 -0700 (PDT)
Received: from neptune.lan ([188.27.128.119])
        by smtp.gmail.com with ESMTPSA id d11-20020a05640208cb00b0050bd4b8ca8fsm8063115edz.14.2023.05.16.05.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 05:22:04 -0700 (PDT)
From:   Alexandru Ardelean <alex@shruggie.ro>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tian.xianting@h3c.com,
        steffen.aschbacher@stihl.de, Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH][V2] sched/rt: Print curr when RT throttling activated
Date:   Tue, 16 May 2023 15:22:02 +0300
Message-Id: <20230516122202.954313-1-alex@shruggie.ro>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xianting Tian <tian.xianting@h3c.com>

We may meet the issue, that one RT thread occupied the cpu by 950ms/1s,
The RT thread maybe is a business thread or other unknown thread.

Currently, it only outputs the print "sched: RT throttling activated"
when RT throttling happen. It is hard to know what is the RT thread,
For further analysis, we need add more prints.

This patch is to print current RT task when RT throttling activated,
It help us to know what is the RT thread in the first time.

Tested-by: Alexandru Ardelean <alex@shruggie.ro>
Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---

Initial patch submission:
  https://lore.kernel.org/all/f3265adc26d4416dacf157f61fa60ad6@h3c.com/T/

We've been having some issues of our own with some applications + some RT
configuration == some threads endded up taking too much CPU time.
This patch came in quite in handy to see in logs which thread is more
problematic.

We've applied this patch onto a 5.10.116 tree. It did need a bit of
re-applying since some context has changed since the initial version (hence
the V2 tag).
Since 5.10.116 (where we used it), it applied nicely to the latest/current
linux-next tree (hence the Tested-by tag).

It would be nice to apply this to the mainline kernel and have this handy.

 kernel/sched/rt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 00e0e5074115..44b161e42733 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -995,7 +995,7 @@ static inline int rt_se_prio(struct sched_rt_entity *rt_se)
 	return rt_task_of(rt_se)->prio;
 }
 
-static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
+static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq, struct task_struct *curr)
 {
 	u64 runtime = sched_rt_runtime(rt_rq);
 
@@ -1019,7 +1019,8 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
 		 */
 		if (likely(rt_b->rt_runtime)) {
 			rt_rq->rt_throttled = 1;
-			printk_deferred_once("sched: RT throttling activated\n");
+			printk_deferred_once("sched: RT throttling activated (curr: pid %d, comm %s)\n",
+						curr->pid, curr->comm);
 		} else {
 			/*
 			 * In case we did anyway, make it go away,
@@ -1074,7 +1075,7 @@ static void update_curr_rt(struct rq *rq)
 		if (sched_rt_runtime(rt_rq) != RUNTIME_INF) {
 			raw_spin_lock(&rt_rq->rt_runtime_lock);
 			rt_rq->rt_time += delta_exec;
-			exceeded = sched_rt_runtime_exceeded(rt_rq);
+			exceeded = sched_rt_runtime_exceeded(rt_rq, curr);
 			if (exceeded)
 				resched_curr(rq);
 			raw_spin_unlock(&rt_rq->rt_runtime_lock);
-- 
2.40.1

