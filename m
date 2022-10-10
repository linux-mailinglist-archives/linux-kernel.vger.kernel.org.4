Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607855F9853
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiJJGZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiJJGZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:25:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33D024BCE
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 23:25:47 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29A4qjQ9003213;
        Mon, 10 Oct 2022 06:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=J8UqY5jMcefolzWBhdES3bvf9xXsBK30aBZ0Auemk/0=;
 b=lydWsfoqVYOOrultPAg3dpGvkd0aEbHOn2ixI/u2sR8BeXrIYEI3FewZAzXxAif63dxM
 jbhpNn8SVvtqJ2lxCQByNvcvfdSSTazInP5gnBxvyDwg3cQc9ZeZihHT/LtmZ/b2auo/
 uMJSDr9AhmzaQ4Umfow9xBncS3yKPWBxV1n83QiDIx5JO5Jrx99RoRR3JVRZJbGL6gW5
 JK4xHyxVYZvoFJDsNQkngMJGP1anlxs9UZgt6KSyTdwuVFqIIAFKG1smQoAKTOr/t76T
 E/Z8xJy+ARs6i8cOCEyDz1sLJagg1pz2TFgtSEbyZ+rq5qBqp918onXpFZfD5fWFYh3M Rg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k31fa3gp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 06:25:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29A6Pi7X001155
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 06:25:44 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Sun, 9 Oct 2022 23:25:42 -0700
Date:   Mon, 10 Oct 2022 11:55:38 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Suren Baghdasaryan <surenb@google.com>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: PSI idle-shutoff
Message-ID: <20221010062538.GC1474@hu-pkondeti-hyd.qualcomm.com>
References: <20220913140817.GA9091@hu-pkondeti-hyd.qualcomm.com>
 <20220915062027.GA14713@hu-pkondeti-hyd.qualcomm.com>
 <CAJuCfpE_nM2uqixnds0d6wbsz4=OQ3KPoJ5HOqDhQXaxFGxwXQ@mail.gmail.com>
 <CAJuCfpEeNzDQ-CvMN3fP5LejOzpnfgUgvkzpPj1CLF-8NqNoww@mail.gmail.com>
 <CAJuCfpFr3JfwkWbDqkU=NUJbCYuCWGySwNusMCdmS3z95WD2AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJuCfpFr3JfwkWbDqkU=NUJbCYuCWGySwNusMCdmS3z95WD2AQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vdNlbIDtfZ-z1hZluSSrOVLq36bdH4FY
X-Proofpoint-ORIG-GUID: vdNlbIDtfZ-z1hZluSSrOVLq36bdH4FY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210100038
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 09:32:44AM -0700, Suren Baghdasaryan wrote:
> On Sun, Oct 2, 2022 at 11:11 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Fri, Sep 16, 2022 at 10:45 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Wed, Sep 14, 2022 at 11:20 PM Pavan Kondeti
> > > <quic_pkondeti@quicinc.com> wrote:
> > > >
> > > > On Tue, Sep 13, 2022 at 07:38:17PM +0530, Pavan Kondeti wrote:
> > > > > Hi
> > > > >
> > > > > The fact that psi_avgs_work()->collect_percpu_times()->get_recent_times()
> > > > > run from a kworker thread, PSI_NONIDLE condition would be observed as
> > > > > there is a RUNNING task. So we would always end up re-arming the work.
> > > > >
> > > > > If the work is re-armed from the psi_avgs_work() it self, the backing off
> > > > > logic in psi_task_change() (will be moved to psi_task_switch soon) can't
> > > > > help. The work is already scheduled. so we don't do anything there.
> > >
> > > Hi Pavan,
> > > Thanks for reporting the issue. IIRC [1] was meant to fix exactly this
> > > issue. At the time it was written I tested it and it seemed to work.
> > > Maybe I missed something or some other change introduced afterwards
> > > affected the shutoff logic. I'll take a closer look next week when I'm
> > > back at my computer and will consult with Johannes.
> >
> > Sorry for the delay. I had some time to look into this and test psi
> > shutoff on my device and I think you are right. The patch I mentioned
> > prevents new psi_avgs_work from being scheduled when the only non-idle
> > task is psi_avgs_work itself, however the regular 2sec averaging work
> > will still go on. I think we could record the fact that the only
> > active task is psi_avgs_work in record_times() using a new
> > psi_group_cpu.state_mask flag and then prevent psi_avgs_work() from
> > rescheduling itself if that flag is set for all non-idle cpus. I'll
> > test this approach and will post a patch for review if that works.
> 

<snip>

> 
> This should detect the activity caused by psi_avgs_work() itself and
> ignore it when deciding to reschedule the averaging work. In the
> formula you posted:
> 
> non_idle_time = (work_start_now - wakeup_now) + (sleep_prev - work_end_prev)
> 
> the first term is calculated only if the PSI state is still active
> (https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L271).
> psi_group_change() will reset that state if psi_avgs_work() was the
> only task on that CPU, so it won't affect non_idle_time. The code
> above is to take care of the second term. Could you please check if
> this approach helps? As I mentioned I'm having trouble getting all the
> tasks silent on Android for a clear test.
> 
> The issue with deferrable timers that you mentioned, how often does
> that happen? If it happens only occasionally and prevents PSI shutoff
> for a couple of update cycles then I don't think that's a huge
> problem. Once PSI shutoff happens it should stay shut. Is that the
> case?

In our system, there are periodic but deferrable timers/works (DCVS, QOS related)
whose period is lower than PSI period. So once PSI average work runs, I see
other unrelated work getting scheduled due to which PSI runs again. I actually
added a hack not to re-arm the PSI work if the system has only one work
(nr_running() == 1) and still see the problem. The moment, I made PSI work as 
deferrable, all the problems gone. I know that is wrong as it could simply not 
run PSI work when other CPUs are busy.

Thanks,
Pavan
