Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76872709609
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 13:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjESLQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 07:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjESLQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:16:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F3CF1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 04:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684494924; i=efault@gmx.de;
        bh=E/4adR+S0vmJtNbVyAmXF2FXo/RyNgMDbRUKb99wMAU=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=TeEnlMo8LSYBfQTqHq3feeEdPyEOPh8YBgtcGs2ZNwF3TTWYWGsn2vxgWQvnPUq/1
         eyOt5AGPv+m2xLmNNIDyBAwxmsGJm4y6lT3JkYT7ogWATsfshTiRp9IPdv12QYMpbl
         7BQZfos+3MlOuSe1ic9ro+CJGIWg22rm1QiwqrUneMay4+xK8UOR02o0nQsLZ5F4Q5
         QHkSxF8fiE/LEu7EwysMcJYp8VBn4yrX1hqybujTlRd8FW8otEBSyowgiAbKExSJbs
         RCNfeVn9bafqxAb7fPS11BX4q+0DXf+2z81BeyS9Tl7dRh/jT1Is9ULrqZft+BQxqK
         fYuAUdx7yv/Zw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.151.60]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJE6L-1pjfJQ2rdL-00KdLu; Fri, 19
 May 2023 13:15:23 +0200
Message-ID: <6dcab05a3ef63bd3c1c9c32c43ad9373d46f9a71.camel@gmx.de>
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
Date:   Fri, 19 May 2023 13:15:20 +0200
In-Reply-To: <ZGWeg6UaZ3WJ6ykI@chenyu5-mobl1>
References: <20230516011159.4552-1-yu.c.chen@intel.com>
         <19664c68f77f5b23a86e5636a17ad2cbfa073f78.camel@gmx.de>
         <ZGNBt7vWJ3fDs5Sc@chenyu5-mobl1>
         <795a6d9475ecb444d219a9d36dc93b48a69e960e.camel@gmx.de>
         <ZGUHa+Si4dJbdsZN@chenyu5-mobl1>
         <a2a4cd5b398390dcf01b800c964b80c6eba89d18.camel@gmx.de>
         <ZGWeg6UaZ3WJ6ykI@chenyu5-mobl1>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:phHUVORzQ9XSzmG8cLbj8Qzk5vBr1RA69Lx8gNUVRhGM8U5xCFK
 5ZhbfxrNyxq6yf5FaCfEpHEC+U+fh6e2nrBBdzt2RBnUatYSweU2movDaFg3dd4IVWF4r1W
 i34zREiiOb+Lf/Cc+qiUMqHowe0E8v9SOJcca/aKYO3CNa4BRH3/Fzh8D0otLTBZpV+Z3d2
 ZzfrLLnEcH67a56NPwSxw==
UI-OutboundReport: notjunk:1;M01:P0:AemU57SKuG0=;lm6/5thNP5rdljbhstw1Gr1hwXn
 gO2pP6XbXZxRGaE8EfY0g+dSw5SqoYHtieTfPPhoril+jruaLX7tQkp3lsN+/rp2fArm6L9kW
 nySyFVMt7nd4SWge4prIkhqfZ1yhlzOhAU+8BRJjixusUWP7u+RMyCqWUvZmSXU+hdFTYGInC
 xpyj1zgjTwB4HwXvwniX9bnaS89SwrgDUi6pf77GJIOVsCXwAKck0Ej1O55WFfKvm2ohwHcXZ
 r7cg8X+tR0eUR/CYKgBZENZmounrkovUxAxDWJD9yex+ehXAyCoZmImlxLYPlbi9SYcYzLMU7
 Tp1fl+qb5o0cAyWa9X/LcG47bKFF1gfetLNtbUKJtFro5yzodsF4LJR3hlfjbEk+7jbFySVHH
 NZDyBpSh4jLrYpKFSkzSq961zvNw0qVmVKJBv/Unwka5OQlYtiPce9VpuoPUdtICsdg2LihbL
 fZK+dPeFseBGcXKg7rN8p8qrRKg4SEmwaONRt7SVdQ6Z+vrpJMbeytRDX86PJ9tqxVNI/QWES
 Rm7pnJKznFAOqSY1L85mZv52WkFzQoP3CEh8a1Hi8KydkXziG7oN08DrHQKy/Lq2MKuR3Q2gH
 AbIsflblDIIDJX2ujyL2ALKrrKYH7BonTJn8rnkm0q5iT55rwtcyD09saD8RdEQiCf7KjeKL7
 jmLMyP+RYIz/5P7Kqdlk3WlqqhhTyGpwiLsf5D66CbAI/0E3G55RV3UaZje+Nndg4lgmfF21J
 31J35PYkCKVdFApL6EIe7ECbJ6j73qeQ500zcK1M0DF7+gknQxxeAa4NRaFReSEslQBTul2kB
 jxriTQC2duOEKNeBESs6rCsGEvg1kCxet3izF++k2wo3j1NNIawAQPJvdAdx/BsPqRPmjXh6y
 CJCOfLeswatBn2Nqv1l3u8TWMlwg6tZ2N528FOn2/blFcTowHLg5d67C/jE/y/QqkjiZ2JRCO
 ODZhBWttn1W63Ranz2apj9xRPDg=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-05-18 at 11:41 +0800, Chen Yu wrote:
> On 2023-05-17 at 21:52:21 +0200, Mike Galbraith wrote:
> >
> > That said, I don't like the waker/wakee have met heuristic much either=
,
> > because tasks waking one another before can just as well mean they met
> > at a sleeping lock, it does not necessarily imply latency bound IPC.
> >
> Yes, for a sleeping lock case, it does not matter whether it is woken up
> on sibling idle, or an idle CPU on another half-busy core. But for the
> pair sharing data, it could bring benefit.

That reply keeps bouncing about in my head, annoying me enough that I'm
going to reply to it so I can finally stop thinking about pipe ping-
pong and the risks of big socket only issue mitigation patches.

The object that inspired SIS_CURRENT, which then morphed into SIS_PAIR
is in effect a mutex.  The numbers derived from operation of that mutex
are not really relevant to IPC or context switches for that matter
(says me;), they're all about memory access cost deltas.

	-Mike
