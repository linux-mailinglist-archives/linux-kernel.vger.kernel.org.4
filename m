Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653F660B5FB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbiJXSpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiJXSpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:45:07 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC3724D887
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:26:52 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id l9so3953187qkk.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kLAt+IwnGUmyRpzuLFJymfFyXp1Of/OcSyYHk3SGp7Q=;
        b=ooGvCPGn1tpoAbxaK0Qx/raipTEsSorlHAr/SmqJ+o8acuPfGUgfU+iXabUNAw6VWC
         wtmCmfba7/DQafyZMUYSNBaYq6HeQDbZR0z+S+RGYFbyJPlN8058ykNLqt7VS/ZRUwfg
         JdD02f4Qf12OdVlJJQcEOR8g5CI7dHbo3/inQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLAt+IwnGUmyRpzuLFJymfFyXp1Of/OcSyYHk3SGp7Q=;
        b=FleknIM8AIbqUymDjEJD1yGkt4Zy2pfcPWvGFdcPdSjOeE7FqbL7IXJrsw+pmn72PB
         Bybd98a8mSJwPIAiGhPx0Oj7P7SaxHi6VJYjgtrBZwLCukQelht6U5S0tcbubW8wyYSW
         3lZFf8eODjObNkmjmn5hmz9giGEC2YkNS23SfSnBhp+MPxTSf/97Fbd31jUlsfStGuGG
         6dFJQLqmmVmExwTMOpVOPmsa7gGEN5oJfQfbBm+jTELe227i+k1UrK7Baw8Esy8jo8bB
         olYQ8c5c5aPtBjquIr/eUgGy+WlqREPYA2DoluiWrbkNhLDfTfp6ffS7s5h8aoZo0SKI
         s0AA==
X-Gm-Message-State: ACrzQf1c3xYouhgwHVO8wRL2Jc5s+vTu7uiwe3nt6awCISTKJi68zXha
        xNOzvj9HAXAHRd1+WbvhNU+mCmKpGcjOmw==
X-Google-Smtp-Source: AMsMyM7sdEixbP1ueOE9/G1lmfqTO0Z9L6CDFDExuNFVhfP6nqDGxQPj5YjlT+OnY6v8EZpT5sRw8Q==
X-Received: by 2002:a05:622a:211:b0:39c:f429:e03a with SMTP id b17-20020a05622a021100b0039cf429e03amr29318466qtx.389.1666630471625;
        Mon, 24 Oct 2022 09:54:31 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id bc14-20020a05622a1cce00b0039bde72b14asm168364qtb.92.2022.10.24.09.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:54:31 -0700 (PDT)
Date:   Mon, 24 Oct 2022 16:54:30 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: Re: [PATCH rcu 13/14] workqueue: Make queue_rcu_work() use
 call_rcu_flush()
Message-ID: <Y1bDRmAv3135XLcn@google.com>
References: <20221019225138.GA2499943@paulmck-ThinkPad-P17-Gen-1>
 <20221019225144.2500095-13-paulmck@kernel.org>
 <CAEXW_YQgSwMYisZVctXkjFu6_5YhFCpL_E5o5H4oJooS5Syp+g@mail.gmail.com>
 <20221024031540.GU5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1ZtyjxKCcV0Hfjn@pc636>
 <Y1aDy3maaO39ClSU@pc636>
 <Y1ahs83258Lok9+O@google.com>
 <20221024153958.GY5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1a8ei1h7SzyYZx9@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1a8ei1h7SzyYZx9@pc636>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 06:25:30PM +0200, Uladzislau Rezki wrote:
> >
> > You guys might need to agree on the definition of "good" here.  Or maybe
> > understand the differences in your respective platforms' definitions of
> > "good".  ;-)
> >
> Indeed. Bad is when once per-millisecond infinitely :) At least in such use

To me once per-ms is really bad, and once per 20ms indefinitely is also not
ideal ;-). Just to give you a sense of why I feel this, I see the RCU thread
wake ups that periodically happen can disturb CPUIdle.

The act of queuing Callback + gp delay + rcu threads running is enough to
disrupt overlaps between CPUidle time and the gp delay. Further the idle
governor will refrain from entering deeper CPUidle states because it will see
timers queued in the near future to wake up the RCU grace-period kthreads.

> workload a can detect a power delta and power gain. Anyway, below is a new
> trace where i do not use "flush" variant for the kvfree_rcu():
> 
> <snip>
> 1. Home screen swipe:
>          rcuop/0-15      [003] d..1  1792.767750: rcu_batch_start: rcu_preempt CBs=1003 bl=10
>          rcuop/2-33      [002] d..1  1792.771717: rcu_batch_start: rcu_preempt CBs=934 bl=10
>          rcuop/3-40      [001] d..1  1794.811816: rcu_batch_start: rcu_preempt CBs=1508 bl=11
>          rcuop/1-26      [003] d..1  1797.116382: rcu_batch_start: rcu_preempt CBs=2127 bl=16
>          rcuop/4-48      [001] d..1  1797.124422: rcu_batch_start: rcu_preempt CBs=95 bl=10
>          rcuop/5-55      [002] d..1  1797.124731: rcu_batch_start: rcu_preempt CBs=143 bl=10
>          rcuop/6-62      [005] d..1  1798.911719: rcu_batch_start: rcu_preempt CBs=132 bl=10
>          rcuop/2-33      [002] d..1  1803.003966: rcu_batch_start: rcu_preempt CBs=3797 bl=29
>          rcuop/0-15      [003] d..1  1803.004707: rcu_batch_start: rcu_preempt CBs=2969 bl=23
> 2. App launches:
>          rcuop/4-48      [005] d..1  1831.087612: rcu_batch_start: rcu_preempt CBs=6141 bl=47
>          rcuop/7-69      [007] d..1  1831.095578: rcu_batch_start: rcu_preempt CBs=5464 bl=42
>          rcuop/5-55      [004] d..1  1832.703571: rcu_batch_start: rcu_preempt CBs=8461 bl=66
>          rcuop/0-15      [004] d..1  1833.731603: rcu_batch_start: rcu_preempt CBs=2548 bl=19
>          rcuop/1-26      [006] d..1  1833.743691: rcu_batch_start: rcu_preempt CBs=2567 bl=20
>          rcuop/2-33      [006] d..1  1833.744005: rcu_batch_start: rcu_preempt CBs=2359 bl=18
>          rcuop/3-40      [006] d..1  1833.744286: rcu_batch_start: rcu_preempt CBs=3681 bl=28
>          rcuop/4-48      [002] d..1  1838.079777: rcu_batch_start: rcu_preempt CBs=10444 bl=81
>          rcuop/7-69      [001] d..1  1838.080375: rcu_batch_start: rcu_preempt CBs=12572 bl=98
>            <...>-62      [002] d..1  1838.080646: rcu_batch_start: rcu_preempt CBs=14135 bl=110
>          rcuop/6-62      [000] d..1  1838.087722: rcu_batch_start: rcu_preempt CBs=10839 bl=84
>            <...>-62      [003] d..1  1839.227022: rcu_batch_start: rcu_preempt CBs=1834 bl=14
>            <...>-26      [001] d..1  1839.963315: rcu_batch_start: rcu_preempt CBs=5769 bl=45
>          rcuop/2-33      [001] d..1  1839.966485: rcu_batch_start: rcu_preempt CBs=3789 bl=29
>            <...>-40      [001] d..1  1839.966596: rcu_batch_start: rcu_preempt CBs=6425 bl=50
>          rcuop/2-33      [005] d..1  1840.541272: rcu_batch_start: rcu_preempt CBs=825 bl=10
>          rcuop/2-33      [005] d..1  1840.547724: rcu_batch_start: rcu_preempt CBs=44 bl=10
>          rcuop/2-33      [005] d..1  1841.075759: rcu_batch_start: rcu_preempt CBs=516 bl=10
>          rcuop/0-15      [002] d..1  1841.695716: rcu_batch_start: rcu_preempt CBs=6312 bl=49
>          rcuop/0-15      [003] d..1  1841.709714: rcu_batch_start: rcu_preempt CBs=39 bl=10
>          rcuop/5-55      [004] d..1  1843.112442: rcu_batch_start: rcu_preempt CBs=16007 bl=125
>          rcuop/5-55      [004] d..1  1843.115444: rcu_batch_start: rcu_preempt CBs=7901 bl=61
>          rcuop/6-62      [001] dn.1  1843.123983: rcu_batch_start: rcu_preempt CBs=8427 bl=65
>          rcuop/6-62      [006] d..1  1843.412383: rcu_batch_start: rcu_preempt CBs=981 bl=10
>          rcuop/0-15      [003] d..1  1844.659812: rcu_batch_start: rcu_preempt CBs=1851 bl=14
>          rcuop/0-15      [003] d..1  1844.667790: rcu_batch_start: rcu_preempt CBs=135 bl=10
> <snip>
> 
> it is much more better. But. As i wrote earlier there is a patch that i have submitted
> some time ago improving kvfree_rcu() batching:

Yes it seems much better than your last traces! I'd propose to drop this
patch because as you show, it effects not only yours but ChromeOS. It appears
kvfree_rcu() use of queue_rcu_work() is a perfect candidate for call_rcu()
batching because it is purely driven by memory pressure. And we have a
shrinker for lazy-RCU as well.

For non-kvfree uses, we can introduce a queue_rcu_work_flush() if need-be.

What do you think?

thanks,

 - Joel

