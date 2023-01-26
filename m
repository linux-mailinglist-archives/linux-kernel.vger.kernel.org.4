Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E335A67D8BB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjAZWr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjAZWrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:47:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5902245F79
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:47:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5FF361982
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 22:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E3CC433D2;
        Thu, 26 Jan 2023 22:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674773243;
        bh=Ep/KY1mu+CYgnjaFY9zEbtTygigA8q1n5HTt47g3wsM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZNprl7PhmX2pjn2/SqfKBf/BFgPCmxOFGfb3Xdu65l8w0TIX26cGDy94uq5D2Yk+v
         sxp3N4d97pMptUV6mSJT8e+iowsH3FpgSEUGnkq/5sU9fZxo38/HTxCxgJNMFn9Cj+
         izplUSGTZRGb152LzibI/rgC2RuzV871BGLMwg10=
Date:   Thu, 26 Jan 2023 14:47:22 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Yang Shi <shy828301@gmail.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Vishal Moola (Oracle) <vishal.moola@gmail.com>
Subject: Re: [PATCH 0/2] Fixes for hugetlb mapcount at most 1 for shared
 PMDs
Message-Id: <20230126144722.8b84116c488553c79d8623ec@linux-foundation.org>
In-Reply-To: <20230126222721.222195-1-mike.kravetz@oracle.com>
References: <20230126222721.222195-1-mike.kravetz@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023 14:27:19 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> Ongoing folio conversions cause context conflicts in the second patch
> when applied to mm-unstable/linux-next.  I can create separate patch(es)
> if people agree with these.

I fixed things up.  queue_folios_hugetlb() is now

static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
			       unsigned long addr, unsigned long end,
			       struct mm_walk *walk)
{
	int ret = 0;
#ifdef CONFIG_HUGETLB_PAGE
	struct queue_pages *qp = walk->private;
	unsigned long flags = (qp->flags & MPOL_MF_VALID);
	struct folio *folio;
	spinlock_t *ptl;
	pte_t entry;

	ptl = huge_pte_lock(hstate_vma(walk->vma), walk->mm, pte);
	entry = huge_ptep_get(pte);
	if (!pte_present(entry))
		goto unlock;
	folio = pfn_folio(pte_pfn(entry));
	if (!queue_folio_required(folio, qp))
		goto unlock;

	if (flags == MPOL_MF_STRICT) {
		/*
		 * STRICT alone means only detecting misplaced folio and no
		 * need to further check other vma.
		 */
		ret = -EIO;
		goto unlock;
	}

	if (!vma_migratable(walk->vma)) {
		/*
		 * Must be STRICT with MOVE*, otherwise .test_walk() have
		 * stopped walking current vma.
		 * Detecting misplaced folio but allow migrating folios which
		 * have been queued.
		 */
		ret = 1;
		goto unlock;
	}

	/*
	 * With MPOL_MF_MOVE, we try to migrate only unshared folios. If it
	 * is shared it is likely not worth migrating.
	 *
	 * To check if the folio is shared, ideally we want to make sure
	 * every page is mapped to the same process. Doing that is very
	 * expensive, so check the estimated mapcount of the folio instead.
	 */
	if (flags & (MPOL_MF_MOVE_ALL) ||
	    (flags & MPOL_MF_MOVE && folio_estimated_mapcount(folio) == 1 &&
	     !hugetlb_pmd_shared(pte))) {
		if (isolate_hugetlb(folio, qp->pagelist) &&
			(flags & MPOL_MF_STRICT))
			/*
			 * Failed to isolate folio but allow migrating pages
			 * which have been queued.
			 */
			ret = 1;
	}
unlock:
	spin_unlock(ptl);
#else
	BUG();
#endif
	return ret;
}

