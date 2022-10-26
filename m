Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E1B60E9DF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbiJZUHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbiJZUGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:06:22 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12D895AF5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:06:19 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l6so11527361pjj.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSvm1OVp5HfWSmnERqwnki4xcSgkSWyRsvH49QuFnfE=;
        b=M6ji8O15HzhOwy1jXWvAOlfmKQUeVoW/EbKvR9LcvTBC2x5En6d987HkhhRKanDnDV
         SFN0WzFT4ZC2IsTIbJT5za3RFvKWWLefUJFkXiy61PQEpN2Fz4H37MdsGumYX9eWk1OO
         +HWsUn9490Xsf9bxh5xgwAintd2PGJAmexI6ec0NZ4gFb2byWvu1AHzmsOmg2jfPs6E6
         P90BnIAzYLyBAzAd7BTeGB5jkonOtk6qNosTYS54/+1/I0O53P9Jib8/1rTtg6vrPmRC
         ptPQUtnCiSrt2ARsE37QJsrbwBaiZRkzXYx1XNw/Jk7Ms0ycWP/g3fFmzFKmA5GSJXhG
         KNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSvm1OVp5HfWSmnERqwnki4xcSgkSWyRsvH49QuFnfE=;
        b=osIFDripWQ80NtYEftNCDlYdaQ95lzAWHMIqUC3h/tV60628KJNkoohf31IOVzjfey
         7Cxo65u/92Yp6izlscsUP3UlAwNZFnTwSWI1BrZvUY4IHUXuuK80JH8wuAX2gedcHZvV
         gONTKw+tPBBQK3/BUQtQPdA5WnmyWXB8vxV0QO6XFZ9zuBEMfaZZ1tHtaQ335kfIdY/C
         ZZ60c1J16+99GqeDObrqfCzMdlmL+LhH2hyJo9O9qsTRJyIx9/Dsuw4aBjmwHL6XuJLP
         8BE3eEwwUEj4LJ26I9IVbsEgXpuI2ar9JMS4m/vyuvbwpuRER/kMBf4ZBAMTSBcixO1C
         /YHg==
X-Gm-Message-State: ACrzQf3VWjavHy0ykFakxqNnlYLla9JgJDhJGdoaHk6tEyORGSBoKzgi
        kS2ICfbxFg5rBEyMj95kF4s=
X-Google-Smtp-Source: AMsMyM674zgL8iO4JRwqnHUIBUF6Ov4gW2fScbBTdsr+f9/SPERPs84eNW+urbl4pIRkzYVLjlt5fw==
X-Received: by 2002:a17:902:be0b:b0:182:fd6:1293 with SMTP id r11-20020a170902be0b00b001820fd61293mr46049794pls.146.1666814779269;
        Wed, 26 Oct 2022 13:06:19 -0700 (PDT)
Received: from localhost (fwdproxy-prn-023.fbsv.net. [2a03:2880:ff:17::face:b00c])
        by smtp.gmail.com with ESMTPSA id 126-20020a620484000000b0056c349f5c70sm2565942pfe.79.2022.10.26.13.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:06:18 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH 4/5] zsmalloc: Add ops fields to zs_pool to store evict handlers
Date:   Wed, 26 Oct 2022 13:06:12 -0700
Message-Id: <20221026200613.1031261-5-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221026200613.1031261-1-nphamcs@gmail.com>
References: <20221026200613.1031261-1-nphamcs@gmail.com>
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
 mm/zsmalloc.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 600c40121544..76ff2ed839d0 100644
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
@@ -388,7 +412,17 @@ static void *zs_zpool_create(const char *name, gfp_t gfp,
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
+	}
+
+	return pool;
 }
 
 static void zs_zpool_destroy(void *pool)
-- 
2.30.2

