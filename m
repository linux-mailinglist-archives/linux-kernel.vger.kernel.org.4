Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2B55F684B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiJFNhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiJFNhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:37:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A24A99DE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 06:37:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id qw20so3998644ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 06:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=1KBtCQA+POVQgcSO7IcdkKbJOYcYsiANOuZ7mA7FU3A=;
        b=LsdhIKdvpjq+E2RQuOWZxicWS6QGeHaNtfNH1k/a6CWDS9JJyNkIMmqwaybdEfF1nn
         onH6NfXu/Z1KePjmeteD0pzhTtNBZQfoTMDzLsHNsd9aT+MNLcR5Vu8lHKySLVmgi8Yi
         rvAPCS+izjGHM/0D9VUU4/0fHvdB/npA4/RqzUgwKt0jO9xaCM01OPR94dudpkE/yhIM
         u5/kRXswkHYZ4MNHHqc5SqP1xEsRls/SHH2yZ6/SW7RKg5A5YO1mHTXGsnyVdohXopO0
         1n8E7Wdjc0hjXChB0PDXf93t/7S8MgtQxcICj+QfnAPoFP87/757+uvS4EMpKu/IIGVy
         DCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1KBtCQA+POVQgcSO7IcdkKbJOYcYsiANOuZ7mA7FU3A=;
        b=wKbYEr84IGN+dt+JP+s4TdHpj5K+dAgkJi0DnqjLkV+1mOKt0EXeE33hloWKer+32E
         RMw9KdUxzUdHjKSMqAIVNf9udU6sS2oker9djr3LppMF03JV+ZyuuD5kX2CWlAVMUJOq
         nas8jFkvZbIgGjaA4LkUKdovbDM/7x0dam2xZ4pASvnI3oxwZX19eW+/HKM59nlucLEm
         N2IaBHpZLmRS7f7m4JziqUP6DY+VSUQK8PoIE+JWR3eHr/FXmAmVvelRCvGpVItxiAud
         CemvmMtG1D5tDWyrk+hFAj5czXfmS1BjPdqYsN7XjG2tEgJNpAQ808F2Ko9mEilsFM0Q
         yx7w==
X-Gm-Message-State: ACrzQf08g6WgiU4R0BW44ehLtqcfYA26edh5oOqx2Ro2/mEnq6S1DM7f
        lHzp40K/waPZXTWKjrHQz4Iiog==
X-Google-Smtp-Source: AMsMyM7bnqMp+6Vd29aCm00f0CbgnkbIiZIM7a9RaRs+fmZ/teSS89vbvnwFen2XQsfYICJluA5tLA==
X-Received: by 2002:a17:906:8453:b0:78d:4893:fede with SMTP id e19-20020a170906845300b0078d4893fedemr1346086ejy.637.1665063449792;
        Thu, 06 Oct 2022 06:37:29 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id z10-20020a50eb4a000000b0044e01e2533asm5901815edp.43.2022.10.06.06.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:37:29 -0700 (PDT)
Date:   Thu, 6 Oct 2022 15:37:28 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] riscv: cpu_relax: switch to
 riscv_has_extension_likely()
Message-ID: <20221006133728.4ge3pmcm7mvksia7@kamzik>
References: <20221006070818.3616-1-jszhang@kernel.org>
 <20221006070818.3616-8-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006070818.3616-8-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 03:08:17PM +0800, Jisheng Zhang wrote:
> Switch cpu_relax() from statich branch to the new helper
> riscv_has_extension_likely()
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/vdso/processor.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include/asm/vdso/processor.h
> index 1e4f8b4aef79..fb30480f36a0 100644
> --- a/arch/riscv/include/asm/vdso/processor.h
> +++ b/arch/riscv/include/asm/vdso/processor.h
> @@ -10,7 +10,7 @@
>  
>  static inline void cpu_relax(void)
>  {
> -	if (!static_branch_likely(&riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_ZIHINTPAUSE])) {
> +	if (!riscv_has_extension_likely(RISCV_ISA_EXT_ZIHINTPAUSE)) {
>  #ifdef __riscv_muldiv
>  		int dummy;
>  		/* In lieu of a halt instruction, induce a long-latency stall. */
> -- 
> 2.37.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
