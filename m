Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B300A5BB357
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 22:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiIPUOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 16:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiIPUOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 16:14:21 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF0EBA9D3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 13:14:20 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id fv3so22134503pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 13:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=9EpRyveJwinf2g/2n5O6cqr+ncXZffrYpgB3rVZ1U7s=;
        b=AkRPBWvSEoaTjwD6gRh46L4FcUM9k1BQQJzQUThnz5J5uZGaHxVU82WRcKah0NkkGY
         t1WafwQWXAXX8ICa+9vWjmdSs8NtzolRC1cOSQm9CUCNKLmdP2sez+CGIBw6iq3FjXO2
         8PI55ym9IXs71CXffKJWwBZHj7LvmDoLQdRfa1edtAhkVgZGNm7OXoV6Om5mBPVGj3rT
         /kWuGrSy7IXQ8o/nCnBuYpAHfy1EwuHsMT2ufPrCuUwnEtoglCo1DWzaWVZZarCP5x8J
         eF+bVv9DUVkK5Iv1U4J0wHe2QqbeihXndGeUkkeq4LPQtXhdtrTIgfI7kUyiAzzYFe5k
         CsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=9EpRyveJwinf2g/2n5O6cqr+ncXZffrYpgB3rVZ1U7s=;
        b=vcuC988W91cMmaw5A+K20zMQFmY8zupgC7oapovYWtnDnqktg2X9VnDGGKZxc2Um45
         0rrmktCOMXYkKqK6P0WZvdEZVmnwbIS/4yHDL5Fh1fXblMmLBlQsHJaciOm5ynQTzpQS
         46RB2xTbykxkMrrVWfyYmTKuocrJpoCvHFN6fzcL0k9olWPP9+m5AK4kS2lHxqD3NZD5
         qdcIzV8iM4LgGCH6MpiQKkp04Di9zoyeEeenZWVuJPKMl0a3sTbnmkKQwsTclihnSOmr
         Bl+whZfpV39MJpqSdOlihh1CLCdG04DKsPsbdHx0XhwVgJmdBN7qDM1AYz30x689UrKm
         bxRA==
X-Gm-Message-State: ACrzQf0nvCDA3TTHENmd1i9wSY0WY4Jbp3zAG8j599te43BAZkaGOdvX
        0CyLVVsj3GtmVbQO2Sl+zinSIg==
X-Google-Smtp-Source: AMsMyM6MeJrbOV8j8gdA7uPANkkK+Xcczxzmk8FzfAW6PD/qhn+3P4hX7qxNP3tSd9MGo6s4LAqqaQ==
X-Received: by 2002:a17:902:8648:b0:178:1b71:c295 with SMTP id y8-20020a170902864800b001781b71c295mr1468549plt.148.1663359259666;
        Fri, 16 Sep 2022 13:14:19 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id o8-20020a1709026b0800b0016d6963cb12sm13765151plk.304.2022.09.16.13.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 13:14:19 -0700 (PDT)
Date:   Fri, 16 Sep 2022 20:14:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Avi Kivity <avi@redhat.com>, Babu Moger <babu.moger@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joerg Roedel <joerg.roedel@amd.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wyes Karny <wyes.karny@amd.com>, x86@kernel.org
Subject: Re: [PATCH 2/5] KVM: svm: Disallow EFER.LMSLE on hardware that
 doesn't support it
Message-ID: <YyTZFzaDOufASxqd@google.com>
References: <20220916045832.461395-1-jmattson@google.com>
 <20220916045832.461395-3-jmattson@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916045832.461395-3-jmattson@google.com>
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

On Thu, Sep 15, 2022, Jim Mattson wrote:
> KVM has never properly virtualized EFER.LMSLE. When the "nested"
> module parameter is true, it allows an SVM guest to set EFER.LMSLE,
> and it passes the bit through in the VMCB, but the KVM emulator
> doesn't perform the required data segment limit checks in 64-bit mode.
> 
> With Zen3, AMD has dropped support for EFER.LMSLE. Hence, if a Zen3
> guest sets EFER.LMSLE, the next VMRUN will fail with "invalid VMCB."
> 
> When the host reports X86_FEATURE_NO_LMSLE, treat EFER.LMSLE as a
> reserved bit in the guest. Now, if a guest tries to set EFER.LMSLE on
> a host without support for EFER.LMSLE, the WRMSR will raise a #GP.
> 
> At the moment, the #GP may come as a surprise, but it's an improvement
> over the failed VMRUN. The #GP will be vindicated anon.
> 
> Fixes: eec4b140c924 ("KVM: SVM: Allow EFER.LMSLE to be set with nested svm")
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/kvm/svm/svm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index f3813dbacb9f..7c4fd594166c 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5012,7 +5012,9 @@ static __init int svm_hardware_setup(void)
>  
>  	if (nested) {
>  		printk(KERN_INFO "kvm: Nested Virtualization enabled\n");
> -		kvm_enable_efer_bits(EFER_SVME | EFER_LMSLE);
> +		kvm_enable_efer_bits(EFER_SVME);
> +		if (!boot_cpu_has(X86_FEATURE_NO_LMSLE))
> +			kvm_enable_efer_bits(EFER_LMSLE);

Since KVM doesn't correctly virtualize EFER.LMSLE, I wonder if we can get away with
dropping support entirely.  I.e. delete the reference to EFER_LMSLE and unconditionally
set F(NO_LMSLE) in KVM_GET_SUPPORTED_CPUID.
