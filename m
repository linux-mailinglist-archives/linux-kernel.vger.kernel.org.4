Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2846060439E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiJSLpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJSLoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:44:38 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A3A2BE39
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:24:32 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j7so28604155wrr.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qhq4XsHm9zBucvLkrTiP0zAM83hKGzPFColPYSxlPio=;
        b=yAXpN2Ke1P6pd+fxrUkG227eg+znIQ+GWsECK2wnzTfyQDL2bV/ObDcTf2UjYEB8wJ
         isKHeIW80H8JamnN9tf3ff+SuGWJAGL4w1vVIt7grjUYgkA4K8znQvv3zKkHOYw51MTw
         lQFKbUG2ALujj01wwTJrimSn4eJgAxKKwYQnOKgGd7PutIQUo9R8s00gdgwQNXQk6e5h
         Q5HlQUADVHpqhv2Sijir4Wzt10mwCvP5FLomfFPlbFi8OKfXbUK9O+VuuwoNw+2Pc9lC
         cocKGnB/Or3sODmrpRN3tHDfKQA8iGTyhqHRnulE0i72oACb3zzC7mloFP/9DKBbqDg/
         duwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhq4XsHm9zBucvLkrTiP0zAM83hKGzPFColPYSxlPio=;
        b=es55MxFVVGeOgR3rX54jpr2W2Tzp0k8Bd5XAwxMZKC5AJPi1NDFJfoXuXpQXZfESk3
         V6CIDYoTx/OVqku6K2qLP/ryZG/jI1qMyBC4ZmOAWAHoMatSTKevNvCiNYr+zB+oSSBa
         3xG5YQEOeeg4NnPIYoG43goD+ZQegxGk3qpnU8NIWbImdL8keSCtX/jTy0nWxaXBYN1m
         MUBtlimAW1GTAOfCUPR0nt3sAZSiffDq2FnOJ/072wyppbuDt7a9mU7Kg2Qpmbc1Oj7J
         igAXN+d3CF5+eGOTeQpMiWCeEyBK5GWnwRVLe6ips4v3z/DXw/QVnlF2N98Nov9Aa4E+
         iGEA==
X-Gm-Message-State: ACrzQf0MWLbgIMtX6B8qH7qhMVozc3kecmH/6gG1VHUt2IaKkd04H73P
        j9XfShd4zIk+UcX92GMbSQYBNw==
X-Google-Smtp-Source: AMsMyM63dSuKlJb/ry0vKZDK0GEcKK5kCPb6nnxxMioSiQKRp2dSi6gd4vbMZUVHnWNGjWXcOqIYdw==
X-Received: by 2002:a5d:5988:0:b0:22e:58fe:28cf with SMTP id n8-20020a5d5988000000b0022e58fe28cfmr4690564wri.440.1666178597630;
        Wed, 19 Oct 2022 04:23:17 -0700 (PDT)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id k16-20020a5d6290000000b0022ae4f8395dsm13056468wru.96.2022.10.19.04.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 04:23:17 -0700 (PDT)
Date:   Wed, 19 Oct 2022 12:23:15 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     John Stultz <jstultz@google.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Connor O'Brien <connoro@google.com>,
        John Dias <joaodias@google.com>, Rick Yiu <rickyiu@google.com>,
        John Kacur <jkacur@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        "J . Avila" <elavila@google.com>
Subject: Re: [PATCH RFC v4 2/3] sched: Avoid placing RT threads on cores
 handling long softirqs
Message-ID: <20221019112315.7d6wyc7d7dgzwsch@airbuntu>
References: <20221003232033.3404802-1-jstultz@google.com>
 <20221003232033.3404802-3-jstultz@google.com>
 <Y01NPB4sa8Z98ntK@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CANDhNCoTGNANDnOQ6touhreG_UEn1-N4T4BktWFxpLPSWVfrdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANDhNCoTGNANDnOQ6touhreG_UEn1-N4T4BktWFxpLPSWVfrdA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/22 20:42, John Stultz wrote:

> > > +     return ret;
> > > +}
> > > +#else
> > > +#define __use_softirq_opt 0
> > > +static bool cpu_busy_with_softirqs(int cpu)
> > > +{
> > > +     return false;
> > > +}
> > > +#endif /* CONFIG_RT_SOFTIRQ_OPTIMIZATION */
> > > +
> > > +static bool rt_task_fits_cpu(struct task_struct *p, int cpu)
> >
> > To me, the new name is unfortunate, since it strips a notion
> > of the reason. Instead, "CPU un/fits, because of capacity" it
> > reads as "CPU un/fits, because of ..." what?
> 
> As with all complicated questions: "It depends" :) On the kernel
> config specifically.
> 
> The earlier version of the patch had:
> rt_task_fits_capacity_and_may_preempt() but Qais suggested it be
> switched to the generic "fits_cpu" as it would depend on the kernel
> config as to which aspect of "fit" was being considered.
> 
> I guess it could be  rt_task_fits_capacity_and_softirq_free() ?

My line of thinking is that we have multiple reasons which could potentially
come and go. Having a simple generic name is future proof to the details of the
reason.

For example, in the future we might find a better way to handle the softirq
conflict and remove this reason; or we might find a new 'reason' is required.
Documenting that in the function header (if required, I see the one line
implementation is self descriptive so far) rather than in name made more sense
to me, hence the suggestion.

I am already aware of another new reason required to handle thermal pressure
when checking for capacity [1]. The discussion has stalled, but the problem is
still there and we'd need to address it. So I expect this code will be massaged
somewhat in the near future.

Sticking to rt_task_fits_cpu() will reduce the churn IMHO. But if you really
prefer something else, works for me :-)

[1] https://lore.kernel.org/lkml/20220514235513.jm7ul2y6uddj6eh2@airbuntu/


Cheers

--
Qais Yousef
