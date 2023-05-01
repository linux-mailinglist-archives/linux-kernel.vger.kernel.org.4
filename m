Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9866F32F3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjEAPeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjEAPeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:34:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F49510C3
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 08:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682955129; i=efault@gmx.de;
        bh=f46aOwvmAhV4lngYC0N/uR8eCEQu28xA7XuVcHi9WxU=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=YXl+IaOQ8IZJXs/v1LwolYwz4scliKHcL0QcaUxtkrg/n14zxAxpUCGkNFjKR/cun
         Rq4K9L9xKQJdoYCSZf1O5x6eAPc5Gb3SiRw+FYVtCdcA8RANsCMY7nx3KoG6/nC+e3
         ggCWDC0NS4iYiFE3l2b5w8nYPGJ+Mx+19SrmdhSKVbjlH4jvpngTTS5PS8NraJC2/X
         JJZIVePeMAUSr769SUradSXNGcgfiUE7OtZVyUyy0ioTlS5xLiQswNJ5dVwZTqr3DC
         VF794ImcXVsFez8Lx24errgliRQo4/LYskPKO9wWJVTgCOHIZZ0BGZAPRYeh9D5GHH
         VL6UJpRqhL4UQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([212.114.172.88]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGhuU-1q6Ag63U3O-00Dngr; Mon, 01
 May 2023 17:32:08 +0200
Message-ID: <ce70393575869d65449a59d321a109f10ac82676.camel@gmx.de>
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
Date:   Mon, 01 May 2023 17:32:05 +0200
In-Reply-To: <20230501134827.GB1597538@hirez.programming.kicks-ass.net>
References: <cover.1682661027.git.yu.c.chen@intel.com>
         <4081178486e025c89dbb7cc0e62bbfab95fc794a.1682661027.git.yu.c.chen@intel.com>
         <20230501134827.GB1597538@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:npTLtCukUQNajgmyVOy6OI/DYQpTG6u20PznJNY0pSD1a78NFst
 BEHaiivEsELI1oNdACv5wmW/HJHFSwfGfOGtD2wzYi5ukrT1h0xR7MFRayvYr8fwvFPhUW9
 12VMXbqDpAXsRzZasrjbq/wa6hDITWwDPeSTljMQaOHmCYB1M84JpA2MVp7WkcgJOejp8jT
 UP0weRn81njqQXDbgmyvQ==
UI-OutboundReport: notjunk:1;M01:P0:gMBbeLtluE0=;RED4Fl2Y86fw4gRGong4JKewGUe
 p0Pkh4MI7JCeyEIZ4k8Voi10mi9WfhT/8r8dIkEs3wKG0Gq4R5UM+cVtqgBTjm6a7qP1EwaWS
 0H8MYYrmdjFctjfdnTyAwKPnEmOyj/rXGyYNLYjKEWC/4PAO10fu8KS3O1PI85lekc4rxgnw/
 IChYJQHgfYj30JnwmCgepZbcMgFmxoOwjWk8m/dM9HH2b4J8GOLVOO9t1InxXjoKOfDExyMKC
 ae0JKft8QTpnY97ElzVA/AAnn8zWf+DAAZ1q2NW9r7sUtnf7kZZEsHVkRLfNpvVn4jGrUgehC
 Wr4lT7FIdDIHK3zvmqeqcDSLjBey/hwBTZmRtmCNPc2YZG6sr6JcrmNjvvaSNEotDp95vq3ex
 HPMTE4wZqrDwlohA7KWV2Z+5NmbkCG1YxbcufVIQb3onKrhFNDpRqAdzr28ludgmJcqsFBr1D
 haeKi9oKPgddw/PjhDtg4PO4w4zHN68e2xA7Rz0EBocLC5rg7zkKDEUTEOgJuu+Yn2DV/ELmr
 5oCUrGopEV/u3eoYUluXsUv7K3Z0oeWsGleYpdj0vobyyVPGKU13T4okZsEoijAMHrPK3dRNw
 zFE8qRf4U7lMNwV21rIp7Z9o5sV02ne5ZLCXVTKppz/acoGi4IvI4t2lDxqeLFqOLEKHSsYUX
 Nx1nteNXT5tyO9zoWBLI32a/BOJJ8CSTtTBC6QjpEiYQWDaVx9MrgxC9kuMtI3JSvE1lI4qyP
 uAmTHIxuu5PWgBA/hu835mhBLHMHxFZkUCvZamglR7XF9ecD3enCmlsO9hzVXQj9ET796fQTz
 NJ4SS5py6pgKpJ/4bY3sNpilkMhxUcS4ffVEmMS7ZO5eq48g7jc6YPGnxmbrIBeXAvgy3ap88
 EGbCoJVQfD4r+lma4nba6hoXfyKUGDSKfS/VwS8JqTr53fltgHmj4hSBmtUr4opqOCPw8xW05
 UJ9wKInnJj/Y6XMVvnsB0sSnbGA=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-05-01 at 15:48 +0200, Peter Zijlstra wrote:
>
> Throughput=C2=A0 646.55 MB/sec=C2=A0=C2=A0 2 clients=C2=A0=C2=A0 2 procs=
=C2=A0 max_latency=3D0.104 ms
> Throughput 1361.06 MB/sec=C2=A0=C2=A0 5 clients=C2=A0=C2=A0 5 procs=C2=
=A0 max_latency=3D0.100 ms
> Throughput 1889.82 MB/sec=C2=A0 10 clients=C2=A0 10 procs=C2=A0 max_late=
ncy=3D0.154 ms
> Throughput 2406.57 MB/sec=C2=A0 20 clients=C2=A0 20 procs=C2=A0 max_late=
ncy=3D3.667 ms
> Throughput 2318.00 MB/sec=C2=A0 40 clients=C2=A0 40 procs=C2=A0 max_late=
ncy=3D0.390 ms
> Throughput 2384.85 MB/sec=C2=A0 80 clients=C2=A0 80 procs=C2=A0 max_late=
ncy=3D1.371 ms
>
>
> So what's going on here? I don't see anything exciting happening at the
> 40 mark. At the same time, I can't seem to reproduce Mike's latency pile
> up either :/

Are you running tbench in the GUI so the per second output stimulates
assorted goo?  I'm using KDE fwtw.

Caught this from my raspberry pi, tbench placement looks lovely, the
llvmpipe thingies otoh..

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

