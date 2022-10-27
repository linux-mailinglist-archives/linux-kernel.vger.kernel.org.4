Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E238C6105E7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 00:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbiJ0Wrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 18:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiJ0Wrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 18:47:43 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB584B40CD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 15:47:42 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id x15so2865764qvp.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 15:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P1b8oympTfiO5TpKLj1JFWX96ZUFWry0jri1TDuGUJw=;
        b=dKRAMe+29hBEeu4pcNPqMQuwfm1C9LFmGijhVMgs6k5kzS+c+ajk9Hd1hcV0PG1Lpg
         lB2/0lxwurEEC5qanUyWLDtdVfIkCfZy+u9Fv6YW0dbmuedk+74aKAJZZb5dCKTinRpm
         ClHsPY1arZ0X7nc3I5qzoUA37X+EbwTyHvwhYRagBvYHOLh3V52lNBHm8hev+EpPSu3P
         Qc1XB8geHerIlmRzYgbVHks9jQdn1RqG7S4WmMIyzwHVdYSO4d1nb1rJl3OIEXgWrcAQ
         bYGw/FKEuR07JkZPgRxlxGpBxc0MRPmKI3tzEcp/YlDiCROEJ4qecuW1qP9PdTnOSWHi
         wJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1b8oympTfiO5TpKLj1JFWX96ZUFWry0jri1TDuGUJw=;
        b=6ebHCYnhRbyLDI3YPTd7jVGjSHQ5jgHSkqB7oeLxL2OSrD5IXkFmGESttUv2IRT5C9
         0ah2vCXJbjpQyzb2Wywx2lmz6O5HT6D7TcpaLKUvY4oCWpPbQRmdFJ1yivK8bYiFeA7R
         hHtWwCe8BHSuIIfXDJe1nqLN6V/JPR8MfQuPBxQEtB1Bx1qjzKVCW4BNeSE5WQuR7R/D
         b8m/mqKuMWJcNU4nAifqISWWbh0ZLQGfFK7RM60Hnb/kVabW+le+8a6w55J4eIDMipfe
         0U1cqn6eAIJ2prmdBXdmGF0EOFU//zFe7D26H2osO5XIEVRxvDxTfp2AtNZ+pt2TRK5V
         B1eQ==
X-Gm-Message-State: ACrzQf3cYYSO7werRRnhubm4by2i3CT80WqiVVBNxp/foeWiVokLf899
        G7T7w0IWnTBAFLb6LdOlyngeSEG9EJizOw==
X-Google-Smtp-Source: AMsMyM7Lbh+oRroquOz8WxsGFr52SUAIAOy7Z6N9sFljMKihOjOuiEfSU1EyPV7ogiGNbb0AXJMlIA==
X-Received: by 2002:a17:902:d70e:b0:178:2d9d:ba7b with SMTP id w14-20020a170902d70e00b001782d9dba7bmr51985646ply.90.1666910851508;
        Thu, 27 Oct 2022 15:47:31 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id nh6-20020a17090b364600b002135fdfa995sm2501962pjb.25.2022.10.27.15.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 15:47:31 -0700 (PDT)
Date:   Thu, 27 Oct 2022 22:47:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH v2 2/3] KVM: x86/svm/pmu: Add AMD PerfMonV2 support
Message-ID: <Y1sKf/PgwHwtAibK@google.com>
References: <20220919093453.71737-1-likexu@tencent.com>
 <20220919093453.71737-3-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919093453.71737-3-likexu@tencent.com>
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

On Mon, Sep 19, 2022, Like Xu wrote:
> @@ -162,20 +179,43 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +	struct kvm_cpuid_entry2 *entry;
> +	union cpuid_0x80000022_ebx ebx;
>  
> -	if (guest_cpuid_has(vcpu, X86_FEATURE_PERFCTR_CORE))
> -		pmu->nr_arch_gp_counters = AMD64_NUM_COUNTERS_CORE;
> -	else
> -		pmu->nr_arch_gp_counters = AMD64_NUM_COUNTERS;
> +	pmu->version = 1;
> +	if (kvm_pmu_cap.version > 1) {
> +		pmu->version = min_t(unsigned int, 2, kvm_pmu_cap.version);

This is wrong, it forces the guest PMU verson to match the max version supported
by KVM.  E.g. if userspace wants to expose v1 for whatever reason, pmu->version
will still end up 2+.

> +		entry = kvm_find_cpuid_entry_index(vcpu, 0x80000022, 0);
> +		if (entry) {
> +			ebx.full = entry->ebx;
> +			pmu->nr_arch_gp_counters = min3((unsigned int)ebx.split.num_core_pmc,
> +							(unsigned int)kvm_pmu_cap.num_counters_gp,
> +							(unsigned int)KVM_AMD_PMC_MAX_GENERIC);

This is technically wrong, the number of counters is supposed to be valid if and
only if v2 is supported.  On a related topic, does KVM explode if userspace
specifies a bogus PMU version on Intel?  I don't see any sanity checks there...

With a proper feature flag

	pmu->version = 1;
	if (kvm_cpu_has(X86_FEATURE_AMD_PMU_V2) &&
	    guest_cpuid_has(X86_FEATURE_AMD_PMU_V2)) {
		pmu->version = 2;

		entry = kvm_find_cpuid_entry_index(vcpu, 0x80000022, 0);
		if (entry) {
			...

Though technically the "if (entry)" check is unnecesary.

> +		}
> +	}
> +
> +	/* Commitment to minimal PMCs, regardless of CPUID.80000022 */
> +	if (guest_cpuid_has(vcpu, X86_FEATURE_PERFCTR_CORE)) {

Unnecessary braces.

> +		pmu->nr_arch_gp_counters = max_t(unsigned int,
> +						 pmu->nr_arch_gp_counters,
> +						 AMD64_NUM_COUNTERS_CORE);

What happens if userspace sets X86_FEATURE_PERFCTR_CORE when its not supported?
E.g. will KVM be coerced into taking a #GP on a non-existent counter?


> +	} else {
> +		pmu->nr_arch_gp_counters = max_t(unsigned int,
> +						 pmu->nr_arch_gp_counters,
> +						 AMD64_NUM_COUNTERS);
> +	}
