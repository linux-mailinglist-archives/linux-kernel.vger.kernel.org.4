Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933D7621D0C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiKHTcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiKHTcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:32:14 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E471F6AECE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 11:32:13 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id h193so14219655pgc.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 11:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcRGiok93yrAI7cvzhwIp5D29F3AFI0/ULm3Nt1q2VU=;
        b=fqWVAbjdw/fNyqUE/etLKdBoXVwrp6pKlcFnwPGKLcOfZBud1HZCf6BK53gHrYdV4g
         IGtamwQbgzqDFuKM78ggN/XUx84npKmZFw7VBbsZ9GFU4jvRffJ7QeuBgCY26lk/XZfJ
         Fo0/BYnSR0oQQHgW7jb+qeC2N6tS06hg+ewVnR12TCYRT2I2Eon1Q03flOwqrDoZx7C1
         0KDKAtbrovbnna4a5n5LUYeCM48kjQQceWfwPa/IuPCChs6JWTSuWBLITjyRGa5wBu0V
         Q0VJr/FlETrNwTiE0In3eUtKGNy2RX9SPuh38w4ZsTDemlolYpXZVDVjeZbQw4BLUMp1
         f8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcRGiok93yrAI7cvzhwIp5D29F3AFI0/ULm3Nt1q2VU=;
        b=yQZFnLvBgh8A05VOGCpaPL/WDqoOzbbs2siK31p01fGDH6yPT68RlkmMzbdhxG+jtG
         57rqIUyYTDSVkux09/jh/1JWPNknLBKFP0vnnL+UU7zyy9TR/h19tH5/lqy7UScBQuR9
         DHK7DsqfKNc7HMhgLrGWQBn3LjFTorqyOsxPPX7WIzvX5H8nT0dFnj0+xcKvoKqG4NtF
         486g2b7Nc/MRQ67nUlmVuVRYfLowVq9fRCVvKEy1GPdd/GAkvsnQya9xA93yzQWKfNeS
         0EomoZLt7e/s7TLhTpSuopbpsmDDv5xwtqOdtraLc2zQmK6mFgVn+Rz/xRHaxSqgHDyn
         aNNQ==
X-Gm-Message-State: ANoB5pmcVXA0alRNUFXVcvsRaZ0VvD/WCLPL2LpF65cH2ru7UtpDcqp7
        TjTtlKPJpMh0pGNXF8cOf2A=
X-Google-Smtp-Source: AA0mqf6iiFu5zDZOHd3n6s6iM4xfMmMFKoWMGjMEb6APqnthOimT7tHF15pQHafzLwYbBJRleC1A4w==
X-Received: by 2002:a05:6a00:1689:b0:56e:d7f4:3aca with SMTP id k9-20020a056a00168900b0056ed7f43acamr18175224pfc.55.1667935933322;
        Tue, 08 Nov 2022 11:32:13 -0800 (PST)
Received: from localhost (fwdproxy-prn-002.fbsv.net. [2a03:2880:ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902c3d500b00186c9d17af2sm7336166plj.17.2022.11.08.11.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 11:32:12 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v3 4/5] zsmalloc: Add ops fields to zs_pool to store evict handlers
Date:   Tue,  8 Nov 2022 11:32:06 -0800
Message-Id: <20221108193207.3297327-5-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221108193207.3297327-1-nphamcs@gmail.com>
References: <20221108193207.3297327-1-nphamcs@gmail.com>
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
 mm/zsmalloc.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 600c40121544..ac86cffa62cd 100644
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

@@ -242,6 +248,12 @@ struct zs_pool {
 	/* List tracking the zspages in LRU order by most recently added object */
 	struct list_head lru;

+#ifdef CONFIG_ZPOOL
+	const struct zs_ops *ops;
+	struct zpool *zpool;
+	const struct zpool_ops *zpool_ops;
+#endif
+
 #ifdef CONFIG_ZSMALLOC_STAT
 	struct dentry *stat_dentry;
 #endif
@@ -379,6 +391,18 @@ static void record_obj(unsigned long handle, unsigned long obj)

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
@@ -388,7 +412,19 @@ static void *zs_zpool_create(const char *name, gfp_t gfp,
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
