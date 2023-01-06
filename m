Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD25965FABC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 05:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjAFE34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 23:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjAFE3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 23:29:49 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D10454DBF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 20:29:47 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id fz16-20020a17090b025000b002269d6c2d83so5047514pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 20:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fcURZiYLo00tcWs3+wszW6Bvd/4zu4Ab0Se45w2cFpM=;
        b=PzZLX9u+0gK6QDlBGSiiQ+OemnGC69bLORrQ+GjSLLjlWg+dEpIA+ZGZNlGjKgg7sw
         IW0PE1FNfVG6VZVQidaDc2WZSr+yisyFL2+5nOfdFlqMrtQT4NOxnVmLeNz9A/UWM4Mz
         Y38AxjqDaC0Ef0iUtTDIinulbT4SNFVEv7qd7TGeRbqFLLRdAKuIRk3jJ6WX3LPZ8vOo
         pCOsM1lXSEcUVZt2vPlB1HQYpnfJ7I0YCUc4UpEUeI2ajO/KGfr2y4yk8jtws65wrWVo
         5wKxgogUt+nwVw+ZRKXFaCvoWdSwQZ8k9f5HqD83Jw4qcCnpOz+s7rY4ARvJ+Ii/jPem
         JLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fcURZiYLo00tcWs3+wszW6Bvd/4zu4Ab0Se45w2cFpM=;
        b=RJ0mbcRCAciXeLIzLGbOLRp/dtR2wMoZSWnwqnVLrCkICC4SJlwhIohgk7YBnp/4xH
         uD1MaCLPpA5q1eEJdpPus0zklsGfLZL8aXPV6zh6TZ7TUJCqZuBpOIk3hPKWDrJLp4qC
         nG/urZQF5GbAxQRrKRLPIMUTpLoPthWDoMDTK/2RoHW909UX+sT2s24I/jr5VTN76uN1
         mg1KEzfIIrQyFKPsEFdkjPH70dnB6CIPb/zD1w22wSSpiikAdnTSUdSv2fwy3oWtcPrl
         I3A1+Ub4aToAhzUCo1QNXv0nVs/UGGzYLbJAePTh+nDtVzUe9BPQJbuctd2ZJzL1tKJY
         kLBA==
X-Gm-Message-State: AFqh2kqy/nl83rzjUxzYvAlz4ohYESDSS/OAi4y6z/ZXJStFglQVFEYE
        ZXJZu6vzhzkHZrNpM7Wx2zUqkFeDsTuK/qYMTIXWrg==
X-Google-Smtp-Source: AMrXdXsy8aDnv6lrfzqqhK3ITxVFNw7u/CFK+OKUcDXNWDmM7yXqif0Zgd7I4s86POJfZVsaf6QzD1xgDsGxm54lXyY=
X-Received: by 2002:a17:90a:488a:b0:226:b5f4:d420 with SMTP id
 b10-20020a17090a488a00b00226b5f4d420mr837152pjh.102.1672979386260; Thu, 05
 Jan 2023 20:29:46 -0800 (PST)
MIME-Version: 1.0
References: <20221230095452.181764-1-akihiko.odaki@daynix.com> <20221230095452.181764-6-akihiko.odaki@daynix.com>
In-Reply-To: <20221230095452.181764-6-akihiko.odaki@daynix.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Thu, 5 Jan 2023 20:29:28 -0800
Message-ID: <CAAeT=Fx4_gms9ds5xOLXQ0oBgVXcZzE2E9OMaNP7tw7sY9DyuQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] KVM: arm64: Always set HCR_TID2
To:     Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Marc Zyngier <maz@kernel.org>, Sven Peter <sven@svenpeter.dev>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Brown <broonie@kernel.org>, asahi@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Dec 30, 2022 at 1:55 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> Always set HCR_TID2 to trap CTR_EL0, CCSIDR2_EL1, CLIDR_EL1, and
> CSSELR_EL1. This saves a few lines of code and allows to employ their
> access trap handlers for more purposes anticipated by the old
> condition for setting HCR_TID2.
>
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  arch/arm64/include/asm/kvm_arm.h           | 3 ++-
>  arch/arm64/include/asm/kvm_emulate.h       | 4 ----
>  arch/arm64/include/asm/kvm_host.h          | 2 --
>  arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 2 --
>  4 files changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index 8aa8492dafc0..44be46c280c1 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -81,11 +81,12 @@
>   * SWIO:       Turn set/way invalidates into set/way clean+invalidate
>   * PTW:                Take a stage2 fault if a stage1 walk steps in device memory
>   * TID3:       Trap EL1 reads of group 3 ID registers
> + * TID2:       Trap CTR_EL0, CCSIDR2_EL1, CLIDR_EL1, and CSSELR_EL1
>   */
>  #define HCR_GUEST_FLAGS (HCR_TSC | HCR_TSW | HCR_TWE | HCR_TWI | HCR_VM | \
>                          HCR_BSU_IS | HCR_FB | HCR_TACR | \
>                          HCR_AMO | HCR_SWIO | HCR_TIDCP | HCR_RW | HCR_TLOR | \
> -                        HCR_FMO | HCR_IMO | HCR_PTW | HCR_TID3 )
> +                        HCR_FMO | HCR_IMO | HCR_PTW | HCR_TID3 | HCR_TID2)
>  #define HCR_VIRT_EXCP_MASK (HCR_VSE | HCR_VI | HCR_VF)
>  #define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK | HCR_ATA)
>  #define HCR_HOST_NVHE_PROTECTED_FLAGS (HCR_HOST_NVHE_FLAGS | HCR_TSC)
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 9bdba47f7e14..30c4598d643b 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -88,10 +88,6 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
>         if (vcpu_el1_is_32bit(vcpu))
>                 vcpu->arch.hcr_el2 &= ~HCR_RW;
>
> -       if (cpus_have_const_cap(ARM64_MISMATCHED_CACHE_TYPE) ||
> -           vcpu_el1_is_32bit(vcpu))
> -               vcpu->arch.hcr_el2 |= HCR_TID2;
> -
>         if (kvm_has_mte(vcpu->kvm))
>                 vcpu->arch.hcr_el2 |= HCR_ATA;
>  }
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 45e2136322ba..cc2ede0eaed4 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -621,7 +621,6 @@ static inline bool __vcpu_read_sys_reg_from_cpu(int reg, u64 *val)
>                 return false;
>
>         switch (reg) {
> -       case CSSELR_EL1:        *val = read_sysreg_s(SYS_CSSELR_EL1);   break;
>         case SCTLR_EL1:         *val = read_sysreg_s(SYS_SCTLR_EL12);   break;
>         case CPACR_EL1:         *val = read_sysreg_s(SYS_CPACR_EL12);   break;
>         case TTBR0_EL1:         *val = read_sysreg_s(SYS_TTBR0_EL12);   break;
> @@ -666,7 +665,6 @@ static inline bool __vcpu_write_sys_reg_to_cpu(u64 val, int reg)
>                 return false;
>
>         switch (reg) {
> -       case CSSELR_EL1:        write_sysreg_s(val, SYS_CSSELR_EL1);    break;
>         case SCTLR_EL1:         write_sysreg_s(val, SYS_SCTLR_EL12);    break;
>         case CPACR_EL1:         write_sysreg_s(val, SYS_CPACR_EL12);    break;
>         case TTBR0_EL1:         write_sysreg_s(val, SYS_TTBR0_EL12);    break;
> diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> index baa5b9b3dde5..147cb4c846c6 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> @@ -39,7 +39,6 @@ static inline bool ctxt_has_mte(struct kvm_cpu_context *ctxt)
>
>  static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
>  {
> -       ctxt_sys_reg(ctxt, CSSELR_EL1)  = read_sysreg(csselr_el1);
>         ctxt_sys_reg(ctxt, SCTLR_EL1)   = read_sysreg_el1(SYS_SCTLR);
>         ctxt_sys_reg(ctxt, CPACR_EL1)   = read_sysreg_el1(SYS_CPACR);
>         ctxt_sys_reg(ctxt, TTBR0_EL1)   = read_sysreg_el1(SYS_TTBR0);
> @@ -95,7 +94,6 @@ static inline void __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
>  static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
>  {
>         write_sysreg(ctxt_sys_reg(ctxt, MPIDR_EL1),     vmpidr_el2);
> -       write_sysreg(ctxt_sys_reg(ctxt, CSSELR_EL1),    csselr_el1);
>
>         if (has_vhe() ||
>             !cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT)) {
> --

Reviewed-by: Reiji Watanabe <reijiw@google.com>

Nit: access_csselr() can now directly use __vcpu_sys_reg() (instead
of using it through via vcpu_{write,read}_sys_reg()), as most codes
do when there is no need to use vcpu_{write,read}_sys_reg().
The same comment is applied to access_ccsidr(), which uses
vcpu_read_sys_reg() to get CSSELR_EL1 value for the vCPU.

Thank you,
Reiji
