Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375EE5FBA04
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiJKSBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJKSBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:01:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A01D66A55
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:01:09 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e717329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e717:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 98E0F1EC058A;
        Tue, 11 Oct 2022 20:01:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665511263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HZS9EJvQC7rg+a+Dg8MMaINTPkLRymTnxYCRJJMt6iU=;
        b=Nvc/2GAWwla6FW2VdLZBz133Dad+XTT47gWCAehWBdSlki+9R1gd8SV9IC8uPtlPbu77gl
        4qanZUPHn/cTC5D0rLsTkUQ+Pu1QVKwybJM96EKwzsUDy7aLdedOaoDIBCykjfkcjFCjNg
        1QpgbWLFYQrX+S7ZT0SExPmUPjBU6oI=
Date:   Tue, 11 Oct 2022 20:01:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH] x86: Fix /proc/cpuinfo cpumask warning
Message-ID: <Y0WvX9Mp0kuohNdq@zn.tnic>
References: <20221011175031.1782748-1-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221011175031.1782748-1-ajones@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 07:50:31PM +0200, Andrew Jones wrote:
> Upcoming cpumask changes will start issuing warnings[*] when cpu

What upcoming changes?

This needs a concrete pointer to a commit or so.

> indices equal to nr_cpu_ids are passed to cpumask_next* functions.

How do those indices get passed here? I think you need to explain how
exactly this happens.

> Ensure we don't generate a warning when reading /proc/cpuinfo by

Please use passive voice in your commit message: no "we" or "I", etc,
and describe your changes in imperative mood.

> validating the cpu index before calling cpumask_next().

s/cpu/CPU/g

> [*] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.
> 
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Cc: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/x86/kernel/cpu/proc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
> index 099b6f0d96bd..584ae6cb5b87 100644
> --- a/arch/x86/kernel/cpu/proc.c
> +++ b/arch/x86/kernel/cpu/proc.c
> @@ -153,9 +153,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  
>  static void *c_start(struct seq_file *m, loff_t *pos)
>  {
> -	*pos = cpumask_next(*pos - 1, cpu_online_mask);
> -	if ((*pos) < nr_cpu_ids)
> -		return &cpu_data(*pos);
> +	if (*pos < nr_cpu_ids) {
> +		*pos = cpumask_next(*pos - 1, cpu_online_mask);
> +		if (*pos < nr_cpu_ids)
> +			return &cpu_data(*pos);
> +	}

Simpler: on function entry:

	if (*pos >= nr_cpu_ids)
		return NULL;

	 /* the rest remains unchanged */

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
