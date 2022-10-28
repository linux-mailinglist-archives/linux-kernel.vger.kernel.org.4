Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124C2611C85
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiJ1Vmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJ1Vmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:42:33 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469022475FF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:42:32 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id a27so1023401qtw.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/i1aLl/b1TIUlQ1hO3+XDW2pk0xma9Zf2pqLaKaxs1g=;
        b=K3GiBE0HZSPTGpOKQl2ezdbcY7QHmpgbjv5fIN8WpmBu5LKnd8RF/l1Y74J8dP3vJj
         +XXKmBBsYilGNqr62Z4Hir6JrMK2mm/zQB744EVSaz12Die3pwEJ4wSkOyEa4v1dSuJa
         7Dc26q+lCHLJkTlfHqSDPESNGmfmXF4cJJ+9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/i1aLl/b1TIUlQ1hO3+XDW2pk0xma9Zf2pqLaKaxs1g=;
        b=OdM/Sg4v/QUU9sx7t5oc3PfNsSbENhp2JvBQwQE8WRn5TXKkTJRA9ugmXXieVnKyeT
         aO2K+QqEnL9Kn8iWUoErIEHk5VJUIqtmPdztGBZ0siK4woEmyrXRCqSt3j3VR7BI9DT/
         Y2NDv5Erm/fMSo++18O9XpTzbD9lNvdNZ14lwpX0JnSiMxA2FX7u/EDkVRZ0Y7CJb2tk
         buG8uU5JMvm3yygUOA5ay/y1K0n+hsScQVtBh8oByFzzPGRpNV2Up/6IWyr/+EuPFA0P
         zG8vqL+2ubt4PYGeQUe+DsIJiJk+PNskSUqGsjboH4y+a5yL87vCCgJJWFlFHt98pZQ2
         ujcQ==
X-Gm-Message-State: ACrzQf3jSXjMc2tbiOI/67XX+cgduv7AuHsEpCboV3rxW1wjjAwFsOxO
        KWcUubsgrCK1ymat3jVV/iT4lD1N3iJz+w==
X-Google-Smtp-Source: AMsMyM7ZKpXWTXA1IEudWxs/zOiPx/0WpJLVYZiTcNboaosicRghs3DcmKgJjp+TVir8rL+w/MuoOg==
X-Received: by 2002:a05:622a:14d:b0:39c:c531:2506 with SMTP id v13-20020a05622a014d00b0039cc5312506mr1416642qtw.13.1666993351335;
        Fri, 28 Oct 2022 14:42:31 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id t10-20020a05622a01ca00b0035d432f5ba3sm2986613qtw.17.2022.10.28.14.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 14:42:30 -0700 (PDT)
Date:   Fri, 28 Oct 2022 21:42:30 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: Re: [PATCH rcu 13/14] workqueue: Make queue_rcu_work() use
 call_rcu_flush()
Message-ID: <Y1xMxlT5B7PcAUMP@google.com>
References: <20221019225144.2500095-13-paulmck@kernel.org>
 <CAEXW_YQgSwMYisZVctXkjFu6_5YhFCpL_E5o5H4oJooS5Syp+g@mail.gmail.com>
 <20221024031540.GU5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1ZtyjxKCcV0Hfjn@pc636>
 <Y1aDy3maaO39ClSU@pc636>
 <Y1ahs83258Lok9+O@google.com>
 <20221024153958.GY5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1a8ei1h7SzyYZx9@pc636>
 <20221024164819.GA5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1xIY77sFTyxgAsU@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1xIY77sFTyxgAsU@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 09:23:47PM +0000, Joel Fernandes wrote:
> On Mon, Oct 24, 2022 at 09:48:19AM -0700, Paul E. McKenney wrote:
> > On Mon, Oct 24, 2022 at 06:25:30PM +0200, Uladzislau Rezki wrote:
> > > >
> > > > You guys might need to agree on the definition of "good" here.  Or maybe
> > > > understand the differences in your respective platforms' definitions of
> > > > "good".  ;-)
> > > >
> > > Indeed. Bad is when once per-millisecond infinitely :) At least in such use
> > > workload a can detect a power delta and power gain. Anyway, below is a new
> > > trace where i do not use "flush" variant for the kvfree_rcu():
> > > 
> > > <snip>
> > > 1. Home screen swipe:
> > >          rcuop/0-15      [003] d..1  1792.767750: rcu_batch_start: rcu_preempt CBs=1003 bl=10
> > >          rcuop/2-33      [002] d..1  1792.771717: rcu_batch_start: rcu_preempt CBs=934 bl=10
> > >          rcuop/3-40      [001] d..1  1794.811816: rcu_batch_start: rcu_preempt CBs=1508 bl=11
> > >          rcuop/1-26      [003] d..1  1797.116382: rcu_batch_start: rcu_preempt CBs=2127 bl=16
> > >          rcuop/4-48      [001] d..1  1797.124422: rcu_batch_start: rcu_preempt CBs=95 bl=10
> > >          rcuop/5-55      [002] d..1  1797.124731: rcu_batch_start: rcu_preempt CBs=143 bl=10
> > >          rcuop/6-62      [005] d..1  1798.911719: rcu_batch_start: rcu_preempt CBs=132 bl=10
> > >          rcuop/2-33      [002] d..1  1803.003966: rcu_batch_start: rcu_preempt CBs=3797 bl=29
> > >          rcuop/0-15      [003] d..1  1803.004707: rcu_batch_start: rcu_preempt CBs=2969 bl=23
> > > 2. App launches:
> > >          rcuop/4-48      [005] d..1  1831.087612: rcu_batch_start: rcu_preempt CBs=6141 bl=47
> > >          rcuop/7-69      [007] d..1  1831.095578: rcu_batch_start: rcu_preempt CBs=5464 bl=42
> > >          rcuop/5-55      [004] d..1  1832.703571: rcu_batch_start: rcu_preempt CBs=8461 bl=66
> > >          rcuop/0-15      [004] d..1  1833.731603: rcu_batch_start: rcu_preempt CBs=2548 bl=19
> > >          rcuop/1-26      [006] d..1  1833.743691: rcu_batch_start: rcu_preempt CBs=2567 bl=20
> > >          rcuop/2-33      [006] d..1  1833.744005: rcu_batch_start: rcu_preempt CBs=2359 bl=18
> > >          rcuop/3-40      [006] d..1  1833.744286: rcu_batch_start: rcu_preempt CBs=3681 bl=28
> > >          rcuop/4-48      [002] d..1  1838.079777: rcu_batch_start: rcu_preempt CBs=10444 bl=81
> > >          rcuop/7-69      [001] d..1  1838.080375: rcu_batch_start: rcu_preempt CBs=12572 bl=98
> > >            <...>-62      [002] d..1  1838.080646: rcu_batch_start: rcu_preempt CBs=14135 bl=110
> > >          rcuop/6-62      [000] d..1  1838.087722: rcu_batch_start: rcu_preempt CBs=10839 bl=84
> > >            <...>-62      [003] d..1  1839.227022: rcu_batch_start: rcu_preempt CBs=1834 bl=14
> > >            <...>-26      [001] d..1  1839.963315: rcu_batch_start: rcu_preempt CBs=5769 bl=45
> > >          rcuop/2-33      [001] d..1  1839.966485: rcu_batch_start: rcu_preempt CBs=3789 bl=29
> > >            <...>-40      [001] d..1  1839.966596: rcu_batch_start: rcu_preempt CBs=6425 bl=50
> > >          rcuop/2-33      [005] d..1  1840.541272: rcu_batch_start: rcu_preempt CBs=825 bl=10
> > >          rcuop/2-33      [005] d..1  1840.547724: rcu_batch_start: rcu_preempt CBs=44 bl=10
> > >          rcuop/2-33      [005] d..1  1841.075759: rcu_batch_start: rcu_preempt CBs=516 bl=10
> > >          rcuop/0-15      [002] d..1  1841.695716: rcu_batch_start: rcu_preempt CBs=6312 bl=49
> > >          rcuop/0-15      [003] d..1  1841.709714: rcu_batch_start: rcu_preempt CBs=39 bl=10
> > >          rcuop/5-55      [004] d..1  1843.112442: rcu_batch_start: rcu_preempt CBs=16007 bl=125
> > >          rcuop/5-55      [004] d..1  1843.115444: rcu_batch_start: rcu_preempt CBs=7901 bl=61
> > >          rcuop/6-62      [001] dn.1  1843.123983: rcu_batch_start: rcu_preempt CBs=8427 bl=65
> > >          rcuop/6-62      [006] d..1  1843.412383: rcu_batch_start: rcu_preempt CBs=981 bl=10
> > >          rcuop/0-15      [003] d..1  1844.659812: rcu_batch_start: rcu_preempt CBs=1851 bl=14
> > >          rcuop/0-15      [003] d..1  1844.667790: rcu_batch_start: rcu_preempt CBs=135 bl=10
> > > <snip>
> > > 
> > > it is much more better. But. As i wrote earlier there is a patch that i have submitted
> > > some time ago improving kvfree_rcu() batching:
> > > 
> > > <snip>
> > > commit 51824b780b719c53113dc39e027fbf670dc66028
> > > Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > Date:   Thu Jun 30 18:33:35 2022 +0200
> > > 
> > >     rcu/kvfree: Update KFREE_DRAIN_JIFFIES interval
> > > 
> > >     Currently the monitor work is scheduled with a fixed interval of HZ/20,
> > >     which is roughly 50 milliseconds. The drawback of this approach is
> > >     low utilization of the 512 page slots in scenarios with infrequence
> > >     kvfree_rcu() calls.  For example on an Android system:
> > > <snip>
> > > 
> > > The trace that i posted was taken without it.
> > 
> > And if I am not getting too confused, that patch is now in mainline.
> > So it does make sense to rely on it, then.  ;-)
> 
> Vlad's patch to change the KFREE_DRAIN_JIFFIES to 5 seconds seems reasonable
> to me. However, can we unify KFREE_DRAIN_JIFFIES and LAZY_FLUSH_JIFFIES ?
> 
> One at 5 and other at 10 seems odd, especially because the former seems to
> negate the effects of the latter and anyone tweaking that in the future (say
> via new command line options) should probably tweak them together to increase
> batching.
> 
> Testing shows significantly better batching with Vlad's updates, however I am
> wondering why the rcu_callback fires in pairs like that from separate
> kworkers:
> 
>      kworker/6:1-157     [006] d..1   288.861610: rcu_callback: rcu_preempt  rhp=0000000079b895f9 func=rcu_work_rcufn 1214
>      kworker/4:2-158     [004]  d..1   288.861612: rcu_callback: rcu_preempt rhp=00000000d83fcc90 func=rcu_work_rcufn 798

I think this is just 2 kvfree_call_rcu() happening on 2 different CPUs, and
then the draining happened on 2 different kworkers, so appears normal.

Here is also some more evidence from the user side, of kvfree_call_rcu()
noisiness on ChromeOS. So we definitely need the batching to happen on
ChromeOS:

   kworker/u24:6-1448  [005]    77.290344: function:             kvfree_call_rcu <-- cfg80211_update_known_bss
 ThreadPoolForeg-5130  [011]    77.301101: function:             kvfree_call_rcu <-- cgroup_migrate_finish
 irq/144-iwlwifi-1010  [004]    77.314367: function:             kvfree_call_rcu <-- cfg80211_update_known_bss
 ThreadPoolSingl-2050  [004]    77.330359: function:             kvfree_call_rcu <-- cgroup_migrate_finish
 ThreadPoolSingl-2050  [004]    77.330362: function:             kvfree_call_rcu <-- cgroup_migrate_finish
 ThreadPoolForeg-5130  [011]    77.331513: function:             kvfree_call_rcu <-- cgroup_migrate_finish
     patchpaneld-2195  [009]    77.337726: function:             kvfree_call_rcu <-- neigh_flush_dev
     patchpaneld-2195  [009]    77.337737: function:             kvfree_call_rcu <-- __hw_addr_del_entry
     patchpaneld-2195  [009]    77.337744: function:             kvfree_call_rcu <-- addrconf_ifdown
     patchpaneld-2195  [009]    77.337744: function:             kvfree_call_rcu <-- __hw_addr_del_entry
 irq/144-iwlwifi-1010  [004]    77.633595: function:             kvfree_call_rcu <-- cfg80211_update_known_bss
 irq/144-iwlwifi-1010  [004]    77.633609: function:             kvfree_call_rcu <-- cfg80211_update_known_bss
 irq/144-iwlwifi-1010  [004]    77.769844: function:             kvfree_call_rcu <-- cfg80211_update_known_bss
   kworker/u24:1-9     [008]    77.769858: function:             kvfree_call_rcu <-- cfg80211_update_known_bss
 irq/144-iwlwifi-1010  [004]    77.880114: function:             kvfree_call_rcu <-- cfg80211_update_known_bss
   kworker/u24:6-1448  [005]    77.880129: function:             kvfree_call_rcu <-- cfg80211_update_known_bss
 irq/144-iwlwifi-1010  [004]    77.880131: function:             kvfree_call_rcu <-- cfg80211_update_known_bss
   kworker/u24:6-1448  [005]    77.880133: function:             kvfree_call_rcu <-- cfg80211_update_known_bss
      virtio_gpu-5882  [010]    78.337302: function:             kvfree_call_rcu <-- context_close
      virtio_gpu-5882  [010]    78.337303: function:             kvfree_call_rcu <-- i915_driver_postclose
      virtio_gpu-5882  [010]    78.346058: function:             kvfree_call_rcu <-- fence_notify
      virtio_gpu-5882  [010]    78.346070: function:             kvfree_call_rcu <-- fence_notify
      virtio_gpu-5882  [010]    78.346079: function:             kvfree_call_rcu <-- fence_notify
      virtio_gpu-5882  [010]    78.346086: function:             kvfree_call_rcu <-- fence_notify
      virtio_gpu-5882  [010]    78.346184: function:             kvfree_call_rcu <-- fence_notify
      virtio_gpu-5882  [010]    78.346196: function:             kvfree_call_rcu <-- fence_notify

thanks,

 - Joel

> 
> I wonder if the queued kwork is executing twice accidentally, or something.
> This kernel does have the additional trace patch below, fyi.
> 
> Another thought I have is, if we can just keep the kvfree_rcu() mapped to
> call_rcu() via a config option say CONFIG_RCU_LAZY_KFREE, or something.
> Because I am personally not much a fan of the kfree_rcu() induced additional
> timer wake ups and kworker queue+wakeup which we don't need per-se, if we are
> already batching with Lazyfied-call_rcu. Too many moving parts which might
> hurt power.
> 
> ---8<-----------------------
> 
> From: Joel Fernandes <joelaf@google.com>
> Subject: [PATCH] debug: reorder trace_rcu_callback
> 
> Signed-off-by: Joel Fernandes <joelaf@google.com>
> ---
>  kernel/rcu/tree.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 73feb09fd51b..a7c175e9533a 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2978,10 +2978,6 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
>  	}
>  
>  	check_cb_ovld(rdp);
> -	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
> -		return; // Enqueued onto ->nocb_bypass, so just leave.
> -	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
> -	rcu_segcblist_enqueue(&rdp->cblist, head);
>  	if (__is_kvfree_rcu_offset((unsigned long)func))
>  		trace_rcu_kvfree_callback(rcu_state.name, head,
>  					 (unsigned long)func,
> @@ -2990,6 +2986,11 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
>  		trace_rcu_callback(rcu_state.name, head,
>  				   rcu_segcblist_n_cbs(&rdp->cblist));
>  
> +	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
> +		return; // Enqueued onto ->nocb_bypass, so just leave.
> +	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
> +	rcu_segcblist_enqueue(&rdp->cblist, head);
> +
>  	/* Go handle any RCU core processing required. */
>  	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
>  	    unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
> -- 
> 2.38.1.273.g43a17bfeac-goog
> 
