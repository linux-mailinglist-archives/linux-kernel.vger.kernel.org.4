Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FD860B7B9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiJXTa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiJXT24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:28:56 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C20614E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:00:11 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id 13so6882218ejn.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kCNpOThVJ6QBABcPTSeFbBx6AToZFdO87fQD1mRRXTo=;
        b=duBOM62Y5zYfOzDCEHWy7eUdgwsqtW3UoxHPsHTC337ZZb1t00aCExDdi6neUvT8LR
         bKFgNz/a9HRQQBWU1G+8DuZ0AaZbjiizb6zdP74b8YUNS6OwN2Umg5+dwYSPOyDgeS5Y
         iICjtOnteHwnx8tWvKWhC38hUpqs++N95swW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kCNpOThVJ6QBABcPTSeFbBx6AToZFdO87fQD1mRRXTo=;
        b=ool7Q2P9OqMeFyZtEVCNcjmTk+8BrMuOn/TPZoMav55v7ruHq1MlEUgUBlSzVnU+Kj
         HgW15ek/uNNRJ4O1tf+mGqvghQgD9SsSSH5oHMZQ16Lkktn9GSBOBH2mTW+vAoXfK+D7
         rXCym+LXgeoocoILtaEwleqYnInIDNxCb/dNbBL0yOdSFXI0IxPvzIaKb6ahQJTMdz8X
         sxwpEcMWC+aGyHfAaPhn5ih+ofLmsz91Jg+e4CK4MP20vPixUb9VpEfZVn0KwHhEWUOh
         CJJ/dW9gS0Q/XY4yjooq+koulOMshNKXy1xXKkMcY1rCdeACLrYiBMzsx54iawZ449Xq
         KREQ==
X-Gm-Message-State: ACrzQf25mZ7IwkjVMKcLrncmg50DaX1IhiFdyO4uLp39Of8/dF9jX03+
        IEM+aCLBAaimMCCa1NWnvsAO+uY1acAQfjrC57VqGuZuOF07cQ==
X-Google-Smtp-Source: AMsMyM4wFVzdw/qhzVMtxe8KcBbCRYXDLfbeUtQH6gW3tyNzlAV236tR8qroSNGQyn8O2MN68opXGr6b1PMzvz+SQws=
X-Received: by 2002:aa7:c041:0:b0:45c:1584:23db with SMTP id
 k1-20020aa7c041000000b0045c158423dbmr31802632edo.184.1666632037496; Mon, 24
 Oct 2022 10:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221019225144.2500095-13-paulmck@kernel.org> <CAEXW_YQgSwMYisZVctXkjFu6_5YhFCpL_E5o5H4oJooS5Syp+g@mail.gmail.com>
 <20221024031540.GU5600@paulmck-ThinkPad-P17-Gen-1> <Y1ZtyjxKCcV0Hfjn@pc636>
 <Y1aDy3maaO39ClSU@pc636> <Y1ahs83258Lok9+O@google.com> <20221024153958.GY5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1a8ei1h7SzyYZx9@pc636> <20221024164819.GA5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1bDdP3iHoa4xqZL@pc636> <Y1bGcQ7RPleYp3ge@pc636>
In-Reply-To: <Y1bGcQ7RPleYp3ge@pc636>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 24 Oct 2022 13:20:26 -0400
Message-ID: <CAEXW_YQqiD1GU7HGrv9UU6vL_MqbxVt14=rxZAKqUpK+pkPDPw@mail.gmail.com>
Subject: Re: [PATCH rcu 13/14] workqueue: Make queue_rcu_work() use call_rcu_flush()
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
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

On Mon, Oct 24, 2022 at 1:08 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> On Mon, Oct 24, 2022 at 06:55:16PM +0200, Uladzislau Rezki wrote:
> > On Mon, Oct 24, 2022 at 09:48:19AM -0700, Paul E. McKenney wrote:
> > > On Mon, Oct 24, 2022 at 06:25:30PM +0200, Uladzislau Rezki wrote:
> > > > >
> > > > > You guys might need to agree on the definition of "good" here.  Or maybe
> > > > > understand the differences in your respective platforms' definitions of
> > > > > "good".  ;-)
> > > > >
> > > > Indeed. Bad is when once per-millisecond infinitely :) At least in such use
> > > > workload a can detect a power delta and power gain. Anyway, below is a new
> > > > trace where i do not use "flush" variant for the kvfree_rcu():
> > > >
> > > > <snip>
> > > > 1. Home screen swipe:
> > > >          rcuop/0-15      [003] d..1  1792.767750: rcu_batch_start: rcu_preempt CBs=1003 bl=10
> > > >          rcuop/2-33      [002] d..1  1792.771717: rcu_batch_start: rcu_preempt CBs=934 bl=10
> > > >          rcuop/3-40      [001] d..1  1794.811816: rcu_batch_start: rcu_preempt CBs=1508 bl=11
> > > >          rcuop/1-26      [003] d..1  1797.116382: rcu_batch_start: rcu_preempt CBs=2127 bl=16
> > > >          rcuop/4-48      [001] d..1  1797.124422: rcu_batch_start: rcu_preempt CBs=95 bl=10
> > > >          rcuop/5-55      [002] d..1  1797.124731: rcu_batch_start: rcu_preempt CBs=143 bl=10
> > > >          rcuop/6-62      [005] d..1  1798.911719: rcu_batch_start: rcu_preempt CBs=132 bl=10
> > > >          rcuop/2-33      [002] d..1  1803.003966: rcu_batch_start: rcu_preempt CBs=3797 bl=29
> > > >          rcuop/0-15      [003] d..1  1803.004707: rcu_batch_start: rcu_preempt CBs=2969 bl=23

> > > > 2. App launches:
> > > >          rcuop/4-48      [005] d..1  1831.087612: rcu_batch_start: rcu_preempt CBs=6141 bl=47
> > > >          rcuop/7-69      [007] d..1  1831.095578: rcu_batch_start: rcu_preempt CBs=5464 bl=42
> > > >          rcuop/5-55      [004] d..1  1832.703571: rcu_batch_start: rcu_preempt CBs=8461 bl=66
> > > >          rcuop/0-15      [004] d..1  1833.731603: rcu_batch_start: rcu_preempt CBs=2548 bl=19
> > > >          rcuop/1-26      [006] d..1  1833.743691: rcu_batch_start: rcu_preempt CBs=2567 bl=20
> > > >          rcuop/2-33      [006] d..1  1833.744005: rcu_batch_start: rcu_preempt CBs=2359 bl=18
> > > >          rcuop/3-40      [006] d..1  1833.744286: rcu_batch_start: rcu_preempt CBs=3681 bl=28
> > > >          rcuop/4-48      [002] d..1  1838.079777: rcu_batch_start: rcu_preempt CBs=10444 bl=81
> > > >          rcuop/7-69      [001] d..1  1838.080375: rcu_batch_start: rcu_preempt CBs=12572 bl=98
> > > >            <...>-62      [002] d..1  1838.080646: rcu_batch_start: rcu_preempt CBs=14135 bl=110
> > > >          rcuop/6-62      [000] d..1  1838.087722: rcu_batch_start: rcu_preempt CBs=10839 bl=84
> > > >            <...>-62      [003] d..1  1839.227022: rcu_batch_start: rcu_preempt CBs=1834 bl=14
> > > >            <...>-26      [001] d..1  1839.963315: rcu_batch_start: rcu_preempt CBs=5769 bl=45
> > > >          rcuop/2-33      [001] d..1  1839.966485: rcu_batch_start: rcu_preempt CBs=3789 bl=29
> > > >            <...>-40      [001] d..1  1839.966596: rcu_batch_start: rcu_preempt CBs=6425 bl=50
> > > >          rcuop/2-33      [005] d..1  1840.541272: rcu_batch_start: rcu_preempt CBs=825 bl=10
> > > >          rcuop/2-33      [005] d..1  1840.547724: rcu_batch_start: rcu_preempt CBs=44 bl=10
> > > >          rcuop/2-33      [005] d..1  1841.075759: rcu_batch_start: rcu_preempt CBs=516 bl=10
> > > >          rcuop/0-15      [002] d..1  1841.695716: rcu_batch_start: rcu_preempt CBs=6312 bl=49
> > > >          rcuop/0-15      [003] d..1  1841.709714: rcu_batch_start: rcu_preempt CBs=39 bl=10
> > > >          rcuop/5-55      [004] d..1  1843.112442: rcu_batch_start: rcu_preempt CBs=16007 bl=125
> > > >          rcuop/5-55      [004] d..1  1843.115444: rcu_batch_start: rcu_preempt CBs=7901 bl=61
> > > >          rcuop/6-62      [001] dn.1  1843.123983: rcu_batch_start: rcu_preempt CBs=8427 bl=65
> > > >          rcuop/6-62      [006] d..1  1843.412383: rcu_batch_start: rcu_preempt CBs=981 bl=10
> > > >          rcuop/0-15      [003] d..1  1844.659812: rcu_batch_start: rcu_preempt CBs=1851 bl=14
> > > >          rcuop/0-15      [003] d..1  1844.667790: rcu_batch_start: rcu_preempt CBs=135 bl=10

Definitely better, but I'd still ask why not just rely on the lazy
batching that we now have, since it is a memory pressure related
usecase. Or another approach could be, for CONFIG_RCU_LAZY, don't
disturb the lazy-RCU batching by queuing these "free memory" CBs; and
instead keep your improved kvfree_rcu() batching only for
!CONFIG_RCU_LAZY.
