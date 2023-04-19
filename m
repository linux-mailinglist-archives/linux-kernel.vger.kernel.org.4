Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9EA6E80AC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 19:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjDSRy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 13:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjDSRyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 13:54:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692BB2D56
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 10:54:21 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-2f625d52275so3468592f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 10:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1681926860; x=1684518860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yj8PvCkjhqlGLpJgZC/Q2Bpv2VR5GOR+cVFRYANmF9w=;
        b=tCM9O56kNnHzXWe9/6XSrxEfZ0NJbNQPHtKUnEr1krjp80qJqtuAFEmUKCT4g9lFZd
         vRIlA+qPPw91grXR5DWu+2Th7pEt4fFIoe9fxeAKvdLwoj6Uwb7lx6y7TovoIhXtdTOc
         IDbQLzZhWBlwX8b1h3u4/NC7dtGJU7FfReEfsq1F0e1mluIOtaprVWl2YDuezxT1WPoA
         qPcaSaTRpMaC9qqDPZgM9371FJ23xgMiF/HMXxNqNYnCrZ4eWjSPrHXSigdlsbbrp4yP
         +IwVSXWwsgJ3BltcO15sIqNKmLPTXO95ZmO7ij9+3nJMk+auxmY4brp6HCatqKgGGJcT
         lrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681926860; x=1684518860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yj8PvCkjhqlGLpJgZC/Q2Bpv2VR5GOR+cVFRYANmF9w=;
        b=FPBoCGzTvLjdm3WZTJm2G5wCv0Kjow9EXAZ8JgrnqrZrVKpSKomD80i4aI5u56s1GM
         qgY99ylh6gn8C/bxd5FKdr9JDHA4PwOtrZbPLgS2NGLgQe3kRzTKNMhbe7qKbtNge/Pl
         0hiZzTA0IStnYsmEDg8tqEGygIlycG6d4180MvlSbtJ5rJAZuzzrDP75emxSycLu3Cpt
         iEmDWeSTJ+cVbxaHrqKQspHd2teUBXzl0Fw/lXzU7mEywl2PIywD6ernW/kc2bHO15ZU
         vxYKRudxjnUh2EWc5/SQl06XwCVKRFRNjgBwLZuVKHcPeDI9t0vbWazTk8uR1G623ERO
         CsQQ==
X-Gm-Message-State: AAQBX9f/Bbj8wMgIgs/MObeOTRql81ojiu7cxVpVVmCapN2ocH5POeOL
        vfhOwtpc2l/3wp33efmAyLIpxw==
X-Google-Smtp-Source: AKy350b7N3K1PIsDxip1YeFxObxVGjVJMIaPkVDiKdgvKCFeHAbPsk5En/D9eoavfPRnvFWU4Iib7Q==
X-Received: by 2002:adf:ee86:0:b0:2f8:3225:2bc2 with SMTP id b6-20020adfee86000000b002f832252bc2mr5337794wro.41.1681926859842;
        Wed, 19 Apr 2023 10:54:19 -0700 (PDT)
Received: from airbuntu (host109-154-46-114.range109-154.btcentralplus.com. [109.154.46.114])
        by smtp.gmail.com with ESMTPSA id y14-20020adffa4e000000b002f5fbc6ffb2sm16248915wrr.23.2023.04.19.10.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 10:54:19 -0700 (PDT)
Date:   Wed, 19 Apr 2023 18:54:14 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     David Dai <davidai@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Qais Yousef <qyousef@google.com>,
        Quentin Perret <qperret@google.com>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1] sched/uclamp: Introduce
 SCHED_FLAG_RESET_UCLAMP_ON_FORK flag
Message-ID: <20230419175414.ycnlaperdkjxgypx@airbuntu>
References: <20230416213406.2966521-1-davidai@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230416213406.2966521-1-davidai@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David!

On 04/16/23 14:34, David Dai wrote:
> A userspace service may manage uclamp dynamically for individual tasks and
> a child task will unintentionally inherit a pesudo-random uclamp setting.
> This could result in the child task being stuck with a static uclamp value
> that results in poor performance or poor power.
> 
> Using SCHED_FLAG_RESET_ON_FORK is too coarse for this usecase and will
> reset other useful scheduler attributes. Adding a
> SCHED_FLAG_RESET_UCLAMP_ON_FORK will allow userspace to have finer control
> over scheduler attributes of child processes.

Thanks a lot for the patch. This has a been a known limitation for a while but
didn't manage to find the time to push anything yet.

ADPF (Android Dynamic Performance Framework) exposes APIs to manage performance
for a set of pids [1]. Only these tasks belong to the session and any forked
tasked is expected to have its uclamp values reset. But as you pointed out, the
current RESET_ON_FORK resets everything, but we don't want that as these
attributes don't belong to ADPF to decide whether they should be reset too or
not. And not resetting them means we can end up with tasks inheriting random
uclamp values unintentionally. We can't tell these tasks not to fork anything.
If the forked tasks are expected to be part of the session, then their pids
must be added explicitly.

[1] https://developer.android.com/reference/android/os/PerformanceHintManager#createHintSession(int%5B%5D,%20long)

> 
> Cc: Qais Yousef <qyousef@google.com>
> Cc: Quentin Perret <qperret@google.com>
> Cc: Saravana Kannan <saravanak@google.com>
> Signed-off-by: David Dai <davidai@google.com>
> ---
>  include/linux/sched.h            | 3 +++
>  include/uapi/linux/sched.h       | 4 +++-
>  kernel/sched/core.c              | 6 +++++-
>  tools/include/uapi/linux/sched.h | 4 +++-
>  4 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 63d242164b1a..b1676b9381f9 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -885,6 +885,9 @@ struct task_struct {
>  	unsigned			sched_reset_on_fork:1;

nit: can't we convert to a flag and re-use?

>  	unsigned			sched_contributes_to_load:1;
>  	unsigned			sched_migrated:1;
> +#ifdef CONFIG_UCLAMP_TASK
> +	unsigned			sched_reset_uclamp_on_fork:1;
> +#endif
>  
>  	/* Force alignment to the next boundary: */
>  	unsigned			:0;
> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> index 3bac0a8ceab2..7515106e1f1a 100644
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -132,12 +132,14 @@ struct clone_args {
>  #define SCHED_FLAG_KEEP_PARAMS		0x10
>  #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
>  #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
> +#define SCHED_FLAG_RESET_UCLAMP_ON_FORK	0x80
>  
>  #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
>  				 SCHED_FLAG_KEEP_PARAMS)
>  
>  #define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
> -				 SCHED_FLAG_UTIL_CLAMP_MAX)
> +				 SCHED_FLAG_UTIL_CLAMP_MAX | \
> +				 SCHED_FLAG_RESET_UCLAMP_ON_FORK)

I was considering to have something a bit more generic that allows selecting
which attributes to reset.

For example a syscall with SCHED_FLAG_RESET_ON_FORK_SEL combined with
SCHED_FLAG_UCLAMP_MIN/MAX will only reset those. This should make it extensible
if we have other similar use cases in the future. The downside it *might*
require to be done in a separate syscall to the one that sets these parameter.
But it should be done once.

Maybe there's a better interface, but I think it makes sense to do it in a way
that we won't have to do this again. Would be good to hear from maintainers
first before you take my word for it ;-)


Cheers

--
Qais Yousef

>  
>  #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
>  			 SCHED_FLAG_RECLAIM		| \
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0d18c3969f90..f2d5f7911855 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1943,6 +1943,10 @@ static void __setscheduler_uclamp(struct task_struct *p,
>  		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
>  			      attr->sched_util_max, true);
>  	}
> +
> +	p->sched_reset_uclamp_on_fork = !!(attr->sched_flags &
> +				     SCHED_FLAG_RESET_UCLAMP_ON_FORK);
> +
>  }
>  
>  static void uclamp_fork(struct task_struct *p)
> @@ -1956,7 +1960,7 @@ static void uclamp_fork(struct task_struct *p)
>  	for_each_clamp_id(clamp_id)
>  		p->uclamp[clamp_id].active = false;
>  
> -	if (likely(!p->sched_reset_on_fork))
> +	if (likely(!p->sched_reset_on_fork && !p->sched_reset_uclamp_on_fork))
>  		return;
>  
>  	for_each_clamp_id(clamp_id) {
> diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
> index 3bac0a8ceab2..d52c59a2e0d0 100644
> --- a/tools/include/uapi/linux/sched.h
> +++ b/tools/include/uapi/linux/sched.h
> @@ -132,12 +132,14 @@ struct clone_args {
>  #define SCHED_FLAG_KEEP_PARAMS		0x10
>  #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
>  #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
> +#define SCHED_FLAG_RESET_UCLAMP_ON_FORK 0x80
>  
>  #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
>  				 SCHED_FLAG_KEEP_PARAMS)
>  
>  #define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
> -				 SCHED_FLAG_UTIL_CLAMP_MAX)
> +				 SCHED_FLAG_UTIL_CLAMP_MAX | \
> +				 SCHED_FLAG_RESET_UCLAMP_ON_FORK)
>  
>  #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
>  			 SCHED_FLAG_RECLAIM		| \
> -- 
> 2.40.0.634.g4ca3ef3211-goog
> 
