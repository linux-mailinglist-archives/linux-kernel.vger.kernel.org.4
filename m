Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D18762DDB2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240255AbiKQONq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240317AbiKQONl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:13:41 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0408F63E5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:13:36 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 6so2066633pgm.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X5edKik6Yy70E8i5dbszPvRkPfUcmxGnVozSbtL7NQA=;
        b=aNN72l2bRasM321JMm9ZKQ0575K/e/Dkc+0KUYJ4tBAGfORjLPuuPodacs4Z9V0VKU
         ELIyzoaIY3udDDmoLRZYc/QcVaiUAqY+1Hio+60D9L2SZN+rGkd0cD8DimwzXFNuFOFB
         bGLJ0R8Zf/E/odUK3oHbkmJpoy1IA67+V0kNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5edKik6Yy70E8i5dbszPvRkPfUcmxGnVozSbtL7NQA=;
        b=e8UpcE+qCbOU3hzBK0Nw30B8VFxTWBVi9iQ+eQg+HrrbJkVXmL/PxjgJrG1Ommfdl0
         thLP08hlR/RclFkrQ+vWUGbUa7JYU1hh0wZ3eAkZPFiVwWD/5fXsTOaqAxQEWPChdeaR
         O3Mk4S7UympZPhXioO0+tLYQn/86OKqQfSWt0kisAV603Z9m7SRbopcp4M0vjKTTgQwS
         mLe4Aluruv+H5Ru7nHQ4Q3jjGglOvJ4g6abS9UnDpaOV9rC7i7UPSju4dJwpp/VbY/mT
         h5N2nUAei/MsHf0KniJR8pT+SMNkM87qbFxQHUchEVPgyxwRvN+UM+3b2nQruUXgghnw
         5u0Q==
X-Gm-Message-State: ANoB5pkgOlPFIaUrlrNawRLPnsfnpfyTAuFcE/g3tVNQX7Mq2D2MywCt
        KfzTq7Ur9sySEJKZW+DpenvsEFQEHIk2mg==
X-Google-Smtp-Source: AA0mqf72fVfRgHzUCMhe32Qxs9QuRwXrtajxHZ1bgfU5Ypu+FT9FL/z5+03VRU2MMpaAxIRgy/SJmQ==
X-Received: by 2002:a05:6a00:1993:b0:56c:3fbb:7eb1 with SMTP id d19-20020a056a00199300b0056c3fbb7eb1mr3261692pfl.7.1668694415440;
        Thu, 17 Nov 2022 06:13:35 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:3925:36ee:c53c:7a49])
        by smtp.gmail.com with ESMTPSA id t18-20020a170902e1d200b001888a46e2d0sm1365037pla.162.2022.11.17.06.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 06:13:35 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zram: remove unused stats fields
Date:   Thu, 17 Nov 2022 23:13:26 +0900
Message-Id: <20221117141326.1105181-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't show num_reads and num_writes since we removed
corresponding sysfs nodes in 2017. Block layer stats are
exposed via /sys/block/zramX/stat file.

However, we still increment those atomic vars and store
them in zram stats. Remove leftovers.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 2 --
 drivers/block/zram/zram_drv.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 4e493c198d84..eea06b1a556f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2033,11 +2033,9 @@ static int zram_bvec_rw(struct zram *zram, struct bio_vec *bvec, u32 index,
 	int ret;
 
 	if (!op_is_write(op)) {
-		atomic64_inc(&zram->stats.num_reads);
 		ret = zram_bvec_read(zram, bvec, index, offset, bio);
 		flush_dcache_page(bvec->bv_page);
 	} else {
-		atomic64_inc(&zram->stats.num_writes);
 		ret = zram_bvec_write(zram, bvec, index, offset, bio);
 	}
 
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index c322d9c9dde2..4b46fcc651b1 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -76,8 +76,6 @@ struct zram_table_entry {
 
 struct zram_stats {
 	atomic64_t compr_data_size;	/* compressed size of pages stored */
-	atomic64_t num_reads;	/* failed + successful */
-	atomic64_t num_writes;	/* --do-- */
 	atomic64_t failed_reads;	/* can happen when memory is too low */
 	atomic64_t failed_writes;	/* can happen when memory is too low */
 	atomic64_t invalid_io;	/* non-page-aligned I/O requests */
-- 
2.38.1.431.g37b22c650d-goog

