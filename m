Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7287863DD05
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiK3SUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiK3SU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:20:29 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A99689AEC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:18:42 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-142306beb9aso21964961fac.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N3+c1ZdCSilgW+SSx6tvWsc7wbKwFqHqee+YfZqL2GM=;
        b=mAWZXY/A192EartorULkeCHGOmKFBQ73IUk+1E5UsC+TbeEtcZo/nYCqGt84k2RRAt
         zHS6sfnkOJHEqJXYTjpJagy4bzYkIpARSy7LwK1dD3fQ0Nt8UysOk9UrG7yvo7g2oBAt
         hEVGa+ziCxfutgcHURBeubf6PGRO8786ArcHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3+c1ZdCSilgW+SSx6tvWsc7wbKwFqHqee+YfZqL2GM=;
        b=s7bN4L5HRBDxTihE9XCB3u0GCsoXWH0uDtA5mHKPtbgPAYMTw6u2gmhmzvZQAql9Bk
         tkJ9aezNmsN75w6BGHBXLmCKnJXjmaSd7Cz+qMUshj5DGkalyUiNuVFGDvdRUgSEAIsL
         NTEUgBgQ0QPT9t5jyGrxFm79XY9ZjLVjfKK9wc6aE8lhXsM5wR6FHUgpOFqQW05fMdU+
         YfdXZgZYE376VhA4K9zqQumy9qf/nPQa3AZN8eEoyGhMbDtfc+ZoaB3wSlLiKdT+fvog
         kZWR2cNS5dJVLE/rinwqtW9BoS7H9+uynj5S2RJ0a2VSZwiOl+8hxWa8ITh259M9+tqF
         KIlw==
X-Gm-Message-State: ANoB5plOGEGqQk6zIHPtD/j+lz9x8Duy1v+9sjrwrbDoewXavMEBjSbM
        P1KgRuOheIMBd8X68ixfToHWZ6rZnFjp3Ygoy/6LTg==
X-Google-Smtp-Source: AA0mqf6ZZIpTDZ0KvdCBVoNn5gchzeQC2bhZoT/xlZWxEXVoPE7NXWJbjZNKarLlQlS31ASGH5wfRwuMpfridO5YjbQ=
X-Received: by 2002:a05:6870:bacb:b0:13a:dd16:9b83 with SMTP id
 js11-20020a056870bacb00b0013add169b83mr37605798oab.15.1669832321389; Wed, 30
 Nov 2022 10:18:41 -0800 (PST)
MIME-Version: 1.0
References: <20221130181316.GA1012431@paulmck-ThinkPad-P17-Gen-1> <20221130181325.1012760-13-paulmck@kernel.org>
In-Reply-To: <20221130181325.1012760-13-paulmck@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 30 Nov 2022 18:18:30 +0000
Message-ID: <CAEXW_YRV8tDyTtEVDhO3_DvnAp10HFr3vkcAnCecGqQYtKNP3Q@mail.gmail.com>
Subject: Re: [PATCH rcu 13/16] workqueue: Make queue_rcu_work() use call_rcu_hurry()
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Uladzislau Rezki <urezki@gmail.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

The API is renamed to call_rcu_hurry() as you and Paul discussed, to
avoid conflicts with the word flush. Could you give your ACK for this
patch, for workqueue?

Thanks a lot,

- Joel

On Wed, Nov 30, 2022 at 6:13 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> From: Uladzislau Rezki <urezki@gmail.com>
>
> Earlier commits in this series allow battery-powered systems to build
> their kernels with the default-disabled CONFIG_RCU_LAZY=y Kconfig option.
> This Kconfig option causes call_rcu() to delay its callbacks in order
> to batch them.  This means that a given RCU grace period covers more
> callbacks, thus reducing the number of grace periods, in turn reducing
> the amount of energy consumed, which increases battery lifetime which
> can be a very good thing.  This is not a subtle effect: In some important
> use cases, the battery lifetime is increased by more than 10%.
>
> This CONFIG_RCU_LAZY=y option is available only for CPUs that offload
> callbacks, for example, CPUs mentioned in the rcu_nocbs kernel boot
> parameter passed to kernels built with CONFIG_RCU_NOCB_CPU=y.
>
> Delaying callbacks is normally not a problem because most callbacks do
> nothing but free memory.  If the system is short on memory, a shrinker
> will kick all currently queued lazy callbacks out of their laziness,
> thus freeing their memory in short order.  Similarly, the rcu_barrier()
> function, which blocks until all currently queued callbacks are invoked,
> will also kick lazy callbacks, thus enabling rcu_barrier() to complete
> in a timely manner.
>
> However, there are some cases where laziness is not a good option.
> For example, synchronize_rcu() invokes call_rcu(), and blocks until
> the newly queued callback is invoked.  It would not be a good for
> synchronize_rcu() to block for ten seconds, even on an idle system.
> Therefore, synchronize_rcu() invokes call_rcu_hurry() instead of
> call_rcu().  The arrival of a non-lazy call_rcu_hurry() callback on a
> given CPU kicks any lazy callbacks that might be already queued on that
> CPU.  After all, if there is going to be a grace period, all callbacks
> might as well get full benefit from it.
>
> Yes, this could be done the other way around by creating a
> call_rcu_lazy(), but earlier experience with this approach and
> feedback at the 2022 Linux Plumbers Conference shifted the approach
> to call_rcu() being lazy with call_rcu_hurry() for the few places
> where laziness is inappropriate.
>
> And another call_rcu() instance that cannot be lazy is the one
> in queue_rcu_work(), given that callers to queue_rcu_work() are
> not necessarily OK with long delays.
>
> Therefore, make queue_rcu_work() use call_rcu_hurry() in order to revert
> to the old behavior.
>
> [ paulmck: Apply s/call_rcu_flush/call_rcu_hurry/ feedback from Tejun Heo. ]
>
> Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/workqueue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 7cd5f5e7e0a1b..07895deca2711 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1771,7 +1771,7 @@ bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
>
>         if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
>                 rwork->wq = wq;
> -               call_rcu(&rwork->rcu, rcu_work_rcufn);
> +               call_rcu_hurry(&rwork->rcu, rcu_work_rcufn);
>                 return true;
>         }
>
> --
> 2.31.1.189.g2e36527f23
>
