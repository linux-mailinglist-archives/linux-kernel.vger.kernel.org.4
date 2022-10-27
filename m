Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94A560EF01
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 06:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbiJ0E11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 00:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbiJ0E1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 00:27:16 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2282140E5F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 21:27:09 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so5088118pjc.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 21:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+4diO4tSVOFVgnXFSt8zIWx9H1y7/ENZOnwMcOSb2Q=;
        b=cn9fO+L4ylQungziAbx0awEs0vb/rKJImh058JzWlfF+li8hh8QOCkIy7ev44qIVZl
         k59U8YOl63gc23DdX2UTbPMidbjb9WxTXcI/kNjWCc7ayygy6Erb5iJfC4lOgp4O1d0O
         /G3x/L16VlMAa5SzTaoytD/pyczoCa/jU8X3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+4diO4tSVOFVgnXFSt8zIWx9H1y7/ENZOnwMcOSb2Q=;
        b=Fi3K0M0GAxGrqWwpCX/HEV0E0cTpRQ1Xoo+e44qfOIqTowgg+LqlyWwYhe+sbiRvtj
         Q5bjbRZDRoK8SVCNZ4r2tqMUB3Wr1EFfuBENV6ESi/OmtOwCeOlObh4s8V9usxT6xGbu
         f9klD52ISJpXa5sJy59ddqehJjqZxp+3VPeF/fAHww4g3Z0WDLc93mSzpb4UpeQkuZK6
         v3vW/yy6YSdD0Yuq9kG4aQpXEem5Zbs2+vUqhJ9ixLiCFQRNkjHu3oZ7T8/w9WPJPlDO
         5JW7e4pzU+cQ5+LVR4TMSm5zeM7SoW+aHRoc5KfEpLVTCy1BDk5AdCEFRQcrZmFkn4Bw
         SKVA==
X-Gm-Message-State: ACrzQf2ss4YY0WT9VTBArd0IcRaojXAQnaObCQbl2/aknGpjlQVnZuIF
        QBMs2m0bhsz3ggUC/bytI+2H2Q==
X-Google-Smtp-Source: AMsMyM7v1jym/Cfi8DjTcdl/L23EwROOmnJ6NDSPAaf1P/bpFyCsr1yAR0pZjfjcTePtikPBXXdinQ==
X-Received: by 2002:a17:90b:3b4c:b0:213:f05:6a8 with SMTP id ot12-20020a17090b3b4c00b002130f0506a8mr7907854pjb.108.1666844829155;
        Wed, 26 Oct 2022 21:27:09 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:30f2:4501:65fa:df12])
        by smtp.gmail.com with ESMTPSA id w23-20020aa79557000000b00565c8634e55sm203140pfq.135.2022.10.26.21.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 21:27:08 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 5/9] zram: huge size watermark cannot be global
Date:   Thu, 27 Oct 2022 13:26:47 +0900
Message-Id: <20221027042651.234524-6-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221027042651.234524-1-senozhatsky@chromium.org>
References: <20221027042651.234524-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2.38.0.135.g90850a2211-goog

