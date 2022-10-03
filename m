Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220AE5F3267
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiJCPYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJCPY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:24:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B953E2654
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 08:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664810665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3AwdTyRgIKZxfca+bCraTzGFElDPhfgV2yzBJDWIiIc=;
        b=MEmw2TJl6tFTSlwHVZUGka90QSCrWlTnaIta/8F70JC5aOMQY4ebwLexYx8hHJKQICRL8M
        4pS/9Zuyj8i9qWJHZFMzzJSFTs8DBcPtHqhYDqvnx/5PpH3OClLTYvoXPjE23ClXLPkCfR
        9knU4//dSNQ7hputXNSx1s7Z5GU4YYI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-501-bZRPNXhDO42m8GXUnqwG7w-1; Mon, 03 Oct 2022 11:24:24 -0400
X-MC-Unique: bZRPNXhDO42m8GXUnqwG7w-1
Received: by mail-qt1-f197.google.com with SMTP id u9-20020a05622a14c900b0035cc7e8cbaeso7491255qtx.19
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 08:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=3AwdTyRgIKZxfca+bCraTzGFElDPhfgV2yzBJDWIiIc=;
        b=KdtlN2ATZcSxb8Gg/OdDfiVcxQAEHPoK2VBezjAgQxS0ZSmj87UVE6hkxIXKZjdToS
         mbXJ1/b+mImfhgDr5HO6RmwaAjtRGimM5vEUrOt5zWBxlJCYPmhxtsALRvyp1+9d/xRs
         ZnCzjio5DXetiRrk8Ie9IEQ5cqgATZ3mNahdnfspaVvVGWFy792vo7NqJJU50qqHIjg4
         aYMxRzNp9g24vQrsxzvarjz410P88CbyE968lcmhW0U0JI4KnTD+PTTaztTwrDAbFkTg
         QHxDUIewCF5rzHKfCxYVb7kiX/ZBCJzpv3OXgUgnq4RuM8/bYB2l97WOq8Wxdk1qqWSK
         RTcA==
X-Gm-Message-State: ACrzQf2Ee1neNs7tcFtkae+BHr42qmozZeqV7zfb69aQOlaG0DVPM8s7
        dZEKnZojErs+2GdjeMOJ4Ufpci0x+MIkjQznTDX93AXocLitqN0SJsUM4tv2anPrVXNCeoTKa5H
        vgQKV9Lu2ZjrVxv2vroitplhk
X-Received: by 2002:ac8:7c52:0:b0:35c:e867:e5dc with SMTP id o18-20020ac87c52000000b0035ce867e5dcmr16317155qtv.433.1664810663647;
        Mon, 03 Oct 2022 08:24:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM75+guqfvitKMHt9acY1KnWc0Ffw2urIGw9EPlUgaFxrFqUOb0XvvvW82FgW2oMKtjOW6O2Ww==
X-Received: by 2002:ac8:7c52:0:b0:35c:e867:e5dc with SMTP id o18-20020ac87c52000000b0035ce867e5dcmr16317135qtv.433.1664810663435;
        Mon, 03 Oct 2022 08:24:23 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id o15-20020a05620a22cf00b006bb78d095c5sm10613381qki.79.2022.10.03.08.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 08:24:22 -0700 (PDT)
Date:   Mon, 3 Oct 2022 11:24:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+152d76c44ba142f8992b@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] general protection fault in PageHeadHuge
Message-ID: <Yzr+pSeTPB5MS6PU@x1n>
References: <Yy9T/JmVb4ymf6WM@monkey>
 <YzDuHbuo2x/b2Mbr@x1n>
 <YzMjxY5O6Hf/IPTx@monkey>
 <YzMomT+OusJnLOPC@x1n>
 <YzYrYVeA0b9d5dos@monkey>
 <YzcTt3P3ofvbGQmi@x1n>
 <YzdhuZmfQCjLFEMO@monkey>
 <YzeqUTDay7AcnP7r@x1n>
 <YzetdU37ekZ6N2II@x1n>
 <Yzo4BU25w7i8HrrQ@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yzo4BU25w7i8HrrQ@monkey>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 06:16:53PM -0700, Mike Kravetz wrote:
> On 09/30/22 23:01, Peter Xu wrote:
> > On Fri, Sep 30, 2022 at 10:47:45PM -0400, Peter Xu wrote:
> > From fe9e50551f3fdb7107315784affca4f9b1c4720f Mon Sep 17 00:00:00 2001
> > From: Peter Xu <peterx@redhat.com>
> > Date: Fri, 30 Sep 2022 22:22:44 -0400
> > Subject: [PATCH] mm/hugetlb: Fix race condition of uffd missing handling
> > Content-type: text/plain
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/hugetlb.c | 36 +++++++++++++++++++++++++++++++++---
> >  1 file changed, 33 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index dd29cba46e9e..5015d8aa5da4 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -5557,9 +5557,39 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
> >  	if (!page) {
> >  		/* Check for page in userfault range */
> >  		if (userfaultfd_missing(vma)) {
> > -			ret = hugetlb_handle_userfault(vma, mapping, idx,
> > -						       flags, haddr, address,
> > -						       VM_UFFD_MISSING);
> > +			bool same;
> > +
> > +			/*
> > +			 * Since hugetlb_no_page() was examining pte
> > +			 * without pgtable lock, we need to re-test under
> > +			 * lock because the pte may not be stable and could
> > +			 * have changed from under us.  Try to detect
> > +			 * either changed or during-changing ptes and bail
> > +			 * out properly.
> > +			 *
> > +			 * One example of changing pte is in-progress CoW
> > +			 * of private mapping, which will clear+flush pte
> > +			 * then reinstall the new one.
> > +			 *
> > +			 * Note that userfaultfd is actually fine with
> > +			 * false positives (e.g. caused by pte changed),
> > +			 * but not wrong logical events (e.g. caused by
> > +			 * reading a pte during changing).  The latter can
> > +			 * confuse the userspace, so the strictness is very
> > +			 * much preferred.  E.g., MISSING event should
> > +			 * never happen on the page after UFFDIO_COPY has
> > +			 * correctly installed the page and returned.
> > +			 */
> 
> Thanks Peter!
> 
> The wording and pte_same check here is better than what I proposed.  I think
> that last paragraph above should go into the commit message as it describes
> user visible effects (missing event after UFFDIO_COPY has correctly installed
> the page and returned).

Will do.

> 
> This seems to have existed since hugetlb userfault support was added.  It just
> became exposed recently due to locking changes going into 6.1.  However, I
> think it may have existed in the window after hugetlb userfault support was
> added and before current i_mmap_sema locking for pmd sharing was added.

Agreed.

> Just a long way of saying I am not sure cc stable if of much value.

Logically the change is stable material. I had worry that after uffd-wp
intergration with hugetlb it's indeed possible to trigger on the CoWs we're
encountering already, so IMO still something good to have for 5.19.

I just saw that you proposed a similar fix in 4643d67e8cb0b35 on a similar
page migration race three years ago.  I'm not sure whether it also can
happen with uffd missing modes too even before uffd-wp introduced.

I think I'll first post the patch with Fixes attached without having stable
tagged, but let me know your thoughts.  No worry on the backport, I can
take care of doing that and tests.

I also plan to add your co-devel tag if you're fine with it because this
patch is a collaboration effort IMO, but please let me know either here or
directly replying to the patch if it's posted if you think that's inproper
in any form.

Thanks Mike!

-- 
Peter Xu

