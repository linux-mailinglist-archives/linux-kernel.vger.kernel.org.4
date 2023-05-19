Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB45708CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjESATh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjESAS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:18:57 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891C11BDA
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:34 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2532d6c7ef2so208373a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455499; x=1687047499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXVXGsiUJa4numQNGqAjT1/ei0l1/pJh5Uz74De66ug=;
        b=nWBVxqSDQEg2N/y5Gt5BtJaS7uzOHTO9qdA79n5BDm++iNoUmSf4Zm5PKGoOKg5R9x
         6smHff3+YmSM4/5i4QSrkE3BHdYqVWGpQTM6gjtdFNg0tDxHSEKzVnMrfw01elzYhJWW
         1hk43D2jNaMU7fTs0E2txKSKqeq0aAIcqZ3oXGpmoz6mRbsrLX3KtkVvOTIn+aqIsJdP
         cA9q5pZhGL+K5neayr2FL9vF6Yy8SCQGEyOkJghzo7MW7oxXZp1G25knq2mwlFwZSyAj
         yl9aaX1iLK7mcokdEi+E0B/7/eEg2MD08WtSlzef7LKVo5yi2I9FWS27X/Zaum45ha1e
         HP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455499; x=1687047499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XXVXGsiUJa4numQNGqAjT1/ei0l1/pJh5Uz74De66ug=;
        b=Xa7xyRqj96zfJusWNKtL1AxyIq/qCmW8NxUeMvCR80g3SSyCVdMMxXdEB1zazzYpBD
         ZYw4u+urA1SglKEctvMl0lF3EoMDjEQlbTh669hAGddXv6qXQBEXsrwlAS6LtMkhr6Tr
         vRn+e10WRVlHJj/wbFdPeCAkz2xjy6/DZCwGZLbJEsBmXwyr+hHgcULfO3oR/r6Fa3N3
         6IOgjN3k8BenhDTEOrKETt5CVGcOrPakjLIteM7+AjjZpBd9/+bZBVwZOpAaIwF/hztj
         onCB+QOsn/oXa320hhJ8FMhGvFQf1AhWgFbnQFWAKQ5EvQgXx5ImYeN/zRKdCcdzRzBg
         RA8A==
X-Gm-Message-State: AC+VfDypHkFtcOMK66FNojKyGSEGl30BJ4q6wCcrJRFXl96l6xezNv2N
        4KLRZ6pWEpafAfd6yVHWmfY=
X-Google-Smtp-Source: ACHHUZ6h3SswNsqfb8hastWH+OOq6fCxnGHroW+RkGaEQbWkI3SsCkj4Pxo8VqYcQ4soVJyyxl3ZFw==
X-Received: by 2002:a17:90a:3186:b0:252:7372:460c with SMTP id j6-20020a17090a318600b002527372460cmr946441pjb.4.1684455499325;
        Thu, 18 May 2023 17:18:19 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090acc0800b00253508d9145sm230910pju.46.2023.05.18.17.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:18:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 23/24] workqueue: Add pool_workqueue->cpu
Date:   Thu, 18 May 2023 14:17:08 -1000
Message-Id: <20230519001709.2563-24-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519001709.2563-1-tj@kernel.org>
References: <20230519001709.2563-1-tj@kernel.org>
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

For both per-cpu and unbound workqueues, pwq's (pool_workqueue's) are
per-cpu. For per-cpu workqueues, we can find out the associated CPU from
pwq->pool->cpu but unbound pools don't have specific CPUs associated. Let's
add pwq->cpu so that given an unbound work item, we can determine which CPU
it was queued on through get_work_pwq(work)->cpu.

This will be used to improve execution locality on unbound workqueues.

NOT_FOR_UPSTREAM
---
 kernel/workqueue.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3ce4c18e139c..4efb0bd6f2e0 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -226,6 +226,7 @@ enum pool_workqueue_stats {
 struct pool_workqueue {
 	struct worker_pool	*pool;		/* I: the associated pool */
 	struct workqueue_struct *wq;		/* I: the owning workqueue */
+	int			cpu;		/* I: the associated CPU */
 	int			work_color;	/* L: current color */
 	int			flush_color;	/* L: flushing color */
 	int			refcnt;		/* L: reference count */
@@ -4131,7 +4132,7 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)
 
 /* initialize newly allocated @pwq which is associated with @wq and @pool */
 static void init_pwq(struct pool_workqueue *pwq, struct workqueue_struct *wq,
-		     struct worker_pool *pool)
+		     struct worker_pool *pool, int cpu)
 {
 	BUG_ON((unsigned long)pwq & WORK_STRUCT_FLAG_MASK);
 
@@ -4139,6 +4140,7 @@ static void init_pwq(struct pool_workqueue *pwq, struct workqueue_struct *wq,
 
 	pwq->pool = pool;
 	pwq->wq = wq;
+	pwq->cpu = cpu;
 	pwq->flush_color = -1;
 	pwq->refcnt = 1;
 	INIT_LIST_HEAD(&pwq->inactive_works);
@@ -4169,8 +4171,9 @@ static void link_pwq(struct pool_workqueue *pwq)
 }
 
 /* obtain a pool matching @attr and create a pwq associating the pool and @wq */
-static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
-					const struct workqueue_attrs *attrs)
+static struct pool_workqueue *
+alloc_unbound_pwq(struct workqueue_struct *wq,
+		  const struct workqueue_attrs *attrs, int cpu)
 {
 	struct worker_pool *pool;
 	struct pool_workqueue *pwq;
@@ -4187,7 +4190,7 @@ static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
 		return NULL;
 	}
 
-	init_pwq(pwq, wq, pool);
+	init_pwq(pwq, wq, pool, cpu);
 	return pwq;
 }
 
@@ -4313,7 +4316,7 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 	 * the default pwq covering whole @attrs->cpumask.  Always create
 	 * it even if we don't use it immediately.
 	 */
-	ctx->dfl_pwq = alloc_unbound_pwq(wq, new_attrs);
+	ctx->dfl_pwq = alloc_unbound_pwq(wq, new_attrs, -1);
 	if (!ctx->dfl_pwq)
 		goto out_free;
 
@@ -4323,7 +4326,7 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 			ctx->pwq_tbl[cpu] = ctx->dfl_pwq;
 		} else {
 			wq_calc_pod_cpumask(new_attrs, cpu, -1);
-			ctx->pwq_tbl[cpu] = alloc_unbound_pwq(wq, new_attrs);
+			ctx->pwq_tbl[cpu] = alloc_unbound_pwq(wq, new_attrs, cpu);
 			if (!ctx->pwq_tbl[cpu])
 				goto out_free;
 		}
@@ -4486,7 +4489,7 @@ static void wq_update_pod(struct workqueue_struct *wq, int cpu, bool online)
 		return;
 
 	/* create a new pwq */
-	pwq = alloc_unbound_pwq(wq, target_attrs);
+	pwq = alloc_unbound_pwq(wq, target_attrs, cpu);
 	if (!pwq) {
 		pr_warn("workqueue: allocation failed while updating CPU pod affinity of \"%s\"\n",
 			wq->name);
@@ -4530,7 +4533,7 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 			if (!*pwq_p)
 				goto enomem;
 
-			init_pwq(*pwq_p, wq, pool);
+			init_pwq(*pwq_p, wq, pool, cpu);
 
 			mutex_lock(&wq->mutex);
 			link_pwq(*pwq_p);
-- 
2.40.1

