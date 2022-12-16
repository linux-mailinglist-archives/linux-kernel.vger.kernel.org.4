Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C6564ED29
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 15:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiLPOzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 09:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiLPOzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 09:55:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DDE4A58A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 06:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671202474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eyyx/aF2V9lTUZ0rSVhQrdjXcZ3OfNikbAhK+3xqsq4=;
        b=S6d4ADa7zXY8lzIQ+gqwqob4fDyFBPBrWQZsrdiZAniv4zBDwdwAPvtxrbyqKlDJmH035o
        UN0RRGzsMZ1bBnP3+7Pg8ojYPMbA7z/VF22a4FzN4ToF8HW+GrYqrZLyR7UB87FL6nVJ9s
        hjEwU3CksANj26aPX0Wtl0rT1ghmAEg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-641--qGQlVN_Oeu-ngFojy_KyA-1; Fri, 16 Dec 2022 09:54:33 -0500
X-MC-Unique: -qGQlVN_Oeu-ngFojy_KyA-1
Received: by mail-qk1-f199.google.com with SMTP id az39-20020a05620a172700b006ff85c3b19eso1942749qkb.18
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 06:54:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyyx/aF2V9lTUZ0rSVhQrdjXcZ3OfNikbAhK+3xqsq4=;
        b=ddB6VaExSaT39BHIuFjKkc9Pye/TZPm4uNoKZrJ2aYkcRD+6Q8GfILcEMOdih+mr1O
         IAAB3kwoKXYok5Bsy2etKblSdywaWOVI3o1ZKuxI4ceeejJl6lYRSpkSdfo1hkjs05Fn
         PMc2p15WWknQnCF+Icr74jbwuAJDFjEpn3xnzOB6sCYG9iccgH3ijfcI9vdcM8FjIlHX
         oPUQOspLsF89ESgAZ7jk9m3feRXrvDEXUaAuL+ljzWXoGh1vTm8oG8hu6dkxzlHAsKcJ
         0hfvyi+hLA4v62ylFGbqvxATvEHH3h2Xve+11Dzb/pzsy8DBO5SvOsmhdhS8XG/UWrsY
         Jmyw==
X-Gm-Message-State: ANoB5plgBXcxupD6BrXGiaJJWS2E+hQngldyXnuOLmg1R4xVd+dmur6J
        M18KN3wgDAQ41lT917jBH0GdQlnbDiqbkfBSGke3fVWbgnv/6znzOsb9XuPzkP2L7Vpjjl8rN6P
        eBuu/kEAgm5mK00DgMNtNbsVT
X-Received: by 2002:ad4:43e9:0:b0:4bb:6eb9:a220 with SMTP id f9-20020ad443e9000000b004bb6eb9a220mr38021838qvu.8.1671202473243;
        Fri, 16 Dec 2022 06:54:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5AHUM11A/bB73hu6cvluJb5tmi8bh492KBCIr5bVruuG1aH/QXeVJO6LChik/tvjIwG/6Bjw==
X-Received: by 2002:ad4:43e9:0:b0:4bb:6eb9:a220 with SMTP id f9-20020ad443e9000000b004bb6eb9a220mr38021814qvu.8.1671202472943;
        Fri, 16 Dec 2022 06:54:32 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a430700b006fa31bf2f3dsm1620323qko.47.2022.12.16.06.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 06:54:32 -0800 (PST)
Date:   Fri, 16 Dec 2022 09:54:31 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Huang Ying <ying.huang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/uffd: Fix pte marker when fork() without fork
 event
Message-ID: <Y5yGp6ToQD+eYrv/@x1n>
References: <20221214200453.1772655-1-peterx@redhat.com>
 <20221214200453.1772655-2-peterx@redhat.com>
 <618b69be-0e99-e35f-04b3-9c63d78ece50@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <618b69be-0e99-e35f-04b3-9c63d78ece50@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 10:04:27AM +0100, David Hildenbrand wrote:
> On 14.12.22 21:04, Peter Xu wrote:
> > When fork(), dst_vma is not guaranteed to have VM_UFFD_WP even if src may
> > have it and has pte marker installed.  The warning is improper along with
> > the comment.  The right thing is to inherit the pte marker when needed, or
> > keep the dst pte empty.
> > 
> > A vague guess is this happened by an accident when there's the prior patch
> > to introduce src/dst vma into this helper during the uffd-wp feature got
> > developed and I probably messed up in the rebase, since if we replace
> > dst_vma with src_vma the warning & comment it all makes sense too.
> > 
> > Hugetlb did exactly the right here (copy_hugetlb_page_range()).  Fix the
> > general path.
> > 
> > Reproducer:
> > 
> > https://github.com/xupengfe/syzkaller_logs/blob/main/221208_115556_copy_page_range/repro.c
> > 
> > Cc: <stable@vger.kernel.org> # 5.19+
> > Fixes: c56d1b62cce8 ("mm/shmem: handle uffd-wp during fork()")
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216808
> > Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   mm/memory.c | 8 ++------
> >   1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index aad226daf41b..032ef700c3e8 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -828,12 +828,8 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> >   			return -EBUSY;
> >   		return -ENOENT;
> >   	} else if (is_pte_marker_entry(entry)) {
> > -		/*
> > -		 * We're copying the pgtable should only because dst_vma has
> > -		 * uffd-wp enabled, do sanity check.
> > -		 */
> > -		WARN_ON_ONCE(!userfaultfd_wp(dst_vma));
> > -		set_pte_at(dst_mm, addr, dst_pte, pte);
> > +		if (userfaultfd_wp(dst_vma))
> > +			set_pte_at(dst_mm, addr, dst_pte, pte);
> >   		return 0;
> >   	}
> >   	if (!userfaultfd_wp(dst_vma))
> 
> Staring at the code first made me go "what about other PTE markers". I then
> looked into the discussion in patch #2. The fix as is is suboptimal, because
> it
> 
> 1) Removes the warning which is good, but
> 2) Silently drops swapin errors now
> 
> So it silently breaks something else temporarily ...
> 
> 
> I remember, that theoretically we could have multiple markers stored in a
> single PTE marker.
> 
> Wouldn't it be cleaner to be able to "clean" specific markers from a PTE
> marker without having to special case on each and everyone? I mean, only
> uffd-wp is really special such that it might disappear for the target.

Quotting the commit message in patch 2:

  Currently there is a priority difference between the uffd-wp bit and the
  swapin error entry, in which the swapin error always has higher priority
  (e.g. we don't need to wr-protect a swapin error pte marker).

  If there will be a 3rd bit introduced, we'll probably need to consider a
  more involved approach so we may need to start operate on the bits.
  Let's leave that for later.

I actually started the fix with something like that, but I noticed it's not
needed to add more code if there's no 3rd bit introduced so I dropped that.
I decided to go the simpler change approach and leave that for later.

> 
> Something like (pseudocode):
> 
> if (!userfaultfd_wp(dst_vma))
> 	pte_marker_clear_uff_wp(entry);
> if (!pte_marker_empty(entry)) {
> 	pte = make_pte_marker(pte_marker_get(entry));
> 	set_pte_at(dst_mm, addr, dst_pte, pte);
> }
> 
> Then this fix would be correct and backport-able even without #2. And it
> would work for new types of markers :)

When that comes, we may need one set_pte_marker_at() taking care of empty
pte markers, otherwise there can be a lot of such check.

> 
> 
> I'd prefer a fix that doesn't break something else temporarily, even if the
> stable backport might require 5 additional minutes to do. So squashing #2
> into #1 would also work.

The thing is whether do we care about someone: (1) explicitly checkout at
the commit of patch 1, then (2) runs the kernel, hit a swapnin error, (3)
fork(), and (4) access the swapin error page in the child.

To me I don't care even starting from (1).. because it really shouldn't
happen at all in any serious environment.

The other reason is these are indeed two issues to solve.  Even if by
accident we kept the swapin error in old code we'll probably dump an
warning which is not wanted either.  It's not something someone will really
get benefit from..

So like many other places, I don't have a strong opinion, but personally I
prefer the current approach.

Andrew, let me know if you want me to repost with a squashed version.

Thanks,

-- 
Peter Xu

