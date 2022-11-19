Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B1963084C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiKSBTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiKSBSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:18:15 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41F7F41B1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:15:44 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 62so6287216pgb.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXVKU8ju9i6lgVo4GHLlSQvxR+3nZ3i/iGJQSsIEw+M=;
        b=jBhZspZhLzlDshrZ/lo4FyZvP0Y26uOgONnXztvGdE4w/RlHjf7VoFHEy/c1QXw9OC
         3sh/pvMH4xjovvN5ZMgrFxs7uaMbEz6EfixhJHiZYxopq/6bP14oIYnEtgTOHe1bmjEt
         2pH3951rnmqnaeRLCM26DP3goHH8vWmo0GFgnf81JZW/KSDg+nnAJfgZasbKgYIZsw66
         ld/4s7hw9iZC3UYE461byM9rk8f9S8QzWQ4Q7tAQW9aA+fMgeZ6rfu/441Wsqap1fvsg
         TKwiBsOZCHowCBL25wiaNVJupPCK9Vqkzg0FSskz55asJlf6oPn+0Nu52DBiMPBxuC63
         O5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXVKU8ju9i6lgVo4GHLlSQvxR+3nZ3i/iGJQSsIEw+M=;
        b=Pt0ngFeCV39pRvBCD56ZQBAECsjz9lehH52QfNJfK+EEif9jjNaji+1nOWU019kyTg
         /CRtnFSNbjTQAp6X72IG3WJw5YDoYkZDBl8EgKviKSSy9XogZ5JGz4f3bld7vkV+2D3z
         HOipMB7CoAojZMrqJZQOMI/0t4mNcs22JQte0hMxFPLR0+GuSbimzlMUClbtrN9KZxfF
         Hoib4dcetrlpHOzHQG5AKT9WXgG5y2ub3rmHlxGEDsiOL5KiSlQ+tOwUE7NGBEGM+jbO
         XvzNvRRZJ2EpEfpypL8RNa2uJiUUTewkTbqOvoPKXhTcNPjT7uc6zZwZCMVUShwz/MYD
         l7mQ==
X-Gm-Message-State: ANoB5pmJG/siuwJCrj3wQviePE0fFy9CZH4NfYU1Qg2JwOKXe1c5QME6
        34X85V8Z/8Du11U4KkmkRlA=
X-Google-Smtp-Source: AA0mqf4o0mZwA9ALBxUb5i0SL4h26XRRE7ZV45iOu6VSl418vkZYGDCrR1JlEljlL4scZsw87eJCWQ==
X-Received: by 2002:a63:4701:0:b0:476:d784:1c44 with SMTP id u1-20020a634701000000b00476d7841c44mr8385602pga.431.1668816944233;
        Fri, 18 Nov 2022 16:15:44 -0800 (PST)
Received: from localhost (fwdproxy-prn-120.fbsv.net. [2a03:2880:ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id x2-20020a626302000000b0056d3b8f530csm3827237pfb.34.2022.11.18.16.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 16:15:43 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v6 5/6] zsmalloc: Add zpool_ops field to zs_pool to store evict handlers
Date:   Fri, 18 Nov 2022 16:15:35 -0800
Message-Id: <20221119001536.2086599-6-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221119001536.2086599-1-nphamcs@gmail.com>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
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

This adds a new field to zs_pool to store evict handlers for writeback,
analogous to the zbud allocator.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 mm/zsmalloc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7dd464b5a6a5..9920f3584511 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -242,6 +242,8 @@ struct zs_pool {
 #ifdef CONFIG_ZPOOL
 	/* List tracking the zspages in LRU order by most recently added object */
 	struct list_head lru;
+	struct zpool *zpool;
+	const struct zpool_ops *zpool_ops;
 #endif

 #ifdef CONFIG_ZSMALLOC_STAT
@@ -382,7 +384,14 @@ static void *zs_zpool_create(const char *name, gfp_t gfp,
 	 * different contexts and its caller must provide a valid
 	 * gfp mask.
 	 */
-	return zs_create_pool(name);
+	struct zs_pool *pool = zs_create_pool(name);
+
+	if (pool) {
+		pool->zpool = zpool;
+		pool->zpool_ops = zpool_ops;
+	}
+
+	return pool;
 }

 static void zs_zpool_destroy(void *pool)
--
2.30.2
