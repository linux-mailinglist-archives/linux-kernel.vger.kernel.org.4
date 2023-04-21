Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A246EA20A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 04:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjDUCwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 22:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjDUCvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 22:51:54 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C6D7ABC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 19:51:31 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b73203e0aso11426066b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 19:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682045491; x=1684637491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1WHvs8FWd3S03N28+vd/xDG2iC9YdMvjBgSLrt0Ra8=;
        b=aHIS0UObijyj/uf3kCDBFk1KumJsx6sc+4Wzeq8S20U8TZCO1UOHgxF3CUqNqhUiAp
         WV6LRLfcODt2FTkt9HCpcRbZ+J0f8Mzoc+/uwsZS2InzL/EKUULFjc49bFHYHNYsY/9G
         yYYeDqd/2nf02/HwWoT7xyYME0DKm2NlpyOTtpujpIz7qW8uiKFn1S5wCwGqrFhPppv+
         7NdvXkJwOZDwzTnj197PrkN0aSq+tpWNxMblkPKeUa+tHKxoT1bD4UcOBAyNFJxsBuH6
         HB+o/aVjuknxO0PJ7Zdg5Ox0wQCdNDX7lJTIfsMpQ+R9ZnQYXtCe6Ur0+QWCl53Q/efe
         6bkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682045491; x=1684637491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W1WHvs8FWd3S03N28+vd/xDG2iC9YdMvjBgSLrt0Ra8=;
        b=KzCkVxTgf5wkh2pnKOIX+Qc7Rq60guN0m4aWZYO4E30je5goObbuFYUt3X9ByiqoHP
         +bsV45rQ9nsGUYNuibn+eN3Wh8XkH0y3eh/o91fTO3YhGAK1UGTjjbss1fJgki59W5Pl
         qOB3ZySa8nKzo2jxyKkx0LtAIKLuLzhZrNUUy05pKEeZlylL4LnHp3PGm5uV+jiApIDF
         sVtwHy4zLXgBsA18EE+hPa/Ml7mx41yghiOhMl11Wf8ifVLFTMjRBBmJzDTaEz15+St3
         1O8EWlXBT5IBUMq9bdzPimHUvF2nKbyE+C7hqAYixq1g7QO0CX/HlrFv92QQ2DbGggQV
         ya4w==
X-Gm-Message-State: AAQBX9cEhOmryF8jCJGPEnn63Cd5sBxKyROM/EoZey0UmCANztOuV4Oj
        5AKBqDHa5RRxUmHBuWkVY/4=
X-Google-Smtp-Source: AKy350ZdUJyK8JP/ReZa/fg6Wim+Ll01XKaRn0Pz9pqvc966pGDJ2f+sEdAbnzPoAUnzFj0AOcjmQw==
X-Received: by 2002:a17:903:188:b0:1a9:2a9e:30a8 with SMTP id z8-20020a170903018800b001a92a9e30a8mr6228740plg.9.1682045491106;
        Thu, 20 Apr 2023 19:51:31 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id f21-20020a17090ace1500b002469a865810sm3630905pju.28.2023.04.20.19.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 19:51:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 22/22] workqueue: Don't implicitly make UNBOUND workqueues w/ @max_active==1 ordered
Date:   Thu, 20 Apr 2023 16:50:46 -1000
Message-Id: <20230421025046.4008499-23-tj@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421025046.4008499-1-tj@kernel.org>
References: <20230421025046.4008499-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
automoatically promoted UNBOUND workqueues w/ @max_active==1 to ordered
workqueues because UNBOUND workqueues w/ @max_active==1 used to be the way
to create ordered workqueues and the new NUMA support broke it. These
problems can be subtle and the fact that they can only trigger on NUMA
machines made them even more difficult to debug.

However, overloading the UNBOUND allocation interface this way creates other
issues. It's difficult to tell whether a given workqueue actually needs to
be ordered and users that legitimately want a min concurrency level wq
unexpectedly gets an ordered one instead. With planned UNBOUND workqueue
udpates to improve execution locality and more prevalence of chiplet designs
which can benefit from such improvements, this isn't a state we wanna be in
forever.

There aren't that many UNBOUND w/ @max_active==1 users in the tree and the
preceding patches audited all and converted them to
alloc_ordered_workqueue() as appropriate. This patch removes the implicit
promotion of UNBOUND w/ @max_active==1 workqueues to ordered ones.

Workqueue will also add a debug option to make all unordered UNBOUND
workqueues to use per-cpu pool_workqueues so that these problems can be
surfaced easier on most machines.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
---
 include/linux/workqueue.h |  4 +---
 kernel/workqueue.c        | 23 ++++-------------------
 2 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index ac551b8ee7d9..e547a90f0328 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -339,7 +339,6 @@ enum {
 	__WQ_DRAINING		= 1 << 16, /* internal: workqueue is draining */
 	__WQ_ORDERED		= 1 << 17, /* internal: workqueue is ordered */
 	__WQ_LEGACY		= 1 << 18, /* internal: create*_workqueue() */
-	__WQ_ORDERED_EXPLICIT	= 1 << 19, /* internal: alloc_ordered_workqueue() */
 
 	WQ_MAX_ACTIVE		= 512,	  /* I like 512, better ideas? */
 	WQ_MAX_UNBOUND_PER_CPU	= 4,	  /* 4 * #cpus for unbound wq */
@@ -417,8 +416,7 @@ alloc_workqueue(const char *fmt, unsigned int flags, int max_active, ...);
  * Pointer to the allocated workqueue on success, %NULL on failure.
  */
 #define alloc_ordered_workqueue(fmt, flags, args...)			\
-	alloc_workqueue(fmt, WQ_UNBOUND | __WQ_ORDERED |		\
-			__WQ_ORDERED_EXPLICIT | (flags), 1, ##args)
+	alloc_workqueue(fmt, WQ_UNBOUND | __WQ_ORDERED | (flags), 1, ##args)
 
 #define create_workqueue(name)						\
 	alloc_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, 1, (name))
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b8b541caed48..00bdcc3c5b36 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4180,12 +4180,8 @@ static int apply_workqueue_attrs_locked(struct workqueue_struct *wq,
 		return -EINVAL;
 
 	/* creating multiple pwqs breaks ordering guarantee */
-	if (!list_empty(&wq->pwqs)) {
-		if (WARN_ON(wq->flags & __WQ_ORDERED_EXPLICIT))
-			return -EINVAL;
-
-		wq->flags &= ~__WQ_ORDERED;
-	}
+	if (WARN_ON(wq->flags & __WQ_ORDERED))
+		return -EINVAL;
 
 	ctx = apply_wqattrs_prepare(wq, attrs, wq_unbound_cpumask);
 	if (!ctx)
@@ -4408,16 +4404,6 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	struct workqueue_struct *wq;
 	struct pool_workqueue *pwq;
 
-	/*
-	 * Unbound && max_active == 1 used to imply ordered, which is no
-	 * longer the case on NUMA machines due to per-node pools.  While
-	 * alloc_ordered_workqueue() is the right way to create an ordered
-	 * workqueue, keep the previous behavior to avoid subtle breakages
-	 * on NUMA.
-	 */
-	if ((flags & WQ_UNBOUND) && max_active == 1)
-		flags |= __WQ_ORDERED;
-
 	/* see the comment above the definition of WQ_POWER_EFFICIENT */
 	if ((flags & WQ_POWER_EFFICIENT) && wq_power_efficient)
 		flags |= WQ_UNBOUND;
@@ -4625,14 +4611,13 @@ void workqueue_set_max_active(struct workqueue_struct *wq, int max_active)
 	struct pool_workqueue *pwq;
 
 	/* disallow meddling with max_active for ordered workqueues */
-	if (WARN_ON(wq->flags & __WQ_ORDERED_EXPLICIT))
+	if (WARN_ON(wq->flags & __WQ_ORDERED))
 		return;
 
 	max_active = wq_clamp_max_active(max_active, wq->flags, wq->name);
 
 	mutex_lock(&wq->mutex);
 
-	wq->flags &= ~__WQ_ORDERED;
 	wq->saved_max_active = max_active;
 
 	for_each_pwq(pwq, wq)
@@ -5868,7 +5853,7 @@ int workqueue_sysfs_register(struct workqueue_struct *wq)
 	 * attributes breaks ordering guarantee.  Disallow exposing ordered
 	 * workqueues.
 	 */
-	if (WARN_ON(wq->flags & __WQ_ORDERED_EXPLICIT))
+	if (WARN_ON(wq->flags & __WQ_ORDERED))
 		return -EINVAL;
 
 	wq->wq_dev = wq_dev = kzalloc(sizeof(*wq_dev), GFP_KERNEL);
-- 
2.40.0

