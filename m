Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7409A61DE05
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 21:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiKEUlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 16:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKEUlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 16:41:47 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A1ADEE7
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 13:41:45 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v7so4800005wmn.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 13:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VmRqjo9LBN5EMKWCXCOTGbj7esRT2XjeWm0BRCCpRu4=;
        b=TdeZJHX5FITMJ6oA94IZUK5csBY8GNC8acfdT/+SVfwLrk6vPTMQL1m9WjOBIADF2T
         QEEmtxr5eCNDl80GDLZ74utM0hVth0ZwQFs+/UEnc88ILmNYW+LIOjLnV+8doVxq/Owv
         VCmAhAwupLciOh3fmGb91FujT89v6Y3F/5+Ulza93pXgyp087weXxDTyqlnEMbQaivKO
         vYzYb9W4Cz4yRF8+8D+y/o9GmTD8JugJMcEnLejE5dmX3xZ4/tElvB3Krdm4Eqk1VRR0
         lIpYklQNOB1oBLziISFTIJEtiNPKbLFTg9BkKbItvIwjZNGctLzbxXnYqo7fr1A28J7M
         i52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmRqjo9LBN5EMKWCXCOTGbj7esRT2XjeWm0BRCCpRu4=;
        b=BPPbjTU3F+3VYaM5+Q3n9UidIG5rJhPognDCIKX2x9z/gC7TKfxJTBlHH+h+W5z30N
         qUAnUBQN6QdmQFerzrXLD1glhO2fLn9zkqvDja4yZghBZ2Z0ZvDhRQsG8SN9QTzhLF66
         c1ArF4NjAeRSjQVL4Ocw4mvViM2BqQyk5epnjBe8QdJWfMXRN9NqSGJnFdPdwpe52X7u
         eVx7OZ9YNS1qlMewAHqqTLEp/Km009bQxfHCOdfb9QLbiSssOwWGthWTdwGqAYH/dSJB
         tE+x4ArUXMAwaB0Yi/fDSvJlpEHsH6WTPsfhiumEiUJUDfV+kiQzpbzgSJklF35njA9k
         D9sg==
X-Gm-Message-State: ACrzQf1IFYmhajvHpK2VNIlQOKjU6QyA18uTWEx2ttCjf7Wni/UN0/un
        xPsaTAvfn6Vzx1BBhRoB/7W8/5Ccz0slzSCJV6g=
X-Google-Smtp-Source: AMsMyM4zOG4ak/iMMFiWZvHhjxIFU8Sm1T9UD9LEZBKu600CV08ghoIvEtwmUB7oM7YGec+KC+PG8Q==
X-Received: by 2002:a1c:6a17:0:b0:3cf:9d32:db2e with SMTP id f23-20020a1c6a17000000b003cf9d32db2emr4322767wmc.62.1667680903810;
        Sat, 05 Nov 2022 13:41:43 -0700 (PDT)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id i18-20020adfe492000000b002345cb2723esm3062064wrm.17.2022.11.05.13.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 13:41:43 -0700 (PDT)
Date:   Sat, 5 Nov 2022 20:41:41 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Valentin Schneider <vschneid@redhat.com>
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
Message-ID: <20221105204141.3tno6fzuh536ye4e@airbuntu>
References: <20220804143609.515789-1-qais.yousef@arm.com>
 <20220804143609.515789-10-qais.yousef@arm.com>
 <xhsmhwn8avd07.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xhsmhwn8avd07.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/22 17:35, Valentin Schneider wrote:
> On 04/08/22 15:36, Qais Yousef wrote:
> > We do consider thermal pressure in util_fits_cpu() for uclamp_min only.
> > With the exception of the biggest cores which by definition are the max
> > performance point of the system and all tasks by definition should fit.
> >
> > Even under thermal pressure, the capacity of the biggest CPU is the
> > highest in the system and should still fit every task. Except when it
> > reaches capacity inversion point, then this is no longer true.
> >
> > We can handle this by using the inverted capacity as capacity_orig in
> > util_fits_cpu(). Which not only addresses the problem above, but also
> > ensure uclamp_max now considers the inverted capacity. Force fitting
> > a task when a CPU is in this adverse state will contribute to making the
> > thermal throttling last longer.
> >
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > ---
> >  kernel/sched/fair.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index cb32dc9a057f..77ae343e32a3 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4293,12 +4293,16 @@ static inline int util_fits_cpu(unsigned long util,
> >        * For uclamp_max, we can tolerate a drop in performance level as the
> >        * goal is to cap the task. So it's okay if it's getting less.
> >        *
> > -	 * In case of capacity inversion, which is not handled yet, we should
> > -	 * honour the inverted capacity for both uclamp_min and uclamp_max all
> > -	 * the time.
> > +	 * In case of capacity inversion we should honour the inverted capacity
> > +	 * for both uclamp_min and uclamp_max all the time.
> >        */
> > -	capacity_orig = capacity_orig_of(cpu);
> > -	capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
> > +	capacity_orig = cpu_in_capacity_inversion(cpu);
> > +	if (capacity_orig) {
> > +		capacity_orig_thermal = capacity_orig;
> > +	} else {
> > +		capacity_orig = capacity_orig_of(cpu);
> > +		capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
> > +	}
> >
> 
> IIUC the rq->cpu_capacity_inverted computation in update_cpu_capacity() can be
> summarised as:
> 
> - If there is a PD with equal cap_orig, but higher effective (orig - thermal)
>   capacity
>   OR
>   there is a PD with pd_cap_orig > cpu_effective_cap:
>   rq->cpu_capacity_inverted = capacity_orig - thermal_load_avg(rq)
> 
> - Else:
>   rq->cpu_capacity_inverted = 0
> 
> Then, the code above uses either rq->cpu_capacity_inverted if it is
> non-zero, otherwise:
> 
>   capacity_orig - arch_scale_thermal_pressure(cpu);
> 
> Why use average thermal pressure in one case, and use instantaneous
> thermal pressure in the other?

There was a big debate on [1] about using avg vs instantaneous.

I used avg for detecting inversion to be consistent with using average in in
scale_rt_capacity(). I didn't want the inversion state to be flipping too
quickly too.

I used the instantaneous in the other check based on that discussion. It seemed
using the average is hurtful when for example the medium drops an OPP and by
not reacting quickly at wake up we lose the chance to place it on a big; which
if my memory didn't fail me is what Xuewen was seeing.

[1] https://lore.kernel.org/lkml/24631a27-42d9-229f-d9b0-040ac993b749@arm.com/

> 
> Can't we get rid of rq->cpu_capacity_inverted and replace this whole thing
> with an unconditional
> 
>   capacity_orig_thermal = capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu));
> 
> ?

I can't see how we end up with equivalent behavior then. Or address the
concerns raised by Xuewen and Lukasz on the RT thread in regards to avg vs
instantaneous.

Specifically, if we don't use the new rq->cpu_capacity_inverted we can't handle
the case where the task is requesting to run at maximum performance but a small
drop in thermal pressure means it won't fit anywhere. That PD is the best fit
until it hits an inversion.

Originally I wanted to defer handling thermal pressure into a different series.
But Vincent thought it's better to handle it now. We want more data points from
more systems tbh. But I think what we have now is still a good improvement over
what we had before.

Lukasz had a patch [2] which could allow making thermal_load_avg() more
acceptable for systems that care about faster response times.

[2] https://lore.kernel.org/lkml/20220429091245.12423-1-lukasz.luba@arm.com/


Thanks

--
Qais Yousef
