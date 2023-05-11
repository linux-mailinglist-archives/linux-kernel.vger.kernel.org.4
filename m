Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223566FF24E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238010AbjEKNPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237587AbjEKNO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:14:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E50DD4C13
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:14:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37367113E;
        Thu, 11 May 2023 06:15:33 -0700 (PDT)
Received: from [10.1.34.59] (C02Z41KALVDN.cambridge.arm.com [10.1.34.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF0863F5A1;
        Thu, 11 May 2023 06:14:47 -0700 (PDT)
Message-ID: <0edc26bd-4341-ff5d-87f4-0c1f685b2d3d@arm.com>
Date:   Thu, 11 May 2023 14:14:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v1 4/5] mm: Add new ptep_deref() helper to fully
 encapsulate pte_t
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        SeongJae Park <sj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        damon@lists.linux.dev
References: <20230511125848.78621-1-ryan.roberts@arm.com>
 <20230511125848.78621-5-ryan.roberts@arm.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230511125848.78621-5-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My appologies for the noise: A blank line between Cc and Subject has broken the
subject and grouping in lore.

Please Ignore this, I will resend.


On 11/05/2023 13:58, Ryan Roberts wrote:
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
> +}
> +#endif
> +
>  #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
>  static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
>  					    unsigned long address,

