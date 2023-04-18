Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A106E6CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbjDRTPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbjDRTOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:14:04 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CF68A60
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:36 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id op30so18259176qvb.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845215; x=1684437215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l59ZyyVgyCUBMvUoPArfOg/Tu2nHrtxfgxoKhkDEsRQ=;
        b=fHLEDZEsV9N0D0X0rv9luI4kf2Ny4hu81LBmLjiQQISEpJJ+RqngAVpAPnFoR0YJg5
         +rnu1yHL/o1ivzsyaceccwRhzNhhqiyoYCKe93qsF3ayw2qwII6swNfekI6XGKLg0WKN
         ufiP8FtZHi0gw8HoJMh10Ahc4nfREGT88vUp2AeAYI8oivqhu8YfXmH0mXPBZwkUumtM
         cdyBUXt7wmT0HtYc+n8SW7cn8uD60GO8c+eVN2+jqkKgf8Z6KnRU8bZkIL2jEokwqAx5
         sPCj0+lVYfaoZN3UpGcQ5ZNRelLySP7T0KS9IIKSrs2ehaDuMkRxPwMV16n9lIi+UQCl
         Tevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845215; x=1684437215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l59ZyyVgyCUBMvUoPArfOg/Tu2nHrtxfgxoKhkDEsRQ=;
        b=beB6hRg24HWRMEAEKTQX7OIcUtV69Q05qNXP9B3mcC13LHk0eV/03q6bwYW7FXPmhz
         4c2UL3ZNJpP3Anbx8YR8mXgizetgeSO+C52W77ouSb+hF7puug7CMrjVLGbfKussik1d
         XFFlVnj6sJ1PIn3H0pRaTKFenWpR6JQ+3iOIm2DAcBvVp9HphfEMH2vx/uDDhIwVjVAN
         J/mBr8Uuab8x+XRsFgmqVzKHVF4+QLRz7w6j0OnhclweSG49i7gpUJhRiORCLhwZAthB
         UVVP+NU7EkadOBPZaObOe4Dm7fUcWsytkXWDg+QfiRNqrTNymaI4v03EAAQAXTNLx+WE
         N/Mw==
X-Gm-Message-State: AAQBX9dobuq8Y90mFHFi/M7Gyd/1AeXxSkegUql3/JCme/bWD6avVCd0
        obWJgZi3Ihyyc9waigKxdPg8tw==
X-Google-Smtp-Source: AKy350Y+h1X4MZEW+S29kRDU7ycQ7OqCtKgHBzDa7byusJ+iYdu4NQRhrwkjbrpSqc3/yAnVuA2tCQ==
X-Received: by 2002:a05:6214:1942:b0:5f1:6904:a2d6 with SMTP id q2-20020a056214194200b005f16904a2d6mr1035437qvk.51.1681845215347;
        Tue, 18 Apr 2023 12:13:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id k15-20020a05620a414f00b007463509f94asm4089576qko.55.2023.04.18.12.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:35 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 14/26] mm: compaction: simplify should_compact_retry()
Date:   Tue, 18 Apr 2023 15:13:01 -0400
Message-Id: <20230418191313.268131-15-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230418191313.268131-1-hannes@cmpxchg.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The different branches for retry are unnecessarily complicated. There
is really only three outcomes: progress, skipped, failed. Also, the
retry counter only applies to loops that made progress, move it there.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 60 +++++++++++++++++--------------------------------
 1 file changed, 20 insertions(+), 40 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c3b7dc479936..18fa2bbba44b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4608,7 +4608,6 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
 		     enum compact_priority *compact_priority,
 		     int *compaction_retries)
 {
-	int max_retries = MAX_COMPACT_RETRIES;
 	int min_priority;
 	bool ret = false;
 	int retries = *compaction_retries;
@@ -4621,19 +4620,27 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
 		return false;
 
 	/*
-	 * Compaction managed to coalesce some page blocks, but the
-	 * allocation failed presumably due to a race. Retry some.
+	 * Compaction coalesced some page blocks, but the allocation
+	 * failed, presumably due to a race. Retry a few times.
 	 */
-	if (compact_result == COMPACT_SUCCESS)
-		(*compaction_retries)++;
+	if (compact_result == COMPACT_SUCCESS) {
+		int max_retries = MAX_COMPACT_RETRIES;
 
-	/*
-	 * All zones were scanned completely and still no result. It
-	 * doesn't really make much sense to retry except when the
-	 * failure could be caused by insufficient priority
-	 */
-	if (compact_result == COMPACT_COMPLETE)
-		goto check_priority;
+		/*
+		 * !costly requests are much more important than
+		 * __GFP_RETRY_MAYFAIL costly ones because they are de
+		 * facto nofail and invoke OOM killer to move on while
+		 * costly can fail and users are ready to cope with
+		 * that. 1/4 retries is rather arbitrary but we would
+		 * need much more detailed feedback from compaction to
+		 * make a better decision.
+		 */
+		if (order > PAGE_ALLOC_COSTLY_ORDER)
+			max_retries /= 4;
+
+		ret = ++(*compaction_retries) <= MAX_COMPACT_RETRIES;
+		goto out;
+	}
 
 	/*
 	 * Compaction was skipped due to a lack of free order-0
@@ -4645,35 +4652,8 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
 	}
 
 	/*
-	 * If compaction backed due to being deferred, due to
-	 * contended locks in async mode, or due to scanners meeting
-	 * after a partial scan, retry with increased priority.
-	 */
-	if (compact_result == COMPACT_DEFERRED ||
-	    compact_result == COMPACT_CONTENDED ||
-	    compact_result == COMPACT_PARTIAL_SKIPPED)
-		goto check_priority;
-
-	/*
-	 * !costly requests are much more important than __GFP_RETRY_MAYFAIL
-	 * costly ones because they are de facto nofail and invoke OOM
-	 * killer to move on while costly can fail and users are ready
-	 * to cope with that. 1/4 retries is rather arbitrary but we
-	 * would need much more detailed feedback from compaction to
-	 * make a better decision.
-	 */
-	if (order > PAGE_ALLOC_COSTLY_ORDER)
-		max_retries /= 4;
-	if (*compaction_retries <= max_retries) {
-		ret = true;
-		goto out;
-	}
-
-	/*
-	 * Make sure there are attempts at the highest priority if we exhausted
-	 * all retries or failed at the lower priorities.
+	 * Compaction failed. Retry with increasing priority.
 	 */
-check_priority:
 	min_priority = (order > PAGE_ALLOC_COSTLY_ORDER) ?
 			MIN_COMPACT_COSTLY_PRIORITY : MIN_COMPACT_PRIORITY;
 
-- 
2.39.2

