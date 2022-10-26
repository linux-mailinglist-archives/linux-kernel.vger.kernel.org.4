Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE2F60DF91
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbiJZLat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiJZLaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:30:30 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBFF2FC03
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:30:23 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h14so13706979pjv.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+4diO4tSVOFVgnXFSt8zIWx9H1y7/ENZOnwMcOSb2Q=;
        b=UhmWDT9HljW7EHf2zAiyG8JgQe7wk9UfSK5DQ4WKQj8lJCL54kE3BAxWAgbPKzQFIL
         HZoXAao6/7PEazMZaa7GuDGAO2fDdNUFp6cC9sO4EzNM2ElwowD4ogmxuSLKQGagkIyW
         fWWevm0IvTQ66rBTBe0CehdXd6v8W+5W3xvX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+4diO4tSVOFVgnXFSt8zIWx9H1y7/ENZOnwMcOSb2Q=;
        b=3XlO7Iw61o4sGA0McC6GCctvtu6C8407LNMLU3rlDVDyslCHBDyRtxaUWOO8+pFKdA
         ZPt8ldp/soGQUpOg0Nl90pxcFqFS1GeN2RpMO3zJAiz1YBeSOVJOG0T2HcFuTagykw6B
         ZYBgLAFPaEpSeb6DzAORIqt3N6IrP5HuV9RqQ0Luk5WxELGOe66SyfCqBMW744qAFrYy
         QbSYTNVP7uLz/M1WLQMKH3Ku8aWBfNeHiwuGiz+I3+LVYjH/6mlVKN1zwSeNhUkF+3mx
         RZHC1BYDenYXoxgnLXmx9jjxfUs40x89iXFr3kx57SJ4txF7GdPWd4OlI96G4g23ld/z
         B09g==
X-Gm-Message-State: ACrzQf3uHhfIoVqH1OJhi6FtaK46newe0YnjbCGLAosWs/yY4+9VGxV8
        QJvoNPdGqkKYF27O5sR1BtlHJg==
X-Google-Smtp-Source: AMsMyM4WtybC2TUGdBn1FJrVP/+bFGZM03VW492KsOHrY9HrIhGNwTkrWcVk1jbevrKEZMYsKmTP7g==
X-Received: by 2002:a17:902:e545:b0:184:2f27:b34 with SMTP id n5-20020a170902e54500b001842f270b34mr42927894plf.15.1666783822754;
        Wed, 26 Oct 2022 04:30:22 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:749c:f7f5:1a8e:d0be])
        by smtp.gmail.com with ESMTPSA id x127-20020a626385000000b005627868e27esm2814919pfb.127.2022.10.26.04.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 04:30:22 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 5/9] zram: huge size watermark cannot be global
Date:   Wed, 26 Oct 2022 20:29:29 +0900
Message-Id: <20221026112933.4122957-6-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221026112933.4122957-1-senozhatsky@chromium.org>
References: <20221026112933.4122957-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

