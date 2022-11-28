Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B43E63B1FE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbiK1TQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiK1TQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:16:18 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67802A43D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:16:17 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y17so3237106plp.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7zVBwMXapBovi67IHJnxuLTYmJEmE4K0rauIUXooT+E=;
        b=Rvo58LN0xH2uPgO2irRcjReHIQUyNCuQcTXEhD2CLtjFDVZ+Id4mJQaHnhNowfb32z
         wHHKYx25qubJrnAw7MjU2xsLtNTN6trIJhv5Yf8+S9D48/Fdd1e0OdCMMCKWkaoKoRxM
         VINGjoxkEWXpRwsZhuob6hynARbiYcGljRxFM0V0lBm1j0JRK7jWXTKbiEVPzleIxhZy
         sKBfH4CPglQppn4K/awUOdjO0t3U6Oz3cJCx4vnYLHNzBxvAHj7mEGSxYn7W6lu2fbME
         LLUNozF7nG74dotX0YW2LnoY9sGyJ+rCjGHmFJ5LQTZV+s3P2ti+eYkXWBW/xp8KTnef
         QPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zVBwMXapBovi67IHJnxuLTYmJEmE4K0rauIUXooT+E=;
        b=ZllQpFLGTQpLlpnHchNALPKwufckpEFlgLND7X3/W1rgFlKLwJvvaRvO7JT3BvSk0G
         UCg0EogS2wXflR3r3gZ/56D4CFErzzsnstGxigbptIjAphV1VhjplShjChgNWrDOYAmW
         Be5CfJZOuoFzvvNF+bDFkjAhW8RxJvevtse9MOmOwx/dK8z786iFoYmOStXAD7ZPi/8P
         xwwpY6dO9fH34xJJrly6eYxnMiKKOTCaUqCQkXJUHC26g10rrui24y7WaVG1laDRKnRC
         Gmw8itKeye+xi+h6uDZr+H2CjwNVlsVyvb85uIM2BwB1arUCB85ziRkA+7A6uDeK5YA7
         KZ/Q==
X-Gm-Message-State: ANoB5pnZQJzTJ2vR4joqI1Som6bjc5iF/1y5dz+B0VCZVuR0XO/qlZ3M
        KdAKzSfLuZIcTRqNspGKAmo=
X-Google-Smtp-Source: AA0mqf43Y0DPx80NwgbjVzmT/qMwCEbLySlmxjEzru6wlIHYC06U6j4UXOX48d8v/xJgcYFsLQGwSQ==
X-Received: by 2002:a17:90a:8592:b0:219:2e8c:a775 with SMTP id m18-20020a17090a859200b002192e8ca775mr8501180pjn.102.1669662977242;
        Mon, 28 Nov 2022 11:16:17 -0800 (PST)
Received: from localhost (fwdproxy-prn-010.fbsv.net. [2a03:2880:ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id gi12-20020a17090b110c00b00218fb3bec27sm7926149pjb.56.2022.11.28.11.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 11:16:16 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v7 0/6] Implement writeback for zsmalloc
Date:   Mon, 28 Nov 2022 11:16:09 -0800
Message-Id: <20221128191616.1261026-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
v7:
  * Rebase this series of patch on top of mm-unstable
    which removes some duplicate code (patch 1).
v6-fix:
  * Add a comment explaining LRU update logic in zs_map_object.
    (patch 4)
    (sugegested by Sergey Senozhatsky and Johannes Weiner).
  * Use get_first_page() and add cond_resched() in retry-loop.
    (patch 6) (sugegested by Sergey Senozhatsky).
v6:
  * Move the move-to-front logic into zs_map_object (patch 4)
    (suggested by Minchan Kim).
  * Small clean up for free_zspage at free_handles() call site
    (patch 6) (suggested by Minchan Kim).
v5:
  * Add a new patch that eliminates unused code in zpool and simplify
    the logic for storing evict handler in zbud/z3fold (patch 2)
  * Remove redudant fields in zs_pool (previously required by zpool)
    (patch 3)
  * Wrap under_reclaim and deferred handle freeing logic in CONFIG_ZPOOL
    (patch 6) (suggested by Minchan Kim)
  * Move a small piece of refactoring from patch 6 to patch 4.
v4:
  * Wrap the new LRU logic in CONFIG_ZPOOL (patch 3).
    (suggested by Minchan Kim)
v3:
  * Set pool->ops = NULL when pool->zpool_ops is null (patch 4).
  * Stop holding pool's lock when calling lock_zspage() (patch 5).
    (suggested by Sergey Senozhatsky)
  * Stop holding pool's lock when checking pool->ops and retries.
    (patch 5) (suggested by Sergey Senozhatsky)
  * Fix formatting issues (.shrink, extra spaces in casting removed).
    (patch 5) (suggested by Sergey Senozhatsky)
v2:
  * Add missing CONFIG_ZPOOL ifdefs (patch 5)
    (detected by kernel test robot).

Unlike other zswap's allocators such as zbud or z3fold, zsmalloc
currently lacks the writeback mechanism. This means that when the zswap
pool is full, it will simply reject further allocations, and the pages
will be written directly to swap.

This series of patches implements writeback for zsmalloc. When the zswap
pool becomes full, zsmalloc will attempt to evict all the compressed
objects in the least-recently used zspages.

There are 6 patches in this series:

Johannes Weiner (2):
  zswap: fix writeback lock ordering for zsmalloc
  zpool: clean out dead code

Nhat Pham (4):
  zsmalloc: Consolidate zs_pool's migrate_lock and size_class's locks
  zsmalloc: Add a LRU to zs_pool to keep track of zspages in LRU order
  zsmalloc: Add zpool_ops field to zs_pool to store evict handlers
  zsmalloc: Implement writeback mechanism for zsmalloc

 mm/z3fold.c   |  36 +-----
 mm/zbud.c     |  32 +----
 mm/zpool.c    |  10 +-
 mm/zsmalloc.c | 342 +++++++++++++++++++++++++++++++++++++++++---------
 mm/zswap.c    |  35 +++---
 5 files changed, 311 insertions(+), 144 deletions(-)

--
2.30.2
