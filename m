Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB89468A941
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 10:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjBDJoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 04:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjBDJoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 04:44:06 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BF533444
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 01:44:05 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id v23so7590998plo.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 01:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jlr7ucZANS1HTD7tqpm1obhZEXx5pvk7Aus1wPx5RkM=;
        b=KsSp0F/iOCaeLRq2Btztcc61UCfwZXJnTOo43Oa0aFqzEtZBiTJUzaE0VGcxTV4u6B
         FVN0bbr/HeC3RlS4iiyi35NxLkUJVVZH5KDn77wNHqgV0ZD2/RS8mlch1qf79h6JVYbC
         +mT1I65LgeN9CdUS6ZiZ2j0fVmjAefTdm9gMQ2ZWef7cjsUECJRUyrKL6Echt0Kmzx9r
         dPlPJTF0bCiXC8pajtyI0CwY7ZJuKyT1bR/DKq54ObZ3Itc20T+9yY9qDgVBeno1CW8b
         lglA/WbHuI7NrGsn7BRLBgXtFEnIaTCTWkPaiTB6Kq0IiELEBdoZQ/AC8hlW1mlbe9gL
         OWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jlr7ucZANS1HTD7tqpm1obhZEXx5pvk7Aus1wPx5RkM=;
        b=Lexyz0jxo0L3mFlZSdBvNhXObWDhNQrFKwo/OKzCEWvUEKV9o9RVhaE5LFz1cW+MOn
         OwXDGlEYixyefQCrrmhMRBzVL84W8fs2Jt+MhKIohlnaBT6H2GIlEkbri6/xPzM7fIXt
         BBDbCdcZS/ONORSZb+3qZ4loVvUQzjBUlvwx5fPcz4y3NgCReEercXBowTjOi9L9cAE7
         /jB+LwM8bEhw9tfgGuNJqJzTlQugQRLFJj0x/oX50H7aRHVeMV3JBLUkIlSQVRtBsgjB
         cMULx655YmMsvriU9KmQcZKmnJZC6GNCEFyfompz/121XxXkWcf2cqu44QRYeSYP+g0K
         CHjA==
X-Gm-Message-State: AO0yUKV0mxPUu0xzjCebOc0HgLp+7W1pf0ECyVRK5+hBl+201pu4C4VI
        5ENsyHrAtQcJ3FXPHBeuSpyhR9vX8RCqgjtG
X-Google-Smtp-Source: AK7set+TLsj8/ei+1yPKzdLl4Lv/5CzSjD1nV609VJpiJHLZft4vH0BJSeU8b/RXQx4a8w4ZLsKtug==
X-Received: by 2002:a17:90b:38c2:b0:22c:15a4:62a0 with SMTP id nn2-20020a17090b38c200b0022c15a462a0mr13531877pjb.37.1675503845168;
        Sat, 04 Feb 2023 01:44:05 -0800 (PST)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.237])
        by smtp.gmail.com with ESMTPSA id ie12-20020a17090b400c00b0020b21019086sm10710252pjb.3.2023.02.04.01.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 01:44:04 -0800 (PST)
From:   qixiaoyu1 <qxy65535@gmail.com>
X-Google-Original-From: qixiaoyu1 <qixiaoyu1@xiaomi.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Ping Xiong <xiongping1@xiaomi.com>,
        Xiaoyu Qi <qixiaoyu1@xiaomi.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 2/2 v4] f2fs: add sysfs nodes to set last_age_weight
Date:   Sat,  4 Feb 2023 17:43:45 +0800
Message-Id: <20230204094345.591407-1-qixiaoyu1@xiaomi.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <3589331b-a3ec-87e1-790d-387439672ea5@kernel.org>
References: <3589331b-a3ec-87e1-790d-387439672ea5@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
Signed-off-by: xiongping1 <xiongping1@xiaomi.com>
---
change log v3 -> v4:
  - allow 0 and 100 to a valid value

 Documentation/ABI/testing/sysfs-fs-f2fs |  5 +++++
 fs/f2fs/extent_cache.c                  | 15 +++++++++------
 fs/f2fs/f2fs.h                          |  1 +
 fs/f2fs/sysfs.c                         | 11 +++++++++++
 4 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 9e3756625a81..11af7dbb6bc9 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -669,3 +669,8 @@ Contact:	"Ping Xiong" <xiongping1@xiaomi.com>
 Description:	When DATA SEPARATION is on, it controls the age threshold to indicate
 		the data blocks as warm. By default it was initialized as 2621440 blocks
 		(equals to 10GB).
+
+What:           /sys/fs/f2fs/<disk>/last_age_weight
+Date:           January 2023
+Contact:        "Ping Xiong" <xiongping1@xiaomi.com>
+Description:    When DATA SEPARATION is on, it controls the weight of last data block age.
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index d9f12f404beb..ce99882ba81c 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -871,19 +871,21 @@ void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
 }
 #endif
 
-static unsigned long long __calculate_block_age(unsigned long long new,
+static unsigned long long __calculate_block_age(struct f2fs_sb_info *sbi,
+						unsigned long long new,
 						unsigned long long old)
 {
 	unsigned int rem_old, rem_new;
 	unsigned long long res;
+	unsigned int weight = sbi->last_age_weight;
 
-	res = div_u64_rem(new, 100, &rem_new) * (100 - LAST_AGE_WEIGHT)
-		+ div_u64_rem(old, 100, &rem_old) * LAST_AGE_WEIGHT;
+	res = div_u64_rem(new, 100, &rem_new) * (100 - weight)
+		+ div_u64_rem(old, 100, &rem_old) * weight;
 
 	if (rem_new)
-		res += rem_new * (100 - LAST_AGE_WEIGHT) / 100;
+		res += rem_new * (100 - weight) / 100;
 	if (rem_old)
-		res += rem_old * LAST_AGE_WEIGHT / 100;
+		res += rem_old * weight / 100;
 
 	return res;
 }
@@ -917,7 +919,7 @@ static int __get_new_block_age(struct inode *inode, struct extent_info *ei,
 			cur_age = ULLONG_MAX - tei.last_blocks + cur_blocks;
 
 		if (tei.age)
-			ei->age = __calculate_block_age(cur_age, tei.age);
+			ei->age = __calculate_block_age(sbi, cur_age, tei.age);
 		else
 			ei->age = cur_age;
 		ei->last_blocks = cur_blocks;
@@ -1233,6 +1235,7 @@ void f2fs_init_extent_cache_info(struct f2fs_sb_info *sbi)
 	atomic64_set(&sbi->allocated_data_blocks, 0);
 	sbi->hot_data_age_threshold = DEF_HOT_DATA_AGE_THRESHOLD;
 	sbi->warm_data_age_threshold = DEF_WARM_DATA_AGE_THRESHOLD;
+	sbi->last_age_weight = LAST_AGE_WEIGHT;
 }
 
 int __init f2fs_create_extent_cache(void)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e8953c3dc81a..c3609cbc28c7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1679,6 +1679,7 @@ struct f2fs_sb_info {
 	/* The threshold used for hot and warm data seperation*/
 	unsigned int hot_data_age_threshold;
 	unsigned int warm_data_age_threshold;
+	unsigned int last_age_weight;
 
 	/* basic filesystem units */
 	unsigned int log_sectors_per_block;	/* log2 sectors per block */
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 83a366f3ee80..cd2fb52d1f3c 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -686,6 +686,15 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "last_age_weight")) {
+		if (t < 0 || t > 100)
+			return -EINVAL;
+		if (t == *ui)
+			return count;
+		*ui = (unsigned int)t;
+		return count;
+	}
+
 	*ui = (unsigned int)t;
 
 	return count;
@@ -944,6 +953,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, revoked_atomic_block, revoked_atomic_block)
 /* For block age extent cache */
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, hot_data_age_threshold, hot_data_age_threshold);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, warm_data_age_threshold, warm_data_age_threshold);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, last_age_weight, last_age_weight);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -1042,6 +1052,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(revoked_atomic_block),
 	ATTR_LIST(hot_data_age_threshold),
 	ATTR_LIST(warm_data_age_threshold),
+	ATTR_LIST(last_age_weight),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs);
-- 
2.39.0

