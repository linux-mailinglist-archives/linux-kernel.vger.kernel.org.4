Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD93610B86
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiJ1Hse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiJ1Hsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:48:32 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E311BE1CB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:48:31 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o4so5869120wrq.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U0U3J+Q69fu7o/YQz3q/fMO7g+tmuXGKvEK6KG9JDGA=;
        b=oqmNgqsztuMpLAhNQorP3820L6EJNnJRDoXEb4RgzXZQMfNQDcyVCHVYlvSTb+cksH
         CwJ2aeLsuRGbAg4oUeweMw9W7RVPie8fbQhXZCKgnIXewPhBCQ2D8qNqXYiXfhT76dW6
         xJX6KJ6QR8kf1VFJxGUsMl5/+ENJJ5Wxii90WkOuwZT7HNIb6lID8pp/UFcfXmak4LFL
         jTzzJYzhej1Kn237Slz8BJcwQbdSqVXWEQpinfJlNcbgrjQ4bsMdqNEumXt3CMYlYdSi
         LO4ALfufKLzxVKs824kdxmBew78rDuLIWHvjPbK+3tKTM3XpkrSx4Zr/NWhajts4BWCr
         /L7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0U3J+Q69fu7o/YQz3q/fMO7g+tmuXGKvEK6KG9JDGA=;
        b=MzeMooGRiT+BhorbiLSMInNZcSdEie1POxGmKUMnyBDohMKo10LqWHVOOiNXmJGZv7
         2dzRA0RDodTmFhL9aHvVd/l6pCTtwv5bPaIg6yiFRA6DfEAsEvSazZi0a13UfD/rdRYj
         meXHBl8o+Gf4WCMg1bwche7yxkBa7YPwXOpdzVfVi28XmoZJu8S0W6uhV+nHSpo5BtgH
         UGqeA3mhlr1Um7drMRavvkQlY70XK+BJHBKvLuLaqNpBE1h+SbNdat3aPkqHPEZ61gKc
         c/7J7N9lcrT5RUzwPlPWis/I5JnJiqTqtDOzUGEZAjdyCqUPymvMm0DRJckilsyKCplA
         LLuw==
X-Gm-Message-State: ACrzQf2+cwo535Xg2An/uALkvBTgQMPQYH8DR/kaelKBWUfl/IdrZKxx
        +qNwZcYka6EMvTd5HjXjqB6+9g==
X-Google-Smtp-Source: AMsMyM6VIrVFAYX3MFdpAr2A3aolwkCyi7gytgwNOdq5lcvzoSJ4ww9Dhq1bl3mK11pqR8Em7mdPlA==
X-Received: by 2002:adf:ef4e:0:b0:236:6608:f6ce with SMTP id c14-20020adfef4e000000b002366608f6cemr18585925wrp.85.1666943309562;
        Fri, 28 Oct 2022 00:48:29 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id h1-20020a5d4301000000b0022efc4322a9sm2989820wrq.10.2022.10.28.00.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 00:48:29 -0700 (PDT)
Date:   Fri, 28 Oct 2022 09:48:28 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     x86@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 2/2] x86: Fix /proc/cpuinfo cpumask warning
Message-ID: <20221028074828.b66uuqqfbrnjdtab@kamzik>
References: <20221014155845.1986223-1-ajones@ventanamicro.com>
 <20221014155845.1986223-3-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014155845.1986223-3-ajones@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 05:58:45PM +0200, Andrew Jones wrote:
> Commit 78e5a3399421 ("cpumask: fix checking valid cpu range") has
> started issuing warnings[*] when cpu indices equal to nr_cpu_ids - 1
> are passed to cpumask_next* functions. seq_read_iter() and cpuinfo's
> start and next seq operations implement a pattern like
> 
>   n = cpumask_next(n - 1, mask);
>   show(n);
>   while (1) {
>       ++n;
>       n = cpumask_next(n - 1, mask);
>       if (n >= nr_cpu_ids)
>           break;
>       show(n);
>   }
> 
> which will issue the warning when reading /proc/cpuinfo. Ensure no
> warning is generated by validating the cpu index before calling
> cpumask_next().
> 
> [*] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.
> 
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Cc: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/x86/kernel/cpu/proc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
> index 099b6f0d96bd..de3f93ac6e49 100644
> --- a/arch/x86/kernel/cpu/proc.c
> +++ b/arch/x86/kernel/cpu/proc.c
> @@ -153,6 +153,9 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  
>  static void *c_start(struct seq_file *m, loff_t *pos)
>  {
> +	if (*pos == nr_cpu_ids)
> +		return NULL;
> +
>  	*pos = cpumask_next(*pos - 1, cpu_online_mask);
>  	if ((*pos) < nr_cpu_ids)
>  		return &cpu_data(*pos);
> -- 
> 2.37.3
>

Hi x86 maintainers,

I realize 78e5a3399421 has now been reverted, so this fix is no longer
urgent. I don't believe it's wrong, though, so if it's still of interest,
then please consider this a friendly ping.

Thanks,
drew
