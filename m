Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8308868B64E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 08:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBFHWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 02:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBFHW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 02:22:29 -0500
Received: from smtp-out0.aaront.org (smtp-out0.aaront.org [IPv6:2600:1f14:3bf:e504::15:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355A41ABEE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 23:22:28 -0800 (PST)
Received: by smtp-out0.aaront.org (Postfix) with ESMTP id 4P9HXF6qyvzMp;
        Mon,  6 Feb 2023 07:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aaront.org; h=
    from:to:cc:subject:date:message-id:mime-version
    :content-transfer-encoding; s=elwxqanhxhag6erl; bh=7eklGvzQeRbVq
    GTFubE4B/V1RUz7+h7698FCisfN/as=; b=XbO3MM0/+ALEFVxpBhbm8oJOuFFiF
    5L4LLHHpEjqrzFnzFpfDW+Ht2cmV63Ya44IF+Rdz0Q+h/LeAAqdlR2h59PgHJu2v
    KCsOgSBnjwcx7uyE+2ak0tN5BUZQTlNZoNx9JulvYFRCx0yR0ERafFsaIXI5ZXV8
    mBZMuwunOaZ0AEAgRGkum80d0qauDlOYx5RS19tgMjjs4FZWH272b/GIxxCMcyG9
    46GaAH/cgqrKRafZnohS2koMgQ95xQjZ+qc1ek9EpzjNEIh435pLyoD6Y2yRSBR3
    OXG8Du42i4yWbfe7fhxRIKMeBLq37EeOqRUWeg7RVyjt3+ncr0DQOg1oA==
From:   Aaron Thompson <dev@aaront.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Aaron Thompson <dev@aaront.org>
Subject: [PATCH 0/1] Fix memblock_free_late() deferred init bug, redux
Date:   Mon,  6 Feb 2023 07:12:09 +0000
Message-Id: <20230206071211.3157-1-dev@aaront.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

Unfortunately my attempted bugfix 115d9d77bb0f ("mm: Always release pages to the
buddy allocator in memblock_free_late()") is itself buggy. It's true that all
reserved pages are initialized by the time memblock_free_late() is called, but
if the pages being freed are in the deferred init range, __free_one_page() might
access nearby uninitialized pages when trying to coalesce buddies, in which case
badness ensues :(

deferred_init_maxorder() handles this by initializing a max-order-sized block of
pages before freeing any of them. We could change memblock_free_late() to do
that, but it seems to me that having memblock_free_late() get involved in
initializing and freeing free pages would be a bit messy. I think it will be
simpler to free the reserved pages later, as part of deferred init or after.

I can see a few ways to accomplish that:

1. Have memblock_free_late() remove the range from memblock.reserved. Deferred
   init will then handle that range as just another free range, so the pages
   will be initialized and freed by deferred_init_maxorder().

   This is the simplest fix, but the problem is that the pages will be
   initialized twice, first by memmap_init_reserved_pages() and again by
   deferred_init_maxorder(). It looks risky to me to blindly zero out an
   already-initialized page struct, but if we could say for certain that the
   page structs for memblock-reserved ranges aren't actually used, at least
   until after deferred init is done, then this could work. I don't know the
   usage of page structs well enough to say.

2. Take 1 and fix the double-init problem. In addition to removing the range
   from memblock.reserved, also set a flag on the range in memblock.memory that
   indicates the pages for that range have already been initialized.
   deferred_init_maxorder() would skip initializing pages for ranges with the
   flag set, but it would still free them.

   This seems like a bit of a conceptual stretch of the memblock region flags
   since this is not a property of the memory itself but rather of the page
   structs corresponding to that memory. But it gets the job done.

3. Defer the freeing of reserved pages until after deferred init is completely
   done. Have memblock_free_late() set a flag on the range in memblock.reserved,
   and have memblock_discard() call __free_pages_core() on those ranges.

   I think this would be a reasonable use of flags on reserved regions. They are
   not currently used.

The included patch implements option 1 because it is the simplest, but it should
not be used if the double-init of the page structs is unsafe. In my testing I
verified that the count, mapcount, and lru list head of all pages are at their
defaults when memblock_free_late() is called by efi_free_boot_services(), but
that's obviously not conclusive. I have draft versions of 2 and 3 that I can
finish up quickly if either of those are preferable.

Please let me know what you think, and sorry for introducing this bug.

Thanks,
Aaron

Aaron Thompson (1):
  mm: Defer freeing reserved pages in memblock_free_late()

 mm/internal.h                     |  2 ++
 mm/memblock.c                     | 36 ++++++++++++++++++++-----------
 mm/page_alloc.c                   | 17 +++++++++++++++
 tools/testing/memblock/internal.h |  7 +++---
 4 files changed, 47 insertions(+), 15 deletions(-)

-- 
2.30.2

