Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6DA60DF90
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiJZLao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbiJZLa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:30:28 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD80B326DC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:30:20 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id pb15so13698736pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXAqqjDk6mAz2KU4pc8JUXu1b5D+3y6f+8lsfEOMErU=;
        b=mfSf8pCFQJ6HG+oVrglzfNEsFiRm6IBwVmjr6QDF19ZwVOdp+OymSnDyDHkDq4CyU2
         YP6CIIpTxjmt05dh9LZr+TJPmMS1e+zdccy2qcES0hkNMO0h27Ltk6PSb9L34EDqitgZ
         MS/sDaeSUqvJNQXPgdb8NLAlxORIG+41vriG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXAqqjDk6mAz2KU4pc8JUXu1b5D+3y6f+8lsfEOMErU=;
        b=SGqPDjZMh7XbH7ONOyTw3lwo0d897znwsiBfY8e8H7YIoIXn0yBblGnuuh1m1RpyTv
         8sTtQrImWeEE+Y7i/wdpj2+tZd4HtiLcYpXUA5Y831FiNXb5kSdRfEWOVwhyMi4y2iyw
         xur8eG9bvParlbSJWhn8jxBFS7hXnSBC2mMFfGLWgIOlNnUQldjX4wbq8BDfd9UIavBG
         uzsz9gc8t9nzWxFo/w4TW2zzOo/SsWSmt6YY8z/KwpzxVewEY7NZWyGU+Cie6ioeT/Ep
         hTrwjwBXPUc3n1B1bbGjKNq+0P2pCEmJKmLJFx3JoXwKIEWJZfqp7QZdSoBGD4NZhhmr
         vcqg==
X-Gm-Message-State: ACrzQf0SsBbDLqNiFhp/bu3oDJiKfdzq38f99y3S1yMtDCR8fUU0VKPL
        U1vlTriugbIxMUHG8/iTYYnLsA==
X-Google-Smtp-Source: AMsMyM5UbeAi24Gw3AydSIfj50cK8jTXEBcDGPH6Rbn9I/i+CUdqxadOzM4siEquUTc7gPP1/0zk8A==
X-Received: by 2002:a17:902:f60c:b0:17c:163f:c0a8 with SMTP id n12-20020a170902f60c00b0017c163fc0a8mr42230267plg.38.1666783820285;
        Wed, 26 Oct 2022 04:30:20 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:749c:f7f5:1a8e:d0be])
        by smtp.gmail.com with ESMTPSA id x127-20020a626385000000b005627868e27esm2814919pfb.127.2022.10.26.04.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 04:30:19 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 4/9] zsmalloc: make huge class watermark zs_pool member
Date:   Wed, 26 Oct 2022 20:29:28 +0900
Message-Id: <20221026112933.4122957-5-senozhatsky@chromium.org>
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

