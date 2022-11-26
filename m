Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EDE63935C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 03:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiKZC2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 21:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKZC2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 21:28:03 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EE7140BA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 18:28:01 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id p12so3766705qvu.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 18:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tC95WUlQqltGbn75svGveITOFZ0cbWQP93hKcfG6lXI=;
        b=eOJiJlxhf07yKAobx+hxeDH526ePYbMuRfI+3vnAfg8Cs8feHiJq+o9/Og1MK93KuA
         iJWcvzzXu+cKE9VDkp7BSUaxhJXtBRrOV9P3OGvOR9EFZ51tUjiOiNu5ULRamOepUAL4
         mrqgutAjdAPX/HP5UvRiIST9+QP24bNizpvSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tC95WUlQqltGbn75svGveITOFZ0cbWQP93hKcfG6lXI=;
        b=W4tqyjonTK9Vz40EFE3xYTD7qRtyY87wk35TgkVzLC3ZEw14Qaud01r+Y7ZPi4/im9
         k3f61WMwINieYyUDOOhECcKfZobFYQ2LUkx9qvlL85U+3TX80qXhc/rJ9jqSGa+MCRjX
         SQtzQMfi3cBBswFfdwMM52OquaV843J6oqtp/+rOxxDeeTclR6QetySC9LPMfEin8GMl
         52CzKTk9Cx6XymJZrlh/8kGI1So7IgB5JSLFuWM9HeCQV+nJ3A19euPmSisi1v26ZrIO
         TP4fDvXWKtmgERRh/NMjB7MNvfa/yZbBsOS/qJ4nitaAD+R55h5JwlU/DIOWRMtoOgq6
         6+rA==
X-Gm-Message-State: ANoB5pnKDMhyHVq2yEjmZoCxLM5JH5LZnJbnxeI0RYA66iZaWAloutZP
        CpH8WZPoYScQJ2eEstLZvJHI9w==
X-Google-Smtp-Source: AA0mqf7SbVaovaX04rcpLX2PVZF/RB4yUUnxWGzONzeEFY/VE43dOzz5i71UWXlJlRsjLItIB01Fgg==
X-Received: by 2002:a05:6214:370e:b0:4c6:9c41:13b1 with SMTP id np14-20020a056214370e00b004c69c4113b1mr33008835qvb.44.1669429680447;
        Fri, 25 Nov 2022 18:28:00 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id r2-20020ae9d602000000b006fb11eee465sm3780588qkk.64.2022.11.25.18.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 18:27:59 -0800 (PST)
Date:   Sat, 26 Nov 2022 02:27:59 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug
Message-ID: <Y4F5r9nLDtCrl6df@google.com>
References: <20221125155427.1381933-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125155427.1381933-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 11:54:27PM +0800, Zqiang wrote:
> Currently, for the case of num_online_cpus() <= 1, return directly,
> indicates the end of current grace period and then release old data.
> it's not accurate, for SMP system, when num_online_cpus() is equal
> one, maybe another cpu that in offline process(after invoke
> __cpu_disable()) is still in the rude RCU-Tasks critical section
> holding the old data, this lead to memory corruption.
> 
> Therefore, this commit add cpus_read_lock/unlock() before executing
> num_online_cpus().

I am not sure if this is needed. The only way what you suggest can happen is
if the tasks-RCU protected data is accessed after the num_online_cpus() value is
decremented on the CPU going offline.

However, the number of online CPUs value is changed on a CPU other than the
CPU going offline.

So there's no way the CPU going offline can run any code (it is already
dead courtesy of CPUHP_AP_IDLE_DEAD). So a corruption is impossible.

Or, did I miss something?

thanks,

 - Joel



> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tasks.h | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 4a991311be9b..08e72c6462d8 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1033,14 +1033,30 @@ static void rcu_tasks_be_rude(struct work_struct *work)
>  {
>  }
>  
> +static DEFINE_PER_CPU(struct work_struct, rude_work);
> +
>  // Wait for one rude RCU-tasks grace period.
>  static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>  {
> +	int cpu;
> +	struct work_struct *work;
> +
> +	cpus_read_lock();
>  	if (num_online_cpus() <= 1)
> -		return;	// Fastpath for only one CPU.
> +		goto end;// Fastpath for only one CPU.
>  
>  	rtp->n_ipis += cpumask_weight(cpu_online_mask);
> -	schedule_on_each_cpu(rcu_tasks_be_rude);
> +	for_each_online_cpu(cpu) {
> +		work = per_cpu_ptr(&rude_work, cpu);
> +		INIT_WORK(work, rcu_tasks_be_rude);
> +		schedule_work_on(cpu, work);
> +	}
> +
> +	for_each_online_cpu(cpu)
> +		flush_work(per_cpu_ptr(&rude_work, cpu));
> +
> +end:
> +	cpus_read_unlock();
>  }
>  
>  void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
> -- 
> 2.25.1
> 
