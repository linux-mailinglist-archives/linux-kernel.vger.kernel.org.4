Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166D45F9BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiJJJJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiJJJJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:09:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E33E46616
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 02:09:27 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29A6e10Y014849;
        Mon, 10 Oct 2022 09:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=bc72pHQzgz14V/rYwIfG322rECtodTqfyv1UIzpyQlE=;
 b=D5Ltr+kRSeWFJw0syhJfr9IhzBMXal8VLiNJvzbebAI2dhSPtIyZVdpZlAnmWizZ4kce
 Y24Misxtk0oUS/84L8Yz7rEx5iVvysVDs6oYMGLGdHGKkWnzzB1eqo8iWy15bpH+lMxc
 bjm/+VFP4QZqzOA1Zjl6vqh0CtFBOUh/jbhMjlSwHi4tWDkwZXay5t0P9HEP1yyEXe5x
 ffPuOg4SU+p8t6TlogQ3hQxzkdE0Drcpes8X+7gKU7tkw7SUCM5l8QQEVTjvMlqbyGCZ
 PW6gR8owjM6KvX0xKHhYBzb0XbPlO47cfEQdQcLq6eT2TZOoVTxhOw4JjBhJgGWOOLXm Aw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k31ghbfmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 09:09:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29A99NN1018998
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 09:09:23 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 10 Oct 2022 02:09:21 -0700
Date:   Mon, 10 Oct 2022 14:39:17 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: PSI idle-shutoff
Message-ID: <20221010090917.GF1474@hu-pkondeti-hyd.qualcomm.com>
References: <20220915062027.GA14713@hu-pkondeti-hyd.qualcomm.com>
 <CAJuCfpE_nM2uqixnds0d6wbsz4=OQ3KPoJ5HOqDhQXaxFGxwXQ@mail.gmail.com>
 <CAJuCfpEeNzDQ-CvMN3fP5LejOzpnfgUgvkzpPj1CLF-8NqNoww@mail.gmail.com>
 <CAJuCfpFr3JfwkWbDqkU=NUJbCYuCWGySwNusMCdmS3z95WD2AQ@mail.gmail.com>
 <43f4d1c3-52fe-5254-7d50-c420de6d11a6@bytedance.com>
 <ff2addac-5a6c-1aa5-5f1c-d62b0444ae4c@bytedance.com>
 <20221010061849.GB1474@hu-pkondeti-hyd.qualcomm.com>
 <20221010064309.GD1474@hu-pkondeti-hyd.qualcomm.com>
 <23360cd5-fe17-3c7e-af21-57dc058fcee0@bytedance.com>
 <259b1a8e-224b-200c-f07b-c4bf87e91dc5@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <259b1a8e-224b-200c-f07b-c4bf87e91dc5@bytedance.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pgUNuNF8pDQW34-Hyw2noCTzwrqZDK3X
X-Proofpoint-ORIG-GUID: pgUNuNF8pDQW34-Hyw2noCTzwrqZDK3X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210100055
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 04:30:36PM +0800, Chengming Zhou wrote:
> On 2022/10/10 14:57, Chengming Zhou wrote:
> > On 2022/10/10 14:43, Pavan Kondeti wrote:
> >> On Mon, Oct 10, 2022 at 11:48:49AM +0530, Pavan Kondeti wrote:
> >>> On Sun, Oct 09, 2022 at 09:17:34PM +0800, Chengming Zhou wrote:
> >>>> On 2022/10/9 20:41, Chengming Zhou wrote:
> >>>>> Hello,
> >>>>>
> >>>>> I just saw these emails, sorry for late.
> >>>>>
> >>>>> On 2022/10/6 00:32, Suren Baghdasaryan wrote:
> >>>>>> On Sun, Oct 2, 2022 at 11:11 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >>>>>>>
> >>>>>>> On Fri, Sep 16, 2022 at 10:45 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >>>>>>>>
> >>>>>>>> On Wed, Sep 14, 2022 at 11:20 PM Pavan Kondeti
> >>>>>>>> <quic_pkondeti@quicinc.com> wrote:
> >>>>>>>>>
> >>>>>>>>> On Tue, Sep 13, 2022 at 07:38:17PM +0530, Pavan Kondeti wrote:
> >>>>>>>>>> Hi
> >>>>>>>>>>
> >>>>>>>>>> The fact that psi_avgs_work()->collect_percpu_times()->get_recent_times()
> >>>>>>>>>> run from a kworker thread, PSI_NONIDLE condition would be observed as
> >>>>>>>>>> there is a RUNNING task. So we would always end up re-arming the work.
> >>>>>>>>>>
> >>>>>>>>>> If the work is re-armed from the psi_avgs_work() it self, the backing off
> >>>>>>>>>> logic in psi_task_change() (will be moved to psi_task_switch soon) can't
> >>>>>>>>>> help. The work is already scheduled. so we don't do anything there.
> >>>>>>>>
> >>>>>>>> Hi Pavan,
> >>>>>>>> Thanks for reporting the issue. IIRC [1] was meant to fix exactly this
> >>>>>>>> issue. At the time it was written I tested it and it seemed to work.
> >>>>>>>> Maybe I missed something or some other change introduced afterwards
> >>>>>>>> affected the shutoff logic. I'll take a closer look next week when I'm
> >>>>>>>> back at my computer and will consult with Johannes.
> >>>>>>>
> >>>>>>> Sorry for the delay. I had some time to look into this and test psi
> >>>>>>> shutoff on my device and I think you are right. The patch I mentioned
> >>>>>>> prevents new psi_avgs_work from being scheduled when the only non-idle
> >>>>>>> task is psi_avgs_work itself, however the regular 2sec averaging work
> >>>>>>> will still go on. I think we could record the fact that the only
> >>>>>>> active task is psi_avgs_work in record_times() using a new
> >>>>>>> psi_group_cpu.state_mask flag and then prevent psi_avgs_work() from
> >>>>>>> rescheduling itself if that flag is set for all non-idle cpus. I'll
> >>>>>>> test this approach and will post a patch for review if that works.
> >>>>>>
> >>>>>> Hi Pavan,
> >>>>>> Testing PSI shutoff on Android proved more difficult than I expected.
> >>>>>> Lots of tasks to silence and I keep encountering new ones.
> >>>>>> The approach I was thinking about is something like this:
> >>>>>>
> >>>>>> ---
> >>>>>>  include/linux/psi_types.h |  3 +++
> >>>>>>  kernel/sched/psi.c        | 12 +++++++++---
> >>>>>>  2 files changed, 12 insertions(+), 3 deletions(-)
> >>>>>>
> >>>>>> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> >>>>>> index c7fe7c089718..8d936f22cb5b 100644
> >>>>>> --- a/include/linux/psi_types.h
> >>>>>> +++ b/include/linux/psi_types.h
> >>>>>> @@ -68,6 +68,9 @@ enum psi_states {
> >>>>>>          NR_PSI_STATES = 7,
> >>>>>>  };
> >>>>>>
> >>>>>> +/* state_mask flag to keep re-arming averaging work */
> >>>>>> +#define PSI_STATE_WAKE_CLOCK        (1 << NR_PSI_STATES)
> >>>>>> +
> >>>>>>  enum psi_aggregators {
> >>>>>>          PSI_AVGS = 0,
> >>>>>>          PSI_POLL,
> >>>>>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> >>>>>> index ecb4b4ff4ce0..dd62ad28bacd 100644
> >>>>>> --- a/kernel/sched/psi.c
> >>>>>> +++ b/kernel/sched/psi.c
> >>>>>> @@ -278,6 +278,7 @@ static void get_recent_times(struct psi_group
> >>>>>> *group, int cpu,
> >>>>>>                  if (delta)
> >>>>>>                          *pchanged_states |= (1 << s);
> >>>>>>          }
> >>>>>> +        *pchanged_states |= (state_mask & PSI_STATE_WAKE_CLOCK);
> >>>>>
> >>>>> If the avgs_work kworker is running on this CPU, it will still see
> >>>>> PSI_STATE_WAKE_CLOCK set in state_mask? So the work will be re-armed?
> >>>>>
> >>>>> Maybe I missed something... but I have another different idea which
> >>>>> I want to implement later only for discussion.
> >>>>
> >>>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> >>>> index ee2ecc081422..f322e8fd8d41 100644
> >>>> --- a/kernel/sched/psi.c
> >>>> +++ b/kernel/sched/psi.c
> >>>> @@ -241,11 +241,13 @@ static void get_recent_times(struct psi_group *group, int cpu,
> >>>>                              enum psi_aggregators aggregator, u32 *times,
> >>>>                              u32 *pchanged_states)
> >>>>  {
> >>>> +       int current_cpu = raw_smp_processor_id();
> >>>>         struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
> >>>>         u64 now, state_start;
> >>>>         enum psi_states s;
> >>>>         unsigned int seq;
> >>>>         u32 state_mask;
> >>>> +       bool only_avgs_work = false;
> >>>>
> >>>>         *pchanged_states = 0;
> >>>>
> >>>> @@ -256,6 +258,14 @@ static void get_recent_times(struct psi_group *group, int cpu,
> >>>>                 memcpy(times, groupc->times, sizeof(groupc->times));
> >>>>                 state_mask = groupc->state_mask;
> >>>>                 state_start = groupc->state_start;
> >>>> +               /*
> >>>> +                * This CPU has only avgs_work kworker running, snapshot the
> >>>> +                * newest times then don't need to re-arm work for this groupc.
> >>>> +                * Normally this kworker will sleep soon and won't
> >>>> +                * wake_clock in psi_group_change().
> >>>> +                */
> >>>> +               if (current_cpu == cpu && groupc->tasks[NR_RUNNING] == 1)
> >>>> +                       only_avgs_work = true;
> >>>>         } while (read_seqcount_retry(&groupc->seq, seq));
> >>>>
> >>>>         /* Calculate state time deltas against the previous snapshot */
> >>>> @@ -280,6 +290,10 @@ static void get_recent_times(struct psi_group *group, int cpu,
> >>>>                 if (delta)
> >>>>                         *pchanged_states |= (1 << s);
> >>>>         }
> >>>> +
> >>>> +       /* Clear PSI_NONIDLE so avgs_work won't be re-armed for this groupc */
> >>>> +       if (only_avgs_work)
> >>>> +               *pchanged_states &= ~(1 << PSI_NONIDLE);
> >>>>  }
> >>>>
> >>> Thanks Chengming for the patch. I will test this patch and report my
> >>> observations. It makes sense to consider this CPU as non-idle if the PSI kworker
> >>> is the only task running. It could run other works but that decision is now
> >>> deferred to schedule out path. Ideally if this is the only (or last) work
> >>> running, we should not see PSI work not re-arming it self.
> >>>
> >>
> >> is condition groupc->tasks[NR_RUNNING] == 1 alone sufficient to clear NONIDLE?
> >> or should we also make sure that !NR_IOWAIT && !NR_MEMSTALL condition on this CPU?
> > 
> > Yes, I think you're correct, we should check !NR_IOWAIT && !NR_MEMSTALL too.
> > 
> 
> Hello,
> 
> Looks like this patch plus the !NR_IOWAIT && !NR_MEMSTALL condition can solve the
> avgs_work re-arm problem.
> 
Yes. This is inline with my observations. Without this patch, I see the PSI
work getting scheduled ~15 times in a 30 seconds trace. It is expected since
PSI FREQ is 2 seconds by default. With your patch, I see less number of PSI
work scheduled. More importantly, it is not scheduled from the work it self
when there is no other activity.

Like I said in the other thread, there is lot of noise I had to suppress to
reduce this problem. The moment, I removed all the suppression, things did
not look bright. one or the other deferrable timer expires due to PSI waking
up the CPU and then scheduling other tasks due to which PSI again queue the
work. I guess that varies from platform to platform.

This patch in principle makes sense to me. Atleast, we have a way of mechanism
for idle shutoff from work it self.

Thanks,
Pavan
