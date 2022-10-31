Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2D0612ED6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 03:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJaCOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 22:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJaCOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 22:14:47 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00548388A
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 19:14:44 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id k22so9512022pfd.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 19:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cOg20qnEayV4nPlpIpR6eCWAzbrV4516eZcvT8U4UVo=;
        b=I0ejvWcRm2/9CvBT5pCdU+n+MF6tYrR3BL0b4SxQouGOu/vgyoIzYa3RBkhX5sK1cO
         jiJCgXfJRw2hG5F73KwGb84nmQXHvTOxaPY49NvCdOkw/eUWcycquTOnKQS8vWqU8XBO
         ad4lZVNVpVGZVZjlV2jiv4zBKpsqVUecOOaAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cOg20qnEayV4nPlpIpR6eCWAzbrV4516eZcvT8U4UVo=;
        b=GCa1YKhNLROV8moErMM0ZFQ9Lp5WB78nnQ6LSdIBbs2XbEUXsA9TvQaZv+j3BCTovK
         rUdU7FB8fz8uXOV7m8Q5De4CYvp8lQKThxQHgdWW9zg6fVIub6xdZQDLXLJpJvG28tct
         Phr7PJ0y0ysylDpMT7VDTGGKuvjWgmBI11s+SsG+Sr8RhR4jHzBrBXNvY3ovBKNLHeCH
         7fvfGzMz0DtZDUK2RuYwvECXS5CIhcBlWqj6pz7CDa2SU74Q7pzVFJSTuiqIPP74vRSd
         mzwrylsFPxp+Gh6fZR5OOORjndoQYcA3Q6S0A7HpQ+UNOZKmN/HOrUeq3lngLfF447bL
         bEXw==
X-Gm-Message-State: ACrzQf0bZPXXo9qn4N+JkP9PZtroP6bbVAQraN4AG3kPi5eOqGfkpZ6B
        pi2ssdF4SUw0cPhohNj60jXhfg==
X-Google-Smtp-Source: AMsMyM7rUVD16GhNPqBdMSFskAkp4rL4S76Ecx1KvcHTAMdeEQaCG9DMEi3RQObY3pgZWQmnsg++Lg==
X-Received: by 2002:a63:4517:0:b0:464:4f06:a0f1 with SMTP id s23-20020a634517000000b004644f06a0f1mr10187716pga.509.1667182484401;
        Sun, 30 Oct 2022 19:14:44 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:7616:afe0:ba6c:96f4])
        by smtp.gmail.com with ESMTPSA id g6-20020a625206000000b005633a06ad67sm3266699pfb.64.2022.10.30.19.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 19:14:44 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] zsmalloc: use temporary unsigned long for min_alloc_size calculations
Date:   Mon, 31 Oct 2022 11:14:38 +0900
Message-Id: <20221031021438.376636-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
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

kbuild reported the following warning:

mm/zsmalloc.c: In function 'zs_create_pool':
mm/zsmalloc.c:2220:69: warning: right shift count >= width of type [-Wshift-count-overflow]

Use unsigned long temp variable for calculations in zs_create_pool().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 0bc9ed1f1a5d..181bfc66249b 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -2211,6 +2211,7 @@ struct zs_pool *zs_create_pool(const char *name, u32 max_pages_per_zspage)
 	int i;
 	struct zs_pool *pool;
 	struct size_class *prev_class = NULL;
+	unsigned long num_pages = max_pages_per_zspage;
 
 	if (WARN_ON(max_pages_per_zspage < ZS_MIN_PAGES_PER_ZSPAGE ||
 		    max_pages_per_zspage > ZS_MAX_PAGES_PER_ZSPAGE))
@@ -2221,8 +2222,7 @@ struct zs_pool *zs_create_pool(const char *name, u32 max_pages_per_zspage)
 		return NULL;
 
 	/* min_alloc_size must be multiple of ZS_ALIGN */
-	pool->min_alloc_size = (max_pages_per_zspage << PAGE_SHIFT) >>
-		OBJ_INDEX_BITS;
+	pool->min_alloc_size = num_pages << PAGE_SHIFT >> OBJ_INDEX_BITS;
 	pool->min_alloc_size = max(pool->min_alloc_size, ZS_MIN_ALLOC_SIZE);
 
 	pool->num_size_classes =
-- 
2.38.1.273.g43a17bfeac-goog

