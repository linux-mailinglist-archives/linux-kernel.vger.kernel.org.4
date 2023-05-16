Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C91C704D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjEPLxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbjEPLxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:53:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB4F6E88
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684237891; i=efault@gmx.de;
        bh=1ebyhok+voqiCJa8OhNFROp9BdFmks1jnW3ey8BYfMI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=HquKW5LopfnP/iMHsTCE4r/JywsJrCEIfNRsQY6svkCwguGnWQYbM7vWrAXz9CwD4
         Z0TTngKyzhHt0GsE+smLMwW1OmjL1uMtxQ/e1MYNK9SXLbmoSzH4kJAqOFMvCe7dZd
         54By7LS/w1u2dpfUEs7B5fyv8ZD/F7KkonFmNh6KYno3E9Ut9GrdJVP6L3YZo5zNNo
         bWQvwmMmeU77sO726r9fPCZ4gcQaC92RIrNBzxC3mmeJK1ENUyamwGEIhtH8h412wW
         ZjPmlhSuYjFgdO842Lfi3y8dWu9FIvAQFOPBL2op50nhSNjxaYwPYWYTuqpaan+QaM
         r/UXH9TjYSN7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.150.139]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwQTF-1qHNZM2BF7-00sPml; Tue, 16
 May 2023 13:51:29 +0200
Message-ID: <795a6d9475ecb444d219a9d36dc93b48a69e960e.camel@gmx.de>
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
Date:   Tue, 16 May 2023 13:51:26 +0200
In-Reply-To: <ZGNBt7vWJ3fDs5Sc@chenyu5-mobl1>
References: <20230516011159.4552-1-yu.c.chen@intel.com>
         <19664c68f77f5b23a86e5636a17ad2cbfa073f78.camel@gmx.de>
         <ZGNBt7vWJ3fDs5Sc@chenyu5-mobl1>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A4pTR6ep2144t5wrJKcAOWtYO1JoZwcZ/goRpbiR+cGYwhhwq+B
 JmbOjNLgFW7+pHN2Wq8FUnh721tqEiH6dwe10hztdkazCLrch6V5Nyw+EDHW4tYLL9Ec/HH
 AvLMtRc+VpUIhUFCXmBPJSy/u72aKoU2M1YS8P0x/ZaKGxxnsek1F9EKk/wjXzTSODe2kPq
 Y0B1dv/KX0ACAkvtb83pg==
UI-OutboundReport: notjunk:1;M01:P0:3dq5S01HEgM=;m/rM7B8GH12glxRej1DTakfAed5
 1NVC75YOgTdxMXEZavWeAUoKZm/LZWlV+f97RLtakzjLKDZ1XYO8JRRL5p4fer0PI7JDiHygN
 bWHx4ioziKJLKDgVMWKDWESOJDxU2/88iadyNy9FF4R/MapFQXJnJrJlidAcdoItKH2Yp5Mxu
 +J0vwFQ/j4mvDzMWmv0fe6XM+trVC/B94Xq70bJyg6FDeF8ZNVd+p8eVGotjidW4860dVnl2T
 wQeH+ocbfLs+cFryunYhqzUVM5ZUVPzmXeC/bh5+MrROexFICKM52sNRDc/Q5yo5mJSrU90a5
 r1oHi/At8mXtM6DcWy6UUcWOhFKODH6IjmBC3rcZfH3yR3nwaAiSmTrAYK1r49eVCQtYTcVQe
 L5Ja4FORQDYNXoteg5Xgpl1Gjju06zwHIo4IolKNrhZ3djjBLMcDEheR6FaZX93L3l5qhQCLP
 wkS2iCTDzwxiPFc4pVK1aeW/G1zj2RJB0XpBs6vGK6k001zfsw9fRBhJdXGEEHO6CjuFKsW4d
 U0i65clA2kM7ow3cjaqXODF5a9zwkjFgVv5h3mTILocwKOwlMB9NHvAGK9rfHhQBpbfplM0aO
 6+ET52dFCcuslPBID2OI0qvwb9mkxhlkvQNWvnFTu6dIhDWG8FdbR1ED70Qa6FB2K8zXabphL
 APB2T+ayWa56TuozE7jqYQFhD0JcSsC8VVhk93jMLz4z9djQuvuvbor3giQCCqQBnx3RlILIG
 Xr0oIXDU+S1sZyvWmtsP+XooymRcMo/ihMPTlcWypDpjyHAoeiGgRp/NbAI0TNjtYDpWOpJxU
 N2aEwlJs6vF6NZnrWZqkDIMunEqnD7POotlhsUbrWOq+JHlABKPGb/LCFXIxaD4bCYcCJwYgT
 r9GbLZGC1m/YIO0MkGpeFhHHO53Yk/XOYVvaB6XF3XrCReIS4va+Y5CApgcClNeajfH1uwUAk
 TIvk3hAQuaHlKxsr8fObYDY8iGw=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-16 at 16:41 +0800, Chen Yu wrote:
> >
> IMO this issue could be generic, the cost of C2C is O(sqrt (n)), in theo=
ry on
> a system with a large number of LLC and with SMT enabled, the issue is e=
asy to
> be detected.
>
> As an example, I did not choose a super big system,
> but a desktop i9-10980XE, launches 2 pairs of ping-ping tasks.
>
> Each pair of tasks are bound to 1 dedicated core:
> ./context_switch1_processes -s 30 -t 2
> average:956883
>
> No CPU affinity for the tasks:
> ./context_switch1_processes -s 30 -t 2 -n
> average:849209
>
> We can see that, waking up the wakee on local core brings benefits on th=
is platform.

Sure, tiny ping-pong balls fly really fast in a shared L2 siblings. The
players being truly synchronous, there's not a whole lot of room for
resource competition, and they do about as close to nothing but
schedule as you can get.

That's not a workload, much less one worthy of special consideration.
It is a useful tool though, exposed a big socket issue, good job tool.
Changing task placement strategy in response to that issue makes zero
sense to me.  There are many ways to schedule and wake other tasks at
high frequency, all use the same paths.  Reduce the pain that big box
sees when playing high speed ping-pong, and real workloads will profit
in boxen large and small.  More in large than small, but nobody loses,
everybody wins.

	-Mike
>
