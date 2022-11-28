Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524E463B2D4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 21:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbiK1UQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 15:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbiK1UQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 15:16:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6F627B04
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669666553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FqaAFD3G+jZ4WHE7W2ZLsRGOd169Cc0eOcFbDpNxulY=;
        b=AVOshO6rpmzlP6vqPF6QIu89yVbDm/GcIDjhY+pz9+Zjq8UfxzrF/kzSGkyvcxTPsHpuwT
        pV0oZGV7rbgRzveZO14e/hOdCuJyLxSGlC4Hj6PIy7IO0RWvtP7pqruBf4F9+a53mT9WZf
        XnS4WqmPpcVU+5sBZqrEWdBqFczWekE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-43-vVo7euIEO2WWDu354SroAw-1; Mon, 28 Nov 2022 15:15:51 -0500
X-MC-Unique: vVo7euIEO2WWDu354SroAw-1
Received: by mail-qk1-f199.google.com with SMTP id i21-20020a05620a405500b006fb25ba3e00so22349777qko.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:15:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqaAFD3G+jZ4WHE7W2ZLsRGOd169Cc0eOcFbDpNxulY=;
        b=IbLsxhVNoDVz+Xwm/luDn5i9e3wbUFiSSfxy16JDDkuLI872PaspRpJ6qs1j1jfECJ
         i8bpXjkuWgGNCjdvn62F8sLrCv6dX9yjkl21Tu7q9YtUFqwBWNL4R0HEueNAX65deObA
         y6bimp0HyPRcvLgK9HhuqU+A6mEws1tqVARc4UDJLs2MdblfEJlv/ctu25oOrkWgQ4a5
         o3mdsv6QkiRa69vSV2tBZO1c0fiO3r0E64CpBk4yYvazNVdz76FYBWahDefl6T8DcFLC
         XiBZnLqRbccRFFhN5/db5niRPVUbTqavC83TkxKxZxa7nLgUR+9533mKBKXnLOfAKVre
         suPw==
X-Gm-Message-State: ANoB5pnCjvrshqMZ11RCR4aaVLIeTHqQ5V7J2HHdvQzPvI/U+ZboIS/r
        mPWJqp0VH9PrMbFFsAtKkllR/GKXA4efECrw+MY9C7VxSN2XACyO9zPgV1OdJHfAyKXJsz0mRE1
        9jBr/OvMJFeeIS9gZWDAN1sEa
X-Received: by 2002:a0c:90f1:0:b0:4c6:8f2e:9a2 with SMTP id p104-20020a0c90f1000000b004c68f2e09a2mr47944975qvp.100.1669666550915;
        Mon, 28 Nov 2022 12:15:50 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6Y5NmQy9S7nCPfZbHSBEKE87bVtEm6ScTkGyMabYTFiOFNFzAj5q1Ydhc3+5YgVPO0ynqwVQ==
X-Received: by 2002:a0c:90f1:0:b0:4c6:8f2e:9a2 with SMTP id p104-20020a0c90f1000000b004c68f2e09a2mr47944950qvp.100.1669666550639;
        Mon, 28 Nov 2022 12:15:50 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id d13-20020ac851cd000000b0039cba52974fsm7358402qtn.94.2022.11.28.12.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 12:15:50 -0800 (PST)
Date:   Mon, 28 Nov 2022 15:15:49 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     Yang Shi <shy828301@gmail.com>, security@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 2/3] mm/khugepaged: Fix GUP-fast interaction by
 sending IPI
Message-ID: <Y4UW9dYHfrvUStsa@x1n>
References: <20221128180252.1684965-1-jannh@google.com>
 <20221128180252.1684965-2-jannh@google.com>
 <CAHbLzkp7+ZrXkoYcVtqrd2mQN3FZ4Y6tyeZCd31Oubz=+esaJQ@mail.gmail.com>
 <CAG48ez0iS2BZd9BAXZLBA3D0fzNePSLWoXqAbYWsTig4nN5FrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez0iS2BZd9BAXZLBA3D0fzNePSLWoXqAbYWsTig4nN5FrQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 08:56:54PM +0100, Jann Horn wrote:
> On Mon, Nov 28, 2022 at 8:54 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Mon, Nov 28, 2022 at 10:03 AM Jann Horn <jannh@google.com> wrote:
> > >
> > > Since commit 70cbc3cc78a99 ("mm: gup: fix the fast GUP race against THP
> > > collapse"), the lockless_pages_from_mm() fastpath rechecks the pmd_t to
> > > ensure that the page table was not removed by khugepaged in between.
> > >
> > > However, lockless_pages_from_mm() still requires that the page table is not
> > > concurrently freed or reused to store non-PTE data. Otherwise, problems
> > > can occur because:
> > >
> > >  - deposited page tables can be freed when a THP page somewhere in the
> > >    mm is removed
> > >  - some architectures store non-PTE information inside deposited page
> > >    tables (see radix__pgtable_trans_huge_deposit())
> > >
> > > Additionally, lockless_pages_from_mm() is also somewhat brittle with
> > > regards to page tables being repeatedly moved back and forth, but
> > > that shouldn't be an issue in practice.
> > >
> > > Fix it by sending IPIs (if the architecture uses
> > > semi-RCU-style page table freeing) before freeing/reusing page tables.
> > >
> > > As noted in mm/gup.c, on configs that define CONFIG_HAVE_FAST_GUP,
> > > there are two possible cases:
> > >
> > >  1. CONFIG_MMU_GATHER_RCU_TABLE_FREE is set, causing
> > >     tlb_remove_table_sync_one() to send an IPI to synchronize with
> > >     lockless_pages_from_mm().
> > >  2. CONFIG_MMU_GATHER_RCU_TABLE_FREE is unset, indicating that all
> > >     TLB flushes are already guaranteed to send IPIs.
> > >     tlb_remove_table_sync_one() will do nothing, but we've already
> > >     run pmdp_collapse_flush(), which did a TLB flush, which must have
> > >     involved IPIs.
> >
> > I'm trying to catch up with the discussion after the holiday break. I
> > understand you switched from always allocating a new page table page
> > (we decided before) to sending IPIs to serialize against fast-GUP,
> > this is fine to me.
> >
> > So the code now looks like:
> >     pmdp_collapse_flush()
> >     sending IPI
> >
> > But the missing part is how we reached "TLB flushes are already
> > guaranteed to send IPIs" when CONFIG_MMU_GATHER_RCU_TABLE_FREE is
> > unset? ARM64 doesn't do it IIRC. Or did I miss something?
> 
> From arch/arm64/Kconfig:
> 
> select MMU_GATHER_RCU_TABLE_FREE
> 
> CONFIG_MMU_GATHER_RCU_TABLE_FREE is not a config option that the user
> can freely toggle; it is an option selected by the architecture.

True.

I think I understand what Yang is confused about and I had the same
question (asked in the old threads but didn't yet got a confirmation),
since I think arm64 didn't use IPI for tlb is also true (according to the
arm64 version of __flush_tlb_range), so PPC doesn't seem to be the only one.

I mentioned PPC only because I saw the comment in mmu_gather.c:

 * Architectures that do not have this (PPC) need to delay the freeing by some
 * other means, this is that means.

So I think it's obsolete.

In short, IIUC there's just an implicit dependency that any
!MMU_GATHER_RCU_TABLE_FREE arch must require IPI for tlb flush (not vice
versa, hence arm64 can have RCU_TABLE_FREE), or something could be broken.

-- 
Peter Xu

