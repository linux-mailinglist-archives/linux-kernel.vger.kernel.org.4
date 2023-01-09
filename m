Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177476628F6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbjAIOsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbjAIOrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:47:46 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25E91EAC6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 06:45:27 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id z5so7340131wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 06:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f4nomVRoCsc9GUqeoBFhY0eow9fFXNRDDHoKBG0FKZE=;
        b=QizTsEib1Gz7Z0f2WIilfh/uo0XL7bV8O3B/m93vY5xO+Cu6BybzidsT4IiaLsPq72
         vTxaM5IwgxexxggZDy2N3lXdIA8hGBBBQtPnUMmCbaE8OtlkN4tIPC1ptUeH+8e7B4yx
         9Dsz5CPIavu4/OJpB/essGdiRKJvuNxKdgCHlb1jpRL1r548UhG19N3lKsrWEZZ3ppQl
         eRByWUhQ0jp2RXngN09RoLJKEZtermI83T0WR1FSvPp73I2oL4FPL3JEzQyJ2Wn1GAjO
         SGeJxHQmwdRM9P0LITCoYjtHMfSeuva8VgbOvbUwP8miAshCdR8aKoYhyTGeOumdHwrF
         UpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4nomVRoCsc9GUqeoBFhY0eow9fFXNRDDHoKBG0FKZE=;
        b=D8aWJKX6D5hOJC3mufl8Ua/nu32vRnFoWscDrnBfA3X0WtcKYENs3vU42CWcBxwmbg
         ONVOhwObbDVIfGnaJzGb+kEmuk+031P3ZxeGttMKHz8qQtwUHMKzoKciQ998VGHpIstd
         IRelqfenPb2CVkQwWRoS92o+lV3dMDTQYj2TIQYNLRUt5ZAMd0l4NChm5ohwtoz90/QR
         k2MQ3rtFgflIfzzoM6E1j684uUQUEUJZooounh+b3hFi9Vkx2ObUl6jTttOLWyV01AkF
         r5p1VYtjZA4+HWYPmrRBvEV2z9CU5HWTjS+7AcuJOfDxKH6eW0Ae6eAJ013UVCRhiTjS
         A5pw==
X-Gm-Message-State: AFqh2komzgs/xhbCF04pYOaZ7xme8FsDYcXFZgajDDTny8A1xhhQTstN
        ZR5n0p5pmtYL4mX7LcCgh3B20K2rh5DoaPgp
X-Google-Smtp-Source: AMrXdXtWn6KoxGCoYyooVHeOgyDujNEnjFYXv0ZjU8ERf4Z6uznxIyzJfeoYKDUfdssNnxjyp5HV7w==
X-Received: by 2002:adf:f3c9:0:b0:2bb:eb1d:bbb1 with SMTP id g9-20020adff3c9000000b002bbeb1dbbb1mr3064310wrp.7.1673275526508;
        Mon, 09 Jan 2023 06:45:26 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id e10-20020adfe38a000000b002bc7fcf08ddsm1389482wrm.103.2023.01.09.06.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 06:45:26 -0800 (PST)
Date:   Mon, 9 Jan 2023 15:45:25 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com
Subject: Re: [PATCH v2 2/3] RISC-V: mm: Enable huge page support to
 kernel_page_present() function
Message-ID: <20230109144525.4xgnpeb6zcyyvx4j@orel>
References: <20230109062407.3235-1-jeeheng.sia@starfivetech.com>
 <20230109062407.3235-3-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109062407.3235-3-jeeheng.sia@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 02:24:06PM +0800, Sia Jee Heng wrote:
> Currently kernel_page_present() function doesn't support huge page
> detection causes the function to mistakenly return false to the
> hibernation core.
> 
> Add huge page detection to the function to solve the problem.
> 
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> ---
>  arch/riscv/mm/pageattr.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> index 86c56616e5de..73fdec8c0a72 100644
> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -221,14 +221,20 @@ bool kernel_page_present(struct page *page)
>  	p4d = p4d_offset(pgd, addr);
>  	if (!p4d_present(*p4d))
>  		return false;
> +	if (p4d_leaf(*pud))
                      ^ p4d

I guess you got lucky with the stack garbage in your testing.

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

Thanks,
drew
