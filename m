Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184B6666FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbjALKeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239901AbjALKeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:34:08 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E765BDF48
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:28:41 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id vm8so43612116ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yN+RLFgvhbz6KNBj4UOEkh6O3KRKmh1JWLTXowfNOQ4=;
        b=OGHK98KQTQCVgP5ZLb6uoWrVZz8ZRATpTGiM+GOa8RsP/vCZb2W/EQEp66Mlkp+gqB
         QNDhS/6bBgw9vsyeH9NAw+v27qnm4efliinHoe6pQ2ceKTcbnAqu1jyURCEweldo6cv2
         0Zg9csNpUlkSJh9q60VIzoxpgdAE69Wt/R3hRJITojYyhgz6DLwM8TeCnlDgwV7ASlZZ
         XaAxMT9OcLSA30eRd10vBWc3sCnCOREd3B2TLUJMfNbH5QyR9yUt6truxXqkiFr0mSGZ
         tGpS0D3wVlLxJdYzg4egxn3mCqPC1XiW4xp2BkHSX5lCX4uFMCHTJs6ZeQ1BJuAZAT6o
         i8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yN+RLFgvhbz6KNBj4UOEkh6O3KRKmh1JWLTXowfNOQ4=;
        b=fYje4O9SwG1eBdFLtMkN7grpcBxtrXUt9pXLUOKtrmSuOswrVHqAPT/DFiw/T9SxfB
         F02RV5+Pio5LvXaX/schpog9P/gPOEdpeRyWq89ox+1B+OimB+c4I+VIAqWinHYm2vZk
         K0HlkpA0itdEvc5GwWXGVX+boo9tGzCGYzHNc06QUefQ9QeX9tsTWVxT8+V2R6RZAcx/
         TXGHnQyk09XskOCB1T6ekXXDlhwX841cZZNm5QIy4+Hn45FY5veblyEP/TVrwM1fWUYC
         VYkufw2NYt2WUyq/KtZBgmZKKcSXNAcRlX0kC8OWjN6/piQbHyWtfGU3I5TGod+otBOi
         AxGg==
X-Gm-Message-State: AFqh2kpl5GMc/RQWLcE+ix8NDNz5/6W7MpRZuzuc5fIoVQ/JBchIhfpB
        y8nPr5z+T2Sf3LHxUvpQzCIdYQ==
X-Google-Smtp-Source: AMrXdXsT4YCuaRmd2Qwsk7Y+iEuMALRbwhOUriEVVCZqG2Xv5xsrjQVC9pGKzTU7opANpTCnxxgG9g==
X-Received: by 2002:a17:907:c28f:b0:83f:5f77:8ff9 with SMTP id tk15-20020a170907c28f00b0083f5f778ff9mr65134074ejc.12.1673519320459;
        Thu, 12 Jan 2023 02:28:40 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id p14-20020a170906784e00b00849c1e5c00esm7276648ejm.72.2023.01.12.02.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 02:28:40 -0800 (PST)
Date:   Thu, 12 Jan 2023 11:28:39 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, kvm-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        Eric Lin <eric.lin@sifive.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 03/11] RISC-V: KVM: Return correct code for hsm stop
 function
Message-ID: <20230112102839.rsabb2bah5lkkx4e@orel>
References: <20221215170046.2010255-1-atishp@rivosinc.com>
 <20221215170046.2010255-4-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215170046.2010255-4-atishp@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 09:00:38AM -0800, Atish Patra wrote:
> According to the SBI specification, the stop function can only
> return error code SBI_ERR_FAILED. However, currently it returns
> -EINVAL which will be mapped SBI_ERR_INVALID_PARAM.

I presume the mapping referred to here is kvm_linux_err_map_sbi().
If so, then -EPERM isn't correct either. That maps to SBI_ERR_DENIED.
The only thing that will ensure we get SBI_ERR_FAILURE (-1) is
anything not handled by the kvm_linux_err_map_sbi switch, as we
need to use the default.

Thanks,
drew

> 
> Return the appropriate linux error code.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/kvm/vcpu_sbi_hsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kvm/vcpu_sbi_hsm.c b/arch/riscv/kvm/vcpu_sbi_hsm.c
> index 2e915ca..0f8d9fe 100644
> --- a/arch/riscv/kvm/vcpu_sbi_hsm.c
> +++ b/arch/riscv/kvm/vcpu_sbi_hsm.c
> @@ -42,7 +42,7 @@ static int kvm_sbi_hsm_vcpu_start(struct kvm_vcpu *vcpu)
>  static int kvm_sbi_hsm_vcpu_stop(struct kvm_vcpu *vcpu)
>  {
>  	if (vcpu->arch.power_off)
> -		return -EINVAL;
> +		return -EPERM;
>  
>  	kvm_riscv_vcpu_power_off(vcpu);
>  
> -- 
> 2.25.1
> 
