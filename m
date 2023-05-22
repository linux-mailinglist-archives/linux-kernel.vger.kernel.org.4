Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E83970B609
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjEVHNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjEVHMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:12:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E107E1BD5
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684739436; i=efault@gmx.de;
        bh=MN9okEE06pBVefU8h4pwJqs5xhgn5P1o7o7Sgao7spY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=sNCppw5WX15R+KIbyQIPH7lh67mRtW1Z45CPtrIvwx9KQjRrR6J/eeeBQ+m5TvFeA
         806jgzaA+VDtjNoT5Fr4W2GeBiq+Iurcgad+PX0d0Uxb1adQ1XGDTrEJrKM8guGrZD
         EZphY/OhbtsSVEDyHBK+w+QB4J8QSJdSljhklKx6c3dtANoObDvUjQjC9SVEoCvOe2
         8t7ntaHqAPhf6wTj+q4ZVLNLUPogpnHRIPq5Iyqu+7baaDd2B1XpBuCjqEKnIHJt37
         2bGJV9YAkPSmzVL1UWYXMZdIO3KjhDWHheALnrCMG8kIRsr3YElbJfsgoxFlnWhikV
         k+Xdu8mc8gmLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.219.131]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJVG-1qfGBu1N5C-00fPJ7; Mon, 22
 May 2023 09:10:36 +0200
Message-ID: <5ffb7ebcc75c106d791d4b5c4dece4b74c551245.camel@gmx.de>
Subject: Re: [RFC PATCH] sched/fair: Introduce SIS_PAIR to wakeup task on
 local idle core first
From:   Mike Galbraith <efault@gmx.de>
To:     Chen Yu <yu.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Date:   Mon, 22 May 2023 09:10:33 +0200
In-Reply-To: <ZGrrUVZBY6qqeS0K@chenyu5-mobl1>
References: <20230516011159.4552-1-yu.c.chen@intel.com>
         <19664c68f77f5b23a86e5636a17ad2cbfa073f78.camel@gmx.de>
         <ZGNBt7vWJ3fDs5Sc@chenyu5-mobl1>
         <795a6d9475ecb444d219a9d36dc93b48a69e960e.camel@gmx.de>
         <ZGUHa+Si4dJbdsZN@chenyu5-mobl1>
         <0ac968e3-cd80-6339-970d-37005876b145@amd.com>
         <ZGWmveL2YTiXp2XR@chenyu5-mobl1>
         <12061140-4f09-b83f-843c-2fb8ff9f6e81@amd.com>
         <ZGrrUVZBY6qqeS0K@chenyu5-mobl1>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dKkZR+a9zjrN1hR6w4R2A1GvFNwa4RAcEuAjZbnisNjS9/4I+V2
 VOiowVk9PNjGYmRIldYDpgYmqBRN+bPEJ7spA1Z9oGyaKoHgVT/KUuumLwbvLWB0D+SSWIC
 CZILVLLk4ZJQDWSNcK7vnwu7avYw8SZUSuVJt/e3FO1E5rlYaTKnAVaix52g+f+467/JxpT
 Y7DpIzWMCkeOQfTtvQj+w==
UI-OutboundReport: notjunk:1;M01:P0:DEeaW/FeMj8=;txeV46sf0K9oCdxYVmTyIKRbnxz
 AsP+jyK6QstlT3TgsrtaXoNuHW9QkgaL0YcDgxgdeNueFutqqppy+I7TB0MXwixcduC4VrFex
 Rloj0E/FHz8PH6oCKavzdRdEHOnBpLUkIAgBo1SzdiaxQ236tTmBDakMW2/f2DaedL937aV8L
 43E3ZxyPTyHWLIPg4SorbkZu/jN+s6gcw03ElbDni/LdTskG4KCU8B9Tyyc2Ml2ZVqsYprACY
 gby3Q9ksPBZPXDSo61ntmrQhHTf9vRb1QPSnNMozXXir4pvmAuUhsmyH9I0CGD3e9hRkqs8jZ
 KgTs1uWssmjrABeROl0h9UEVHJovEp6dAjxGHAVuAMhNsm2IOwbeZRwonP7oJh6dKubkLekIa
 Lr0AbxYtDE0+pkCSwKpbRCXjErps2oM/EuVp8CHenN/2YE+0Mr6nqoRv8WiVyPGEiQtz1gXEj
 oJk/xLxEXr+90ANKEJKKmwOr685ecNgUpfVA7QUGTV/d4XTKAmbOJsbAgb4QsA26SIqt3BTiB
 A4azS5cI9DI9pxq4xkepU782ggpY82DkOM23vBghx3aXK1o0KgwuR7/Rv/IYu/pa3gnuzciNE
 X/afTWMX1GNEwP5qAFRTFelX8gLzrgkLhGTmni1uHdSdPhDJv1EiIhCkFd9nJVnWtGPog+fLe
 MDl70c9Mp8vJhyjqUFaGXghXfzr0uYXIl7F1Pf5CSlfL/3TVuUYqXZFs3R0glL4K4+7wm7tFP
 ZxKaBkLTdRpLc8hSO6noYnKeEM30B+PJrexqQqNwoB8OPFmq9bja9X01nG19SyDbQGRRt613Q
 EeQpU9/ogP6G5e+aM8iqLXs2TJW/NKXJcXb2zcSFcZqirUx4s0whb1CdHYBgDkWH4e8hcW0QB
 WXtUQ/dXzwJFCTmKRr2UPnWrZyCE/U8E0ZlDB54dS+X1+dYjISqRQV3xujQZavKmKT+Sj8BHf
 L8zHqeQX0Je4Imyhc3sbwanOUno=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-05-22 at 12:10 +0800, Chen Yu wrote:
>
> Meanwhile, I looked back at Yicong's proposal on waking up task
> on local cluster first. It did show some improvement on Jacobsville,
> I guess that could also be a chance to reduce C2C latency.

Something else to consider is that communication data comes in many
size chunks and volumes, and cache footprints can easily be entirely
local constructs unrelated to any transferred data.

At one extreme of the huge spectrum of possibilities, a couple less
than brilliant tasks playing high speed ping-pong can bounce all over a
box with zero consequences, but for a pair more akin to say Einstein
and Bohr pondering chalkboards full of mind bending math and meeting
occasionally at the water cooler to exchange snarky remarks, needlessly
bouncing them about forces them to repopulate chalkboards, and C2C
traffic you try to avoid via bounce you generate via bounce.

Try as you may, methinks you're unlikely to succeed at avoiding C2C in
a box where roughly half of all paths are C2C.  What tasks have in
their pockets and what they'll do with a CPU at any point in time is
unknown and unknowable by the scheduler, dooming pinpoint placement
accuracy as a goal.

	-Mike
