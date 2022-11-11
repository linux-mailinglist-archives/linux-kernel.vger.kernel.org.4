Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD91C62524E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiKKEPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiKKEO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:14:59 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8F267131;
        Thu, 10 Nov 2022 20:14:58 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id h132so3954827oif.2;
        Thu, 10 Nov 2022 20:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p63dJQ8Zm1StkFJbBaYMAZgNwK/eOyFjpsy+2OYCi50=;
        b=h/qWkjLSgEyAJah89p+vgT6NQynzFunXIArGdkU0XeiYzi1H7rata405JYf6ClTI+B
         nmghiawtYZByjpqJy3mM7BNM5xVCvDvD5aX1mxU+IWUlbo6ovG939oMH3O/RCnrgOzYq
         2QGCfjxFTIkAlEppGbWQT936ooO6lf40KQHJMYPtn8VDLjFE7CKiXIFtP5ZrWi9mk4EY
         KA8kXg2gft8P/4vOssapiwPL32B4PF4uMXNw1CynoglzQ5aWS/o0ktEjr8oaGjh68qhq
         rstLTea6xPTAvAc8MODPL87vCtskFz/lJ3xavFe4O5bh/34Ujm4155uJhRhYk67NwVNS
         8mYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p63dJQ8Zm1StkFJbBaYMAZgNwK/eOyFjpsy+2OYCi50=;
        b=6AY/9KTH+5ZAPNgfdEuVW/yceHqc2JYLTUahRRDX/p4FsJ9cZgjQOtWbE/yqGd5nYM
         aw08GLFomIpxXFTquKBS5IAnuoHSPvscbbEBhTMUyv/EXqHBM9cdeBkdNdMfCcI6cNnV
         zCpnkenxzwG7/hJq6Zpi2pAkt74Srzsgaw1Rcje1kwsgFLY0WIWJFKijGpZEQL4mMNOm
         UVXmGzlwLN5Kpb7NxBrMKNJjVF9fNEZeXngsHPmjX0iNg6+/naXOBylHXw1ZfVfo4/jQ
         yJra6YbC5eVxwe++K9uqeZPBFV7rRRL9CJ2iXSedOlxl/9g9CJVK2n9/pXqumapf5Zde
         qvOA==
X-Gm-Message-State: ACrzQf1gvqe3KNOdqeJj6in/IaM6giCHqrYrnMNb3+5sjPiGjO28wYlj
        Jd1MFQlpCvU0PQLmH7RXoKs=
X-Google-Smtp-Source: AMsMyM7b8tbRaQRGbmuhAG9mhyQNZp61zj9zEvl1eF7QlhtBjlOwONQncQLSFtFBszzuP5wzulbUHw==
X-Received: by 2002:a05:6808:151e:b0:35a:7300:7208 with SMTP id u30-20020a056808151e00b0035a73007208mr2438895oiw.75.1668140097551;
        Thu, 10 Nov 2022 20:14:57 -0800 (PST)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id v4-20020a9d6044000000b00661a05691fasm562487otj.79.2022.11.10.20.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 20:14:57 -0800 (PST)
Date:   Thu, 10 Nov 2022 20:14:56 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     x86@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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
Subject: Re: [PATCH v4 1/1] x86: cpuinfo: Ensure inputs to cpumask_next are
 valid
Message-ID: <Y23MQA8ZaQ135aJV@yury-laptop>
References: <20221103142504.278543-1-ajones@ventanamicro.com>
 <20221103142504.278543-2-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103142504.278543-2-ajones@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 03:25:04PM +0100, Andrew Jones wrote:
> The valid cpumask range is [0, nr_cpu_ids) and cpumask_next()
> currently calls find_next_bit() with its input CPU ID number plus one
> for the bit number, giving cpumask_next() the range [-1, nr_cpu_ids - 1).
> seq_read_iter() and cpuinfo's start and next seq operations implement a
> pattern like
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
> which will eventually result in cpumask_next() being called with
> nr_cpu_ids - 1. A kernel compiled with commit 78e5a3399421 ("cpumask:
> fix checking valid cpu range"), but not its revert, commit
> 80493877d7d0 ("Revert "cpumask: fix checking valid cpu range"."),
> will generate a warning when DEBUG_PER_CPU_MAPS is enabled each time
> /proc/cpuinfo is read. Future-proof cpuinfo by checking its input to
> cpumask_next() is valid.
> 
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Cc: Yury Norov <yury.norov@gmail.com>

Reviewed-by: Yury Norov <yury.norov@gmail.com>

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
