Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5897251C9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 03:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240592AbjFGBwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 21:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240632AbjFGBvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 21:51:51 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37A61BF3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 18:50:42 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-565eb83efe4so87683127b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 18:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686102642; x=1688694642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPx7Ne3yd4lv/xb5FbWV+NGodWH250aFCWbyJxGGksw=;
        b=KKQoy3VdsAFYGIsHGhIldfg5BDOBO0LwNN2Yk6JZI3rcxwiQumymRahtfFGUTz0bhG
         X0SUy8JwmK3MIlTjwoh4MAYURrJidIW1EG7MdaeeRE2eB8DanlP8Qmpa5gkR207AtvJg
         +j6zZXPePjXwXkBUmqJDFuo9US1Hdt1fwzzWAJLfM1gZilZbuaoyNwjXD0uwjkbZ7N05
         fOtqpqznGrgZ5iKgGy4+zyfizWZ4ZLWtgntQpT+ndLrOOBbywLLz/FrYulAAb0xWPLul
         JZh8Tevbn+ekGfMBrSgULv0mMdNsV5dVjB+XuRi6vJlVVZZ911uixECa67riBsbCOI53
         /hTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686102642; x=1688694642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPx7Ne3yd4lv/xb5FbWV+NGodWH250aFCWbyJxGGksw=;
        b=FRLRMYjuCXRSS/N3j7RsXzPIn733yxUSrBTTXa9Kud1/7oSerzqUBnuwiIxHXT7XRE
         g3GmlP3oYyuYThG5dh9VlcmKaQDjN/2K1I26Jd4IWtO1VwV5WZBx7gCmbUcWhvX97FmJ
         GSwcMfC4uBQz+qvCqyXQZj7Xf+691H30IQTvzPr0KgdOIxdyfBXbtwgX5vcHB3xF56ON
         h/6tWHjjoIA5+b9VKK4TRcPn3dtbmf88W05+sjgUjdx8xZ3E/htDy/IMTrTlabgQ52OI
         GVydyJVncWZ9uzbMitYI58Odj4zsdYMCTrD6KTn2FnDvl+4Le64SDmARSOCcne+3USw3
         yM/g==
X-Gm-Message-State: AC+VfDyrSR0rNGcEZ+uEnnY8qO7UGaYtASnWldlPJoX92W4kaxg6PFO5
        +KWaSaNnmXkema3fXJZBLp4=
X-Google-Smtp-Source: ACHHUZ4g4F297YV7GbnIWFS3xmGASHOSO39NOBNg5hjORyWt221e61r+aCDvb8BCEtrrr4CzSBu41w==
X-Received: by 2002:a5b:6c4:0:b0:bb2:ff31:b376 with SMTP id r4-20020a5b06c4000000b00bb2ff31b376mr4442376ybq.17.1686102641732;
        Tue, 06 Jun 2023 18:50:41 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902788500b001aaf536b1e3sm9151176pll.123.2023.06.06.18.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 18:50:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 6 Jun 2023 15:50:39 -1000
From:   Tejun Heo <tj@kernel.org>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     jiangshanlai@gmail.com, torvalds@linux-foundation.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, joshdon@google.com, brho@google.com,
        briannorris@chromium.org, nhuck@google.com, agk@redhat.com,
        snitzer@kernel.org, void@manifault.com
Subject: Re: [PATCH 14/24] workqueue: Generalize unbound CPU pods
Message-ID: <ZH_ib0TeWvzF9Kqg@slm.duckdns.org>
References: <20230519001709.2563-1-tj@kernel.org>
 <20230519001709.2563-15-tj@kernel.org>
 <30625cdd-4d61-594b-8db9-6816b017dde3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30625cdd-4d61-594b-8db9-6816b017dde3@amd.com>
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

Sorry about the delay. We moved last week and that ended up being a lot more
disruptive than I expected.

On Tue, May 30, 2023 at 01:36:13PM +0530, K Prateek Nayak wrote:
> I ran into a NULL pointer dereferencing issue when trying to test a build
> of the "affinity-scopes-v1" branch from your workqueue tree
> (https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/?h=affinity-scopes-v1)
> Inlining the splat, some debug details, and workaround I used below.
...
>     [    4.280321] BUG: kernel NULL pointer dereference, address: 0000000000000004
...
>     [    4.284172]  wq_update_pod+0x89/0x1e0
>     [    4.284172]  workqueue_online_cpu+0x1fc/0x250
>     [    4.284172]  cpuhp_invoke_callback+0x165/0x4b0
>     [    4.284172]  cpuhp_thread_fun+0xc4/0x1b0
>     [    4.284172]  smpboot_thread_fn+0xe7/0x1e0
>     [    4.284172]  kthread+0xfb/0x130
>     [    4.284172]  ret_from_fork+0x2c/0x50
>     [    4.284172]  </TASK>
>     [    4.284172] Modules linked in:
>     [    4.284172] CR2: 0000000000000004
>     [    4.284172] ---[ end trace 0000000000000000 ]---
> 
> I was basically hitting the following, seemingly impossible scenario in
> wqattrs_pod_type():
> 
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -3825,8 +3825,10 @@ wqattrs_pod_type(const struct workqueue_attrs *attrs)
>  {
>         struct wq_pod_type *pt = &wq_pod_types[attrs->affn_scope];
> 
> -       if (likely(pt->nr_pods))
> +       if (likely(pt->nr_pods)) {
> +               BUG_ON(!pt->cpu_pod); /* No pods despite thinking we have? */
>                 return pt;
> +       }
> 
>         /*
>          * Before workqueue_init_topology(), only SYSTEM is available which is
> --
> 
> Logging the value of "attrs->affn_scope" when hitting the scenario gave
> me "5" which corresponds to "WQ_AFFN_NR_TYPES". The kernel was reading a
> value beyond the wq_pod_types[] bounds.
> 
> This value for "affn_scope" is only set in the above hunk and I got the
> kernel to boot by making the following change:
> 
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -4069,7 +4071,7 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
>         pool->node = node;
> 
>         /* clear wq-only attr fields. See 'struct workqueue_attrs' comments */
> -       pool->attrs->affn_scope = WQ_AFFN_NR_TYPES;
> +       pool->attrs->affn_scope = wq_affn_dfl;
>         pool->attrs->localize = false;
>         pool->attrs->ordered = false;

I see. The code is a bit too subtle. wq_update_pod() is abusing dfl_pwq's
attrs to access its wq_unbound_cpumask filtered cpumask but
wqattrs_pod_type() now expects to (rightfully) get the attrs of the
workqueue in question, not its dfl_pwq's.

A proper fix follows. This goes right before
0014-workqueue-Generalize-unbound-CPU-pods.patch. Some of the subsequent
patches need to be updated. I'll post an updated patch series later.

Thanks.

From: Tejun Heo <tj@kernel.org>
Subject: workqueue: Factor out actual cpumask calculation to reduce subtlety in wq_update_pod()

For an unbound pool, multiple cpumasks are involved.

U: The user-specified cpumask (may be filtered with cpu_possible_mask).

A: The actual cpumask filtered by wq_unbound_cpumask. If the filtering
   leaves no CPU, wq_unbound_cpumask is used.

P: Per-pod subsets of #A.

wq->attrs stores #U, wq->dfl_pwq->pool->attrs->cpumask #A, and
wq->cpu_pwq[CPU]->pool->attrs->cpumask #P.

wq_update_pod() is called to update per-pod pwq's during CPU hotplug. To
calculate the new #P for each workqueue, it needs to call
wq_calc_pod_cpumask() with @attrs that contains #A. Currently,
wq_update_pod() achieves this by calling wq_calc_pod_cpumask() with
wq->dfl_pwq->pool->attrs.

This is rather fragile because we're calling wq_calc_pod_cpumask() with
@attrs of a worker_pool rather than the workqueue's actual attrs when what
we want to calculate is the workqueue's cpumask on the pod. While this works
fine currently, future changes will add fields which are used differently
between workqueues and worker_pools and this subtlety will bite us.

This patch factors out #U -> #A calculation from apply_wqattrs_prepare()
into wqattrs_actualize_cpumask and updates wq_update_pod() to copy
wq->unbound_attrs and use the new helper to obtain #A freshly instead of
abusing wq->dfl_pwq->pool_attrs.

This shouldn't cause any behavior changes in the current code.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reference: http://lkml.kernel.org/r/30625cdd-4d61-594b-8db9-6816b017dde3@amd.com
---
 kernel/workqueue.c |   43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3681,6 +3681,20 @@ static bool wqattrs_equal(const struct w
 	return true;
 }
 
+/* Update @attrs with actually available CPUs */
+static void wqattrs_actualize_cpumask(struct workqueue_attrs *attrs,
+				      const cpumask_t *unbound_cpumask)
+{
+	/*
+	 * Calculate the effective CPU mask of @attrs given @unbound_cpumask. If
+	 * @attrs->cpumask doesn't overlap with @unbound_cpumask, we fallback to
+	 * @unbound_cpumask.
+	 */
+	cpumask_and(attrs->cpumask, attrs->cpumask, unbound_cpumask);
+	if (unlikely(cpumask_empty(attrs->cpumask)))
+		cpumask_copy(attrs->cpumask, unbound_cpumask);
+}
+
 /**
  * init_worker_pool - initialize a newly zalloc'd worker_pool
  * @pool: worker_pool to initialize
@@ -4206,32 +4220,22 @@ apply_wqattrs_prepare(struct workqueue_s
 		goto out_free;
 
 	/*
-	 * Calculate the attrs of the default pwq with unbound_cpumask
-	 * which is wq_unbound_cpumask or to set to wq_unbound_cpumask.
-	 * If the user configured cpumask doesn't overlap with the
-	 * wq_unbound_cpumask, we fallback to the wq_unbound_cpumask.
-	 */
-	copy_workqueue_attrs(new_attrs, attrs);
-	cpumask_and(new_attrs->cpumask, new_attrs->cpumask, unbound_cpumask);
-	if (unlikely(cpumask_empty(new_attrs->cpumask)))
-		cpumask_copy(new_attrs->cpumask, unbound_cpumask);
-
-	/*
-	 * We may create multiple pwqs with differing cpumasks.  Make a
-	 * copy of @new_attrs which will be modified and used to obtain
-	 * pools.
-	 */
-	copy_workqueue_attrs(tmp_attrs, new_attrs);
-
-	/*
 	 * If something goes wrong during CPU up/down, we'll fall back to
 	 * the default pwq covering whole @attrs->cpumask.  Always create
 	 * it even if we don't use it immediately.
 	 */
+	copy_workqueue_attrs(new_attrs, attrs);
+	wqattrs_actualize_cpumask(new_attrs, unbound_cpumask);
 	ctx->dfl_pwq = alloc_unbound_pwq(wq, new_attrs);
 	if (!ctx->dfl_pwq)
 		goto out_free;
 
+	/*
+	 * We may create multiple pwqs with differing cpumasks. Make a copy of
+	 * @new_attrs which will be modified and used to obtain pools.
+	 */
+	copy_workqueue_attrs(tmp_attrs, new_attrs);
+
 	for_each_possible_cpu(cpu) {
 		if (new_attrs->ordered) {
 			ctx->dfl_pwq->refcnt++;
@@ -4398,9 +4402,10 @@ static void wq_update_pod(struct workque
 	cpumask = target_attrs->cpumask;
 
 	copy_workqueue_attrs(target_attrs, wq->unbound_attrs);
+	wqattrs_actualize_cpumask(target_attrs, wq_unbound_cpumask);
 
 	/* nothing to do if the target cpumask matches the current pwq */
-	wq_calc_pod_cpumask(wq->dfl_pwq->pool->attrs, pod, cpu_off, cpumask);
+	wq_calc_pod_cpumask(target_attrs, pod, cpu_off, cpumask);
 	pwq = rcu_dereference_protected(*per_cpu_ptr(wq->cpu_pwq, cpu),
 					lockdep_is_held(&wq_pool_mutex));
 	if (cpumask_equal(cpumask, pwq->pool->attrs->cpumask))
