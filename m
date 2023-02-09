Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4385F69110A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjBITLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjBITLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:11:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F57566FAF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 11:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675969858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Dj0BP9m73pVTm4Be4o48kVctCdenhcFPv1e/YS/laI=;
        b=KheGel43Oaa5D9rE6UiHJvX5VWPeCg3ePfCYRoHVhvA08P8HRtnSXom0Xp3/XRW3Y7iCev
        5nRyJDy9Zr1aAQ4zJBZZqzJzdSNawx09zeFThmTxMO7nUioKSX8o7Om4vuGKAV8R+UdUr3
        oBtfTbYIGtWs6oLnb2EoAO1gXtAhHg4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-519-2vPScnmvNFiYXFDLO9O7Fw-1; Thu, 09 Feb 2023 14:10:56 -0500
X-MC-Unique: 2vPScnmvNFiYXFDLO9O7Fw-1
Received: by mail-qt1-f199.google.com with SMTP id s4-20020ac85284000000b003b849aa2cd6so1656114qtn.15
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 11:10:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Dj0BP9m73pVTm4Be4o48kVctCdenhcFPv1e/YS/laI=;
        b=f/aJjgHzlJXitIZeUI8hfv68gqdQxK4sf5/ZDax+uQ4y4qOCojLITkQZW2p9HX0N7E
         At50ERlOhnmRXmzcae9Qoxl0Vk6EG1xr3vPgAeDAaCEKYS/bA63yoWTO7Nc1l0MHIW1G
         HBMyd7piiwJMaag7h0O9wtIVT7uXIQgqKkEhtj/BoDSeOkNNDeK5F81QP7ufg6SVZQlD
         n337dmsI9tpLXpqN8siccZFA5igqtA+/CxC0J+5SGAW8wAYipA4g0oerMH1Zoz21a/0r
         mDQ8Rtsle+8M2N+4Yz9t/ddOp7SFFCA3fOgbH9ViKZz4gS2OQlDuGVeM2fuWn2Ru4awt
         KxIw==
X-Gm-Message-State: AO0yUKX5cdEutcL1b1SngTo0WigpPo9DD1QuBEeHS/dk5pRAJXnUvJkn
        CqAdUtwaUIIKQEAs1Ay6iGBZ4yY9mh4ykJe3Nc0eDoiTveFsrAPXytfwaPpkrkfxm+7MXCL8Ljz
        BwvBZd9IMMaENWXVN6mpbgLCA
X-Received: by 2002:ac8:5809:0:b0:3b5:87db:f979 with SMTP id g9-20020ac85809000000b003b587dbf979mr25862186qtg.5.1675969856382;
        Thu, 09 Feb 2023 11:10:56 -0800 (PST)
X-Google-Smtp-Source: AK7set/lmwGYwFrmIA272G1b1Q++8pZ+MeACfzFEldLvKa3aT33BSefwotMazszkuYM+7adjcFuiPw==
X-Received: by 2002:ac8:5809:0:b0:3b5:87db:f979 with SMTP id g9-20020ac85809000000b003b587dbf979mr25862148qtg.5.1675969856101;
        Thu, 09 Feb 2023 11:10:56 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id i185-20020a3786c2000000b006fa4ac86bfbsm1924693qkd.55.2023.02.09.11.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 11:10:55 -0800 (PST)
Date:   Thu, 9 Feb 2023 14:10:53 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for
 walk_hugetlb_range
Message-ID: <Y+VFPX+ToMY27uiw@x1n>
References: <Y9qRta3bd4JqjUHx@x1n>
 <CADrL8HU809O0cPa9hXjf3k+ob139SQqvxOvpqm6UEv=zrPjHSg@mail.gmail.com>
 <Y9re82gctIZf08cX@x1n>
 <CADrL8HVja_xJ9qczsd-fQfEPvEEXswhXQwoan=a_LSMyORvqww@mail.gmail.com>
 <CADrL8HUSx6=K0QXQtTmv9ZJQmvhe6KEb+FiAviRfO3HjmRUeTw@mail.gmail.com>
 <CADrL8HUm7g4pBLv9vjmB-LhJqxm4jyksGJQAdwRsweKKAnofDg@mail.gmail.com>
 <Y+LbEY62MT/3yo7I@x1n>
 <CADrL8HUVCXHsaWU7beYQsLw0C7J730PQm45caKE26V8mCFHjKQ@mail.gmail.com>
 <Y+PKwvLT8+wQ6LPA@x1n>
 <CADrL8HUZON-Fc9YxPyTA21AY02OgEXDDsmq9AUSMSxjr83ndYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HUZON-Fc9YxPyTA21AY02OgEXDDsmq9AUSMSxjr83ndYA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 08:43:45AM -0800, James Houghton wrote:
> On Wed, Feb 8, 2023 at 8:16 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Feb 07, 2023 at 04:26:02PM -0800, James Houghton wrote:
> > > On Tue, Feb 7, 2023 at 3:13 PM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > James,
> > > >
> > > > On Tue, Feb 07, 2023 at 02:46:04PM -0800, James Houghton wrote:
> > > > > > Here is the result: [1] (sorry it took a little while heh). The
> > > >
> > > > Thanks.  From what I can tell, that number shows that it'll be great we
> > > > start with your rfcv1 mapcount approach, which mimics what's proposed by
> > > > Matthew for generic folio.
> > >
> > > Do you think the RFC v1 way is better than doing the THP-like way
> > > *with the additional MMU notifier*?
> >
> > What's the additional MMU notifier you're referring?
> 
> An MMU notifier that informs KVM that a collapse has happened without
> having to invalidate_range_start() and invalidate_range_end(), the one
> you're replying to lower down in the email. :) [ see below... ]

Isn't that something that is needed no matter what mapcount approach we'll
go for?  Did I miss something?

> 
> >
> > >
> > > >
> > > > > > implementation of the "RFC v1" way is pretty horrible[2] (and this
> > > >
> > > > Any more information on why it's horrible? :)
> > >
> > > I figured the code would speak for itself, heh. It's quite complicated.
> > >
> > > I really didn't like:
> > > 1. The 'inc' business in copy_hugetlb_page_range.
> > > 2. How/where I call put_page()/folio_put() to keep the refcount and
> > > mapcount synced up.
> > > 3. Having to check the page cache in UFFDIO_CONTINUE.
> >
> > I think the complexity is one thing which I'm fine with so far.  However
> > when I think again about the things behind that complexity, I noticed there
> > may be at least one flaw that may not be trivial to work around.
> >
> > It's about truncation.  The problem is now we use the pgtable entry to
> > represent the mapcount, but the pgtable entry cannot be zapped easily,
> > unless vma unmapped or collapsed.
> >
> > It means e.g. truncate_inode_folio() may stop working for hugetlb (of
> > course, with page lock held).  The mappings will be removed for real, but
> > not the mapcount for HGM anymore, because unmap_mapping_folio() only zaps
> > the pgtable leaves, not the ones that we used to account for mapcounts.
> >
> > So the kernel may see weird things, like mapcount>0 after
> > truncate_inode_folio() being finished completely.
> >
> > For HGM to do the right thing, we may want to also remove the non-leaf
> > entries when truncating or doing similar things like a rmap walk to drop
> > any mappings for a page/folio.  Though that's not doable for now because
> > the locks that truncate_inode_folio() is weaker than what we need to free
> > the pgtable non-leaf entries - we'll need mmap write lock for that, the
> > same as when we unmap or collapse.
> >
> > Matthew's design doesn't have such issue if the ptes need to be populated,
> > because mapcount is still with the leaves; not the case for us here.
> >
> > If that's the case, _maybe_ we still need to start with the stupid but
> > working approach of subpage mapcounts.
> 
> Good point. I can't immediately think of a solution. I would prefer to
> go with the subpage mapcount approach to simplify HGM for now;
> optimizing mapcount for HugeTLB can then be handled separately. If
> you're ok with this, I'll go ahead and send v2.

I'm okay with it, but I suggest wait for at least another one day or two to
see whether Mike or others have any comments.

> 
> One way that might be possible: using the PAGE_SPECIAL bit on the
> hstate-level PTE to indicate if mapcount has been incremented or not
> (if the PTE is pointing to page tables). As far as I can tell,
> PAGE_SPECIAL doesn't carry any meaning for HugeTLB PTEs, but we would
> need to be careful with existing PTE examination code as to not
> misinterpret these PTEs.

This is an interesting idea. :) Yes I don't see it being used at all in any
pgtable non-leaves.

Then it's about how to let the zap code know when to remove the special
bit, hence the mapcount, because not all of them should.

Maybe it can be passed over as a new zap_flags_t bit?

Thanks,

-- 
Peter Xu

