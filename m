Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A493A620853
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbiKHEkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiKHEj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:39:58 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B94B27CF2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 20:39:56 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A84bHBd028201;
        Tue, 8 Nov 2022 04:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=gD3uIyXfiOGcXhczMRga6Oy/J2b2pNZF8KhTc1IKG+o=;
 b=ls7GTW1jpY40/6h2zj8r98e17PBfcevidWI/bglhc0uE1wnJxzrZ1Hi/PZkrZeJd9qs2
 eXRBCRH6uzxFdWo7KGVUUv5GJ4qCAUM12poGWDp9b6C/hxCvnzH6P+pMZeDNnqvBUm29
 ugOpvL2CN2D/lLgFBeyj+8PZcu9FMgvk2UgOWoerRiTBrDpWyMRUz2lhm3/1VnR6SvG4
 jVgeoekJsppq1v/pViKqGGx6Pg7mMoSSMF67z64ZLpemoK/FSkdnXMuGoGO6IknLPA+w
 hDaWpCHi4P4ptYMxShqI/me6eLcMpSWYZdNMl6Vpql/yRkNvepR/jQwKWULoEzgoWpup Xg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kq5yq9ayu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 04:37:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A84bFcd029366
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Nov 2022 04:37:15 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 7 Nov 2022 20:37:12 -0800
Date:   Tue, 8 Nov 2022 10:07:08 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v4 00/16] timer: Move from a push remote at enqueue to a
 pull at expiry model
Message-ID: <20221108043708.GA9994@hu-pkondeti-hyd.qualcomm.com>
References: <20221104145737.71236-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221104145737.71236-1-anna-maria@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dhsdLcuyEFCfx3UMWWijETGslqA2bwvI
X-Proofpoint-ORIG-GUID: dhsdLcuyEFCfx3UMWWijETGslqA2bwvI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080023
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anna-Maria,

On Fri, Nov 04, 2022 at 03:57:21PM +0100, Anna-Maria Behnsen wrote:
> Placing timers at enqueue time on a target CPU based on dubious heuristics
> does not make any sense:
> 
>  1) Most timer wheel timers are canceled or rearmed before they expire.
> 
>  2) The heuristics to predict which CPU will be busy when the timer expires
>     are wrong by definition.
> 
> So placing the timers at enqueue wastes precious cycles.
> 
> The proper solution to this problem is to always queue the timers on the
> local CPU and allow the non pinned timers to be pulled onto a busy CPU at
> expiry time.
> 
> Therefore split the timer storage into local pinned and global timers:
> Local pinned timers are always expired on the CPU on which they have been
> queued. Global timers can be expired on any CPU.
> 
> As long as a CPU is busy it expires both local and global timers. When a
> CPU goes idle it arms for the first expiring local timer. If the first
> expiring pinned (local) timer is before the first expiring movable timer,
> then no action is required because the CPU will wake up before the first
> movable timer expires. If the first expiring movable timer is before the
> first expiring pinned (local) timer, then this timer is queued into a idle
> timerqueue and eventually expired by some other active CPU.
> 
> To avoid global locking the timerqueues are implemented as a hierarchy. The
> lowest level of the hierarchy holds the CPUs. The CPUs are associated to
> groups of 8, which are seperated per node. If more than one CPU group
> exist, then a second level in the hierarchy collects the groups. Depending
> on the size of the system more than 2 levels are required. Each group has a
> "migrator" which checks the timerqueue during the tick for remote expirable
> timers.
> 
> If the last CPU in a group goes idle it reports the first expiring event in
> the group up to the next group(s) in the hierarchy. If the last CPU goes
> idle it arms its timer for the first system wide expiring timer to ensure
> that no timer event is missed.
> 
> 
> Testing
> ~~~~~~~
> 
> The impact of wasting cycles during enqueue by using the heuristic in
> contrast to always queueing the timer on the local CPU was measured with a
> micro benchmark. Therefore a timer is enqueued and dequeued in a loop with
> 1000 repetitions on a isolated CPU. The time the loop takes is measured. A
> quater of the remaining CPUs was kept busy. This measurement was repeated
> several times. With the patch queue the average duration was reduced by
> approximately 25%.
> 
> 	145ns	plain v6
> 	109ns	v6 with patch queue
> 
> 
> Furthermore the impact of residence in deep idle states of an idle system
> was investigated. The patch queue doesn't downgrade this behavior.
> 
> 
> During testing on a mostly idle machine a ping pong game could be observed:
> a process_timeout timer is expired remotely on a non idle CPU. Then the CPU
> where the schedule_timeout() was executed to enqueue the timer comes out of
> idle and restarts the timer using schedule_timeout() and goes back to idle
> again. This is due to the fair scheduler which tries to keep the task on
> the CPU which it previously executed on.
> 
> 
> Next Steps
> ~~~~~~~~~~
> 
> Simple deferrable timers are no longer required as they can be converted to
> global timers. If a CPU goes idle, a formerly deferrable timer will not
> prevent the CPU to sleep as long as possible. Only the last migrator CPU
> has to take care of them. Deferrable timers with timer pinned flags needs
> to be expired on the specified CPU but must not prevent CPU from going
> idle. They require their own timer base which is never taken into account
> when calculating the next expiry time. This conversation and required
> cleanup will be done in a follow up series.
> 

Taking non-pinned deferrable timers case, they are queued on their own base
and its expiry is not taken into account while programming the next timer
event during idle.

Can you elaborate on "Simple deferrable timers are no longer required as they
can be converted to global timers" statement?

Though they can be on global base, we still need to find a way to distinguish
them aginst the normal global timers so that the last migrator can program
the next timer event without taking these deferrable timer expiry into
account? IOW, a deferrable timer should not bring a completely idle system out
of idle to serve the deferrable timer.

When the deferrable timers will be queued on global base, once a CPU comes out
of idle and serve the timers on global base, the deferrable timers also would
be served. This is a welcoming change. We would see a truly deferrable global
timer something we would be interested in. [1] has some background on this.

[1]
https://lore.kernel.org/lkml/1430188744-24737-1-git-send-email-joonwoop@codeaurora.org/

Thanks,
Pavan
