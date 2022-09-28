Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE965EE812
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbiI1VOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbiI1VNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:13:16 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E040DE7C1F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:07:53 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id b75so13570637pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=3wPW0+piPk2ft9dooMQAz6w02q2w62WYhl87gRVkcTk=;
        b=tFiYW+OO4Yhq8CWdSEEMserzAGfUiLRpFoMuZe4H2LGXXlSfchoSBIXEMNt9ZHpXTR
         djRYatUXy47bNPz2w2FLoS70Hn8RJHJlNw6a8w5720BeBoCn2qmw/p4leFZHYZQqYRDl
         7hJHU/XgNhDu4v0dXEmqEGn7dNckdljIFsI6t3iVJrKs7DzGOntJ+QzPU9xG2rjjNZNz
         myNl6WwWJa2OXJc1c+79dOSzL5NCrZ0QdVw2t4IJ6zA4Dpf68zz0XQwoorfxw2yWaxCH
         7h4pNAf0H2tICxFSF7O9cG+inyqo7PDHGdq8wpfhtLjmrQ1Tpo2fReyQ2uxdfr+adoIf
         iJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=3wPW0+piPk2ft9dooMQAz6w02q2w62WYhl87gRVkcTk=;
        b=wKnxlRQcCi4DTgBl+leiDeLkPn6yU/p9b5oRNYdiWrWML/2trKaDcepafmz0PID25J
         LPHlrdgz0GgIbhWyBD4s+wH5YTuvwp8V71gXgkfeGa5Kz48CjhjOtj38zbCD6HiDoqTt
         rMoHqqvMZbW0ApWyeGj8kilpb0InmLsHp9q98KRHIb9jHf7sKZm12w+x/GNGrhv1cGYL
         JmDVgvsr2gTBWuehsqk7PlkkoRejh7RUpkulkaC/MTEx8al11dS1mm05TodOjz0TvpEA
         kKcr1nUhfgRfxfluBHO6SVZeI9wp0RuFogEnic7yGbedxDqT+5l1T3biswIDKd+AhK3x
         AqnQ==
X-Gm-Message-State: ACrzQf0UKliGHqqk5kSPPrt9ea7R3+/k43Cf0WbpdDfthYBYSu0VA055
        gyu3tZeufYmRhcwkyYooN71EMQ0+9r+Y+g==
X-Google-Smtp-Source: AMsMyM7LMkw20qPvTa56SDUcXFflMvnX8Lei8QyhuQ6kpz2mcN0LXeikDdVmf37JfFyB3Dar3TZsRQ==
X-Received: by 2002:a63:85c3:0:b0:43a:4c05:c313 with SMTP id u186-20020a6385c3000000b0043a4c05c313mr31375133pgd.418.1664399181658;
        Wed, 28 Sep 2022 14:06:21 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id mp3-20020a17090b190300b00200558540a3sm1983196pjb.53.2022.09.28.14.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 14:06:21 -0700 (PDT)
Date:   Wed, 28 Sep 2022 21:06:17 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, avagin@gmail.com
Subject: Re: [PATCH v2 4/4] x86/fpu: Correct the legacy state offset and size
 information
Message-ID: <YzS3SXVxJOrC/k5X@google.com>
References: <20220922200034.23759-1-chang.seok.bae@intel.com>
 <20220922200034.23759-5-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922200034.23759-5-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022, Chang S. Bae wrote:
> MXCSR is architecturally part of the SSE state. But, the kernel code
> presumes it as part of the FP component. Adjust the offset and size for
> these legacy states.
> 
> Notably, each legacy component area is not contiguous, unlike extended
> components. Add a warning message when these offset and size are
> referenced.
> 
> Fixes: ac73b27aea4e ("x86/fpu/xstate: Fix xstate_offsets, xstate_sizes for non-extended xstates")
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/x86/kernel/fpu/xstate.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index a3f7045d1f8e..ac2ec5d6e7e4 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -143,8 +143,13 @@ static unsigned int xfeature_get_offset(u64 xcomp_bv, int xfeature)
>  	 * offsets.
>  	 */
>  	if (!cpu_feature_enabled(X86_FEATURE_XCOMPACTED) ||
> -	    xfeature <= XFEATURE_SSE)
> +	    xfeature <= XFEATURE_SSE) {
> +		if (xfeature <= XFEATURE_SSE)
> +			pr_warn("The legacy state (%d) is discontiguously located.\n",
> +				xfeature);

pr_warn() here isn't warranted.  copy_uabi_to_xstate() calls this with non-extended
features, which is perfectly fine since it manually handles MXCSR.  And that helper
is directly reachable by userspace, i.e. userspace can spam the pr_warn().
