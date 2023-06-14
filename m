Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407C970FF82
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 22:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjEXUye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 16:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjEXUyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 16:54:31 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECCB18D
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 13:54:26 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-528ab71c95cso428618a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 13:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684961665; x=1687553665;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9TXhZ+RcN2Ognzp8oG5yYSbm5kQG0D1S7pQBiGgog54=;
        b=2h8rqjYFPpwx20+8Yus2Hv3Lx5qrGrNNiOfzsYxA8jNNXcXLIYMNwFXRSu9nTmloVx
         b36BMiaIOxdoRW0NliLzsShWH1H+AfN9X1Lg/wDyJr7JpbvRnVYXbDhpMq+Cm2UouQ3w
         yJ74x2vVorasmuB3ksM/+65kRjrVyg4CHGgisKXxtBY3fMUsoWqZSIwUTAd4x6r2NdO+
         0opK4OzY7ZIDVy/eKGLL/+ICbkH6MqcEImqNubWW/QDDYzqJCazivH2L+0RwFOuUxMFs
         MOvWyhEwQQKdd1GRrsQcT6+fZbcdMx1V2uh0jisUPwVT9+fDlgGMel1ao5QTl2Owq6fm
         UvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684961665; x=1687553665;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9TXhZ+RcN2Ognzp8oG5yYSbm5kQG0D1S7pQBiGgog54=;
        b=BObhb9h/5wjQ1bxFf6JjhmXXQpvJL7ZAmz1crAC/0YXTFCphpVLTsEwf+/82JDfEah
         KbCluW1l51hi8oqqc88oF3U4lR8XX+ACS7plnZdTgM+Hbw+rIJoXsW9uwoZo209fEtUD
         jT9oyyChdtHoOoKDB3doVrHKz+ZmJLAtaPn6UpDcY4iB0IKw2XYPjYivb5N16Yg5o8bV
         Awu94d0J7mIAjYzGpdzlgFzxbn2Bedo9Pl2vQB9d7K29rGoQybgSOp90ZPZIkzT8t2mA
         GPpy21kHtksmuMq/Elc2wpZJcewWYd879iLVVFQeIvETj1NJqu+0hMoor92KHvwHTpmh
         pm+A==
X-Gm-Message-State: AC+VfDz3JEniivjSwCnaCZPLPH07Kg9hj6/3hhXNZ9DYfVEZKHk9vCNe
        oMP4Ekcwy6p/M8Yy4QV5g3u4GhseC+Y=
X-Google-Smtp-Source: ACHHUZ59PvRbm7Gs1FWHPgxapZORSTXDU5xMszFYvqWO85C6Ht301jisiRZ2GoB/1Jqq2QkPdarpBp94re8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:3349:0:b0:51b:8f87:6da4 with SMTP id
 z70-20020a633349000000b0051b8f876da4mr4463245pgz.11.1684961665658; Wed, 24
 May 2023 13:54:25 -0700 (PDT)
Date:   Wed, 24 May 2023 13:54:23 -0700
In-Reply-To: <20230310105346.12302-3-likexu@tencent.com>
Mime-Version: 1.0
References: <20230310105346.12302-1-likexu@tencent.com> <20230310105346.12302-3-likexu@tencent.com>
Message-ID: <ZG55f55fVreCi/pI@google.com>
Subject: Re: [PATCH 2/5] KVM: x86/pmu: Add a helper to check if pmc has PEBS
 mode enabled
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
> Add a helper to check if pmc has PEBS mode enabled so that more new
> code may reuse this part and opportunistically drop a pmu reference.
> 
> No functional change intended.
> 
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  arch/x86/kvm/pmu.c | 3 +--
>  arch/x86/kvm/pmu.h | 7 +++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index d1c89a6625a0..01a6b7ffa9b1 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -191,7 +191,6 @@ static int pmc_reprogram_counter(struct kvm_pmc *pmc, u32 type, u64 config,
>  				 bool exclude_user, bool exclude_kernel,
>  				 bool intr)
>  {
> -	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
>  	struct perf_event *event;
>  	struct perf_event_attr attr = {
>  		.type = type,
> @@ -203,7 +202,7 @@ static int pmc_reprogram_counter(struct kvm_pmc *pmc, u32 type, u64 config,
>  		.exclude_kernel = exclude_kernel,
>  		.config = config,
>  	};
> -	bool pebs = test_bit(pmc->idx, (unsigned long *)&pmu->pebs_enable);
> +	bool pebs = pebs_is_enabled(pmc);
>  
>  	attr.sample_period = get_sample_period(pmc, pmc->counter);
>  
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index cff0651b030b..db4262fe8814 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -189,6 +189,13 @@ static inline void kvm_pmu_request_counter_reprogram(struct kvm_pmc *pmc)
>  	kvm_make_request(KVM_REQ_PMU, pmc->vcpu);
>  }
>  
> +static inline bool pebs_is_enabled(struct kvm_pmc *pmc)

pebs_is_enabled() is a bit too generic, e.g. at a glance I would expect it to return
true if PEBS as a whole is enabled.  What about something like pmc_is_pebs() or
pmc_is_pebs_enabled()?
