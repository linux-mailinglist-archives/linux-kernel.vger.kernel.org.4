Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D39C642D7C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiLEQsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbiLEQrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:47:48 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6921C1ADB8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:46:43 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id a14so7897109pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 08:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wBuKcoM+BgmLWxWnn53uMMW9saBlJ8h0l5lioV+cxtw=;
        b=Yp/LshZjsu5TY0+uEvPakxJqPBNW2xM8WfoaH2AN1/LuHVAa08gwyLQZzwHQYU7pp9
         xaDAYlbhc1LHIJUSvT8Ipf1HLNYMZ+AAWtss21LwMl5y2RZR/QhpYncpNEQiGWoL/JSt
         1IDg90fFHi0yENcoH2Oa/BhGz98n16svoHFxifSrnZEHHYFmr7sAL87gD9maRFNG4wPN
         w1ZKk5fLVw2Bs/16xWl05TfqhVy00n0e1yEhEb87Qs+J5AMCDAra/Vrhq1n3RVj8T9On
         XG2kS6/njA1UQC1cB8vbcukLWgPRohnQO37Bf2UtQoFgNaVmLCghXjpoDHblaoVlPmY8
         5Mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBuKcoM+BgmLWxWnn53uMMW9saBlJ8h0l5lioV+cxtw=;
        b=jPTQRQaWwR6G6HlKVOKoRRHHOK5Cmss8u/r48r788YksjPoXcjEQeBuAJe8pA5Mzmh
         2vqGCVS3pnFNeh5uVncnCT0opoX5ADof+/mdMP5i3YGflnXk/nT+kxbsxk24CAFLaytu
         ktMXL8vXt9uOf0aq7nKJsQmZGlHqFzPX079nMYtvKFZQHRC9H84UXHUimwZVokHycmj2
         HwuHeccPGZ838Ay97yb0e2nYqolq+JFGp8f97KOoF7sz6YK3qLi5INmkFr8V5yLbe+rU
         rCTGTilhU8qviJxYeu746ZXa+YQ2xps8YQ+Q12KwrsJKOAO62mligvPei/zfq9E/hqtP
         ljfQ==
X-Gm-Message-State: ANoB5plU/hGsW3p4QCYVtKI2ra3rXp6PUB+C48utkN8xtWjxpyTkXZlc
        oG9mAG7uQZS+B9iYl3/nLs9EOA==
X-Google-Smtp-Source: AA0mqf6CnDwQTRQD+uHAbFBNUibmPgylkuPyyI+2Cg6c4HOTfO1L02ctVvTP2Te/WB/b/vXzpsZGpw==
X-Received: by 2002:a63:ec45:0:b0:470:4320:ef39 with SMTP id r5-20020a63ec45000000b004704320ef39mr56788543pgj.381.1670258802815;
        Mon, 05 Dec 2022 08:46:42 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902dc8300b00189a50d2a3esm10749267pld.241.2022.12.05.08.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 08:46:42 -0800 (PST)
Date:   Mon, 5 Dec 2022 16:46:38 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86/pmu: Avoid ternary operator by directly
 referring to counters->type
Message-ID: <Y44gbvm5Zb7a1Sbj@google.com>
References: <20221205113718.1487-1-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205113718.1487-1-likexu@tencent.com>
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

On Mon, Dec 05, 2022, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> In either case, the counters will point to fixed or gp pmc array, and
> taking advantage of the C pointer, it's reasonable to use an almost known
> mem load operation directly without disturbing the branch predictor.

The compiler is extremely unlikely to generate a branch for this, e.g. gcc-12 uses
setne and clang-14 shifts "fixed" by 30.  FWIW, clang is also clever enough to
use a cmov to load the address of counters, i.e. the happy path will have no taken
branches for either type of counter.

> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index e5cec07ca8d9..28b0a784f6e9 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -142,7 +142,7 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
>  	}
>  	if (idx >= num_counters)
>  		return NULL;
> -	*mask &= pmu->counter_bitmask[fixed ? KVM_PMC_FIXED : KVM_PMC_GP];
> +	*mask &= pmu->counter_bitmask[counters->type];

In terms of readability, I have a slight preference for the current code as I
don't have to look at counters->type to understand its possible values.
