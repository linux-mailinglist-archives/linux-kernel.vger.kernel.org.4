Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5170667A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240598AbjALP5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjALP4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:56:41 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E405F83
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:47:07 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id v30so27374692edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=touwoPoiYZf0HhlEwi8bPQAghKKkIn4o576UC3VAJig=;
        b=Y7UoxZEpqnNjH0C9dutC6Y5LH1YueEA7ar7GIXTHlsjyRJ1sQpJtfyBFGYZZ0+I62Z
         9eTjvcW9vrhwTGHfni2BokqqH/0aQEat3j0uzP2TfbaEwjeBuOGoDCUQlmeA4FkZ+ewt
         meVWwzqwaN/2To9Bls79seggrsSl5K8RyhUL27PyWuJ7fUbMscS7CW5OERw9WTa/Ze99
         R99lWv2BngR25eDhMzpt4vvtuXuNlya7pJ998yVIWOjpAq9szC6mqV6DYPWlsR0D0SYu
         ysMrm5D/chxmdZmDr6sOiiMJjeqm0JXxL9A2SAW52cz4uN1tcoaqzvnuI1zyPOuRC9Gy
         BNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=touwoPoiYZf0HhlEwi8bPQAghKKkIn4o576UC3VAJig=;
        b=bpe/KIagColsXzqfllHI99Y5M/cmiaIP9laoiUhnVmo7x4BC3E9Tf5JChKPRdP73Qo
         ECQRcLxuqwaSw9go57SFYeWRxuCqe3mfbVStOfBImIDnxE1J1zAe9f0cKSMeWM4cBKiz
         TP5TcgkMR/LV5GdojtD6D676Ir6VQHVBCqiZlgYNwEIBhcVyySPKtXh5Nq1l55x9rHLi
         vITMZj9ciqey+/0sG7LLuQBBIGvnMS0MiErDuii1ad+cKPtcdyXYtYmUycHuYzDPjHS/
         AVA3hpBjbNnL868gMSjzLkxGWAkYJeySnaDgD9y8T2VSMs6JjNWJh8bpyYoCOBFrNnY3
         Uw6Q==
X-Gm-Message-State: AFqh2kpP1Snryc+ajymOosmdLVTANYhhNdSC46rgZVs5vVwKqP29i7AU
        cgpoIvUqwQQFYbfGwHwzWb7S1Q==
X-Google-Smtp-Source: AMrXdXssM3QKtx3x/hfO1hFv0f1b7bDY5i5kFJO302k1BGtRn7sQ9lO5PV+s3tuqXmOqb6biVLRgvw==
X-Received: by 2002:a05:6402:d55:b0:499:c294:77b6 with SMTP id ec21-20020a0564020d5500b00499c29477b6mr9702559edb.9.1673538426017;
        Thu, 12 Jan 2023 07:47:06 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id fd7-20020a056402388700b00483dd234ac6sm7119348edb.96.2023.01.12.07.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:47:05 -0800 (PST)
Date:   Thu, 12 Jan 2023 16:47:04 +0100
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
Subject: Re: [PATCH v2 08/11] RISC-V: KVM: Disable all hpmcounter access for
 VS/VU mode
Message-ID: <20230112154704.x6ml27hnsxh25my2@orel>
References: <20221215170046.2010255-1-atishp@rivosinc.com>
 <20221215170046.2010255-9-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215170046.2010255-9-atishp@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 09:00:43AM -0800, Atish Patra wrote:
> Any guest must not get access to any hpmcounter including cycle/instret
> without any checks. We achieve that by disabling all the bits except TM
> bit in hcountern.

hcounteren

> 
> However, instret and cycle access for guest userspace can be enabled
> upon explicit request (via ONE REG) or on first trap from VU mode
> to maintain ABI requirement in the future. This patch doesn't support
> that as ONE REG inteface is not settled yet.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/kvm/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index 58c5489..9c2efd3 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -49,7 +49,8 @@ int kvm_arch_hardware_enable(void)
>  	hideleg |= (1UL << IRQ_VS_EXT);
>  	csr_write(CSR_HIDELEG, hideleg);
>  
> -	csr_write(CSR_HCOUNTEREN, -1UL);
> +	/* VS should access only TM bit. Everything else should trap */

s/TM bit/the time counter/

> +	csr_write(CSR_HCOUNTEREN, 0x02);
>  
>  	csr_write(CSR_HVIP, 0);
>  
> -- 
> 2.25.1
> 

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
