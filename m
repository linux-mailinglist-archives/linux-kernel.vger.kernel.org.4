Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0F7662B4B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjAIQdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjAIQdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:33:09 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8C4B98
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 08:33:08 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id 17so10130402pll.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 08:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ecp5UFXfNMFBPIbOtNPSmh8uc1awnDJTKSEsrjWv1Jc=;
        b=T3mfjVoSsnq4DNmeDAcjPBeEiahgAMBHTrKrKvCs5rFb/gx7oh7As9TBNXd1AG2zqC
         nh7lmGG54wrvEzYqqR/AndgIknyNKWCoyvrE4RuvGJ/woK7ivfhiEOctGXmXQC6hEB9A
         79KSk/HttDjr0065S6rdO5DPJIkEOD5pnRvoNhLB4zu2XQ7uni8ijViXWTpjD7H7XiyS
         EJzudVQuN6WRw9gXhEppZckDUYyCTFGuY3urr4krV39FbIKZSVGQo+KREMtvUnl+0Fzq
         g8AcU1+Majh2WFScE5Q89JrNQYhEDOzlB3JOsRPkpZXrMSlWeyEqGG69VtmSuAOgQFnQ
         Jn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ecp5UFXfNMFBPIbOtNPSmh8uc1awnDJTKSEsrjWv1Jc=;
        b=O36vbVHxU3EOPkYCtPJioO1lc5HxhrWu1tYvJDPVwvVMD24dgM0sRNQW4AisquWFmn
         THORMSpJ31eDiz394U2xoFfS+Oykg/F6eOzFYrl1bgtl+YDLdBk27TrYhpjV03YMLjMd
         XWsOOqP4PuULYeZ2nPTN302aw5t5anoXBl7gAEtiTs8WbYowUDuLZmpd/JcWU5G8LnQp
         zbL+EXRfqpq8escaoJRhc/O0cjzNYiIT2jcXZL1AdimoIJTSE4fWpbUaBeF7A56CrrYk
         B34VY3p/abcXEgkAxrbjdvkKhErA6R9dls1aY17IRSofTUpAHUf7+q1xbDLPXQLQy2hM
         /QgA==
X-Gm-Message-State: AFqh2kpNIlDSLPJhOsk3aQml0s7iLqz7+5O9ByzZVgTtH/gD42LQL9st
        yD+PQVhHLoLDUceF+AYOf2Ea6Q==
X-Google-Smtp-Source: AMrXdXuYeh2cJWf75YwCyP/mklYb4x9F5k5OP4SETjAi8DT2Lj6aEq76MLPjnPTJZfxv6efegirOtg==
X-Received: by 2002:a17:90a:e2c4:b0:226:5758:a57f with SMTP id fr4-20020a17090ae2c400b002265758a57fmr649243pjb.2.1673281987756;
        Mon, 09 Jan 2023 08:33:07 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090ad0c400b00218fb3bec27sm5661842pjw.56.2023.01.09.08.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 08:33:02 -0800 (PST)
Date:   Mon, 9 Jan 2023 16:32:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Orr <marcorr@google.com>,
        Ben Gardon <bgardon@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>
Subject: Re: [PATCH 5/6] KVM: VMX: Always intercept accesses to unsupported
 "extended" x2APIC regs
Message-ID: <Y7xBuYBYCfEgS9sI@google.com>
References: <20230107011025.565472-1-seanjc@google.com>
 <20230107011025.565472-6-seanjc@google.com>
 <5e50b87a4c7d19f9386bac1aa7061675018a2caa.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e50b87a4c7d19f9386bac1aa7061675018a2caa.camel@redhat.com>
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

On Sun, Jan 08, 2023, Maxim Levitsky wrote:
> On Sat, 2023-01-07 at 01:10 +0000, Sean Christopherson wrote:
> >  static void vmx_update_msr_bitmap_x2apic(struct kvm_vcpu *vcpu)
> >  {
> > +	/*
> > +	 * x2APIC indices for 64-bit accesses into the RDMSR and WRMSR halves
> > +	 * of the MSR bitmap.  KVM emulates APIC registers up through 0x3f0,
> > +	 * i.e. MSR 0x83f, and so only needs to dynamically manipulate 64 bits.
> > +	 */
> The above comment is better to be placed down below, near the actual write,
> otherwise it is confusing.

Can you elaborate on why it's confusing?  The intent of this specific comment is
to capture why the index calculations use BITS_PER_LONG_LONG and sizeof(u64).

> > +	const int read_idx = APIC_BASE_MSR / BITS_PER_LONG_LONG;
> > +	const int write_idx = read_idx + (0x800 / sizeof(u64));
> >  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> > +	u64 *msr_bitmap = (u64 *)vmx->vmcs01.msr_bitmap;
> >  	u8 mode;
> >  
> >  	if (!cpu_has_vmx_msr_bitmap())
> > @@ -4058,7 +4049,18 @@ static void vmx_update_msr_bitmap_x2apic(struct kvm_vcpu *vcpu)
> >  
> >  	vmx->x2apic_msr_bitmap_mode = mode;
> >  
> > -	vmx_reset_x2apic_msrs(vcpu, mode);
> > +	/*
> > +	 * Reset the bitmap for MSRs 0x800 - 0x83f.  Leave AMD's uber-extended
> > +	 * registers (0x840 and above) intercepted, KVM doesn't support them.
> 
> I don't think AMD calls them uber-extended. Just extended.

Yeah, I took some creative liberaties.  I want to avoid confusion with the more
common use of Extended APIC (x2APIC).
