Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164AA6337DB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbiKVJEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbiKVJDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:03:55 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8051391E8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:03:54 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id m7-20020a9d6447000000b0066da0504b5eso8902208otl.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xxiV6Y0Y6sfCT/ieR4TcyBVO0torIXGTRcmTsYBc9t0=;
        b=BIkobYqdKLM1FKhedwiDK5ICkJ4IaitoqlBHAnL55vXD7BRqxq5jfKgpaqrW0I70ko
         hyWSKYO8xgV471syHCqdDr1hbfbOgme2goGQytDv+JMs9qdiprVhZMKaekE9zwRXjjf5
         U+Lx98xIX1aa1DssSrs9WUhBtzw0TKbpA3ih8tJ6wIeUH/NQmgNtPjYs7t/iFRhcnijQ
         9nwYLB1wVmRdaKqQC4x1z+w9+OcEM+0kfEzCRm58F21LNLLInN+iyrujZJmmV0Wt6bws
         3BC2Pq7QhCBXuNN1OPKAQi63USPM13ocD2mGb1t9zPow6/9BFt6ts1f7z0aKikVvMIkI
         9S1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxiV6Y0Y6sfCT/ieR4TcyBVO0torIXGTRcmTsYBc9t0=;
        b=ry30ArlH00/glmyzXZ8uyppWXjCJqgJAJmywJB7djhvBxjQZ2IJZNI3grU5zkIR0fA
         tphgQZogEc/MDJJFBr1smEiMvH6omN7QLuBxbkil/K6W6Kf6Ogih7hX72nF3Bfy5fkVT
         FHyZbBs6dHtfJQG+9BFYsx5Y8gw+5Zyyj2EAzu4zxKs4URvZg9V49BWhnI59XGIZ8p3v
         jKUGKF6YQ0lnZ58/4r0HWWVvCCiDSvGJ2oRg6c0nlvjQIMXSsTs0oNiuOPZwxD6ObZQb
         Cob1E4NbvFV+ma2t5zlygWNBbVmTZ2fU67XbvAkQmU5/oLIYMvmT8L9HjZ3nw+y+iTsk
         YLDg==
X-Gm-Message-State: ANoB5plBui+gqXJl0nkgt1fFURXvmLgfa/QWaq5hAVXG1E+qXBwyGvDa
        MJG2EX1AgNM5m6OV04IZi4wUQg==
X-Google-Smtp-Source: AA0mqf4arlWtava+aAS17r8idiTw0ibTQJg1S/7J9O3jkEdwKj00BzelUsWSCveQKmcE50+0ieyKfw==
X-Received: by 2002:a05:6830:6486:b0:661:170:49fc with SMTP id ck6-20020a056830648600b00661017049fcmr4033509otb.144.1669107834004;
        Tue, 22 Nov 2022 01:03:54 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m25-20020a9d4c99000000b00661a1a48079sm5757697otf.7.2022.11.22.01.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 01:03:53 -0800 (PST)
Date:   Tue, 22 Nov 2022 01:03:42 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
Subject: Re: [PATCH 1/3] mm,thp,rmap: subpages_mapcount of PTE-mapped
 subpages
In-Reply-To: <20221121123638.4mp22wjmxz4gzhfz@box.shutemov.name>
Message-ID: <efa711e6-3ec2-f297-c146-577a88894c66@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com> <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com> <78fa518-85b5-32c0-ee92-537fa46131f6@google.com> <20221121123638.4mp22wjmxz4gzhfz@box.shutemov.name>
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

On Mon, 21 Nov 2022, Kirill A. Shutemov wrote:
> On Fri, Nov 18, 2022 at 01:12:03AM -0800, Hugh Dickins wrote:
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Thanks a lot for all these, Kirill.

> 
> Few minor nitpicks below.
> 
...
> >  static inline void page_dup_file_rmap(struct page *page, bool compound)
> >  {
> > -	if (PageCompound(page))
> > -		page_dup_compound_rmap(page, compound);
> > -	else
> > +	if (likely(!compound /* page is mapped by PTE */))
> 
> I'm not a fan of this kind of comments.
> 
> Maybe move above the line (here and below)?

Okay, done throughout.  I wouldn't have added those comments, but Linus
had another "simmering hatred", of the "compound" arguments: he found
them very confusing.

The real fix is to rename them, probably to pmd_mapped; or better, pass
down an int nr_pages as he suggested; but I'm wary of the HPAGE_NR_PAGES
build bug, and it wants to be propagated through various other files
(headers and mlock.c, maybe more) - not a cleanup to get into now.

> 
> >  		atomic_inc(&page->_mapcount);
> > +	else
> > +		page_dup_compound_rmap(page);
> >  }
...
> > @@ -1176,20 +1157,16 @@ void page_dup_compound_rmap(struct page *page, bool compound)
> >  	 * Note that hugetlb does not call page_add_file_rmap():
> >  	 * here is where hugetlb shared page mapcount is raised.
> >  	 */
> > -	if (PageHuge(page)) {
> > -		atomic_inc(compound_mapcount_ptr(page));
> > -		return;
> > -	}
> > +	if (PageHuge(head)) {
> > +		atomic_inc(compound_mapcount_ptr(head));
> >  
> 
> Remove the newline?

It was intentional there, I thought it was easier to read that way;
but since this gets reverted in the next patch, I've no reason to
fight over it - removed.

Hugh
