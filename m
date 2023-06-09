Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B2E72A414
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjFIUGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjFIUGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:06:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849C33A82
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:06:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19298659DE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 20:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB81C433EF;
        Fri,  9 Jun 2023 20:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686341194;
        bh=I5eLjVvS0j4LRy8nwugVLv1qLrwPGv6yABwGuRiB+w0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YqaO5bl3XEMwtnhnotlvPEAgrU3xEt9NSz3dEe6LUBbD5J9rBClfs1UXqaQl2jASA
         zYO51MdN9A0kxbg86I8m8gM5BK/nbJMwoet5nWMDR+21lql3f94v2/WBHXsb8Mt6qt
         PnnuYVV0groHs6ywW6cwCI8pR/xRA4fJ9J0LVYuw=
Date:   Fri, 9 Jun 2023 13:06:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 28/32] mm/memory: allow pte_offset_map[_lock]() to
 fail
Message-Id: <20230609130632.ec6ffe72fc5f7952af4a3e54@linux-foundation.org>
In-Reply-To: <bb548d50-e99a-f29e-eab1-a43bef2a1287@google.com>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
        <bb548d50-e99a-f29e-eab1-a43bef2a1287@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2023 18:43:38 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> copy_pte_range(): use pte_offset_map_nolock(), and allow for it to fail;
> but with a comment on some further assumptions that are being made there.
> 
> zap_pte_range() and zap_pmd_range(): adjust their interaction so that
> a pte_offset_map_lock() failure in zap_pte_range() leads to a retry in
> zap_pmd_range(); remove call to pmd_none_or_trans_huge_or_clear_bad().
> 
> Allow pte_offset_map_lock() to fail in many functions.  Update comment
> on calling pte_alloc() in do_anonymous_page().  Remove redundant calls
> to pmd_trans_unstable(), pmd_devmap_trans_unstable(), pmd_none() and
> pmd_bad(); but leave pmd_none_or_clear_bad() calls in free_pmd_range()
> and copy_pmd_range(), those do simplify the next level down.
> 
> ...
>
> @@ -3728,11 +3737,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  			vmf->page = pfn_swap_entry_to_page(entry);
>  			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>  					vmf->address, &vmf->ptl);
> -			if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
> -				spin_unlock(vmf->ptl);
> -				goto out;
> -			}
> -
> +			if (unlikely(!vmf->pte ||
> +				     !pte_same(*vmf->pte, vmf->orig_pte)))
> +				goto unlock;
>  			/*
>  			 * Get a page reference while we know the page can't be
>  			 * freed.

This hunk falls afoul of
https://lkml.kernel.org/r/20230602092949.545577-5-ryan.roberts@arm.com.

I did this:

@@ -3729,7 +3738,8 @@ vm_fault_t do_swap_page(struct vm_fault
 			vmf->page = pfn_swap_entry_to_page(entry);
 			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 					vmf->address, &vmf->ptl);
-			if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte)))
+			if (unlikely(!vmf->pte ||
+				     !pte_same(*vmf->pte, vmf->orig_pte)))
 				goto unlock;
 
 			/*

