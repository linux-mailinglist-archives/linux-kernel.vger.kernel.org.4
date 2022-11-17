Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D738C62E225
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240542AbiKQQj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbiKQQi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:38:56 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF5E7C011
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:38:47 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso5875119pjg.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Nqg4Xt8lGKthWB+nE04XmQsPpZUs65jb+qHOq4Cr/k=;
        b=PRXwfJiPmdnJffoazkBjUBN8ZE3gBH/hkNy/65kEe1ygSQwxKpmoEIjZkvNBkBd3d4
         UAcN7kr2yQiixORgoPBvpXxN27IMZ+QOmLa8coD8Fa9cMn2Khspr0MSgul60p0CoPc9S
         V+hm8qNojAxVS77NWN/UxmzX/5B2ujehMRzWW57FsYBMYCh65oPMx5O2EkKMzdJq8OIs
         wz9RkshLbCfjuOFy8mofp+9SYbllP0P65SoImEnn29027zUuKntQn2uac4eQxrdzBN7W
         n57wczZSCztTlEVXxl8d3ExlLHHiz5qAxdv8Y9hE3J/YV9vEgMNrMQKQ3YdiJzgniV/Z
         VWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Nqg4Xt8lGKthWB+nE04XmQsPpZUs65jb+qHOq4Cr/k=;
        b=yPrBJXPszLxGdSpBb3CPSD85IfpiYH2H31FrnITV4zsuRvfwDJjCVH/WQ9Xyp3rz+Q
         obfV7ot8cLemyiPz2HYMaBdQVSxM8daOlPQxT3B+An7f1ORnmPjElh56emLmb9es//7B
         qxopPOaNW0zhs9Dkiy83y5twGQ1pBoZ3raovOzzh8pk4hEsSX1Jz7omiRPWtRLnL6Pv9
         YGWnGvzgDYc4hER3n+/dBi1R9hAjnZF3JkLA+VXzjmFl2EU8jfbGEQYISU4ydqjG0NTw
         sPV+C1tMOf/g+Mli38Mgrqyfptbnx2/iVKIxN5MBMxfdc8F5dMhxBG19aFxz9oFy/WWm
         WkrQ==
X-Gm-Message-State: ANoB5pkzoP31++w4J9lQbWW2PXVfcSqBXkXNK2YiX/xafn47hRbHB/ay
        UpCq5djHN8AbKVvy3IjwlSDHdMMGuSOUlw==
X-Google-Smtp-Source: AA0mqf44KzoNad4Ffghvr1rp79PUpUhzA6ssZf3/8UcqNZf9nc9k7+WSrqnu8RxDJ2OxLOuAnvhU0g==
X-Received: by 2002:a17:90a:bc4b:b0:212:d796:d30f with SMTP id t11-20020a17090abc4b00b00212d796d30fmr3699709pjv.9.1668703126784;
        Thu, 17 Nov 2022 08:38:46 -0800 (PST)
Received: from localhost (fwdproxy-prn-001.fbsv.net. [2a03:2880:ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090322c400b0016f196209c9sm1645420plg.123.2022.11.17.08.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:38:46 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v4 4/5] zsmalloc: Add ops fields to zs_pool to store evict handlers
Date:   Thu, 17 Nov 2022 08:38:38 -0800
Message-Id: <20221117163839.230900-5-nphamcs@gmail.com>
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

This adds fields to zs_pool to store evict handlers for writeback,
analogous to the zbud allocator.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zsmalloc.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 2557b55ec767..776d0e15a401 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -225,6 +225,12 @@ struct link_free {
 	};
 };

+struct zs_pool;
+
+struct zs_ops {
+	int (*evict)(struct zs_pool *pool, unsigned long handle);
+};
+
 struct zs_pool {
 	const char *name;

@@ -242,6 +248,9 @@ struct zs_pool {
 #ifdef CONFIG_ZPOOL
 	/* List tracking the zspages in LRU order by most recently added object */
 	struct list_head lru;
+	const struct zs_ops *ops;
+	struct zpool *zpool;
+	const struct zpool_ops *zpool_ops;
 #endif

 #ifdef CONFIG_ZSMALLOC_STAT
@@ -385,6 +394,18 @@ static void record_obj(unsigned long handle, unsigned long obj)

 #ifdef CONFIG_ZPOOL

+static int zs_zpool_evict(struct zs_pool *pool, unsigned long handle)
+{
+	if (pool->zpool && pool->zpool_ops && pool->zpool_ops->evict)
+		return pool->zpool_ops->evict(pool->zpool, handle);
+	else
+		return -ENOENT;
+}
+
+static const struct zs_ops zs_zpool_ops = {
+	.evict =	zs_zpool_evict
+};
+
 static void *zs_zpool_create(const char *name, gfp_t gfp,
 			     const struct zpool_ops *zpool_ops,
 			     struct zpool *zpool)
@@ -394,7 +415,19 @@ static void *zs_zpool_create(const char *name, gfp_t gfp,
 	 * different contexts and its caller must provide a valid
 	 * gfp mask.
 	 */
-	return zs_create_pool(name);
+	struct zs_pool *pool = zs_create_pool(name);
+
+	if (pool) {
+		pool->zpool = zpool;
+		pool->zpool_ops = zpool_ops;
+
+		if (zpool_ops)
+			pool->ops = &zs_zpool_ops;
+		else
+			pool->ops = NULL;
+	}
+
+	return pool;
 }

 static void zs_zpool_destroy(void *pool)
--
2.30.2
