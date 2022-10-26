Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359CE60DF8E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbiJZLad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbiJZLaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:30:19 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F732F021
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:30:18 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e129so14463705pgc.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHzCyKbWb+aU+sZGmdZ8m8JVMN9OaN+P/JFQjaIcOqo=;
        b=CLe/xD6MM8eGCn9K4ey1Id/4Y+RMm1UdxlSXb3Af8TSUSccKm0tWe/dZMBkT5nF2IM
         A+QXB7pCZKWwzYs63P+o//k4SjonuoD+Fp7NpqTPITOrM+7tz5g8IEUOkFgA5jS1wFCh
         9VyRUexk961XMuPn8A2B9UzeZWIYfAFCwoFTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHzCyKbWb+aU+sZGmdZ8m8JVMN9OaN+P/JFQjaIcOqo=;
        b=DA3j9WtQh6Vcw8mugcviB59wcHQ4IKDLcsRHDCbBpvCUSGuljJH/tBisLJarWTYCQA
         mdzj20yo37B3Yz2A0pZH1LiTyco1Nncuik+9UtypLTapcaAp5wN2rvRz+W/Z/BY40M1H
         f6qxGpq+H4lPH4Lp5WBpzXGwOyvfCMCPCnvmmxRLQYEx9Vbid7QxtDkRM3cXCAA2BiHQ
         yUUPye746hzUzRwhcArImDZ7E6k5R/0HclgGVsg9uUVCVAyxacIFUMN+HmJ6+r/FhgoU
         S6gTfyGFWn+GU6u/IpGOB2aygWzKyOAzxboCYcyFVaFeRy46cs+fYXyLjQ9JnUewn69A
         hpgw==
X-Gm-Message-State: ACrzQf2OTjSH6gRWqJJOB3T+qtaTo6VcAE0NLSUcLV/sARUrQWSjDyeH
        B5yZCz7Pr6GD9Yw0AwxiNAiymQ==
X-Google-Smtp-Source: AMsMyM4BWeM8jHJpkgsFmswC5yJ7118tu3F2MKu7Jf8wLzddpHW/5TBtizge9YhVHpepNv2F+HCBiw==
X-Received: by 2002:a63:454d:0:b0:43c:e834:ec0 with SMTP id u13-20020a63454d000000b0043ce8340ec0mr38246206pgk.270.1666783817832;
        Wed, 26 Oct 2022 04:30:17 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:749c:f7f5:1a8e:d0be])
        by smtp.gmail.com with ESMTPSA id x127-20020a626385000000b005627868e27esm2814919pfb.127.2022.10.26.04.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 04:30:17 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 3/9] zsmalloc: move away from page order defines
Date:   Wed, 26 Oct 2022 20:29:27 +0900
Message-Id: <20221026112933.4122957-4-senozhatsky@chromium.org>
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

There is no reason for us to require pages per-zspage to be a
power of two. Rename macros and use plain limit numbers there
instead of 2 ^ N values. This will let us to have more tunable
limits.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/zsmalloc.h | 16 +++++++---------
 mm/zsmalloc.c            |  4 +---
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index 6cd1d95b928a..b6b8654a2d45 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -33,17 +33,15 @@ enum zs_mapmode {
 	 */
 };
 
-#define ZS_PAGE_ORDER_2		2
-#define ZS_PAGE_ORDER_4		4
-
 /*
- * A single 'zspage' is composed of up to 2^N discontiguous 0-order (single)
- * pages. ZS_MAX_PAGE_ORDER defines upper limit on N, ZS_MIN_PAGE_ORDER
- * defines lower limit on N. ZS_DEFAULT_PAGE_ORDER is recommended value.
+ * A single 'zspage' is composed of up to N discontiguous 0-order
+ * (single) pages. ZS_MAX_PAGES_PER_ZSPAGE defines upper limit on N,
+ * ZS_MIN_PAGES_PER_ZSPAGE defines lower limit on N.
+ * ZS_DEFAULT_PAGES_PER_ZSPAGE is a recommended value.
  */
-#define ZS_MIN_PAGE_ORDER	ZS_PAGE_ORDER_2
-#define ZS_MAX_PAGE_ORDER	ZS_PAGE_ORDER_4
-#define ZS_DEFAULT_PAGE_ORDER	ZS_PAGE_ORDER_2
+#define ZS_MIN_PAGES_PER_ZSPAGE	1
+#define ZS_MAX_PAGES_PER_ZSPAGE	16
+#define ZS_DEFAULT_PAGES_PER_ZSPAGE	4
 
 struct zs_pool_stats {
 	/* How many pages were migrated (freed) */
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index bc377e5d3417..d4f68fba746b 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -74,8 +74,6 @@
  */
 #define ZS_ALIGN		8
 
-#define ZS_MAX_PAGES_PER_ZSPAGE	(_AC(1, UL) << ZS_MAX_PAGE_ORDER)
-
 #define ZS_HANDLE_SIZE (sizeof(unsigned long))
 
 /*
@@ -2215,7 +2213,7 @@ struct zs_pool *zs_create_pool(const char *name)
 	if (!pool)
 		return NULL;
 
-	max_pages_per_zspage = 1U << ZS_DEFAULT_PAGE_ORDER;
+	max_pages_per_zspage = ZS_DEFAULT_PAGES_PER_ZSPAGE;
 	/* min_alloc_size must be multiple of ZS_ALIGN */
 	pool->min_alloc_size = (max_pages_per_zspage << PAGE_SHIFT) >>
 		OBJ_INDEX_BITS;
-- 
2.38.0.135.g90850a2211-goog

