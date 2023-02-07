Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE8568E445
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 00:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjBGXON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 18:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjBGXOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 18:14:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC58CA27D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 15:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675811606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oNi+RiOGKSiKkCvek9MkTYvmX4eAt2gu4PyrGvqMVkw=;
        b=XdYeJQifB0Ao3jhlguAltLmMFTRs0tkiGv8mADKNeXX+SZoM9Rfr1elZ0ttah6xcMXUJmf
        69qc/LtqydUOg1h6c+n8NPXj2nBx1a/NbktvLrBMoIm+oOlH4dMOHCVOkdRQ2TvMVq+qUL
        GDLHyoCtpvryzEayq+HdtnVNAkgdCcY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-286-pGMs-r32ObqqzeMZZxgF0g-1; Tue, 07 Feb 2023 18:13:24 -0500
X-MC-Unique: pGMs-r32ObqqzeMZZxgF0g-1
Received: by mail-qt1-f200.google.com with SMTP id c14-20020ac87d8e000000b003ba2d72f98aso3622572qtd.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 15:13:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNi+RiOGKSiKkCvek9MkTYvmX4eAt2gu4PyrGvqMVkw=;
        b=vHFUEkFfx2U9Unl7OBQNRx8UDrZqiv1tOMsje3zDI2XZNkjnrgkklYCdNvuIfR/blc
         qVbsFyGgq8hMPZOHqx98091N9mBlC36oHU7uveHjLPDXQRPdakWqEgD2laJALHROCp+s
         oeRsfqefDSB12xTPuVP0H5eUKRBZq5O/ZolPUA/k4x6tjWaSBmS9T+EgqzaNnK8fJV4Q
         q9vmrzCQnHSPEgFMV5syjivHZxgc72t2FHJTevXUGuV4l2tXo4wtkcGKKM9MNmAHYmJ/
         8SZ4MoNKn1jCVShlJi5sQQj05mBJ0ll1j2heEb0JFys4gWFQghah1ef70EMb0hVpqzmC
         OoMg==
X-Gm-Message-State: AO0yUKWN7g4BEcHV9QmelBixMDkrV7ggRGr+6SScmL8VLz/FiuVRHDu/
        WGxK2R3vG/F0/Zn9hH6h0GKBI2YuFNO5BhG1yzI15WH+3gfW/E43T80UB6QzMoF+xIXI3qCRcuF
        wl+Gqr88kyS1ulMZ6DSMnrBCz
X-Received: by 2002:a05:622a:4d2:b0:3b8:58d0:b4d4 with SMTP id q18-20020a05622a04d200b003b858d0b4d4mr10092224qtx.2.1675811604207;
        Tue, 07 Feb 2023 15:13:24 -0800 (PST)
X-Google-Smtp-Source: AK7set/fD/RYcwuAx/Q8KI9xxvqAde2ZVSyohDdEwjWF4qCzRiGAo8bC9aG2GlTiryK0d9nBiXoktw==
X-Received: by 2002:a05:622a:4d2:b0:3b8:58d0:b4d4 with SMTP id q18-20020a05622a04d200b003b858d0b4d4mr10092186qtx.2.1675811603900;
        Tue, 07 Feb 2023 15:13:23 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id h184-20020a376cc1000000b006fcb77f3bd6sm10272129qkc.98.2023.02.07.15.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 15:13:23 -0800 (PST)
Date:   Tue, 7 Feb 2023 18:13:21 -0500
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
Message-ID: <Y+LbEY62MT/3yo7I@x1n>
References: <Y9gzOqwKcu7p/PEw@x1n>
 <CADrL8HXX9YDFUxmPPsm2s3Pno0XXgAyFB40fV1PdtP9eb-5D2A@mail.gmail.com>
 <Y9m/VVRABt0Blfjh@x1n>
 <CADrL8HXpfTE1+eE3rNGQyOr1QRtDtG5mBp-b3xcNX22QJRvPaQ@mail.gmail.com>
 <Y9qRta3bd4JqjUHx@x1n>
 <CADrL8HU809O0cPa9hXjf3k+ob139SQqvxOvpqm6UEv=zrPjHSg@mail.gmail.com>
 <Y9re82gctIZf08cX@x1n>
 <CADrL8HVja_xJ9qczsd-fQfEPvEEXswhXQwoan=a_LSMyORvqww@mail.gmail.com>
 <CADrL8HUSx6=K0QXQtTmv9ZJQmvhe6KEb+FiAviRfO3HjmRUeTw@mail.gmail.com>
 <CADrL8HUm7g4pBLv9vjmB-LhJqxm4jyksGJQAdwRsweKKAnofDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HUm7g4pBLv9vjmB-LhJqxm4jyksGJQAdwRsweKKAnofDg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James,

On Tue, Feb 07, 2023 at 02:46:04PM -0800, James Houghton wrote:
> > Here is the result: [1] (sorry it took a little while heh). The

Thanks.  From what I can tell, that number shows that it'll be great we
start with your rfcv1 mapcount approach, which mimics what's proposed by
Matthew for generic folio.

> > implementation of the "RFC v1" way is pretty horrible[2] (and this

Any more information on why it's horrible? :)

A quick comment is I'm wondering whether that "whether we should boost the
mapcount" value can be hidden in hugetlb_pte* so you don't need to pass
over a lot of bool* deep into the hgm walk routines.

> > implementation probably has bugs anyway; it doesn't account for the
> > folio_referenced() problem).

I thought we reached a consensus on the resolution, by a proposal to remove
folio_referenced_arg.mapcount.  Is it not working for some reason?

> >
> > Matthew is trying to solve the same problem with THPs right now: [3].
> > I haven't figured out how we can apply Matthews's approach to HGM
> > right now, but there probably is a way. (If we left the mapcount
> > increment bits in the same place, we couldn't just check the
> > hstate-level PTE; it would have already been made present.)

I'm just worried that (1) this may add yet another dependency to your work
which is still during discussion phase, and (2) whether the folio approach
is easily applicable here, e.g., we may not want to populate all the ptes
for hugetlb HGMs by default.

> >
> > We could:
> > - use the THP-like way and tolerate ~1 second collapses
> 
> Another thought here. We don't necessarily *need* to collapse the page
> table mappings in between mmu_notifier_invalidate_range_start() and
> mmu_notifier_invalidate_range_end(), as the pfns aren't changing,
> we aren't punching any holes, and we aren't changing permission bits.
> If we had an MMU notifier that simply informed KVM that we collapsed
> the page tables *after* we finished collapsing, then it would be ok
> for hugetlb_collapse() to be slow.

That's a great point!  It'll definitely apply to either approach.

> 
> If this MMU notifier is something that makes sense, it probably
> applies to MADV_COLLAPSE for THPs as well.

THPs are definitely different, mmu notifiers should be required there,
afaict.  Isn't that what the current code does?

See collapse_and_free_pmd() for shmem and collapse_huge_page() for anon.

> 
> 
> > - use the (non-RFC) v1 way and tolerate the migration/smaps differences
> > - use the RFC v1 way and tolerate the complicated mapcount accounting
> > - flesh out [3] and see if it can be applied to HGM nicely
> >
> > I'm happy to go with any of these approaches.
> >
> > [1]: https://pastebin.com/raw/hJzFJHiD
> > [2]: https://github.com/48ca/linux/commit/4495f16a09b660aff44b3edcc125aa3a3df85976
> > [3]: https://lore.kernel.org/linux-mm/Y+FkV4fBxHlp6FTH@casper.infradead.org/
> 
> - James
> 

-- 
Peter Xu

