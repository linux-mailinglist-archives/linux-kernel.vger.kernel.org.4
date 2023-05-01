Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193A46F3305
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjEAPim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjEAPik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:38:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14B7FF
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 08:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682955432; i=efault@gmx.de;
        bh=JV2jwp5QqjHGEc/8VsdQAgS38Mj7layJ8b9/wvrEaLQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=g2n6lD7IOjMsiiz5JLXqn5+h/awbKuUUJq9Fe59jAdBXAzmX4vJChX7b4hoc7jo3Y
         b21ENqrVZvlU6e53mfgSOEEuJP+/qG+5P6AqXiwRPxgkvibPzsDRvfyy2Zm9NOuUmx
         3x9eKAaus2qEIXa/H+CJPscRhV4ofvPgIF6hWxhtwvmLq6V4HsVc46xLliRF+ju8pn
         9k+kGqSCmCj1JqrVtmye58DvgYo60ctZi6RiKLVVSCglQihBvrgY500ChtudA4tNhr
         X7l+dwJTb0Oa2QJmweM70K/Kah5hvVjZYQHKPo6xYGmF91eSW/IM+nD/ivbPUHu1SO
         4BxDeh9TluFRQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([212.114.172.88]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpJq-1qS1KE2pNq-00ZszO; Mon, 01
 May 2023 17:37:12 +0200
Message-ID: <0e9e94a365e0164a132d2506cb9eb25237925c36.camel@gmx.de>
Subject: Re: [PATCH v8 2/2] sched/fair: Introduce SIS_CURRENT to wake up
 short task on current CPU
From:   Mike Galbraith <efault@gmx.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Chen Yu <yu.c.chen@intel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
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
Date:   Mon, 01 May 2023 17:37:10 +0200
In-Reply-To: <ce70393575869d65449a59d321a109f10ac82676.camel@gmx.de>
References: <cover.1682661027.git.yu.c.chen@intel.com>
         <4081178486e025c89dbb7cc0e62bbfab95fc794a.1682661027.git.yu.c.chen@intel.com>
         <20230501134827.GB1597538@hirez.programming.kicks-ass.net>
         <ce70393575869d65449a59d321a109f10ac82676.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8A48Q2C0krCJburBXEACSR4pkfeCIAbw8/1/5nTKYISP/t2GNyT
 1F3O6dQSjQvO6nDMdTyvxC1o5+rYBksDltQqDaOHTsv69iVovJEETjwneWM7m9j/uUjTtPI
 p3x21JH/D++mQjCiPLaIqxHTLGk7RiURZbzEl0OKejbZPzc6Y0SyNFKprbXp5QBEN4U6rkw
 Um9UF/5HFQkYCeMEFqKyQ==
UI-OutboundReport: notjunk:1;M01:P0:tqqZyC8A6zs=;6KRNRyVWgyJOY9FR0RMUDVe0y3Q
 o1gpH+4EfQdub0j4zGr0XWkLI8A2zYeJEsO3daU6qyxF2jbrP/7NTL/26dN7VF99ZKX+p6FhU
 w8W3Q47BUincPOhvQzR9J50wXle/IFZT+6oKCB2IZY8Z3s6PadF9ik+mjoH+V0uAw1yu+1peN
 2453jVcG84iuiayKMOC4thAhIzXdOX5pLsTgpbyNtRylz+e0aMDozBDJItyqkczBxlf9jCcxH
 S9+HH7wJurX3aMSR0lvO1OqNYPKkFLK52Ok1HCfEYQv/xkS6QLGfyIaor+07mPjushSFzNNJz
 ueOWWYUfUmc1wLdxGFjrD6qDzrG5EsYxeB0giUTrvnWRhH2Hqt3MewoTO8KrAMGt4P9TRpJgW
 UNlSLxGuPk32Q9hbEyPyMVEorKUVh3LjPbUP2RmvrTH33V9WGy8u6b/uCHFgD8rJYot2SCvRZ
 CzUc/AebX/NeFXtbyNn2huQaGXpBgJe9wmQh8JKck936p/fabftBL+ts0XxrMqR0TktTghctZ
 kSO0Au73mtNdG+Pc6DQ/AZanizRoU3n+BdG8B6VvqKTT5A7jPMOiyU2WGEy5zur0Tnk96ZTYu
 ocpz9Tokgt9VbAVZxbxhD5NpeCTVWWyUKZgJVzg4yUL+2L/mRlni+WK5pH3SMrtXqCvFYmI1H
 SJ6scSyqeO+p5at0d0UH9p2MyPTR0iSWTrWSOQavTW4/4h544F3FzZwpJHieoUoEXO0+d3eL0
 FHHilk+rQHqEqd7986xWIvwoLatqvqZEf9DYOG5zF23mrp5EXz1J1gPkhiXbQGZy7MTh8GRzt
 pIbVKVqtItwQUHVAHuX9QWBzNu1mCW1SVdDgeOAvsptsdTDY2gmmzRYnQV6HY565Ne4tjPCue
 DFPMrVWoXJ/oFr75UCmgli63pk4GPe1A9a+6VLSrNqcblwyBxixmdT8uHYO5H85LpLyy/qBwv
 CT5bNst5fSmysoguOdCmAQs5zh4=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-05-01 at 17:32 +0200, Mike Galbraith wrote:
> On Mon, 2023-05-01 at 15:48 +0200, Peter Zijlstra wrote:
> >
> > Throughput=C2=A0 646.55 MB/sec=C2=A0=C2=A0 2 clients=C2=A0=C2=A0 2 pro=
cs=C2=A0 max_latency=3D0.104
> > ms
> > Throughput 1361.06 MB/sec=C2=A0=C2=A0 5 clients=C2=A0=C2=A0 5 procs=C2=
=A0 max_latency=3D0.100
> > ms
> > Throughput 1889.82 MB/sec=C2=A0 10 clients=C2=A0 10 procs=C2=A0 max_la=
tency=3D0.154
> > ms
> > Throughput 2406.57 MB/sec=C2=A0 20 clients=C2=A0 20 procs=C2=A0 max_la=
tency=3D3.667
> > ms
> > Throughput 2318.00 MB/sec=C2=A0 40 clients=C2=A0 40 procs=C2=A0 max_la=
tency=3D0.390
> > ms
> > Throughput 2384.85 MB/sec=C2=A0 80 clients=C2=A0 80 procs=C2=A0 max_la=
tency=3D1.371
> > ms
> >
> >
> > So what's going on here? I don't see anything exciting happening at
> > the
> > 40 mark. At the same time, I can't seem to reproduce Mike's latency
> > pile
> > up either :/
>
> Are you running tbench in the GUI so the per second output stimulates
> assorted goo?=C2=A0 I'm using KDE fwtw.
>
> Caught this from my raspberry pi, tbench placement looks lovely, the
> llvmpipe thingies otoh..

erm, without 14 feet of whitespace.

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ P COM=
MAND
19109 git       20   0   23468   1920   1664 R 52.65 0.012   3:59.64 4 tbe=
nch
19110 git       20   0   23468   1664   1536 R 52.65 0.010   4:00.03 3 tbe=
nch
19104 git       20   0   23468   1664   1536 R 52.32 0.010   4:00.15 1 tbe=
nch
19105 git       20   0   23468   1664   1536 R 52.32 0.010   4:00.16 0 tbe=
nch
19108 git       20   0   23468   1792   1664 R 52.32 0.011   4:00.12 7 tbe=
nch
19111 git       20   0   23468   1792   1664 R 51.99 0.011   4:00.33 5 tbe=
nch
19106 git       20   0   23468   1664   1536 R 51.66 0.010   3:59.40 6 tbe=
nch
19107 git       20   0   23468   1664   1536 R 51.32 0.010   3:59.72 2 tbe=
nch
19114 git       20   0    6748    896    768 R 46.69 0.006   3:32.77 6 tbe=
nch_srv
19116 git       20   0    6748    768    768 S 46.69 0.005   3:32.17 7 tbe=
nch_srv
19118 git       20   0    6748    768    768 S 46.69 0.005   3:31.70 3 tbe=
nch_srv
19117 git       20   0    6748    768    768 S 46.36 0.005   3:32.99 4 tbe=
nch_srv
19112 git       20   0    6748    768    768 S 46.03 0.005   3:32.51 1 tbe=
nch_srv
19113 git       20   0    6748    768    768 R 46.03 0.005   3:32.48 0 tbe=
nch_srv
19119 git       20   0    6748    768    768 S 46.03 0.005   3:31.93 5 tbe=
nch_srv
19115 git       20   0    6748    768    768 R 45.70 0.005   3:32.70 2 tbe=
nch_srv
 2492 root      20   0  392608 110044  70276 S 1.987 0.682   8:06.86 3 X
 2860 root      20   0 2557284 183260 138568 S 0.662 1.135   2:06.38 6 llv=
mpipe-1
 2861 root      20   0 2557284 183260 138568 S 0.662 1.135   2:06.44 6 llv=
mpipe-2
 2863 root      20   0 2557284 183260 138568 S 0.662 1.135   2:04.94 6 llv=
mpipe-4
 2864 root      20   0 2557284 183260 138568 S 0.662 1.135   2:04.72 6 llv=
mpipe-5
 2866 root      20   0 2557284 183260 138568 S 0.662 1.135   2:04.49 6 llv=
mpipe-7
19562 root      20   0   26192   4876   3596 R 0.662 0.030   0:00.43 5 top
 2837 root      20   0 2557284 183260 138568 S 0.331 1.135   1:51.39 5 kwi=
n_x11
 2859 root      20   0 2557284 183260 138568 S 0.331 1.135   2:07.56 6 llv=
mpipe-0
 2862 root      20   0 2557284 183260 138568 S 0.331 1.135   2:05.97 6 llv=
mpipe-3
 2865 root      20   0 2557284 183260 138568 S 0.331 1.135   2:03.84 6 llv=
mpipe-6
 2966 root      20   0 3829152 323000 174992 S 0.331 2.001   0:12.71 4 llv=
mpipe-7
 2998 root      20   0 1126332 116960  78032 S 0.331 0.725   0:25.58 3 kon=
sole

