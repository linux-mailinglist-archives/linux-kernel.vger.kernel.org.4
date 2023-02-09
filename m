Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03217691192
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjBITuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBITuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:50:05 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A481A23671
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 11:50:03 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id x8so3347570vso.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 11:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=olFywbvLrfXwhFHGfemOgr304ne0C352PmeiLfsF2Oc=;
        b=PzQDLW7QIdPZwxSSyUuTRHLymbtwkkPN3Pq3+BRayY7EObWjO0E7MVxFCaU2ZH3u5k
         vEcAJoByu4akTjCfIfyTQlAOB65maUkAChOKM3hxduHbWBUmao9Tcuv5TICJXnSvviqz
         9BbNoQlUyGp9bN+agkJijyA9GPtAnWO/TiObo+q/bpshutTK+LGZTDHD1iILr5c/Biu6
         dQx+hovs7eS/Ulh2d3W7I/8x/GElQe19vRKM4u1b7ofhJLIlqXOiH3YKvsCg9ZE9icfq
         4r0pVkKLo03ChI8LjKucq5e8tPM8POSCYInOlsZa9GW4hXuEGZ4dmDX59kvSslIl16Rb
         L43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=olFywbvLrfXwhFHGfemOgr304ne0C352PmeiLfsF2Oc=;
        b=0M6BC/MA7W3z39lR9jMgmnzuzbHoimLTJhkCbpWK7lsi2cl5YMk6T8YbStng8YSoK4
         sbh7VJZMs2Z+UN2qa5BsfQ+CJ1LGPAeetghF2RTlwedDLPk/GoQwgLGc11gtYu2YddAF
         0OwL/M9kZ28O49LwafkxFl8vL7UCeyN8fPMAGIKTCez7tCMH0exTi59a9yLTh3o0+7vs
         wAp3xgDeNlhMS9nvnsJD7CURHxMjKmUVnYoUw/waO3wVe0cbqdfm7izXu1Q+LgFDgCGo
         2Mf8p5IwzzsQuFrM9PO1K9vaE+JYOdzaRl778idSbr2kmksVpY1Mz07YkkSdt2sWzfBu
         //+g==
X-Gm-Message-State: AO0yUKU3TsUko3vfEkAUbJ/L3BzYzzK94/dUlONUOE18/vizSnEfKFou
        /UcohTAqFe0MRa6YtUVBHHJ1Mg6zclCqsCiGTxxMww==
X-Google-Smtp-Source: AK7set8G/6ISFHb7vhOMOnRTtv3rW4MA87GnQYO4pEhykQbb7DjaZ7t8AbGOGTB/SO5x4X4fe0deeiznRkYANfftwBE=
X-Received: by 2002:a05:6102:2e1:b0:411:c393:2def with SMTP id
 j1-20020a05610202e100b00411c3932defmr874047vsj.40.1675972202586; Thu, 09 Feb
 2023 11:50:02 -0800 (PST)
MIME-Version: 1.0
References: <Y9qRta3bd4JqjUHx@x1n> <CADrL8HU809O0cPa9hXjf3k+ob139SQqvxOvpqm6UEv=zrPjHSg@mail.gmail.com>
 <Y9re82gctIZf08cX@x1n> <CADrL8HVja_xJ9qczsd-fQfEPvEEXswhXQwoan=a_LSMyORvqww@mail.gmail.com>
 <CADrL8HUSx6=K0QXQtTmv9ZJQmvhe6KEb+FiAviRfO3HjmRUeTw@mail.gmail.com>
 <CADrL8HUm7g4pBLv9vjmB-LhJqxm4jyksGJQAdwRsweKKAnofDg@mail.gmail.com>
 <Y+LbEY62MT/3yo7I@x1n> <CADrL8HUVCXHsaWU7beYQsLw0C7J730PQm45caKE26V8mCFHjKQ@mail.gmail.com>
 <Y+PKwvLT8+wQ6LPA@x1n> <CADrL8HUZON-Fc9YxPyTA21AY02OgEXDDsmq9AUSMSxjr83ndYA@mail.gmail.com>
 <Y+VFPX+ToMY27uiw@x1n>
In-Reply-To: <Y+VFPX+ToMY27uiw@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 9 Feb 2023 11:49:25 -0800
Message-ID: <CADrL8HUu5xk5Qo2xJg6qhBXep2W5uwH1zHLat-4hhGOsreH8Rg@mail.gmail.com>
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for walk_hugetlb_range
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 9, 2023 at 11:11 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Feb 09, 2023 at 08:43:45AM -0800, James Houghton wrote:
> > On Wed, Feb 8, 2023 at 8:16 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Tue, Feb 07, 2023 at 04:26:02PM -0800, James Houghton wrote:
> > > > On Tue, Feb 7, 2023 at 3:13 PM Peter Xu <peterx@redhat.com> wrote:
> > > > >
> > > > > James,
> > > > >
> > > > > On Tue, Feb 07, 2023 at 02:46:04PM -0800, James Houghton wrote:
> > > > > > > Here is the result: [1] (sorry it took a little while heh). The
> > > > >
> > > > > Thanks.  From what I can tell, that number shows that it'll be great we
> > > > > start with your rfcv1 mapcount approach, which mimics what's proposed by
> > > > > Matthew for generic folio.
> > > >
> > > > Do you think the RFC v1 way is better than doing the THP-like way
> > > > *with the additional MMU notifier*?
> > >
> > > What's the additional MMU notifier you're referring?
> >
> > An MMU notifier that informs KVM that a collapse has happened without
> > having to invalidate_range_start() and invalidate_range_end(), the one
> > you're replying to lower down in the email. :) [ see below... ]
>
> Isn't that something that is needed no matter what mapcount approach we'll
> go for?  Did I miss something?

It's not really needed for anything, but it could be an optimization
for both approaches. However, for the subpage-mapcount approach, it
would have a *huge* impact. That's what I mean.

>
> >
> > >
> > > >
> > > > >
> > > > > > > implementation of the "RFC v1" way is pretty horrible[2] (and this
> > > > >
> > > > > Any more information on why it's horrible? :)
> > > >
> > > > I figured the code would speak for itself, heh. It's quite complicated.
> > > >
> > > > I really didn't like:
> > > > 1. The 'inc' business in copy_hugetlb_page_range.
> > > > 2. How/where I call put_page()/folio_put() to keep the refcount and
> > > > mapcount synced up.
> > > > 3. Having to check the page cache in UFFDIO_CONTINUE.
> > >
> > > I think the complexity is one thing which I'm fine with so far.  However
> > > when I think again about the things behind that complexity, I noticed there
> > > may be at least one flaw that may not be trivial to work around.
> > >
> > > It's about truncation.  The problem is now we use the pgtable entry to
> > > represent the mapcount, but the pgtable entry cannot be zapped easily,
> > > unless vma unmapped or collapsed.
> > >
> > > It means e.g. truncate_inode_folio() may stop working for hugetlb (of
> > > course, with page lock held).  The mappings will be removed for real, but
> > > not the mapcount for HGM anymore, because unmap_mapping_folio() only zaps
> > > the pgtable leaves, not the ones that we used to account for mapcounts.
> > >
> > > So the kernel may see weird things, like mapcount>0 after
> > > truncate_inode_folio() being finished completely.
> > >
> > > For HGM to do the right thing, we may want to also remove the non-leaf
> > > entries when truncating or doing similar things like a rmap walk to drop
> > > any mappings for a page/folio.  Though that's not doable for now because
> > > the locks that truncate_inode_folio() is weaker than what we need to free
> > > the pgtable non-leaf entries - we'll need mmap write lock for that, the
> > > same as when we unmap or collapse.
> > >
> > > Matthew's design doesn't have such issue if the ptes need to be populated,
> > > because mapcount is still with the leaves; not the case for us here.
> > >
> > > If that's the case, _maybe_ we still need to start with the stupid but
> > > working approach of subpage mapcounts.
> >
> > Good point. I can't immediately think of a solution. I would prefer to
> > go with the subpage mapcount approach to simplify HGM for now;
> > optimizing mapcount for HugeTLB can then be handled separately. If
> > you're ok with this, I'll go ahead and send v2.
>
> I'm okay with it, but I suggest wait for at least another one day or two to
> see whether Mike or others have any comments.

Ok. :)

>
> >
> > One way that might be possible: using the PAGE_SPECIAL bit on the
> > hstate-level PTE to indicate if mapcount has been incremented or not
> > (if the PTE is pointing to page tables). As far as I can tell,
> > PAGE_SPECIAL doesn't carry any meaning for HugeTLB PTEs, but we would
> > need to be careful with existing PTE examination code as to not
> > misinterpret these PTEs.
>
> This is an interesting idea. :) Yes I don't see it being used at all in any
> pgtable non-leaves.
>
> Then it's about how to let the zap code know when to remove the special
> bit, hence the mapcount, because not all of them should.
>
> Maybe it can be passed over as a new zap_flags_t bit?

Here[1] is one way it could be done (it doesn't work 100% correctly,
it's just approximately what we could do). Basically we pass in the
entire range that we are unmapping ("floor" and "ceil"), and if
hugetlb_remove_rmap finds that we're doing the final removal of a page
that we are entirely unmapping (i.e., floor <= addr &
huge_page_mask(h)). Having a zap flag would probably work too.

I think something like [1] ought to go in its own series. :)

[1]: https://github.com/48ca/linux/commit/de884eaaadf61b8dcfb1defd99bbf487667e46f4

- James
