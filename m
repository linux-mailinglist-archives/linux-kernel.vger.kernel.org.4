Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C73967F7E7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 14:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbjA1NIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 08:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjA1NIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 08:08:40 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5D4C641
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 05:08:38 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id p26so9177609ejx.13
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 05:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3noSpr0qsbBjaPiHek7vXj61bnZWH4YDsV9fDm3w6bg=;
        b=GqoA0BWlnkv1+k7b2w6EFw+iRqLjZcbPObOdfLA1dW+gUzDn4hFyaV44TZTRFH/2TI
         ZzyZ3g/aod4fp4lN+/kWOa/68ecDddZXUuzTTvgOYSVQxXM9jMQ+EvRgPnZgqD+BqHPu
         fo8SftFGTNn4oTAmMO4Ayga2VN8WLakrSnTVYaEw/aB9Gtp5pEPEBFnx3ZxRLi87/Tbx
         metjDOan2qaYk2jOfOoYI90co/8m7UPb+xRW+fjo3VYRYnudZp9W7QdP5ks3+pFlCMl/
         UQDVWUGoj+Rl98SZJ5V325dEgLGPhHD+uMpJnup5o7/nZGVpEDuOUaR2GD4wWnSJwCfK
         V8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3noSpr0qsbBjaPiHek7vXj61bnZWH4YDsV9fDm3w6bg=;
        b=LrjPuKo7te2dBiPWQZxnnb3+Hxtjum0cgCuomdLRP9Ik9DJSwPUvvP0YUO/GJWHTob
         /rDpWEkON3XPBCb8itmr/2/Ob8QYSX5I+pA55+JuDnxuFH/kg6ygCx2ShSqgKyNL7z3g
         OruGJ2C6/88RKbIaIarebrWKLGGUjYIcHVD+N8TCehJyeDE8Z+nTtRTOUc46wWbOmixm
         Qx5mEVn1AJr/lRCSLDx5X/2L6sotRwbE+oyZyD3deknra8joEJ0omAkSS04g4lCZDGOi
         EiTiKnDPsylHyKozJZgswME/MV1tcs1+GFkiC0s2aAGG67DB4irZnvCeOMYxkhFiQ9Ml
         SLag==
X-Gm-Message-State: AO0yUKWeA3CA0FJo3NJOiUPjDyjMNf/7eEiSFU+fNwIJ7QxhqfttZftR
        vBp0ulgS7FjUdjjGZUxsqqR18A==
X-Google-Smtp-Source: AK7set9s1XJCixtX4cwHO6p5/3Vah0LIW8ZFX9u6X+W6Gu/3sSdtWRe1LeWRRkOlfiv8fDUoCSjdCw==
X-Received: by 2002:a17:906:a457:b0:878:66bc:2280 with SMTP id cb23-20020a170906a45700b0087866bc2280mr9834745ejb.12.1674911317574;
        Sat, 28 Jan 2023 05:08:37 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id n5-20020a1709061d0500b0084d420503a3sm3910116ejh.178.2023.01.28.05.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 05:08:37 -0800 (PST)
Date:   Sat, 28 Jan 2023 14:08:36 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] RISC-V: KVM: Fix privilege mode setting in
 kvm_riscv_vcpu_trap_redirect()
Message-ID: <20230128130836.4ujqmzfqlfpcekni@orel>
References: <20230128082847.3055316-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128082847.3055316-1-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 01:58:46PM +0530, Anup Patel wrote:
> The kvm_riscv_vcpu_trap_redirect() should set guest privilege mode
> to supervisor mode because guest traps/interrupts are always handled
> in virtual supervisor mode.
> 
> Fixes: 9f7013265112 ("RISC-V: KVM: Handle MMIO exits for VCPU")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/kvm/vcpu_exit.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index c9f741ab26f5..af7c4bc07929 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
> @@ -160,6 +160,9 @@ void kvm_riscv_vcpu_trap_redirect(struct kvm_vcpu *vcpu,
>  
>  	/* Set Guest PC to Guest exception vector */
>  	vcpu->arch.guest_context.sepc = csr_read(CSR_VSTVEC);
> +
> +	/* Set Guest privilege mode to supervisor */
> +	vcpu->arch.guest_context.sstatus |= SR_SPP;
>  }
>  
>  /*
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
