Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40BF6A02FF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 07:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjBWG52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 01:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjBWG51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 01:57:27 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE13D4A1E9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 22:57:24 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id 6so9405012wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 22:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KD2BbHM42s+qBr4AAb9fqsLLnrBN9ef1lpzrqkSofU8=;
        b=I+KKZ9EwPLLCgyLBn1Nfv7AXEZy2LHfIYVutHsCPPlix2651u56DQIMYSbi1kUNEzJ
         JrB1eBqntxgCvv0LVgGtwAZkb7TU0OynhwmQRhqRw83/cuu7tf+w8ipQ4WPw/BkwjhSd
         y3nER6oRYsi2nnXzJZxVNLzpWa1m41ZWBs6BBfVuxjXo0CSeR0bFW4CSoxOf7atfyo/J
         FaBoHU9LXIcJKBwCX92gv8O99kEFk8Ik3XPSBV49gWZHiGCXXNgkx4z4lqkxEn9TMAk5
         29GFaQz5ggMtjjDooLwmpEgDycRGGb6rFQDFwnJ+MmCGClMf818KrrGyhQc3NlQ2EqEH
         62tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KD2BbHM42s+qBr4AAb9fqsLLnrBN9ef1lpzrqkSofU8=;
        b=Vn1Q5w8IjZQTL2potusB8guewVwhJ7q+Uyr/O3LLlw3IU+sBFXAygue/ry30Lzl3d+
         BGv7LPSKMFT6KgXPa2clv+mAXW/SvEHp6ncmXkZMnfstIq6f9PQSpDj9kBwHWYKE3TEv
         pO51sW/w6Ww4KtfAGM2f8HZf3G0I/b1jEG9+kFTJu/iWfeoxQ0aexVfijYqNQVLEtK6w
         BbatUXRs8RH3sqQQgvLWwfMna/yMAWK2PB/hDx94twKcdMTn5H6YI0FVxHF8UX3c4PTd
         XjKUp6sa1olARaA0AbsxvQh72EfdRMeFtAXQQd25QNPiaqR/ahEhYrcRRZtlihOifptB
         YTUQ==
X-Gm-Message-State: AO0yUKUyrnp995Z6fWRyNth/PyBGL5qIza38PKT1beE0btwqO5HZpb/S
        YYYm8UbcrmU4LXtk+tuuAvWk1A==
X-Google-Smtp-Source: AK7set+Ho9MkNNLGFSCQSbmPjDo0YWzb+lX1SEoWKWu62OlrzVjdAzu7byOiHrA41Htt3R7JCZN6ng==
X-Received: by 2002:a5d:5848:0:b0:2c5:98f2:486 with SMTP id i8-20020a5d5848000000b002c598f20486mr10548278wrf.11.1677135443421;
        Wed, 22 Feb 2023 22:57:23 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id c15-20020adfef4f000000b002c54c9bd71fsm7148700wrp.93.2023.02.22.22.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 22:57:23 -0800 (PST)
Date:   Thu, 23 Feb 2023 07:57:17 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com
Subject: Re: [PATCH v4 3/4] RISC-V: mm: Enable huge page support to
 kernel_page_present() function
Message-ID: <20230223065717.zmlf2gxmtsgqperw@orel>
References: <20230221023523.1498500-1-jeeheng.sia@starfivetech.com>
 <20230221023523.1498500-4-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221023523.1498500-4-jeeheng.sia@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 10:35:22AM +0800, Sia Jee Heng wrote:
> Currently kernel_page_present() function doesn't support huge page
> detection causes the function to mistakenly return false to the
> hibernation core.
> 
> Add huge page detection to the function to solve the problem.
> 
> Fixes tag: commit 9e953cda5cdf ("riscv:
> Introduce huge page support for 32/64bit kernel")

This should be formatted as below (no line wrap and no 'tag' in the tag)

Fixes: 9e953cda5cdf ("riscv: Introduce huge page support for 32/64bit kernel")

> 
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> ---
>  arch/riscv/mm/pageattr.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> index 86c56616e5de..ea3d61de065b 100644
> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -217,18 +217,26 @@ bool kernel_page_present(struct page *page)
>  	pgd = pgd_offset_k(addr);
>  	if (!pgd_present(*pgd))
>  		return false;
> +	if (pgd_leaf(*pgd))
> +		return true;
>  
>  	p4d = p4d_offset(pgd, addr);
>  	if (!p4d_present(*p4d))
>  		return false;
> +	if (p4d_leaf(*p4d))
> +		return true;
>  
>  	pud = pud_offset(p4d, addr);
>  	if (!pud_present(*pud))
>  		return false;
> +	if (pud_leaf(*pud))
> +		return true;
>  
>  	pmd = pmd_offset(pud, addr);
>  	if (!pmd_present(*pmd))
>  		return false;
> +	if (pmd_leaf(*pmd))
> +		return true;
>  
>  	pte = pte_offset_kernel(pmd, addr);
>  	return pte_present(*pte);
> -- 
> 2.34.1
> 
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
