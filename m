Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1998E63B2A1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbiK1T5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbiK1T5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:57:34 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C801B26
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:57:31 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id z3so8461335iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CnEA0T2qkTiQEs01sfihIXT1UyG0xIqrCPo5fAQoIbw=;
        b=me3KUbF51HGTLR1arblyz8L3dc/A91yVC3vRVU1WCj6Y6Aa3Sfn1yNZFZ1kwzV4092
         F+d1RVIPlwGEZ44KFLIu422hyZ0Edh8zep1H30licwwOPonTZ7omiunGYUrGOD5ShnxX
         NjUbjal94soLHwqFSLlFNnRv+7R/A7EFUF132I8WB5ooMmuJZdPRb6ty9iu9KcSwkIAJ
         TLrTabdccrWvpxbFmqhoCWjZCQ8SCRC7EWoO8PINWMrIqHASgeIPEOZn9zxRpbUzASzt
         vQg2d0VccsIV5L6wkwoqMxi0/A8XHk8MnjUjYVdvooaHR+6Q5mxEiWWBc1N8sCbWY6I3
         i69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CnEA0T2qkTiQEs01sfihIXT1UyG0xIqrCPo5fAQoIbw=;
        b=MqP5h9fLysQ3z5trny0A2Roqyx+XOtx2K/wRy0wgduYz0YkS3STvxjnogBhhhkc5J0
         yTWPmgxOZV4PhAFlfxO7XUANvAKKwtqaMRJn0VHpQiFgYsoGH0jWhGONrgjTwrhkr8tw
         GT8ckC3ii39qqWA3eAZlvu6GVt7ElNlGzwS1DuIyu74+ZNNjJMyIQ/DPnLjrLq0OTU6j
         QKiu39YZm5se72pgBs01VQsLJS3aoUYMhLW76SNtFg3iA4z0WPxkOImqx8Xo76145FX4
         AlvY41mZLbXl4F3RbpDRV3IW7/8RhXoAvYa95EPThmexUUvaiskxq2+pCMcoq8CBUOah
         LYzQ==
X-Gm-Message-State: ANoB5pmyQdEDFRKMTIh8835pYfhItE3PzISZSZs/D2rK/S5Fj/4DGi/B
        AksKOjO+5NxOKE8gzxEC6sv7tdlatux0JmWSMxdqJA==
X-Google-Smtp-Source: AA0mqf7+QHxHZ5sbPo/ZTB0shmWRx331k9d/UeBMAAsLSWnfawD7LQI0hbXS+foBaVAFeJ6iP5alri66QnHpVJ5vE0Q=
X-Received: by 2002:a02:2123:0:b0:376:91d:b104 with SMTP id
 e35-20020a022123000000b00376091db104mr17049939jaa.58.1669665450587; Mon, 28
 Nov 2022 11:57:30 -0800 (PST)
MIME-Version: 1.0
References: <20221128180252.1684965-1-jannh@google.com> <20221128180252.1684965-2-jannh@google.com>
 <CAHbLzkp7+ZrXkoYcVtqrd2mQN3FZ4Y6tyeZCd31Oubz=+esaJQ@mail.gmail.com>
In-Reply-To: <CAHbLzkp7+ZrXkoYcVtqrd2mQN3FZ4Y6tyeZCd31Oubz=+esaJQ@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 28 Nov 2022 20:56:54 +0100
Message-ID: <CAG48ez0iS2BZd9BAXZLBA3D0fzNePSLWoXqAbYWsTig4nN5FrQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm/khugepaged: Fix GUP-fast interaction by sending IPI
To:     Yang Shi <shy828301@gmail.com>
Cc:     security@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
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

On Mon, Nov 28, 2022 at 8:54 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Mon, Nov 28, 2022 at 10:03 AM Jann Horn <jannh@google.com> wrote:
> >
> > Since commit 70cbc3cc78a99 ("mm: gup: fix the fast GUP race against THP
> > collapse"), the lockless_pages_from_mm() fastpath rechecks the pmd_t to
> > ensure that the page table was not removed by khugepaged in between.
> >
> > However, lockless_pages_from_mm() still requires that the page table is not
> > concurrently freed or reused to store non-PTE data. Otherwise, problems
> > can occur because:
> >
> >  - deposited page tables can be freed when a THP page somewhere in the
> >    mm is removed
> >  - some architectures store non-PTE information inside deposited page
> >    tables (see radix__pgtable_trans_huge_deposit())
> >
> > Additionally, lockless_pages_from_mm() is also somewhat brittle with
> > regards to page tables being repeatedly moved back and forth, but
> > that shouldn't be an issue in practice.
> >
> > Fix it by sending IPIs (if the architecture uses
> > semi-RCU-style page table freeing) before freeing/reusing page tables.
> >
> > As noted in mm/gup.c, on configs that define CONFIG_HAVE_FAST_GUP,
> > there are two possible cases:
> >
> >  1. CONFIG_MMU_GATHER_RCU_TABLE_FREE is set, causing
> >     tlb_remove_table_sync_one() to send an IPI to synchronize with
> >     lockless_pages_from_mm().
> >  2. CONFIG_MMU_GATHER_RCU_TABLE_FREE is unset, indicating that all
> >     TLB flushes are already guaranteed to send IPIs.
> >     tlb_remove_table_sync_one() will do nothing, but we've already
> >     run pmdp_collapse_flush(), which did a TLB flush, which must have
> >     involved IPIs.
>
> I'm trying to catch up with the discussion after the holiday break. I
> understand you switched from always allocating a new page table page
> (we decided before) to sending IPIs to serialize against fast-GUP,
> this is fine to me.
>
> So the code now looks like:
>     pmdp_collapse_flush()
>     sending IPI
>
> But the missing part is how we reached "TLB flushes are already
> guaranteed to send IPIs" when CONFIG_MMU_GATHER_RCU_TABLE_FREE is
> unset? ARM64 doesn't do it IIRC. Or did I miss something?

From arch/arm64/Kconfig:

select MMU_GATHER_RCU_TABLE_FREE

CONFIG_MMU_GATHER_RCU_TABLE_FREE is not a config option that the user
can freely toggle; it is an option selected by the architecture.
