Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9595860EF00
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 06:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbiJ0E1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 00:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbiJ0E1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 00:27:14 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3657713C1D7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 21:27:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so342208pjl.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 21:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXAqqjDk6mAz2KU4pc8JUXu1b5D+3y6f+8lsfEOMErU=;
        b=WngvKc8vcBYMk1kZ5arHHYitYLIPzMf9lvgsPMzCnmgpIOkw/9/8hqJ7boohJPjK84
         1/GpQJvSc9hWAZAbj89XueIUHcvodWbahm+jty7rdLIhluMQy7c2Agh3CZZ8EztEsHT5
         xkqhhdRhVa3ztF3+mmlNK9my9cEQZaqSq6j54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXAqqjDk6mAz2KU4pc8JUXu1b5D+3y6f+8lsfEOMErU=;
        b=cBZh5Az70za53V893hJIEZXHO0W9C8oHBLOdgKF5AquJ56jurOGoxbY5hdRsYviMdE
         6YxLBeeVDnR3mOoeLPYwIHwFnJuGT0Hm8/CjsYaJovHZpiFdeuUQ9uYwkwq94L6Ox9Bj
         3qQMErI3ovidTjWyMA+G4aO2S0XcF7c83SmkTGFTLffQKzRMkZIx540IdxJw3h0STe2r
         XHJoqinVbSu5L79dZbRo3KQew4g0XOS2MhRpID2B3VQhs5GYvyGOdJfYCh7AqE/hZi1a
         wNoSGVGF0krdBzMYauyY3I2VbsN5JIfidbIvCUlok/46Gy9H3PYshbe7qpk5stj2PQ5C
         Q8AA==
X-Gm-Message-State: ACrzQf3auyyZTZnLpATr9B1JwOk2MIJFN64VNDsfMWQJmWZzGAsXIhCx
        +6PwkKAeu+bREGwG9LvpxZzL1Q==
X-Google-Smtp-Source: AMsMyM7PNp0OP2QcmW90+E2XrzDzR0wbvfLWMoR4FKeUYoOPqf84Z//D7HEkMOLtbVS2Ygqpvg0hAA==
X-Received: by 2002:a17:90b:1b0b:b0:20d:7c31:e75d with SMTP id nu11-20020a17090b1b0b00b0020d7c31e75dmr7711106pjb.101.1666844826902;
        Wed, 26 Oct 2022 21:27:06 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:30f2:4501:65fa:df12])
        by smtp.gmail.com with ESMTPSA id w23-20020aa79557000000b00565c8634e55sm203140pfq.135.2022.10.26.21.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 21:27:06 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 4/9] zsmalloc: make huge class watermark zs_pool member
Date:   Thu, 27 Oct 2022 13:26:46 +0900
Message-Id: <20221027042651.234524-5-senozhatsky@chromium.org>
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

We will permit per-pool configuration of pages per-zspage value,
which changes characteristics of the classes and moves around
huge class size watermark. Thus huge class size needs to be
a per-pool variable.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index d4f68fba746b..cab8080e2fc6 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -178,7 +178,6 @@ static struct dentry *zs_stat_root;
  * (see: fix_fullness_group())
  */
 static const int fullness_threshold_frac = 4;
-static size_t huge_class_size;
 
 struct size_class {
 	spinlock_t lock;
@@ -227,6 +226,7 @@ struct zs_pool {
 
 	u32 num_size_classes;
 	u32 min_alloc_size;
+	size_t huge_class_size;
 
 	struct zs_pool_stats stats;
 
@@ -1350,7 +1350,7 @@ EXPORT_SYMBOL_GPL(zs_unmap_object);
  */
 size_t zs_huge_class_size(struct zs_pool *pool)
 {
-	return huge_class_size;
+	return pool->huge_class_size;
 }
 EXPORT_SYMBOL_GPL(zs_huge_class_size);
 
@@ -2264,8 +2264,8 @@ struct zs_pool *zs_create_pool(const char *name)
 		 * endup in the huge class.
 		 */
 		if (pages_per_zspage != 1 && objs_per_zspage != 1 &&
-				!huge_class_size) {
-			huge_class_size = size;
+				!pool->huge_class_size) {
+			pool->huge_class_size = size;
 			/*
 			 * The object uses ZS_HANDLE_SIZE bytes to store the
 			 * handle. We need to subtract it, because zs_malloc()
@@ -2275,7 +2275,7 @@ struct zs_pool *zs_create_pool(const char *name)
 			 * class because it grows by ZS_HANDLE_SIZE extra bytes
 			 * right before class lookup.
 			 */
-			huge_class_size -= (ZS_HANDLE_SIZE - 1);
+			pool->huge_class_size -= (ZS_HANDLE_SIZE - 1);
 		}
 
 		/*
-- 
2.38.0.135.g90850a2211-goog

