Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8415D64BBD8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 19:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbiLMSW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 13:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236271AbiLMSWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:22:54 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B482248
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:22:50 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r18so388759pgr.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vbt0meIgNn6WBG4YKbNfGi1T3PYNH2tI0RABGm6MAIY=;
        b=clVFCd5NAswd0cV5yiJ07YbrMqm/CoMDjz7XOZ2ww7a9GYyW5vk4yywNHRG5Ad+WXB
         hbq44pfn7aYqEIVVmUQsFM6Y8CxcJlw3QXr/qCvnKCNZBr8PzznZVoNkfZNbn1xITgwW
         +nBS4O9SzJ/7RuXokUHopQoBRfoB75i29p7cO2lqearialjc2gIWpVxIy1tX/nmDQgwc
         W58XTPAQZgCLDbxqZzXtl1PCpopHaxD1OtIsbXSLCYd76Ow533MgDCL5mG6/XVENGbWF
         ZfNmBf8gS0lPgVdqVkKxH6lghccfPJyKH2BL2/y9fbgiRx549qyPOE9NiT9AsmrxddrV
         KhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbt0meIgNn6WBG4YKbNfGi1T3PYNH2tI0RABGm6MAIY=;
        b=FvH8gYnPIeH63ZFQjVe0hKr1tfEWLjAsqujuPG9+bvjrtVKn2CJqZ0qk3y3wCwdwKA
         Vg8/lD6dqnOj/rEZIo9OhrpLZQTZXsZA+DKRD8Zrzu/kGWFlRzoANFAUk5ccMH8RcmJF
         ORZZoTWri8E+LmQzKYb5zgpDjIr/9hMZxmk+xx12sJWJ6IzbmiZ29i0Kg0O3IL7xWJTk
         MR91yOWPzn1H6uCiNWRJBa5W07sO17Ukl5WOQ9gpJcm5zqghIdbGJMble6jMz1paUBXh
         mRwOma0N5lttQpvEly3fiGDRDVVY/xDcmZFEjhedu6fJju5BH5gC1Hiy1lfEHFiWBHyQ
         aZEA==
X-Gm-Message-State: ANoB5plCgsIwHPht4m1AajnZwEFIV7bKGj8AoYkmQstvb+zwZ0ciLYzb
        DXSpGb5R+34Dy/neZ5tvm1DcrpAjjW2+bH1+
X-Google-Smtp-Source: AA0mqf6Soby8rd6m9EytXXHvJpT4TDAOmpLAofqH3m8MSRCn4y3bZNlZuKdxW3txtw47z8Dx4bLf1w==
X-Received: by 2002:aa7:9697:0:b0:576:9252:d06 with SMTP id f23-20020aa79697000000b0057692520d06mr371181pfk.0.1670955769814;
        Tue, 13 Dec 2022 10:22:49 -0800 (PST)
Received: from google.com (220.181.82.34.bc.googleusercontent.com. [34.82.181.220])
        by smtp.gmail.com with ESMTPSA id g74-20020a62524d000000b0056bb4bbfb9bsm8195038pfb.95.2022.12.13.10.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 10:22:49 -0800 (PST)
Date:   Tue, 13 Dec 2022 10:22:45 -0800
From:   Ricardo Koller <ricarkol@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     James Clark <james.clark@arm.com>, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] KVM: arm64: PMU: Fix PMCR_EL0 reset value
Message-ID: <Y5jC9bAJ08xW1ZIA@google.com>
References: <20221209164446.1972014-1-james.clark@arm.com>
 <20221209164446.1972014-2-james.clark@arm.com>
 <Y5N3R+w3GF94hxHa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5N3R+w3GF94hxHa@google.com>
X-Spam-Status: No, score=-16.4 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URI_DOTEDU,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 05:58:31PM +0000, Oliver Upton wrote:
> On Fri, Dec 09, 2022 at 04:44:46PM +0000, James Clark wrote:
> > ARMV8_PMU_PMCR_N_MASK is an unshifted value which results in the wrong
> > reset value for PMCR_EL0, so shift it to fix it.
> 
> That's just mean. *_MASK tends to be a shifted mask, although it would
> appear that asm/perf_event.h does not follow this convention. Fixing
> that would be nice (as I'm sure somebody else will get burned by this),
> but for the sake of an immediate fix:
>

Even kvm-unit-tests does this:

arm/pmu.c:
#define PMU_PMCR_N_SHIFT   11
#define PMU_PMCR_N_MASK    0x1f


> > This fixes the following error when running qemu:
> > 
> >   $ qemu-system-aarch64 -cpu host -machine type=virt,accel=kvm -kernel ...
> > 
> >   target/arm/helper.c:1813: pmevcntr_rawwrite: Assertion `counter < pmu_num_counters(env)' failed.
> > 
> > Fixes: 292e8f149476 ("KVM: arm64: PMU: Simplify PMCR_EL0 reset handling")
> > Signed-off-by: James Clark <james.clark@arm.com>
> 
> Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
> 
> --
> Thanks,
> Oliver
> 
> > ---
> >  arch/arm64/kvm/sys_regs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > index d5ee52d6bf73..c6cbfe6b854b 100644
> > --- a/arch/arm64/kvm/sys_regs.c
> > +++ b/arch/arm64/kvm/sys_regs.c
> > @@ -646,7 +646,7 @@ static void reset_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
> >  		return;
> >  
> >  	/* Only preserve PMCR_EL0.N, and reset the rest to 0 */
> > -	pmcr = read_sysreg(pmcr_el0) & ARMV8_PMU_PMCR_N_MASK;
> > +	pmcr = read_sysreg(pmcr_el0) & (ARMV8_PMU_PMCR_N_MASK << ARMV8_PMU_PMCR_N_SHIFT);
> >  	if (!kvm_supports_32bit_el0())
> >  		pmcr |= ARMV8_PMU_PMCR_LC;
> >  
> > -- 
> > 2.25.1
> > 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
