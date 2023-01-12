Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB36B666B73
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 08:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbjALHPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 02:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjALHPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:15:33 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45C7165BC
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 23:15:32 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 7so12192302pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 23:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNSLlROnJSkgN15DCmptn3Khdtb1/dRVR5mfe/1h2ik=;
        b=Z8qfZubx+z0IoTKIQznPAOA8axWTCiUQjRph76J7wUSbIXNIslIKoy5wj2gLJeKTSi
         0hPiHkN8wya06J1BruCbHoIa7X4yOxvsavyQEN224atMg+hZT9HGV1DkqypbfIZOaYto
         68LxBOmug8+Ikm8iZTKVk0TsvlsdfAP6LggHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNSLlROnJSkgN15DCmptn3Khdtb1/dRVR5mfe/1h2ik=;
        b=cETfnPlV8zjXa0LJOZGYhJXixQbI7m8g7fRG5LpXxo3+27IKb3wZGbfL7bzUzuR9P0
         K8R9zTc7ZiqJwnmeIK78ZAyDoGjLAbc/CUF/fqZa9sSN0rFzFbcNpDwRVkz7O0eGB3uF
         JAx9tiE9O/QIe9lTxMSF9Z+T0iAzkErRgVJvc+8IwtBzHTRIA+Uj+4F0nWrwOahVxrhN
         VQc0axINYwH2GdItbwoaJKb5Ma2Mb84yLRaa2pRF5xzdRwcFsMkIlv30plE/fDfi5WOs
         vASBjHoPPv1aa/37gbFPz9HXZRsgTC/OhjEM5xTHHwsnW6PiqVR8ALsPUlvq9/Ps0rEC
         VFTA==
X-Gm-Message-State: AFqh2kr8pgUDh9Ak/IaLrQCrfJRrOjrH8EbjmyJ30cb8cB5WLIlM42Mw
        ikxbQAo48rdljPY/nXedWyzuIA==
X-Google-Smtp-Source: AMrXdXt4o1GyXaKZeMG0Y9nYlABViwtAaD563g9m6wYHD78QqRVryTGKnua/YhCQ+8vRhNHhT6FXqw==
X-Received: by 2002:aa7:9436:0:b0:589:78:80cd with SMTP id y22-20020aa79436000000b00589007880cdmr12972397pfo.8.1673507732355;
        Wed, 11 Jan 2023 23:15:32 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:59e5:ea10:b191:6fbd])
        by smtp.gmail.com with ESMTPSA id e26-20020aa7981a000000b00585cb0efebbsm600847pfl.175.2023.01.11.23.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 23:15:31 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] zsmalloc: turn chain size config option into UL constant
Date:   Thu, 12 Jan 2023 16:14:43 +0900
Message-Id: <20230112071443.1933880-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <Y7+ym2gT+XMuL/U5@google.com>
References: <Y7+ym2gT+XMuL/U5@google.com>
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

This fixes

>> mm/zsmalloc.c:122:59: warning: right shift count >= width of type [-Wshift-count-overflow]

and

>> mm/zsmalloc.c:224:28: error: variably modified 'size_class' at file scope
     224 |         struct size_class *size_class[ZS_SIZE_CLASSES];

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index febfe86d0b1b..290053e648b0 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -133,9 +133,12 @@
 #define MAGIC_VAL_BITS	8
 
 #define MAX(a, b) ((a) >= (b) ? (a) : (b))
+
+#define ZS_MAX_PAGES_PER_ZSPAGE	(_AC(CONFIG_ZSMALLOC_CHAIN_SIZE, UL))
+
 /* ZS_MIN_ALLOC_SIZE must be multiple of ZS_ALIGN */
 #define ZS_MIN_ALLOC_SIZE \
-	MAX(32, (CONFIG_ZSMALLOC_CHAIN_SIZE << PAGE_SHIFT >> OBJ_INDEX_BITS))
+	MAX(32, (ZS_MAX_PAGES_PER_ZSPAGE << PAGE_SHIFT >> OBJ_INDEX_BITS))
 /* each chunk includes extra space to keep handle */
 #define ZS_MAX_ALLOC_SIZE	PAGE_SIZE
 
@@ -1119,7 +1122,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 					gfp_t gfp)
 {
 	int i;
-	struct page *pages[CONFIG_ZSMALLOC_CHAIN_SIZE];
+	struct page *pages[ZS_MAX_PAGES_PER_ZSPAGE];
 	struct zspage *zspage = cache_alloc_zspage(pool, gfp);
 
 	if (!zspage)
@@ -1986,7 +1989,7 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 				struct page *newpage, struct page *oldpage)
 {
 	struct page *page;
-	struct page *pages[CONFIG_ZSMALLOC_CHAIN_SIZE] = {NULL, };
+	struct page *pages[ZS_MAX_PAGES_PER_ZSPAGE] = {NULL, };
 	int idx = 0;
 
 	page = get_first_page(zspage);
@@ -2366,7 +2369,7 @@ static int calculate_zspage_chain_size(int class_size)
 	if (is_power_of_2(class_size))
 		return chain_size;
 
-	for (i = 1; i <= CONFIG_ZSMALLOC_CHAIN_SIZE; i++) {
+	for (i = 1; i <= ZS_MAX_PAGES_PER_ZSPAGE; i++) {
 		int waste;
 
 		waste = (i * PAGE_SIZE) % class_size;
-- 
2.39.0.314.g84b9a713c41-goog

