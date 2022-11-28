Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D87D63B202
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiK1TQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbiK1TQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:16:24 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569C41B9E0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:16:23 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id w79so11474109pfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHuTThRVlbG3opW3Eui02soyfeJZjUm1L8jiWi26BCg=;
        b=C1njT9ct1VEYu1a7Som+DHiPAWCnbNJXRNIJ0x1OklwTE76JeUyTP2yaMXnFmywfH4
         WuWw8qqctMsDQtHmLfNOBUU86VVgOuFkPcDatoYete6FUZ2pGju05ox7BnhKuLBOuLCZ
         XLvJ+3eQpnSODgFAYSB+hMu1Aid/ShlAzqtk0dgyFNUac/dUdoFgZw2iIRtXQB0BOBsC
         ECpRgFsAC/0ZP0R1CHybZI8+e76M58NrWLNrYzB2dvIRN8IT+sxV4fZjs8A+Eu2cM4l5
         TO/JWLXj6SKTpgP6jedFUG1at6oSCDn680+q5y7aLWPOWN1aKsp0LGtBqQoh4oNIX+4w
         RWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHuTThRVlbG3opW3Eui02soyfeJZjUm1L8jiWi26BCg=;
        b=NWUlDOmv/dQI20cH/nciM7xh4YpIr/UWkWRsa4RfIo9dGS86adhenFVHovY7q916B/
         zxwkW9s41ALxROOqFTkqNhAe01+/HUE442BsELywAbMF7ieXHkuNYKZb+j7wNPfaWt7T
         cr44JdnbZ24uH1KhWe+6PpYmsCMiI1K5G3kkgXrBPqEUPpggmmlj1PI2B8EELhLPkNky
         HusL1yXxOeJDM8W12vKuagv1jgkPwgC7OduMr/NAHgVR0VZOxQfzfOSGsY9HpdFpPiOB
         7xLYaH+HUPt87EuOyJpsVOLiiQ764FVNVgUYPSCKUbGAGqTpcppZYYURYeNF2EWmrhO2
         jyPw==
X-Gm-Message-State: ANoB5pktuQ1EVGr847IQ75zLF+7VeJmA2LddYmwpmIaIsfW9kJPMOOqp
        Wy7inw2l6QToonQwNdl9gTU=
X-Google-Smtp-Source: AA0mqf4RsNu9K1vn8qwUjdZ6i2kL/AxZ7ZpWTB9LPwc2WGsc/bsG43pHTovayPvnSUlNKGvmMgmFsA==
X-Received: by 2002:a63:a61:0:b0:478:2d2c:6e82 with SMTP id z33-20020a630a61000000b004782d2c6e82mr3001168pgk.136.1669662982851;
        Mon, 28 Nov 2022 11:16:22 -0800 (PST)
Received: from localhost (fwdproxy-prn-018.fbsv.net. [2a03:2880:ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4-20020a630d44000000b00439c6a4e1ccsm7006068pgn.62.2022.11.28.11.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 11:16:22 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v7 4/6] zsmalloc: Add a LRU to zs_pool to keep track of zspages in LRU order
Date:   Mon, 28 Nov 2022 11:16:13 -0800
Message-Id: <20221128191616.1261026-5-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221128191616.1261026-1-nphamcs@gmail.com>
References: <20221128191616.1261026-1-nphamcs@gmail.com>
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

This helps determines the coldest zspages as candidates for writeback.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zsmalloc.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 5427a00a0518..b1bc231d94a3 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -239,6 +239,11 @@ struct zs_pool {
 	/* Compact classes */
 	struct shrinker shrinker;

+#ifdef CONFIG_ZPOOL
+	/* List tracking the zspages in LRU order by most recently added object */
+	struct list_head lru;
+#endif
+
 #ifdef CONFIG_ZSMALLOC_STAT
 	struct dentry *stat_dentry;
 #endif
@@ -260,6 +265,12 @@ struct zspage {
 	unsigned int freeobj;
 	struct page *first_page;
 	struct list_head list; /* fullness list */
+
+#ifdef CONFIG_ZPOOL
+	/* links the zspage to the lru list in the pool */
+	struct list_head lru;
+#endif
+
 	struct zs_pool *pool;
 #ifdef CONFIG_COMPACTION
 	rwlock_t lock;
@@ -953,6 +964,9 @@ static void free_zspage(struct zs_pool *pool, struct size_class *class,
 	}

 	remove_zspage(class, zspage, ZS_EMPTY);
+#ifdef CONFIG_ZPOOL
+	list_del(&zspage->lru);
+#endif
 	__free_zspage(pool, class, zspage);
 }

@@ -998,6 +1012,10 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 		off %= PAGE_SIZE;
 	}

+#ifdef CONFIG_ZPOOL
+	INIT_LIST_HEAD(&zspage->lru);
+#endif
+
 	set_freeobj(zspage, 0);
 }

@@ -1270,6 +1288,31 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	obj_to_location(obj, &page, &obj_idx);
 	zspage = get_zspage(page);

+#ifdef CONFIG_ZPOOL
+	/*
+	 * Move the zspage to front of pool's LRU.
+	 *
+	 * Note that this is swap-specific, so by definition there are no ongoing
+	 * accesses to the memory while the page is swapped out that would make
+	 * it "hot". A new entry is hot, then ages to the tail until it gets either
+	 * written back or swaps back in.
+	 *
+	 * Furthermore, map is also called during writeback. We must not put an
+	 * isolated page on the LRU mid-reclaim.
+	 *
+	 * As a result, only update the LRU when the page is mapped for write
+	 * when it's first instantiated.
+	 *
+	 * This is a deviation from the other backends, which perform this update
+	 * in the allocation function (zbud_alloc, z3fold_alloc).
+	 */
+	if (mm == ZS_MM_WO) {
+		if (!list_empty(&zspage->lru))
+			list_del(&zspage->lru);
+		list_add(&zspage->lru, &pool->lru);
+	}
+#endif
+
 	/*
 	 * migration cannot move any zpages in this zspage. Here, pool->lock
 	 * is too heavy since callers would take some time until they calls
@@ -1988,6 +2031,9 @@ static void async_free_zspage(struct work_struct *work)
 		VM_BUG_ON(fullness != ZS_EMPTY);
 		class = pool->size_class[class_idx];
 		spin_lock(&pool->lock);
+#ifdef CONFIG_ZPOOL
+		list_del(&zspage->lru);
+#endif
 		__free_zspage(pool, class, zspage);
 		spin_unlock(&pool->lock);
 	}
@@ -2299,6 +2345,10 @@ struct zs_pool *zs_create_pool(const char *name)
 	 */
 	zs_register_shrinker(pool);

+#ifdef CONFIG_ZPOOL
+	INIT_LIST_HEAD(&pool->lru);
+#endif
+
 	return pool;

 err:
--
2.30.2
