Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A6C68F300
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjBHQRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjBHQQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:16:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE314B74C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 08:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675872968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mwf7rfwfNT2NehwiIE+ikRTPDY0JBgN/N8jjGidg+sU=;
        b=Ss/yUAZyOpsqv5Ow2LJgT5wrHHUJA1UbvL1o4eZ1EPVWrhJbXjEBr6MFxPxq/nkebaQ8pG
        yWsSl7eDJCzPcJRPV2QRXbWHCSDas5fAzW50hogxcuMsXxGm9Myzyj42PW0lrfjycSKjWd
        7325bmD+Oq7ODHOWAYvL5CudZA5M9tY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-580-Wh2cxZFNNj2pftSt4pls8w-1; Wed, 08 Feb 2023 11:16:06 -0500
X-MC-Unique: Wh2cxZFNNj2pftSt4pls8w-1
Received: by mail-qt1-f198.google.com with SMTP id c14-20020ac87d8e000000b003ba2d72f98aso5049925qtd.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 08:16:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwf7rfwfNT2NehwiIE+ikRTPDY0JBgN/N8jjGidg+sU=;
        b=ObVv9AfWMgxR4uF84UgQjdpoLVgYlvV2di0JwV6UAEa7x/GqEBrOeWhceFUA7X5Xd5
         +kArTHS/HwGg6TJ5o26cXs36jX8OHnkpZ9BNs7o3kCRmywBjK0+p2nhaeFcWL8IBNWft
         aLX1n8MX+qnXiIqJ55XxoAuEitl0sCY1y2m/TmMWJgLJl9A6E9+Ew1JXV0fCkhIS6oVc
         m2w/JC5yhA0d4ERNHmWT9X7f/lNqfU/WABQXOE3IEVMcZe1V96+jRUJaAUkudw1Do2SQ
         3QVf/n5D1xJWMuc2WhsHZZDtI8UTunBydFzFg1Q11GxqPWOq7kqoZj58X47Scii9sHdi
         3VGQ==
X-Gm-Message-State: AO0yUKX6HX0L+0LrB74Um/MfFyL4nF9Jnshb9bycIsTvg+UogQHsKDJl
        4XCMb2ssxwoZVVrDAlL+8W8pU7lSFrfmVKEirs3ps2SEKUKrCDVmlpSGRrxLBhHkXw8BdwbxNV+
        QMNEYL+ZbJqQkMPkvD16i1TnJ
X-Received: by 2002:ac8:5e11:0:b0:3b9:fc92:a6 with SMTP id h17-20020ac85e11000000b003b9fc9200a6mr14939744qtx.6.1675872965420;
        Wed, 08 Feb 2023 08:16:05 -0800 (PST)
X-Google-Smtp-Source: AK7set/0m8hfu7/yvzWEDDzH7ppzEgnoMBaIJeRGEEkMikotRaed4dllfcaULguCF/RTGle4IqbPxA==
X-Received: by 2002:ac8:5e11:0:b0:3b9:fc92:a6 with SMTP id h17-20020ac85e11000000b003b9fc9200a6mr14939695qtx.6.1675872965000;
        Wed, 08 Feb 2023 08:16:05 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id fv22-20020a05622a4a1600b003b646123691sm11843472qtb.31.2023.02.08.08.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 08:16:04 -0800 (PST)
Date:   Wed, 8 Feb 2023 11:16:02 -0500
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
Message-ID: <Y+PKwvLT8+wQ6LPA@x1n>
References: <Y9m/VVRABt0Blfjh@x1n>
 <CADrL8HXpfTE1+eE3rNGQyOr1QRtDtG5mBp-b3xcNX22QJRvPaQ@mail.gmail.com>
 <Y9qRta3bd4JqjUHx@x1n>
 <CADrL8HU809O0cPa9hXjf3k+ob139SQqvxOvpqm6UEv=zrPjHSg@mail.gmail.com>
 <Y9re82gctIZf08cX@x1n>
 <CADrL8HVja_xJ9qczsd-fQfEPvEEXswhXQwoan=a_LSMyORvqww@mail.gmail.com>
 <CADrL8HUSx6=K0QXQtTmv9ZJQmvhe6KEb+FiAviRfO3HjmRUeTw@mail.gmail.com>
 <CADrL8HUm7g4pBLv9vjmB-LhJqxm4jyksGJQAdwRsweKKAnofDg@mail.gmail.com>
 <Y+LbEY62MT/3yo7I@x1n>
 <CADrL8HUVCXHsaWU7beYQsLw0C7J730PQm45caKE26V8mCFHjKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HUVCXHsaWU7beYQsLw0C7J730PQm45caKE26V8mCFHjKQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 04:26:02PM -0800, James Houghton wrote:
> On Tue, Feb 7, 2023 at 3:13 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > James,
> >
> > On Tue, Feb 07, 2023 at 02:46:04PM -0800, James Houghton wrote:
> > > > Here is the result: [1] (sorry it took a little while heh). The
> >
> > Thanks.  From what I can tell, that number shows that it'll be great we
> > start with your rfcv1 mapcount approach, which mimics what's proposed by
> > Matthew for generic folio.
> 
> Do you think the RFC v1 way is better than doing the THP-like way
> *with the additional MMU notifier*?

What's the additional MMU notifier you're referring?

> 
> >
> > > > implementation of the "RFC v1" way is pretty horrible[2] (and this
> >
> > Any more information on why it's horrible? :)
> 
> I figured the code would speak for itself, heh. It's quite complicated.
> 
> I really didn't like:
> 1. The 'inc' business in copy_hugetlb_page_range.
> 2. How/where I call put_page()/folio_put() to keep the refcount and
> mapcount synced up.
> 3. Having to check the page cache in UFFDIO_CONTINUE.

I think the complexity is one thing which I'm fine with so far.  However
when I think again about the things behind that complexity, I noticed there
may be at least one flaw that may not be trivial to work around.

It's about truncation.  The problem is now we use the pgtable entry to
represent the mapcount, but the pgtable entry cannot be zapped easily,
unless vma unmapped or collapsed.

It means e.g. truncate_inode_folio() may stop working for hugetlb (of
course, with page lock held).  The mappings will be removed for real, but
not the mapcount for HGM anymore, because unmap_mapping_folio() only zaps
the pgtable leaves, not the ones that we used to account for mapcounts.

So the kernel may see weird things, like mapcount>0 after
truncate_inode_folio() being finished completely.

For HGM to do the right thing, we may want to also remove the non-leaf
entries when truncating or doing similar things like a rmap walk to drop
any mappings for a page/folio.  Though that's not doable for now because
the locks that truncate_inode_folio() is weaker than what we need to free
the pgtable non-leaf entries - we'll need mmap write lock for that, the
same as when we unmap or collapse.

Matthew's design doesn't have such issue if the ptes need to be populated,
because mapcount is still with the leaves; not the case for us here.

If that's the case, _maybe_ we still need to start with the stupid but
working approach of subpage mapcounts.

[...]

> > > > Matthew is trying to solve the same problem with THPs right now: [3].
> > > > I haven't figured out how we can apply Matthews's approach to HGM
> > > > right now, but there probably is a way. (If we left the mapcount
> > > > increment bits in the same place, we couldn't just check the
> > > > hstate-level PTE; it would have already been made present.)
> >
> > I'm just worried that (1) this may add yet another dependency to your work
> > which is still during discussion phase, and (2) whether the folio approach
> > is easily applicable here, e.g., we may not want to populate all the ptes
> > for hugetlb HGMs by default.
> 
> That's true. I definitely don't want to wait for this either. It seems
> like Matthew's approach won't work very well for us -- when doing a
> lot of high-granularity UFFDIO_CONTINUEs on a 1G page, checking all
> the PTEs to see if any of them are mapped would get really slow.

I think it'll be a common problem to userfaultfd when it comes, e.g.,
userfaultfd by design is PAGE_SIZE based so far.  It needs page size
granule on pgtable manipulations, unless we extend the userfaultfd protocol
to support folios, iiuc.

> 
> >
> > > >
> > > > We could:
> > > > - use the THP-like way and tolerate ~1 second collapses
> > >
> > > Another thought here. We don't necessarily *need* to collapse the page
> > > table mappings in between mmu_notifier_invalidate_range_start() and
> > > mmu_notifier_invalidate_range_end(), as the pfns aren't changing,
> > > we aren't punching any holes, and we aren't changing permission bits.
> > > If we had an MMU notifier that simply informed KVM that we collapsed
> > > the page tables *after* we finished collapsing, then it would be ok
> > > for hugetlb_collapse() to be slow.
> >
> > That's a great point!  It'll definitely apply to either approach.
> >
> > >
> > > If this MMU notifier is something that makes sense, it probably
> > > applies to MADV_COLLAPSE for THPs as well.
> >
> > THPs are definitely different, mmu notifiers should be required there,
> > afaict.  Isn't that what the current code does?
> >
> > See collapse_and_free_pmd() for shmem and collapse_huge_page() for anon.
> 
> Oh, yes, of course, MADV_COLLAPSE can actually move things around and
> properly make THPs. Thanks. But it would apply if we were only
> collapsing PTE-mapped THPs, I think?

Yes it applies I think.  And if I'm not wrong it's also doing so. :) See
collapse_pte_mapped_thp().

While for anon we always allocate a new page, hence not applicable.

-- 
Peter Xu

