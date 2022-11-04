Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3614E619EE2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiKDRgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiKDRgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E4432065
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667583337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RMvES9h1ylliLgVwkULg2x1BbxHd2t6jSiU8MP78/C0=;
        b=dDzsWagkYU7XjvfYZ6dfYWp7wcbrA39OujbcTC1XWCYuk86FTVQfe6LEcxrQkmh3JbP5ep
        A74icsQreZLmoK6gwYxx30y8wcILKcXUNMqqt7Vus4ohWX+e1uN5F5SuPpCFgtbs8+WHeW
        OgDtte5EBsyyK8l8ednY295neG/3lqM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-157-nm78KVCrOyS0uAabwPOYTg-1; Fri, 04 Nov 2022 13:35:36 -0400
X-MC-Unique: nm78KVCrOyS0uAabwPOYTg-1
Received: by mail-wm1-f71.google.com with SMTP id f62-20020a1c3841000000b003cf6d9aacbbso2602992wma.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 10:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMvES9h1ylliLgVwkULg2x1BbxHd2t6jSiU8MP78/C0=;
        b=o35icfPO9lZ7o0p5EJVoBaK+bxY0HDOU4ZEqDcC9ARkVlt7WCTIPFtv7zIfluNx9Mv
         imI/Qiw13UZyJbKpfc+uBcpu7prdr/Ucr3VoYEYIjAABhyN0T0P5dcdLGYQNfNADp1K4
         RkHICM+88RjuGlB8yV3xf/tUfToZ9hyurMytcVTWa9+Ewwg1ovMQyB3f4UmwiFqZhOUN
         VGZuSurMAumxrJU5eIYu76xsaMlGm+rZd47j8UICLhU56pj/Extrfi3p1jMkYc9g22NW
         +6yuqbJYnB4XLPqmGUzrKeX9hkkLJy0+tR2LNeHm4+rC4PxeU+6IfUxhTA/VgNTwH+QX
         CiWA==
X-Gm-Message-State: ANoB5pmVQyV5WjCGQei4/tZWyRGVLTYFvZvoOoPhIiSaxDzCi8q3zuq2
        J5cNO3DuVb15lADDyq+SCcHbqoK75GPRESDtpQNx6LXwzJhMgvHLywJTbvQPE+UvnUJ7FxHMA9F
        7tF0OMdFGSOEatR0nbo1AOTOS
X-Received: by 2002:a5d:6909:0:b0:23a:fbdc:3791 with SMTP id t9-20020a5d6909000000b0023afbdc3791mr2636246wru.60.1667583335230;
        Fri, 04 Nov 2022 10:35:35 -0700 (PDT)
X-Google-Smtp-Source: AA0mqf4CzGXioEIvxr+Xi/WxdH8Z8k3XMB2/Pbpm36vQqoqEhQoBiw1wgEp6+fBq5Y1SEoo+WfanBg==
X-Received: by 2002:a5d:6909:0:b0:23a:fbdc:3791 with SMTP id t9-20020a5d6909000000b0023afbdc3791mr2636233wru.60.1667583335045;
        Fri, 04 Nov 2022 10:35:35 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id c3-20020a5d5283000000b002206203ed3dsm3872851wrv.29.2022.11.04.10.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 10:35:34 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Qais Yousef <qais.yousef@arm.com>
Subject: Re: [PATCH v2 1/9] sched/uclamp: Fix relationship between uclamp
 and migration margin
In-Reply-To: <20220804143609.515789-2-qais.yousef@arm.com>
References: <20220804143609.515789-1-qais.yousef@arm.com>
 <20220804143609.515789-2-qais.yousef@arm.com>
Date:   Fri, 04 Nov 2022 17:35:33 +0000
Message-ID: <xhsmhy1sqvd0a.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I'm only seeing this now that it has hit tip/sched/core and I've had a
stroll through fair.c, apologies for this being late.

On 04/08/22 15:36, Qais Yousef wrote:
> +static inline int util_fits_cpu(unsigned long util,
> +				unsigned long uclamp_min,
> +				unsigned long uclamp_max,
> +				int cpu)
> +{
> +	unsigned long capacity_orig, capacity_orig_thermal;
> +	unsigned long capacity = capacity_of(cpu);
> +	bool fits, uclamp_max_fits;
> +
> +	/*
> +	 * Check if the real util fits without any uclamp boost/cap applied.
> +	 */
> +	fits = fits_capacity(util, capacity);
> +
> +	if (!uclamp_is_used())
> +		return fits;
> +
> +	/*
> +	 * We must use capacity_orig_of() for comparing against uclamp_min and
> +	 * uclamp_max. We only care about capacity pressure (by using
> +	 * capacity_of()) for comparing against the real util.
> +	 *
> +	 * If a task is boosted to 1024 for example, we don't want a tiny
> +	 * pressure to skew the check whether it fits a CPU or not.
> +	 *
> +	 * Similarly if a task is capped to capacity_orig_of(little_cpu), it
> +	 * should fit a little cpu even if there's some pressure.
> +	 *
> +	 * Only exception is for thermal pressure since it has a direct impact
> +	 * on available OPP of the system.
> +	 *
> +	 * We honour it for uclamp_min only as a drop in performance level
> +	 * could result in not getting the requested minimum performance level.
> +	 *

Why specifically care about OPPs here? Per our CPU capacity model, a task
alone on a CPUx throttled to f=fmax/2 and a task coscheduled on a CPUy with
RT/DL tasks and/or IRQs such that cpu_capacity(CPUy) = 50% are both getting
(roughly) the same performance level.

