Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FFD6A7BBD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjCBHSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCBHSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:18:31 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D437D9F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 23:18:09 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so1983287pjh.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 23:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1677741489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOEf7Xpb5mkHbizoh2yjcukV0fYIhk+yPMhArKvHWnk=;
        b=SI9qPKQILSUegSga9aDKDbESKV9QZgBmwdMURAH+J2GKA6miCPfU6DYdzqFMBWhjHf
         zvepFO+Q+xMrauermsFGfMkmtL/3oMenp0t5HG9PKS8XWOEux9iG83xqWqGmL50k/n9s
         5uKQ811tk6a+oTdG4X+nDcghxaEMfxY8YyJ4yV/1ShROkRohEXUqzbTAobTgXji3+QXx
         BB+pxlVQux58clo1ixnLbkE+NyUpJ3Xy7CPzeETzfa2f31tsLEnUVJXeG8N2igOjF0Yg
         pGP9P0wzV9k5gey+7HMMOUSdXVRA6CFY55ppRWxouMmg5hKiiTlHvRw2qDNXWzuIUGzR
         Tvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677741489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOEf7Xpb5mkHbizoh2yjcukV0fYIhk+yPMhArKvHWnk=;
        b=5/poON1ftO28HB9g0fM/Z+Cu3wlmX13YvTSv0sJq3DxnjEXV3C32NO24IHjGIdZbMf
         eTWZF5NPsZNVNYhItwjHRb7P7jNRH81zwHW2E9R21b3dWkcBQNHzx+hw/3/XGmiCuH4j
         tlmTA7GfK6HNZoGEJTd4g45wgxsBJwcL7geKAPd9As1yYIuYh1/sUCYalkYq+glhl/s6
         pGQVO1F3OCjfKXgQilm5iLtKni0rVy4H4rzm0DFBadxUlaiL2o95c/caWbPlikgPr2Kj
         LUq4QhL1KBu7503uTmMWqDcRnFyxGBTz0jR62+bN74Cx3P3txrKqHkSwWO5eoSowkepG
         8POw==
X-Gm-Message-State: AO0yUKXKpB22Bd8KyWNCql6zijxz8vOIHTA6PPA2vYwmozXXjUDeeXop
        ZF4hP5DzaskYqt7NqFvko/DZjQ==
X-Google-Smtp-Source: AK7set+3fzNkZU+X9dxOT7UWt5ecBglYgwBmfTTzoARuALfR2zWAvXYO1qXMoiCTm0BC1/Ptiz0CPQ==
X-Received: by 2002:a05:6a20:a829:b0:cb:a64b:71d3 with SMTP id cb41-20020a056a20a82900b000cba64b71d3mr8003611pzb.26.1677741489032;
        Wed, 01 Mar 2023 23:18:09 -0800 (PST)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id m19-20020a637d53000000b0050300e81eb9sm8611097pgn.54.2023.03.01.23.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 23:18:08 -0800 (PST)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     xiang@kernel.org, chao@kernel.org, gerry@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org, jefflexu@linux.alibaba.com
Cc:     linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        Jia Zhu <zhujia.zj@bytedance.com>,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH V3] erofs: support flattened block device for multi-blob images
Date:   Thu,  2 Mar 2023 15:17:51 +0800
Message-Id: <20230302071751.48425-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <8be37b4c-5a87-1c10-b0e6-99284e6fd4ca@linux.alibaba.com>
References: <8be37b4c-5a87-1c10-b0e6-99284e6fd4ca@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support mounting multi-blobs container image as a single
block device, add flattened block device feature for EROFS.

In this mode, all meta/data contents will be mapped into one block
address. User could compose a block device(by nbd/ublk/virtio-blk/
vhost-user-blk) from multiple sources and mount the block device by
EROFS directly. It can reduce the number of block devices used, and
it's also benefits in both VM file passthrough and distributed storage
scenarios.

You can test this using the method mentioned by:
https://github.com/dragonflyoss/image-service/pull/1111
1. Compose a (nbd)block device from multi-blobs.
2. Mount EROFS on mntdir/.
3. Compare the md5sum between source dir and mntdir/.

Later, we could also use it to refer original tar blobs.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
v3:
1. Move the flatdev check down after all sanity checks.(Jingbo Xu)
2. Add Reviewed-by tag.
---
 fs/erofs/data.c     | 8 ++++++--
 fs/erofs/internal.h | 1 +
 fs/erofs/super.c    | 5 ++++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index e16545849ea7..818f78ce648c 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -197,7 +197,6 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 	struct erofs_device_info *dif;
 	int id;
 
-	/* primary device by default */
 	map->m_bdev = sb->s_bdev;
 	map->m_daxdev = EROFS_SB(sb)->dax_dev;
 	map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
@@ -210,12 +209,17 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			up_read(&devs->rwsem);
 			return -ENODEV;
 		}
+		if (devs->flatdev) {
+			map->m_pa += blknr_to_addr(dif->mapped_blkaddr);
+			up_read(&devs->rwsem);
+			return 0;
+		}
 		map->m_bdev = dif->bdev;
 		map->m_daxdev = dif->dax_dev;
 		map->m_dax_part_off = dif->dax_part_off;
 		map->m_fscache = dif->fscache;
 		up_read(&devs->rwsem);
-	} else if (devs->extra_devices) {
+	} else if (devs->extra_devices && !devs->flatdev) {
 		down_read(&devs->rwsem);
 		idr_for_each_entry(&devs->tree, dif, id) {
 			erofs_off_t startoff, length;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 3f3561d37d1b..4fee380a98d9 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -81,6 +81,7 @@ struct erofs_dev_context {
 	struct rw_semaphore rwsem;
 
 	unsigned int extra_devices;
+	bool flatdev;
 };
 
 struct erofs_fs_context {
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 19b1ae79cec4..0afdfce372b3 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -248,7 +248,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 		if (IS_ERR(fscache))
 			return PTR_ERR(fscache);
 		dif->fscache = fscache;
-	} else {
+	} else if (!sbi->devs->flatdev) {
 		bdev = blkdev_get_by_path(dif->path, FMODE_READ | FMODE_EXCL,
 					  sb->s_type);
 		if (IS_ERR(bdev))
@@ -290,6 +290,9 @@ static int erofs_scan_devices(struct super_block *sb,
 	if (!ondisk_extradevs)
 		return 0;
 
+	if (!sbi->devs->extra_devices && !erofs_is_fscache_mode(sb))
+		sbi->devs->flatdev = true;
+
 	sbi->device_id_mask = roundup_pow_of_two(ondisk_extradevs + 1) - 1;
 	pos = le16_to_cpu(dsb->devt_slotoff) * EROFS_DEVT_SLOT_SIZE;
 	down_read(&sbi->devs->rwsem);
-- 
2.20.1

