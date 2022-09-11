Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502945B520D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 01:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiIKXse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 19:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIKXsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 19:48:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222D71C12B
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 16:48:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B73B0B80BA3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86AEC433D7;
        Sun, 11 Sep 2022 23:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662940109;
        bh=t1jgc4Li5g5fFW9NerbgXBzTYKrrbratV/fa4ALxfKI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PIYZsDKxH4Ep23P3oVAYMUotd5atx/hz5oIf3Z8IPjig/sfH/+rDeZecDiosrGHFI
         op/fl3o/nDe8expDY80ZXg9v9Qw8HjDQc2gbAw9O+NfLd3M30utB3CFcXV5M7KUARE
         JiV5PiCHjNONQuruacdsC61++ydwVQ5g8WOjLqEw=
Date:   Sun, 11 Sep 2022 16:48:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 5/7] mm: Remember young/dirty bit for page migrations
Message-Id: <20220911164828.faaa229189826ef2c219fc2d@linux-foundation.org>
In-Reply-To: <20220811161331.37055-6-peterx@redhat.com>
References: <20220811161331.37055-1-peterx@redhat.com>
        <20220811161331.37055-6-peterx@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2022 12:13:29 -0400 Peter Xu <peterx@redhat.com> wrote:

> When page migration happens, we always ignore the young/dirty bit settings
> in the old pgtable, and marking the page as old in the new page table using
> either pte_mkold() or pmd_mkold(), and keeping the pte clean.
> 
> That's fine from functional-wise, but that's not friendly to page reclaim
> because the moving page can be actively accessed within the procedure.  Not
> to mention hardware setting the young bit can bring quite some overhead on
> some systems, e.g. x86_64 needs a few hundreds nanoseconds to set the bit.
> The same slowdown problem to dirty bits when the memory is first written
> after page migration happened.
> 
> Actually we can easily remember the A/D bit configuration and recover the
> information after the page is migrated.  To achieve it, define a new set of
> bits in the migration swap offset field to cache the A/D bits for old pte.
> Then when removing/recovering the migration entry, we can recover the A/D
> bits even if the page changed.
> 
> One thing to mention is that here we used max_swapfile_size() to detect how
> many swp offset bits we have, and we'll only enable this feature if we know
> the swp offset is big enough to store both the PFN value and the A/D bits.
> Otherwise the A/D bits are dropped like before.
> 

There was some discussion over v3 of this patch, but none over v4.

Can people please review this patch series so we can get moving with it?

Thanks.

