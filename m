Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771B363B967
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 06:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbiK2FUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 00:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbiK2FUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 00:20:12 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F1850D79
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 21:20:11 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bx10so8212140wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 21:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UNtdvjscBhLbwh2XhJBp9F2ZNT8kfwAr14y0tkrEfX4=;
        b=YTO1hgLZguCdb6dM2PGe/mFaxgvPJ9FFs5FLLLiKeEvJIF4E8z6L66+m0nHOLQWYTG
         Br5NP+RuRHUIzj+NdIrw6uuJVyGoA0MQytuPZR89PiunS3xcUsW2xuG3ApMF/002kb98
         pKkpohbCeUUS06R6+HLRImy+1pGoQsyhQilwsjs6C6mXM5v8UeDNZVJRNuiARtCIzLmf
         7lR4umfzB4BEtx56RR8sg2qHlIR6vF3EtGen4XLiuRYEPx2VPW9mY3Tc2y8GLJm329s9
         BWNInJHNLF3tzUiwb3ldQSNdN/mZ0sxPcSaD0r1SVi0E6zAIhDN3JMWeDXu9UDyZuB+G
         2uGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNtdvjscBhLbwh2XhJBp9F2ZNT8kfwAr14y0tkrEfX4=;
        b=4PZxgCsek3ILx8kCyKMdvTtYAJK3NG6NOd4PadeNJ7af05DrOmAHU4yqrWzp06vt4t
         ez+CXgQMvS6ti8I8ALP/Yq3uA7NxkajIf8cA6hhwGmXu1aGy4qvTqxIoCJEE8Nga2zKc
         v6VnIlj0lIGH1R9+jB1xtoVy2xPg0Mai5vt9R55uYRKxf8necN28t0TXexfH1EQBRfyg
         uq4iZVntKGp+uDRUa81T5w9wyuyG/sqWwAsmxjtEFt1owUlgWH8nU74JDLN8YspA/xLG
         9PktamhfR9F3Jd3zgXZ9Xm06QOLgymhrC2dUjKLZAbRfS2YS2f8X7fvHeOZevTHC+W0x
         A1ww==
X-Gm-Message-State: ANoB5pmMb0ZV3kWz05IS+B9hRthjU4wFif10u3ub/WEnL37QWRYL6oww
        KOZGNEHFpZbf50w/T2q5kfEgvQ==
X-Google-Smtp-Source: AA0mqf52narjPwuAD2X85QS2JLR4/KZBHsWfpzhuT8Zjpu5uwjDHTPLaoPhzIqv1I50SxY3DzMvX/Q==
X-Received: by 2002:a5d:58d1:0:b0:242:a3a:69cf with SMTP id o17-20020a5d58d1000000b002420a3a69cfmr9670017wrf.159.1669699209959;
        Mon, 28 Nov 2022 21:20:09 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id q8-20020adfcd88000000b00236576c8eddsm12357878wrj.12.2022.11.28.21.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 21:20:09 -0800 (PST)
Date:   Tue, 29 Nov 2022 06:20:08 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] RISC-V: KVM: Remove redundant includes of
 asm/kvm_vcpu_timer.h
Message-ID: <20221129052008.jyoexzmhzo3n6l5w@kamzik>
References: <20221128161424.608889-1-apatel@ventanamicro.com>
 <20221128161424.608889-3-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128161424.608889-3-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 09:44:17PM +0530, Anup Patel wrote:
> The asm/kvm_vcpu_timer.h is redundantly included in vcpu_sbi_base.c
> so let us remove it.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/kvm/vcpu_sbi_base.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/riscv/kvm/vcpu_sbi_base.c b/arch/riscv/kvm/vcpu_sbi_base.c
> index 48f431091cdb..22b9126e2872 100644
> --- a/arch/riscv/kvm/vcpu_sbi_base.c
> +++ b/arch/riscv/kvm/vcpu_sbi_base.c
> @@ -12,7 +12,6 @@
>  #include <linux/version.h>
>  #include <asm/csr.h>
>  #include <asm/sbi.h>
> -#include <asm/kvm_vcpu_timer.h>
>  #include <asm/kvm_vcpu_sbi.h>
>  
>  static int kvm_sbi_ext_base_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
