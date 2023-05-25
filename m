Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9184A710E30
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241500AbjEYOVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjEYOVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:21:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B096189;
        Thu, 25 May 2023 07:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U8Ak11VIsc+VQhtMvrttpQiETgYMyOlybtRim6fMVi8=; b=NBQsDfTgYYZT0p9hVq/M7btlaw
        FF3WYNlSo9swkBIqjIu0sUYi3sou4mxgUw9C7Iw+7Q1lrB8d8nhWaDiCn+aucm5HDK9LvwarpDmE0
        1HiVUN26Q/Qgd399Y5XpfuFJ8DREht21ZUuoorPIjwXqGszB208WDMi8DOhgAqbKKWzHtJANr9Qp3
        ALs4m7kyHdQ8iTjmDszLjZb5Gr6coOV66fpS8iX4T1aN0zjbg1Hw5MxnrrOv4xPigKqbAThn2WZRm
        pjz7F/gT34P5LzQHsl5FdcpvrIddoNPh0xwZX9+geRDqBpZfIaNWDMU7P2htPXzhO+WV5JB40wRFV
        6XXuOs2w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q2BpR-006Z1z-2k;
        Thu, 25 May 2023 14:20:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E3FCC300322;
        Thu, 25 May 2023 16:20:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C8AC3241ECA53; Thu, 25 May 2023 16:20:31 +0200 (CEST)
Date:   Thu, 25 May 2023 16:20:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Nathan Chancellor <nathan@kernel.org>, namhyung@kernel.org,
        eranian@google.com, acme@kernel.org, mark.rutland@arm.com,
        jolsa@kernel.org, irogers@google.com, bp@alien8.de,
        kan.liang@linux.intel.com, adrian.hunter@intel.com,
        maddy@linux.ibm.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, maz@kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 3/4] perf/core: Remove pmu linear searching code
Message-ID: <20230525142031.GU83892@hirez.programming.kicks-ass.net>
References: <20230504110003.2548-1-ravi.bangoria@amd.com>
 <20230504110003.2548-4-ravi.bangoria@amd.com>
 <20230524214133.GA2359762@dev-arch.thelio-3990X>
 <f02c78e2-34b9-4985-640a-279dae1004a9@amd.com>
 <ZG8KLbZSECiYaKFc@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG8KLbZSECiYaKFc@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 07:11:41AM +0000, Oliver Upton wrote:

> The PMUv3 driver does pass a name, but it relies on getting back an
> allocated pmu id as @type is -1 in the call to perf_pmu_register().
> 
> What actually broke is how KVM probes for a default core PMU to use for
> a guest. kvm_pmu_probe_armpmu() creates a counter w/ PERF_TYPE_RAW and
> reads the pmu from the returned perf_event. The linear search had the
> effect of eventually stumbling on the correct core PMU and succeeding.
> 
> Perf folks: is this WAI for heterogenous systems?

TBH, I'm not sure. hetero and virt don't mix very well AFAIK and I'm not
sure what ARM64 does here.

IIRC the only way is to hard affine things; that is, force vCPU of
'type' to the pCPU mask of 'type' CPUs.

If you don't do that; or let userspace 'override' that, things go
sideways *real* fast.

Mark gonna have to look at this.

> Either way, the whole KVM end of this scheme is a bit clunky, and I
> believe it to be unneccessary at this point as we maintain a list of
> core PMU instances that KVM is able to virtualize. We can just walk
> that to find a default PMU to use.
> 
> Not seeing any issues on -next with the below diff. If this works for
> folks I can actually wrap it up in a patch and send it out.
> 
> diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
> index 45727d50d18d..cbc0b662b7f8 100644
> --- a/arch/arm64/kvm/pmu-emul.c
> +++ b/arch/arm64/kvm/pmu-emul.c
> @@ -694,47 +694,26 @@ void kvm_host_pmu_init(struct arm_pmu *pmu)
>  
>  static struct arm_pmu *kvm_pmu_probe_armpmu(void)
>  {
> -	struct perf_event_attr attr = { };
> -	struct perf_event *event;
> -	struct arm_pmu *pmu = NULL;
> -
> -	/*
> -	 * Create a dummy event that only counts user cycles. As we'll never
> -	 * leave this function with the event being live, it will never
> -	 * count anything. But it allows us to probe some of the PMU
> -	 * details. Yes, this is terrible.
> -	 */
> -	attr.type = PERF_TYPE_RAW;
> -	attr.size = sizeof(attr);
> -	attr.pinned = 1;
> -	attr.disabled = 0;
> -	attr.exclude_user = 0;
> -	attr.exclude_kernel = 1;
> -	attr.exclude_hv = 1;
> -	attr.exclude_host = 1;
> -	attr.config = ARMV8_PMUV3_PERFCTR_CPU_CYCLES;
> -	attr.sample_period = GENMASK(63, 0);
> +	struct arm_pmu *arm_pmu = NULL, *tmp;
> +	struct arm_pmu_entry *entry;
> +	int cpu;
>  
> -	event = perf_event_create_kernel_counter(&attr, -1, current,
> -						 kvm_pmu_perf_overflow, &attr);
> +	mutex_lock(&arm_pmus_lock);
> +	cpu = get_cpu();
>  
> -	if (IS_ERR(event)) {
> -		pr_err_once("kvm: pmu event creation failed %ld\n",
> -			    PTR_ERR(event));
> -		return NULL;
> -	}
> +	list_for_each_entry(entry, &arm_pmus, entry) {
> +		tmp = entry->arm_pmu;
>  
> -	if (event->pmu) {
> -		pmu = to_arm_pmu(event->pmu);
> -		if (pmu->pmuver == ID_AA64DFR0_EL1_PMUVer_NI ||
> -		    pmu->pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF)
> -			pmu = NULL;
> +		if (cpumask_test_cpu(cpu, &tmp->supported_cpus)) {
> +			arm_pmu = tmp;
> +			break;
> +		}
>  	}
>  
> -	perf_event_disable(event);
> -	perf_event_release_kernel(event);
> +	put_cpu();
> +	mutex_unlock(&arm_pmus_lock);
>  
> -	return pmu;
> +	return arm_pmu;
>  }
