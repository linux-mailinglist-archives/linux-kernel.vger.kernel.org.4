Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F915EAC16
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiIZQKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbiIZQKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:10:15 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F4F7675C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:57:59 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id i15so4454568qvp.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=xbwhnvTdoNg6ueeHazPEvzz2Z3FuunK0VXhpLtTzYFw=;
        b=nRAkXpuXiG6m/pcVUl+2/wPuloR0Z5A68mgxQFA7pNPcxanCYfMMuYYAxBWVSEKkif
         B3UcLIabAXLmVLY3Q0jkNqGOm3GSM1rOZUoHinH09LQm6Rw5mAY+DNGvvat4xMMNLRh2
         sjBS70l48jRUMnrd0m6TZWVrvdpTSKYNsm/AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=xbwhnvTdoNg6ueeHazPEvzz2Z3FuunK0VXhpLtTzYFw=;
        b=CCLrD78up3MPj6h0o5yr0Uv1Vhzl29Ti4kw6RALxxAYr5Xwn3p/+/sBZ7ZeTFS5DZ9
         lrnwICfVyo2q4E2lst4I+8mw7suQo5S/SUXpr4Ea1f0iGD2gSeEZ6FKfSakv96/jWP2k
         oL1sP5QzAkeYqdcsU9wztsY8pWazVN/b6I7WDRcsaczCr4tyFaAr0GIzSn7GG1qb7aX1
         8eef/1NK73lSLYHn5QfGLlmGr0uw+84/vPtUKoEDyCs3U9fltU+fWIaO8SiaJmI1drlF
         T2xZ8M2ru0R2vKbPiOD5hDQeeNWyLLF1pn8+//MjJ8b4V8LyHLMg+anmDVeUmGv+mvXX
         p/Dw==
X-Gm-Message-State: ACrzQf3QehqcUIdld62kX00ylS+jhBV3jQhddpUW/Zm5JmyHPrSKm5Uw
        2VUCrDmN3SdcsLQOS9uCc3XIOA==
X-Google-Smtp-Source: AMsMyM49SqsBPPe30T2MAYoswk50Edt/GDvg9Ukpu2O7MxeuGy5wQhh8SRtDGTo/7WE/rS9B9Acx7g==
X-Received: by 2002:ad4:5949:0:b0:4ad:89bb:f00f with SMTP id eo9-20020ad45949000000b004ad89bbf00fmr15642726qvb.114.1664204250349;
        Mon, 26 Sep 2022 07:57:30 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id br20-20020a05620a461400b006bb11f9a859sm11776609qkb.122.2022.09.26.07.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:57:29 -0700 (PDT)
Date:   Mon, 26 Sep 2022 14:57:29 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH 03/23] sched/core: Initialize the class of a new task
Message-ID: <YzG92YDyBK/0W+5u@google.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-4-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909231205.14009-4-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Fri, Sep 09, 2022 at 04:11:45PM -0700, Ricardo Neri wrote:
> New tasks shall start life as unclassified. They will be classified by
> hardware when they run.
> 
> Cc: Ben Segall <bsegall@google.com>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tim C. Chen <tim.c.chen@intel.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
>  kernel/sched/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ee28253c9ac0..db548c1a25ef 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4336,6 +4336,9 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
>  	p->se.prev_sum_exec_runtime	= 0;
>  	p->se.nr_migrations		= 0;
>  	p->se.vruntime			= 0;
> +#ifdef CONFIG_SCHED_TASK_CLASSES
> +	p->class			= TASK_CLASS_UNCLASSIFIED;
> +#endif

I find the term 'class' very broad and unclear what kind of class (without
further reading). So I am worried about how this generic term usage plays
with Linux source code in the long-term (like what if someone else comes up
with a usage of term 'class' that is unrelated to IPC.)

To that end, I was wondering if it could be renamed to p->ipc_class, and
CONFIG_SCHED_TASK_IPC_CLASSES, or something.

thanks,

 - Joel



>  	INIT_LIST_HEAD(&p->se.group_node);
>  
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> -- 
> 2.25.1
> 
