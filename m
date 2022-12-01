Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0447963F824
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiLAT0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiLAT0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:26:52 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74564BE6B6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:26:51 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3ceb4c331faso25673857b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 11:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=To2+IGODACfnwpoIhBKQmVc3cqLwsoSI0sFi4wzSM/E=;
        b=cVvowtY9KFRmZF7PH4+F1K/Shm+oki/xR+2GSZqQWfdCij57G18sh4Q3wsLyD7vryQ
         UD2OTKDBwavXQ1NaIhhGzF+ZgNiGZEAvaBFxq+jlWImzwsZ4jFpg+JSsvFL73t40cHlC
         cgmhGJEL0MSyv9ymPRgJeoD2Ib//Pg4LqhThq9AyoGMzOR9VWnzXPYzqJDLYAD/XhRmR
         3i3iK7rgzY08A4jYM+xtgrPdoi4dAtpBEsY0GuxhBzXZVFQ30EIjfsryvNzL3ax/JXEk
         KYBakWKOz4NbtIa7ny0p150Kb33uWc9VybGu6bmaFOsU/H1ofJWvPQQ0wozx1LjBkMxo
         BhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=To2+IGODACfnwpoIhBKQmVc3cqLwsoSI0sFi4wzSM/E=;
        b=hTVgEvy9KjLC2Vs4PGYLIy22pVQhq+N1EXWFZEkr227Ckq/XvnyBVXoMuhbg29EQFu
         9kn6DI6DuMKmHbSKxrCRxqPEuwF6VRLhFVD/P3SY0vGH8D8Ov5QkN+zxoOL+MTM0OjV2
         2i0l+e4TTExNvqfLASndMN2y1T9mS6NVJnGEkSd4YszHVjSD6SPuUqr12Y0IGMBjg5i7
         YzFsjUWa25kfKDW6awKKyecarrD4sh83DGSto6jFOCHn7W+U2OP0vkLRggP6Adkv/zQk
         XnIZcUFFr0ptDaWcDWc3xZ/lrwO2VMJ3s6BYJrRah08rRofBxLkk2CAL4jXr7Ts2tTdn
         MMQw==
X-Gm-Message-State: ANoB5pkPuMtk6Gi2RYly6S+0QAjqw9lKjH21NqP4TZf8fvTRX9t/BXS3
        T0dWoSKr/fSDn4nS1j026yo1XYfe2Pt/UNDnU89H
X-Google-Smtp-Source: AA0mqf5WBu/X5ruc3+IYERRFvBbHREqwfJ9bQdjXNgwUDJIsolUh8a0CfxBAUAbg5SZni/y/11N4MVKJtnkt1wDyNwxm
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:3f93:cb91:7d11:def])
 (user=axelrasmussen job=sendgmr) by 2002:a25:838c:0:b0:6f8:e7ca:f0ab with
 SMTP id t12-20020a25838c000000b006f8e7caf0abmr14229160ybk.315.1669922810753;
 Thu, 01 Dec 2022 11:26:50 -0800 (PST)
Date:   Thu,  1 Dec 2022 11:26:44 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221201192644.1941049-1-axelrasmussen@google.com>
Subject: [PATCH] mm: multi-gen LRU: fix LRU size accounting on folio removal
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Steven Barrett <steven@liquorix.net>,
        Yu Zhao <yuzhao@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Xu <peterx@redhat.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        Brian Geffon <bgeffon@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
Cc:     linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When removing a folio from MGLRU, we want to update the LRU size
accordingly based on the generation it belonged to previously -
lru_gen_update_size() does this.

The bug here is, set_mask_bits effectively clears the generation bits.
Ignoring the complexity set_mask_bits is meant to handle, the code being
changed here is in effect:

    flags = !reclaiming && lru_gen_is_active(lruvec, gen) ? BIT(PG_active) : 0;
    flags = *folio->flags = (*folio->flags & ~LRU_GEN_MASK) | flags;
    gen = ((flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;

In other words, the bug is we clear all of the `LGU_GEN_MASK` bits, and
then we recalculate `gen` - but of course after clearing the bits
`flags & LRU_GEN_MASK` is always zero, and so now `gen` is always -1.

So we effectively always call:

    lru_gen_update_size(lruvec, folio, -1, -1);

This leads `lru_gen_update_size` to incorrectly conclude that we're
**adding**, not removing, a folio. We take this path:

    /* addition */
    if (old_gen < 0) {
        /* always false, new_gen is -1 too */
        if (lru_gen_is_active(lruvec, new_gen))
            /* ... */
	__update_lru_size(lruvec, lru, zone, delta);
	return;
    }

In other words, when removing, we incorrectly *add* the delta to the
inactive LRU instead of subtracting.

The fix is simple. We already have the generation number the folio
belonged to: we set `int gen = folio_lru_gen(folio);` at the top of
`lru_gen_del_folio`. So, just delete the line incorrectly recalculating
the generation number.

Fixes: ec1c86b25f4b ("mm: multi-gen LRU: groundwork")
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/mm_inline.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index e8ed225d8f7c..5bba6e0b0840 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -277,7 +277,6 @@ static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio,
 	/* for folio_migrate_flags() */
 	flags = !reclaiming && lru_gen_is_active(lruvec, gen) ? BIT(PG_active) : 0;
 	flags = set_mask_bits(&folio->flags, LRU_GEN_MASK, flags);
-	gen = ((flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
 
 	lru_gen_update_size(lruvec, folio, gen, -1);
 	list_del(&folio->lru);
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

