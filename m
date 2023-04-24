Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CF46DA69B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 02:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjDGAcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 20:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjDGAcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 20:32:09 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82E1618B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 17:32:07 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id h66-20020a628345000000b00625e0121e40so18029901pfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 17:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680827527;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gB6QWOYr52F6RzUn42cn9YO/xJt1ZAN7hiQOwDN28jE=;
        b=oHmnDkznLB2fqcJzNFTU5CRPcplPmHa+GIQvo6Orr7+wsQGd+s6vVf89WhNskorqqE
         lLQG19YX7xsC6cNJu3aGKA02F4zBlgkRLI2TlIGHkPxT2JSWGp+N1IQoSHYPCk3g3/ge
         Qe4fNqV+EpBohAuiAZ0cLezUCUrpsVfm6I/JEE/mOo/vwLU0kLmuMHEUHCbYAoZlUveK
         qTk8ykE0+1aYqB7uWwpNJ3odfc3TqWHhG9byQ+2Ubr8nfELrzum0C7Qnjm/IZ9MD5eT3
         xRm6ojDNp1UYi9lqluGOLwUN78Q+5I3ZmqwOXrQEiQ39Fq33KpwCTcb0OvfvRMsknJ8f
         5FRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680827527;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gB6QWOYr52F6RzUn42cn9YO/xJt1ZAN7hiQOwDN28jE=;
        b=ryTwmykG4j1guJFhW4n1PRzHh+gNSKeO9cjIy3NteF2biY3aY+gTeBFJrsoxyyDnis
         77rGu+rP6rKXNhIZD6qo4aICEVZMuWhw9Dn+mb5+S9DttLKZntb5awHRz02yiaLiWu6R
         0EYEi1a+/LxBffIL1Xjt4uK+ngQXTBlxB7ZwryS/pff3Gtb9enoa8oOdjPD6BPBgnCgN
         O/6cXgGNds0fZP5o3zEntrthRgXuVXJVlYTqCgvmlA58ZEu77Fsa+ZV6xjd8RkJquAm+
         D3htIpJDpyOtSk+R4Tl4pQQHSQJdVw4qD8N53vHVkjSXa3h861Aq2ba2KaodGbi0C66N
         LH4w==
X-Gm-Message-State: AAQBX9dnQ0oaikJbYmvDg6JElFS4pOYYJIDWFrVGvu2Ob0HK2nHqNpZ/
        4mNc2fhqcta6AbnAolHYDc71LYbMSAQ=
X-Google-Smtp-Source: AKy350ZKPl5uhVQylzilx1ijUrU5YeSnYp0rewZjeOU7OOLMz3vTuRUjjlrZudIWP/Bn4kGIuKKUvf/UyXA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:da8e:b0:1a5:144c:27df with SMTP id
 j14-20020a170902da8e00b001a5144c27dfmr107749plx.4.1680827527170; Thu, 06 Apr
 2023 17:32:07 -0700 (PDT)
Date:   Thu, 6 Apr 2023 17:32:05 -0700
In-Reply-To: <20230214050757.9623-10-likexu@tencent.com>
Mime-Version: 1.0
References: <20230214050757.9623-1-likexu@tencent.com> <20230214050757.9623-10-likexu@tencent.com>
Message-ID: <ZC9khVlFr2RYd83P@google.com>
Subject: Re: [PATCH v4 09/12] KVM: x86/pmu: Forget PERFCTR_CORE if the min num
 of counters isn't met
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> KVM should sanity check the number of counters enumerated by perf and
> explicitly drop PERFCTR_CORE support if the min isn't met. E.g. if KVM
> needs 6 counters and perf says there are 4, then something is wrong and
> enumerating 6 to the guest is only going to cause more issues.
> 
> Opportunistically, the existing kvm_cpu_cap_check_and_set() makes it
> easier to simplify the host check before setting the PERFCTR_CORE flag.

Once again, state what the patch does.

> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  arch/x86/kvm/svm/svm.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index dd21e8b1a259..f4a4691b4f4e 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4910,9 +4910,14 @@ static __init void svm_set_cpu_caps(void)
>  	    boot_cpu_has(X86_FEATURE_AMD_SSBD))
>  		kvm_cpu_cap_set(X86_FEATURE_VIRT_SSBD);
>  
> -	/* AMD PMU PERFCTR_CORE CPUID */
> -	if (enable_pmu && boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
> -		kvm_cpu_cap_set(X86_FEATURE_PERFCTR_CORE);
> +	if (enable_pmu) {

A comment would be very helpful here.   Even better would be if we can convince
perf to rename AMD64_NUM_COUNTERS to AMD64_LEGACY_NUM_COUNTERS.


> +		if (kvm_pmu_cap.num_counters_gp < AMD64_NUM_COUNTERS_CORE) {
> +			kvm_pmu_cap.num_counters_gp = AMD64_NUM_COUNTERS;

Hmm, this subtly relies on kvm_init_pmu_capability() running first.  That
_probably_ won't change, but like the arch LBRs side of things I would prefer to
avoid taking unnecessarily.  E.g. something like this?

		/*
		 * Enumerate support for PERFCTR_CORE if and only if KVM has
		 * access to enough counters to virtualize "core" support,
		 * otherwise limit vPMU support to the legacy number of counters.
		 */
		if (kvm_pmu_cap.num_counters_gp < AMD64_NUM_COUNTERS_CORE)
			kvm_pmu_cap.num_counters_gp = min(AMD64_NUM_COUNTERS,
							  kvm_pmu_cap.num_counters_gp);

It's a bit paranoid, but practically speaking it doesn't cost us anything.

> +		} else {
> +			/* AMD PMU PERFCTR_CORE CPUID */

Meh, this is not a very helpful comment, no need to carry it forward.  And if you
drop it, then the need for curly braces goes away.

> +			kvm_cpu_cap_check_and_set(X86_FEATURE_PERFCTR_CORE);
> +		}
> +	}
>  
>  	/* CPUID 0x8000001F (SME/SEV features) */
>  	sev_set_cpu_caps();
> -- 
> 2.39.1
> 
