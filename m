Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311BF70FFDD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 23:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjEXVPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 17:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEXVPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 17:15:01 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E63BF5
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 14:14:59 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-64d4ea109faso1416289b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684962899; x=1687554899;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L0CszzEDwbE3JY4YxlCWnLSJ9BPWtVjD6zzwUuhdUAA=;
        b=HPNpwWP0auatKhgJRShk8KKkeQowTcRk82oMS+BgHcGzQCjb99RlL0cPt0FmbMsAMS
         lsUuKskvy/yH3bDvzk0W0JvbK7AcjAedIfK+D8ISvxtTWtNGDnGdOo0XGaibdPqt/dnk
         OhBqzP26mbc6odrVxU/8svO1/p7v1weDTBvIW+Gxs6XR9jfX0jeUVQ3xca8Xj1MNQTNj
         l5BOo/p+RlUcv4DjKhQceL3j/CQZHG3T1ELm+32KsNvdqkRwxXmAw0kvJwwhILLtQZUG
         LM9rQIDrV5tvuySCReMpmZCq147CDdtIX6zIFE5ZwN1xEonjK05qXqpW0ztETozRlz0r
         38tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684962899; x=1687554899;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L0CszzEDwbE3JY4YxlCWnLSJ9BPWtVjD6zzwUuhdUAA=;
        b=HeC45Wvo5H1XFSLBO1V9G7Z7WgqBiEsSLS02wckF/cffMnpHfv61OKybaASqeokYpB
         lWDMUbhasbMPnPs2o3vFJUz8CK06fdPLIBZ3TV67RXTQ89xIutpG0nk3jk7f4sxuaENI
         9H7mbd6VWz5v+cipdMIr1ogYK1w4Gs2JB0yDXvYAb4fKunDGF47l7MDsPO10/qJGSizt
         sbwYQMR+yLJ9myYwJUF1j1K9TOEIN50nrl/+bh6XX46n/1cIvDuLO23zsNLF1jxBsi4L
         TftfAIMM0h89ZeDc//o7efym1lUbGNpJ1laZcy57f34Zd1SxUHvvT02OjZ+tX3r4/Kcd
         Hvow==
X-Gm-Message-State: AC+VfDzvEiG2ea5fK6UePXDlRdaShskdkjMOLxLhvPtfztii15u3jpYx
        3zEvvsc/zgSPrxeiKSuu8WUny15sMa8=
X-Google-Smtp-Source: ACHHUZ7eclZoMdEkilzU+7c7b5JIvKk8WPVxpasD88aM3nhMPtgnD5y1pGlefT+b7mvnKnxqKzCApp9Nyfs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1585:b0:643:a029:5b3f with SMTP id
 u5-20020a056a00158500b00643a0295b3fmr1662047pfk.2.1684962899087; Wed, 24 May
 2023 14:14:59 -0700 (PDT)
Date:   Wed, 24 May 2023 14:14:57 -0700
In-Reply-To: <20230310105346.12302-5-likexu@tencent.com>
Mime-Version: 1.0
References: <20230310105346.12302-1-likexu@tencent.com> <20230310105346.12302-5-likexu@tencent.com>
Message-ID: <ZG5+Ud26J0Ll7g0w@google.com>
Subject: Re: [PATCH 4/5] KVM: x86/pmu: Reorder functions to reduce unnecessary declarations
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> Considering that more emulations are deferred to kvm_pmu_handle_event(),
> moving it to the end of pmu.c makes it easier to call previous functions,
> instead of just piling up the function declarations to make compiler green.

kvm_pmu_handle_event() is globally visible, moving it around changes nothing.

As for using it in kvm_mark_pmc_is_quirky(), explicitly state the direct
motivation for moving kvm_pmu_request_counter_reprogram(), i.e. that it's being
hoisted above pmc_read_counter() for use in a future patch.  Using abstract
language might sound pretty and dramatic, but it's really not helpful for reviewers.

> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index db4262fe8814..a47b579667c6 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -48,6 +48,12 @@ static inline u64 pmc_bitmask(struct kvm_pmc *pmc)
>  	return pmu->counter_bitmask[pmc->type];
>  }
>  
> +static inline void kvm_pmu_request_counter_reprogram(struct kvm_pmc *pmc)
> +{
> +	set_bit(pmc->idx, pmc_to_pmu(pmc)->reprogram_pmi);
> +	kvm_make_request(KVM_REQ_PMU, pmc->vcpu);
> +}
> +
>  static inline u64 pmc_read_counter(struct kvm_pmc *pmc)
>  {
>  	u64 counter, enabled, running;
> @@ -183,12 +189,6 @@ static inline void kvm_init_pmu_capability(const struct kvm_pmu_ops *pmu_ops)
>  					     KVM_PMC_MAX_FIXED);
>  }
>  
> -static inline void kvm_pmu_request_counter_reprogram(struct kvm_pmc *pmc)
> -{
> -	set_bit(pmc->idx, pmc_to_pmu(pmc)->reprogram_pmi);
> -	kvm_make_request(KVM_REQ_PMU, pmc->vcpu);
> -}
> -
>  static inline bool pebs_is_enabled(struct kvm_pmc *pmc)
>  {
>  	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
> -- 
> 2.39.2
> 
