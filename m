Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600FB6D73D8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 07:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbjDEFnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 01:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236670AbjDEFnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 01:43:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67C91993
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 22:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1680673318; i=efault@gmx.de;
        bh=sUdWzpzmfRWuXY4AU2qAzpIkKMwOhhtNOsy3wInzbUE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=rhV38kEglRWUnZG0e0o+TX3mAy3nkplGZ8A2/0gx1nH4HbJJqc0/ptb1nTpg00M/y
         wzynQwjesfxTVwudZifPm2zPxHRi7hK6AXTK+7h6v5GCswpk4R18U9d1eA8bIuW9xv
         bzX76VnXz8dRpe7ndcoQf5dqj2ZSKb+wl8aczStn0zjh8d3Ar3+lBkST6wvxsqlewp
         dNuLt6TZtLQGON6qXupXV/JCEMROIJLOZtx1lHSYI78fU4CIaAv3RvYGJF47PgpM9a
         yTIj6mmLpDskqAU2unh8mPsIWG+A32RMJJJpRUTPOdareT18iP3s5DIi9CqdqBp7wL
         sqDjH8WNuw3uA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.218.3]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4hvR-1qRLk23qLP-011jxb; Wed, 05
 Apr 2023 07:41:58 +0200
Message-ID: <ebcb958335cbae76e2014553bf9996ceb0c2b88f.camel@gmx.de>
Subject: Re: [PATCH 14/17] sched/eevdf: Better handle mixed slice length
From:   Mike Galbraith <efault@gmx.de>
To:     Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org
Date:   Wed, 05 Apr 2023 07:41:54 +0200
In-Reply-To: <20230404135050.GA471948@google.com>
References: <20230328092622.062917921@infradead.org>
         <20230328110354.562078801@infradead.org>
         <CAKfTPtAkFBw5zt0+WK7dWBUE9OrbOOExG8ueUE6ogdCEQZhpXQ@mail.gmail.com>
         <20230404092936.GD284733@hirez.programming.kicks-ass.net>
         <20230404135050.GA471948@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ou5ArlKwR9XUMlNP+rwG+gz5epjMnsDKJq7r6W50CBinQV1jKyQ
 0b2/lwVCDYkyAvvRYyusmO2HiCw1vge5eqFqCAjxjHW0BJJ/IYa7hPMe4assCo/qokjqgPV
 ood6GKyyUOjR6R8yVXorvrPgiDT5xVIFSgO/g+zHjbgrwlXDr6sfg1roYs3i6RXgnfrAyvo
 soG+7c6c+z/0yVEvjBdTQ==
UI-OutboundReport: notjunk:1;M01:P0:mK9RXOATy4M=;q8FQX9LitnkGV8u9REtwmVE9qnD
 1mX2y78X61Hm6Uh4m1ZuxC+MqJBuTX82k/ZQEmrPLyFvK0Qjq37dz8uLbbVmnz1A5uLeIZ08B
 DlokEBn1Sf6z06xjc9lj8+aYyKcAbmCxU/3tXFwIs8wI0o7hzXpFsOVknJ61E6uEohD3l2cCr
 HJxW5lv6E663AqJorLzBCB4Hb8Y7YLtDf8y9dKinaQLHYtQzQy3RIYx1qpjiq5M3R2n3QztaF
 yl9FCWGPYvCbxaw3k8tHCrpMd/9oZN/TrOHJE6zlKxA674+xoVW9Yd025p+D1jus1oi6hxWfT
 0TLUSBzIP77BfQKO/qtiX3luKq54V3Pyex7w/0VHBdJLADffjABrO6I/giu8ZNQXyWHl4XFHU
 hvnBYXw1zWcFmGoTycIHd2k9EiePqKxpbNgYdKAZ1nh3K4mHuD/pYtz5L8TK56dMEsRPnkJaW
 2OsmomaokA/3ntQsk7CJXdAJovcnleggLW9NG3YF1O1NC5bDtEIxElITs/uWxrUBFhRL0DGew
 O6lU2SbSya3a/EBOdRGUUG0mAfNxllV4kmUZb4A03r3vbBnirBzsm9mf+5fMpRKG9YUMF3cOZ
 RzLTAP661meV+nS2oXuBVyx+0ELxJPZhsh4WpWiIpDdwOunZ10MOMtZG5DS8QMnzNpCUjdx/s
 FOKE/KzaTDsN3ndLntzxEZ9pVh1g+mlBfpru6czIABlDrYBUh9VU0nlgqs2TnGJEpcGVN4Ag8
 MPUQgm1XoI4yK5O3e5TCbpDRHZdrwGJBvYofmBcAdlUYNOer3nQZqrDTKkXs/hm/NRd0TasL+
 vrRH7S88NJoJQqWUl/zHeejBtWH/hjKeUYr3mQpgQzx7Vn7D8/QKHPiiRY2csseMfTqxpllIY
 txsDJSi5yDFAvptxYVcAGRt6qNbxio/iYiqJYW63sJSDTyaWWPDi+y4O7dPo9+u8j+tM3OXsE
 iFzpMA==
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-04-04 at 13:50 +0000, Joel Fernandes wrote:
> On Tue, Apr 04, 2023 at 11:29:36AM +0200, Peter Zijlstra wrote:
> > On Fri, Mar 31, 2023 at 05:26:51PM +0200, Vincent Guittot wrote:
> >
> > >
> > > Task A always run
> > > Task B loops on : running 1ms then sleeping 1ms
> > > default nice and latency nice prio bot both
> > > each task should get around 50% of the time.
> > >
> > > The fairness is ok with tip/sched/core
> > > but with eevdf, Task B only gets around 30%
> > >
> > > I haven't identified the problem so far
> >
> > Heh, this is actually the correct behaviour. If you have a u=3D1 and a
> > u=3D.5 task, you should distribute time on a 2:1 basis, eg. 67% vs 33%=
.
>
> Splitting like that sounds like starvation of the sleeper to me. If some=
thing
> sleeps a lot, it will get even less CPU time on an average than it would=
 if
> there was no contention from the u=3D1 task.
>
> And also CGroups will be even more weird than it already is in such a wo=
rld,
> 2 different containers will not get CPU time distributed properly- say i=
f
> tasks in one container sleep a lot and tasks in another container are CP=
U
> bound.

Lets take a quick peek at some group distribution numbers.

start tbench and massive_intr in their own VT (autogroup), then in
another, sleep 300;killall top massive_intr tbench_srv tbench.

(caveman method because perf's refusing to handle fast switchers well
for me.. top's plenty good enough for this anyway, and less intrusive)

massive_intr runs 8ms, sleeps 1, wants 88.8% of 8 runqueues.  tbench
buddy pairs want only a tad more CPU, 100% between them, but switch
orders of magnitude more frequently.  Very dissimilar breeds of hog.

master.today      accrued   of 2400s vs master
team massive_intr 1120.50s     .466      1.000
team tbench       1256.13s     .523      1.000

+eevdf
team massive_intr 1071.94s     .446       .956
team tbench       1301.56s     .542      1.036

There is of course a distribution delta.. but was it meaningful?

Between mostly idle but kinda noisy GUI perturbing things, and more
importantly, neither load having been manually distributed and pinned,
both schedulers came out pretty good, and both a tad shy of.. perfect
is the enemy of good.

Raw numbers below in case my mouse mucked up feeding of numbers to bc
(blame the inanimate, they can't do a damn thing about it).

6.3.0.g148341f-master
  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ P COM=
MAND
 5641 root      20   0    2564    640    640 R 50.33 0.004   2:17.19 5 mas=
sive_intr
 5636 root      20   0    2564    640    640 S 49.00 0.004   2:20.05 5 mas=
sive_intr
 5647 root      20   0    2564    640    640 R 48.67 0.004   2:21.85 6 mas=
sive_intr
 5640 root      20   0    2564    640    640 R 48.00 0.004   2:21.13 6 mas=
sive_intr
 5645 root      20   0    2564    640    640 R 47.67 0.004   2:18.25 5 mas=
sive_intr
 5638 root      20   0    2564    640    640 R 46.67 0.004   2:22.39 2 mas=
sive_intr
 5634 root      20   0    2564    640    640 R 45.00 0.004   2:18.93 4 mas=
sive_intr
 5643 root      20   0    2564    640    640 R 44.00 0.004   2:20.71 7 mas=
sive_intr
 5639 root      20   0   23468   1664   1536 R 29.00 0.010   1:22.31 3 tbe=
nch
 5644 root      20   0   23468   1792   1664 R 28.67 0.011   1:22.32 3 tbe=
nch
 5637 root      20   0   23468   1664   1536 S 28.00 0.010   1:22.75 5 tbe=
nch
 5631 root      20   0   23468   1792   1664 R 27.00 0.011   1:21.47 4 tbe=
nch
 5632 root      20   0   23468   1536   1408 R 27.00 0.010   1:21.78 0 tbe=
nch
 5653 root      20   0    6748    896    768 S 26.67 0.006   1:15.26 3 tbe=
nch_srv
 5633 root      20   0   23468   1792   1664 R 26.33 0.011   1:22.53 0 tbe=
nch
 5635 root      20   0   23468   1920   1792 R 26.33 0.012   1:20.72 7 tbe=
nch
 5642 root      20   0   23468   1920   1792 R 26.00 0.012   1:21.73 2 tbe=
nch
 5650 root      20   0    6748    768    768 R 25.67 0.005   1:15.71 1 tbe=
nch_srv
 5652 root      20   0    6748    768    768 S 25.67 0.005   1:15.71 3 tbe=
nch_srv
 5646 root      20   0    6748    768    768 S 25.33 0.005   1:14.97 4 tbe=
nch_srv
 5648 root      20   0    6748    896    768 S 25.00 0.006   1:14.66 0 tbe=
nch_srv
 5651 root      20   0    6748    896    768 S 24.67 0.006   1:14.79 2 tbe=
nch_srv
 5654 root      20   0    6748    768    768 R 24.33 0.005   1:15.47 0 tbe=
nch_srv
 5649 root      20   0    6748    768    768 R 24.00 0.005   1:13.95 7 tbe=
nch_srv

6.3.0.g148341f-master-eevdf
  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ P COM=
MAND
10561 root      20   0    2564    768    640 R 49.83 0.005   2:14.86 3 mas=
sive_intr
10562 root      20   0    2564    768    640 R 49.50 0.005   2:14.00 3 mas=
sive_intr
10564 root      20   0    2564    896    768 R 49.50 0.006   2:14.11 6 mas=
sive_intr
10559 root      20   0    2564    768    640 R 47.84 0.005   2:14.03 2 mas=
sive_intr
10560 root      20   0    2564    768    640 R 45.51 0.005   2:13.92 7 mas=
sive_intr
10557 root      20   0    2564    896    768 R 44.85 0.006   2:13.59 7 mas=
sive_intr
10563 root      20   0    2564    896    768 R 44.85 0.006   2:13.53 6 mas=
sive_intr
10558 root      20   0    2564    768    640 R 43.52 0.005   2:13.90 2 mas=
sive_intr
10577 root      20   0   23468   1920   1792 R 35.22 0.012   1:37.06 0 tbe=
nch
10574 root      20   0   23468   1920   1792 R 32.23 0.012   1:32.89 4 tbe=
nch
10580 root      20   0   23468   1920   1792 R 29.57 0.012   1:34.95 0 tbe=
nch
10575 root      20   0   23468   1792   1664 R 29.24 0.011   1:31.66 4 tbe=
nch
10576 root      20   0   23468   1792   1664 S 28.57 0.011   1:34.55 5 tbe=
nch
10573 root      20   0   23468   1792   1664 R 28.24 0.011   1:33.17 5 tbe=
nch
10578 root      20   0   23468   1920   1792 S 28.24 0.012   1:33.97 1 tbe=
nch
10579 root      20   0   23468   1920   1792 R 28.24 0.012   1:36.09 1 tbe=
nch
10587 root      20   0    6748    768    640 S 26.91 0.005   1:09.45 0 tbe=
nch_srv
10582 root      20   0    6748    768    640 R 24.25 0.005   1:08.19 4 tbe=
nch_srv
10588 root      20   0    6748    640    640 R 22.59 0.004   1:09.15 0 tbe=
nch_srv
10583 root      20   0    6748    640    640 R 21.93 0.004   1:07.93 4 tbe=
nch_srv
10586 root      20   0    6748    640    640 S 21.59 0.004   1:07.92 1 tbe=
nch_srv
10581 root      20   0    6748    640    640 S 21.26 0.004   1:07.08 5 tbe=
nch_srv
10585 root      20   0    6748    640    640 R 21.26 0.004   1:08.89 5 tbe=
nch_srv
10584 root      20   0    6748    768    640 S 20.93 0.005   1:08.61 1 tbe=
nch_srv


