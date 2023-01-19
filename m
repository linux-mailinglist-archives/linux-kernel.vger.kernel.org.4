Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC8A6733F6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjASIpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjASIpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:45:38 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B994E66FB8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 00:45:37 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id v5so1982441edc.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 00:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MetS4zEUaxTfPd/u3Ip9L5fgpunrgvS3jQ8pBOXt1mM=;
        b=PP4FgTsOX7M7u20b3L0El1yV5cE65Y86ooftaSLBpFPeygfOBLHIFCEch+eqAzHbFB
         5r0a/kFOb8+5d+yu2OKxVCujxhqNuLnmyCFaAAd4NyNUpRK36cBTvSVcidxbwUtOgySf
         xj2wcJ5VQSlf6Vx0E0DCZdtAo/ySP8fWsI+kF1jeGt7GP7FtwiTKqoe2fKK1DFG5FL+b
         UGKgfmyHdXDLSqsxVXbRonqHuXFo9rtSj607TajE1MU9StjF3BsitnybzgVBUMfjpeZn
         0GPQSuryTGCAABSm7vZJgi56f2oc3MR6L56nwBqq4SLkfmOtXDTTiye53dw78LDPG0RL
         9Ocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MetS4zEUaxTfPd/u3Ip9L5fgpunrgvS3jQ8pBOXt1mM=;
        b=brtmxoYUenjDGydE5jZssrxCC0vKiFpli+xLiwE+D+MpeaTamEuXUPQx83x+IV1y4i
         SxFk/iV+8JTIjdvvcYW8sGUhLbJZWAEcgkIUgtCmluvSj0HC7eb7S9hV5wAdym2JkykF
         GFizzkE9OEEIYjexd4gsZ8qOE5HGzGHvLRvnZpvgpxZevvu5r4BDTQ5IThNa+xVKihut
         hXnZV696bPC8APlArnoWXbIfGfzUzeBhG5JTKfIqgYZ5o8T4b9Ap28D4iI4+O0W3NgH/
         Yba2iFeQsDOnY0DIx2gm12UP/nZNvtDx6zC77otLUftV2ZC98uesA1PnhxV80wiSpDGT
         Sr8w==
X-Gm-Message-State: AFqh2koOLGjaLQAN+EdyHWzA5E9fMRwOH2O0RUsnrmRH2N6iBMvCd5Qe
        vlgSE0rZx4lN4Wfmx3lvLXCisfzmR1opkTIH
X-Google-Smtp-Source: AMrXdXs2xG8hVYhIa1aU3CZbotbYriwT0Cnx4/lLKT7ZPgtBxrr5nbaBghkK/Mu1CsMf1UZNzrngLw==
X-Received: by 2002:a05:6402:1ccc:b0:49c:fdd2:a47d with SMTP id ds12-20020a0564021ccc00b0049cfdd2a47dmr12308104edb.37.1674117936369;
        Thu, 19 Jan 2023 00:45:36 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id eo9-20020a056402530900b00463bc1ddc76sm7520001edb.28.2023.01.19.00.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 00:45:36 -0800 (PST)
Date:   Thu, 19 Jan 2023 09:45:34 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: alternative: proceed one more instruction for
 auipc/jalr pair
Message-ID: <20230119084534.v3asjioao2zyvpje@orel>
References: <20230115162811.3146-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230115162811.3146-1-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 12:28:11AM +0800, Jisheng Zhang wrote:
> If we patched auipc + jalr pair, we'd better proceed one more
> instruction. Andrew pointed out "There's not a problem now, since
> we're only adding a fixup for jal, not jalr, but we should
> future-proof this and there's no reason to revisit an already fixed-up
> instruction anyway."
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/kernel/alternative.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
> index fc341b69bf62..2354c69dc7d1 100644
> --- a/arch/riscv/kernel/alternative.c
> +++ b/arch/riscv/kernel/alternative.c
> @@ -122,6 +122,7 @@ void riscv_alternative_fix_offsets(void *alt_ptr, unsigned int len,
>  
>  			riscv_alternative_fix_auipc_jalr(alt_ptr + i * sizeof(u32),
>  							 insn, insn2, patch_offset);
> +			i++;
>  		}
>  
>  		if (riscv_insn_is_jal(insn)) {
> -- 
> 2.38.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
