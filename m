Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3A268D1B8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 09:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjBGIte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 03:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjBGItc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:49:32 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F9A2118
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 00:49:31 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id jg8so1663985ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 00:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHOlXYzwEYd1vytSqnuF84M6GLa2GjB5pfViGaoRHZg=;
        b=QtT6nNTiyGFUbk0kbvw5UB3sOj0C1589s6RqmlzxhGmVmfaTFXxDnIT0yydInmWySj
         Finzt+1YAtD6N+jpS6EYdkMlH1I9IdXAgCPeh9dkDSys4UXO45UV6ucEamyrmAqzQ1ul
         DefoU2fSw9WScNsAHaRaO/nXqg9yqTXgA0m9a953KpzAT+w+YPCV+OBd01u7qFKtRTmM
         svjDq8mF+n9FYil5YphXq/XcDmC0uZHT/gUPhs4F45W89k6wsITsg3Qim2Z7qOMfDzdq
         q65GhD57rVQAzmbrZceIW/OmDEaUympg/PiAq7VoIQkHC1I0FCAsZwMu8pBXuYgE8A2n
         5Jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHOlXYzwEYd1vytSqnuF84M6GLa2GjB5pfViGaoRHZg=;
        b=m4fEuBE9GDlQy2GnSkrGgNQ73rlCkt6VnFrjWxzW/zbFve6Y2QcioIm3Hwi72ZpwyC
         TPb/KL1IP4tk58mTISUUIXi5KPjgV1hwxfKTGfMqRA+X2tX3JxF1BrisBI/RcPS8m4ST
         WHEnIstVredbI4xUkRGKtqcYS5XR9/4ZONFgD++nWzXmuGutmjZCGDSuesLK6zV9Q+XZ
         mga/fn3lj8vlTci1Q2oAomKCsWxiV4VqWG2GbRw17d9i0FQ6UyHZhTUoxAyWbLkxOTiz
         k/EMCFifILLy4z2xTIe/mX2zSUf1XBZyjnoorTFcFzvUGeXVwF0STpfaMvMWE0NMqrdF
         RkzA==
X-Gm-Message-State: AO0yUKVnSdc40afF1ylzlDVf7j12uOg74wm9K7ddrXQVQvcU6oLjaj69
        XQy05mCqLXalewFwxzwGYVw=
X-Google-Smtp-Source: AK7set8d2IceX7XZnrRuhBG8VLpUV6o9jLH8VTa4KLtt82FWtuGeAVxu3kkVLBDyR2OMp7Q2dRe7bw==
X-Received: by 2002:a17:906:8557:b0:8a4:7806:6eed with SMTP id h23-20020a170906855700b008a478066eedmr2563002ejy.63.1675759770334;
        Tue, 07 Feb 2023 00:49:30 -0800 (PST)
Received: from gmail.com (1F2EF0FB.nat.pool.telekom.hu. [31.46.240.251])
        by smtp.gmail.com with ESMTPSA id ot17-20020a170906ccd100b0088272bac7c5sm6530259ejb.121.2023.02.07.00.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 00:49:29 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 7 Feb 2023 09:49:24 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/6] x86/pat: check for MTRRs enabled in memtype_reserve()
Message-ID: <Y+IQlJI33snDiLT1@gmail.com>
References: <20230207072902.5528-1-jgross@suse.com>
 <20230207072902.5528-3-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207072902.5528-3-jgross@suse.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Juergen Gross <jgross@suse.com> wrote:

> Today memtype_reserve() bails out early if pat_enabled() returns false.
> The same can be done in case MTRRs aren't enabled.
> 
> This will reinstate the behavior of memtype_reserve() before commit
> 72cbc8f04fe2 ("x86/PAT: Have pat_enabled() properly reflect state when
> running on Xen"). There have been reports about that commit breaking
> SEV-SNP guests under Hyper-V, which was tried to be resolved by commit
> 90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type() for MTRR disabled case"),
> but that again resulted in problems with Xen PV guests.
> 
> Fixes: 72cbc8f04fe2 ("x86/PAT: Have pat_enabled() properly reflect state when running on Xen")
> Fixes: 90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type() for MTRR disabled case")
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/mm/pat/memtype.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> index fb4b1b5e0dea..18f612b43763 100644
> --- a/arch/x86/mm/pat/memtype.c
> +++ b/arch/x86/mm/pat/memtype.c
> @@ -557,8 +557,12 @@ int memtype_reserve(u64 start, u64 end, enum page_cache_mode req_type,
>  		return -EINVAL;
>  	}
>  
> -	if (!pat_enabled()) {
> -		/* This is identical to page table setting without PAT */
> +	/*
> +	 * PAT disabled or MTRRs disabled don't require any memory type
> +	 * tracking or type adjustments, as there can't be any conflicts
> +	 * between PAT and MTRRs with at least one of both being disabled.
> +	 */
> +	if (!pat_enabled() || !mtrr_enabled()) {
>  		if (new_type)
>  			*new_type = req_type;

Doesn't memtype_reserve() also check for overlapping ranges & type 
compatibility in memtype_check_conflict(), etc., which can occur even in a 
pure PAT setup? Ie. are we 100% sure that in the !MTRR case it would be a 
NOP?

But even if it's a functional NOP as you claim, we'd still be better off if 
the memtype tree was still intact - instead of just turning off the API.

Also, speling nit:

   s/one of both
    /one or both

Thanks,

	Ingo
