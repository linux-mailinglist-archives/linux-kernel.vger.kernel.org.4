Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4FC6F2601
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 21:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjD2TfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 15:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjD2TfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 15:35:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019FC1731
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 12:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682796856; i=efault@gmx.de;
        bh=8i8a3fwQygQMSd1A2c/AJxJ26izwjiU8gXEmbSVLhDI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=TlN06C7M+bTEDuMpNckyqx8aKiRo8HzGhonWFQZHbLaKeE4u0w08fCP202XDVmRZL
         y1eWppqS8/aRZO79h0LDEd0twvPN9lB9jXbmC3vj8olruZ3ysfMXnoiIpvst9K3aB5
         0M7OoYZPQYsy2aPTnYO1vcoSKKRw1wtwUSqfEfs8jm/7PskUyAU0ftyUvc5BNbXrrT
         y+cBKMAxgdGwLzw8C3C0QnqZKe90Z5Osq/VWj3ZWfrHdVfYZ/NsZrvSWHMLAMTazLy
         c3/MbEziS2HC+hbROWhfD5I6dksVBbmfvq1yDLmpNjlElVq2s4T2499Wk7nYtrCsAi
         8uJqpFlb6usmg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([212.114.172.88]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNbox-1pddvX2CTr-00P7ok; Sat, 29
 Apr 2023 21:34:16 +0200
Message-ID: <66406be50c8e040870217f5c9131b901d4dd2013.camel@gmx.de>
Subject: Re: [PATCH v8 2/2] sched/fair: Introduce SIS_CURRENT to wake up
 short task on current CPU
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
        Ben Segall <bsegall@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>,
        kernel test robot <yujie.liu@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Aaron Lu <aaron.lu@intel.com>, linux-kernel@vger.kernel.org
Date:   Sat, 29 Apr 2023 21:34:06 +0200
In-Reply-To: <4081178486e025c89dbb7cc0e62bbfab95fc794a.1682661027.git.yu.c.chen@intel.com>
References: <cover.1682661027.git.yu.c.chen@intel.com>
         <4081178486e025c89dbb7cc0e62bbfab95fc794a.1682661027.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YB5FWrdeJEfux6Qt1sIUThKjv3ZOMSnwXlCvnjy45Ntc7EujCjV
 u8XhZod6yf2nXkUUe1je65WSMTfelusaErI6Eg/NRZNRMj/UvrpXx3LzWk2bafq768Zqd66
 Oo/6wROo9GlcFYvSg6YoKqlagiao2HbNL7GBXs7lMjLaGAvuIkSPGmlNA4o9FFuy9rua5Wn
 CWgMJdFbesMsLBDjcGXJQ==
UI-OutboundReport: notjunk:1;M01:P0:1Im9BOJnHKQ=;COol0a84Euh9IgHVXqFqISCjTQ1
 zWT9afR0Ql2GanHaTvBpluyJ7PFYxLRj6hzzDARS8Q3pXpSmKyCy7GJHHS0QrAZDlBLZPDWx/
 8CiL/D83rOOGe/CUL1tEpWq7FPxidBlOSUHEcCNCtl+AJVpJPCYkmZNGrSuB30vOQtJB6F2AE
 whggZ1rXjD/FzHBiaagCOGl3G2G7shNWhdcSwmtDLBjK7cW8R8xFIUrsRvk0D/lGPB7cUI5is
 OUuK61O+b828ZFkPtJKITBbgXCiZ8c0E1mrfs2WCyYLI55akJqW0HOJY34rUS88KJS3atjbag
 0g5H83jTynRdf8ktXo/oVlkjlKxl90SGgZ6MR/6gzZU/NEmIvtTxU54qrDbIV5wAG5oEEhh//
 uWsd5kH2wKdR9FNvIMTSYP218+U3Ps7wY2S3NJLcyj7LoRL0jDPYZpMlndqi8xokuo2KgN27x
 QoBViblepuKMO3x/H9D7awC07Ez5rkVHPohlXUXA2VDz+PkZp3wltNO/VQYEniTY1C5XzbAJz
 +xlRMJjD435SV2lozdQn1wpfS5qFeY1+uVg3v0vUN3roMxApO42E7D01uwwZnxY5f4+aFYouq
 6ubX3OkTR8gHsPdUz2eSl+kyxB+6GpCNI96kVi8vrpmwKxA2lVCzZ8rWnqA7dh6NhHjFJvgyd
 Jb1jRBYa0SJNJw24pt/9QwbnxMekowqrUM/ipNJ1T5dWisb17J1DllqERJRGNgpj55V46R9U0
 88rH32syLTaI7oSNCvQrHruhItl9oDfT+BcKu07BSmrDtGrKBomhGg8qIARaYp015hBnniA0R
 5TCB3PVkFVr4LQSkFaFHmS/QsIv3z8aVvttJT3OAoYZLWgTbTKKmfIV3Wc5P7ecnLoCDSEH0K
 f6wmTTi33nVkm0T+zw+BXsesZCldA8JcGcq2fTpJZsT0CvpuMd0uzC3y+1hDGc++lRn91fOyx
 4NGd0ysrP7kNBNfZqOgbh1zSN20=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-04-29 at 07:16 +0800, Chen Yu wrote:
> [Problem Statement]
> For a workload that is doing frequent context switches, the throughput
> scales well until the number of instances reaches a peak point. After
> that peak point, the throughput drops significantly if the number of
> instances continue to increase.
>
> The will-it-scale context_switch1 test case exposes the issue. The
> test platform has 2 x 56C/112T and 224 CPUs in total. will-it-scale
> launches 1, 8, 16 ... instances respectively. Each instance is composed
> of 2 tasks, and each pair of tasks would do ping-pong scheduling via
> pipe_read() and pipe_write(). No task is bound to any CPU. It is found
> that, once the number of instances is higher than 56, the throughput
> drops accordingly:
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> throughput|
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 X
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X=C2=
=A0=C2=A0 X X
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X X
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 X
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0 X
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 X
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | X
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +----------------=
-.------------------->
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 56
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 number of instances

Should these buddy pairs not start interfering with one another at 112
instances instead of 56? NR_CPUS/2 buddy pair instances is the point at
which trying to turn waker/wakee overlap into throughput should tend
toward being a loser due to man-in-the-middle wakeup delay pain more
than offsetting overlap recovery gain, rendering sync wakeup thereafter
an ever more likely win.

Anyway..

What I see in my box, and I bet a virtual nickle it's a player in your
box as well, is WA_WEIGHT making a mess of things by stacking tasks,
sometimes very badly.  Below, I start NR_CPUS tbench buddy pairs in
crusty ole i4790 desktop box with WA_WEIGHT turned off, then turn it on
remotely as to not have noisy GUI muck up my demo.

...
   8   3155749  3606.79 MB/sec  warmup  38 sec  latency 3.852 ms
   8   3238485  3608.75 MB/sec  warmup  39 sec  latency 3.839 ms
   8   3321578  3608.59 MB/sec  warmup  40 sec  latency 3.882 ms
   8   3404746  3608.09 MB/sec  warmup  41 sec  latency 2.273 ms
   8   3487885  3607.58 MB/sec  warmup  42 sec  latency 3.869 ms
   8   3571034  3607.12 MB/sec  warmup  43 sec  latency 3.855 ms
   8   3654067  3607.48 MB/sec  warmup  44 sec  latency 3.857 ms
   8   3736973  3608.83 MB/sec  warmup  45 sec  latency 4.008 ms
   8   3820160  3608.33 MB/sec  warmup  46 sec  latency 3.849 ms
   8   3902963  3607.60 MB/sec  warmup  47 sec  latency 14.241 ms
   8   3986117  3607.17 MB/sec  warmup  48 sec  latency 20.290 ms
   8   4069256  3606.70 MB/sec  warmup  49 sec  latency 28.284 ms
   8   4151986  3608.35 MB/sec  warmup  50 sec  latency 17.216 ms
   8   4235070  3608.06 MB/sec  warmup  51 sec  latency 23.221 ms
   8   4318221  3607.81 MB/sec  warmup  52 sec  latency 28.285 ms
   8   4401456  3607.29 MB/sec  warmup  53 sec  latency 20.835 ms
   8   4484606  3607.06 MB/sec  warmup  54 sec  latency 28.943 ms
   8   4567609  3607.32 MB/sec  warmup  55 sec  latency 28.254 ms

Where I turned it on is hard to miss.

Short duration thread pool workers can be stacked all the way to the
ceiling by WA_WEIGHT during burst wakeups, with wake_wide() not being
able to intervene due to lack of cross coupling between waker/wakees
leading to heuristic failure.  A (now long) while ago I caught that
happening with firefox event threads, it launched 32 of 'em in my 8 rq
box (hmm), and them being essentially the scheduler equivalent of
neutrinos (nearly massless), we stuffed 'em all into one rq.. and got
away with it because those particular threads don't seem to do much of
anything.  However, were they to go active, the latency hit that we set
up could have stung mightily. That scenario being highly generic leads
me to suspect that somewhere out there in the big wide world, folks are
eating that burst serialization.

	-Mike
