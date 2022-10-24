Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645EA60B57B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbiJXS2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiJXS2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:28:24 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B7DEE0AF;
        Mon, 24 Oct 2022 10:10:15 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id fy4so6547336ejc.5;
        Mon, 24 Oct 2022 10:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vMyTwmDSbrb64nJlixAkfr9Gk7sJ7y1AmirPSSGRFMk=;
        b=cNirpzFwGMo4G8twVx8Zj8UIz2W2NoXSXRTuq3JLEuWZLQGcVhpPzVFMi3QJcdG3lX
         OpQbbAdBJFUmmWsZsmjskqIYTGU03g6ywF+Ht5KE51QWKoAs5MdRfPiFa0b9krJSYni/
         W0M5fKj7rt+OfvIfTAPxzhDx6S/2i6pFm9k1nHDei9gLf43/7+rFGd7Y6GJKR57pE0nn
         KGHSGtOyfiOSCUqqhDyol6kPucEo33gmUSIgNQL7oPVKLodYdKJCChSWK9MztDDoz8Kl
         IVvH2EdXVHnLsjXMDzdWEuhjVOUkm+RdYPE55S76ur8g6+6zSvrFKVXeK2R1ZBSxUaYl
         6miQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMyTwmDSbrb64nJlixAkfr9Gk7sJ7y1AmirPSSGRFMk=;
        b=HvPdRKUUWNzzpCJwv8b3EccqJ2m1B8r3yLrY0gJMRPg2c6V6YMjH34VUb0Ja1CsHmU
         3UEa2IxQSEI0cesCI4N0kL8oV+4e8salEi+jUWahXk9HQNQyO3GGfjsJOitfBgAg/zKt
         DWSdFAre/91oFU3xslcbYM2Qx2sXBPubh8t3h65/tp93Yv0qgxhfGSBI0KRhZSHPrWnQ
         x1FoB1XBgRZzPJp6D1mrDO9GgS9Caz1B2YZN01bMvZYFRwWj35fikqdHFYOH5ExXfPqt
         mjOFFyXuiwHzTJwDZr1+ZZwhGbUUAt4ivaQlwfTy81Ym8tELrdjg4nJLuN+afTK0YMq/
         gRlg==
X-Gm-Message-State: ACrzQf3AH0qnk+sMB8jC64cPNxcTEEKKTnKiCUR1oKp3Ssie32A2Owcy
        KquGeNiwZNelvjcBafkCrTZanRJ42aM=
X-Google-Smtp-Source: AMsMyM6GmHsCCdJYMl4fuSbeEcl8e8oe2+FicHhg2WPicClK6d/uZet22BqhK8ZV7WXQKz8x6f/pOw==
X-Received: by 2002:ac2:4db8:0:b0:4a4:5e0e:b75e with SMTP id h24-20020ac24db8000000b004a45e0eb75emr11560010lfe.64.1666630519209;
        Mon, 24 Oct 2022 09:55:19 -0700 (PDT)
Received: from pc636 (host-217-213-69-138.mobileonline.telia.com. [217.213.69.138])
        by smtp.gmail.com with ESMTPSA id k12-20020a2ea28c000000b00276ac526d40sm44742lja.37.2022.10.24.09.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:55:18 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 24 Oct 2022 18:55:16 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: Re: [PATCH rcu 13/14] workqueue: Make queue_rcu_work() use
 call_rcu_flush()
Message-ID: <Y1bDdP3iHoa4xqZL@pc636>
References: <20221019225138.GA2499943@paulmck-ThinkPad-P17-Gen-1>
 <20221019225144.2500095-13-paulmck@kernel.org>
 <CAEXW_YQgSwMYisZVctXkjFu6_5YhFCpL_E5o5H4oJooS5Syp+g@mail.gmail.com>
 <20221024031540.GU5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1ZtyjxKCcV0Hfjn@pc636>
 <Y1aDy3maaO39ClSU@pc636>
 <Y1ahs83258Lok9+O@google.com>
 <20221024153958.GY5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1a8ei1h7SzyYZx9@pc636>
 <20221024164819.GA5600@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024164819.GA5600@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 09:48:19AM -0700, Paul E. McKenney wrote:
> On Mon, Oct 24, 2022 at 06:25:30PM +0200, Uladzislau Rezki wrote:
> > >
> > > You guys might need to agree on the definition of "good" here.  Or maybe
> > > understand the differences in your respective platforms' definitions of
> > > "good".  ;-)
> > >
> > Indeed. Bad is when once per-millisecond infinitely :) At least in such use
> > workload a can detect a power delta and power gain. Anyway, below is a new
> > trace where i do not use "flush" variant for the kvfree_rcu():
> > 
> > <snip>
> > 1. Home screen swipe:
> >          rcuop/0-15      [003] d..1  1792.767750: rcu_batch_start: rcu_preempt CBs=1003 bl=10
> >          rcuop/2-33      [002] d..1  1792.771717: rcu_batch_start: rcu_preempt CBs=934 bl=10
> >          rcuop/3-40      [001] d..1  1794.811816: rcu_batch_start: rcu_preempt CBs=1508 bl=11
> >          rcuop/1-26      [003] d..1  1797.116382: rcu_batch_start: rcu_preempt CBs=2127 bl=16
> >          rcuop/4-48      [001] d..1  1797.124422: rcu_batch_start: rcu_preempt CBs=95 bl=10
> >          rcuop/5-55      [002] d..1  1797.124731: rcu_batch_start: rcu_preempt CBs=143 bl=10
> >          rcuop/6-62      [005] d..1  1798.911719: rcu_batch_start: rcu_preempt CBs=132 bl=10
> >          rcuop/2-33      [002] d..1  1803.003966: rcu_batch_start: rcu_preempt CBs=3797 bl=29
> >          rcuop/0-15      [003] d..1  1803.004707: rcu_batch_start: rcu_preempt CBs=2969 bl=23
> > 2. App launches:
> >          rcuop/4-48      [005] d..1  1831.087612: rcu_batch_start: rcu_preempt CBs=6141 bl=47
> >          rcuop/7-69      [007] d..1  1831.095578: rcu_batch_start: rcu_preempt CBs=5464 bl=42
> >          rcuop/5-55      [004] d..1  1832.703571: rcu_batch_start: rcu_preempt CBs=8461 bl=66
> >          rcuop/0-15      [004] d..1  1833.731603: rcu_batch_start: rcu_preempt CBs=2548 bl=19
> >          rcuop/1-26      [006] d..1  1833.743691: rcu_batch_start: rcu_preempt CBs=2567 bl=20
> >          rcuop/2-33      [006] d..1  1833.744005: rcu_batch_start: rcu_preempt CBs=2359 bl=18
> >          rcuop/3-40      [006] d..1  1833.744286: rcu_batch_start: rcu_preempt CBs=3681 bl=28
> >          rcuop/4-48      [002] d..1  1838.079777: rcu_batch_start: rcu_preempt CBs=10444 bl=81
> >          rcuop/7-69      [001] d..1  1838.080375: rcu_batch_start: rcu_preempt CBs=12572 bl=98
> >            <...>-62      [002] d..1  1838.080646: rcu_batch_start: rcu_preempt CBs=14135 bl=110
> >          rcuop/6-62      [000] d..1  1838.087722: rcu_batch_start: rcu_preempt CBs=10839 bl=84
> >            <...>-62      [003] d..1  1839.227022: rcu_batch_start: rcu_preempt CBs=1834 bl=14
> >            <...>-26      [001] d..1  1839.963315: rcu_batch_start: rcu_preempt CBs=5769 bl=45
> >          rcuop/2-33      [001] d..1  1839.966485: rcu_batch_start: rcu_preempt CBs=3789 bl=29
> >            <...>-40      [001] d..1  1839.966596: rcu_batch_start: rcu_preempt CBs=6425 bl=50
> >          rcuop/2-33      [005] d..1  1840.541272: rcu_batch_start: rcu_preempt CBs=825 bl=10
> >          rcuop/2-33      [005] d..1  1840.547724: rcu_batch_start: rcu_preempt CBs=44 bl=10
> >          rcuop/2-33      [005] d..1  1841.075759: rcu_batch_start: rcu_preempt CBs=516 bl=10
> >          rcuop/0-15      [002] d..1  1841.695716: rcu_batch_start: rcu_preempt CBs=6312 bl=49
> >          rcuop/0-15      [003] d..1  1841.709714: rcu_batch_start: rcu_preempt CBs=39 bl=10
> >          rcuop/5-55      [004] d..1  1843.112442: rcu_batch_start: rcu_preempt CBs=16007 bl=125
> >          rcuop/5-55      [004] d..1  1843.115444: rcu_batch_start: rcu_preempt CBs=7901 bl=61
> >          rcuop/6-62      [001] dn.1  1843.123983: rcu_batch_start: rcu_preempt CBs=8427 bl=65
> >          rcuop/6-62      [006] d..1  1843.412383: rcu_batch_start: rcu_preempt CBs=981 bl=10
> >          rcuop/0-15      [003] d..1  1844.659812: rcu_batch_start: rcu_preempt CBs=1851 bl=14
> >          rcuop/0-15      [003] d..1  1844.667790: rcu_batch_start: rcu_preempt CBs=135 bl=10
> > <snip>
> > 
> > it is much more better. But. As i wrote earlier there is a patch that i have submitted
> > some time ago improving kvfree_rcu() batching:
> > 
> > <snip>
> > commit 51824b780b719c53113dc39e027fbf670dc66028
> > Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Date:   Thu Jun 30 18:33:35 2022 +0200
> > 
> >     rcu/kvfree: Update KFREE_DRAIN_JIFFIES interval
> > 
> >     Currently the monitor work is scheduled with a fixed interval of HZ/20,
> >     which is roughly 50 milliseconds. The drawback of this approach is
> >     low utilization of the 512 page slots in scenarios with infrequence
> >     kvfree_rcu() calls.  For example on an Android system:
> > <snip>
> > 
> > The trace that i posted was taken without it.
> 
> And if I am not getting too confused, that patch is now in mainline.
> So it does make sense to rely on it, then.  ;-)
> 
Right.

urezki@pc638:~/data/raid0/coding/linux.git$ git tag --contains
51824b780b719c53113dc39e027fbf670dc66028
v6.1-rc1
v6.1-rc2
urezki@pc638:~/data/raid0/coding/linux.git$

--
Uladzislau Rezki
