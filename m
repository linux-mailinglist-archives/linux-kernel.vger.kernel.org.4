Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3258630846
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiKSBSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiKSBSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:18:09 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADEE169C15
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:15:38 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id h14so5830210pjv.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l0d0+INXxLonVlNVaXxtrteVyMG4KiznbapsCu7BEf8=;
        b=JEAySdKw7SYVBGVsVWVy4HVnJrk/5blfpJoyj7CJYYjTg5Oiol9XaYbFlHCGCqzs6D
         Q+zjqQHcr9VkaYm33ezAsm/Jd4B6FKLJdZP2GitZffxkMhj3J6SbzRv8oIvn7D50t+YZ
         VoRkBYbvfIkE+cOrvqQ11L+AhoBaskC4Eg4eYc1pFZ4LPqUdp/DShteRFXYufw3ye4Jy
         eFwYEjQxi6XBmCSoh3IxXFtHcptiAG/clonLFRxHTkENq1pnAAhKD5mW18EQOIheg03g
         Tqrx7bv8xjWm2geZJ9o+wY2ssMiZ3DJLiKgCs3oAkdEXHejriKHZUnyY1yaVNHs9Cz+F
         CTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0d0+INXxLonVlNVaXxtrteVyMG4KiznbapsCu7BEf8=;
        b=WP514W6cfV+hkNGfBuqiikK9JWp0V+j2/GXYB7R2Xqoe0suhbUMlbRhH8K5n0I7Ema
         2eWpcdhi9tRrmm+aitixzYqdrfnEmG6Ln3OUZQB/q15OxKFUYJ2STFTDQvLPjzf+zlkH
         ECuzSF68o5qQsxN04qAjaR1ew9irlOETifTYAwc488luU12tmtdruPuHUi1ytIcFkL10
         jVlFfz+AlvQfvRU3NtbxhwoqprJIriJBZyl/e2LVDZ494Yw86oZmzbhXEHHWYnlcgbg/
         hnH1YsR13E6yxWLk1BglV9GOSoqJS7K0NhA4H8K3ks7BGOdfEDhDMhFO/X5Ntu5lRe24
         ZuPA==
X-Gm-Message-State: ANoB5pnMtQ719iP1PNUxvVPaxpNAfQSw7/XATr3nOXrwXD7XR0jvWHgU
        PvKW87HCK2/M/plwu/OSLRc=
X-Google-Smtp-Source: AA0mqf7+KhbpxRUPQz21CGAUNaV7cv1+U77vIPgX58+BaO6HQjXYrsNkhXux0inUFTKsJu9rQBTKaA==
X-Received: by 2002:a17:902:f707:b0:176:b0ce:3472 with SMTP id h7-20020a170902f70700b00176b0ce3472mr1660064plo.169.1668816937584;
        Fri, 18 Nov 2022 16:15:37 -0800 (PST)
Received: from localhost (fwdproxy-prn-012.fbsv.net. [2a03:2880:ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id b15-20020a1709027e0f00b001869394a372sm4285518plm.201.2022.11.18.16.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 16:15:37 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v6 0/6] Implement writeback for zsmalloc
Date:   Fri, 18 Nov 2022 16:15:30 -0800
Message-Id: <20221119001536.2086599-1-nphamcs@gmail.com>
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
 mm/zsmalloc.c | 325 ++++++++++++++++++++++++++++++++++++++++----------
 mm/zswap.c    |  37 +++---
 5 files changed, 295 insertions(+), 145 deletions(-)

--
2.30.2
