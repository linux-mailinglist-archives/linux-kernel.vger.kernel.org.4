Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C85669A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjAMOdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjAMOcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:32:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296802DDD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lZ2zHRVtRuDz4SYlt/Zs3M9lTXrjN27bEpPx9owSDqs=; b=QDUKC0CyMRKg9WggcYRD51Tffm
        mdO9IqNwyevHpGZg/MSewgV9rxX8fn6Asior+lKkiYfn9zr5lhEbvMIDMfrgw5l1chjE1DOWqcJuV
        oV931nGyxJXJj9q4JWZM3l5aUQ9UjBbV20fOXbC/yNKLH7FaqEZbbCz5hqr6ti+3PYMxSAqJQFREQ
        p5AcdJ5X37762m4rx/Ldbr+oc0Dl/Kde4a3vwlLI6a/qnIwQAPSr3wdMMjkZ6GUscsfnZorpy2tgJ
        QiYQlmVS182iBZMqnt8F7IbJjMzWlV8GnulbMzDrgumBzLZfT1MHxm4aeDIFrn/E66W5PcZ/vx1Ft
        ywnSsQmA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGKzx-006AIQ-8y; Fri, 13 Jan 2023 14:25:37 +0000
Date:   Fri, 13 Jan 2023 14:25:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 1/7] mm: huge_memory: make
 __do_huge_pmd_anonymous_page() to take a folio
Message-ID: <Y8Fp4UBvO/i8/PYf@casper.infradead.org>
References: <20230112083006.163393-1-wangkefeng.wang@huawei.com>
 <20230112083006.163393-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112083006.163393-2-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 04:30:00PM +0800, Kefeng Wang wrote:
> Let's __do_huge_pmd_anonymous_page() take a folio and convert related
> functions to use folios.

No, this is actively wrong!  Andrew, please drop this patch.

If we want to support folio sizes larger than PMD size (and I think we
do), we need to be able to specify precisely which page in the folio
is to be stored at this PTE.  The *interface* must remain struct page.
We can convert from page to folio within the function, but we *MUST NOT*
go the other way.

>  static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
> -			struct page *page, gfp_t gfp)
> +			struct folio *folio, gfp_t gfp)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
> +	struct page *page = &folio->page;

... ie this is bad and wrong.

> @@ -834,7 +835,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>  		count_vm_event(THP_FAULT_FALLBACK);
>  		return VM_FAULT_FALLBACK;
>  	}
> -	return __do_huge_pmd_anonymous_page(vmf, &folio->page, gfp);
> +	return __do_huge_pmd_anonymous_page(vmf, folio, gfp);
>  }
>  
>  static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,

A reasonable person might ask "But Matthew, you allocated a folio here,
then you're converting back to a struct page to call
__do_huge_pmd_anonymous_page() so isn't this a sensible patch?"

And I would say "still no".  This is a question of interfaces, and
even though __do_huge_pmd_anonymous_page() is static and has precisely
one caller today that always allocates a folio of precisely PMD size,
I suspect it will need to be more visible in the future and the
conversion of the interface from page to folio misleads people.
