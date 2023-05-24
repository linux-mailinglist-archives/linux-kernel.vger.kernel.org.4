Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C2970FE35
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 21:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjEXTGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 15:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjEXTGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 15:06:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396BC119
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 12:06:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FBC161861
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 19:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7309C433D2;
        Wed, 24 May 2023 19:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684955200;
        bh=GVRc+Sp9w/3xXlBsQVu0Gt2t8xcE/XUdcs2PrknnrIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KhQs1INe6kCzvHfogk+XSvMboZSn/7JsnDgsYzrpLC3uzaY72fqtCGJBwbZ6kgOwy
         KdiYU3k3pkgjkBvtBVB+6ZfojBBijCQZ1lPQLAJlreF6ZMhcE6ISQFwTGb2jRIB4k3
         YrSNvcq+s2fga2YfhBwK9vdmdOK6lugfX0rovb2NfPhSYUB0b8slU7RKVKAx7kP+cd
         6MTvp8O0W/K5mUfNhaI07Hr2eLyYU6CANtyTsmTP+Cdo6xVR2FmrsjZHIt9jZgzC9I
         NGWZWvaLg3pkzzRqa1mxCaB7kw4Z5GR70fCd53RJUtgYXsQu/6nwGtiKpBtqBnL1AG
         3PQ58WowleodQ==
Date:   Wed, 24 May 2023 22:06:18 +0300
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
Subject: Re: [PATCH v2 4/5] mm: Add new ptep_deref() helper to fully
 encapsulate pte_t
Message-ID: <20230524190618.GR4967@kernel.org>
References: <20230518110727.2106156-1-ryan.roberts@arm.com>
 <20230518110727.2106156-5-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518110727.2106156-5-ryan.roberts@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 12:07:26PM +0100, Ryan Roberts wrote:
> There are many call sites that directly dereference a pte_t pointer.
> This makes it very difficult to properly encapsulate a page table in the
> arch code without having to allocate shadow page tables. ptep_deref()
> aims to solve this by replacing all direct dereferences with a call to
> this function.
> 
> The default implementation continues to just dereference the pointer
> (*ptep), so generated code should be exactly the same. However, it is
> possible for the architecture to override the default with their own
> implementation, that can (e.g.) hide certain bits from the core code, or
> determine young/dirty status by mixing in state from another source.
> 
> While ptep_get() and ptep_get_lockless() already exist, these are
> implemented as atomic accesses (e.g. READ_ONCE() in the default case).
> So rather than using ptep_get() and risking performance regressions,
> introduce an new variant.
> 
> Call sites will be converted to use the accessor in future commits.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/pgtable.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index c5a51481bbb9..1161beab2492 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -204,6 +204,13 @@ static inline int pudp_set_access_flags(struct vm_area_struct *vma,
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  #endif
>  
> +#ifndef ptep_deref
> +static inline pte_t ptep_deref(pte_t *ptep)
> +{
> +	return *(pte_t *)ptep;

Why do you need the casting here?

> +}
> +#endif
> +
>  #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
>  static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
>  					    unsigned long address,
> -- 
> 2.25.1
> 
> 

-- 
Sincerely yours,
Mike.
