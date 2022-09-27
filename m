Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626CC5EB6B7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 03:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiI0BQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 21:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiI0BQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 21:16:25 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98019DB53
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 18:16:24 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id s18so5224475qtx.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 18:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=lJiwUX4WFZna6i47oXwO2n1sgR7EUT5w4JOS9Ff/DHs=;
        b=DMfogkQLrXV5fFaGl5QnBXJa7ZN5DzeF4f2U4vdFC5Bk0q+dIUYqCWOTdHQuq6xnfu
         KpLyKoqQSsth+BaQTI2X7/uwxJeeZd0+2VlMonOcKEWM7nVkMcQRCUcTSaNozxfhvtlx
         k3TtMqbUGmFbQ/eA8CHc8+55Ro5tcKGCiLtf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lJiwUX4WFZna6i47oXwO2n1sgR7EUT5w4JOS9Ff/DHs=;
        b=0BZ510PQk6S8SLrFstoHvAsO4X/YDrCXhlmc4g0bC2ekGkyNoY3bwVdnW/IdnEqjJ3
         RvKw1U3hIL3tUzwql2y5GOj/Xs8oYCpZAtkFuvk4vlAD4J1g601VfOQU8nMdyaGV3eXA
         ywsF+i6YtHEMwrXz2+JKQCGzMKdpYezn+Y6IPp7Az3TVk8l46PLWnOvUO5NDfaFcr//D
         ecDO+B2VneivMcfhv/bL2WMI0tX4TWTZnzUs5Z7RZf/E+lLc+hHLHJ6cTfCdud51KPJV
         YluvHjwZpklZxcljMrqUC2ptdzmnrASvnGhj5rK7imA8wjUCqi9a81Sl20KdN0kd8XXe
         0HBQ==
X-Gm-Message-State: ACrzQf0Sw/lgFDohDx1vP+QMFiVEd8czbOIY9xiydiGXhe+rvtrHXBXx
        fkZwqHpbfKZAO+3Ke1dOkICSpw==
X-Google-Smtp-Source: AMsMyM7DObqjxVRoIL4Z/FvfFYgotF8xYyo0sfNheDBWvuAyyuXEPzB7Ar+QtUWnfJu7rVHj5ArW5g==
X-Received: by 2002:ac8:5748:0:b0:35b:ac34:ff37 with SMTP id 8-20020ac85748000000b0035bac34ff37mr20201051qtx.630.1664241383815;
        Mon, 26 Sep 2022 18:16:23 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id e2-20020ac84e42000000b00338ae1f5421sm24217qtw.0.2022.09.26.18.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 18:16:23 -0700 (PDT)
Date:   Tue, 27 Sep 2022 01:16:23 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <YzJO58HXH6YYxmND@google.com>
References: <20220926223534.GY4196@paulmck-ThinkPad-P17-Gen-1>
 <BE2B629D-B5D2-4ED0-944E-2F13E846047E@joelfernandes.org>
 <20220926235755.GD4196@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220926235755.GD4196@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 04:57:55PM -0700, Paul E. McKenney wrote:
[..]
> > >>>>>> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > >>>>>> index 08605ce7379d..40ae36904825 100644
> > >>>>>> --- a/include/linux/rcupdate.h
> > >>>>>> +++ b/include/linux/rcupdate.h
> > >>>>>> @@ -108,6 +108,13 @@ static inline int rcu_preempt_depth(void)
> > >>>>>> 
> > >>>>>> #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
> > >>>>>> 
> > >>>>>> +#ifdef CONFIG_RCU_LAZY
> > >>>>>> +void call_rcu_flush(struct rcu_head *head, rcu_callback_t func);
> > >>>>>> +#else
> > >>>>>> +static inline void call_rcu_flush(struct rcu_head *head,
> > >>>>>> +        rcu_callback_t func) {  call_rcu(head, func); }
> > >>>>>> +#endif
> > >>>>>> +
> > >>>>>> /* Internal to kernel */
> > >>>>>> void rcu_init(void);
> > >>>>>> extern int rcu_scheduler_active;
> > >>>>>> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > >>>>>> index f53ad63b2bc6..edd632e68497 100644
> > >>>>>> --- a/kernel/rcu/Kconfig
> > >>>>>> +++ b/kernel/rcu/Kconfig
> > >>>>>> @@ -314,4 +314,12 @@ config TASKS_TRACE_RCU_READ_MB
> > >>>>>>      Say N here if you hate read-side memory barriers.
> > >>>>>>      Take the default if you are unsure.
> > >>>>>> 
> > >>>>>> +config RCU_LAZY
> > >>>>>> +    bool "RCU callback lazy invocation functionality"
> > >>>>>> +    depends on RCU_NOCB_CPU
> > >>>>>> +    default n
> > >>>>>> +    help
> > >>>>>> +      To save power, batch RCU callbacks and flush after delay, memory
> > >>>>>> +      pressure or callback list growing too big.
> > >>>>>> +
> > >>>>>> 
> > >>>>> Do you think you need this kernel option? Can we just consider and make
> > >>>>> it a run-time configurable? For example much more users will give it a try,
> > >>>>> so it will increase a coverage. By default it can be off.
> > >>>>> 
> > >>>>> Also you do not need to do:
> > >>>>> 
> > >>>>> #ifdef LAZY
> > >>>> 
> > >>>> How does the "LAZY" macro end up being runtime-configurable? That's static /
> > >>>> compile time. Did I miss something?
> > >>>> 
> > >>> I am talking about removing if:
> > >>> 
> > >>> config RCU_LAZY
> > >>> 
> > >>> we might run into issues related to run-time switching though.
> > >> 
> > >> When we started off, Paul said he wanted it kernel CONFIGurable. I will defer
> > >> to Paul on a decision for that. I prefer kernel CONFIG so people don't forget
> > >> to pass a boot param.
> > > 
> > > I am fine with a kernel boot parameter for this one.  You guys were the
> > > ones preferring Kconfig options.  ;-)
> > 
> > Yes I still prefer that.. ;-)
> > 
> > > But in that case, the CONFIG_RCU_NOCB_CPU would come into play to handle
> > > the case where there is no bypass.
> > 
> > If you don’t mind, let’s do both like we did for NOCB_CPU_ALL. In which
> > case, Vlad since this was your suggestion, would you be so kind to send a
> > patch adding a boot parameter on top of the series? ;-). I’ll include it
> > in the next version. I’d suggest keep the boot param default off and add
> > a CONFIG option that forces the boot param to be turned on.
> 
> NOCB_CPU_ALL?  If you are thinking in terms of laziness/flushing being
> done on a per-CPU basis among the rcu_nocbs CPUs, that sounds like
> something for later.

Oh, no, I was just trying to bring that up as an example of making boot
parameters and CONFIG options for the same thing.

> Are you thinking in terms of Kconfig options that allow: (1) No laziness.
> (2) Laziness on all rcu_nocbs CPUs, but only if specified by a boot
> parameter.  (3) Laziness on all rcu_nocbs CPUs regardless of boot
> parameter.  I could get behind that.

Sure agreed, or we could just make it CONFIG_RCU_LAZY_DEFAULT=y and if boot
param is specified, override the CONFIG. That will be the simplest and least
confusing IMO.

thanks :)

 - Joel




> 
