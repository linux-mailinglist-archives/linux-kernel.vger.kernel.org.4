Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3256D887C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbjDEU2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbjDEU1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:27:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE4A76A5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 13:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Rp1vsSz2rb49nidUrcuZPQSFo9FctViDmHV3m59FGQw=; b=D6bVZ+EjFDeh7bEdhFvwo2HPUm
        DMN/cQUuDsKxgwM4Uf5jrvAaVbcI5+E9J8kxiQjAwEnjonhrqg+dHUEnOHPE6FnWrX9Lj0d8Amv81
        WInen6+5ifp5jozSCmrzNN5H263HFJXZhxutBDwNbMgLuu6fd7wiD+wi2KQRahwx//f7GkIIBICee
        VmtKXwZFdGiro+bdA5UeQjyTGiuBNOMsoPJ1seb6cNjIGLbU1HlG8HyMzAK2g61MjbJ/5ou9y+9e3
        IPAKALU3/gpUw6W/q/ayByDUbTHf9NllqgdF0drw09vlwZLbKUgf8pVFkVkh7FoNP01f0cSzEy48C
        4E2Iz6lA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pk9ij-00A4v8-1u;
        Wed, 05 Apr 2023 20:27:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C012E300202;
        Wed,  5 Apr 2023 22:27:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A79A127985546; Wed,  5 Apr 2023 22:27:04 +0200 (CEST)
Date:   Wed, 5 Apr 2023 22:27:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, vincent.guittot@linaro.org, jon.grimm@amd.com,
        bharata@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 9/9] x86/clear_huge_page: make clear_contig_region()
 preemptible
Message-ID: <20230405202704.GF365912@hirez.programming.kicks-ass.net>
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
 <20230403052233.1880567-10-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403052233.1880567-10-ankur.a.arora@oracle.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 10:22:33PM -0700, Ankur Arora wrote:
> clear_contig_region() can be used to clear up to a huge-page (2MB/1GB)
> chunk Allow preemption in the irqentry_exit path to make sure we don't
> hold on to the CPU for an arbitrarily long period.
> 
> Performance: vm-scalability/case-anon-w-seq-hugetlb mmaps an anonymous
> hugetlb-2mb region, and then writes sequentially to the region, demand
> faulting pages on the way.
> 
> This test, with a CONFIG_VOLUNTARY config shows the effects of this
> change: stime drops (~18% on Icelakex, ~5% on Milan), while the utime
> goes up (~15% on Icelakex, ~13% on Milan.)
> 
>   *Icelakex*                  mm/clear_huge_page   x86/clear_huge_page   change
>   (mem=4GB/task, tasks=128)
> 
>   stime                           293.02 +- .49%        239.39 +- .83%   -18.30%
>   utime                           440.11 +- .28%        508.74 +- .60%   +15.59%
>   wall-clock                        5.96 +- .33%          6.27 +-2.23%   + 5.20%
> 
> 
> 
>   *Milan*                     mm/clear_huge_page   x86/clear_huge_page   change
>   (mem=1GB/task, tasks=512)
> 
>   stime                          490.95 +- 3.55%       466.90 +- 4.79%   - 4.89%
>   utime                          276.43 +- 2.85%       311.97 +- 5.15%   +12.85%
>   wall-clock                       3.74 +- 6.41%         3.58 +- 7.82%   - 4.27%
> 
> The drop in stime is due to REP; STOS being more efficient for bigger
> extents.  The increase in utime is due to cache effects of that change:
> mm/clear_huge_page() clears page-at-a-time, while narrowing towards the
> faulting page; while x86/clear_huge_page only optimizes for cache
> locality in the local neighbourhood of the faulting address.
> 
> This effect on utime is visible via the increased L1-dcache-load-misses
> and LLC-load* and an increased backend boundedness for perf user-stat
> --all-user on Icelakex. The effect is slight but given the heavy cache
> pressure generated by the test, shows up in the drop in user IPC:
> 
>     -  9,455,243,414,829      instructions                     #    2.75  insn per cycle              ( +- 14.14% )  (46.17%)
>     -  2,367,920,864,112      L1-dcache-loads                  #    1.054 G/sec                       ( +- 14.14% )  (69.24%)
>     -     42,075,182,813      L1-dcache-load-misses            #    2.96% of all L1-dcache accesses   ( +- 14.14% )  (69.24%)
>     -         20,365,688      LLC-loads                        #    9.064 K/sec                       ( +- 13.98% )  (69.24%)
>     -            890,382      LLC-load-misses                  #    7.18% of all LL-cache accesses    ( +- 14.91% )  (69.24%)
> 
>     +  9,467,796,660,698      instructions                     #    2.37  insn per cycle              ( +- 14.14% )  (46.16%)
>     +  2,369,973,307,561      L1-dcache-loads                  #    1.027 G/sec                       ( +- 14.14% )  (69.24%)
>     +     42,155,621,201      L1-dcache-load-misses            #    2.96% of all L1-dcache accesses   ( +- 14.14% )  (69.24%)
>     +         22,116,300      LLC-loads                        #    9.588 K/sec                       ( +- 14.20% )  (69.24%)
>     +          1,355,607      LLC-load-misses                  #   10.29% of all LL-cache accesses    ( +- 15.49% )  (69.25%)
> 
> Given the fact that the stime improves for all loads using this path,
> while the utime drop is load dependent add this change.

Either I really need sleep, or *NONE* of the above is actually relevant
to what the patch below actually does!

The above talks about the glories of using large clears, while the patch
allows reschedules which are about latency.

> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  arch/x86/mm/hugetlbpage.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
> index 4294b77c4f18..c8564b0552e5 100644
> --- a/arch/x86/mm/hugetlbpage.c
> +++ b/arch/x86/mm/hugetlbpage.c
> @@ -158,7 +158,17 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>  static void clear_contig_region(struct page *page, unsigned long vaddr,
>  				unsigned int npages)
>  {
> +	might_sleep();
> +
> +	/*
> +	 * We might be clearing a large region.
> +	 * Allow rescheduling.
> +	 */
> +	allow_resched();
>  	clear_user_pages(page_address(page), vaddr, page, npages);
> +	disallow_resched();
> +
> +	cond_resched();
>  }
>  
>  void clear_huge_page(struct page *page,
> -- 
> 2.31.1
> 
