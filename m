Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886FF739B26
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjFVIz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjFVIzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:55:09 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B501FDD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:54:59 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b5585e84b4so6827235ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687424099; x=1690016099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pXD3DmjPUfWk2+jjA+m+4zKKy0fC+8AwUsZhq2lRmk=;
        b=E+tFDKMSki037PBhfmhvWVloKXWuzU3Ri56xXQW9hCkunzqr3/MhlEZSqiNZ+tNI9q
         wXEuj2hNk0ysqFsBunC7adB4hsOSpWoOkzyNHyQickBfIH13Ob7zUzdQVkoowJm+gwHf
         GqLtSyQYvEY7J6FdTyYJ1xVnKRHg63OezBYT/3UycGb6EQo3xYiC+CTrGWJfn3US3UhJ
         dbGuvQxkFI38s4idyaP5iHfWFNKc7ZWCaOV72DK+NmzkQO6lFrqKljjPnoN3sVHURF0C
         M8AH8Js6rxjyGoBC/sNAUYyKjN9tqWo3Nk1SQH9TmJx7zV/vF6Qb8YX+sV5g8XxbHf9I
         nLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424099; x=1690016099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pXD3DmjPUfWk2+jjA+m+4zKKy0fC+8AwUsZhq2lRmk=;
        b=VkbgaEQI0Y8HaURXGaBBx05C0goTVm3STUfTLKomAoAdeeenoO9p4umYqaIcfcbPwm
         F9JaJFEqp18VS77M83Edsr8ALDC08qFoWzg1GE6OG7dJhgzFf+pjTQDwVxFK60n/nGSs
         ZUr20V9T9BIrra2Uu+3Eubr35Ck3Ie28VYjMUYBjBcBKG2vWqhKqxooguZ70tgg92bF7
         syg8G3FD+WB+A8iR37Mr1VKf51Q5WuQ2nP42IIIWPYf1T8aN3lQF7inaKfcYcAaNGH59
         VYk6R8qKa4h7DokhdUukgQ0re0A7ip7wa+5xG5yZWjgG0XnPjXTEYN8CAtJ/6mqu6Gl0
         xH0A==
X-Gm-Message-State: AC+VfDx1/qBZuFeZPpNBogoAy9eXVF2Cs78idHrMmVsV0KiXNEkNbGWe
        3kaflVuOV5e/EBv96b+PSFWlmg==
X-Google-Smtp-Source: ACHHUZ6uW4WhSYRgUY2aQCit4ogoH8R/r57rghu14Eyu6d6WG0AvLb+rcmWHNr1Voea08aO5tIYo3Q==
X-Received: by 2002:a17:902:ecc6:b0:1ae:1364:6086 with SMTP id a6-20020a170902ecc600b001ae13646086mr21600250plh.2.1687424099018;
        Thu, 22 Jun 2023 01:54:59 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001b549fce345sm4806971plw.230.2023.06.22.01.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:54:58 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 07/29] dm zoned: dynamically allocate the dm-zoned-meta shrinker
Date:   Thu, 22 Jun 2023 16:53:13 +0800
Message-Id: <20230622085335.77010-8-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for implementing lockless slab shrink,
we need to dynamically allocate the dm-zoned-meta shrinker,
so that it can be freed asynchronously using kfree_rcu().
Then it doesn't need to wait for RCU read-side critical
section when releasing the struct dmz_metadata.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 drivers/md/dm-zoned-metadata.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index 9d3cca8e3dc9..41b10ffb968a 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -187,7 +187,7 @@ struct dmz_metadata {
 	struct rb_root		mblk_rbtree;
 	struct list_head	mblk_lru_list;
 	struct list_head	mblk_dirty_list;
-	struct shrinker		mblk_shrinker;
+	struct shrinker		*mblk_shrinker;
 
 	/* Zone allocation management */
 	struct mutex		map_lock;
@@ -615,7 +615,7 @@ static unsigned long dmz_shrink_mblock_cache(struct dmz_metadata *zmd,
 static unsigned long dmz_mblock_shrinker_count(struct shrinker *shrink,
 					       struct shrink_control *sc)
 {
-	struct dmz_metadata *zmd = container_of(shrink, struct dmz_metadata, mblk_shrinker);
+	struct dmz_metadata *zmd = shrink->private_data;
 
 	return atomic_read(&zmd->nr_mblks);
 }
@@ -626,7 +626,7 @@ static unsigned long dmz_mblock_shrinker_count(struct shrinker *shrink,
 static unsigned long dmz_mblock_shrinker_scan(struct shrinker *shrink,
 					      struct shrink_control *sc)
 {
-	struct dmz_metadata *zmd = container_of(shrink, struct dmz_metadata, mblk_shrinker);
+	struct dmz_metadata *zmd = shrink->private_data;
 	unsigned long count;
 
 	spin_lock(&zmd->mblk_lock);
@@ -2936,17 +2936,22 @@ int dmz_ctr_metadata(struct dmz_dev *dev, int num_dev,
 	 */
 	zmd->min_nr_mblks = 2 + zmd->nr_map_blocks + zmd->zone_nr_bitmap_blocks * 16;
 	zmd->max_nr_mblks = zmd->min_nr_mblks + 512;
-	zmd->mblk_shrinker.count_objects = dmz_mblock_shrinker_count;
-	zmd->mblk_shrinker.scan_objects = dmz_mblock_shrinker_scan;
-	zmd->mblk_shrinker.seeks = DEFAULT_SEEKS;
+
+	zmd->mblk_shrinker = shrinker_alloc_and_init(dmz_mblock_shrinker_count,
+						     dmz_mblock_shrinker_scan,
+						     0, DEFAULT_SEEKS, 0, zmd);
+	if (!zmd->mblk_shrinker) {
+		dmz_zmd_err(zmd, "allocate metadata cache shrinker failed");
+		goto err;
+	}
 
 	/* Metadata cache shrinker */
-	ret = register_shrinker(&zmd->mblk_shrinker, "dm-zoned-meta:(%u:%u)",
+	ret = register_shrinker(zmd->mblk_shrinker, "dm-zoned-meta:(%u:%u)",
 				MAJOR(dev->bdev->bd_dev),
 				MINOR(dev->bdev->bd_dev));
 	if (ret) {
 		dmz_zmd_err(zmd, "Register metadata cache shrinker failed");
-		goto err;
+		goto err_shrinker;
 	}
 
 	dmz_zmd_info(zmd, "DM-Zoned metadata version %d", zmd->sb_version);
@@ -2982,6 +2987,8 @@ int dmz_ctr_metadata(struct dmz_dev *dev, int num_dev,
 	*metadata = zmd;
 
 	return 0;
+err_shrinker:
+	shrinker_free(zmd->mblk_shrinker);
 err:
 	dmz_cleanup_metadata(zmd);
 	kfree(zmd);
@@ -2995,7 +3002,7 @@ int dmz_ctr_metadata(struct dmz_dev *dev, int num_dev,
  */
 void dmz_dtr_metadata(struct dmz_metadata *zmd)
 {
-	unregister_shrinker(&zmd->mblk_shrinker);
+	unregister_and_free_shrinker(zmd->mblk_shrinker);
 	dmz_cleanup_metadata(zmd);
 	kfree(zmd);
 }
-- 
2.30.2

