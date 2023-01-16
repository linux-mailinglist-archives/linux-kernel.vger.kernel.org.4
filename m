Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A209B66B9BC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjAPJAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjAPI7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:59:45 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C3E166DA
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:58:46 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-4a263c4ddbaso372473737b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zuSxYEPkMjk82KBC8EhT/h+b6b5l6gYAxOwSeD4dHkA=;
        b=bd9JoYSEWmsaUlXw5SI+TilBUTUNytWMRwiZ5uU1fh5ZyPbK5QDjdl84glcy4le5ZH
         xWRTnLZraaQAs5NYmcOtjBKydLtbKp2SRvU06YazRSApqpomlLPBC67Vv/i9PxMz/jUU
         umO+t88exGvyu4oCrHqB17kiqABuAWQfSinGoO+ZTQIfUU52e0u1KawOLL4kL/jl06l4
         rdA5xRXo/PTX1II1+TxPN+JdPNeuHKBZ05b+b05x6afLm7MC7KFRK1WoQQSca4zXKETe
         6ARUrYv4sdSiT+gxLH+HjrCjorXemW8729Vq+oT3097eTyDcr9A9GpDuWmp4hcODD0vj
         c4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zuSxYEPkMjk82KBC8EhT/h+b6b5l6gYAxOwSeD4dHkA=;
        b=UiI7yXa88NG2RYJzaKfCCTrTw8m4y++Y+ZsjNlsHDzymWdzIOa4xbh2TLUGESEKf3H
         8RB+EYIMn2nUgawoA4MD27kVf6k5fzD7poN66goc02XDVQbLDBjOFKipgkXCP+9kTd7v
         H52OCreV8kJ1gt0OVVMuPlv0RaYQorFrL5O545USs+kLdph4raFF4Jfqp1pPZyS92Kx/
         JRnXQcKX+LtwvJEAd9sUNp3klR9lcH1USNlxeCMhzTvoPz0XSLsrAVFJbo7E8NrNY2gZ
         ZoGx93FYbIhQciNNayVOWXV/prMC7E4Qs42MmdBLOALNqxyrEVOHPHPUmhHpYOFYsoi+
         LYww==
X-Gm-Message-State: AFqh2kqQuJiAD34DV3dL6QjTAYAc9Q5Gtgod7Xs57dzgJdWErnM8E54s
        wFvZZ8Q3zRyK1oSo4eLFZ6MSCBcGSRI/IXXIYUfPcD0/Rz1cds9W
X-Google-Smtp-Source: AMrXdXsV3yfBLWlyvhYWgw4Q7LnScwDpxiq5VFP+FvT7AJWWDIqQE/v82RBEaY0QsOkz9rv9CcW2cic1Vd4zdMIKmLU=
X-Received: by 2002:a81:6ac2:0:b0:4db:1408:a90c with SMTP id
 f185-20020a816ac2000000b004db1408a90cmr1518421ywc.55.1673859525201; Mon, 16
 Jan 2023 00:58:45 -0800 (PST)
MIME-Version: 1.0
From:   Rick Yiu <rickyiu@google.com>
Date:   Mon, 16 Jan 2023 16:58:09 +0800
Message-ID: <CAKns5cVijC_o13H7UM7WS2ckexP2y1aYJviqNcKeCE-y_2mcXQ@mail.gmail.com>
Subject: [PATCH] sched: Pass flags to cpufreq governor for RT tasks
To:     mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, Rick Yiu <rickyiu@google.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now only CFS tasks could pass flags to the cpufreq governor
but not RT tasks. This limits the ability of cpufreq governor to handle
RT tasks if it needs to. By passing flags of RT tasks will increase
the flexibility of the cpufreq governor.

Signed-off-by: Rick Yiu <rickyiu@google.com>
---
 kernel/sched/rt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index ed2a47e4ddae..6cef87b3d946 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -479,7 +479,7 @@ static inline void rt_queue_push_tasks(struct rq *rq)
 }
 #endif /* CONFIG_SMP */

-static void enqueue_top_rt_rq(struct rt_rq *rt_rq);
+static void enqueue_top_rt_rq(struct rt_rq *rt_rq, unsigned int flags);
 static void dequeue_top_rt_rq(struct rt_rq *rt_rq, unsigned int count);

 static inline int on_rt_rq(struct sched_rt_entity *rt_se)
@@ -584,7 +584,7 @@ static void sched_rt_rq_enqueue(struct rt_rq *rt_rq)

  if (rt_rq->rt_nr_running) {
  if (!rt_se)
- enqueue_top_rt_rq(rt_rq);
+ enqueue_top_rt_rq(rt_rq, 0);
  else if (!on_rt_rq(rt_se))
  enqueue_rt_entity(rt_se, 0);

@@ -681,7 +681,7 @@ static inline void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
  if (!rt_rq->rt_nr_running)
  return;

- enqueue_top_rt_rq(rt_rq);
+ enqueue_top_rt_rq(rt_rq, 0);
  resched_curr(rq);
 }

@@ -1102,7 +1102,7 @@ dequeue_top_rt_rq(struct rt_rq *rt_rq, unsigned int count)
 }

 static void
-enqueue_top_rt_rq(struct rt_rq *rt_rq)
+enqueue_top_rt_rq(struct rt_rq *rt_rq, unsigned int flags)
 {
  struct rq *rq = rq_of_rt_rq(rt_rq);

@@ -1120,7 +1120,7 @@ enqueue_top_rt_rq(struct rt_rq *rt_rq)
  }

  /* Kick cpufreq (see the comment in kernel/sched/sched.h). */
- cpufreq_update_util(rq, 0);
+ cpufreq_update_util(rq, flags);
 }

 #if defined CONFIG_SMP
@@ -1508,7 +1508,7 @@ static void enqueue_rt_entity(struct
sched_rt_entity *rt_se, unsigned int flags)
  dequeue_rt_stack(rt_se, flags);
  for_each_sched_rt_entity(rt_se)
  __enqueue_rt_entity(rt_se, flags);
- enqueue_top_rt_rq(&rq->rt);
+ enqueue_top_rt_rq(&rq->rt, flags);
 }

 static void dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned
int flags)
@@ -1525,7 +1525,7 @@ static void dequeue_rt_entity(struct
sched_rt_entity *rt_se, unsigned int flags)
  if (rt_rq && rt_rq->rt_nr_running)
  __enqueue_rt_entity(rt_se, flags);
  }
- enqueue_top_rt_rq(&rq->rt);
+ enqueue_top_rt_rq(&rq->rt, flags);
 }

 /*
-- 
2.39.0.314.g84b9a713c41-goog
