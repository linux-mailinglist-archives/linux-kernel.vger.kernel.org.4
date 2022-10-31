Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B614612FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 06:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJaFln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 01:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiJaFlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 01:41:35 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6192BE2C
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:41:30 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso14920107pjg.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4A6bhxNpojaEfPLcsnRmMeXdGP9le8JW2bwOtY/TXkw=;
        b=mVTml/Dy4+8p9+6rmaolR4vBzjYW7UCec/5EMJ+idSZbvLmxXWLwMeDUDy8NMfmSjx
         qH5MGu1oQ1A7u43SxQHdT0a+55WaYPhC5BtaEix7UtY1PUPttIA1tLy0w29dES+LR692
         yWCf2+X19RD7iNSYK+TgQm6wZYQBsbJ2q97Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4A6bhxNpojaEfPLcsnRmMeXdGP9le8JW2bwOtY/TXkw=;
        b=tHSAu/5k66U4CfLIvwdEK5xl/9YG1m7tpA1qtbjoM815a2xdxl6fl3DmcFEqwhCwV1
         4iAwpP0kerBBwc7xFZbplpIm0nDrt+MKIqx5Xm1pSCMzKeUEYOgdc0Z2NiI6103cmJqU
         4zZgBO1xZPR+CUEjdbbgY1/tWHUEawAtjqoWhTwCm0twcN6GHSXdXqbtDWK3NvPMkWqO
         lAJ2z8cYTSgxSaN2MwpHSYNzbDpLvHEcLrWzJeKvlqzXppFK9MoE0tDvXgsHNHRxn7VJ
         p6kJ9kDch+eLkf3YsOuy5xQeA+197YSJAJqlYyVqWwXBaG9FBBlHrz2KBj3bX6K/DvV3
         tumg==
X-Gm-Message-State: ACrzQf0H5UZ0suseKWQddCdPsh1HOcNalY+a5BKtB9cst8O4JKAgfe7J
        Vpx4t+spQ9h+0bedDe9A8R6Zbw==
X-Google-Smtp-Source: AMsMyM5/Tqjv38wC3ib39unJG1knEpYCMVX+0dvSVs/aWk6fGK7Xl5OBbYQvU4RkIQhQKqzo4LbOTQ==
X-Received: by 2002:a17:90b:1e43:b0:213:1efe:9815 with SMTP id pi3-20020a17090b1e4300b002131efe9815mr13311203pjb.164.1667194890154;
        Sun, 30 Oct 2022 22:41:30 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:7616:afe0:ba6c:96f4])
        by smtp.gmail.com with ESMTPSA id w12-20020aa79a0c000000b0056befcd7958sm3573308pfj.84.2022.10.30.22.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 22:41:29 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 5/9] zram: huge size watermark cannot be global
Date:   Mon, 31 Oct 2022 14:41:04 +0900
Message-Id: <20221031054108.541190-6-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221031054108.541190-1-senozhatsky@chromium.org>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZRAM will pass pool specific limit on number of pages
per-zspages which will affect pool's characteristics.
Namely huge size class watermark value. Move huge_class_size
to struct zram, because this value now can be unique to the
pool (zram device).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 13 +++----------
 drivers/block/zram/zram_drv.h |  5 +++++
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fd31beb6491a..90b0c66bbd5b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -50,12 +50,6 @@ static const char *default_comp_algs[ZRAM_MAX_ZCOMPS] = {
 
 /* Module params (documentation at end) */
 static unsigned int num_devices = 1;
-/*
- * Pages that compress to sizes equals or greater than this are stored
- * uncompressed in memory.
- */
-static size_t huge_class_size;
-
 static const struct block_device_operations zram_devops;
 
 static void zram_free_page(struct zram *zram, size_t index);
@@ -1259,8 +1253,7 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 		return false;
 	}
 
-	if (!huge_class_size)
-		huge_class_size = zs_huge_class_size(zram->mem_pool);
+	zram->huge_class_size = zs_huge_class_size(zram->mem_pool);
 	return true;
 }
 
@@ -1488,7 +1481,7 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 		return ret;
 	}
 
-	if (comp_len >= huge_class_size)
+	if (comp_len >= zram->huge_class_size)
 		comp_len = PAGE_SIZE;
 	/*
 	 * handle allocation has 2 paths:
@@ -1665,7 +1658,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	 * in a way that will save us memory. Mark the object so that we
 	 * don't attempt to re-compress it again (RECOMP_SKIP).
 	 */
-	if (comp_len_next >= huge_class_size ||
+	if (comp_len_next >= zram->huge_class_size ||
 	    comp_len_next >= comp_len_prev ||
 	    class_index_next >= class_index_prev ||
 	    ret) {
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 09b9ceb5dfa3..9d6fcfdf7aa7 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -120,6 +120,11 @@ struct zram {
 	 */
 	u64 disksize;	/* bytes */
 	const char *comp_algs[ZRAM_MAX_ZCOMPS];
+	/*
+	 * Pages that compress to sizes equal or greater than this are stored
+	 * uncompressed in memory.
+	 */
+	size_t huge_class_size;
 	/*
 	 * zram is claimed so open request will be failed
 	 */
-- 
2.38.1.273.g43a17bfeac-goog

