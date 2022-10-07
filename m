Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793765F7D22
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 20:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJGSFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 14:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiJGSDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 14:03:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E5A86F90
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 11:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S2z7kL/puGmrjNYlyHAwGHHEwyzprFts21kmJPvb+tA=; b=stIurYOm1Eq5Jmv9ryuWsRZALi
        S9nb4Z/bfXmUrPUhWv3StqLFqxF/QyVqlUSwbVnUgGsXD2ZGX1OsvDVKzmz7hpk6LP/lL4a4Nw6Tn
        AIfqou5bRhZewiYU53EvuEoitfLf6mkhGoko08mdshH6vAuDA+NB0qvE3DougXZr+17YHTnJihD6b
        sF5DVL8WnOEa+EJVEHOn4K/TVAwt/fj/qsnE/kBMKN2NNVXKxkcU7lLycd54yNweptmfGj9Zkuk/R
        ZW6cKdNVO2kDtbtH9XofNXSzKGvoMu2fwnsC4unM8lfIs5cD6YntnoCQkYEBeNW8pJ8WCguiBgaiz
        07l0XqFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogrgB-0024GK-TE; Fri, 07 Oct 2022 18:02:35 +0000
Date:   Fri, 7 Oct 2022 19:02:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH] mm: move PG_slab flag to page_type
Message-ID: <Y0BpuxUb+Y8BKHIM@casper.infradead.org>
References: <20220919125708.276864-1-42.hyeyoo@gmail.com>
 <Yy+NCJ525S+HzP4k@casper.infradead.org>
 <Y0AreJczk6FdiKxr@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0AreJczk6FdiKxr@hyeyoo>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 10:36:56PM +0900, Hyeonggon Yoo wrote:
> > First, you say that folio_mapped() returns false for slab pages.  That's
> > only true for order-0 slab pages.  For larger pages,
> > 
> >         if (!folio_test_large(folio))
> >                 return atomic_read(&folio->_mapcount) >= 0;
> >         if (atomic_read(folio_mapcount_ptr(folio)) >= 0)
> >                 return true;
> > 
> > so that's going to depend what folio_mapcount_ptr() aliases with.
> 
> IIUC it's true for order > 0 slab too.
> 
> As slab pages are not mapped to userspace at all,
> entire compound page nor base pages are not mapped to userspace.
> 
> AFAIK followings are true for order > 0 slab:
>         - (first tail page)->compound_mapcount is -1

That's the part I wasn't sure of.  I think we do, in
prep_compound_head().

>         - _mapcount of base pages are -1
> 
> So:
>         folio_mapped() and page_mapped() (if applied to head page)
>         returns false for larger pages with this patch.
> 
> I wrote simple testcase and did check that folio_mapped() and page_mapped()
> returns false for both order-0 page and larger pages. (and SLAB
> returned true for them before)
> 
> > Second, this patch changes the behaviour of PageSlab() when applied to
> > tail pages.
> 
> Altough it changes the way it checks the flag,
> 
> it does not change behavior when applied to tail pages - PageSlab() on tail
> page returns false with or without this patch.

Really?  It seems to me that it returns true at the moment.  Look:

__PAGEFLAG(Slab, slab, PF_NO_TAIL)

#define PF_NO_TAIL(page, enforce) ({                                    \
                VM_BUG_ON_PGFLAGS(enforce && PageTail(page), page);     \
                PF_POISONED_CHECK(compound_head(page)); })

so AFAICS, PageSlab checks the Slab bit on the head page, not the
tail page.

> If PageSlab() need to return true for tail pages too,
> we may make it check page_type at head page.
> 
> But I'm not sure when it the behavior is needed.
> Can you please share your insight on this?

There are tools like tools/vm/page-types.c which expect PageSlab to
return true for tail pages.

> > Which raises the further question of what PageBuddy(),
> > PageTable(), PageGuard() and PageIsolated() should do for multi-page
> > folios, if that is even possible.
> 
> For users that uses real compound page like slab, we can make it check
> page_type of head page. (if needed)
> 
> But for cases David described, there isn't much thing we can do
> except making them to use real compound pages.
> 
> > Third, can we do this without that awkward __u16 thing?  Perhaps
> > 
> > -#define PG_buddy        0x00000080
> > -#define PG_offline      0x00000100
> > -#define PG_table        0x00000200
> > -#define PG_guard        0x00000400
> > +#define PG_buddy        0x00010000
> > +#define PG_offline      0x00020000
> > +#define PG_table        0x00040000
> > +#define PG_guard        0x00080000
> > +#define PG_slab         0x00100000
> > 
> > ... and then use wrappers in slab.c to access the bottom 16 bits?
> 
> Definitely! I prefer that way and will adjust in RFC v2.
> 
> Thank you for precious feedback.

No problem.  I suggested (in an off-list email) that you consider counting
'active' by subtraction rather than addition because I have a feeling that

int active(struct slab *slab)
{
	return ~(slab->page_type | PG_slab);
}

would be better than

int active(struct slab *slab)
{
	return slab->page_type & 0xffff;
}

at least in part because you don't have to clear the bottom 16 bits of
page_type when you clear PG_slab, and you don't have to re-set them
when you set PG_slab.
