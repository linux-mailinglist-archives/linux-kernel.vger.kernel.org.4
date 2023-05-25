Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB70A7108FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbjEYJe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240444AbjEYJeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:34:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D38E4B
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1685007193; i=efault@gmx.de;
        bh=dzmGJbT9vNfENkU55MdWdhIPKYqJfzUidx6T+yitQTY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=OnhzaCti1/1qeJlfMnlCSjhSQuY9sNonlb95Lz9rsax6aRKJLQdG7VxYEgtGp5r2J
         mYkw1wB4zxptB+HK7Q4qP1yOEZO2ZDIlBgcWLcjkKbstTi3VI0+W7R98jWn5rUG/Du
         494NvUQSqGOhnp7nDo7/6b7yyc5iwEUlnyYcKStfbyStVXsnbkhWR1tDrspYK2EZTD
         WWIekZTx7Kvjf2FxU6Z0aaP7lmRoMpA6LFYRo1ldXGJR/R0EsPe4w5O9I4yLtDbxzh
         s6Ckn/n9LOrxAXcuvqnbhVdt+2yAZhxtx9wrAa/5qsdL/eXdwny19t7psfyd8Nvmnb
         rCfSWwgvUcgPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.150.37]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wLZ-1q3Uup3dhj-007XXu; Thu, 25
 May 2023 11:33:12 +0200
Message-ID: <372fcc546474ed280d1e200fc83deded3759da52.camel@gmx.de>
Subject: Re: [RFC PATCH] sched/fair: Introduce SIS_PAIR to wakeup task on
 local idle core first
From:   Mike Galbraith <efault@gmx.de>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Aaron Lu <aaron.lu@intel.com>, Barry Song <baohua@kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Thu, 25 May 2023 11:33:09 +0200
In-Reply-To: <ZG8SmByO0g5fjOc7@chenyu5-mobl1>
References: <20230516011159.4552-1-yu.c.chen@intel.com>
         <19664c68f77f5b23a86e5636a17ad2cbfa073f78.camel@gmx.de>
         <ZGNBt7vWJ3fDs5Sc@chenyu5-mobl1>
         <795a6d9475ecb444d219a9d36dc93b48a69e960e.camel@gmx.de>
         <ZGUHa+Si4dJbdsZN@chenyu5-mobl1>
         <0ac968e3-cd80-6339-970d-37005876b145@amd.com>
         <ZGWmveL2YTiXp2XR@chenyu5-mobl1>
         <12061140-4f09-b83f-843c-2fb8ff9f6e81@amd.com>
         <ZGrrUVZBY6qqeS0K@chenyu5-mobl1>
         <5ffb7ebcc75c106d791d4b5c4dece4b74c551245.camel@gmx.de>
         <ZG8SmByO0g5fjOc7@chenyu5-mobl1>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bXu3eUWOX28a31ftyMMXf4cKy0h12gX9iO1Tzxond1i2ZKtjkUL
 fHfap1obrjqu5+Trv9il2smV+On34ZaVxV+pumnitFn/FUcgqbDf6c1E2AGRi0qgTjzdop4
 vZ23y58FVKnHBL8RlsvXeN2voaIhIGFNaW68+wgQRpvDoisuZaJPA9nusZSA9L7TIiJHgcB
 nGsSaSa7Ak6uyG7U7WqkA==
UI-OutboundReport: notjunk:1;M01:P0:+9o+2iJ57fk=;lZTfHIMPq8rDV/OGmwxFQcr61J8
 6sv+q3RNR79SjJvd+SiES3EW8UVfe+ocFggYpACDBzAqZ9uJHwBeOEL2rSsLd6G2Ik49qS46S
 gjj/fnhPJwWhoCQvtl2oAKLkrOzDPp6pGRoFO5Y2OBqAMQw9lKA6WBEp+06i1+qiGE/0Eo4ex
 RFoWpbNFqCfhFjVCOyGg1bI6hmhVsSE0vXEQu2LnQpmJC4tnCUwmM7EJyui4eG529jiq6K8JK
 UdWhCEsE7jvIB6MBsGy+O40MA5gf3Dy7XixhZyOPLPDn6rp5fYvjUam8crRRUtEQfs7ulQNFX
 8B64fW3ik0TqBzEX+iLSMagtL/46OXbx8uQYSbvCqNVhRwcprmII52Rid12xnlIco4j7+aYEu
 JZKpwEJ37qAqqThUNycL/49WxJZCpKvJ4A56YgW+Jw1GiPUWbTHT844E6PxVmTgeZ2IC1jZ9r
 On07/0mCkgKMCD1QRdA7PuseeiAf1sbzYLQC6IJvUpUvUbg3RXvle+Rl7jMBTm3CqTrBcK3fI
 DHNOFNMtQDY183cpQ6DL1hfyKcImQ1lfeweqjedtwN0MyB0qBBSL99O3d2cEHb2GaMC6/nU/b
 AAOyiUNNf/84lq1LoT/3Ol5KLefRaWvoDhyEAvZ7c6+aLBh8i9lqVPdExAuINyurxN1aMaLOw
 ONLJcR76msxbS5SgWmg0u+Y26B2ClVeo3oLdiDhgRTyJGezPWcLXMVOGBSn+N3ZbC13umom2b
 UWZD/8UGqCiL6DJRscR/m8kZtxKjKhgENpSS7Zxd3Vby081Ik3q518SFfs3OS9FeusqjuB0rC
 M97pvkBHtY/rAikeoqZDubXGP1fQ2zvxW6b+cRHMlghMMzWYaH89uNwK7EjMLoKUAlbhZzr67
 ObnL2NtCYObTBGhWCaT3+uirTueNbRbnCV5r0IJu3xv5sgiNId1n4TjPUNnVbRCZLgrSWLgB/
 q5uXHQC+LoVI5NEhjof7XsV3sQA=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-05-25 at 15:47 +0800, Chen Yu wrote:
> On 2023-05-22 at 09:10:33 +0200, Mike Galbraith wrote:
> >
> > At one extreme of the huge spectrum of possibilities, a couple less
> > than brilliant tasks playing high speed ping-pong can bounce all over =
a
> > box with zero consequences, but for a pair more akin to say Einstein
> > and Bohr pondering chalkboards full of mind bending math and meeting
> > occasionally at the water cooler to exchange snarky remarks, needlessl=
y
> > bouncing them about forces them to repopulate chalkboards, and C2C
> > traffic you try to avoid via bounce you generate via bounce.
> >
> I guess what you mean is that, for a wakee has large local data cache
> footprint, it is not a good idea to wakeup the wakee on a remote core.
> Because in that way the wakee has to repopulate the cache from scratch.

Yeah, and all variations in between.

> Yes, the problem is that currently the scheduler is lacking of metric
> to indicate the task's working set, or per-task-cache-footprint-track
> (although we have numa balancing to calculate per-task-node-statistics).
> If provided with this cache-aware metric, the wakee can be put to a cand=
idate
> CPU where the cache locallity(either LLC or L2) is friendly to the wakee=
.
> Because there is no such accurate metric, the heuristic seems to be an c=
ompromised
> way to predict the task placement.

Nah, it's a dart toss.  With a box full of net blaster tools, the odds
may even be favorable, but who knows what the wild will do.

> The C2C was mainly caused by accessing global tg->load, so besides
> wakeup placement, there should also be other way to mitigate C2C,
> such as reducing the frequency of accessing tg->load.

Attacking that is the only thing that makes any sense to me.

> Besides that, while studying the history of wake_wide(), I suddenly
> found that 10 years ago Michael has proposed exactly the same strategy t=
o
> check if task A and B are waking up each other, if they are, put them
> together, otherwise, spread them to different LLC:
> https://lkml.org/lkml/2013/3/6/73
> And this version has finnaly evolved to what wake_wide() looks like toda=
y
> in your patch:

Yeah, I've touched that, but it's still busted.  I watched firefox
burst wake a way too big thread pool, but since worker-bees collected
zero flips, the heuristic says all is well, move along ginormous swarm.

	-Mike
