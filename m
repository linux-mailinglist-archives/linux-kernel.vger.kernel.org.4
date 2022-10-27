Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A866060EEFF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 06:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbiJ0E1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 00:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbiJ0E1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 00:27:06 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190BA13C1E2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 21:27:05 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so342148pjl.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 21:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHzCyKbWb+aU+sZGmdZ8m8JVMN9OaN+P/JFQjaIcOqo=;
        b=aSq+upzUZDdmC75naLxSlP8YpIcWBfuiUS998Gz2iB6tqN4yzH7e5GMJvSc97pighw
         2VTDsvilUhxegpUo5ItOSWNQxe90NnQg8p8L2B4P00g7f3R7tGeHEqtGVJNNWBRveOLP
         GcBCvqAX/L8G3fn/4j3Jkaf7d3yUXYdkv3s7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHzCyKbWb+aU+sZGmdZ8m8JVMN9OaN+P/JFQjaIcOqo=;
        b=ItxeenpebdU0EKySiBcqlNQjNTHF3GySNLwGuP4H9hIua9YidDj6pGKitwcbqa4iFQ
         rJz2NtEbwRZPn0wvbrB/dlfktocTf2mu4ZVT+sA/x4+uIlFIE3W1K316ynvDz5tx8VMD
         T1HqQVz8ywmu3Ag/KNfWzNtfDD/hCk2XSjyOpb0pMXUknOh5DWIqVynWmhh3LmsR36xi
         I+PeVNlScoR0QannMo1b1fTz+V+hhdqOXw4eve1S5hYUthF/S4pIwvFpLQvWp9qiIwe/
         yhbWxYSMUllCU0ILOLqq/2qo1X8PKPHFjKmo7yHjechwwrLUchv/oYQUHd5f9/Ngqedv
         4+LQ==
X-Gm-Message-State: ACrzQf2+NCZNxUsQsW52lkTQXmWMfUbhnKjeDg/eCGeh8guJK7Tub5V/
        T55xtzI+18vDaDBpfgZuybCeYQ==
X-Google-Smtp-Source: AMsMyM797j3sc8YkFDNvzD0Xr0D9iMhxgxZ66M0yX/pGyuoc9PJt02IDJYOIeyuvGuiXXR2j0GAi2g==
X-Received: by 2002:a17:90b:3ec6:b0:20a:eb6b:c832 with SMTP id rm6-20020a17090b3ec600b0020aeb6bc832mr7917557pjb.22.1666844824643;
        Wed, 26 Oct 2022 21:27:04 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:30f2:4501:65fa:df12])
        by smtp.gmail.com with ESMTPSA id w23-20020aa79557000000b00565c8634e55sm203140pfq.135.2022.10.26.21.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 21:27:04 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 3/9] zsmalloc: move away from page order defines
Date:   Thu, 27 Oct 2022 13:26:45 +0900
Message-Id: <20221027042651.234524-4-senozhatsky@chromium.org>
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

