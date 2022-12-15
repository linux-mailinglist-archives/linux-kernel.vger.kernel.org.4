Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77C764DCB4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 15:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLOOGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 09:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLOOGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 09:06:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AFC108E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 06:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671113134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f5mWqAZ4oKzRB/AUy0EFC6zsdw46PWyd5mKsEYBuVQc=;
        b=TcrotNfJc3O6UqFnAq++yaE6B2rcQmwCxUFRQliaBDlpgzNiQZFdb6PuQNKJSW/uTWu41C
        RtKOegkfdeD6FOCUNj9aK3AuX48oRoOcmtPiCmochmU97dllvkTH00UDFuxL20TjElBcYY
        +GhiJqugHHU3jiPhp+gif4tXfof7Jlw=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-622-P0ykJ4aaP9GnSebUS04v-g-1; Thu, 15 Dec 2022 09:05:32 -0500
X-MC-Unique: P0ykJ4aaP9GnSebUS04v-g-1
Received: by mail-oo1-f69.google.com with SMTP id x20-20020a4a6214000000b004a36ed7679eso8208985ooc.15
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 06:05:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5mWqAZ4oKzRB/AUy0EFC6zsdw46PWyd5mKsEYBuVQc=;
        b=i84nBu7kD32Cw48luyynt8ESiJwIh7wDAmq7MD0h5/uxjZa/0Pnv6FU0alJyxNa3gh
         ROLFJ6VCXwAfyo9aZmph2odqbzIgAF+aJA9yiMmYSEpzkmffTSwtjCuhL1yjx/sdZiMD
         sUW+U6cy8iqM23ym4TbkzdxtbbwuA4SOoiTIQA373+8ce1JxObxmMpu6u2BgoPNs19Z+
         SWD9FnPUh5DZ6j9nUdfkxCnhFb7sc2Tw5rZ40GehA4yo8goRqrnDxpHJhd3ySIdsKWws
         JAonHv9sCDTLk+JfCm+Gwmjvxjxmwg/ov5c66u6JPoTXxQelbGDY3o02iye3NK1nH9+t
         UOrQ==
X-Gm-Message-State: AFqh2koQeK92hB0bQ702ybUbMe2zqzxVpL6B/D5yjmBS/c38D69Tyh/v
        sVwhK9+wFKgo6ONCB+QGEajjk3CX3cZ0yYi8F/EC665Jdg1WSYvpvzP6wNAd7JuUGtvgNLGKyLV
        Kk2lSnQuJ3Qr2HN9maiKL+i54
X-Received: by 2002:a05:6358:ee96:b0:e2:8961:31eb with SMTP id il22-20020a056358ee9600b000e2896131ebmr360087rwb.18.1671113131158;
        Thu, 15 Dec 2022 06:05:31 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvONXi/dqYJVFx4n5Wjg35lK85YO/Ff/VaOFj8YDa8i+fVvbU4Ufo7cLZgI/t2BoMFIue5OPQ==
X-Received: by 2002:a05:6358:ee96:b0:e2:8961:31eb with SMTP id il22-20020a056358ee9600b000e2896131ebmr360055rwb.18.1671113130807;
        Thu, 15 Dec 2022 06:05:30 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id y18-20020a37f612000000b006fa2cc1b0fbsm11948112qkj.11.2022.12.15.06.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 06:05:30 -0800 (PST)
Date:   Thu, 15 Dec 2022 09:05:28 -0500
From:   Peter Xu <peterx@redhat.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH 2/2] mm: Fix a few rare cases of using swapin error pte
 marker
Message-ID: <Y5spqIz3vAlqYIHK@x1n>
References: <20221214200453.1772655-1-peterx@redhat.com>
 <20221214200453.1772655-3-peterx@redhat.com>
 <87bko5cf8y.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bko5cf8y.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 03:12:13PM +0800, Huang, Ying wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > This patch should harden commit 15520a3f0469 ("mm: use pte markers for swap
> > errors") on using pte markers for swapin errors on a few corner cases.
> >
> > 1. Propagate swapin errors across fork()s: if there're swapin errors in
> >    the parent mm, after fork()s the child should sigbus too when an error
> >    page is accessed.
> >
> > 2. Fix a rare condition race in pte_marker_clear() where a uffd-wp pte
> >    marker can be quickly switched to a swapin error.
> >
> > 3. Explicitly ignore swapin error pte markers in change_protection().
> >
> > I mostly don't worry on (2) or (3) at all, but we should still have them.
> > Case (1) is special because it can potentially cause silent data corrupt on
> > child when parent has swapin error triggered with swapoff, but since swapin
> > error is rare itself already it's probably not easy to trigger either.
> >
> > Currently there is a priority difference between the uffd-wp bit and the
> > swapin error entry, in which the swapin error always has higher
> > priority (e.g. we don't need to wr-protect a swapin error pte marker).
> >
> > If there will be a 3rd bit introduced, we'll probably need to consider a
> > more involved approach so we may need to start operate on the bits.  Let's
> > leave that for later.
> >
> > This patch is tested with case (1) explicitly where we'll get corrupted
> > data before in the child if there's existing swapin error pte markers, and
> > after patch applied the child can be rightfully killed.
> >
> > We don't need to copy stable for this one since 15520a3f0469 just landed as
> > part of v6.2-rc1, only "Fixes" applied.
> >
> > Fixes: 15520a3f0469 ("mm: use pte markers for swap errors")
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/hugetlb.c  | 3 +++
> >  mm/memory.c   | 8 ++++++--
> >  mm/mprotect.c | 8 +++++++-
> >  3 files changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index f5f445c39dbc..1e8e4eb10328 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -4884,6 +4884,9 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
> >  				entry = huge_pte_clear_uffd_wp(entry);
> >  			set_huge_pte_at(dst, addr, dst_pte, entry);
> >  		} else if (unlikely(is_pte_marker(entry))) {
> > +			/* No swap on hugetlb */
> > +			WARN_ON_ONCE(
> > +			    is_swapin_error_entry(pte_to_swp_entry(entry)));
> >  			/*
> >  			 * We copy the pte marker only if the dst vma has
> >  			 * uffd-wp enabled.
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 032ef700c3e8..3e836fecd035 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -828,7 +828,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> >  			return -EBUSY;
> >  		return -ENOENT;
> >  	} else if (is_pte_marker_entry(entry)) {
> > -		if (userfaultfd_wp(dst_vma))
> > +		if (is_swapin_error_entry(entry) || userfaultfd_wp(dst_vma))
> 
> Should we do this in [1/2]?  It appears that we introduce an issue in
> [1/2] and fix it in [2/2]?

Patch 1 copied stable with 5.19+, this one is not.

So if we want to squash, we may want to squash both patches into one, then
we'll need an explicit follow up on stable branch with something like patch
1.  The current way works easier for stable, but I can also do the other.

Thanks,

-- 
Peter Xu

