Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA693667994
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240570AbjALPjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240613AbjALPiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:38:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAA722A
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673537356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZMH7oL1ojLL00OhcJ9kVNoLAkEuf5OtGz8iT68u8uvU=;
        b=jB+T2k/B1/shth6Mmz/YaxghoQ27AOPEzQhcWV9fcuIrin6+2OR6k37m512qbLslP3a4Fq
        YsgdG41bgyrQ7hHx6qbeWqZILiKQv0UqZVhgNqeJSyHLDssVQng2eOuFdslx3eecvHtESJ
        d68VDDCQ7fnFIHM0w05pTz4Z9udhkoM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-394-6a2wk7-IOEuhY2kbZgNOoA-1; Thu, 12 Jan 2023 10:29:12 -0500
X-MC-Unique: 6a2wk7-IOEuhY2kbZgNOoA-1
Received: by mail-qk1-f198.google.com with SMTP id m9-20020a05620a290900b0070596994c7eso13276399qkp.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:29:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMH7oL1ojLL00OhcJ9kVNoLAkEuf5OtGz8iT68u8uvU=;
        b=3slMYka8G1sLEciUpswL72dCa1Iifys3ecX3RsP2NsbZBj8Jmkmfj1FoUOsTogvtRv
         vXGDL4Pnw6M5X0g66D9W3BFypKWUe3c7dVpyHI+VDijpeSoy59Y2268sE6QpbnVGrlQ6
         nNyS+flphc81k2OJDHSeo7w+1u8dIDb9f7oHYq1SOVv5ueQm8Mv3jDR4T4YkYdawo94+
         fyJf4zS/M89LSVivOV6tnQOFEEXW5WA8sJkQ5MVKO1OqQ/1cD3gx4Z+r3irOKVUN+hG0
         YyncWCs5zlHwglUkz+iM4Hc5JZiO9KkXpQIa6+JxUMIlxOgUHOPBJnjMcb4mjiX1M+Wo
         WWhg==
X-Gm-Message-State: AFqh2krr0nrAx9qSXG+Sq38//EPBxMMKZXOikb1/A/U1bJyHvrx1qaGR
        DesUIfUeHh37K+94lplS9xy/aMqxc3spJMv4jp8vtyhmUdCl7rsnpd5DYWZIhhtbOHcYwjoCDfb
        OqNWObo7ieojACSffb96RddjP
X-Received: by 2002:a05:622a:2510:b0:3a8:1677:bc39 with SMTP id cm16-20020a05622a251000b003a81677bc39mr69643456qtb.52.1673537351602;
        Thu, 12 Jan 2023 07:29:11 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu+8O/sWnQ31LlfQAmjSWTP3JKBg/z6LUtFrCFt7Nlxp9dZVZSfnBngoTT8ia8+jKxx3f5ybA==
X-Received: by 2002:a05:622a:2510:b0:3a8:1677:bc39 with SMTP id cm16-20020a05622a251000b003a81677bc39mr69643426qtb.52.1673537351249;
        Thu, 12 Jan 2023 07:29:11 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id f9-20020ac80689000000b00343057845f7sm9164029qth.20.2023.01.12.07.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:29:10 -0800 (PST)
Date:   Thu, 12 Jan 2023 10:29:08 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
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
Message-ID: <Y8AnROAtMngKntnq@x1n>
References: <20230105101844.1893104-1-jthoughton@google.com>
 <20230105101844.1893104-22-jthoughton@google.com>
 <Y78+/wleTEC3gyqu@x1n>
 <CADrL8HU-prbfx2xxXCi0RPznp5DB68-NjqqmdM+4aUeUUURhiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HU-prbfx2xxXCi0RPznp5DB68-NjqqmdM+4aUeUUURhiA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 09:06:48AM -0500, James Houghton wrote:
> On Wed, Jan 11, 2023 at 5:58 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > James,
> >
> > On Thu, Jan 05, 2023 at 10:18:19AM +0000, James Houghton wrote:
> > > @@ -751,9 +761,9 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
> > >               int mapcount = page_mapcount(page);
> > >
> > >               if (mapcount >= 2)
> > > -                     mss->shared_hugetlb += huge_page_size(hstate_vma(vma));
> > > +                     mss->shared_hugetlb += hugetlb_pte_size(hpte);
> > >               else
> > > -                     mss->private_hugetlb += huge_page_size(hstate_vma(vma));
> > > +                     mss->private_hugetlb += hugetlb_pte_size(hpte);
> > >       }
> > >       return 0;
> >
> > One thing interesting I found with hgm right now is mostly everything will
> > be counted as "shared" here, I think it's because mapcount is accounted
> > always to the huge page even if mapped in smaller sizes, so page_mapcount()
> > to a small page should be huge too because the head page mapcount should be
> > huge.  I'm curious the reasons behind the mapcount decision.
> >
> > For example, would that risk overflow with head_compound_mapcount?  One 1G
> > page mapping all 4K takes 0.25M counts, while the limit should be 2G for
> > atomic_t.  Looks like it's possible.
> 
> The original mapcount approach was "if the hstate-level PTE is
> present, increment the compound_mapcount by 1" (basically "if any of
> the hugepage is mapped, increment the compound_mapcount by 1"), but
> this was painful to implement,

Any more info here on why it was painful?  What is the major blocker?

> so I changed it to what it is now (each new PT mapping increments the
> compound_mapcount by 1). I think you're right, there is absolutely an
> overflow risk. :( I'm not sure what the best solution is. I could just go
> back to the old approach.

No rush on that; let's discuss it thoroughly before doing anything.  We
have more context than when it was discussed initially in the calls, so
maybe a good time to revisit.

> 
> Regarding when things are accounted in private_hugetlb vs.
> shared_hugetlb, HGM shouldn't change that, because it only applies to
> shared mappings (right now anyway). It seems like "private_hugetlb"
> can include cases where the page is shared but has only one mapping,
> in which case HGM will change it from "private" to "shared".

The two fields are not defined against VM_SHARED, it seems.  At least not
with current code base.

Let me quote the code again just to be clear:

		int mapcount = page_mapcount(page);    <------------- [1]

		if (mapcount >= 2)
			mss->shared_hugetlb += hugetlb_pte_size(hpte);
		else
			mss->private_hugetlb += hugetlb_pte_size(hpte);

		smaps_hugetlb_hgm_account(mss, hpte);

So that information (for some reason) is only relevant to how many mapcount
is there.  If we have one 1G page and only two 4K mapped, with the existing
logic we should see 8K private_hugetlb while in fact I think it should be
8K shared_hugetlb due to page_mapcount() taking account of both 4K mappings
(as they all goes back to the head).

I have no idea whether violating that will be a problem or not, I suppose
at least it needs justification if it will be violated, or hopefully it can
be kept as-is.

> 
> >
> > Btw, are the small page* pointers still needed in the latest HGM design?
> > Is there code taking care of disabling of hugetlb vmemmap optimization for
> > HGM?  Or maybe it's not needed anymore for the current design?
> 
> The hugetlb vmemmap optimization can still be used with HGM, so there
> is no code to disable it. We don't need small page* pointers either,
> except for when we're dealing with mapping subpages, like in
> hugetlb_no_page. Everything else can handle the hugetlb page as a
> folio.
> 
> I hope we can keep compatibility with the vmemmap optimization while
> solving the mapcount overflow risk.

Yeh that'll be perfect if it works.  But afaiu even with your current
design (ignoring all the issues on either smaps accounting or overflow
risks), we already referenced the small pages, aren't we?  See:

static inline int page_mapcount(struct page *page)
{
	int mapcount = atomic_read(&page->_mapcount) + 1;  <-------- here

	if (likely(!PageCompound(page)))
		return mapcount;
	page = compound_head(page);
	return head_compound_mapcount(page) + mapcount;
}

Even if we assume small page->_mapcount should always be zero in this case,
we may need to take special care of hugetlb pages in page_mapcount() to not
reference it at all.  Or I think it's reading random values and some days
it can be non-zero.

The other approach is probably using the thp approach.  After Hugh's rework
on the thp accounting I assumed it would be even cleaner (at least no
DoubleMap complexity anymore.. even though I can't say I fully digested the
whole history of that).  It's all about what's the major challenges of
using the same approach there with thp.  You may have more knowledge on
that aspect so I'd be willing to know.

Thanks,

-- 
Peter Xu

