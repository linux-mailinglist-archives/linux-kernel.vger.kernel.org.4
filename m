Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553A76F58F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjECNWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjECNV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:21:59 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC1A4EE3
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 06:21:57 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-959a626b622so794607166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 06:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683120116; x=1685712116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzRMXTYTdYPpAVFcOzJCYrFtdtIU5s0xCA/fMsi9aVw=;
        b=cuuqP3nm2QUBC+7cVDDovQ740IJJwyhLSVr/ectDHCYST3DngPuVYqo7Ullpj6XphU
         j/QVMsBfRJe4qn0D3BjPXX+pI1k0cCckd/0ClZIfSALQ5FdW1YiOjQL66rnuHW2K9VXF
         x+PS4HT3ZFENun4xA2tHT4Xs4kNAqqj1UKyU+4V52e6FP4ozLXC2OCfe3rQo3EQkrQ7p
         ho7bm7ooSXkzWCVK4WRp5HwTZnNiXducAlrdzNrQeW9bbQ9QHyaMpQxEoB4HDjDpFiJQ
         DFhatqQWJyzhjjE4PDbgv5bRgKTlP0Ow9B/do7N+WxITCAuN8IIWvo23qYuvTuU+haAt
         3Srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683120116; x=1685712116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZzRMXTYTdYPpAVFcOzJCYrFtdtIU5s0xCA/fMsi9aVw=;
        b=E25HjDCqneuCyBcV4k5++rS8g8yimHChjzRtq8Z4KpM749opzXrvUvSmSGxwn/S4CO
         k0GNW3k3C3HqKFD3oa91+pEl8tZoPdxxRwWzB4qQnfL5OycPyUqhAu2QTNtECUzL8NAA
         fwKLl3yAwjAQ24Np711gCqVt5nqDqqMHdkJ1Ll1ipySt0pxt5C4YBYzvt0y0A8c3KNyi
         OLN4nVhzhWCaaIFq0meGbQ+bLD3BrU8HUycKqCLFRnLJdBzA4qNxSVvQB/jv+HVwweJu
         8KQYT2nzKUBMDJKXzZFXz8GwGF+ApFMXwrh+0Tqkb2Shhgqbyj24mqkrp8WGYQ3HrWVY
         rHww==
X-Gm-Message-State: AC+VfDzLCEpRCX4IoY1vgKHSBxDUP0/MYr25jPJ88wS4wB97KMTkjC8G
        GebM65owETlYG0evE5wCdlMVvjcjFufH+Q==
X-Google-Smtp-Source: ACHHUZ7ITP51j4I84yloYFqzhbTNOPuguHfdetHU3+588kvjv+IB7GSvJJK1uHoy2aUY+IpPhKp4bA==
X-Received: by 2002:a17:907:3e22:b0:94e:c40a:cca9 with SMTP id hp34-20020a1709073e2200b0094ec40acca9mr3775771ejc.35.1683120116043;
        Wed, 03 May 2023 06:21:56 -0700 (PDT)
Received: from lelloman-5950.. (host-95-235-191-161.retail.telecomitalia.it. [95.235.191.161])
        by smtp.gmail.com with ESMTPSA id vh7-20020a170907d38700b0094f31208918sm17107250ejc.108.2023.05.03.06.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 06:21:55 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        minchan@kernel.org, ngupta@vflare.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     hannes@cmpxchg.org,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH] mm: fix zswap writeback race condition
Date:   Wed,  3 May 2023 15:21:48 +0200
Message-Id: <20230503132148.9682-1-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zswap writeback mechanism can cause a race condition resulting in
memory corruption, where a swapped out page gets swapped in with data
that was written to a different page.

The race unfolds like this:
1. a page with data A and swap offset X is stored in zswap
2. page A is removed off the LRU by zpool driver for writeback in
zswap-shrink work, data for A is mapped by zpool driver
3. user space program faults and invalidates page entry A, offset X is
considered free
4. kswapd stores page B at offset X in zswap (zswap could also be full,
if so, page B would then be IOed to X, then skip step 5.)
5. entry A is replaced by B in tree->rbroot, this doesn't affect the
local reference held by zswap-shrink work
6. zswap-shrink work writes back A at X, and frees zswap entry A
7. swapin of slot X brings A in memory instead of B

The fix:
Once the swap page cache has been allocated (case ZSWAP_SWAPCACHE_NEW),
zswap-shrink work just checks that the local zswap_entry reference is
still the same as the one in the tree. If it's not the same it means
that it's either been invalidated or replaced, in both cases the
writeback is aborted because the local entry contains stale data.

Reproducer:
I originally found this by running `stress` overnight to validate my
work on the zswap writeback mechanism, it manifested after hours on my
test machine. The key to make it happen is having zswap writebacks, so
whatever setup pumps /sys/kernel/debug/zswap/written_back_pages should
do the trick.
In order to reproduce this faster on a vm, I setup a system with ~100M
of available memory and a 500M swap file, then running
`stress --vm 1 --vm-bytes 300000000 --vm-stride 4000` makes it happen
in matter of tens of minutes. One can speed things up even more by
swinging /sys/module/zswap/parameters/max_pool_percent up and down
between, say, 20 and 1; this makes it reproduce in tens of seconds.
It's crucial to set `--vm-stride` to something other than 4096 otherwise
`stress` won't realize that memory has been corrupted because all pages
would have the same data.

Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 mm/zswap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index f6c89049cf70..d20d60266bc8 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -995,6 +995,19 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 		goto fail;
 
 	case ZSWAP_SWAPCACHE_NEW: /* page is locked */
+		/*
+		 * if the entry in the tree has been replaced, it means that we would
+		 * be overriding the swap page with stale data, let's not do that.
+		 */
+		spin_lock(&tree->lock);
+		if (zswap_rb_search(&tree->rbroot, entry->offset) != entry) {
+			spin_unlock(&tree->lock);
+			delete_from_swap_cache(page_folio(page));
+			ret = -ENOMEM;
+			goto fail;
+		}
+		spin_unlock(&tree->lock);
+
 		/* decompress */
 		acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
 		dlen = PAGE_SIZE;
-- 
2.34.1

