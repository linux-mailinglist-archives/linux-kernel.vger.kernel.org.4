Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068396F5ABB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 17:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjECPMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 11:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjECPMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 11:12:19 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDF34EEC
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 08:12:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50be17a1eceso2399717a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 08:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683126737; x=1685718737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2BX6nWAElbktu61khbd0CCx1zjsdbT7nj779WoSgig=;
        b=Qi6kuSdLcWjDbiev/7XbQmEqXPI+b4DTWodJFdtLrPJwebJmneRvtEyv4A2AHACHjr
         KZQQ1zaSdVzACQuRGfqTmaCV7NNnJCWmZKO77OnD9u4aRNSEWYxkrkGFEGDxA+/owHIl
         u8ubC4loyBWDTJAOFa3xOQtsCufSlyiMl/7Z9Y0yyHMle7Xz1ssAEeS0t1erXno8rHyw
         BorSbdZBPzEs6QcbRMSkImRcwRZnl4vQUw98AxBss4m9UhUMt8cjU2rSNXrJjyzkDAHO
         N6OEbz7VqunpgwydGsthlQXYRAZMoaZ57lhUkuDfsY4rv9c11EdcWrO9nNaNwpJp4Feo
         hu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683126737; x=1685718737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2BX6nWAElbktu61khbd0CCx1zjsdbT7nj779WoSgig=;
        b=IrY+vSu0Zcbq37GAgAorB2d59J4fsGetgkWTEZJvEd3cpbot39MIjCXU5DhbDkDwxd
         iXYmU8twjkt0hn7rfbSHzrHDYDVqi9QH5LT144Isot2KT4OYYqG1MH5S4R02AF0S84aK
         fuOehH1e5i/cC1az8PXjk4v3j/pJ/hWDabTBg7pJKa1dttYmXV7NBOaGSLguaFN/p6rN
         c3xiE7fgG95I96mAMvXOR+wesDx0T/A6g2cHZkGPgjCb2D/5qpJwU1DI2P29i0CGlKFf
         biPfO5wwpWDEBrxQ1RJiTzLOnJsvIgb0irLWrPuJJUiOzFhMkHptQ010Kc06KXJpuKsF
         VobA==
X-Gm-Message-State: AC+VfDwZYX5OSMRfXRg5a8V2goUctniKFDRgAaZpnBMowruzvG1sE6q/
        GL8lDkDG3tecummVEPiN9qg=
X-Google-Smtp-Source: ACHHUZ5zj66pRwOFBbL/PILSfveFY9WzUGN8wSua4Hq5MvKvv5uge/onUY79vZp3saY5nTEOtosOoQ==
X-Received: by 2002:a17:907:9721:b0:94f:3980:bf91 with SMTP id jg33-20020a170907972100b0094f3980bf91mr4315478ejc.19.1683126736625;
        Wed, 03 May 2023 08:12:16 -0700 (PDT)
Received: from lelloman-5950.. (host-95-235-191-161.retail.telecomitalia.it. [95.235.191.161])
        by smtp.gmail.com with ESMTPSA id mb20-20020a170906eb1400b0094f432f2429sm17527738ejb.109.2023.05.03.08.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 08:12:15 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        minchan@kernel.org, ngupta@vflare.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     hannes@cmpxchg.org,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v2] mm: fix zswap writeback race condition
Date:   Wed,  3 May 2023 17:12:00 +0200
Message-Id: <20230503151200.19707-1-cerasuolodomenico@gmail.com>
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

V2:
- updated comment with better explaination of the situation being
addressed in the check

Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index f6c89049cf70..5d5977c9ea45 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -995,6 +995,22 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 		goto fail;
 
 	case ZSWAP_SWAPCACHE_NEW: /* page is locked */
+		/*
+		 * Having a local reference to the zswap entry doesn't exclude
+		 * swapping from invalidating and recycling the swap slot. Once
+		 * the swapcache is secured against concurrent swapping to and
+		 * from the slot, recheck that the entry is still current before
+		 * writing.
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

