Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D49704543
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 08:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjEPGZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 02:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjEPGZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 02:25:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D360040F0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 23:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684218222; i=efault@gmx.de;
        bh=Kr9RAA1XL77KfiiWaPaC9YRr66qWut9m39scyfpiSOo=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=qnf7dh2iKyX+DFNjAMovVCrc8NHnBD+u5xdm4o/jhsQMztKLw+2d6BVyOX+nFzZjF
         NdpLyUOk5qA8nsrTmvS1Soei6Kuv//7Tykp+Uf6VIFSPAAyGdWV/Z6ldS4CBksPq8w
         8pojPMz9NbcTd9OCJFnxMxJ9Yao9TFSA1VUHxaG7WILkRln0Mlo5VIKUPBo1W9aYGA
         sr4mEo+H6pq+pfxmdI1IV+xh9gzruFxab+Viy8GOCW2GUKAXBkFM0zQvLVjJlMyF1w
         bSagzNE0xr+VDXlghjhLWOtcjKIar54odnFViFkvsoFi9ea/Pd4yrvZOS0DwLWNgc6
         rYBuA8QNmOoJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.150.139]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRTRH-1pmWPT2phl-00NOGk; Tue, 16
 May 2023 08:23:42 +0200
Message-ID: <19664c68f77f5b23a86e5636a17ad2cbfa073f78.camel@gmx.de>
Subject: Re: [RFC PATCH] sched/fair: Introduce SIS_PAIR to wakeup task on
 local idle core first
From:   Mike Galbraith <efault@gmx.de>
To:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
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
Date:   Tue, 16 May 2023 08:23:35 +0200
In-Reply-To: <20230516011159.4552-1-yu.c.chen@intel.com>
References: <20230516011159.4552-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aWEk6ZBe8l6Ell80IZQWqCUXUa6tsLBRON/apxD3nLnH1w/q1jT
 zCrdr3ByR5QqjRU0qav0SpatIsY0PwjqykWgF/x01mHv8czEzfZNF8e5Y0/2S2YJIM97K/3
 WoWxeSvzKZaeR0plbeUdKcJBte7+hizQUFInfZki2f/ib/FvSZaC/tLqkicBRsV7go7R5SR
 O7cHPK4e4xNnwnwl02A8g==
UI-OutboundReport: notjunk:1;M01:P0:EH7DTAo6Ok4=;j94Q2GnCzGq3azQf28yRrOULxBh
 j11yDjgpGDo0eHzNMvdjhv1w3G45ugnwENxym7+aO94ZFY1AnCXAVHigiM8PA8LUy5gcqo6/2
 XI6vAPgqvmp0hqPxO1xE0fmI/vJl7/BFWocvD8TjP5GLX9DjwA2LskKvfguAcd3ATnpyr93SI
 UQ+BUfnXMvXi4seGqxy8Aqt9F62qdTt0DJs8LejnzeEOZwPh9cV9TJie9tB4zG09PKJdpBmXv
 dq2DY+m0WovSA1aTuWlJk2zr9xI0QS62k1lxaRx0J6+VToJu+lZC/5SccjKqSdYs6dP3T2MuB
 WGqS9jw1vBtYzPkWjZA815Kq/FrMxA2ZeK1QSnrlVPjFCfg6NLfflkGJU/f91FxkOARjvbA3C
 Ohbs+ymhyGtpSjcwVFb66VH0sDWSTL4K3ePAZEDdPyoQRk2uwc/Yd+USHP8He1wvqCVTvryHv
 lx1gOqWIMOnE+ch+pibOiwH0Cklaj0PCr1hA3PcdhUQTOakF6+PWENYxRYz3JsmQA5KNr++8p
 YReOMBFL07KsyCEQliTKoNF2MTkiwChc6ODm06ZW5K6i491ArkXOlIqqXfh0kq4SSrOIZ3AnF
 bwBL8whAeXWdHmwXvDRb9a1W7v3AhH1X5YFc5NofO9gqqn8amJ/JWIAv3r1Htug6fshlVYtH3
 7cG3+VWsGeJYtY0y9qxysPLplHtu9CxuY/UjrIFrYZ5XF2oLlXoLltcXRadeTHUr24d3PXa9I
 TpF8N69Wl4bwopS4wuY7dBscFCSHMajh4e7RgjD4lVw3uG1dXGxRo0sUOSLrUEoZo4sRz34cV
 s4u3JELT5nSkNO9faPB6w1WEA9yG6Lc2mX+wc3pAhGr5RwMDkA038kfhkzzDNgGC+DriQ1ExA
 IfQiYa4FTfi7UNPbk3Bs4yHAph0T8x6EGMIZQ9arrn+SDfoRLbEi9t7s0sOONN9sqPS9npJwE
 7l0+gc3XTjobciJtiWpUjr0/2Ww=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-16 at 09:11 +0800, Chen Yu wrote:
> [Problem Statement]
>
...

> 20.26%=C2=A0=C2=A0=C2=A0 19.89%=C2=A0 [kernel.kallsyms]=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] update_cfs_group
> 13.53%=C2=A0=C2=A0=C2=A0 12.15%=C2=A0 [kernel.kallsyms]=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [k] update_load_avg

Yup, that's a serious problem, but...

> [Benchmark]
>
> The baseline is on sched/core branch on top of
> commit a6fcdd8d95f7 ("sched/debug: Correct printing for rq->nr_uninterru=
ptible")
>
> Tested will-it-scale context_switch1 case, it shows good improvement
> both on a server and a desktop:
>
> Intel(R) Xeon(R) Platinum 8480+, Sapphire Rapids 2 x 56C/112T =3D 224 CP=
Us
> context_switch1_processes -s 100 -t 112 -n
> baseline=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SIS_PAIR
> 1.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +68.=
13%
>
> Intel Core(TM) i9-10980XE, Cascade Lake 18C/36T
> context_switch1_processes -s 100 -t 18 -n
> baseline=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SIS_PAIR
> 1.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +45.=
2%

git@homer: ./context_switch1_processes -s 100 -t 8 -n
(running in an autogroup)

   PerfTop:   30853 irqs/sec  kernel:96.8%  exact: 96.8% lost: 0/0 drop: 0=
/0 [4000Hz cycles],  (all, 8 CPUs)
=2D-----------------------------------------------------------------------=
------------------------------------

     5.72%  [kernel]       [k] switch_mm_irqs_off
     4.23%  [kernel]       [k] __update_load_avg_se
     3.76%  [kernel]       [k] __update_load_avg_cfs_rq
     3.70%  [kernel]       [k] __schedule
     3.65%  [kernel]       [k] entry_SYSCALL_64
     3.22%  [kernel]       [k] enqueue_task_fair
     2.91%  [kernel]       [k] update_curr
     2.67%  [kernel]       [k] select_task_rq_fair
     2.60%  [kernel]       [k] pipe_read
     2.55%  [kernel]       [k] __switch_to
     2.54%  [kernel]       [k] __calc_delta
     2.44%  [kernel]       [k] dequeue_task_fair
     2.38%  [kernel]       [k] reweight_entity
     2.13%  [kernel]       [k] pipe_write
     1.96%  [kernel]       [k] restore_fpregs_from_fpstate
     1.93%  [kernel]       [k] select_idle_smt
     1.77%  [kernel]       [k] update_load_avg <=3D=3D
     1.73%  [kernel]       [k] native_sched_clock
     1.66%  [kernel]       [k] try_to_wake_up
     1.52%  [kernel]       [k] _raw_spin_lock_irqsave
     1.47%  [kernel]       [k] update_min_vruntime
     1.42%  [kernel]       [k] update_cfs_group <=3D=3D
     1.36%  [kernel]       [k] vfs_write
     1.32%  [kernel]       [k] prepare_to_wait_event

...not one with global scope.  My little i7-4790 can play ping-pong all
day long, as can untold numbers of other boxen around the globe.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 48b6f0ca13ac..e65028dcd6a6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7125,6 +7125,21 @@ static int select_idle_sibling(struct task_struct=
 *p, int prev, int target)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asym_=
fits_cpu(task_util, util_min, util_max, target))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return target;
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If the waker and the wakee=
 are good friends to each other,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * putting them within the sa=
me SMT domain could reduce C2C
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * overhead. SMT idle sibling=
 should be preferred to wakee's
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * previous CPU, because the =
latter could still have the risk of C2C
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * overhead.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (sched_feat(SIS_PAIR) && s=
ched_smt_active() &&
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 current->l=
ast_wakee =3D=3D p && p->last_wakee =3D=3D current) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0i =3D select_idle_smt(p, smp_processor_id());
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if ((unsigned int)i < nr_cpumask_bits)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0retur=
n i;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If the previous CPU i=
s cache affine and idle, don't be stupid:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */

Global scope solutions for non-global issues tend to not work out. =C2=A0

Below is a sample of potential scaling wreckage for boxen that are NOT
akin to the one you're watching turn caches into silicon based pudding.

Note the *_RR numbers.  Those poked me in the eye because they closely
resemble pipe ping-pong, all fun and games with about as close to zero
work other than scheduling as network-land can get, but for my box, SMT
was the third best option of three.

You just can't beat idle core selection when it comes to getting work
done, which is why SIS evolved to select cores first.

Your box and ilk need help that treats the disease and not the symptom,
or barring that, help that precisely targets boxen having the disease.

	-Mike

10 seconds of 1 netperf client/server instance, no knobs twiddled.

TCP_SENDFILE-1  stacked    Avg:  65387
TCP_SENDFILE-1  cross-smt  Avg:  65658
TCP_SENDFILE-1  cross-core Avg:  96318

TCP_STREAM-1    stacked    Avg:  44322
TCP_STREAM-1    cross-smt  Avg:  42390
TCP_STREAM-1    cross-core Avg:  77850

TCP_MAERTS-1    stacked    Avg:  36636
TCP_MAERTS-1    cross-smt  Avg:  42333
TCP_MAERTS-1    cross-core Avg:  74122

UDP_STREAM-1    stacked    Avg:  52618
UDP_STREAM-1    cross-smt  Avg:  55298
UDP_STREAM-1    cross-core Avg:  97415

TCP_RR-1        stacked    Avg: 242606
TCP_RR-1        cross-smt  Avg: 140863
TCP_RR-1        cross-core Avg: 219400

UDP_RR-1        stacked    Avg: 282253
UDP_RR-1        cross-smt  Avg: 202062
UDP_RR-1        cross-core Avg: 288620
