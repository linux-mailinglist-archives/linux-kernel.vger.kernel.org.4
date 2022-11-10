Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBDA623A04
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 03:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiKJCth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 21:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbiKJCte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 21:49:34 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515C4B1E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 18:49:33 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id v8so406285qkg.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 18:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6TexcarRbXmqxk9wL/ILQGc5M5ZNt/RsOVA+Ap3ji0g=;
        b=RSnomFS+DpxFQ06pn86pqBbEYB/57ZUBxzIpuydZoXglzD5HpP3WFKoAo55bDZFkV/
         7sKsp3at97zghtT7UozO7c2F2lPnSuGPgXU/Iy6AHVTMNYr+IKkshzzK81p5+zJ1z+zI
         Vu1u0/CuV763qShcU1xpOasxEaGKn7sjbn6JjPDCM367Eu9SH/Eeb/sfGr58z6LlhmbC
         9q+6m0y3FEUSM0vtlMDW2ixCYuJu6RlkrMUpbbXJC8xmHJYwFEfGIOXfcklPN2Cmpnln
         CF8gy/JjUgWsfoiDcnfoEWnvMZYOAjHDmbVaezszHY8wwKDyFmJkq3iahqbami6YT1VA
         1AYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6TexcarRbXmqxk9wL/ILQGc5M5ZNt/RsOVA+Ap3ji0g=;
        b=vRV3/pTbKD+WejA4R4jb7xYO+/QNUXSZz2U7kfUDuowNFPUoumELpuRYsYBUAhC9E8
         onCrcdz4cqIKHUW64lBcssWddRGFuAps1/Uf8Jd5AW4m3J6AS9iVKgO8SURhkbZifvhe
         ipPqp3ebcWdHC8F4KBEVFp5WNbb6K0peB/y/cP/wpOxBN9co+k+LIoyLjAA2W6UiW+W2
         e2n2jAWaqEsvL4wpumXl4DUBN2MRej0vXmfyOeQH4Wv4HhQkPIF4JKotYtXKlZvscOQZ
         lOlGFxEybg49kww13V2Cqmp5240R+h5XWZuFppUWMPPcEFhlIXycnd9ezdcbL0QIpHBU
         Mpog==
X-Gm-Message-State: ANoB5plULJnEyf6OsRmHcaMWwyZtw6LW5E68Bk+T/oDA8t3NI6nrhIP8
        8hDly7AsmAt23MPdmXZRHiIQlg==
X-Google-Smtp-Source: AA0mqf5FmcgaLL3XZUshwPdzBGYydVkpziELkDAGxVKJRzGZg+afKWMa0WH0YqlRUzMlyR5uj1wGmQ==
X-Received: by 2002:a37:de17:0:b0:6fa:d987:a574 with SMTP id h23-20020a37de17000000b006fad987a574mr13720155qkj.329.1668048572349;
        Wed, 09 Nov 2022 18:49:32 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h3-20020a05620a244300b006fa4cac54a4sm11271564qkn.133.2022.11.09.18.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 18:49:31 -0800 (PST)
Date:   Wed, 9 Nov 2022 18:49:29 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] mm,thp,rmap: simplify compound page mapcount
 handling
In-Reply-To: <20221105195115.2d5yvvepdjsqjmmv@box>
Message-ID: <7f9e1dfb-64f7-62a1-f35-988825303814@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com> <47ad693-717-79c8-e1ba-46c3a6602e48@google.com> <20221105195115.2d5yvvepdjsqjmmv@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sat, 5 Nov 2022, Kirill A. Shutemov wrote:
> On Wed, Nov 02, 2022 at 06:51:38PM -0700, Hugh Dickins wrote:
> 
> Thanks for doing this!
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Thanks!

> 
> And sorry again for PageDoubleMap() :/

It did serve a real purpose, but I always found it hard to live with,
and I'm glad that you're happy it's gone too :)

> 
> Minor nitpick and a question below.
> 
> > @@ -829,12 +829,20 @@ static inline int folio_entire_mapcount(struct folio *folio)
> >  
> >  /*
> >   * Mapcount of compound page as a whole, does not include mapped sub-pages.
> > - *
> > - * Must be called only for compound pages.
> > + * Must be called only on head of compound page.
> >   */
> > -static inline int compound_mapcount(struct page *page)
> > +static inline int head_compound_mapcount(struct page *head)
> >  {
> > -	return folio_entire_mapcount(page_folio(page));
> > +	return atomic_read(compound_mapcount_ptr(head)) + 1;
> > +}
> > +
> > +/*
> > + * Sum of mapcounts of sub-pages, does not include compound mapcount.
> > + * Must be called only on head of compound page.
> > + */
> > +static inline int head_subpages_mapcount(struct page *head)
> > +{
> > +	return atomic_read(subpages_mapcount_ptr(head));
> >  }
> >  
> >  /*
> 
> Any particular reason these two do not take struct folio as an input?
> It would guarantee that it is non-tail page. It will not guarantee
> large-folio, but it is something.

The actual reason is that I first did this work in a pre-folio tree;
and even now I am much more at ease with compound pages than folios.

But when I looked to see if I ought to change them, found that the
only uses are below in this header file, or in __dump_page() or in
free_tail_pages_check() - low-level functions, page-oriented and
obviously on head.  So I wasn't tempted to change them at all.

> 
> > @@ -1265,8 +1288,6 @@ void page_add_new_anon_rmap(struct page *page,
> >  		VM_BUG_ON_PAGE(!PageTransHuge(page), page);
> >  		/* increment count (starts at -1) */
> >  		atomic_set(compound_mapcount_ptr(page), 0);
> > -		atomic_set(compound_pincount_ptr(page), 0);
> > -
> 
> It has to be initialized to 0 on allocation, right?

That's right.  I was going to say that I'd commented on this in the
commit message, but no, it looks like I only commented on the instance
in hugepage_add_new_new_anon_rmap() (and added the "increment" comment
line from here to there).

I visited both those functions to add a matching subpages_mapcount
initialization; then realized that the pincount addition had missed
the point, initialization to 0 has already been done, and the
compound_mapcount line is about incrementing from -1 to 0,
not about initializing.

There are similar places in mm/hugetlb.c, where I did add the
subpages_mapcount initialization to the compound_pincount and
compound_mapcount initializations: that's because I'm on shaky ground
with hugetlb page lifecycle, and not so sure of their status there.

Hugh
