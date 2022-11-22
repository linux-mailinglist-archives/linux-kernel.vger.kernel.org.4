Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C082633817
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbiKVJNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiKVJNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:13:45 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBFA63A5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:13:44 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id j26so2664130qki.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7xqdWpmMgK4TlDGSJjLz9IABXgjJRE62xPUxcQSf0wk=;
        b=O+mOhBKwBvKXkrpaR3qctTFgHdCTbmxJx9hfOl5YVIJFKz5hMMUW9G25INF+60AZ7H
         F0HQ5g+r6nJc6Gci2GztjHTAdqYVta6oPs3isV4NoKvbEBa5xKmRZJSmQ+5x8Zz0DXrJ
         vb4OPfS1R3AevGCJOAEn9TfIPY3EEpBhE3qScjWTtIe45TDD40nd2dWSml/W2hOHgikN
         6Jny/WbU89Tyc2bIii7PVjlWQ2UUv0l8DxWA7AoWzSY7UeEwq/q0iMbyoDa1HsNXOsx/
         Qzg0Vt5MqLZ/IP9nE8zye1ggzp3kWRVJJrB/k5cYuJaXIZxNdiMfOJvwjAslqUtLZ3c3
         edig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7xqdWpmMgK4TlDGSJjLz9IABXgjJRE62xPUxcQSf0wk=;
        b=6cTyu7fMt9UEVaW/Spo24LfzOiAozqusQWx3eS/7IOQ6crhwuNnMipVXsF5VzucRzb
         fE3NX7z/YgzHIhUE/m3iARohsVmeMmbzXPGfawiKR5utdGnESAb6DHqUhcgFqBKxuJKg
         uHk2tZY/PGGL2+ZqpiraUUZ5TWqBL/1vLPitRKLcUufE7+0H/3L3S+Oor3KCTVwrYDkZ
         KR2ObGX6N2+k3w+9tFrWl8xiksfwdnWMsLnSHyatTIyJh7CtCRrDhCesTX1BJuUy9dkB
         2afsX4iBynsD94pq5QFyzwz7loZiXcaHQMLuado5tyVlCdxnEQYdSML9opV1/ZiLmhf/
         ZkSQ==
X-Gm-Message-State: ANoB5pkW/LZjvd7OXrKTQS3rPdx3rBeaZccKJkukcfv0Cfv3Juq8l/+a
        2HACr/GpHDP5A9H7LvpZNG7xWw==
X-Google-Smtp-Source: AA0mqf4efPgyC6I9oPi8Nox4ddRnpIfoEy3+l57wAnRX7coydzZIpyvy5Dgy1rZtvpX/7WWu9lhQZg==
X-Received: by 2002:a37:b03:0:b0:6fa:9d10:1784 with SMTP id 3-20020a370b03000000b006fa9d101784mr20331534qkl.627.1669108423412;
        Tue, 22 Nov 2022 01:13:43 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id bs42-20020a05620a472a00b006b61b2cb1d2sm9741158qkb.46.2022.11.22.01.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 01:13:42 -0800 (PST)
Date:   Tue, 22 Nov 2022 01:13:39 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
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
Subject: Re: [PATCH 1/3 fix] mm,thp,rmap: subpages_mapcount of PTE-mapped
 subpages: fix
In-Reply-To: <20221121123812.4sxk7ewzfhdqq6zs@box.shutemov.name>
Message-ID: <536d9a99-1cbb-d05d-21bf-4cc8d032692@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com> <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com> <78fa518-85b5-32c0-ee92-537fa46131f6@google.com> <CAOUHufYf9Ns6vPpDeSOnUBaQm3Th+N6WbLiT7F=191LNpsatNQ@mail.gmail.com> <759077a6-a08-5bb0-a0b6-53be2fe8b56a@google.com>
 <7a4f5e5e-de33-dace-c526-4a3d3cf5f6e0@google.com> <20221121123812.4sxk7ewzfhdqq6zs@box.shutemov.name>
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
> On Fri, Nov 18, 2022 at 05:35:05PM -0800, Hugh Dickins wrote:
...
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1281,7 +1281,7 @@ void page_add_anon_rmap(struct page *page,
> >  	struct compound_mapcounts mapcounts;
> >  	int nr = 0, nr_pmdmapped = 0;
> >  	bool compound = flags & RMAP_COMPOUND;
> > -	bool first;
> > +	bool first = true;
> >  
> >  	if (unlikely(PageKsm(page)))
> >  		lock_page_memcg(page);
> 
> Other option is to drop PageTransHuge() check that you already claim to be
> redundant.
> 
> Or have else BUG() to catch cases where the helper called with
> compound=true on non-THP page.

I'm sticking with the "first = true".  I did receive a report of bloating
some tiny config a little, on the very first series, so I've been on guard
since then about adding THP code where the optimizer cannot see to remove
it: so do want to keep the PageTransHuge check in there.  Could be done
in other ways, yes, but I'd ended up feeling this was the best compromise.

Hugh
