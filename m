Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2283F623968
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 03:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbiKJCAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 21:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiKJB6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:58:43 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A989D88
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 17:58:33 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-13bef14ea06so815266fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 17:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U3+h3Jg4UrytHO9CCFQac05mLjppk7PsqbWzF0gjR58=;
        b=WgNpeFH3S4gC5KRcOylHYfE5JHo7N7MPFRlvVNZ//vP0Ay5AC49Mv71lA1PlhBkkbx
         4p2mECzPGOqFl7wam2F1l07RVsmsWxs7FA+clKwhmpUndgQNnLvaCSpVhQNjyDJ/weez
         FMIG+2LL/L7D3M77xACUU/ZUT32wwRB7ZktBoP9DW8Bm2KnI/u66C0vUpyk96ydaggd3
         V4aN1BA9iiszBzgJOXgVFIb+B+HVGjiwoiSY2pJCEzyp+y9Z+3UkUdr8Nh2wSLjFAamR
         DFY739hknn8GcligzFkbYYTV7YRqpJDjbvH7JjfrIKudIuJOJwG5u4HdK5DMyjM2q4dc
         MA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3+h3Jg4UrytHO9CCFQac05mLjppk7PsqbWzF0gjR58=;
        b=4MXXN3XIpRa4N2m5EzrlYqlReYbFt3/dr9YF39uMCuMTC9Xb7cAp5+bLmrQLw4GEuu
         Xny9UCMREV7bARS2rnYLfeT9oad7xYiDkc6UqGkhm+39uURjoUYMLFyCRwuijocEtr/I
         oLGMCpf5R/8UenzBdSXa/jjCNvLx2u+NITMs0YWig/MrPibVCvyONXs+opMqKsQv+J8g
         18qTQpljKZKb05rD+2uFePxYqOoHEPsAVl9KxJIzoXIbP7xG4haCK2gCnB9DvPCENEKc
         7n49wG2WH+Rb9B7eAb5+8FMhplA3S6Zom8d0V6eKML+rUvYh1wT0KcTATPY5pRYe8esE
         tcXg==
X-Gm-Message-State: ACrzQf0xGV/5iZPTd9Wx9VdQyiJ9VhJUzs5cJRWdXadtthiRAhYpHHSb
        KU+xpA86sutTIXno5xikM22Wdw==
X-Google-Smtp-Source: AMsMyM7kJKuze054T3sXZ6/oP4ttn+EY3iAeqQ1GUvUlUQkiS3OltEudE5Au/GaYL0Z3qF5WabEKjQ==
X-Received: by 2002:a05:6870:bb09:b0:13b:2f1f:82fa with SMTP id nw9-20020a056870bb0900b0013b2f1f82famr996064oab.47.1668045511436;
        Wed, 09 Nov 2022 17:58:31 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e1-20020a056830200100b00661b5e95173sm5879346otp.35.2022.11.09.17.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 17:58:30 -0800 (PST)
Date:   Wed, 9 Nov 2022 17:58:17 -0800 (PST)
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
Subject: Re: [PATCH 1/3] mm,hugetlb: use folio fields in second tail page
In-Reply-To: <20221105191321.572bdm67tulpva5k@box>
Message-ID: <9de71a55-8f6d-a32e-cd57-f8ab8581e50@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com> <3818cc9a-9999-d064-d778-9c94c5911e6@google.com> <20221105191321.572bdm67tulpva5k@box>
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
> On Wed, Nov 02, 2022 at 06:48:45PM -0700, Hugh Dickins wrote:
> > @@ -260,13 +267,16 @@ struct page {
> >   *    to find how many references there are to this folio.
> >   * @memcg_data: Memory Control Group data.
> >   * @_flags_1: For large folios, additional page flags.
> > - * @__head: Points to the folio.  Do not use.
> > + * @_head_1: Points to the folio.  Do not use.
> >   * @_folio_dtor: Which destructor to use for this folio.
> >   * @_folio_order: Do not use directly, call folio_order().
> >   * @_total_mapcount: Do not use directly, call folio_entire_mapcount().
> >   * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
> >   * @_folio_nr_pages: Do not use directly, call folio_nr_pages().
> > - * @_private_1: Do not use directly, call folio_get_private_1().
> 
> Looks like it misses
> 
>   + * @_flags_2: For large folios, additional page flags.
>   + * @_head_2: Points to the folio.  Do not use.
> 
> to match the first tail page documentation.
> 
> Otherwise the patch looks good to me:
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Many thanks for all your encouragement and reviews, Kirill.

Okay, I've added a couple of lines on those fields; but did not
want to recommend the _flags_2 field for use (by the time we run
out in _flags_1, I hope all this will be gone or look different).

I'm sending an incremental fix, once I've responded to Sidhartha.

Hugh
