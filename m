Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F22621C83
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiKHSvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiKHSvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:51:14 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5369E63CCA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:51:11 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A8HJYCc020432;
        Tue, 8 Nov 2022 18:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=sr1b1DU5i/7xk/QFlcm76uAiBlx9Li2Dc+NFlMf3vkE=;
 b=lYvmC2vRz2yyBz/LwNaWOz9/MN9jR5OMfmARMdXFSSlxRqD8Bo+8MOtrRjYDKZKITdhh
 a4rg5o07AAJXJYnHskbR7YyZfeYf6G8ztT+7HIzRCCAdZuqAYlbLADyYTFdJjokBdBjI
 Or9HyfprpCwrWiKHGnjLxfX/KSjIrA6YwATu3IfcTmAFppitHSMbSKNDwJYS176qJ7I2
 Ml2UzZJgPC3CeJNsPRK4qhCzMYr2IX9Tn9qBs1lp6IFfMsMhIQyotLK+uT/q7guup90N
 AAAFzUdsvnkhIVjyWFrboHlJC3SnaMWT5r1jLO6cNrowgE/feiHxuJi53LNnfqM9VuOi /w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kqud70cwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 18:48:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A8ImUfR012664
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Nov 2022 18:48:30 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 8 Nov 2022 10:48:26 -0800
Date:   Wed, 9 Nov 2022 00:18:22 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Frederic Weisbecker" <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v4 00/16] timer: Move from a push remote at enqueue to a
 pull at expiry model
Message-ID: <20221108184822.GB28920@hu-pkondeti-hyd.qualcomm.com>
References: <20221104145737.71236-1-anna-maria@linutronix.de>
 <20221108043708.GA9994@hu-pkondeti-hyd.qualcomm.com>
 <776be028-9161-9ba1-3bf9-417b17f46a1b@linutronix.de>
 <20221108160457.GA28920@hu-pkondeti-hyd.qualcomm.com>
 <d1814f32-c8a2-c65f-836d-6c84878c4650@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d1814f32-c8a2-c65f-836d-6c84878c4650@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WrmU-A4FTwdh1wGg9pczRT4QZKBTLJoF
X-Proofpoint-ORIG-GUID: WrmU-A4FTwdh1wGg9pczRT4QZKBTLJoF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 adultscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080119
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 06:39:22PM +0100, Anna-Maria Behnsen wrote:
> On Tue, 8 Nov 2022, Pavan Kondeti wrote:
> 
> > Hi Anna-Maria,
> > 
> > On Tue, Nov 08, 2022 at 04:06:15PM +0100, Anna-Maria Behnsen wrote:
> > > On Tue, 8 Nov 2022, Pavan Kondeti wrote:
> > > 
> > > > Hi Anna-Maria,
> > > > 
> > > > On Fri, Nov 04, 2022 at 03:57:21PM +0100, Anna-Maria Behnsen wrote:
> > > > > Next Steps
> > > > > ~~~~~~~~~~
> > > > > 
> > > > > Simple deferrable timers are no longer required as they can be converted to
> > > > > global timers. If a CPU goes idle, a formerly deferrable timer will not
> > > > > prevent the CPU to sleep as long as possible. Only the last migrator CPU
> > > > > has to take care of them. Deferrable timers with timer pinned flags needs
> > > > > to be expired on the specified CPU but must not prevent CPU from going
> > > > > idle. They require their own timer base which is never taken into account
> > > > > when calculating the next expiry time. This conversation and required
> > > > > cleanup will be done in a follow up series.
> > > > > 
> > > > 
> > > > Taking non-pinned deferrable timers case, they are queued on their own base
> > > > and its expiry is not taken into account while programming the next timer
> > > > event during idle.
> > > 
> > > If CPU is not the last CPU going idle, then yes.
> > 
> > What is special with last CPU that is going idle? Sorry, it is not clear where
> > the deferrable timer expiry is taken into account while programming the next
> > wakeup event?
> 
> The last CPU has to make sure the global timers are handled. At the moment
> the deferrable timer expiry is not taken into account for next wakeup.
> 

Right. Nothing changes wrt deferrable timers with this series.

> > forward_and_idle_timer_bases()->tmigr_cpu_deactivate() is only taking global
> > timer expiry (deferrable timers are NOT queued on global base) and comparing
> > against the local base expiry. This makes me think that we are not taking
> > deferrable timers expiry into account, which is correct IMO.
> 
> The information "deferrable timers [...] can be converted to global timers"
> is below the heading "Next Steps". It is _NOT_ part of this series, it will
> be part of a follow up patch series.
> 
> The posted series only introduces the timer migration hierarchy and then
> removes the heuristic on which CPU a timer will be enqueued. The only
> change for deferrable timers after this series is: They are always enqueued
> on the local CPU. The rest stays the same.
> 

Understood. 

> 
> > > > When the deferrable timers will be queued on global base, once a CPU comes out
> > > > of idle and serve the timers on global base, the deferrable timers also would
> > > > be served. This is a welcoming change. We would see a truly deferrable global
> > > > timer something we would be interested in. [1] has some background on this.
> > > 
> > > Serving the deferrable timers once a CPU comes out of idle is already the
> > > case even without the timer migration hierarchy. See upstream version of
> > > run_local_timers().
> > 
> > However upstream version does not wake a CPU just to serve a deferrable timer.
> > But it seems if we consider a deferrable timer just as another global timer,
> > sure it will not prevent the local CPU going idle but there would be one CPU
> > (thus, the system) that pays the penalty.
> >
> 
> Right.
> 
> > > > [1]
> > > > https://lore.kernel.org/lkml/1430188744-24737-1-git-send-email-joonwoop@codeaurora.org/
> > > 
> > > As far as I understand the problem you are linking to correctly, you want
> > > to have a real "unbound" solution for deferrable or delayed work. This is
> > > what you get with the timer migration hierarchy and when enqueuing
> > > deferrable timers into global timer base. Timers are executed on the
> > > migrator CPU because this CPU is not idle - doesn't matter where they have
> > > been queued before.
> > > 
> > > It might be possible, that a fomerly deferrable timer enforces the last CPU
> > > going idle to come back out of idle. But the question is, how often does
> > > this occur in contrast to a wakeup cause by a non deferrable timer?  If you
> > > have a look at the timers in kernel you have 64 deferrable timers (this
> > > number also contain the deferrable and pinned timers). There are 7 timers
> > > with only TIMER_PINNED flag and some additional using the add_timer_on() to
> > > be enqueued on a dedicated CPU. But in total we have more than 1000
> > > timers. Sure - in the end, numbers hardly depends on the selected kernel
> > > config...
> > 
> > I will give an example here. Lets say we have 4 CPUs in a system. There is a
> > devfreq governor driver that configures a delayed work for every 20 msec.
> 
> s/delayed work/deferrable work ?

yeah, deferrable work.

> 
> > #1 When the system is busy, this *deferrable* timer expires at the 20 msec
> > boundary. However, when the system is idle (i.e no use case is running but
> > system does not enter global suspend because of other reasons like display
> > ON etc), we don't expect this deferrable timer to expire at every 20 msec. 
> > 
> > With your proposal, we endup seeing the system (last CPU that enters idle)
> > coming out of idle for every 20 msec which is not desirable.
> 
> With my proposal for next steps only timers with pinned and deferrable flag
> set would keep the old behavior.

pinned timers/work are meant for collecting/doing per-CPU things. Those who
don't care about these like devfreq would generally want the scheduler to select
the best CPU for their work and probably don't use pinned timers.

> 
> > #2 Today, deferrable is local to CPU. Irrespective of the activity on the
> > other CPUs, this deferrable timer does not expire as long as the local CPU
> > is idle for whatever reason. That is definitly not the devfreq governor
> > expectation. The intention is to save power when system is idle but serving
> > the purpose when it is relatively busy.
> > 
> > > 
> > > Side note: One big problem of deferrable timers disappear with this
> > > approach. All deferrable timers _WILL_ expire. Even if CPU where they have
> > > been enqueued does not come back out of idle. Only deferrable and pinned
> > > timers will still have this problem.
> > > 
> > Yes, this is a welcoming change. Solves the #2 problem as mentioned above.
> 
> But this welcoming change is only accessible when enqueuing deferrable
> timers into global base. But be aware, the problem sill exists for pinned
> deferrable timers.
> 
Yes. I will look forward to your series that implements Next steps and we can
discuss more about this. Please do keep the usecase/example, I have mentioned
above. We really don't want folks to use pinned deferrable timers as a
workaround because now deferrable timers do wake up CPUs otherwise.

Thanks,
Pavan
