Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AF867A7FF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 01:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjAYAvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 19:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAYAvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 19:51:38 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878333FF09
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:51:36 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id o13so16911903pjg.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AFMllcKPaOUgFGlC7PFrFPAm3GcrxbOJzGs8ZXDeXvU=;
        b=BkoOwFh/U9jEHG6Na327/oV/3WzYMncCvqX8rhcP5yQKCT2pOr0qCaI0FRHHLDT7zg
         lK7zZ23XY8cTkonvctJEfQrKQKwO8FgQs9FGFZGByZhvOMMOGlNiKTdeIlZRKx4RbVeo
         XZOf2qeMoovWM3frYC+GBhNGAMMRr8LVCEOybQxWnhXJVsIB4aPlaE4OAmyHEyJ8jPoK
         jGdIzL89myFa0PlIgaoIKiL23WLwOHzjICk93V+2vx14taGPkQ44G6Y2qEGJvjVzwhlE
         mOWdEs7mM4NpcISfBeSdIFX9PdzbHkYOgwB1a85t4mceRnmI3TCyKnnYRcuaBs5QXjqH
         9PFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFMllcKPaOUgFGlC7PFrFPAm3GcrxbOJzGs8ZXDeXvU=;
        b=51PNQnLANx4koK5Zd7G0UEOLd9pu5VAjD/vPxRkzosG2JYQNTiD6JRbgP0AV/HHEYr
         UQz2EBbZ3Vji2kmvTH3UlQ776TlorODWcq7WJkm9Oz1YCG5EC1HItkwNf8sH6OEcZjo+
         +mBEC2xVKVOoQPeFGYD7i7FR6ac/LRkUilT7nwHiRPFATCrkGIdc4+6LO0ZotCHztPjE
         bKQNRXLN4l+gmL6i3x5pOZEhjvTqUL0I2uBcqGluBzDUuKKzCLW1NQnVtxdzW5ehnOxa
         wWhU1/xzQK4q/ByL5vial8kjJjEXZQvJiht2OK7klAaWUSBqlTYMjF/kooD9Znl8jyoU
         5LbQ==
X-Gm-Message-State: AO0yUKXYOXqgEm8/QoUH3C3olb6oSBNjJIK0QfnhBgycEIZVzApKjfE0
        0yyuW9erGy12ImL8hXGvQ3lhGE6pd3PSypLbq10=
X-Google-Smtp-Source: AK7set/pxaQt8SOHI6NCbetKZIMirhstC36lViuRC9iTeQQsZ1pF4nTwnBNk0FnJxGremT5vsgPhww==
X-Received: by 2002:a05:6a20:c759:b0:9d:c38f:9bdd with SMTP id hj25-20020a056a20c75900b0009dc38f9bddmr453885pzb.2.1674607895862;
        Tue, 24 Jan 2023 16:51:35 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79211000000b00575b6d7c458sm2215684pfo.21.2023.01.24.16.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 16:51:35 -0800 (PST)
Date:   Wed, 25 Jan 2023 00:51:31 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     John Allen <john.allen@amd.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, weijiang.yang@intel.com,
        rick.p.edgecombe@intel.com, x86@kernel.org, thomas.lendacky@amd.com
Subject: Re: [RFC PATCH 7/7] KVM: SVM: Add CET features to supported_xss
Message-ID: <Y9B9Ey1hK9A7NDVb@google.com>
References: <20221012203910.204793-1-john.allen@amd.com>
 <20221012203910.204793-8-john.allen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012203910.204793-8-john.allen@amd.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022, John Allen wrote:
> If the CPU supports CET, add CET XSAVES feature bits to the
> supported_xss mask.
> 
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>  arch/x86/kvm/svm/svm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index b474c7e57139..b815865ad0fb 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5026,6 +5026,11 @@ static __init void svm_set_cpu_caps(void)
>  	    boot_cpu_has(X86_FEATURE_AMD_SSBD))
>  		kvm_cpu_cap_set(X86_FEATURE_VIRT_SSBD);
>  
> +	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK)) {

No need for curly braces.

> +		kvm_caps.supported_xss |= XFEATURE_MASK_CET_USER |
> +					  XFEATURE_MASK_CET_KERNEL;
> +	}
> +
>  	/* AMD PMU PERFCTR_CORE CPUID */
>  	if (enable_pmu && boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
>  		kvm_cpu_cap_set(X86_FEATURE_PERFCTR_CORE);
> -- 
> 2.34.3
> 
