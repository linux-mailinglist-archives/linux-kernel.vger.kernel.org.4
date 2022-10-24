Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61EF609F56
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJXKuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJXKty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:49:54 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEA622BD4;
        Mon, 24 Oct 2022 03:49:52 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a29so16079160lfo.1;
        Mon, 24 Oct 2022 03:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zja/Cz2UNdEAT2UerRwGcdXhwOP4DGiqzZVhukFpGEc=;
        b=iSaWbSmP5q4Bg9r9NNGlpO/ZBh8z1SNuKqE8j/tuv2bIKbPiwQmq3MacI2kaVoXgEg
         nQWePWWhS931CwQQ7ATmDnka9lU6VpeZYV4DEXAJLCOu5LbdRaOUHk4Pb+U7qae/VRZb
         rj/8MDN4ryPmKjKtGUvhmD4TdFWTjE0l0PBXM+fHwLuFAlnrdxMxWKCul253ReeEM1QT
         gIwo2f0IPcyfuLEXeWzRCCXJLTL+eSBpiOzpixpwFwmrBoTXeJlGwj8fIwLsYN96IxPu
         Hnb8MbneBY9WTkVFB+srk+ppW8rjmQLQyTvKIvUX3ss5V81939BWE4Q4BqphSK094U9g
         a3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zja/Cz2UNdEAT2UerRwGcdXhwOP4DGiqzZVhukFpGEc=;
        b=0NSZKo+4mqSuHh385i7Actvg+7n/MU6N3IK4fcDu4rQgEAZgD2VqbgzCh1VTVi84EY
         fM2Ki2qtBO4OMpSg6oMb85mjkrVmWjRuq20iF8R7bq+R3OZM5CJ3SdPZ6uO5X1uVSvbP
         eP3iLuVFVtMAxVll9I3MxJy6Hy4m5k2o2c/99W4YodBT5moKy0ghgDpiSWPoLCa6IQfe
         fQwHi0uEOMJ5koiFzms9tn+zZMOoQiFMkFoRJPMtvYYKZVcXaT0bcR/+rLsinl9My0qJ
         I+3MvNu7i8kbGoS1+ZW3cmvzndUsn13xp/eEl/d9N4c/otllugCBioxAQ5nnhXk3gYbN
         TEFg==
X-Gm-Message-State: ACrzQf1WO0wx5oX9iYncjTk4jkKz242IOp+597L+YT71vKg9Zba+x0B9
        qEOBIZT59M29HMKUGNhjiCE=
X-Google-Smtp-Source: AMsMyM7tUVW6OjSoFoFrhsnXJdbFwdhqcLnkJwUiIND46gNDa0Xbt1qh6HixDJrO2RoMFhdLmxeEaw==
X-Received: by 2002:a05:6512:3402:b0:49f:e6a:3cc8 with SMTP id i2-20020a056512340200b0049f0e6a3cc8mr13125523lfr.457.1666608591056;
        Mon, 24 Oct 2022 03:49:51 -0700 (PDT)
Received: from pc636 (host-90-235-65-92.mobileonline.telia.com. [90.235.65.92])
        by smtp.gmail.com with ESMTPSA id f5-20020a05651c02c500b002770c030dc0sm421718ljo.109.2022.10.24.03.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 03:49:50 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 24 Oct 2022 12:49:46 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH rcu 13/14] workqueue: Make queue_rcu_work() use
 call_rcu_flush()
Message-ID: <Y1ZtyjxKCcV0Hfjn@pc636>
References: <20221019225138.GA2499943@paulmck-ThinkPad-P17-Gen-1>
 <20221019225144.2500095-13-paulmck@kernel.org>
 <CAEXW_YQgSwMYisZVctXkjFu6_5YhFCpL_E5o5H4oJooS5Syp+g@mail.gmail.com>
 <20221024031540.GU5600@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024031540.GU5600@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Oct 23, 2022 at 08:36:00PM -0400, Joel Fernandes wrote:
> > Hello,
> > 
> > On Wed, Oct 19, 2022 at 6:51 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > From: Uladzislau Rezki <urezki@gmail.com>
> > >
> > > call_rcu() changes to save power will slow down RCU workqueue items
> > > queued via queue_rcu_work(). This may not be an issue, however we cannot
> > > assume that workqueue users are OK with long delays. Use
> > > call_rcu_flush() API instead which reverts to the old behavio
> > 
> > On ChromeOS, I can see that queue_rcu_work() is pretty noisy and the
> > batching is much better if we can just keep it as call_rcu() instead
> > of call_rcu_flush().
> > 
> > Is there really any reason to keep it as call_rcu_flush() ?  If I
> > recall, the real reason Vlad's system was slowing down was because of
> > scsi and the queue_rcu_work() conversion was really a red herring.
> 
<snip>
*** drivers/acpi/osl.c:
acpi_os_drop_map_ref[401]      queue_rcu_work(system_wq, &map->track.rwork);

*** drivers/gpu/drm/i915/gt/intel_execlists_submission.c:
virtual_context_destroy[3653]  queue_rcu_work(system_wq, &ve->rcu);

*** fs/aio.c:
free_ioctx_reqs[632]           queue_rcu_work(system_wq, &ctx->free_rwork);

*** fs/fs-writeback.c:
inode_switch_wbs[604]          queue_rcu_work(isw_wq, &isw->work);
cleanup_offline_cgwb[676]      queue_rcu_work(isw_wq, &isw->work);

*** include/linux/workqueue.h:
__printf[446]                  extern bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork);

*** kernel/cgroup/cgroup.c:
css_release_work_fn[5253]      queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
css_create[5384]               queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);

*** kernel/rcu/tree.c:
kfree_rcu_monitor[3192]        queue_rcu_work(system_wq, &krwp->rcu_work);

*** net/core/skmsg.c:
sk_psock_drop[852]             queue_rcu_work(system_wq, &psock->rwork);

*** net/sched/act_ct.c:
tcf_ct_flow_table_put[355]     queue_rcu_work(act_ct_wq, &ct_ft->rwork);

*** net/sched/cls_api.c:
tcf_queue_work[225]            return queue_rcu_work(tc_filter_wq, rwork);
<snip>
There are 9 users of the queue_rcu_work() functions. I think there can be
a side effect if we keep it as lazy variant. Please note that i have not
checked all those users.

> There are less than 20 invocations of queue_rcu_work(), so it should
> be possible look through each.  The low-risk approach is of course to
> have queue_rcu_work() use call_rcu_flush().
> 
> The next approach might be to have a Kconfig option and/or kernel
> boot parameter that allowed a per-system choice.
> 
> But it would not hurt to double-check on Android.
> 
I did not see such noise but i will come back some data on 5.10 kernel
today.

> 
> > Vlad, any thoughts?
> > 
At least for the kvfree_rcu() i would like to keep the sync variant, because
we have the below patch that improves bathing:

<snip>
commit 51824b780b719c53113dc39e027fbf670dc66028
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Thu Jun 30 18:33:35 2022 +0200

    rcu/kvfree: Update KFREE_DRAIN_JIFFIES interval

    Currently the monitor work is scheduled with a fixed interval of HZ/20,
    which is roughly 50 milliseconds. The drawback of this approach is
    low utilization of the 512 page slots in scenarios with infrequence
    kvfree_rcu() calls.  For example on an Android system:
<snip>

Apparently i see it in the "dev" branch only.

--
Uladzislau Rezki
