Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E623761FE0F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiKGS7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiKGS7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:59:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D72F65
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 10:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667847509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zAtcEOPSlot0plj2rcnsTapnoNeT01CxSTEjWLgd9/A=;
        b=DJ1LFH49HEvJrm+UWXyFPd2yzO66yrSWULyYzKsiaalNVgNpchkPTnU6TYXgW5aG9BYJh6
        0EWmXltIxm8W+I8tzsSk/ISSZgaTj0yxwujbiq10PJ9aQqoePkaA9yr+6rj1tcCkO6oJ1g
        xcc65MnYy2MPhla+vTtdkJeAOBwlHGA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-351-oRFo4PqOO_SgjVKSxv2zIg-1; Mon, 07 Nov 2022 13:58:26 -0500
X-MC-Unique: oRFo4PqOO_SgjVKSxv2zIg-1
Received: by mail-wr1-f71.google.com with SMTP id h18-20020adfa4d2000000b00236584fc8c7so3084556wrb.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 10:58:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zAtcEOPSlot0plj2rcnsTapnoNeT01CxSTEjWLgd9/A=;
        b=WQgRTtI7/v3MyGH68/fw/kWm9VuHO0syXzFS2ZCk4rsHB9E1UJh23nEUrhkhfyuzIn
         9cZp06J/y9k4P0MdJnEu95PBZ34EOtvJfrFaGIOaBzk2KGM1W+9XbCBXdICm+BM1YoE7
         cOFyuUJNWvpey5xzG4rpHZlbv1ZEf/yWHJ5kHVY2XksuYp72FKNLwXN2vDg982lVj1RH
         DdmGgp71HnFSLfk808Yq/2tG5MY9KqSCraFhOCg9ORLU+XSice8TZEVxma5B16vkojpX
         cqW/UItxDwlvFJ5OSMQIsxnUPRFPASLfY41EVPCgdkjW9oBlXy8goKSQFlQvHScYH17Z
         +uIQ==
X-Gm-Message-State: ACrzQf2s8b+TPQIw/yP8ooHiJsGVZLkgjvzbL8x+oXp0iu4XG/GH/iLB
        4GulDDoSpC1eTU1y2NUMvXEQFtLKbkikLpzvzFAU1cTml0+LPWBV2pKOAtobWUsy+YFe0PpLvdJ
        KOM/xauDs2gNjPEE6g/IWEYia
X-Received: by 2002:a05:600c:5388:b0:3c5:4c1:a1f6 with SMTP id hg8-20020a05600c538800b003c504c1a1f6mr34552896wmb.11.1667847504982;
        Mon, 07 Nov 2022 10:58:24 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7N36r1wNwR+0Wql6ZMTaLxXdMQmSdQqpgHVXqn7a8pp4qgv1x8kBYd0zW2p3ob8L0JqfocJA==
X-Received: by 2002:a05:600c:5388:b0:3c5:4c1:a1f6 with SMTP id hg8-20020a05600c538800b003c504c1a1f6mr34552881wmb.11.1667847504718;
        Mon, 07 Nov 2022 10:58:24 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id bq21-20020a5d5a15000000b00231ed902a4esm8387926wrb.5.2022.11.07.10.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:58:24 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>
Subject: Re: [PATCH v2 9/9] sched/fair: Consider capacity inversion in
 util_fits_cpu()
In-Reply-To: <20221105204141.3tno6fzuh536ye4e@airbuntu>
References: <20220804143609.515789-1-qais.yousef@arm.com>
 <20220804143609.515789-10-qais.yousef@arm.com>
 <xhsmhwn8avd07.mognet@vschneid.remote.csb>
 <20221105204141.3tno6fzuh536ye4e@airbuntu>
Date:   Mon, 07 Nov 2022 18:58:23 +0000
Message-ID: <xhsmho7timw1c.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/22 20:41, Qais Yousef wrote:
> On 11/04/22 17:35, Valentin Schneider wrote:
>> On 04/08/22 15:36, Qais Yousef wrote:
>> > We do consider thermal pressure in util_fits_cpu() for uclamp_min only.
>> > With the exception of the biggest cores which by definition are the max
>> > performance point of the system and all tasks by definition should fit.
>> >
>> > Even under thermal pressure, the capacity of the biggest CPU is the
>> > highest in the system and should still fit every task. Except when it
>> > reaches capacity inversion point, then this is no longer true.
>> >
>> > We can handle this by using the inverted capacity as capacity_orig in
>> > util_fits_cpu(). Which not only addresses the problem above, but also
>> > ensure uclamp_max now considers the inverted capacity. Force fitting
>> > a task when a CPU is in this adverse state will contribute to making the
>> > thermal throttling last longer.
>> >
>> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
>> > ---
>> >  kernel/sched/fair.c | 14 +++++++++-----
>> >  1 file changed, 9 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> > index cb32dc9a057f..77ae343e32a3 100644
>> > --- a/kernel/sched/fair.c
>> > +++ b/kernel/sched/fair.c
>> > @@ -4293,12 +4293,16 @@ static inline int util_fits_cpu(unsigned long util,
>> >        * For uclamp_max, we can tolerate a drop in performance level as the
>> >        * goal is to cap the task. So it's okay if it's getting less.
>> >        *
>> > -	 * In case of capacity inversion, which is not handled yet, we should
>> > -	 * honour the inverted capacity for both uclamp_min and uclamp_max all
>> > -	 * the time.
>> > +	 * In case of capacity inversion we should honour the inverted capacity
>> > +	 * for both uclamp_min and uclamp_max all the time.
>> >        */
>> > -	capacity_orig = capacity_orig_of(cpu);
>> > -	capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
>> > +	capacity_orig = cpu_in_capacity_inversion(cpu);
>> > +	if (capacity_orig) {
>> > +		capacity_orig_thermal = capacity_orig;
>> > +	} else {
>> > +		capacity_orig = capacity_orig_of(cpu);
>> > +		capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
>> > +	}
>> >
>>
>> IIUC the rq->cpu_capacity_inverted computation in update_cpu_capacity() can be
>> summarised as:
>>
>> - If there is a PD with equal cap_orig, but higher effective (orig - thermal)
>>   capacity
>>   OR
>>   there is a PD with pd_cap_orig > cpu_effective_cap:
>>   rq->cpu_capacity_inverted = capacity_orig - thermal_load_avg(rq)
>>
>> - Else:
>>   rq->cpu_capacity_inverted = 0
>>
>> Then, the code above uses either rq->cpu_capacity_inverted if it is
>> non-zero, otherwise:
>>
>>   capacity_orig - arch_scale_thermal_pressure(cpu);
>>
>> Why use average thermal pressure in one case, and use instantaneous
>> thermal pressure in the other?
>
> There was a big debate on [1] about using avg vs instantaneous.
>

Interesting thread, thanks for the link!

> I used avg for detecting inversion to be consistent with using average in in
> scale_rt_capacity(). I didn't want the inversion state to be flipping too
> quickly too.
>
> I used the instantaneous in the other check based on that discussion. It seemed
> using the average is hurtful when for example the medium drops an OPP and by
> not reacting quickly at wake up we lose the chance to place it on a big; which
> if my memory didn't fail me is what Xuewen was seeing.
>

OK So IIUC by using the inst. pressure you start excluding CPUs sooner, and
with the avg pressure you keep those CPUs out (if the pressure remained
long enough).

> [1] https://lore.kernel.org/lkml/24631a27-42d9-229f-d9b0-040ac993b749@arm.com/
>

>>
>> Can't we get rid of rq->cpu_capacity_inverted and replace this whole thing
>> with an unconditional
>>
>>   capacity_orig_thermal = capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu));
>>
>> ?
>
> I can't see how we end up with equivalent behavior then. Or address the
> concerns raised by Xuewen and Lukasz on the RT thread in regards to avg vs
> instantaneous.
>
> Specifically, if we don't use the new rq->cpu_capacity_inverted we can't handle
> the case where the task is requesting to run at maximum performance but a small
> drop in thermal pressure means it won't fit anywhere. That PD is the best fit
> until it hits an inversion.
>
> Originally I wanted to defer handling thermal pressure into a different series.
> But Vincent thought it's better to handle it now. We want more data points from
> more systems tbh. But I think what we have now is still a good improvement over
> what we had before.
>
> Lukasz had a patch [2] which could allow making thermal_load_avg() more
> acceptable for systems that care about faster response times.
>
> [2] https://lore.kernel.org/lkml/20220429091245.12423-1-lukasz.luba@arm.com/
>
>
> Thanks
>
> --
> Qais Yousef

