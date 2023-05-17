Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08D8707298
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjEQTx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjEQTx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:53:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B45F4680
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684353145; i=efault@gmx.de;
        bh=zAXFoLOajTXEmUsic4hbXuN64+R+26WPlaON6S5yV2o=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=InY58JYGwUOxMDeBhqF37iSsCjATATTRmo64tDgw55l9Gzg3sGm/pAk4gtG+Gq4sX
         HVG3V1rqxoQiwesk33xMBAvR/oVW5jvPIsG4suVnGwZ9W5j4E3UGOlksxn08SkBwsj
         IS5qzUgpafG1jaICrDdKzt6/LrUoFtWR7WnWIsKcDS0UfPtlJ1P5w41GdZY5SUTeVQ
         cHZhOHRL8MBNMthZQnT99OiJTCkNy2IDcuJVcF/v827U7ScJIJzhJEyvLSedtaPaNq
         fQWQ88PU3weUvGLSWIDPP3lIo3XPsrs7QGz8422dBZAm81Ic53YTuRFxN8lAqQZwcQ
         lX6+Cgr5R+hww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.218.183]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3W0-1pjVXK3DkE-00LW1n; Wed, 17
 May 2023 21:52:24 +0200
Message-ID: <a2a4cd5b398390dcf01b800c964b80c6eba89d18.camel@gmx.de>
Subject: Re: [RFC PATCH] sched/fair: Introduce SIS_PAIR to wakeup task on
 local idle core first
From:   Mike Galbraith <efault@gmx.de>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Aaron Lu <aaron.lu@intel.com>, Barry Song <baohua@kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Wed, 17 May 2023 21:52:21 +0200
In-Reply-To: <ZGUHa+Si4dJbdsZN@chenyu5-mobl1>
References: <20230516011159.4552-1-yu.c.chen@intel.com>
         <19664c68f77f5b23a86e5636a17ad2cbfa073f78.camel@gmx.de>
         <ZGNBt7vWJ3fDs5Sc@chenyu5-mobl1>
         <795a6d9475ecb444d219a9d36dc93b48a69e960e.camel@gmx.de>
         <ZGUHa+Si4dJbdsZN@chenyu5-mobl1>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EJg82i2kMTUg9lieo5qfK4GQxONkuxsN8roMHmtqhL7sRu07Rku
 H6lQfsRkE2uf5TD1eZ8Di63Svo8dEVFLhIH5Zen3rMGiv0rUpitkyTYLiEbSGTTXsVZ06Uw
 7jXSjP0hTiET4YsgHL8zGkviHu4vGbZde3Oaus7m3sjDB1IzNw6aiWJr/HgHElIuO42anyk
 9cGBsP4egHezfVTENxoSg==
UI-OutboundReport: notjunk:1;M01:P0:ns0GJxB1Wbc=;/J5eMQ+N9Z05Xr/7p31NoSmyCS1
 XU1fkr67v7H2Y0Cqb9uZTlNFDeqi6AJv9H1TxZOmFKqZzL3++kuiBHtPaIiDnNKAaOnaYe/ZF
 KnUaepsTtaMUBFUCXXZ3pxwOcHctuJFfKVh0XR164mw/EL5Ek7B+fSshK1nMGvaEPG8OtP0LC
 VRsZTcp2XKKIK8K1v4/VtAWtC4Dsbjn9Nl+d28Puz+zp8BTokAC14ydZFD+UPH/qt598LCM4g
 xaZEu7ubr9yPK3fX8AtUFR9pkqtAVQKWHdtjdyFx6rE/bwuhuppjInmJRSTyfOecseZsxyeJi
 RqPwzIKRcShNVOW6xUFQnhRXPy0HO3MF5PqjPgK6B2GCTSyt9ct9gpIR3d1daep8a+yKY+8e5
 hZ7nN+b2jv2PMOdOt8/p2dLVT4Xcq8BV4NyPq1Q+V+HOd4DzicwRWsn/VtvqKHGvONIOJQNax
 44BN3YPAZPtZ3KKl3MMU1V7wJKkjKSXWLV/ZZjbnwUaaCDWOueKzLjtP1LjJKlmYHJEPvDgGo
 xp80+6fTbKzHUOSOlAOW4ZC6KOHMrRBdilOCpFJ0mdoddDappaAVCcnT3JpMVE5rPUafe1V+Q
 bynIcbdQhEuMFqrS01mQ1BadiJ/WOQp91UnIqKRHWJ0nBQLODsqJHHRMENuWJnd3r3/gJYW7y
 fNfBK3fI/nx91VIu5Ib1xTVssFyWuVrrl/6WrowklJoOfuwfW+hKtg0yPETzbhofzDOT4rbyU
 ndhuAFou90PCvD5eMHRC5f5cNvwuHQKCrfm6KpsqRvS9JzMTnoZ6mjJpvmBwq+Cnx9lizN6/e
 3WnWeXMPZ9seLirTcvWT2SLcaGrTYfZjWtMi9L6TfxmBzDFxNvUKUOY/nBvo/mI0kMKBIgvJv
 0m+99m4rV32DVJ4jOA0/S2Y1+q9wDsItVGy19iumxE/De8Ik4A5luidux33U7p0ue2sIDj672
 IR9lbiHiFw7XL75lj8c0xPUpFS4=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-05-18 at 00:57 +0800, Chen Yu wrote:
> >
> I'm thinking of two directions based on current patch:
>
> 1. Check the task duration, if it is a high speed ping-pong pair, let th=
e
> =C2=A0=C2=A0 wakee search for an idle SMT sibling on current core.
>
> =C2=A0=C2=A0 This strategy give the best overall performance improvement=
, but
> =C2=A0=C2=A0 the short task duration tweak based on online CPU number wo=
uld be
> =C2=A0=C2=A0 an obstacle.

Duration is pretty useless, as it says nothing about concurrency.
Taking the 500us metric as an example, one pipe ping-pong can meet
that, and toss up to nearly 50% of throughput out the window if you
stack based only on duration.

> Or
>
> 2. Honors the idle core.
> =C2=A0=C2=A0 That is to say, if there is an idle core in the system, cho=
ose that
> =C2=A0=C2=A0 idle core first. Otherwise, fall back to searching for an i=
dle smt
> =C2=A0=C2=A0 sibling rather than choosing a idle CPU in a random half-bu=
sy core.
>
> =C2=A0=C2=A0 This strategy could partially mitigate the C2C overhead, an=
d not
> =C2=A0=C2=A0 breaking the idle-core-first strategy. So I had a try on it=
, with
> =C2=A0=C2=A0 above change, I did see some improvement when the system is=
 around
> =C2=A0=C2=A0 half busy(afterall, the idle_has_core has to be false):

If mitigation is the goal, and until the next iteration of socket
growth that's not a waste of effort, continuing to honor idle core is
the only option that has a ghost of a chance.

That said, I don't like the waker/wakee have met heuristic much either,
because tasks waking one another before can just as well mean they met
at a sleeping lock, it does not necessarily imply latency bound IPC.

I haven't met a heuristic I like, and that includes the ones I invent.
The smarter you try to make them, the more precious fast path cycles
they eat, and there's a never ending supply of holes in the damn things
that want plugging.  A prime example was the SIS_CURRENT heuristic self
destructing in my box, rendering that patch a not quite free noop :)

	-Mike
