Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C649A6247B5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiKJQ6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiKJQ6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:58:21 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2A4205F0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:58:21 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id p18so1467314qkg.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0PcjM7Qx8NCGxX+37pMucCBResM/T5j/rL0qDgsxmxo=;
        b=GU5BzO5E1+Cms1HYFBdUrm1Y5OvAAUG4KFQcbS5w0UjAygwbAQajcCUP8Pq2JUKYdh
         /g5abIY/j/2ZzkZ16EAAI3XcK6IBhJL1xAeUkNvtdNLcs/kpHjqkXcS8ze7RhW9veGvP
         a9RDzAb+CeBzGB1tg24Ku+X8S9jQ0TV1Ft4os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0PcjM7Qx8NCGxX+37pMucCBResM/T5j/rL0qDgsxmxo=;
        b=nkR9iWegz4KQj9w+SNKSrBiDUKkUUbuUo2Es5enjlLhqCybIOj19L/h31lE9zXb7sl
         zcIPrPW+Ox6hC/vw/9CH312HyKUo1s2Oy9ykUhR8ZsL0hvmZlWLQxPD1sF0VoF1Z20fL
         sFUKFiInhizuJo2ya3qxwVObJ+Ofc3fgYYDTDZbc54L6j8ssRCNZLA8QFsmZjtbNhEin
         3P4viShB77B8bdXo5Sj6A3Oag7pNjhTdjKpvkyReYJPCxxuVkfvfBnolKpgyxaBP88mZ
         iafVi70Wzv+jjhrwG01RwJF2k7/yWAnzBWfj2nZObJezNHgcbRice3/fEmS49HpXIpaI
         67qA==
X-Gm-Message-State: ACrzQf2yB8H/TVLtv18gm3FJTfh+t9HEMxadrd14moEbvLm0y+I4052Q
        XY+pX/mjPFYAX1vzx9E5Xgg2HAKERE/bkw==
X-Google-Smtp-Source: AMsMyM5gHWK0YseCl1usvrOdldHkErBdVa4gFxugbQMP2m28UtSx+Qo6C+32SE6dxXfMH2TcKhUMxA==
X-Received: by 2002:a05:620a:46:b0:6fa:2145:e691 with SMTP id t6-20020a05620a004600b006fa2145e691mr45029746qkt.54.1668099499920;
        Thu, 10 Nov 2022 08:58:19 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id ey26-20020a05622a4c1a00b003a4ec43f2b5sm11484312qtb.72.2022.11.10.08.58.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 08:58:18 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id f201so1794298yba.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:58:17 -0800 (PST)
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr66657978ybu.310.1668099497288; Thu, 10
 Nov 2022 08:58:17 -0800 (PST)
MIME-Version: 1.0
References: <5f52de70-975-e94f-f141-543765736181@google.com>
 <fca2f694-2098-b0ef-d4e-f1d8b94d318c@google.com> <CAHk-=wiJfLx9dVJcQOhQsAseoPmLhpVvHgf4GYu6frfhmBAuMg@mail.gmail.com>
 <Y20nbz4ypWhwF38L@casper.infradead.org>
In-Reply-To: <Y20nbz4ypWhwF38L@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Nov 2022 08:58:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgYz=5AXvu1+O0+t5WGr7RAMCgEUUrng1PKGGhFYtCcTQ@mail.gmail.com>
Message-ID: <CAHk-=wgYz=5AXvu1+O0+t5WGr7RAMCgEUUrng1PKGGhFYtCcTQ@mail.gmail.com>
Subject: Re: [PATCH 4/3] mm,thp,rmap: handle the normal !PageCompound case first
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxcg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
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
        "Zach O'Keefe" <zokeefe@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 8:31 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> Ah.  I've been trying to understand what that 'compound' really means,
> and what the difference is to 'PageCompound()' and why we need both.

Yeah, so the 'why' is:

 (a) to distinguish the case of "I'm mapping the first sub-page of a
compound page as a _single_ page page entry in the pte" from "I'm
mapping the whole compound/THP/HUGETLB page as a pmd"

The actual 'page' pointer can be the same in both cases, so you can't
tell from that: PageCompound() will be true in both cases.

Of course, sometimes you *can* tell from the page pointer too (eg the
HUGETLB case can never be mapped as a small page), but not always.

 (b) because we do completely different things from a page locking and
statistics standpoint for the two cases.

That (b) is obviously related to (a), but it's effectively the main
reason why rmap needs to be able to tell the difference in the first
place.

> HugeTLB pages _are_ marked as Compound.

Oh, ok. It's not clear why they would be, and historically I don't
think they were, but I guess it's for random implementation details
(probably to look up the head page logic).

>  There's some fairly horrific
> code to manually make them compound when they have to be allocated
> piecemeal (because they're 1GB and too large for the page allocator).

Yeah, the HUGETLB case is a mess these days, but it made sense
historically, because it was a much simpler thing than the THP pages
that have all the fragmentation cases.

Now that we handle pmd-sized pages anyway, the HUGETLB case is mostly
just a nasty oddity, but we obviously also do the pud case with
HUGETLB.

And who knows what ia64 did with its completely random page-size
thing. I don't even want to think about it, and thankfully these days
I don't feel like I need to care any more ;)

> >    To make things more confusing, some places use PageHeadHuge()
> > instead (but the folio version of said test is called
> > "folio_test_hugetlb()", just so that nobody could possibly ever accuse
> > the HUGETLB code to have consistency).
>
> That one's my fault, but it's a reaction to all the times that I and
> others have got confused between PageHuge and PageTransHuge.  I suppose
> we could do a big sed s/PageHuge/PageHugeTLB/, but I'm hopeful the
> entire hugetlb codebase is either converted to folios or unified with
> THP handling.

Yeah, it would be lovely to make HUGETLB some THP special case some day.

                 Linus
