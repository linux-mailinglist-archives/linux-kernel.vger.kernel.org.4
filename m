Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE6860CFEE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiJYPGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbiJYPGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:06:13 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9862B87F8F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:06:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t15so1995507edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mx+tlGdScROHlmnWrt4kiiTPExq3QJVgEjXE9i7tgVw=;
        b=ofJ8GvRcm4invsPT5OH9laVKMLi9GXRp1N174DafinSVM8egec1+Gpx6XrvznAx40W
         m/YyhafqUom6LfP9ikD9HnyD+MFaeQrK/sSHm599A4/6cyK505e4eJmaANOI89EVIcqZ
         bain+6x8jLxuDskyyvuO92WAegpHH30awTFW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mx+tlGdScROHlmnWrt4kiiTPExq3QJVgEjXE9i7tgVw=;
        b=mz15Fe9HVyc5CPVSOlb3dDc9iCgWCc2RMav1/UAwFbZQ848L/2vrKK2tib5G/ApKsg
         IVT8ixpfjMVQoKM0Jp7Y8TF5FY3y2lfEcHcFPaJVeqJEAUAuVnVzhE18x+RNZB82Wd3X
         jXe4AwrFpB7n/eOYj5iKUTuuItMBnBmOLXE/qPFkORXY0XFsQqKEiZJiwOzErT/fdlPY
         LDVtM2PKdCdwzXwukWNlRN5iQUaxZeCaZKjABgzobse+SWKcW8g07mtwet9vno+TEl71
         ZaTANxqDJ2FI506FRLMe+468/smX1HhT2z6MMs8NW7q5Ta+p90qTAUUdtp79mc/cFJ6Y
         1nKA==
X-Gm-Message-State: ACrzQf2iSrOy6LGCML1MsQVGGA3bWYp8whd/OJHZU66HBuGa96WJB3on
        E50DWdALWVP2RZzYogshTeT1J5h5mS5qCXVA2tBC1w==
X-Google-Smtp-Source: AMsMyM7spNSfgcScxWfgIhcuF41ETEptHqO+SKPfaev8ctjJSEIfethohmBw6gOV4pkUOHYXi6LrJTFElw1gSwlPud0=
X-Received: by 2002:a05:6402:3551:b0:45d:a52f:2d77 with SMTP id
 f17-20020a056402355100b0045da52f2d77mr37383976edd.67.1666710369935; Tue, 25
 Oct 2022 08:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <Y1ahs83258Lok9+O@google.com> <20221024153958.GY5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1a8ei1h7SzyYZx9@pc636> <20221024164819.GA5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1bDdP3iHoa4xqZL@pc636> <Y1bGcQ7RPleYp3ge@pc636> <CAEXW_YQqiD1GU7HGrv9UU6vL_MqbxVt14=rxZAKqUpK+pkPDPw@mail.gmail.com>
 <20221024173558.GC5600@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YQFNd8evWMxv=sWwZ0q28wxAwStCMgaJnDu6QM6YqqjMA@mail.gmail.com>
 <CAEXW_YQr1Ag0L+J6RZ28vQKbBZwM98+YdsCqmt6mU0At67HDxQ@mail.gmail.com> <Y1e+/LD8BPu4JC9I@pc636>
In-Reply-To: <Y1e+/LD8BPu4JC9I@pc636>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 25 Oct 2022 11:05:57 -0400
Message-ID: <CAEXW_YQAXee2iGDC8XQJnF7sAaaB2tPX4p6Bb3cYr9pMUnC9nQ@mail.gmail.com>
Subject: Re: [PATCH rcu 13/14] workqueue: Make queue_rcu_work() use call_rcu_flush()
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 6:48 AM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> On Mon, Oct 24, 2022 at 04:16:20PM -0400, Joel Fernandes wrote:
> > On Mon, Oct 24, 2022 at 4:12 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Mon, Oct 24, 2022 at 1:36 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Mon, Oct 24, 2022 at 01:20:26PM -0400, Joel Fernandes wrote:
> > > > > On Mon, Oct 24, 2022 at 1:08 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Oct 24, 2022 at 06:55:16PM +0200, Uladzislau Rezki wrote:
> > > > > > > On Mon, Oct 24, 2022 at 09:48:19AM -0700, Paul E. McKenney wrote:
> > > > > > > > On Mon, Oct 24, 2022 at 06:25:30PM +0200, Uladzislau Rezki wrote:
> > > > > > > > > >
> > > > > > > > > > You guys might need to agree on the definition of "good" here.  Or maybe
> > > > > > > > > > understand the differences in your respective platforms' definitions of
> > > > > > > > > > "good".  ;-)
> > > > > > > > > >
> > > > > > > > > Indeed. Bad is when once per-millisecond infinitely :) At least in such use
> > > > > > > > > workload a can detect a power delta and power gain. Anyway, below is a new
> > > > > > > > > trace where i do not use "flush" variant for the kvfree_rcu():
> > > > > > > > >
> > > > > > > > > <snip>
> > > > > > > > > 1. Home screen swipe:
> > > > > > > > >          rcuop/0-15      [003] d..1  1792.767750: rcu_batch_start: rcu_preempt CBs=1003 bl=10
> > > > > > > > >          rcuop/2-33      [002] d..1  1792.771717: rcu_batch_start: rcu_preempt CBs=934 bl=10
> > > > > > > > >          rcuop/3-40      [001] d..1  1794.811816: rcu_batch_start: rcu_preempt CBs=1508 bl=11
> > > > > > > > >          rcuop/1-26      [003] d..1  1797.116382: rcu_batch_start: rcu_preempt CBs=2127 bl=16
> > > > > > > > >          rcuop/4-48      [001] d..1  1797.124422: rcu_batch_start: rcu_preempt CBs=95 bl=10
> > > > > > > > >          rcuop/5-55      [002] d..1  1797.124731: rcu_batch_start: rcu_preempt CBs=143 bl=10
> > > > > > > > >          rcuop/6-62      [005] d..1  1798.911719: rcu_batch_start: rcu_preempt CBs=132 bl=10
> > > > > > > > >          rcuop/2-33      [002] d..1  1803.003966: rcu_batch_start: rcu_preempt CBs=3797 bl=29
> > > > > > > > >          rcuop/0-15      [003] d..1  1803.004707: rcu_batch_start: rcu_preempt CBs=2969 bl=23
> > > > >
> > > > > > > > > 2. App launches:
> > > > > > > > >          rcuop/4-48      [005] d..1  1831.087612: rcu_batch_start: rcu_preempt CBs=6141 bl=47
> > > > > > > > >          rcuop/7-69      [007] d..1  1831.095578: rcu_batch_start: rcu_preempt CBs=5464 bl=42
> > > > > > > > >          rcuop/5-55      [004] d..1  1832.703571: rcu_batch_start: rcu_preempt CBs=8461 bl=66
> > > > > > > > >          rcuop/0-15      [004] d..1  1833.731603: rcu_batch_start: rcu_preempt CBs=2548 bl=19
> > > > > > > > >          rcuop/1-26      [006] d..1  1833.743691: rcu_batch_start: rcu_preempt CBs=2567 bl=20
> > > > > > > > >          rcuop/2-33      [006] d..1  1833.744005: rcu_batch_start: rcu_preempt CBs=2359 bl=18
> > > > > > > > >          rcuop/3-40      [006] d..1  1833.744286: rcu_batch_start: rcu_preempt CBs=3681 bl=28
> > > > > > > > >          rcuop/4-48      [002] d..1  1838.079777: rcu_batch_start: rcu_preempt CBs=10444 bl=81
> > > > > > > > >          rcuop/7-69      [001] d..1  1838.080375: rcu_batch_start: rcu_preempt CBs=12572 bl=98
> > > > > > > > >            <...>-62      [002] d..1  1838.080646: rcu_batch_start: rcu_preempt CBs=14135 bl=110
> > > > > > > > >          rcuop/6-62      [000] d..1  1838.087722: rcu_batch_start: rcu_preempt CBs=10839 bl=84
> > > > > > > > >            <...>-62      [003] d..1  1839.227022: rcu_batch_start: rcu_preempt CBs=1834 bl=14
> > > > > > > > >            <...>-26      [001] d..1  1839.963315: rcu_batch_start: rcu_preempt CBs=5769 bl=45
> > > > > > > > >          rcuop/2-33      [001] d..1  1839.966485: rcu_batch_start: rcu_preempt CBs=3789 bl=29
> > > > > > > > >            <...>-40      [001] d..1  1839.966596: rcu_batch_start: rcu_preempt CBs=6425 bl=50
> > > > > > > > >          rcuop/2-33      [005] d..1  1840.541272: rcu_batch_start: rcu_preempt CBs=825 bl=10
> > > > > > > > >          rcuop/2-33      [005] d..1  1840.547724: rcu_batch_start: rcu_preempt CBs=44 bl=10
> > > > > > > > >          rcuop/2-33      [005] d..1  1841.075759: rcu_batch_start: rcu_preempt CBs=516 bl=10
> > > > > > > > >          rcuop/0-15      [002] d..1  1841.695716: rcu_batch_start: rcu_preempt CBs=6312 bl=49
> > > > > > > > >          rcuop/0-15      [003] d..1  1841.709714: rcu_batch_start: rcu_preempt CBs=39 bl=10
> > > > > > > > >          rcuop/5-55      [004] d..1  1843.112442: rcu_batch_start: rcu_preempt CBs=16007 bl=125
> > > > > > > > >          rcuop/5-55      [004] d..1  1843.115444: rcu_batch_start: rcu_preempt CBs=7901 bl=61
> > > > > > > > >          rcuop/6-62      [001] dn.1  1843.123983: rcu_batch_start: rcu_preempt CBs=8427 bl=65
> > > > > > > > >          rcuop/6-62      [006] d..1  1843.412383: rcu_batch_start: rcu_preempt CBs=981 bl=10
> > > > > > > > >          rcuop/0-15      [003] d..1  1844.659812: rcu_batch_start: rcu_preempt CBs=1851 bl=14
> > > > > > > > >          rcuop/0-15      [003] d..1  1844.667790: rcu_batch_start: rcu_preempt CBs=135 bl=10
> > > > >
> > > > > Definitely better, but I'd still ask why not just rely on the lazy
> > > > > batching that we now have, since it is a memory pressure related
> > > > > usecase. Or another approach could be, for CONFIG_RCU_LAZY, don't
> > > > > disturb the lazy-RCU batching by queuing these "free memory" CBs; and
> > > > > instead keep your improved kvfree_rcu() batching only for
> > > > > !CONFIG_RCU_LAZY.
> > > >
> > > > Given that making the kvfree_rcu()-level batching conditional on
> > > > CONFIG_RCU_LAZY would complicate the code, what bad thing happens when
> > > > keeping the kvfree_rcu-level batching unconditionally?
> > >
> > > The bad thing happening is power impact. There is a noticeable impact
> > > in our testing, and when we dropped this particular patch, it got much
> > > better results.
> > >
> > > I also run rcutop and I see without the patch that I have several
> > > seconds of laziness at a time, unlike with the patch.
> > >
> > > Even in the beginning when I came up with an implementation for
> > > call_rcu_lazy(), I had to mark queue_rcu_work() as lazy as well since
> > > it was quite frequent (on ChromeOS). But when we introduced the
> > > flush() API, I forgot to not use flush() on it.  But unfortunately
> > > this patch slipped into my last series when Vlad and I were debugging
> > > the SCSI issue, and did not really help for the SCSI issue itself.
> >
> > I could try to run Vlad's other mainline patch itself and measure
> > power, I'll get back on that. Thanks!
> >
> That makes sense. It would be good to have a look at your power figures
> and traces.

If you don't mind, could you backport that patch to 5.10?
Here is my 5.10 tree for reference (without the patch)
https://github.com/joelagnel/linux-kernel.git    (branch
5.10-v9-minus-queuework-plus-kfreebatch)

and I am getting conflicts if I cherry-pick:
51824b780b71 ("rcu/kvfree: Update KFREE_DRAIN_JIFFIES interval")

I am assuming you have already done the backport, that's why you got
the traces above. If so, I would appreciate a link to your branch so I
don't mess the backport up!

 - Joel
