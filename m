Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5767C708CC0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjESAS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjESASI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:18:08 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDED1988
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:17:55 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64359d9c531so1947235b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455475; x=1687047475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1m2+L6s6yTedlkjGRtkdmOBtMzjsPpC6Q11Fk73V9E=;
        b=ibTQQrziO1HNqoksVze8jV/WZuIGym6k/RLnUFRkvzC1FYNlJeiEOTRiWCdSMubNDu
         lxX/pIMyF1HqpVh3CZXV+NjiTwIAcPlEL6hLCYF10XCwMHm6UNhvg+m/nY9HE1y9Wcdw
         +8EUhwswORXeV9h+4gfOr+X2qS1apCB6RsuanebrMok7o8nGcyUwTquNnAPFlQ9KEkHi
         o+OudO3nB5sNtF+AOm3MSOE9fjE80UwRQ4rcRBwOGr20AOM5FP0nQpr1nefu8viU3zNr
         PeQa7YrFYGokalIXNQF2ZW8VqU6RKil9inL+pY0CE6NAzug7zLDKdCpwZ1Cyp/5pPOvE
         wr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455475; x=1687047475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l1m2+L6s6yTedlkjGRtkdmOBtMzjsPpC6Q11Fk73V9E=;
        b=QwURebL58u3e12TMu+vRxIQNrC35jDzws1SOCf2Vu/7ICqax8d50peWSI0ya90f2Xt
         c3wjMosAHy03oF9pYO5hmTxchMBjQ7xqBFY/B6EuJiH92VuDk35pul8IYLHFQpKqbRVj
         PLwjBDrzzRUT3XVyRGcEFIqEBiYLO4plR3pgAingD+wUNaQbe9zGbufFXayxXj1DZyLS
         SrADPmNCN0vJcYMyDQKkUEQ3rXgmnMIBkYCTthwQejDWwvGbiOSGQwLCOpkVPi1Fy9zA
         4ElyX/+bVbNOeOMN+x3w2GgzbzDxEt7LbaXrgslh07ZXT/YqDught8y+TuVdhNjZdHQU
         pxqw==
X-Gm-Message-State: AC+VfDz8gcUJGMPES+7DxX+Gc9hqmXxtN+l3ZmwHdH3TmKubNqGpLVPV
        TKXLFLcAcMiUAoRRGWGSQQE=
X-Google-Smtp-Source: ACHHUZ75xkX9BnYEirZjqO1/hpiWVaDpSom0xHHr7RCch76aX+7Rsq3wEFcycvOwXa886iwQT/LQSg==
X-Received: by 2002:a05:6a00:218a:b0:643:558d:9ce2 with SMTP id h10-20020a056a00218a00b00643558d9ce2mr804173pfi.21.1684455474923;
        Thu, 18 May 2023 17:17:54 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y11-20020a62b50b000000b00646e7d2b5a7sm1854752pfe.112.2023.05.18.17.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:17:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 10/24] workqueue: Rename workqueue_attrs->no_numa to ->ordered
Date:   Thu, 18 May 2023 14:16:55 -1000
Message-Id: <20230519001709.2563-11-tj@kernel.org>
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

With the recent removal of NUMA related module param and sysfs knob,
workqueue_attrs->no_numa is now only used to implement ordered workqueues.
Let's rename the field so that it's less confusing especially with the
planned CPU affinity awareness improvements.

Just a rename. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/workqueue.h |  6 +++---
 kernel/workqueue.c        | 19 +++++++++----------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index d1b681f67985..8cc9b86d3256 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -141,13 +141,13 @@ struct workqueue_attrs {
 	cpumask_var_t cpumask;
 
 	/**
-	 * @no_numa: disable NUMA affinity
+	 * @ordered: work items must be executed one by one in queueing order
 	 *
-	 * Unlike other fields, ``no_numa`` isn't a property of a worker_pool. It
+	 * Unlike other fields, ``ordered`` isn't a property of a worker_pool. It
 	 * only modifies how :c:func:`apply_workqueue_attrs` select pools and thus
 	 * doesn't participate in pool hash calculations or equality comparisons.
 	 */
-	bool no_numa;
+	bool ordered;
 };
 
 static inline struct delayed_work *to_delayed_work(struct work_struct *work)
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 43f3bb801bd9..6a5d227949d9 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3653,10 +3653,10 @@ static void copy_workqueue_attrs(struct workqueue_attrs *to,
 	cpumask_copy(to->cpumask, from->cpumask);
 	/*
 	 * Unlike hash and equality test, this function doesn't ignore
-	 * ->no_numa as it is used for both pool and wq attrs.  Instead,
-	 * get_unbound_pool() explicitly clears ->no_numa after copying.
+	 * ->ordered as it is used for both pool and wq attrs.  Instead,
+	 * get_unbound_pool() explicitly clears ->ordered after copying.
 	 */
-	to->no_numa = from->no_numa;
+	to->ordered = from->ordered;
 }
 
 /* hash value of the content of @attr */
@@ -3916,10 +3916,10 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
 	pool->node = target_node;
 
 	/*
-	 * no_numa isn't a worker_pool attribute, always clear it.  See
+	 * ordered isn't a worker_pool attribute, always clear it.  See
 	 * 'struct workqueue_attrs' comments for detail.
 	 */
-	pool->attrs->no_numa = false;
+	pool->attrs->ordered = false;
 
 	if (worker_pool_assign_id(pool) < 0)
 		goto fail;
@@ -4124,7 +4124,7 @@ static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
 static void wq_calc_node_cpumask(const struct workqueue_attrs *attrs, int node,
 				 int cpu_going_down, cpumask_t *cpumask)
 {
-	if (!wq_numa_enabled || attrs->no_numa)
+	if (!wq_numa_enabled || attrs->ordered)
 		goto use_dfl;
 
 	/* does @node have any online CPUs @attrs wants? */
@@ -4236,7 +4236,7 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 		goto out_free;
 
 	for_each_possible_cpu(cpu) {
-		if (new_attrs->no_numa) {
+		if (new_attrs->ordered) {
 			ctx->dfl_pwq->refcnt++;
 			ctx->pwq_tbl[cpu] = ctx->dfl_pwq;
 		} else {
@@ -4393,7 +4393,7 @@ static void wq_update_unbound_numa(struct workqueue_struct *wq, int cpu,
 	lockdep_assert_held(&wq_pool_mutex);
 
 	if (!wq_numa_enabled || !(wq->flags & WQ_UNBOUND) ||
-	    wq->unbound_attrs->no_numa)
+	    wq->unbound_attrs->ordered)
 		return;
 
 	/*
@@ -6323,11 +6323,10 @@ void __init workqueue_init_early(void)
 		/*
 		 * An ordered wq should have only one pwq as ordering is
 		 * guaranteed by max_active which is enforced by pwqs.
-		 * Turn off NUMA so that dfl_pwq is used for all nodes.
 		 */
 		BUG_ON(!(attrs = alloc_workqueue_attrs()));
 		attrs->nice = std_nice[i];
-		attrs->no_numa = true;
+		attrs->ordered = true;
 		ordered_wq_attrs[i] = attrs;
 	}
 
-- 
2.40.1

