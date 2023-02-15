Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E34697EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 15:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjBOO7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 09:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjBOO7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:59:36 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E67535A8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 06:59:35 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id o20so27970061lfk.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 06:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=opxKWn/3ZRZhHQW457nWgKER1yUNZeQOCSRNriqCARc=;
        b=PVbxH6CZW65pg8CssyGrSSFxPQK2Ir1CeGtsfAFBQpgCtkRrn9Cz2s02mJZq/JUQ7V
         LQGdXnViZee7L4UZEqMyoqtsiTOGLPIWS5DkUlNDo1nuaM+WUT0eKB7TcofqJfCBHeGj
         l+7KVVosXPuuzYDTuIO1kjb+GKTXJIFyN/nx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opxKWn/3ZRZhHQW457nWgKER1yUNZeQOCSRNriqCARc=;
        b=R0knEuJZzbENeA01cfFhxQm2W4XL17nE1oUEvJQhLvTWSPOGjSenTmYYqXd75TeLO3
         0N+0CzOUXQRqxNBa8mjYN1+v093aLK9JPO/YG89cBLtm5VHym6jABvFabGZ57MuS3hFA
         tA0Or38oOmJlCbj/ehI5fZftS19/yobd3mBfhBDlgbWYZ6qa6qdnbEhz/UQnS0cDAecC
         Y0ZJWPAQwFJKH3fECK9pE+C+6vEqJev1g0C3NXsULOx+eG95GnDGCC+CPsXb3xoaXdb/
         P9P22lCha/8mj0jRM/etFs9hi70ScbwzsLSDRBMH6X99ep5e2mnAKzT9RFpg5CfQVQ/7
         4mwQ==
X-Gm-Message-State: AO0yUKUh4lg2fxcFLhBlHr1xAgWFOyxPvLdmt61t2jm72xmu0cIA2oQ2
        Y6DRZ+clpJQ8ged/XU3vTKXhp5qMIJnYKqwt6teqMw==
X-Google-Smtp-Source: AK7set/TNpsgs9uIkss6ZBBh1xOuxN2AyeKBnaAtLWhKN7hRxuD5dT4kYFtvk88wBjijPv57kMW/m6klJIpuIaf8kfg=
X-Received: by 2002:ac2:59cf:0:b0:4d5:ca32:9bdf with SMTP id
 x15-20020ac259cf000000b004d5ca329bdfmr617970lfn.11.1676473173450; Wed, 15 Feb
 2023 06:59:33 -0800 (PST)
MIME-Version: 1.0
References: <20230210000021.1007853-1-qiang1.zhang@intel.com>
In-Reply-To: <20230210000021.1007853-1-qiang1.zhang@intel.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 15 Feb 2023 09:59:22 -0500
Message-ID: <CAEXW_YSdXWcM_WO8FNNAs_sy=d=dwd7Ox9Aayucu9hgJ9BLhHQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/isolation: Fix illegal CPU value by
 housekeeping_any_cpu() return
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 9, 2023 at 6:55 PM Zqiang <qiang1.zhang@intel.com> wrote:
>
> For kernels built with CONFIG_NO_HZ_FULL=y, running the following tests:
>
[...]
> This commit therefore add checks for cpumask_any_and() return values
> in housekeeping_any_cpu(), if cpumask_any_and() returns an illegal CPU
> value, the housekeeping_any_cpu() will return current CPU number.
>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/sched/isolation.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 373d42c707bc..534397ab7a36 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -46,7 +46,11 @@ int housekeeping_any_cpu(enum hk_type type)
>                         if (cpu < nr_cpu_ids)
>                                 return cpu;
>
> -                       return cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> +                       cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> +                       if (cpu >= nr_cpu_ids)
> +                               return smp_processor_id();
> +                       else
> +                               return cpu;

Nit: no need of "else", simply:

return (cpu >= nr_cpuids ? smp_processor_id() : cpu);

or

if (cpu >= nr_cpu_ids)
   return smp_processor_id();
return cpu;

Thanks.
