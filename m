Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5166F3C36
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 04:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjEBCxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 22:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjEBCxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 22:53:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C229D1BD5
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 19:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682995917; i=efault@gmx.de;
        bh=DF6/JrJ9nhIq2aWBHx6BcQtQTQQ2CBQJ0eB3wxrEH5A=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=jbvynz2kwqI3qsYTgCmhTAQUMjeskGGbde2Mj+P17Eq90eOimICcwLapiecbyxiD1
         GyUKm6gOUsmqft6jvKfyS9L94Wqlkmq8KkqnXTWITfW6ES9wmOZGbXMXGaAefdJ+YF
         9Pddg369oi3St//YQbURi/6wCwxEmtPGduxfCU+5wyJa+Dfzpb7s5IRzjZsAKXXi61
         yjTGwuKoj5bLt2E+6ooXb5fgAMIfrW/420+z+wgi/USeMgNCbrZVBJFEtsffUpFvpQ
         b3W6yvutb+afOWxHlE1elZjpE7xGb4hmpp0m0Qd2PS37VJT0JQq7jgMR64uroi9U3Q
         eaqWaXBzaY2Tw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([212.114.172.88]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQMuR-1pXryv3VSb-00MJ87; Tue, 02
 May 2023 04:51:56 +0200
Message-ID: <4e271e7d95fe862c9f201b6f04b16b1423ae3dcb.camel@gmx.de>
Subject: Re: [PATCH v8 2/2] sched/fair: Introduce SIS_CURRENT to wake up
 short task on current CPU
From:   Mike Galbraith <efault@gmx.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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
Date:   Tue, 02 May 2023 04:51:51 +0200
In-Reply-To: <20230501184920.GC1597476@hirez.programming.kicks-ass.net>
References: <cover.1682661027.git.yu.c.chen@intel.com>
         <4081178486e025c89dbb7cc0e62bbfab95fc794a.1682661027.git.yu.c.chen@intel.com>
         <20230501134827.GB1597538@hirez.programming.kicks-ass.net>
         <ce70393575869d65449a59d321a109f10ac82676.camel@gmx.de>
         <20230501184920.GC1597476@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jAqgkww3ScP5tuPJcp6Jg54UTYvHJBTLd3fs5yohevm+gk8nPJ3
 c9Dg706Bs4jc34+rn/O5MKcY2oWdZKJ93hTy2aQ78A6zrkqihBmEnERSyPI2tzCDh6DCT+9
 idSEQmGqEbEp/c3HN2CUab0HGQZJOEeX9QUFC99rz18LS8YA8uWAlv5b+OrXgNymOQ2gGOg
 idd7ZB5BKhYXfrG0sUKtw==
UI-OutboundReport: notjunk:1;M01:P0:grUpVZ0UAKQ=;a7KL5LQWvwQBExc3l7d83JV7AB7
 YiIzTJ/iSQx8vNy8ki0TAA9Kic+QML92p54uOM1EXqOWtohh7WuYnPbqjcnBLaeDP7lu1N9PU
 HS1Mvi2cnGvWN/lz5tvOdlx/ydL7O3fKMu+bSn817qWXFe/cAaHhcop2le3upvjs36KR0ZZFZ
 oOpAQLuKuPpVUp6O04f02M2T1C7+mTLRJR35pmXTnKfVu+rn02h/ZqdRmG1W6JvRw+uNKOYHg
 NuUo+NJexeo0lwpFykte0YvUldYPhdCLD3LNbTbUitnd27M7WLgBcW9qjXJM/5ReSWODdfq2e
 BF5hwLOQUSLuocHfEAb8gWM4744QSLCtS2CrA9T23EmD8rqtwjW1XG5k6vy0P54hHORyepExc
 yI8yrEzcgPCj3D3DjW3k3HXXQzmc0m1e9ukLcg8e+tv5RtSirUrBxMbcMiBS23Se/ixUrM0G5
 qbmX7NQygdxa8fa8dD2r0uXJ/INgS5gmwB3xdrRMtP2HLulnVSJwT9JOiv8vzFBs9kw9+oOWb
 pl98tL7ysurv1sxUx0R4jg4kMN1CA7ZOzsTXVRuZuazAXb165C+RUgG+BwpUoKghsyNJnfJCj
 B7R/uCeCfK2amoMMQBkIESGIabYC9Sakb1wP4kA80La2TgbaiG/8G1aweOtGTCfOkgta/H5c7
 q76QsV0wCIjKl50DxJJndDd3dnPpxbfQM3bq1corYbE0lM//ytNW0iqiUUlLempEdtxIvOdlA
 V+IKpNAOIaIWDfPkYCcr7jeTJpwCWJ16O8V9OhSB3eST9K4eec9g1Lal0bJ8R5Nn0pEbaBkcM
 W8HH+Jheu7CUQJYOcX0Y2Pp1dRzcHG04dzFtaTK6/bH2ugsY8WHzSsIPggnwSlb2twvHPUWSP
 3PXO1TQR3KcUWhouLRDX78IEoD0HEP3ryebfEqM7TjZUYMcV6ZEKTPciksVaKyiaR8y4RQBub
 asg33VHR5IGBx/X4pMC2rZXoc3c=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-05-01 at 20:49 +0200, Peter Zijlstra wrote:
> On Mon, May 01, 2023 at 05:32:05PM +0200, Mike Galbraith wrote:
> > On Mon, 2023-05-01 at 15:48 +0200, Peter Zijlstra wrote:
> > >
> > > Throughput=C2=A0 646.55 MB/sec=C2=A0=C2=A0 2 clients=C2=A0=C2=A0 2 p=
rocs=C2=A0 max_latency=3D0.104 ms
> > > Throughput 1361.06 MB/sec=C2=A0=C2=A0 5 clients=C2=A0=C2=A0 5 procs=
=C2=A0 max_latency=3D0.100 ms
> > > Throughput 1889.82 MB/sec=C2=A0 10 clients=C2=A0 10 procs=C2=A0 max_=
latency=3D0.154 ms
> > > Throughput 2406.57 MB/sec=C2=A0 20 clients=C2=A0 20 procs=C2=A0 max_=
latency=3D3.667 ms
> > > Throughput 2318.00 MB/sec=C2=A0 40 clients=C2=A0 40 procs=C2=A0 max_=
latency=3D0.390 ms
> > > Throughput 2384.85 MB/sec=C2=A0 80 clients=C2=A0 80 procs=C2=A0 max_=
latency=3D1.371 ms
> > >
> > >
> > > So what's going on here? I don't see anything exciting happening at =
the
> > > 40 mark. At the same time, I can't seem to reproduce Mike's latency =
pile
> > > up either :/
> >
> > Are you running tbench in the GUI so the per second output stimulates
> > assorted goo?=C2=A0 I'm using KDE fwtw.
>
> Nah, the IVB-EP is headless, doesn't even have systemd on, still running
> sysvinit.

Turns out load distribution on Yu's box wasn't going wonky way early
after all, so WA_WEIGHT's evil side is off topic wrt $subject.  Hohum.

	-Mike
