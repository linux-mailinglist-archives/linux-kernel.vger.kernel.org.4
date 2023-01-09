Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1138662739
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbjAINfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbjAINe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:34:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864A71EECD
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 05:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673271220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZaDHq41SfAlEO/FEWzBquw15t81pf5rbinRD53jl+xU=;
        b=SCcjkEddG1ojWO09dsfd6XtUK/H0A4bWNBFVua0tlprWGv/iphcFHYHsSo3q5lItt1dC1c
        GXK9tholLi/wSGeLGefN5JV755Pro2HRcn2g+lQiEkS+IFonbrlco7i6PuIB9A5JmOzrGD
        jZVo1c6/qgQtfG/9XaCuG1RzvW1Kq74=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-RsS6eexYMW60mhY2Rmr8rQ-1; Mon, 09 Jan 2023 08:33:30 -0500
X-MC-Unique: RsS6eexYMW60mhY2Rmr8rQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACA141C068CA;
        Mon,  9 Jan 2023 13:33:29 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.33.36.188])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 30CBB492C3E;
        Mon,  9 Jan 2023 13:33:28 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v7 1/4] workqueue: Protects wq_unbound_cpumask with wq_pool_attach_mutex
Date:   Mon,  9 Jan 2023 13:33:13 +0000
Message-Id: <20230109133316.4026472-2-vschneid@redhat.com>
In-Reply-To: <20230109133316.4026472-1-vschneid@redhat.com>
References: <20230109133316.4026472-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

When unbind_workers() reads wq_unbound_cpumask to set the affinity of
freshly-unbound kworkers, it only holds wq_pool_attach_mutex. This isn't
sufficient as wq_unbound_cpumask is only protected by wq_pool_mutex.

Make wq_unbound_cpumask protected with wq_pool_attach_mutex and also
remove the need of temporary saved_cpumask.

Fixes: 10a5a651e3af ("workqueue: Restrict kworker in the offline CPU pool running on housekeeping CPUs")
Reported-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 07895deca2711..76ea87b0251ce 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -326,7 +326,7 @@ static struct rcuwait manager_wait = __RCUWAIT_INITIALIZER(manager_wait);
 static LIST_HEAD(workqueues);		/* PR: list of all workqueues */
 static bool workqueue_freezing;		/* PL: have wqs started freezing? */
 
-/* PL: allowable cpus for unbound wqs and work items */
+/* PL&A: allowable cpus for unbound wqs and work items */
 static cpumask_var_t wq_unbound_cpumask;
 
 /* CPU where unbound work was last round robin scheduled from this CPU */
@@ -3952,7 +3952,8 @@ static void apply_wqattrs_cleanup(struct apply_wqattrs_ctx *ctx)
 /* allocate the attrs and pwqs for later installation */
 static struct apply_wqattrs_ctx *
 apply_wqattrs_prepare(struct workqueue_struct *wq,
-		      const struct workqueue_attrs *attrs)
+		      const struct workqueue_attrs *attrs,
+		      const cpumask_var_t unbound_cpumask)
 {
 	struct apply_wqattrs_ctx *ctx;
 	struct workqueue_attrs *new_attrs, *tmp_attrs;
@@ -3968,14 +3969,15 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 		goto out_free;
 
 	/*
-	 * Calculate the attrs of the default pwq.
+	 * Calculate the attrs of the default pwq with unbound_cpumask
+	 * which is wq_unbound_cpumask or to set to wq_unbound_cpumask.
 	 * If the user configured cpumask doesn't overlap with the
 	 * wq_unbound_cpumask, we fallback to the wq_unbound_cpumask.
 	 */
 	copy_workqueue_attrs(new_attrs, attrs);
-	cpumask_and(new_attrs->cpumask, new_attrs->cpumask, wq_unbound_cpumask);
+	cpumask_and(new_attrs->cpumask, new_attrs->cpumask, unbound_cpumask);
 	if (unlikely(cpumask_empty(new_attrs->cpumask)))
-		cpumask_copy(new_attrs->cpumask, wq_unbound_cpumask);
+		cpumask_copy(new_attrs->cpumask, unbound_cpumask);
 
 	/*
 	 * We may create multiple pwqs with differing cpumasks.  Make a
@@ -4072,7 +4074,7 @@ static int apply_workqueue_attrs_locked(struct workqueue_struct *wq,
 		wq->flags &= ~__WQ_ORDERED;
 	}
 
-	ctx = apply_wqattrs_prepare(wq, attrs);
+	ctx = apply_wqattrs_prepare(wq, attrs, wq_unbound_cpumask);
 	if (!ctx)
 		return -ENOMEM;
 
@@ -5334,7 +5336,7 @@ void thaw_workqueues(void)
 }
 #endif /* CONFIG_FREEZER */
 
-static int workqueue_apply_unbound_cpumask(void)
+static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 {
 	LIST_HEAD(ctxs);
 	int ret = 0;
@@ -5350,7 +5352,7 @@ static int workqueue_apply_unbound_cpumask(void)
 		if (wq->flags & __WQ_ORDERED)
 			continue;
 
-		ctx = apply_wqattrs_prepare(wq, wq->unbound_attrs);
+		ctx = apply_wqattrs_prepare(wq, wq->unbound_attrs, unbound_cpumask);
 		if (!ctx) {
 			ret = -ENOMEM;
 			break;
@@ -5365,6 +5367,11 @@ static int workqueue_apply_unbound_cpumask(void)
 		apply_wqattrs_cleanup(ctx);
 	}
 
+	if (!ret) {
+		mutex_lock(&wq_pool_attach_mutex);
+		cpumask_copy(wq_unbound_cpumask, unbound_cpumask);
+		mutex_unlock(&wq_pool_attach_mutex);
+	}
 	return ret;
 }
 
@@ -5383,7 +5390,6 @@ static int workqueue_apply_unbound_cpumask(void)
 int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
 {
 	int ret = -EINVAL;
-	cpumask_var_t saved_cpumask;
 
 	/*
 	 * Not excluding isolated cpus on purpose.
@@ -5397,23 +5403,8 @@ int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
 			goto out_unlock;
 		}
 
-		if (!zalloc_cpumask_var(&saved_cpumask, GFP_KERNEL)) {
-			ret = -ENOMEM;
-			goto out_unlock;
-		}
-
-		/* save the old wq_unbound_cpumask. */
-		cpumask_copy(saved_cpumask, wq_unbound_cpumask);
-
-		/* update wq_unbound_cpumask at first and apply it to wqs. */
-		cpumask_copy(wq_unbound_cpumask, cpumask);
-		ret = workqueue_apply_unbound_cpumask();
-
-		/* restore the wq_unbound_cpumask when failed. */
-		if (ret < 0)
-			cpumask_copy(wq_unbound_cpumask, saved_cpumask);
+		ret = workqueue_apply_unbound_cpumask(cpumask);
 
-		free_cpumask_var(saved_cpumask);
 out_unlock:
 		apply_wqattrs_unlock();
 	}
-- 
2.31.1

