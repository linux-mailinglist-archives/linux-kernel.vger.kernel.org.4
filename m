Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CEF60F5BA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbiJ0Kuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbiJ0Kuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:50:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E256C12B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:50:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2A88B82583
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 10:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5924C433C1;
        Thu, 27 Oct 2022 10:50:45 +0000 (UTC)
Date:   Thu, 27 Oct 2022 11:50:42 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Muchun Song <muchun.song@linux.dev>,
        Wupeng Ma <mawupeng1@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 1/1] mm: hugetlb_vmemmap: Fix WARN_ON in
 vmemmap_remap_pte
Message-ID: <Y1piguJXagcxiTpn@arm.com>
References: <20221025014215.3466904-1-mawupeng1@huawei.com>
 <614E3E83-1EAB-4C39-AF9C-83C0CCF26218@linux.dev>
 <35dd51eb-c266-f221-298a-21309c17971a@arm.com>
 <3D6FDA43-A812-4907-B9C8-C2B25567DBBC@linux.dev>
 <3c545133-71aa-9a8d-8a13-09186c4fa767@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c545133-71aa-9a8d-8a13-09186c4fa767@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 02:06:00PM +0530, Anshuman Khandual wrote:
> On 10/26/22 12:31, Muchun Song wrote:
> >> On 10/25/22 12:06, Muchun Song wrote:
> >>>> On Oct 25, 2022, at 09:42, Wupeng Ma <mawupeng1@huawei.com> wrote:
> >>>> From: Ma Wupeng <mawupeng1@huawei.com>
> >>>>
> >>>> Commit f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with
> >>>> each HugeTLB page") add vmemmap_remap_pte to remap the tail pages as
> >>>> read-only to catch illegal write operation to the tail page.
> >>>>
> >>>> However this will lead to WARN_ON in arm64 in __check_racy_pte_update()
> >>>
> >>> Thanks for your finding this issue.
> >>>
> >>>> since this may lead to dirty state cleaned. This check is introduced by
> >>>> commit 2f4b829c625e ("arm64: Add support for hardware updates of the
> >>>> access and dirty pte bits") and the initial check is as follow:
> >>>>
> >>>> BUG_ON(pte_write(*ptep) && !pte_dirty(pte));
> >>>>
> >>>> Since we do need to mark this pte as read-only to catch illegal write
> >>>> operation to the tail pages, use set_pte  to replace set_pte_at to bypass
> >>>> this check.
> >>>
> >>> In theory, the waring does not affect anything since the tail vmemmap
> >>> pages are supposed to be read-only. So, skipping this check for vmemmap
> >>
> >> Tails vmemmap pages are supposed to be read-only, in practice but their
> >> backing pages do have pte_write() enabled. Otherwise the VM_WARN_ONCE()
> >> warning would not have triggered.
> > 
> > Right.
> > 
> >>
> >>        VM_WARN_ONCE(pte_write(old_pte) && !pte_dirty(pte),
> >>                     "%s: racy dirty state clearing: 0x%016llx -> 0x%016llx",
> >>                     __func__, pte_val(old_pte), pte_val(pte));
> >>
> >> Also, is not it true that the pte being remapped into a different page
> >> as read only, than what it had originally (which will be freed up) i.e 
> >> the PFN in 'old_pte' and 'pte' will be different. Hence is there still
> > 
> > Right.
> > 
> >> a possibility for a race condition even when the PFN changes ?
> > 
> > Sorry, I didn't get this question. Did you mean the PTE is changed from
> > new (pte) to the old one (old_pte) by the hardware because of the update
> > of dirty bit when a concurrent write operation to the tail vmemmap page?
> 
> No, but is not vmemmap_remap_pte() reuses walk->reuse_page for all remaining
> tails pages ? Is not there a PFN change, along with access permission change
> involved in this remapping process ?

For the record, as we discussed offline, changing the output address
(pfn) of a pte is not safe without break-before-make if at least one of
the mappings was writeable. The caller (vmemmap_remap_pte()) would need
to be fixed to first invalidate the pte and then write the new pte. I
assume no other CPU accesses this part of the vmemmap while the pte is
being remapped.

-- 
Catalin
