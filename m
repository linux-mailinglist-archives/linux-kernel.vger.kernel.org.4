Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7809A70FE1F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 21:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjEXTAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 15:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEXTAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 15:00:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A209F119
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 12:00:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34CC463807
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 19:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BDDC433EF;
        Wed, 24 May 2023 19:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684954811;
        bh=xfARP3XwE0LoO4NFR5VnnXwiMlIzDx5sfYJ5uWQsEDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m5wc+luk1casXK1c7CCiClqhS++lIUNQglRVbpV6CnWollgCDKLqkAPu+1G6k031W
         bUWIwMajVtI2uXzzvo5JKBkAkOnQcYhI8bxtBqweyp0PsoxClkCvJuX+rqS9Ut6p6g
         9P72zkNDvKow0Z+tmKi9oYZnUk9jv8y8k90ebiu0ODNt08hZjrlVXNhDGW01FmjtVk
         1d7FZgDlwrVRFrj8ZNp7KwRuSxSHD0q3WFO/+y/40R+rDvAfbVsdKbHFD/fryFhaJz
         BPL67NKdvr2IwJL5LVnOuA+IFSR9Vv8IbaRT5gDuu0b6cxMt5zhUL4jzUSLAhLCTa5
         k/6eBDXREegmg==
Date:   Wed, 24 May 2023 21:59:49 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        damon@lists.linux.dev
Subject: Re: [PATCH v2 3/5] mm: Fix failure to unmap pte on highmem systems
Message-ID: <20230524185949.GQ4967@kernel.org>
References: <20230518110727.2106156-1-ryan.roberts@arm.com>
 <20230518110727.2106156-4-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518110727.2106156-4-ryan.roberts@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 12:07:25PM +0100, Ryan Roberts wrote:
> The loser of a race to service a pte for a device private entry in the
> swap path previously unlocked the ptl, but failed to unmap the pte. This
> only affects highmem systems since unmapping a pte is a noop on
> non-highmem systems.
> 
> Fixes: 16ce101db85d ("mm/memory.c: fix race when faulting a device private page")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/memory.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index f69fbc251198..ed429e20a1bb 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3728,10 +3728,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  			vmf->page = pfn_swap_entry_to_page(entry);
>  			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>  					vmf->address, &vmf->ptl);
> -			if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
> -				spin_unlock(vmf->ptl);
> -				goto out;
> -			}
> +			if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte)))
> +				goto unlock;
>  
>  			/*
>  			 * Get a page reference while we know the page can't be
> -- 
> 2.25.1
> 
> 

-- 
Sincerely yours,
Mike.
