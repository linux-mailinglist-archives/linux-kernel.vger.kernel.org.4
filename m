Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C041E70975E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjESMkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjESMkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:40:12 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A94102
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 05:40:10 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96aadfb19d7so609384466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 05:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1684500009; x=1687092009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcIbsIikfDMuopSmhbHndV34wIxjpvvu7t5RPKLo+Ds=;
        b=sb6jjHiPTREDcXdqa2JjB543aE4BffIZF/xpQ81XMOPbM5HDi7RIw/E2nSt+nx319g
         gPJgXd5jWMC7y6+vkLqrHE+0zbFS3gbHUeppbPpBCiBAohfGYKUfPFayPpzAob9UXhxE
         QEegswrzo+Jdcji9zBexb7zusPe6L0fKPR2rbjXa/EhMVS7NUITvoive3AA6Xwbeno+A
         CwED3HrTiR3swlcHMBb0od8FoLayohcwFMLmKVO2c2Y2qhgfs87pyMfAMwlsVGKgzU0o
         AYN8sqSYl+atdFoHRcFi2lu+/nsFdkF/r6TrTSzeUZT2EACdDjtMk4pC+XdWoe8U+5xo
         fkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684500009; x=1687092009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcIbsIikfDMuopSmhbHndV34wIxjpvvu7t5RPKLo+Ds=;
        b=Rvup7eSVESUeeeXTPL/mbT3ijKTm66o04ititcczos2YrhCLJec+DGA0nIEHKbmrIR
         Vr6Nt4uduNU0UmRbrAQgTEXx+YQheHacOtCOFcd/tuDMxpViotICTAw7/pTV4wxYmfYb
         Wro96y21MfR1+f0xScDBermbSBWpquc/4Pgoy++YM4+xzRvg+8HsU6GAuE28huqJv1sD
         Dt6KEV518TMTbCzChG/cQCwYPmpQN0TTH6aFP/wb/rs7btHynab+doVLjcdSX3bw39aj
         UjU2p35Dj5CBkiX1PcMPIO6htt/mYk6cZ6/XREaqYGk5zv9rfEW4p90hiKp6Y75pDwOf
         c83w==
X-Gm-Message-State: AC+VfDzWO0/TlGc11WuMBBkUZX4J3PT1q9ocNMP6+2uDIqiULbKgZvv5
        5G/3Wgl191X3+rOjrAnRlzml8g==
X-Google-Smtp-Source: ACHHUZ42BThcRQN7iBlCrc1jrTpTmxdOBr2VDl2uvIRk1Qsm8fZ7lS6NcIBzfFWtNzJJ8hIX2xrwWg==
X-Received: by 2002:a17:907:1c0e:b0:969:dda1:3896 with SMTP id nc14-20020a1709071c0e00b00969dda13896mr2224646ejc.0.1684500009025;
        Fri, 19 May 2023 05:40:09 -0700 (PDT)
Received: from localhost ([2a02:8070:6389:7d40:e266:3092:9afb:a7b1])
        by smtp.gmail.com with ESMTPSA id l18-20020a170906a41200b00965a52d2bf6sm2253368ejz.88.2023.05.19.05.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 05:40:08 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/5] mm: compaction: simplify should_compact_retry()
Date:   Fri, 19 May 2023 14:39:56 +0200
Message-Id: <20230519123959.77335-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230519123959.77335-1-hannes@cmpxchg.org>
References: <20230519123959.77335-1-hannes@cmpxchg.org>
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
are really only three outcomes: progress (retry n times), skipped
(retry if reclaim can help), failed (retry with higher priority).

Rearrange the branches and the retry counter to make it simpler.

v2:
- fix trace point build (Mel)
- fix max_retries logic for costly allocs (Huang)

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 53 +++++++++++++++----------------------------------
 1 file changed, 16 insertions(+), 37 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5a84a0bebc37..72660e924b95 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3772,16 +3772,22 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
 	 * Compaction managed to coalesce some page blocks, but the
 	 * allocation failed presumably due to a race. Retry some.
 	 */
-	if (compact_result == COMPACT_SUCCESS)
-		(*compaction_retries)++;
+	if (compact_result == COMPACT_SUCCESS) {
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
 
-	/*
-	 * All zones were scanned completely and still no result. It
-	 * doesn't really make much sense to retry except when the
-	 * failure could be caused by insufficient priority
-	 */
-	if (compact_result == COMPACT_COMPLETE)
-		goto check_priority;
+		ret = ++(*compaction_retries) <= max_retries;
+		goto out;
+	}
 
 	/*
 	 * Compaction was skipped due to a lack of free order-0
@@ -3793,35 +3799,8 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
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
2.40.0

