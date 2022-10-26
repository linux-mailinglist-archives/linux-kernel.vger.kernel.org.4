Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E192D60DDFD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 11:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbiJZJZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 05:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbiJZJYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 05:24:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7862D3FD63
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 02:24:48 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7b8329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7b8:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 381161EC064E;
        Wed, 26 Oct 2022 11:24:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666776287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uZok860yPzg2HSkFXYHJ/wRjPzyzd3KTktgEJeYsqRY=;
        b=EW8aND/2FfWr5evU4I55E/F43rrzXt4ayM8e3QikewJgE+LdWkOl7U8OR0DAjpUxWLG7g5
        p/gGBQm+7VT4yTIgH0dolQQlu94/TbEFHxQ42fgPrQBXDVGcXlmCxNlmhcah12hU+YoAdM
        TDn/t9Q8rOCZqFEHuEWAA85aIUqLiSw=
Date:   Wed, 26 Oct 2022 11:24:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 05/16] x86/mtrr: split MTRR specific handling from
 cache dis/enabling
Message-ID: <Y1j82TJGmSjhEhCD@zn.tnic>
References: <20221004081023.32402-1-jgross@suse.com>
 <20221004081023.32402-6-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221004081023.32402-6-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 10:10:12AM +0200, Juergen Gross wrote:
> @@ -764,11 +779,8 @@ void cache_disable(void) __acquires(cache_disable_lock)
>  	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
>  	flush_tlb_local();
>  
> -	/* Save MTRR state */
> -	rdmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
> -
> -	/* Disable MTRRs, and set the default type to uncached */
> -	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo & ~0xcff, deftype_hi);
> +	if (boot_cpu_has(X86_FEATURE_MTRR))

check_for_deprecated_apis: Warning: arch/x86/kernel/cpu/mtrr/generic.c:782: Do not use boot_cpu_has() - use cpu_feature_enabled() instead.

> +		mtrr_disable();
>  
>  	/* Again, only flush caches if we have to. */
>  	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
> @@ -781,8 +793,8 @@ void cache_enable(void) __releases(cache_disable_lock)
>  	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
>  	flush_tlb_local();
>  
> -	/* Intel (P6) standard MTRRs */
> -	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
> +	if (boot_cpu_has(X86_FEATURE_MTRR))

Ditto.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
