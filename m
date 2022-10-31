Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC59612FD1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 06:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiJaFld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 01:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiJaFl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 01:41:27 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89343BC14
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:41:25 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so14940773pjc.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q47a/PNtxAlJKL8yCX3+cfAOXZEGpDh+HXwifBH5lKc=;
        b=OYKyQePuyQDoHhgCchBV4FMDx0nWgF7FRbwlJg+5H3agLccnKM3iywpXD9Ad6WlB9e
         2hKoZcKk5G/boerau0bifRUyl66HD3wpSCWk/agkmOsrg0WbI+yuve3bQQODeG1tBhlr
         jW9CV4MIvC/C7cUB7KWXWdWNpbLLs4wlJYM+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q47a/PNtxAlJKL8yCX3+cfAOXZEGpDh+HXwifBH5lKc=;
        b=gUPEJf209kep/RKZT/gqNKHrI7nrQXYgMThJN6uYVpJYeF7B3LiT+lz0hE0RPewtU9
         jKGoZVm0Il/D6Wi0km5b/jCFzwa0ExyjYEb0jhqTXlGQ4AVBbecvXkKoIe1eZCoycZcy
         Q4SSiu+AvktRJNBlRFn2H08k9v+4wXxZc1UBZwnpVxNMV7+GE9r8ihVvARE6BL33D527
         pgz9n+zU/UP6T3asdgUt3zAjB8FnRWyRNOYGmnax7asxt0Gt+B91qVfk34l2Ck0x28t6
         vvsAgNF4li3uE8UdrvOPeT6JbbHBRJDTpgYIk3xH5beWvJ37baj+KpyTZ6orDGDrXtKE
         Stqw==
X-Gm-Message-State: ACrzQf2y0r3eyQ2xeZkghHJDEmrqm/nuHR0pkDliucmpE2f3txhisINo
        v178D6OrBzVoka2DspX5+lPhOw==
X-Google-Smtp-Source: AMsMyM7lIE25lBRCfac1jIjiko+Si6xCOBbIGSlmJaY3ParCu8pVW0pf03O7dc9ImI+Po6W9R2fxGg==
X-Received: by 2002:a17:903:4d7:b0:178:8564:f754 with SMTP id jm23-20020a17090304d700b001788564f754mr12779632plb.60.1667194885017;
        Sun, 30 Oct 2022 22:41:25 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:7616:afe0:ba6c:96f4])
        by smtp.gmail.com with ESMTPSA id w12-20020aa79a0c000000b0056befcd7958sm3573308pfj.84.2022.10.30.22.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 22:41:24 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 3/9] zsmalloc: move away from page order defines
Date:   Mon, 31 Oct 2022 14:41:02 +0900
Message-Id: <20221031054108.541190-4-senozhatsky@chromium.org>
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
index a9773566f85b..5f79223e7bfe 100644
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
 
-	num_pages = 1UL << ZS_DEFAULT_PAGE_ORDER;
+	num_pages = ZS_DEFAULT_PAGES_PER_ZSPAGE;
 	/* min_alloc_size must be multiple of ZS_ALIGN */
 	pool->min_alloc_size = num_pages << PAGE_SHIFT >> OBJ_INDEX_BITS;
 	pool->min_alloc_size = max(pool->min_alloc_size, ZS_MIN_ALLOC_SIZE);
-- 
2.38.1.273.g43a17bfeac-goog

