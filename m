Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4723D62E223
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbiKQQjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240637AbiKQQiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:38:55 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D29E7818B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:38:43 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id y4so2133599plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdXYXXujE5c6Z8uTdZ5KokARMRQa3FrJU+bkNzs2RLY=;
        b=oUdeLYBGlvLG123q8GqQX48SG762gZkHyxwD/CQnrBoB4Vh1+p2Ck7lVhiNkqnu5q0
         du9Xij/rT2JVxeyh9jH5BAwEhVln1dU0S3KA2SfSRSnQQG0IOlwjQHR7toI9DdBaEbeQ
         9B1MH+AyYhr8Zxcxdi22Wm8dI5rSEieLZCPSN2sPD16X47ZsCxyHQp4Avg6axUIlyOim
         PBuesYanmIb4IOmdKWe6NhkCBviHMSzeYwiqsNlw1dNcmsQZP963LulvMKKMZhxHI5Rv
         bJlQHezRy1lbHMPvTEV9CPvM/QW6fWHqSCqpAhiY34OIqcdl621KD7NG/zqRW5tQZWJP
         Z6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdXYXXujE5c6Z8uTdZ5KokARMRQa3FrJU+bkNzs2RLY=;
        b=XohBn0zuMJZjEceSSX2c2B/PBdD6spgKptGeFwpPnEbrCtngG3eFHTRhTfpWB5W5vr
         K5u/T+PGZHsRR6/zubNST8/nVZ8E0H5ee24BBsu060u8Qcb+nmfm1/GiDOgffbR40N0l
         8F3zMp6ox+/hhNJEphiOy0Gw8YfLMweXsia0og/QX0eZ+ZXY/B0Ud7m9d+wyI6TnQWbo
         c6nEj7X+koDY+tvYeSxcXsMPzlSQJlSAAnBZ/YZ55B8lUcDpbtmyBaut95iv09FdJlzL
         790Y+JSFU+7/8U8in5I4M/3BC+Hsoh9vdbMtzJwq1WF3Z27sTwVx0b9Us4lt8Sn2tUPH
         dMPw==
X-Gm-Message-State: ANoB5pnoJjaok/68kN99W+B5jBaqgSAUIbE/mTz2E5doIHNmnA5M8fx5
        v0QT4RdWe6dHAHWiXBbgkNMYIYjllGavCg==
X-Google-Smtp-Source: AA0mqf4dCzk0UaidJ1LEguhOxPNhCf2SFFc2QYWKmgSXtPv/ga+VnLB8+OZZUwB8M6zR7N1hzOWP/g==
X-Received: by 2002:a17:902:c409:b0:186:fd58:c706 with SMTP id k9-20020a170902c40900b00186fd58c706mr3658532plk.4.1668703122572;
        Thu, 17 Nov 2022 08:38:42 -0800 (PST)
Received: from localhost (fwdproxy-prn-000.fbsv.net. [2a03:2880:ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id y65-20020a626444000000b0056d73ef41fdsm1377275pfb.75.2022.11.17.08.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:38:42 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v4 1/5] zswap: fix writeback lock ordering for zsmalloc
Date:   Thu, 17 Nov 2022 08:38:35 -0800
Message-Id: <20221117163839.230900-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221117163839.230900-1-nphamcs@gmail.com>
References: <20221117163839.230900-1-nphamcs@gmail.com>
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

From: Johannes Weiner <hannes@cmpxchg.org>

zswap's customary lock order is tree->lock before pool->lock, because
the tree->lock protects the entries' refcount, and the free callbacks in
the backends acquire their respective pool locks to dispatch the backing
object. zsmalloc's map callback takes the pool lock, so zswap must not
grab the tree->lock while a handle is mapped. This currently only
happens during writeback, which isn't implemented for zsmalloc. In
preparation for it, move the tree->lock section out of the mapped entry
section

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 2d48fd59cc7a..2d69c1d678fe 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -958,7 +958,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	};

 	if (!zpool_can_sleep_mapped(pool)) {
-		tmp = kmalloc(PAGE_SIZE, GFP_ATOMIC);
+		tmp = kmalloc(PAGE_SIZE, GFP_KERNEL);
 		if (!tmp)
 			return -ENOMEM;
 	}
@@ -968,6 +968,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	swpentry = zhdr->swpentry; /* here */
 	tree = zswap_trees[swp_type(swpentry)];
 	offset = swp_offset(swpentry);
+	zpool_unmap_handle(pool, handle);

 	/* find and ref zswap entry */
 	spin_lock(&tree->lock);
@@ -975,20 +976,12 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	if (!entry) {
 		/* entry was invalidated */
 		spin_unlock(&tree->lock);
-		zpool_unmap_handle(pool, handle);
 		kfree(tmp);
 		return 0;
 	}
 	spin_unlock(&tree->lock);
 	BUG_ON(offset != entry->offset);

-	src = (u8 *)zhdr + sizeof(struct zswap_header);
-	if (!zpool_can_sleep_mapped(pool)) {
-		memcpy(tmp, src, entry->length);
-		src = tmp;
-		zpool_unmap_handle(pool, handle);
-	}
-
 	/* try to allocate swap cache page */
 	switch (zswap_get_swap_cache_page(swpentry, &page)) {
 	case ZSWAP_SWAPCACHE_FAIL: /* no memory or invalidate happened */
@@ -1006,6 +999,14 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 		acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
 		dlen = PAGE_SIZE;

+		zhdr = zpool_map_handle(pool, handle, ZPOOL_MM_RO);
+		src = (u8 *)zhdr + sizeof(struct zswap_header);
+		if (!zpool_can_sleep_mapped(pool)) {
+			memcpy(tmp, src, entry->length);
+			src = tmp;
+			zpool_unmap_handle(pool, handle);
+		}
+
 		mutex_lock(acomp_ctx->mutex);
 		sg_init_one(&input, src, entry->length);
 		sg_init_table(&output, 1);
@@ -1015,6 +1016,11 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 		dlen = acomp_ctx->req->dlen;
 		mutex_unlock(acomp_ctx->mutex);

+		if (!zpool_can_sleep_mapped(pool))
+			kfree(tmp);
+		else
+			zpool_unmap_handle(pool, handle);
+
 		BUG_ON(ret);
 		BUG_ON(dlen != PAGE_SIZE);

@@ -1045,7 +1051,11 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 		zswap_entry_put(tree, entry);
 	spin_unlock(&tree->lock);

-	goto end;
+	return ret;
+
+fail:
+	if (!zpool_can_sleep_mapped(pool))
+		kfree(tmp);

 	/*
 	* if we get here due to ZSWAP_SWAPCACHE_EXIST
@@ -1054,17 +1064,10 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	* if we free the entry in the following put
 	* it is also okay to return !0
 	*/
-fail:
 	spin_lock(&tree->lock);
 	zswap_entry_put(tree, entry);
 	spin_unlock(&tree->lock);

-end:
-	if (zpool_can_sleep_mapped(pool))
-		zpool_unmap_handle(pool, handle);
-	else
-		kfree(tmp);
-
 	return ret;
 }

--
2.30.2
