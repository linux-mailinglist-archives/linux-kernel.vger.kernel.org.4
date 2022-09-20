Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E855BE81D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiITOIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiITOIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:08:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF2B5808D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:08:07 -0700 (PDT)
X-UUID: e0fbb2a245f9471b8b9adca93bcc0ffb-20220920
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=lxnU2/ni7a4wCh4IpfQnH7qy6vzsjnbyVDzNTIc9HHo=;
        b=MqSMr2KLObRlWZ8BqdTirp7tpyj8aSKw8VRQ6JrBPk9B/WszR/GPPX6gyYTW3QJTIBkdZPvZvBp91TYzYAZGPMERIQGRa0uFxjS3uCva+zekpqCJFNXifWsNUDJQG/ozpQ+3n9HHlslBwLSuCx5bsFz45UaWfH2Em0+n/xWTEBg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:244116df-e8ef-48da-945f-cf0e2f0bd71c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.11,REQID:244116df-e8ef-48da-945f-cf0e2f0bd71c,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:39a5ff1,CLOUDID:88b94b5e-5ed4-4e28-8b00-66ed9f042fbd,B
        ulkID:2209202208036WARSN8R,BulkQuantity:1,Recheck:0,SF:28|17|19|48|823|824
        ,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:
        0
X-UUID: e0fbb2a245f9471b8b9adca93bcc0ffb-20220920
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jian-min.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1707152392; Tue, 20 Sep 2022 22:08:00 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 20 Sep 2022 22:07:59 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 20 Sep 2022 22:07:59 +0800
Message-ID: <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
From:   Jian-Min Liu <jian-min.liu@mediatek.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>
CC:     Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>
Date:   Tue, 20 Sep 2022 22:07:59 +0800
In-Reply-To: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Update some test data in android phone to support switching PELT HL 
is helpful functionality.

We switch runtime PELT HL during runtime by difference scenario e.g.
pelt8 in playing game, pelt32 in camera video. Support runntime
switching PELT HL is flexible for different workloads.

the below table show performance & power data points: 

---------------------------------------------------------------------
--|                      | PELT
halflife                                |
|                      |----------------------------------------------|
|                      |       32      |       16      |       8      |
|                      |----------------------------------------------|
|                      | avg  min  avg | avg  min  avg | avg  min  avg|
| Scenarios            | fps  fps  pwr | fps  fps  pwr | fps  fps  pwr|
|---------------------------------------------------------------------|
| HOK game 60fps       | 100  100  100 | 105 *134* 102 | 104 *152* 106|
| HOK game 90fps       | 100  100  100 | 101 *114* 101 | 103 *129* 105|
| HOK game 120fps      | 100  100  100 | 102 *124* 102 | 105 *134* 105|
| FHD video rec. 60fps | 100  100  100 | n/a  n/a  n/a | 100  100  103|
| Camera snapshot      | 100  100  100 | n/a  n/a  n/a | 100  100  102|
-----------------------------------------------------------------------

HOK ... Honour Of Kings, Video game
FHD ... Full High Definition
fps ... frame per second
pwr ... power consumption

table values are in %


On Mon, 2022-08-29 at 07:54 +0200, Dietmar Eggemann wrote:
> Many of the Android devices still prefer to run PELT with a shorter
> halflife than the hardcoded value of 32ms in mainline.
> 
> The Android folks claim better response time of display pipeline
> tasks
> (higher min and avg fps for 60, 90 or 120Hz refresh rate). Some of
> the
> benchmarks like PCmark web-browsing show higher scores when running
> with 16ms or 8ms PELT halflife. The gain in response time and
> performance is considered to outweigh the increase of energy
> consumption in these cases.
> 
> The original idea of introducing a PELT halflife compile time option
> for 32, 16, 8ms from Patrick Bellasi in 2018
> 
https://urldefense.com/v3/__https://lkml.kernel.org/r/20180409165134.707-1-patrick.bellasi@arm.com__;!!CTRNKA9wMg0ARbw!x-6IhaOmZWO5PJIWEfZLD-6grV2BwlOBpflNV57-oNZY8NfSocwlImAHM2TQFyo56_r-$
>  
> wasn't integrated into mainline mainly because of breaking the PELT
> stability requirement (see (1) below).
> 
> We have been experimenting with a new idea from Morten Rasmussen to
> instead introduce an additional clock between task and pelt clock.
> This
> way the effect of a shorter PELT halflife of 8ms or 16ms can be
> achieved by left-shifting the elapsed time. This is similar to the
> use
> of time shifting of the pelt clock to achieve scale invariance in
> PELT.
> The implementation is from Vincent Donnefort with some minor
> modifications to align with current tip sched/core.
> 
> ---
> 
> Known potential issues:
> 
> (1) PELT stability requirement
> 
> PELT halflife has to be larger than or equal to the scheduling
> period.
> 
> The sched_period (sysctl_sched_latency) of a typical mobile device
> with
> 8 CPUs with the default logarithmical tuning is 24ms so only the 32
> ms
> PELT halflife met this. Shorter halflife of 16ms or even 8ms would
> break
> this.
> 
> It looks like that this problem might not exist anymore because of
> the
> PELT rewrite in 2015, i.e. with commit 9d89c257dfb9
> ("sched/fair: Rewrite runnable load and utilization average
> tracking").
> Since then sched entities (task & task groups) and cfs_rq's are
> independently maintained rather than each entity update maintains the
> cfs_rq at the same time.
> 
> This seems to mitigate the issue that the cfs_rq signal is not
> correct
> when there are not all runnable entities able ot do a self update
> during
> a PELT halflife window.
> 
> That said, I'm not entirely sure whether the entity-cfs_rq
> synchronization is the only issue behind this PELT stability
> requirement.
> 
> 
> (2) PELT utilization versus util_est (estimated utilization)
> 
> The PELT signal of a periodic task oscillates with higher peak
> amplitude
> when using smaller halflife. For a typical periodic task of the
> display
> pipeline with a runtime/period of 8ms/16ms the peak amplitude is at
> ~40
> for 32ms, at ~80 for 16ms and at ~160 for 8ms. Util_est stores the
> util_avg peak as util_est.enqueued per task.
> 
> With an additional exponential weighted moving average (ewma) to
> smooth
> task utilization decreases, util_est values of the runnable tasks are
> aggregated on the root cfs_rq.
> CPU and task utilization for CPU frequency selection and task
> placement
> is the max value out of util_est and util_avg. 
> I.e. because of how util_est is implemented higher CPU Operating
> Performance Points and more capable CPUs are already chosen when
> using
> smaller PELT halflife.
> 
> 
> (3) Wrong PELT history when switching PELT multiplier
> 
> The PELT history becomes stale the moment the PELT multiplier is
> changed
> during runtime. So all decisions based on PELT are skewed for the
> time
> interval to produce LOAD_MAX_AVG (the sum of the infinite geometric
> series) which value is ~345ms for halflife=32ms (smaller for 8ms or
> 16ms).
> 
> Rate limiting the PELT multiplier change to this value is not solving
> the issue here. So the user would have to live with possible
> incorrect
> discussions during these PELT multiplier transition times.
> 
> ---
> 
> It looks like that individual task boosting e.g. via uclamp_min,
> possibly abstracted by middleware frameworks like Android Dynamic
> Performance Framework (ADPF) would be the way to go here but until
> this
> is fully available and adopted some Android folks will still prefer
> the
> overall system boosting they achieve by running with a shorter PELT
> halflife.
> 
> Vincent Donnefort (1):
>   sched/pelt: Introduce PELT multiplier
> 
>  kernel/sched/core.c  |  2 +-
>  kernel/sched/pelt.c  | 60
> ++++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/pelt.h  | 42 ++++++++++++++++++++++++++++---
>  kernel/sched/sched.h |  1 +
>  4 files changed, 100 insertions(+), 5 deletions(-)
> 

