Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6DD5F6849
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJFNhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiJFNhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:37:00 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F19AA3F4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 06:36:59 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id a13so2905381edj.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 06:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=DZoJlUHmQo7sC5JniZgyDQJ0wSD+jVGoLhaBhI1aGrY=;
        b=VrDqkwCw5gUn3mEQeJpu9dZ6AF1IXGZyviXwZK0a0SBl8C3saY78DBhb/NdOBGw77D
         sioORUtf+ZoAvGawjjvFeAr50qIikDof/HLUpqsqTrCtVa84hHZkd/E0dpQmOvJmsCKg
         qZ9OMEmE/hBTKMJW/rXB9LjDUvMy45qOBk1xsAcIxkP1o1SOlIqrt5LYHaxORiElDwe4
         R9MZ0qz9U5yOptdEaPV/ZihLWb3ludMoViQRvpsVTZslK6Hu73ZRKH1EXmP8DwyIesF7
         oz8lu2coaNvI6Sl0AoAymj5KIn4GobvoY9tgws3Nwugy4Wj5zSaaSmR9MocBH/bPBHRk
         J+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DZoJlUHmQo7sC5JniZgyDQJ0wSD+jVGoLhaBhI1aGrY=;
        b=L6pIea6oIwvQ7X+TGoUCFC8Uwx9ow4iYkIWbXvZPntuIL+aKDjcAh9pOiBHOPVWxkP
         1t/AOrTSm9h784Nu2cWntWb+nehXheMagVjW5YTxjxKSeRXC+sM/MuzvH9wrasPpG39L
         y9ftcpdAfYSjTxL6tjdgPbZ4XSIiy+uEM2X5QlztphYi3VG7b3dM0T2iqMDJcWFzpT5o
         zf9UuXZ2Oa3vF2EE7654XmOWD4UEyZUPO+dzUm/LR2wS9d0Pw7XhxtDMCkkzbsRvru6O
         g1efTSoopz3dOYvqCw5cUyVT5xGTk7otyKRinxf3z2RfZ/5qMxNCJ56jBsvzSOT5sSAA
         sTZg==
X-Gm-Message-State: ACrzQf0JRoTzQvADK79YtNUFFlKGkGX8xINbqfSZ/lo1pFv67KglqgwY
        +FLlTD+xll2fGaFBTYsN6lrI7A==
X-Google-Smtp-Source: AMsMyM4nMOW1IAKp6SZkiuHt6/NehY++eUad8HKnZasoygesNi8fvEa5ilT/pi5mdZrAC6xvW9K3kQ==
X-Received: by 2002:a05:6402:428c:b0:440:8259:7a2b with SMTP id g12-20020a056402428c00b0044082597a2bmr4549032edc.329.1665063417836;
        Thu, 06 Oct 2022 06:36:57 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id e24-20020a17090681d800b0078246b1360csm10146351ejx.225.2022.10.06.06.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:36:57 -0700 (PDT)
Date:   Thu, 6 Oct 2022 15:36:56 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] riscv: fpu: switch has_fpu() to
 riscv_has_extension_likely()
Message-ID: <20221006133656.sdtxrpopvmy6b5mw@kamzik>
References: <20221006070818.3616-1-jszhang@kernel.org>
 <20221006070818.3616-7-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006070818.3616-7-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 03:08:16PM +0800, Jisheng Zhang wrote:
> Switch has_fpu() from statich branch to the new helper
> riscv_has_extension_likely().
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/switch_to.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
> index 11463489fec6..60f8ca01d36e 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -59,7 +59,8 @@ static inline void __switch_to_aux(struct task_struct *prev,
>  
>  static __always_inline bool has_fpu(void)
>  {
> -	return static_branch_likely(&riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_FPU]);
> +	return riscv_has_extension_likely(RISCV_ISA_EXT_f) ||
> +		riscv_has_extension_likely(RISCV_ISA_EXT_d);
>  }
>  #else
>  static __always_inline bool has_fpu(void) { return false; }
> -- 
> 2.37.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
