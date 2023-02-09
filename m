Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6E869120E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 21:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjBIUXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 15:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjBIUXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 15:23:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D9131E12
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 12:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675974159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=22CmcsvPaM9XIPOOhNM72ZzlF0lYtjQ+dP35CSXhGrs=;
        b=VTgikRRwTpb9BTjqt6E4jvpjNjjfSzc9rxhwL1RUl3rnfj3Mej+xOMz/C0z1aXWodz1YTQ
        MFRPvGhupOPNw4f4/jsvVJU7XbhlGLL7Ws8pBtShtds7yMMwaCIKStIPVNTQC6qQm5yxJt
        Z1W5SEdYsWUc6jzu2k8hOiy09A94Xjo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-433-q2LGm5JPME2cQoRwzIHUDw-1; Thu, 09 Feb 2023 15:22:38 -0500
X-MC-Unique: q2LGm5JPME2cQoRwzIHUDw-1
Received: by mail-qv1-f70.google.com with SMTP id d14-20020a0cf6ce000000b0056dc767e387so1294489qvo.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 12:22:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22CmcsvPaM9XIPOOhNM72ZzlF0lYtjQ+dP35CSXhGrs=;
        b=Hg57cvWN8ST02vylRUmF9cWjmcsqb4hJYZhGomEKe6W2yj4kxh4+/LurAa0iltCoRu
         F7THZTUZV98zx0XVc/bSjKtdTMjp6RlArs2YF9op2pFA6lI2wXQdZBuxHGlfrLUKMFcJ
         lmKdXlooTCHABp4Kly2OyV4KbPXAa789PaMC+zirgKmectvg0QGvQzbbkKCdkmdkAtEg
         QZ34ZEJLPg9dFkyc/5tdJ/wrd7ZbbTIzxfmpj2Uv16RSzl+2BPjMOVfiyLBBBXu9MPLd
         z8LPis8cpFJQ7bkGWCB0eMh6BvFx1OEiWctXMIc08WWXAUxpG+IPXijeGSpgSS0rqGZw
         rskA==
X-Gm-Message-State: AO0yUKU/FGL3lavuAiCeScijj7VIxjnDje8J3nohM5tZPdqcsU6Hkr92
        wRCIGgLon/sXIqNUWJKZsDq+1GQVxzNlwBjW0385mSDJuK3UoPdh2KdVDF98xfViB4yUCCvm8q2
        0b8MP/JNcb3+bUg3/AO17iYUI
X-Received: by 2002:ac8:4e8d:0:b0:3b8:5f47:aac2 with SMTP id 13-20020ac84e8d000000b003b85f47aac2mr25039851qtp.1.1675974157810;
        Thu, 09 Feb 2023 12:22:37 -0800 (PST)
X-Google-Smtp-Source: AK7set/2S1j09igKbJogZdkwwYta3D17IevLtaU41oFt6c3NwTRE6ES6qGHcKfsd62Q2D8VqHMPmgg==
X-Received: by 2002:ac8:4e8d:0:b0:3b8:5f47:aac2 with SMTP id 13-20020ac84e8d000000b003b85f47aac2mr25039815qtp.1.1675974157497;
        Thu, 09 Feb 2023 12:22:37 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id c26-20020ac84e1a000000b003a5c6ad428asm1828903qtw.92.2023.02.09.12.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 12:22:36 -0800 (PST)
Date:   Thu, 9 Feb 2023 15:22:35 -0500
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
Message-ID: <Y+VWC6miqDCoq0U+@x1n>
References: <Y9re82gctIZf08cX@x1n>
 <CADrL8HVja_xJ9qczsd-fQfEPvEEXswhXQwoan=a_LSMyORvqww@mail.gmail.com>
 <CADrL8HUSx6=K0QXQtTmv9ZJQmvhe6KEb+FiAviRfO3HjmRUeTw@mail.gmail.com>
 <CADrL8HUm7g4pBLv9vjmB-LhJqxm4jyksGJQAdwRsweKKAnofDg@mail.gmail.com>
 <Y+LbEY62MT/3yo7I@x1n>
 <CADrL8HUVCXHsaWU7beYQsLw0C7J730PQm45caKE26V8mCFHjKQ@mail.gmail.com>
 <Y+PKwvLT8+wQ6LPA@x1n>
 <CADrL8HUZON-Fc9YxPyTA21AY02OgEXDDsmq9AUSMSxjr83ndYA@mail.gmail.com>
 <Y+VFPX+ToMY27uiw@x1n>
 <CADrL8HUu5xk5Qo2xJg6qhBXep2W5uwH1zHLat-4hhGOsreH8Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HUu5xk5Qo2xJg6qhBXep2W5uwH1zHLat-4hhGOsreH8Rg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 11:49:25AM -0800, James Houghton wrote:
> On Thu, Feb 9, 2023 at 11:11 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Feb 09, 2023 at 08:43:45AM -0800, James Houghton wrote:
> > > On Wed, Feb 8, 2023 at 8:16 AM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Tue, Feb 07, 2023 at 04:26:02PM -0800, James Houghton wrote:
> > > > > On Tue, Feb 7, 2023 at 3:13 PM Peter Xu <peterx@redhat.com> wrote:
> > > > > >
> > > > > > James,
> > > > > >
> > > > > > On Tue, Feb 07, 2023 at 02:46:04PM -0800, James Houghton wrote:
> > > > > > > > Here is the result: [1] (sorry it took a little while heh). The
> > > > > >
> > > > > > Thanks.  From what I can tell, that number shows that it'll be great we
> > > > > > start with your rfcv1 mapcount approach, which mimics what's proposed by
> > > > > > Matthew for generic folio.
> > > > >
> > > > > Do you think the RFC v1 way is better than doing the THP-like way
> > > > > *with the additional MMU notifier*?
> > > >
> > > > What's the additional MMU notifier you're referring?
> > >
> > > An MMU notifier that informs KVM that a collapse has happened without
> > > having to invalidate_range_start() and invalidate_range_end(), the one
> > > you're replying to lower down in the email. :) [ see below... ]
> >
> > Isn't that something that is needed no matter what mapcount approach we'll
> > go for?  Did I miss something?
> 
> It's not really needed for anything, but it could be an optimization
> for both approaches. However, for the subpage-mapcount approach, it
> would have a *huge* impact. That's what I mean.

Ah, okay.

> 
> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > > > implementation of the "RFC v1" way is pretty horrible[2] (and this
> > > > > >
> > > > > > Any more information on why it's horrible? :)
> > > > >
> > > > > I figured the code would speak for itself, heh. It's quite complicated.
> > > > >
> > > > > I really didn't like:
> > > > > 1. The 'inc' business in copy_hugetlb_page_range.
> > > > > 2. How/where I call put_page()/folio_put() to keep the refcount and
> > > > > mapcount synced up.
> > > > > 3. Having to check the page cache in UFFDIO_CONTINUE.
> > > >
> > > > I think the complexity is one thing which I'm fine with so far.  However
> > > > when I think again about the things behind that complexity, I noticed there
> > > > may be at least one flaw that may not be trivial to work around.
> > > >
> > > > It's about truncation.  The problem is now we use the pgtable entry to
> > > > represent the mapcount, but the pgtable entry cannot be zapped easily,
> > > > unless vma unmapped or collapsed.
> > > >
> > > > It means e.g. truncate_inode_folio() may stop working for hugetlb (of
> > > > course, with page lock held).  The mappings will be removed for real, but
> > > > not the mapcount for HGM anymore, because unmap_mapping_folio() only zaps
> > > > the pgtable leaves, not the ones that we used to account for mapcounts.
> > > >
> > > > So the kernel may see weird things, like mapcount>0 after
> > > > truncate_inode_folio() being finished completely.
> > > >
> > > > For HGM to do the right thing, we may want to also remove the non-leaf
> > > > entries when truncating or doing similar things like a rmap walk to drop
> > > > any mappings for a page/folio.  Though that's not doable for now because
> > > > the locks that truncate_inode_folio() is weaker than what we need to free
> > > > the pgtable non-leaf entries - we'll need mmap write lock for that, the
> > > > same as when we unmap or collapse.
> > > >
> > > > Matthew's design doesn't have such issue if the ptes need to be populated,
> > > > because mapcount is still with the leaves; not the case for us here.
> > > >
> > > > If that's the case, _maybe_ we still need to start with the stupid but
> > > > working approach of subpage mapcounts.
> > >
> > > Good point. I can't immediately think of a solution. I would prefer to
> > > go with the subpage mapcount approach to simplify HGM for now;
> > > optimizing mapcount for HugeTLB can then be handled separately. If
> > > you're ok with this, I'll go ahead and send v2.
> >
> > I'm okay with it, but I suggest wait for at least another one day or two to
> > see whether Mike or others have any comments.
> 
> Ok. :)
> 
> >
> > >
> > > One way that might be possible: using the PAGE_SPECIAL bit on the
> > > hstate-level PTE to indicate if mapcount has been incremented or not
> > > (if the PTE is pointing to page tables). As far as I can tell,
> > > PAGE_SPECIAL doesn't carry any meaning for HugeTLB PTEs, but we would
> > > need to be careful with existing PTE examination code as to not
> > > misinterpret these PTEs.
> >
> > This is an interesting idea. :) Yes I don't see it being used at all in any
> > pgtable non-leaves.
> >
> > Then it's about how to let the zap code know when to remove the special
> > bit, hence the mapcount, because not all of them should.
> >
> > Maybe it can be passed over as a new zap_flags_t bit?
> 
> Here[1] is one way it could be done (it doesn't work 100% correctly,
> it's just approximately what we could do). Basically we pass in the
> entire range that we are unmapping ("floor" and "ceil"), and if
> hugetlb_remove_rmap finds that we're doing the final removal of a page
> that we are entirely unmapping (i.e., floor <= addr &
> huge_page_mask(h)). Having a zap flag would probably work too.

Yeah maybe flags are not needed at all.  I had a quick glance, looks good
in general.

I think the trick is when it's not unmapped in a single shot.  Consider
someone zaps the first half of HGM-mapped hpage then the other half.  The
range may not always tell the whole story so rmap might be left over in
some cases.

But maybe it is not a big deal.  The only thing I think of so far is the
partial DONTNEED.  but I think maybe it's fine to leave it there until
another more serious request to either truncate or unmap it.  At least all
rmap walks should work as expected.

> 
> I think something like [1] ought to go in its own series. :)
> 
> [1]: https://github.com/48ca/linux/commit/de884eaaadf61b8dcfb1defd99bbf487667e46f4

Yes I agree it can be worked on top.

-- 
Peter Xu

