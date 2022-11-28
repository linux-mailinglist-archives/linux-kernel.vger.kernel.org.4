Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EAC63AE34
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiK1Q7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiK1Q6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:58:46 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7E313DCE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:58:42 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id h206so8035362iof.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+XtmF+OzS7nFi9b07/wW7bomxRaZmCEdAG1Z2XFqwAY=;
        b=AXGGBtTZZeB2swJZQBELTWmiPA8pj8I3Q1LZqOLE10Iz8lCMM81B0fiuHbOI11x+X5
         BnaNrk2Mew7ohyaX0JVoFfItrW5SOB+bmUtBp7/KCNACrtj99aZ00kBtxNFR9SyK1Xhs
         GPQf7PxpJ8G2Vgl/L+mFv3E6odqSjlAdmnLBLz+okJzMBstDvYounzzruuRrAZkbHm1o
         VJRNhepdHm8KxQHu/i5eJILXY9sRH9bFKPCIIQtbTlmo8WaX1BvH+Wxazm7YtRCbRf1L
         i+FONKlS+jip7B14FAq2wVD7q96HHGjQFzd7V/ZxQytOZxi5uF2MGGMH++rIEDazy21+
         ajfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+XtmF+OzS7nFi9b07/wW7bomxRaZmCEdAG1Z2XFqwAY=;
        b=NI+YAVqCI0lI2sirlNk0I1243S59dDQfs3PwjR3FaLtQcgDqH25XEPkKMKgpfFGagb
         n8/i9TmKLtv4y8V1GzVwtlB6RctqEoPLLgi7wMHmEn5Y1WIYCatVnjtHuah526b21dUC
         QxmH43qN18QffEZBWuW3vqo5RuSVA2rklHCO9kacKaGFGz/pf4LZaVb7yT+g/ryHFdQv
         svgVrEtWNkoowEts67gyW5Trc21AohUqjFP9QXzYpXvDpyRdNgddRbilcp7yR/sKt7w6
         LdeCg68lMGV8Nq0+AAcaYFyUb80XI3uRYJdxAvOtkYBhBmJz0eC2UBsIZF+CjNExbHOH
         aOUw==
X-Gm-Message-State: ANoB5pno5r8WWUQobTVvkayjq6Relacw1nDKq3YYbx9Yoi4qSDK8W2sK
        SjikdEqFVfqjRqcy/+azBzVMpu3D35c4xJ8/7MyKgA==
X-Google-Smtp-Source: AA0mqf5v0ngWgQIvgqIexF0b6XB5LvYtOnZ9Gz25Q4hd4Qyfk0HowI7MMK4VKlEF4qr22tW9aq49RBU8KNzK0i0wM0g=
X-Received: by 2002:a02:b691:0:b0:389:af9:4860 with SMTP id
 i17-20020a02b691000000b003890af94860mr9905696jam.164.1669654721738; Mon, 28
 Nov 2022 08:58:41 -0800 (PST)
MIME-Version: 1.0
References: <20221125213714.4115729-1-jannh@google.com> <20221125213714.4115729-2-jannh@google.com>
 <ea2a2311-0a7e-cc81-0b82-5de45acba8f5@redhat.com>
In-Reply-To: <ea2a2311-0a7e-cc81-0b82-5de45acba8f5@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 28 Nov 2022 17:58:05 +0100
Message-ID: <CAG48ez02g3ind9p9op-t_k3eruANE4idhjT044rK5+qK8_-EFA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm/khugepaged: Fix GUP-fast interaction by sending IPI
To:     David Hildenbrand <david@redhat.com>
Cc:     security@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Nov 28, 2022 at 2:46 PM David Hildenbrand <david@redhat.com> wrote:
> On 25.11.22 22:37, Jann Horn wrote:
> > Since commit 70cbc3cc78a99 ("mm: gup: fix the fast GUP race against THP
> > collapse"), the lockless_pages_from_mm() fastpath rechecks the pmd_t to
> > ensure that the page table was not removed by khugepaged in between.
> >
> > However, lockless_pages_from_mm() still requires that the page table is not
> > concurrently freed.
>
> That's an interesting point. For anon THPs, the page table won't get
> immediately freed, but instead will be deposited in the "pgtable list"
> stored alongside the THP.
>
>  From there, it might get withdrawn (pgtable_trans_huge_withdraw()) and
>
> a) Reused as a page table when splitting the THP. That should be fine,
> no garbage in it, simply a page table again.

Depends on the definition of "fine" - it will be a page table again,
but deposited page tables are not associated with a specific address,
so it might be reused at a different address. If GUP-fast on address A
races with a page table from address A being deposited and reused at
address B, and then GUP-fast returns something from address B, that's
not exactly great either.

> b) Freed when zapping the THP (zap_deposited_table()). that would be bad.
>
> ... but I just realized that e.g., radix__pgtable_trans_huge_deposit
> uses actual page content to link the deposited page tables, which means
> we'd already storing garbage in there when depositing the page, not when
> freeing+reusing the page ....
>
> Maybe worth adding to the description.

Yeah, okay, I'll change the commit message and resend...

[...]
> With CONFIG_MMU_GATHER_RCU_TABLE_FREE this will most certainly do the
> right thing. I assume with CONFIG_MMU_GATHER_RCU_TABLE_FREE, the
> assumption is that there will be an implicit IPI.
>
> That implicit IPI has to happen before we deposit. I assume that is
> expected to happen during pmdp_collapse_flush() ?

Yeah, pmdp_collapse_flush() does a TLB flush, as the name says. And as
documented in a comment in mm/gup.c:

 * Before activating this code, please be aware that the following assumptions
 * are currently made:
 *
 *  *) Either MMU_GATHER_RCU_TABLE_FREE is enabled, and
tlb_remove_table() is used to
 *  free pages containing page tables or TLB flushing requires IPI broadcast.

I'll go sprinkle that in a comment somewhere, either in the file or in
the commit message...
