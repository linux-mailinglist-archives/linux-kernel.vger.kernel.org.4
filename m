Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1726C68A43F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 22:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjBCVH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 16:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjBCVHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 16:07:05 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25974A1472
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 13:05:20 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso8944288pju.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 13:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRkhbVYx72n4TXeP74pzIeW0EWRz202u/hdkivmgX8E=;
        b=bYQXV+7uhtyeNzG1HjS7VWvOmtEDV2Hag2GlbnJ4dTbFa1tjojwOOHGFe33i2GVo/O
         +75H8AmDNH5t2zD4gbhvuTiWlL4BfQEZ2qmx+XYkucQAKyIwbA8X6tBFeHxYdShEQF8o
         o2FTbtT/htoWaHFVHMOOXzQ+cQ1ZYjdwDSPNjEoccV8xYVIygFBS/cO78t0knDl3+xt3
         9FE9WkjgQQop8k0xAZuuPDbhlU1dQmqflmjlLJtlUU8JSD3K5to2YPdVF99wNjqSmqik
         eMH8mx8QxAdlmPmCZcmIRzFDFiS/e9t6m0Ja/7sKuNIkm17S+r0ImmVxo+fvkm1aPuaE
         soog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRkhbVYx72n4TXeP74pzIeW0EWRz202u/hdkivmgX8E=;
        b=o3BjTUI5iLFgjlp0oNB0MfvYS+6zH9LpIeEJMFGTKbR7x5cXHHGDMtbBiMR2jSgCZq
         PNr3r+0bIQkf6XtxvBBwVdqX9oo7p64XXprBQQ5+hzz1JwvFc2Ajx3HSqcgl6OYbXV17
         BIm3tFXEKGlUu3ouTwnpL3K/VEQH0To4i0xYFP1i3XMSZ24cbPMkFItgaXgS/UiwqrK4
         lzaT8kHqB2/tfT0KKqMYsoB0FOxeMX7aUHgiHrcNBLPI0CykcJS0vXeonj/7BhrB/kfy
         0mJ8OkhZD3C+CHGSfxy/RorvAyvXdj9trcVa9Jkn284c0MQNv0MAjwp7JNir6kGxjhY/
         jlAg==
X-Gm-Message-State: AO0yUKUCj3ApSsKEwP2QFGL/9XYiqYDj6TVjT/WUpuL3mYCCfgcRWgOV
        iRKPcgPepEtGS/NGicFY9kFAuqo8IpU=
X-Google-Smtp-Source: AK7set+WnQx5k9SxqLJOGh2THwS+yzAxAuiYmtpxkelfQZY45AU2AkmT8KNsMPDCOnAUcRfutLTNTQ==
X-Received: by 2002:a17:90a:195a:b0:230:7079:aec1 with SMTP id 26-20020a17090a195a00b002307079aec1mr4644202pjh.29.1675458292830;
        Fri, 03 Feb 2023 13:04:52 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:35e])
        by smtp.gmail.com with ESMTPSA id r19-20020a17090b051300b0022bb3ee9b68sm2084214pjz.13.2023.02.03.13.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 13:04:52 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 3 Feb 2023 11:04:50 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>, Phil Auld <pauld@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Fix a missed update of user_cpus_ptr
Message-ID: <Y9128uN5X8L3VTG3@slm.duckdns.org>
References: <20230203181849.221943-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203181849.221943-1-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 01:18:49PM -0500, Waiman Long wrote:
> Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
> cpumask"), a successful call to sched_setaffinity() should always save
> the user requested cpu affinity mask in a task's user_cpus_ptr. However,
> when the given cpu mask is the same as the current one, user_cpus_ptr
> is not updated. Fix this by saving the user mask in this case too.
> 
> Fixes: 8f9ea86fdf99 ("sched: Always preserve the user requested cpumask")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/sched/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 30d9752e2ca5..91255f791df3 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2951,8 +2951,11 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
>  	}
>  
>  	if (!(ctx->flags & SCA_MIGRATE_ENABLE)) {
> -		if (cpumask_equal(&p->cpus_mask, ctx->new_mask))
> +		if (cpumask_equal(&p->cpus_mask, ctx->new_mask)) {
> +			if (ctx->flags & SCA_USER)
> +				swap(p->user_cpus_ptr, ctx->user_mask);
>  			goto out;
> +		}
>  
>  		if (WARN_ON_ONCE(p == current &&
>  				 is_migration_disabled(p) &&

and this is for a separate bug and should go through the scheduler tree.

Thanks.

-- 
tejun
