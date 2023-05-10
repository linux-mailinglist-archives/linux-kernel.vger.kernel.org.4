Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44936FD91B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbjEJIV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjEJIVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:21:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8DB171B;
        Wed, 10 May 2023 01:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1WZCLagr9yk4Cbp+6qSxxsSMmqvOctxqT3bVkNGFhnY=; b=CzmDvf3rqlZoWLTgd3FVOKNA13
        am3KRsvw5dx0zZtORpSkeQixmHm2I0T/j68VXo57hz3B2sKfsZlkzT6mcIfsGM8QExy3tEBmFQg15
        5knvERiYGPZKMBkmsOAK/iQ/5rtOFvAqMTYH7nFMXqdqWWfvmHjqNDYraw79BjtqAXxEKvC5IXPLi
        v4WkUXSf6SdYO2DxNqGoNj/9jzwXI/RVqLwvIK8H89K9xhFYfEkKkPofOod7rLsPcDYQd4FB4I+bb
        ncPfZdYjPCu8FZ1ut2ZqCkZjLMrUhqEHRkvEROX3xUgFItRMwb3mnY6amim7reKFoxZZ2cjlGh5hD
        cm+pskqQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pwf2E-007PM8-2r;
        Wed, 10 May 2023 08:20:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4DA20300338;
        Wed, 10 May 2023 10:18:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2369E20B04BA2; Wed, 10 May 2023 10:18:48 +0200 (CEST)
Date:   Wed, 10 May 2023 10:18:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 21/23] x86: Allow get_locked_pte() to fail
Message-ID: <20230510081848.GD83892@hirez.programming.kicks-ass.net>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
 <eba2b72f-2180-498b-c8bd-ce8f717fc78a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eba2b72f-2180-498b-c8bd-ce8f717fc78a@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 10:08:37PM -0700, Hugh Dickins wrote:
> In rare transient cases, not yet made possible, pte_offset_map() and
> pte_offset_map_lock() may not find a page table: handle appropriately.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  arch/x86/kernel/ldt.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
> index 525876e7b9f4..eb844549cd83 100644
> --- a/arch/x86/kernel/ldt.c
> +++ b/arch/x86/kernel/ldt.c
> @@ -367,8 +367,10 @@ static void unmap_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt)
>  
>  		va = (unsigned long)ldt_slot_va(ldt->slot) + offset;
>  		ptep = get_locked_pte(mm, va, &ptl);
> -		pte_clear(mm, va, ptep);
> -		pte_unmap_unlock(ptep, ptl);
> +		if (ptep) {
> +			pte_clear(mm, va, ptep);
> +			pte_unmap_unlock(ptep, ptl);
> +		}
>  	}

Ow geez, now I have to go remember how the whole PTI/LDT crud worked :/

At first glance this seems wrong; we can't just not unmap the LDT if we
can't find it in a hurry. Also, IIRC this isn't in fact a regular user
mapping, so it should not be subject to THP induced seizures.

... memory bubbles back ... for PTI kernels we need to map this in the
user and kernel page-tables because obviously userspace needs to be able
to have access to the LDT. But it is not directly acessible by
userspace. It lives in the cpu_entry_area as a virtual map of the real
kernel allocation, and this virtual address is used for LLDT.
Modification is done through sys_modify_ldt().

I think I would feel much better if this were something like:

	if (!WARN_ON_ONCE(!ptep))

This really shouldn't fail and if it does, simply skipping it isn't the
right thing either.
