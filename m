Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34496195CF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 13:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiKDMGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 08:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiKDMGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:06:12 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B892B1AB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 05:06:10 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n39-20020a05600c3ba700b003cf71011cddso5132387wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 05:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yfCM1rcjYJ0vxXm+tPYpoJJN5STvtSm0B2J6d626ZUo=;
        b=USyOTccSMKDkLaCNNOXZeGyR2OIducGfAqIWGtDfQbQMTG9Pic9y5aqohZvUctebUv
         dV++GojK6Mc4L3YgJf4jcrernEWC+/EhNyf4usdOsMxbjiqWk2X3Cwr503ApoE4b0odq
         Nc7Qnr4GoUD2lmnNllTGiAbvwhh0SLTNvH8B9dxYWIKWKEXbCHG1ceJ2bQ/bF8mpV35S
         yfo+XKw2prRFziF3Xqg+cDNQlf6Nrgyk3HDKEczcu31wZPqly3JD0SfI6lnVe1QeYm4U
         QNzKJiGfkUo/wbOtC/cbMW8agGihf1QVc/uPNDhL9oF0NedHlRJugc5MlBNoXQ7muNk4
         K8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfCM1rcjYJ0vxXm+tPYpoJJN5STvtSm0B2J6d626ZUo=;
        b=tehovDDkGCqX9F/JI6jmFlEiE+KjMmXTO9lpiLouR7KCOkr7XPVPAPlNYm1mhY91xh
         DRwfofDnEJP83dGLFK52cjAl/moYFyj8cA9ma6iVt7PZRZgqK2YcMaW7lgq7lg63XkGw
         a4j9uKAIlJ/PHeDHhV2mZvUqeLLwOSoptrdvldyMVs8QtqFifvq/QtsjQV8PlEgtulGW
         x5TNgd0Csh4F2WIFquV1FAJY6NOjVWaE0P/zmOr1r6JxfcewWR2HnSgHWrhaPiI1n0lU
         vraOGVmgMv2C7B2Abc+bPE4FcJcCpLVe2kAQDMy3lSRyg2b/b/HAvH6GchCPEgbAkFr4
         Bt4g==
X-Gm-Message-State: ACrzQf1a1fOEkedYp51JPdHMCTMaUb84TojBu5W4UjD4oxuNEC3PJCWL
        CiqY4T5G5Av4Pa5W5NAO9yWmew==
X-Google-Smtp-Source: AMsMyM4yK8uxdLQ/SMIC+yRn7jpKMQhBAv9Eo5Pa1+/td8STOSVC5cyWO5tEBcxRCee6tSLNSicD+Q==
X-Received: by 2002:a1c:4641:0:b0:3cf:4ff3:8d2f with SMTP id t62-20020a1c4641000000b003cf4ff38d2fmr23940434wma.107.1667563569470;
        Fri, 04 Nov 2022 05:06:09 -0700 (PDT)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id q2-20020adff942000000b0023677693532sm3228189wrr.14.2022.11.04.05.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 05:06:08 -0700 (PDT)
Date:   Fri, 4 Nov 2022 12:06:07 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org
Subject: Re: [PATCH v7 6/9] sched/fair: Add sched group latency support
Message-ID: <20221104120607.feovsqj5wvzptkcp@airbuntu>
References: <CAKfTPtBJQOY7UUkm1=wvG18UWgLLiTW0dr3bTGUJY=siM_LLxQ@mail.gmail.com>
 <CD57BDD3-5919-48EC-992A-3879D8AA074F@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CD57BDD3-5919-48EC-992A-3879D8AA074F@joelfernandes.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/22 06:55, Joel Fernandes wrote:

> >> I think the interface solves a different problem which is latency of task
> >> or cgroup wrt other group. Vincent, you are setting this for a “top app”
> >> group in android in your tests, and seeing improvement correct? AFAICS,
> >> this improvement comes because of lower latency
> > 
> > Yes Top app and display group
> > 
> >> during *same CPU* competition between different groups by juggling around
> >> the wakeup-preemption window -- which maybe is good for Android.
> >> 
> >> OTOH, the “prefer idle” flag in android that Qais is referring to, will
> >> need a completely different method as I cannot see how a nice value can
> >> communicate that (that can complement Vincent's changes here). And it will
> >> need to have a per-task interface as well. We have
> > 
> > Why a negative latency_nice value condition can't be used ? or latency -20
> > ?
> 
> Ah and forgot to reply about negative.
> 
> Maybe, but it’s still a horrible overload of the meaning of the value. I am
> not terribly against choosing negative value if there is consensus among
> everyone. Qais?

TBH I think the whole notion of 'nice' is confusing. From my experience talking
with some game developers they didn't know how to use nice values or what they
exactly mean. Given their target audience is a large diverse range of devices
with different spec, and that they can only lower it as increasing it requires
privilege; how to decide the right value to work reliably everywhere?

latency_nice might suffer from the same problem. But I don't have a better
alternative to suggest. I think that was the worrying input from Peter and
Thomas; these numbers could appear like magic crystal ball from users
perspective but I haven't seen any new discussion in spite my attempt to stir
it.

As we brought up in another email thread; I think CFS notion of priority could
be improved and it could lead to improve this problem by product. But this
won't address problems like load balance search times that were brought up as
part of this latency discussions in the past.

So short answer is I don't know :) I think the interface and use cases should
be discussed more still.


Thanks

--
Qais Yousef
