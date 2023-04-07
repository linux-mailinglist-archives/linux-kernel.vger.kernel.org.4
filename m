Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138216DA71C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 03:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjDGBu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 21:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjDGBu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 21:50:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3737B6581
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 18:50:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g187-20020a2520c4000000b00b74680a7904so40653058ybg.15
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 18:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680832254;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JowVrky1sJdaqIz82N9TZtKH8APFD0brvsJqK7PiSgc=;
        b=VoAAmuxU0jHs+dSy5Fyk1n7oXhKdE/nFuTJCDoHeI+wV3/E+7tJ6st5i9QMFGkS+Xt
         KItff21bALWu17UcdoQsCk4XiahsCjGpIBYMvUNelibdo8r14VaYcNROVPG5YA8+XFrk
         7LVfGY+8E0QxIiBdkgX1BnJ8nCh1Pvn1MGrn7iit+vG1px6v4FPYi1RRFeltwST6J1iX
         JML87NzWbjEqk6QEYRYGzu8zcnAgU1aJJLPkjjgl/TuV1/i6S+tNNBdFsrWYe5PURP7b
         oexE1r3Y739tjvJrNC6/ZPssrXyYjDzt2JPNDC7oVH/F/Llh9h5GgBLKkqA6LtUWtsaa
         tnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680832254;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JowVrky1sJdaqIz82N9TZtKH8APFD0brvsJqK7PiSgc=;
        b=Ycjt9DDWMtvTJ6Oylf3+23CNQgi1kB+JLF3xfF2S+pQE/y8rw33+yqdrqXUHzw+6nA
         QIj+lv6GXGYAjGb4DCbeUU21lCxG5vm/JVM+Trkm+blLXDTQ7koIBxOUMFskkrl8eDEY
         61U/FssvR3E0i1xPMn0aCxRUcrm/vSOBrqkXCMIuH7ILkBl1bZnhdcDcVQYVvk5TTqME
         IucGlCmrrLOjpk7UAvAAtvQuZMEEUAfrMNKFuT2k9aZBzfrkZux7qghEz9nRMxpxzzdu
         A67nAvs0f1iqTAi87kO63VptdetOmWadwsYqyS469UKMEPBoufqqZDtDwiJxxgZP3dX9
         q2Zg==
X-Gm-Message-State: AAQBX9eGxeHy0Pj1oxV1IjNkemB7YH83o660Mes849XZthSoM27NO2Sm
        UqDPNgmQU/zvDDyfZOH/UGRhBdFduIo=
X-Google-Smtp-Source: AKy350b/2615uacXu4PGtPnp7F39tKkNwP+m0AUlMDVtQgBK4+3c5IY/QdqO+HUQKksXHQUT/Efwh0H0xiQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d4d1:0:b0:b68:d117:305b with SMTP id
 m200-20020a25d4d1000000b00b68d117305bmr767999ybf.10.1680832254517; Thu, 06
 Apr 2023 18:50:54 -0700 (PDT)
Date:   Thu, 6 Apr 2023 18:50:53 -0700
In-Reply-To: <20230214050757.9623-13-likexu@tencent.com>
Mime-Version: 1.0
References: <20230214050757.9623-1-likexu@tencent.com> <20230214050757.9623-13-likexu@tencent.com>
Message-ID: <ZC92/WkJf9/AnABP@google.com>
Subject: Re: [PATCH v4 12/12] KVM: x86/cpuid: Add AMD CPUID ExtPerfMonAndDbg
 leaf 0x80000022
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sandipan Das <sandipan.das@amd.com>
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
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index f4a4691b4f4e..2472fa8746c2 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4916,6 +4916,12 @@ static __init void svm_set_cpu_caps(void)
>  		} else {
>  			/* AMD PMU PERFCTR_CORE CPUID */
>  			kvm_cpu_cap_check_and_set(X86_FEATURE_PERFCTR_CORE);
> +			/*
> +			 * KVM only supports AMD PerfMon V2, even if it supports V3+.

Ha!  A perfect example of why I strongly prefer that changelogs and comments avoid
pronouns.  The above "it" reads as:

			 * KVM only supports AMD PerfMon V2, even if KVM supports V3+.

which is clearly nonsensical.


> +			 * For PerfMon V3+, it's unsafe to expect V2 bit is set or cleared.

If it's unsafe to assume anything v3+ implying v2 support, then it's definitely
not safe to assume that KVM can blindly set v2 without future changes.  I don't
see any reason not to do

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index bd324962bb7e..1192f605ad47 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -756,6 +756,10 @@ void kvm_set_cpu_caps(void)
                F(NULL_SEL_CLR_BASE) | F(AUTOIBRS) | 0 /* PrefetchCtlMsr */
        );
 
+       kvm_cpu_cap_mask(CPUID_8000_0022_EAX,
+               F(PERFMON_V2)
+       );
+
        /*
         * Synthesize "LFENCE is serializing" into the AMD-defined entry in
         * KVM's supported CPUID if the feature is reported as supported by the


and then this code can be:

			if (kvm_pmu_cap.version != 2)
				kvm_cpu_cap_clear(X86_FEATURE_PERFMON_V2);

Ah, but presumably the

		if (kvm_pmu_cap.num_counters_gp < AMD64_NUM_COUNTERS_CORE)

path also needs to clear PERFMON_V2.  I think I'd still vote to grab host CPUID
and clear here (instead of setting).

What is the relationship between PERFCTR_CORE and PERFMON_V2?  E.g. if v2 depends
on having PERFCTR_CORE, then we can do:

	if (enable_pmu) {
		if (kvm_pmu_cap.num_counters_gp < AMD64_NUM_COUNTERS_CORE)
			kvm_pmu_cap.num_counters_gp = AMD64_NUM_COUNTERS;
		else
			kvm_cpu_cap_check_and_set(X86_FEATURE_PERFCTR_CORE);

		if (kvm_pmu_cap.version != 2 ||
		    !kvm_cpu_cap_has(X86_FEATURE_PERFCTR_CORE))
			kvm_cpu_cap_clear(X86_FEATURE_PERFMON_V2);
