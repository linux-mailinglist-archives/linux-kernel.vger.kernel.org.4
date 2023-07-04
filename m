Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBC874694D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjGDGBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGDGBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:01:10 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6B0E52
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 23:01:09 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51d9bf5411aso5842407a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 23:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688450468; x=1691042468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nl9gTJEQlp1epsps/bWt1kzzLQTu7OGXe4NvbD2+dJU=;
        b=C+63iSwAWL2QEv0vXOTtpkTpOzgfgDV8ArF5AQ98M1x0FpUFDjwYxEkTSpOLpEZDTz
         lv5BozU1lxxx9H6vVvEOm8YKdTyb/wg/78/5TRW+J24ix/xuhXIZwSkkoDmbiot/4cr0
         QCyIyGYVokfAlzaHFR6DwmaVJRRSCKFe6BGuca/G8BawV01HkxYVpjJUSkVrk0c2mtD9
         tln2SulLzmzn0G3Psk4yJSliN82FGCwckLBBrKrthFxAkln4Zj9cLUX78weHlfkzIY8I
         SI/HaWTYJrNHfzbs2EE/jhilLXaCsjxKdB3Cg1syg7rz/aBBQiX/BI+dn9npt/2cmNQD
         8GxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688450468; x=1691042468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nl9gTJEQlp1epsps/bWt1kzzLQTu7OGXe4NvbD2+dJU=;
        b=XQRlXQg88psQLgbD/WqtnIYen71qlrNzt20RBUr18GjzTriq2LfLK68a4lRQuDIyCd
         bAiU1HLk6SYNLSenrxMICAfMbDDa/56BbcP9VVMrFxOMg69d3nyO/g5On0kSUbbEKWF5
         SxB+a9xR8uIdHmAO2VC/28heHkI+Qp3k3P6yOIxHRSo1341mq2FeyCgxn6pXbYMo4GPx
         cuKUqP4kIRKp4g1wN1aTCr4Q9knVlJZXsOGI03btiRkZbcQfYy5iIc9tJlFDs67rQjXH
         arySi02mHDF0yQUPvr6Li8qvalBEbOCJjI5/YweZOoDA9uvXugtDmI9jq/1EItqtj7rG
         UV3Q==
X-Gm-Message-State: ABy/qLa+/A0MoRBQjOF3Ew/iez5/GR7s1udgjKnFccNcDZ7yI5CB+LKJ
        LFxg5WHZMFiJXt5EsJqdkRqP+Q==
X-Google-Smtp-Source: APBJJlHQg2PkEmmcSnTVZtihp1VqBSr2PqMhFlzgoDfMBKwN+COmCPeIF8RS9L6pzXrtBhJgf77Q/w==
X-Received: by 2002:a17:906:74e:b0:992:3aa8:b21 with SMTP id z14-20020a170906074e00b009923aa80b21mr8972282ejb.25.1688450468186;
        Mon, 03 Jul 2023 23:01:08 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id i26-20020a1709063c5a00b00991d54db2acsm10381224ejg.44.2023.07.03.23.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 23:01:07 -0700 (PDT)
Date:   Tue, 4 Jul 2023 08:01:06 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Hugh Dickins <hughd@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        James Houghton <jthoughton@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH] mm: riscv: fix an unsafe pte read in huge_pte_alloc()
Message-ID: <20230704-f273e5ba6c440dff03d07101@orel>
References: <20230703190044.311730-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703190044.311730-1-jhubbard@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 12:00:44PM -0700, John Hubbard wrote:
> The WARN_ON_ONCE() statement in riscv's huge_pte_alloc() is susceptible
> to false positives, because the pte is read twice at the C language
> level, locklessly, within the same conditional statement. Depending on
> compiler behavior, this can lead to generated machine code that actually
> reads the pte just once, or twice. Reading twice will expose the code to
> changing pte values and cause incorrect behavior.
> 
> In [1], similar code actually caused a kernel crash on 64-bit x86, when
> using clang to build the kernel, but only after the conversion from *pte
> reads, to ptep_get(pte). The latter uses READ_ONCE(), which forced a
> double read of *pte.
> 
> Rather than waiting for the upcoming ptep_get() conversion, just convert
> this part of the code now, but in a way that avoids the above problem:
> take a single snapshot of the pte before using it in the WARN
> conditional.
> 
> As expected, this preparatory step does not actually change the
> generated code ("make mm/hugetlbpage.s"), on riscv64, when using a gcc
> 12.2 cross compiler.
> 
> [1] https://lore.kernel.org/20230630013203.1955064-1-jhubbard@nvidia.com
> 
> Suggested-by: James Houghton <jthoughton@google.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  arch/riscv/mm/hugetlbpage.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
> index 542883b3b49b..96225a8533ad 100644
> --- a/arch/riscv/mm/hugetlbpage.c
> +++ b/arch/riscv/mm/hugetlbpage.c
> @@ -73,7 +73,11 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
>  	}
>  
>  out:
> -	WARN_ON_ONCE(pte && pte_present(*pte) && !pte_huge(*pte));
> +	if (pte) {
> +		pte_t pteval = ptep_get_lockless(pte);

I think ptep_get_lockless() on riscv (even riscv32) will always just be
ptep_get(), since pte_t is unsigned long, which can be read atomically.

> +
> +		WARN_ON_ONCE(pte_present(pteval) && !pte_huge(pteval));

Ensuring we only read the pte once is good though.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew


> +	}
>  	return pte;
>  }
>  
> 
> base-commit: 0a8d6c9c7128a93689fba384cdd7f72b0ce19abd
> -- 
> 2.41.0
> 
