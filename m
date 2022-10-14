Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6125FE6C6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 04:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJNCEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 22:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJNCEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 22:04:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B306BA8359
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 19:04:10 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a6-20020a17090abe0600b0020d7c0c6650so6616938pjs.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 19:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lC2pghpTe/REQRIwm7i5sqf6UNKbGEzV2cpJkMCHIBQ=;
        b=28MZN/1ShtOl3fkgyqUh/cC6SBCFNo3mlOfZGEJoloKnSObdeOiSPGsBR4u3wSS3ig
         Sj1BW4xxfjCNw+WZR0tKVsVivlSvDFvEpn60PcUTdEGOXJle724YLDG6aqenU3e1W5A/
         i/HaM6IpCTX/IHqBHYdDa3GjqeyCCxgeZTgmc05IG/Q4Im/gFwClK7AUik1xAgXoUT2w
         x67dlylf1n6LfZWNHRwFPmN9ODsCP1c+ta5cy6Ul0p47uC5s53MhTCmGb+AD4m7RS2xt
         rQ6TvxJscgQPHCvB3/L1U+8HXx1ID6zYjCkNfG9uHPQIbnvxNWwQ1NcrCrdiK7X6KJTf
         ZDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lC2pghpTe/REQRIwm7i5sqf6UNKbGEzV2cpJkMCHIBQ=;
        b=GXD+mUiOBRcQwEMjjUMgCeAPxciCH4/Cb+SWu0UC39zO0ReBAA/U3G/OkaoUYtmdcD
         keC8I4nfA4jaaxReyMMNDbLJ0KrdxGHL0yukzXRJ7q4rfiDBxNTimbKaDrFTN7+L4A4W
         2pJUO8e3qoRNOrBMpcLTLVMTrpCyDQGMMGuuTIWBkC4PW8j/oN/2/99+QtGgsdsdTZFw
         KQq1XiFGTdSULZe14EW6dtsMHq95rcy67Hzayv2jekF8bAtXnrCTnIflsM+3huzSUdah
         XRVMPbUizSZrkjsc9m6DNjz4mCzwTeMr/at9V2txJ36XE25Z5Yqiboa8fPQTbgw/Gn6J
         qF8A==
X-Gm-Message-State: ACrzQf3dMytygAH5aPJLwpEpBkUSYbxjjUH+zZbv9735ZlCYM9JqZ7F7
        pE9HJQ5jf5PzeI0yb/YYLPqJIA==
X-Google-Smtp-Source: AMsMyM4Zs0RF14FsucgUsQU/9c7SAmQvRsy5KKjSE8KaqSMeyuqlF7oekTnk3qDR5QJLGPD6v7w5wA==
X-Received: by 2002:a17:903:230a:b0:17d:707a:360e with SMTP id d10-20020a170903230a00b0017d707a360emr2902229plh.118.1665713043058;
        Thu, 13 Oct 2022 19:04:03 -0700 (PDT)
Received: from [10.4.165.47] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902654c00b00176c0e055f8sm490801pln.64.2022.10.13.19.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 19:04:02 -0700 (PDT)
Message-ID: <7dba12ce-f981-6017-0613-542472e3ec5c@bytedance.com>
Date:   Fri, 14 Oct 2022 10:03:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH] sched/psi: Fix avgs_work re-arm in psi_avgs_work()
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     quic_pkondeti@quicinc.com, peterz@infradead.org,
        quic_charante@quicinc.com, linux-kernel@vger.kernel.org
References: <20220913140817.GA9091@hu-pkondeti-hyd.qualcomm.com>
 <20221010104206.12184-1-zhouchengming@bytedance.com>
 <CAJuCfpF7Z+CYhk-f_aaDTE232+m9z_n-QfjGfdLje7QrX9bFtw@mail.gmail.com>
 <a73f58a3-9f96-2ce5-38a0-8abab27a2260@bytedance.com>
 <CAJuCfpET+B3X-uX2vDp-2yH-+OVxOu3YXL7JWZrPuoh22P+5SQ@mail.gmail.com>
 <dea56c22-ab5b-25e2-9819-cc598f9aad80@bytedance.com>
 <CAJuCfpFTDyR1V+JYOY_uN6Xg1Nip5b=9dzkwm-CNd8vMWaQQFQ@mail.gmail.com>
 <46c6e1cc-77d3-eac1-fa18-deed2bac4a0e@bytedance.com>
 <Y0g0UAAJMhPczNm/@cmpxchg.org>
 <CAJuCfpFo5EEEg24VLSmcPo=VDMszB9Q2a4L_Eq6E9VWnbsBJDQ@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJuCfpFo5EEEg24VLSmcPo=VDMszB9Q2a4L_Eq6E9VWnbsBJDQ@mail.gmail.com>
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

On 2022/10/14 00:10, Suren Baghdasaryan wrote:
> On Thu, Oct 13, 2022 at 8:52 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>>
>> On Thu, Oct 13, 2022 at 07:06:55PM +0800, Chengming Zhou wrote:
>>> Should I still need to copy groupc->tasks[] out for the current_cpu as you
>>> suggested before?
>>
>> It'd be my preference as well. This way the resched logic can be
>> consolidated into a single block of comment + code at the end of the
>> function.
> 
> Sounds good to me. If we are copying times in the retry loop then
> let's move the `reschedule =` decision out of that loop completely. At
> the end of get_recent_times we can do:
> 
> if (cpu == current_cpu)
>     reschedule = tasks[NR_RUNNING] +
>                             tasks[NR_IOWAIT] +
>                             tasks[NR_MEMSTALL] > 1;
> else
>     reschedule = *pchanged_states & (1 << PSI_NONIDLE);
> 

Ok, I will send an updated patch later.

Thanks!

> 
>>
>>> @@ -242,6 +242,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>>                              u32 *pchanged_states)
>>>  {
>>>         struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
>>> +       int current_cpu = raw_smp_processor_id();
>>> +       bool reschedule;
>>>         u64 now, state_start;
>>>         enum psi_states s;
>>>         unsigned int seq;
>>> @@ -256,6 +258,10 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>>                 memcpy(times, groupc->times, sizeof(groupc->times));
>>>                 state_mask = groupc->state_mask;
>>>                 state_start = groupc->state_start;
>>> +               if (cpu == current_cpu)
>>> +                       reschedule = groupc->tasks[NR_RUNNING] +
>>> +                               groupc->tasks[NR_IOWAIT] +
>>> +                               groupc->tasks[NR_MEMSTALL] > 1;
>>>         } while (read_seqcount_retry(&groupc->seq, seq));
>>
>> This also matches psi_show() and the poll worker. They don't currently
>> use the flag, but it's somewhat fragile and confusing. Add a test for
>> current_work() == &group->avgs_work?
> 
> Good point. (tasks[NR_RUNNING] + tasks[NR_IOWAIT] + tasks[NR_MEMSTALL]
>> 1) condition should also contain this check.
