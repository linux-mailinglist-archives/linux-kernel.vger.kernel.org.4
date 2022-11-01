Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D05F614749
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiKAJ4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKAJ4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:56:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DF313F79
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 02:56:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A02B56153B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 09:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A48AC433D6;
        Tue,  1 Nov 2022 09:56:04 +0000 (UTC)
Date:   Tue, 1 Nov 2022 09:56:01 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     mawupeng <mawupeng1@huawei.com>
Cc:     muchun.song@linux.dev, songmuchun@bytedance.com,
        anshuman.khandual@arm.com, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mhocko@suse.com, osalvador@suse.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 1/1] mm: hugetlb_vmemmap: Fix WARN_ON in
 vmemmap_remap_pte
Message-ID: <Y2DtMblXeeT4x/0W@arm.com>
References: <20221025014215.3466904-1-mawupeng1@huawei.com>
 <614E3E83-1EAB-4C39-AF9C-83C0CCF26218@linux.dev>
 <1b2e03b2-5e91-2e60-82d0-ea111840c81d@huawei.com>
 <305231eb-e46a-9295-a845-73237c98855b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305231eb-e46a-9295-a845-73237c98855b@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 09:55:15AM +0800, mawupeng wrote:
> On 2022/10/26 11:01, mawupeng wrote:
> > On 2022/10/25 14:36, Muchun Song wrote:
> >>> On Oct 25, 2022, at 09:42, Wupeng Ma <mawupeng1@huawei.com> wrote:
> >>>
> >>> From: Ma Wupeng <mawupeng1@huawei.com>
> >>>
> >>> Commit f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with
> >>> each HugeTLB page") add vmemmap_remap_pte to remap the tail pages as
> >>> read-only to catch illegal write operation to the tail page.
> >>>
> >>> However this will lead to WARN_ON in arm64 in __check_racy_pte_update()
> >>
> >> Thanks for your finding this issue.
> >>
> >>> since this may lead to dirty state cleaned. This check is introduced by
> >>> commit 2f4b829c625e ("arm64: Add support for hardware updates of the
> >>> access and dirty pte bits") and the initial check is as follow:
> >>>
> >>>  BUG_ON(pte_write(*ptep) && !pte_dirty(pte));
> >>>
> >>> Since we do need to mark this pte as read-only to catch illegal write
> >>> operation to the tail pages, use set_pte  to replace set_pte_at to bypass
> >>> this check.
[...]
> IMHO, arm64 or other archs do some work on the dirty bit and rdonly bit in
> pte in commit 2f4b829c625e ("arm64: Add support for hardware updates of the
> access and dirty pte bits").
> 
> Maybe we can use pte_wrprotect() to mark this pte read-only? It will add 
> PTE_DIRTY bit for the new pte entry compare to the old one.
> 
> Here is the diff:
> 
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index ba2a2596fb4e..24a230895316 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -244,8 +244,7 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
>          * Remap the tail pages as read-only to catch illegal write operation
>          * to the tail pages.
>          */
> -       pgprot_t pgprot = PAGE_KERNEL_RO;
> -       pte_t entry = mk_pte(walk->reuse_page, pgprot);
> +       pte_t entry = pte_wrprotect(mk_pte(walk->reuse_page, PAGE_KERNEL));

This may silence the warning but we plan to add another to detect a
change in the pfn without going through a break-before-make sequence.

-- 
Catalin
