Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B125FD818
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 13:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiJMLHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 07:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJMLHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 07:07:03 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C82910CFB9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 04:07:02 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso5370820pjq.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 04:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D4P6myG42mkZ8dAxkOq1KPGwMoapcvR4swZcDloXrJ4=;
        b=De+EkbPxRYKVeYch1+cZkRahc+mIsM4almtt+grHB3CAkloEScoLu405835znIr0TM
         4rC3q+zEYzPMKEJWmKPX/ERSAnI8JceAkjGaKpKj6I7fQPfH+3LQoF4QudLxYyMi2JA4
         40yWSqaw0/zLvj3iIKI+mrxBwV4cHOkiSqWN/mO/phK+awaRC0TKkumj1rxkgsZXH2ee
         MhSx3fVzUUT/F209CRd4dPgorVdv2gek628kqLj4PW5lGwcYDtfMxA7EUD/4n9RFywBa
         jBLbVDgKNezwNgGnLdyI1IQLW7A873UHedzg33+bkiAnXorYyXfRkQfzYAUtUoTsR0zH
         Oo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4P6myG42mkZ8dAxkOq1KPGwMoapcvR4swZcDloXrJ4=;
        b=AWv8S94K6hSSWS3xiUB4rRoI1kLLJDkgAwPuRBsIYfBDawHrdBpWIMdCTg+O9xQryH
         rTAPubaZXRvX2CTarKdri+G0zIu1e+sbjAUayA5T1ViH/7L17XkOHtF0qe37AqlrI0gY
         yHrIAU3Nca05GRyGFZbFvk1c1/PQTPlCl2khTwuFEPJJ6tBeceiiaC8eYkBSVVCqj88u
         hNed0N6sDp6mzAsvYqP6x3a/7TSOrPLFhKlLExTII8Z2yETYrgprGIxYiucVZfvSl0wm
         N7H7MLjI8aIYtrpjOPB9BtoRt1fsmFWrNutHZV+8mHElLuLISzCCOMqEmnPgRXXGrPQF
         /WWg==
X-Gm-Message-State: ACrzQf1W+CcWNbHHCi5bwHsrJty6Ibu2mO5T5Md9zkvIv41Hb8MHUDSM
        Xrm8ICac5IpR6MJ92ImjjlrUhXyXYIdnsg==
X-Google-Smtp-Source: AMsMyM65Dx8z4c6VkeuIbSpINlL5/hZHpXdyErT+2glXBozQBYKsO/7nhRbDgbzGN39HJ8J2haprJg==
X-Received: by 2002:a17:903:2307:b0:181:e618:b4c5 with SMTP id d7-20020a170903230700b00181e618b4c5mr22381453plh.172.1665659221441;
        Thu, 13 Oct 2022 04:07:01 -0700 (PDT)
Received: from [10.4.165.47] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id f13-20020a17090a638d00b00200b12f2bf3sm2951354pjj.51.2022.10.13.04.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 04:07:01 -0700 (PDT)
Message-ID: <46c6e1cc-77d3-eac1-fa18-deed2bac4a0e@bytedance.com>
Date:   Thu, 13 Oct 2022 19:06:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH] sched/psi: Fix avgs_work re-arm in psi_avgs_work()
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     hannes@cmpxchg.org, quic_pkondeti@quicinc.com,
        peterz@infradead.org, quic_charante@quicinc.com,
        linux-kernel@vger.kernel.org
References: <20220913140817.GA9091@hu-pkondeti-hyd.qualcomm.com>
 <20221010104206.12184-1-zhouchengming@bytedance.com>
 <CAJuCfpF7Z+CYhk-f_aaDTE232+m9z_n-QfjGfdLje7QrX9bFtw@mail.gmail.com>
 <a73f58a3-9f96-2ce5-38a0-8abab27a2260@bytedance.com>
 <CAJuCfpET+B3X-uX2vDp-2yH-+OVxOu3YXL7JWZrPuoh22P+5SQ@mail.gmail.com>
 <dea56c22-ab5b-25e2-9819-cc598f9aad80@bytedance.com>
 <CAJuCfpFTDyR1V+JYOY_uN6Xg1Nip5b=9dzkwm-CNd8vMWaQQFQ@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJuCfpFTDyR1V+JYOY_uN6Xg1Nip5b=9dzkwm-CNd8vMWaQQFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/13 02:24, Suren Baghdasaryan wrote:
> On Tue, Oct 11, 2022 at 7:11 PM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> On 2022/10/12 01:00, Suren Baghdasaryan wrote:
>>> On Mon, Oct 10, 2022 at 5:07 PM Chengming Zhou
>>> <zhouchengming@bytedance.com> wrote:
>>>>
>>>> Hello,
>>>>
>>>> On 2022/10/11 05:21, Suren Baghdasaryan wrote:
>>>>> On Mon, Oct 10, 2022 at 3:42 AM Chengming Zhou
>>>>> <zhouchengming@bytedance.com> wrote:
>>>>>>
>>>>>> Pavan reported a problem that PSI avgs_work idle shutoff is not
>>>>>> working at all. Because PSI_NONIDLE condition would be observed in
>>>>>> psi_avgs_work()->collect_percpu_times()->get_recent_times() even if
>>>>>> only the kworker running avgs_work on the CPU.
>>>>>>
>>>>>> Although commit 1b69ac6b40eb ("psi: fix aggregation idle shut-off")
>>>>>> avoided the ping-pong wake problem when the worker sleep, psi_avgs_work()
>>>>>> still will always re-arm the avgs_work, so shutoff is not working.
>>>>>>
>>>>>> This patch changes to consider current CPU groupc as IDLE if the
>>>>>> kworker running avgs_work is the only task running and no IOWAIT
>>>>>> or MEMSTALL sleep tasks, in which case we will shut off the avgs_work
>>>>>> if other CPUs' groupc are also IDLE.
>>>>>>
>>>>>> One potential problem is that the brief period of non-idle time
>>>>>> incurred between the aggregation run and the kworker's dequeue will
>>>>>> be stranded in the per-cpu buckets until avgs_work run next time.
>>>>>> The buckets can hold 4s worth of time, and future activity will wake
>>>>>> the avgs_work with a 2s delay, giving us 2s worth of data we can leave
>>>>>> behind when shut off the avgs_work. If the kworker run other works after
>>>>>> avgs_work shut off and doesn't have any scheduler activities for 2s,
>>>>>> this maybe a problem.
>>>>>>
>>>>>> Reported-by: Pavan Kondeti <quic_pkondeti@quicinc.com>
>>>>>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>>>>
>>>>> Copying my comments from
>>>>> https://lore.kernel.org/all/CAJuCfpHyYMak-mfVmtEN9Z-hGYQ6Wko57TLjukz9HaN26EDAuA@mail.gmail.com/
>>>>> in case you want to continue the discussion here...
>>>>>
>>>>>> ---
>>>>>>  kernel/sched/psi.c | 15 +++++++++++++++
>>>>>>  1 file changed, 15 insertions(+)
>>>>>>
>>>>>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>>>>>> index ee2ecc081422..f4cdf6f184ba 100644
>>>>>> --- a/kernel/sched/psi.c
>>>>>> +++ b/kernel/sched/psi.c
>>>>>> @@ -242,6 +242,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>>>>>                              u32 *pchanged_states)
>>>>>>  {
>>>>>>         struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
>>>>>> +       int current_cpu = raw_smp_processor_id();
>>>>>> +       bool only_avgs_work = false;
>>>>>>         u64 now, state_start;
>>>>>>         enum psi_states s;
>>>>>>         unsigned int seq;
>>>>>> @@ -256,6 +258,15 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>>>>>                 memcpy(times, groupc->times, sizeof(groupc->times));
>>>>>>                 state_mask = groupc->state_mask;
>>>>>>                 state_start = groupc->state_start;
>>>>>> +               /*
>>>>>> +                * This CPU has only avgs_work kworker running, snapshot the
>>>>>> +                * newest times then don't need to re-arm for this groupc.
>>>>>> +                * Normally this kworker will sleep soon and won't wake
>>>>>> +                * avgs_work back up in psi_group_change().
>>>>>> +                */
>>>>>> +               if (current_cpu == cpu && groupc->tasks[NR_RUNNING] == 1 &&
>>>>>> +                   !groupc->tasks[NR_IOWAIT] && !groupc->tasks[NR_MEMSTALL])
>>>>>> +                       only_avgs_work = true;
>>>>>
>>>>> Why do you determine only_avgs_work while taking a snapshot? The
>>>>> read_seqcount_retry() might fail and the loop gets retried, which
>>>>> might lead to a wrong only_avgs_work value if the state changes
>>>>> between retries. I think it's safer to do this after the snapshot was
>>>>> taken and to use tasks[NR_RUNNING] instead of  roupc->tasks.
>>>>
>>>> Ah, you are right, coping groupc->tasks[NR_RUNNING] and tasks[NR_IOWAIT], tasks[NR_MEMSTALL]
>>>> is ok for me. (Maybe we only need to copy groupc->tasks[NR_RUNNING]?)
>>>>
>>>> Another way is to add an else branch:
>>>>
>>>>                 if (current_cpu == cpu && groupc->tasks[NR_RUNNING] == 1 &&
>>>>                     !groupc->tasks[NR_IOWAIT] && !groupc->tasks[NR_MEMSTALL])
>>>>                         only_avgs_work = true;
>>>>                 else
>>>>                         only_avgs_work = false;
>>>>
>>>> Both are ok for me.
>>>
>>> Let's use the simple way and use the tasks[] after the snapshot is taken.
>>
>> Ok, I changed like this:
>>
>>         struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
>> +       int current_cpu = raw_smp_processor_id();
>> +       unsigned int tasks[NR_PSI_TASK_COUNTS];
>>         u64 now, state_start;
>>         enum psi_states s;
>>         unsigned int seq;
>> @@ -256,6 +258,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>                 memcpy(times, groupc->times, sizeof(groupc->times));
>>                 state_mask = groupc->state_mask;
>>                 state_start = groupc->state_start;
>> +               if (cpu == current_cpu)
>> +                       memcpy(tasks, groupc->tasks, sizeof(groupc->tasks));
>>         } while (read_seqcount_retry(&groupc->seq, seq));
>>
>>>
>>>>
>>>>>
>>>>>>         } while (read_seqcount_retry(&groupc->seq, seq));
>>>>>>
>>>>>>         /* Calculate state time deltas against the previous snapshot */
>>>>>> @@ -280,6 +291,10 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>>>>>                 if (delta)
>>>>>>                         *pchanged_states |= (1 << s);
>>>>>>         }
>>>>>> +
>>>>>> +       /* Clear PSI_NONIDLE so avgs_work won't be re-armed for this groupc */
>>>>>> +       if (only_avgs_work)
>>>>>> +               *pchanged_states &= ~(1 << PSI_NONIDLE);
>>>>>
>>>>> This seems to be safe because changed_states&(1<< PSI_NONIDLE) is used
>>>>> only for re-arming psi_avgs_work, however semantically this is
>>>>> incorrect. The CPU was not idle when it was executing psi_avgs_work.
>>>>> IMO a separate flag would avoid this confusion.
>>>>
>>>> Yes, it's safe, but has this confusion. Use a separate flag looks better, like PSI_ONLY_AVGS_WORK.
>>>> But then in collect_percpu_times() we still have to clear PSI_NONIDLE of this CPU if PSI_ONLY_AVGS_WORK
>>>> has been set.
>>>>
>>>>         for_each_possible_cpu(cpu) {
>>>>                 u32 times[NR_PSI_STATES];
>>>>                 u32 nonidle;
>>>>                 u32 cpu_changed_states;
>>>>
>>>>                 get_recent_times(group, cpu, aggregator, times,
>>>>                                 &cpu_changed_states);
>>>>                 changed_states |= cpu_changed_states;
>>>>
>>>> cpu_changed_states should clear PSI_NONIDLE if PSI_ONLY_AVGS_WORK already set.
>>>
>>> No, PSI_NONIDLE should not be affected by PSI_ONLY_AVGS_WORK. These
>>> flags should be independent and aggregated into changed_states without
>>> affecting each other. Something similar to how I suggested with
>>> PSI_STATE_WAKE_CLOCK in
>>> https://lore.kernel.org/all/CAJuCfpFr3JfwkWbDqkU=NUJbCYuCWGySwNusMCdmS3z95WD2AQ@mail.gmail.com/#t.
>>
>> If we don't clear PSI_NONIDLE of this CPU, changed_states |= cpu_changed_states;
>> so changed_states has PSI_NONIDLE, and we won't know if other CPUs are IDLE or not
>> in psi_avgs_work().
> 
> I was thinking something like this:
> 
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -244,6 +244,7 @@ static void get_recent_times(struct psi_group
> *group, int cpu,
>         enum psi_states s;
>         unsigned int seq;
>         u32 state_mask;
> +       bool reschedule;
> 
>         *pchanged_states = 0;
> 
> @@ -254,6 +255,14 @@ static void get_recent_times(struct psi_group
> *group, int cpu,
>                memcpy(times, groupc->times, sizeof(groupc->times));
>                state_mask = groupc->state_mask;
>                state_start = groupc->state_start;
> +              if (current_cpu == cpu)
> +                     reschedule = groupc->tasks[NR_RUNNING] +
> +                            groupc->tasks[NR_IOWAIT] +
> +                            groupc->tasks[NR_MEMSTALL] > 1;
> +              else
> +                     reschedule = times[PSI_NONIDLE] >
> +                            groupc->times_prev[aggregator][PSI_NONIDLE];
> +
>         } while (read_seqcount_retry(&groupc->seq, seq));
We can't use times[] here because it will incorporate currently active states
on the CPU.

Should I still need to copy groupc->tasks[] out for the current_cpu as you
suggested before?

> 
>         /* Calculate state time deltas against the previous snapshot */
> @@ -278,6 +287,8 @@ static void get_recent_times(struct psi_group
> *group, int cpu,
>                if (delta)
>                       *pchanged_states |= (1 << s);
>         }
> +       if (reschedule)
> +              *pchanged_states |= PSI_STATE_RESCHEDULE;

Is this ok?

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 4bd3913dd176..0cbcbf89a934 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -242,6 +242,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
                             u32 *pchanged_states)
 {
        struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
+       int current_cpu = raw_smp_processor_id();
+       bool reschedule;
        u64 now, state_start;
        enum psi_states s;
        unsigned int seq;
@@ -256,6 +258,10 @@ static void get_recent_times(struct psi_group *group, int cpu,
                memcpy(times, groupc->times, sizeof(groupc->times));
                state_mask = groupc->state_mask;
                state_start = groupc->state_start;
+               if (cpu == current_cpu)
+                       reschedule = groupc->tasks[NR_RUNNING] +
+                               groupc->tasks[NR_IOWAIT] +
+                               groupc->tasks[NR_MEMSTALL] > 1;
        } while (read_seqcount_retry(&groupc->seq, seq));

        /* Calculate state time deltas against the previous snapshot */
@@ -280,6 +286,12 @@ static void get_recent_times(struct psi_group *group, int cpu,
                if (delta)
                        *pchanged_states |= (1 << s);
        }
+
+       if (cpu != current_cpu)
+               reschedule = *pchanged_states & (1 << PSI_NONIDLE);
+
+       if (reschedule)
+               *pchanged_states |= (1 << PSI_STATE_RESCHEDULE);
 }


