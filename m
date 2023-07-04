Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B402746A4A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjGDHGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjGDHGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:06:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9324FFB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:06:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 417272F4;
        Tue,  4 Jul 2023 00:07:30 -0700 (PDT)
Received: from [10.57.76.103] (unknown [10.57.76.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 574903F762;
        Tue,  4 Jul 2023 00:06:45 -0700 (PDT)
Message-ID: <82d3332e-beff-85ff-c1fd-0d46345b69b5@arm.com>
Date:   Tue, 4 Jul 2023 08:06:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] mm: riscv: fix an unsafe pte read in huge_pte_alloc()
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Hugh Dickins <hughd@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        James Houghton <jthoughton@google.com>
References: <20230703190044.311730-1-jhubbard@nvidia.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230703190044.311730-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2023 20:00, John Hubbard wrote:
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

I'm not sure there is any upcoming ptep_get() conversion for riscv? Not from me
at least - my focus was on the generic code to suficiently encapsulate it as an
enabler for some follow on arm64 changes.

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

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

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
> +
> +		WARN_ON_ONCE(pte_present(pteval) && !pte_huge(pteval));
> +	}
>  	return pte;
>  }
>  
> 
> base-commit: 0a8d6c9c7128a93689fba384cdd7f72b0ce19abd

