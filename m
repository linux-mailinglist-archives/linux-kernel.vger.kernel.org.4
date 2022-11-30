Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A9163DD14
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiK3SWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiK3SV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:21:28 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2048D65A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:20:06 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id t62so19626044oib.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vdp4j6kiy4UQZim4jGenqW5cdZeKNZUSFB293OPsKw4=;
        b=mAMq4T/gP9VcyGraToL3Nre1HYLcFBZ4FbRuIAZX2RXsBbLAfM+rzDZNmEB1G040Id
         cxtni1Wm7EGLVeYc1deX2HHYf0AFBvKl8C0SyW23CdBuu5uZao/XoeyG4dG0ncsIcvzD
         HZ4xcobLS8wW1jOBMQ9Q5FrlsXaGAR3IFpZ1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vdp4j6kiy4UQZim4jGenqW5cdZeKNZUSFB293OPsKw4=;
        b=lRBjKh8IoleON9QKnxHSmukvPmUwRfRPzSx6HJMLD+ClIk3e9EkZlOPYeC2WKi35o0
         IdfUQNZ4M5kw1DcKA/zxFa+c3L2FtEAPtRmkAzki4HRfgedncGjE2rjizegF5ZyZe0Rl
         Y3LTDZ5p0J3kLoT6QEkhdobYRU8rpdW2ZaJZ86sJ2zVLrVfjlRbZkdqnqB7vC93n0i3p
         B6Arg1mviZq3/3jAY47jOG0woTVbasWtKu21hLjKDkysPdtlQRilhY0dcK8Br2zDgIPz
         2vPWDMiFI6k+nChk8hatL2OOsB0dxDVhBhZyxjS4E4PS8ifVaIR8lJzr5pEa6Y+9jUvD
         HVPw==
X-Gm-Message-State: ANoB5plDiz2bpzMxi/LwD9Nx4lgwweXpodTx6HKoLFXVovt+dceokYjA
        IzO4wlVzLdKylVtefjm0KU48xd2rfnkqPJQE+kV2Jg==
X-Google-Smtp-Source: AA0mqf5sSvtaWTm2pchCNoKTpXWdWxaMgcb6sK6DTCzJV41ofLpiVL6MLm8SxjiIxRU+GiI+YWEzkPB6FcPNwfijHl0=
X-Received: by 2002:a05:6808:1a09:b0:354:4a36:aa32 with SMTP id
 bk9-20020a0568081a0900b003544a36aa32mr32442745oib.15.1669832405979; Wed, 30
 Nov 2022 10:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20221130181316.GA1012431@paulmck-ThinkPad-P17-Gen-1> <20221130181325.1012760-12-paulmck@kernel.org>
In-Reply-To: <20221130181325.1012760-12-paulmck@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 30 Nov 2022 18:19:55 +0000
Message-ID: <CAEXW_YTZO1eZLpL-Rth_55n_iKJv3xthJdy1vpYRmj+=MfZHFw@mail.gmail.com>
Subject: Re: [PATCH rcu 12/16] percpu-refcount: Use call_rcu_hurry() for
 atomic switch
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

Could you give your ACK for this patch, for percpu refcount? The API
is renamed like in the workqueue one, as well.

Thanks a lot,

- Joel


On Wed, Nov 30, 2022 at 6:13 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
>
> Earlier commits in this series allow battery-powered systems to build
> their kernels with the default-disabled CONFIG_RCU_LAZY=y Kconfig option.
> This Kconfig option causes call_rcu() to delay its callbacks in order to
> batch callbacks.  This means that a given RCU grace period covers more
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
> And another call_rcu() instance that cannot be lazy is the one on the
> percpu refcounter's "per-CPU to atomic switch" code path, which
> uses RCU when switching to atomic mode.  The enqueued callback
> wakes up waiters waiting in the percpu_ref_switch_waitq.  Allowing
> this callback to be lazy would result in unacceptable slowdowns for
> users of per-CPU refcounts, such as blk_pre_runtime_suspend().
>
> Therefore, make __percpu_ref_switch_to_atomic() use call_rcu_hurry()
> in order to revert to the old behavior.
>
> [ paulmck: Apply s/call_rcu_flush/call_rcu_hurry/ feedback from Tejun Heo. ]
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: <linux-mm@kvack.org>
> ---
>  lib/percpu-refcount.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
> index e5c5315da2741..668f6aa6a75de 100644
> --- a/lib/percpu-refcount.c
> +++ b/lib/percpu-refcount.c
> @@ -230,7 +230,8 @@ static void __percpu_ref_switch_to_atomic(struct percpu_ref *ref,
>                 percpu_ref_noop_confirm_switch;
>
>         percpu_ref_get(ref);    /* put after confirmation */
> -       call_rcu(&ref->data->rcu, percpu_ref_switch_to_atomic_rcu);
> +       call_rcu_hurry(&ref->data->rcu,
> +                      percpu_ref_switch_to_atomic_rcu);
>  }
>
>  static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
> --
> 2.31.1.189.g2e36527f23
>
