Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E0E604B2A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbiJSPXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbiJSPWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:22:47 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A971DC83B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:16:02 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id pq16so17195508pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p/yGaf4/dBguojbfnSYOpEC26mQ4z6N8HhJSV9NQYmc=;
        b=cIg9nG++bbZE2c03DnK9RMCaADOtPz/gGEgWVWUqAYfwleQ22poIlPP0wCG+NW7Rmp
         RKTOFTu7fHg66D/Fmw3wzl+fMuoIWINWXJJzi1zHcoeXjJ6OqdO2XXRonT7Alct/fPkb
         RUQiQSH5nE/gMhhkn8ktWcbqAlVRo/favIaLHNWcs+n3/f9tSSXVFw9THflKOa4y9EEC
         5QTE+ueeK5kUXObSAW1Mp//o9Xy936OH5v8rtslSmX4Hz8kwRJVe7ieQwqFuA1SSBSFo
         IDHnJ9lDWaR9WqbZGmuKkBiycN8KET6NGfEbrAUF+2t9YcsWtWieeNCm661physY5+wa
         fwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/yGaf4/dBguojbfnSYOpEC26mQ4z6N8HhJSV9NQYmc=;
        b=ErstIr1yxaIEqFBUDRWMjofKctTEB41dhd5O9I7tEj5F7mHrq6DIh+/plbSMLPS4ra
         jmDzPHYOvN2tSX3IMw1sGnUxfGNNoyen0xIKsaUpoWt0Lw1Zqdtx0AHEibgKW4qL6lql
         paRvbAKLN6G27UHbZ0c8i/qaLLre2sKJnnbhj3baTJ93fB8oFj9aZKuAx2cqcj6FZXIz
         jLpq2qwa7Jkf8shUMZkEShLCMVROPe1sctfvezk1m774/bTcRrpKzBz1CrdiC9ekmTgN
         DwKST5L6Oya8kpQraeTKKZivSK2YJEnmSdj2j1uwlh7DVtrK9wEi7tyY8bov7ReP5PvJ
         9x8g==
X-Gm-Message-State: ACrzQf2ER7aNFMCHeshnqzQk+KcQY0WWrJ9MKLfd/RA1ekr2CmYFVgZ4
        JChG0k0tr1F4fkIZ8g0xNjolLw==
X-Google-Smtp-Source: AMsMyM45rvfJtgYQFuVbJhF4qQk2Q0lTHAIdYG6ftqWTFaKuEuf6kzBOZRS2T890rgIPZr52WzWJ3g==
X-Received: by 2002:a17:902:b907:b0:178:2898:8084 with SMTP id bf7-20020a170902b90700b0017828988084mr8978392plb.140.1666192522159;
        Wed, 19 Oct 2022 08:15:22 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090abd0900b001fd6066284dsm117148pjr.6.2022.10.19.08.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 08:15:21 -0700 (PDT)
Date:   Wed, 19 Oct 2022 15:15:18 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jiaxi Chen <jiaxi.chen@linux.intel.com>
Cc:     kvm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, pbonzini@redhat.com, ndesaulniers@google.com,
        alexandre.belloni@bootlin.com, peterz@infradead.org,
        jpoimboe@kernel.org, chang.seok.bae@intel.com,
        pawan.kumar.gupta@linux.intel.com, babu.moger@amd.com,
        jmattson@google.com, sandipan.das@amd.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, fenghua.yu@intel.com,
        keescook@chromium.org, jane.malalane@citrix.com, nathan@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] x86: KVM: Enable CMPccXADD CPUID and expose it to
 guest
Message-ID: <Y1AUhlwWjIkKfZHA@google.com>
References: <20221019084734.3590760-1-jiaxi.chen@linux.intel.com>
 <20221019084734.3590760-2-jiaxi.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019084734.3590760-2-jiaxi.chen@linux.intel.com>
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

For all the shortlogs, "expose it to guest" is technically wrong.  Adding
recognition in kvm/cpuid.c advertises KVM support to host userspace.  Whether or
not a feature is exposed to the guest is up to the userspace VMM.

On Wed, Oct 19, 2022, Jiaxi Chen wrote:
> CMPccXADD is a new set of instructions in the latest Intel platform Sierra
> Forest. It includes a semaphore operation that can compare and add the

In general, avoid pronouns in changelogs, it's not clear what "it" refers to here.

And for all of these changelogs, please explicitly state that there are no VMX
controls for these instructions, assuming that's actually true.  From a KVM
perspective, that's far more interesting than the details of the instruction(s).

> operands if condition is met, which can improve database performance.
> 
> The bit definition:
> CPUID.(EAX=7,ECX=1):EAX[bit 7]
> 
> This patch enables this CPUID in the kernel feature bits and expose it to
> guest OS.

Same thing here, KVM doesn't decide whether or not to expose the feature to the
guest.

> Signed-off-by: Jiaxi Chen <jiaxi.chen@linux.intel.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  arch/x86/kvm/cpuid.c               | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index ef4775c6db01..445626cb5779 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -308,6 +308,7 @@
>  /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
>  #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
>  #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
> +#define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* CMPccXADD instructions */

Boris,

What do you think about moving CPUID_7_1_EAX to be a KVM-only leaf too?  AFAICT,
KVM passthrough is the only reason the existing features are defined.
