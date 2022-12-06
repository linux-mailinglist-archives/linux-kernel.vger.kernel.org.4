Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E015A644A34
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiLFRTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbiLFRTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:19:49 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC6632B9E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:19:49 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id p24so14597692plw.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 09:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nufx4zcAF2Hy92hdZ4SQGgGJQhbCVmBKUwfpAVYuWVU=;
        b=Obn4AceK6JO1PPNkUXCyxakNTEOq4vY6WYVQLNpctP9OccD3HniookrXLoUobLFi58
         g4OP1m+jq9wTSxYIXXemVbnmEZVHPR4h0M9IStEHhBlVhRqJ1V3iz5Jm4X+ZIFGQMgav
         q60b2tS4LyqYTF4BahjOYBq5aQ2io2Puub3yiSTk/Mc9YFCzQPYLC8nLU/WvhEaqdtBr
         4tv4pWh+Owmc5zKz/+2yT/H+Sp/gfXWqFPf8yAwdJ4pB44xBWX8VUDq7tF6tHxHcKo6s
         jJG7bR1H2Hdr1QYvZHmUZkmRpa4q28Be6oBZlCRwWROdG7WxCnxEHw3dRLt2QuJuvmzA
         qQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nufx4zcAF2Hy92hdZ4SQGgGJQhbCVmBKUwfpAVYuWVU=;
        b=rHIVJxEKoHB2iE+bXJU3xiYafk5k76edBSQs+lndMwnA6wa1trBVPheRoSGjzW/iYw
         UDc4PivJDCQVjykt6rrCyECcEFhggN8I+hQ74SJIAnw/tNwvosHBS1o/NdGB78Lw57aB
         Wzo+ccuchBaBfK5pppMRwIKwwRxQBXzWNZZxJXl+qI+534XHOYV1tpGQqkTIVWkrTF41
         jaYRSbsGGZD3mT1X1BxeHwkxmEbJM+UwhxcSoqmktnE5m0/reJVcf0yJyJBoEqhP8oj6
         9jBLeBNoFqZtCDX1ijiN2Ek0j1kiW89ft3VdWxNdgZawKACFrjYnh3Jhy18VDJay8WXi
         PPGw==
X-Gm-Message-State: ANoB5pnbYQoXFlcxZv6PHfT6MbP+KgH0yn4saOl/aHMxKS2z11RIBZtl
        2qeAqdnOthSd5N4gJ1pe17bAGw==
X-Google-Smtp-Source: AA0mqf5cWW2MfuAinYnKIj4/TFXmrCH6S81CbrXwLs/uGbsz9tE0u3kFGxBncDG7FF690NMfx9Vviw==
X-Received: by 2002:a17:902:7686:b0:177:faf5:58c5 with SMTP id m6-20020a170902768600b00177faf558c5mr73905859pll.166.1670347188486;
        Tue, 06 Dec 2022 09:19:48 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id c9-20020a63ef49000000b0046feca0883fsm9918488pgk.64.2022.12.06.09.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 09:19:48 -0800 (PST)
Date:   Tue, 6 Dec 2022 17:19:44 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86/pmu: Avoid ternary operator by directly
 referring to counters->type
Message-ID: <Y495sF0rDGrrfstD@google.com>
References: <20221205113718.1487-1-likexu@tencent.com>
 <Y44gbvm5Zb7a1Sbj@google.com>
 <38b2a836-f9a4-23e4-107b-61efc74638a4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38b2a836-f9a4-23e4-107b-61efc74638a4@gmail.com>
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

On Tue, Dec 06, 2022, Like Xu wrote:
> > > diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> > > index e5cec07ca8d9..28b0a784f6e9 100644
> > > --- a/arch/x86/kvm/vmx/pmu_intel.c
> > > +++ b/arch/x86/kvm/vmx/pmu_intel.c
> > > @@ -142,7 +142,7 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
> > >   	}
> > >   	if (idx >= num_counters)
> > >   		return NULL;
> > > -	*mask &= pmu->counter_bitmask[fixed ? KVM_PMC_FIXED : KVM_PMC_GP];
> > > +	*mask &= pmu->counter_bitmask[counters->type];
> > 
> > In terms of readability, I have a slight preference for the current code as I
> > don't have to look at counters->type to understand its possible values.
> When someone tries to add a new type of pmc type, the code bugs up.

Are there new types coming along?  If so, I definitely would not object to refactoring
this code in the context of a series that adds a new type(s).  But "fixing" this one
case is not sufficient to support a new type, e.g. intel_is_valid_rdpmc_ecx() also
needs to be updated.  Actually, even this function would need additional updates
to perform a similar sanity check.

	if (fixed) {
		counters = pmu->fixed_counters;
		num_counters = pmu->nr_arch_fixed_counters;
	} else {
		counters = pmu->gp_counters;
		num_counters = pmu->nr_arch_gp_counters;
	}
	if (idx >= num_counters)
		return NULL;

> And, this one will make all usage of pmu->counter_bitmask[] more consistent.

How's that?  There's literally one instance of using ->type

  static inline u64 pmc_bitmask(struct kvm_pmc *pmc)
  {
	struct kvm_pmu *pmu = pmc_to_pmu(pmc);

	return pmu->counter_bitmask[pmc->type];
  }

everything else is hardcoded.  And using pmc->type there make perfect sense in
that case.  But in intel_rdpmc_ecx_to_pmc(), there is already usage of "fixed",
so IMO switching to ->type makes that function somewhat inconsistent with itself.
