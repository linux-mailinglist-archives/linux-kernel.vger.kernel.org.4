Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D59675611
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjATNoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjATNoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:44:11 -0500
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4EF6CCF2;
        Fri, 20 Jan 2023 05:44:10 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id ss4so13992138ejb.11;
        Fri, 20 Jan 2023 05:44:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugActICuqABJPgs2DMA844zVQO+yJ6DzsC4UoZ9cvY0=;
        b=I1dRWk2jcx8D1Tl0BycBI0OLyx29efSHBWwdelliCYbzz50CfLJH77Yclgh2uWAZwq
         2MLs2+KC2oSG0elq5Wx6d8+YKOCSvJWXy+i97oWqCtEs9rTcehXaeW639ie4iIvBZ3ek
         FEcnYlcuqCKkh/GmVNAFHlDT9MlEH285HxwdQ8ZJPh2Toay8KXZeM7X0Z1L/3dhbQrNF
         y75iFlDZ1PYBmdN06GTr0A+QjocylHCmoDg91SWdgjfHmFE4c1Eer2GFLlEOqbmFgfgP
         SPJhnbnkW4/jq9dYDXaeqyFGbMrbANQfvHIyZAw8ETgI+GWj8hb9tpdDpoDLZL0HF/Fa
         nvHg==
X-Gm-Message-State: AFqh2kqCrRMx4HO+WARodcQGAuf7cu33Q6ePicKXNM2ljOVYpQQaH4t2
        TGsm2d9L1UTn3uyBNEGHqpbZKv/ay30SIv4LKVlfV6YF
X-Google-Smtp-Source: AMrXdXsvPmKcejSlnKj0fndRKkkmeosK6wyiVNiyt9QcuBvqv51+RPXD7R5SRfiM6F7cK2Oz2tjwpcEPsf99O1WAcfw=
X-Received: by 2002:a17:906:940c:b0:86f:d628:e184 with SMTP id
 q12-20020a170906940c00b0086fd628e184mr1810820ejx.96.1674222249153; Fri, 20
 Jan 2023 05:44:09 -0800 (PST)
MIME-Version: 1.0
References: <20221230075159.1482626-1-linmq006@gmail.com>
In-Reply-To: <20221230075159.1482626-1-linmq006@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Jan 2023 14:43:57 +0100
Message-ID: <CAJZ5v0iPMyQUibJk5S=ZdnsU43yBqyDAVCFkbmmwd_LVZjR=5w@mail.gmail.com>
Subject: Re: [PATCH] powercap/dtpm_cpu: Fix refcount leak in __dtpm_cpu_setup
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 8:52 AM Miaoqian Lin <linmq006@gmail.com> wrote:
>
> The policy return by cpufreq_cpu_get() should be released with
> cpufreq_cpu_put() to balance the reference counter.
> Add missing cpufreq_cpu_put() to fix this.
>
> Fixes: 0e8f68d7f048 ("powercap/drivers/dtpm: Add CPU energy model based support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/powercap/dtpm_cpu.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index 2ff7717530bf..3083c6b45c90 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -195,12 +195,16 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
>                 return 0;
>
>         pd = em_cpu_get(cpu);
> -       if (!pd || em_is_artificial(pd))
> -               return -EINVAL;
> +       if (!pd || em_is_artificial(pd)) {
> +               ret = -EINVAL;
> +               goto out_put_policy;
> +       }
>
>         dtpm_cpu = kzalloc(sizeof(*dtpm_cpu), GFP_KERNEL);
> -       if (!dtpm_cpu)
> -               return -ENOMEM;
> +       if (!dtpm_cpu) {
> +               ret = -ENOMEM;
> +               goto out_put_policy;
> +       }
>
>         dtpm_init(&dtpm_cpu->dtpm, &dtpm_ops);
>         dtpm_cpu->cpu = cpu;
> @@ -220,6 +224,8 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
>         if (ret)
>                 goto out_dtpm_unregister;

The part of the patch above is valid, but I don't think that the
policy reference counter can be dropped below, because that may allow
the policy to go away and this driver will be still using it, won't
it?

>
> +       cpufreq_cpu_put(policy);
> +
>         return 0;
>
>  out_dtpm_unregister:
> @@ -230,7 +236,8 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
>         for_each_cpu(cpu, policy->related_cpus)
>                 per_cpu(dtpm_per_cpu, cpu) = NULL;
>         kfree(dtpm_cpu);
> -
> +out_put_policy:
> +       cpufreq_cpu_put(policy);
>         return ret;
>  }
>
> --
> 2.25.1
>
