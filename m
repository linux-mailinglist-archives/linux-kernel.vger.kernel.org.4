Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C996F64B7BA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbiLMOsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbiLMOr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:47:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81951152
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=vAgoNGGNFWw+Ql8a9hTqqWYJABEeT5+mK+PPBOcML5g=; b=Kt4Whzyah49ucXbgVrZGqQ1Ihe
        M+uGhzv8248mtUrrmhdcEYwxAmSOGlvLwFwue332mfvfafg7LXpMM2I0dCf+sN1R+ZUv1UgFSokhU
        x8bMk1B6AsiL0KYsaEJ5DwwlOW3ozuVIwuwUCR26f4QKZLXhLyAidkTXj9ZDuxQW1IQ+xMw0LXHO8
        XsHBsAS0A/b2aPzlW/2sezuWXRouMmuTB//p5OAHlraHdIphAGKeRv64VFGQ+YX03EPot2uQkHysJ
        fgS4j/us5Kvl4+dR6qo77YPUmk3LiUStfhYcYYVXeO1Pj3NS60D2eD6Vu483aCwO29Pxb78yWMbT2
        6z8gUIog==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p56ZO-00CJUz-OK; Tue, 13 Dec 2022 14:47:46 +0000
Date:   Tue, 13 Dec 2022 14:47:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        SeongJae Park <sj@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, damon@lists.linux.dev,
        vishal.moola@gmail.com
Subject: Re: [PATCH -next 1/8] mm: memory_hotplug: add pfn_to_online_folio()
Message-ID: <Y5iQkmjj1ISoTWAF@casper.infradead.org>
References: <20221213092735.187924-1-wangkefeng.wang@huawei.com>
 <20221213092735.187924-2-wangkefeng.wang@huawei.com>
 <f07d1c95-f13c-682b-0519-0b137ccdc631@redhat.com>
 <801ccbe2-08b8-e1cb-9aee-614d59a807d2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <801ccbe2-08b8-e1cb-9aee-614d59a807d2@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 08:13:31PM +0800, Kefeng Wang wrote:
> 
> On 2022/12/13 19:40, David Hildenbrand wrote:
> > On 13.12.22 10:27, Kefeng Wang wrote:
> > > Introduce a wrapper function pfn_to_online_folio(), which calls
> > > pfn_to_online_page() and returns the folio of the page found,
> > > or null if no page.
> > > 
> > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > > ---
> > >   include/linux/memory_hotplug.h | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/include/linux/memory_hotplug.h
> > > b/include/linux/memory_hotplug.h
> > > index 9fcbf5706595..e841e4fb52a7 100644
> > > --- a/include/linux/memory_hotplug.h
> > > +++ b/include/linux/memory_hotplug.h
> > > @@ -265,6 +265,13 @@ static inline void
> > > pgdat_kswapd_unlock(pg_data_t *pgdat) {}
> > >   static inline void pgdat_kswapd_lock_init(pg_data_t *pgdat) {}
> > >   #endif /* ! CONFIG_MEMORY_HOTPLUG */
> > >   +static inline struct folio *pfn_to_online_folio(unsigned long pfn)
> > > +{
> > > +    struct page *page = pfn_to_online_page(pfn);
> > > +
> > > +    return page ? page_folio(page) : NULL;
> > > +}
> > 
> > Who guarantees that page_folio() is safe and stable at that point?
> > 
> > IIRC, that's very tricky. We could have the page concurrently getting
> > freed and the folio dissolved.
> So the caller should consider this,  lock or get the folio in the caller?

The caller only has a pfn; it doesn't have the folio at the time of
the call.  David is right, this function cannot safely exist.
