Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1CE70DBCE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbjEWLxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236698AbjEWLxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC48FE
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684842772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06VwMlvzR/6CE72qZy68IsZn5wGl4zzgeBN/A6aW1cc=;
        b=Xw7Jz1qfC1t3Pj5CnhrH3xnAPLRNTKG1XRAIlx28y4GKvjjEKg1DQvS/XosRSeIZIuojC1
        6XxcNvPj09c3KSvEg717LxWiHQofwLaJAlo1KB84D+QHJr23jcrLsT6OKNCkFutYuCvRAX
        faQjU88kFAgmhHMIdin6YovFbhGoVHA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-r7OMX_2tOvCrpeWdVa3PrA-1; Tue, 23 May 2023 07:52:51 -0400
X-MC-Unique: r7OMX_2tOvCrpeWdVa3PrA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2535c34919bso241825a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684842770; x=1687434770;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06VwMlvzR/6CE72qZy68IsZn5wGl4zzgeBN/A6aW1cc=;
        b=OUs8Yxu4zCoWKWKk1c7KkYMpPWMVViVPEiN/eJJN5Rkh3LioQX/QV68lFoirnBCCix
         EeGsOrVsh9E/J0bQRBz9wQC8gVJMngDPPluOkpD+2cFL+F1V27gNquNWQ/qfHr3Aq2Cd
         70PPwTLUj3Nlegqsw/9EecbdGyqJfNtoZg+7KdiF0FXQof3f5soDvI+b21VPvKAxFKbS
         27YrBUL25FnhaWqJKosM3vDKWDwkF0uMxmuG65RaeDHP31xoRyTLMEX3lyQwW5qx0z4h
         ukPfbJrz1i54Fzwo/l19/veQCGrSIKnHYq87ThlOl+ZdXVTU6Y3zhjlgpeiitMtBKmYk
         05ZQ==
X-Gm-Message-State: AC+VfDy2WEcgzhyt4UgBMjdKPKu0vlF6oHWAhzIG3aJLvAsEBHgBrTeE
        vbj9c0F1ZIBr0sdSTGDeQcr2DRob3nnNz+9nGdwtfUJtZJkpJmQAxvkQ/IkvDdsx325HKzI7DW2
        u9tq7lb5H6peU0r5sgFXBjtzS
X-Received: by 2002:a17:903:2341:b0:1ac:3ebc:af0c with SMTP id c1-20020a170903234100b001ac3ebcaf0cmr14894236plh.1.1684842770673;
        Tue, 23 May 2023 04:52:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6vP9F0VfIfiU5Je8+q5mg6HvhTsJ6AolGVBg5cr9od6knJO5Ku6pDmkpyrmFj/G2NCOZWtlQ==
X-Received: by 2002:a17:903:2341:b0:1ac:3ebc:af0c with SMTP id c1-20020a170903234100b001ac3ebcaf0cmr14894226plh.1.1684842770366;
        Tue, 23 May 2023 04:52:50 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ja2-20020a170902efc200b001ab13f1fa82sm6645521plb.85.2023.05.23.04.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 04:52:50 -0700 (PDT)
Message-ID: <47e5efc6-f635-70a1-83d6-0c1efbd9168b@redhat.com>
Date:   Tue, 23 May 2023 19:52:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/5] arm64/sysreg: Standardise naming of bitfield
 constants in OSL[AS]R_EL1
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev
References: <20230419-arm64-syreg-gen-v1-0-936cd769cb9e@kernel.org>
 <20230419-arm64-syreg-gen-v1-4-936cd769cb9e@kernel.org>
From:   Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20230419-arm64-syreg-gen-v1-4-936cd769cb9e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/23 00:22, Mark Brown wrote:
> Our standard scheme for naming the constants for bitfields in system
> registers includes _ELx in the name but not the SYS_, update the
> constants for OSL[AS]R_EL1 to follow this convention.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>   arch/arm64/include/asm/kvm_host.h |  2 +-
>   arch/arm64/include/asm/sysreg.h   | 10 +++++-----
>   arch/arm64/kvm/sys_regs.c         | 10 +++++-----
>   3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index bcd774d74f34..cde4ad590f8c 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -996,7 +996,7 @@ void kvm_arm_clear_debug(struct kvm_vcpu *vcpu);
>   void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu);
>   
>   #define kvm_vcpu_os_lock_enabled(vcpu)		\
> -	(!!(__vcpu_sys_reg(vcpu, OSLSR_EL1) & SYS_OSLSR_OSLK))
> +	(!!(__vcpu_sys_reg(vcpu, OSLSR_EL1) & OSLSR_EL1_OSLK))
>   
>   int kvm_arm_vcpu_arch_set_attr(struct kvm_vcpu *vcpu,
>   			       struct kvm_device_attr *attr);
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 4ecae92b56b5..09de958e79ed 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -141,13 +141,13 @@
>   #define SYS_MDRAR_EL1			sys_reg(2, 0, 1, 0, 0)
>   
>   #define SYS_OSLAR_EL1			sys_reg(2, 0, 1, 0, 4)
> -#define SYS_OSLAR_OSLK			BIT(0)
> +#define OSLAR_EL1_OSLK			BIT(0)
>   
>   #define SYS_OSLSR_EL1			sys_reg(2, 0, 1, 1, 4)
> -#define SYS_OSLSR_OSLM_MASK		(BIT(3) | BIT(0))
> -#define SYS_OSLSR_OSLM_NI		0
> -#define SYS_OSLSR_OSLM_IMPLEMENTED	BIT(3)
> -#define SYS_OSLSR_OSLK			BIT(1)
> +#define OSLSR_EL1_OSLM_MASK		(BIT(3) | BIT(0))
> +#define OSLSR_EL1_OSLM_NI		0
> +#define OSLSR_EL1_OSLM_IMPLEMENTED	BIT(3)
> +#define OSLSR_EL1_OSLK			BIT(1)
>   
>   #define SYS_OSDLR_EL1			sys_reg(2, 0, 1, 3, 4)
>   #define SYS_DBGPRCR_EL1			sys_reg(2, 0, 1, 4, 4)
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 53749d3a0996..8a5160a90d3c 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -388,9 +388,9 @@ static bool trap_oslar_el1(struct kvm_vcpu *vcpu,
>   		return read_from_write_only(vcpu, p, r);
>   
>   	/* Forward the OSLK bit to OSLSR */
> -	oslsr = __vcpu_sys_reg(vcpu, OSLSR_EL1) & ~SYS_OSLSR_OSLK;
> -	if (p->regval & SYS_OSLAR_OSLK)
> -		oslsr |= SYS_OSLSR_OSLK;
> +	oslsr = __vcpu_sys_reg(vcpu, OSLSR_EL1) & ~OSLSR_EL1_OSLK;
> +	if (p->regval & OSLAR_EL1_OSLK)
> +		oslsr |= OSLSR_EL1_OSLK;
>   
>   	__vcpu_sys_reg(vcpu, OSLSR_EL1) = oslsr;
>   	return true;
> @@ -414,7 +414,7 @@ static int set_oslsr_el1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
>   	 * The only modifiable bit is the OSLK bit. Refuse the write if
>   	 * userspace attempts to change any other bit in the register.
>   	 */
> -	if ((val ^ rd->val) & ~SYS_OSLSR_OSLK)
> +	if ((val ^ rd->val) & ~OSLSR_EL1_OSLK)
>   		return -EINVAL;
>   
>   	__vcpu_sys_reg(vcpu, rd->reg) = val;
> @@ -1760,7 +1760,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>   	{ SYS_DESC(SYS_MDRAR_EL1), trap_raz_wi },
>   	{ SYS_DESC(SYS_OSLAR_EL1), trap_oslar_el1 },
>   	{ SYS_DESC(SYS_OSLSR_EL1), trap_oslsr_el1, reset_val, OSLSR_EL1,
> -		SYS_OSLSR_OSLM_IMPLEMENTED, .set_user = set_oslsr_el1, },
> +		OSLSR_EL1_OSLM_IMPLEMENTED, .set_user = set_oslsr_el1, },
>   	{ SYS_DESC(SYS_OSDLR_EL1), trap_raz_wi },
>   	{ SYS_DESC(SYS_DBGPRCR_EL1), trap_raz_wi },
>   	{ SYS_DESC(SYS_DBGCLAIMSET_EL1), trap_raz_wi },
> 

-- 
Shaoqin

