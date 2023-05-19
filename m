Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4784270975B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjESMkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjESMkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:40:11 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB54A109
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 05:40:09 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-510eb3dbaaeso2962884a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 05:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1684500008; x=1687092008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLUm7WZINfPJ8EnyZppR+QB8ZeshYnpRD1lp9jOg8YM=;
        b=UqY0Q1QneRWgaChbAJgyXkbGCj5MIeuFO1Mmxqo9b0QVAxAtyzG0jFAVliXTITC41q
         oC79XjrJW9vlGUQVQJWPUcF9FCRAbWfWtVRthlUqELkW1+wmsNFisu0FKzt8Vuy7O/0r
         gyMNuX0yd/37Jh6HhJKs7jW2i8YAXmc5zUZTmN3Rlmuo6uaaRSkBGojlNeDxEigi5TXY
         wkeYQj8gFL6V8RbvUzItTEhn0gtfrZrDjFrQqIDzdEz+gAAc8yjZKn2/LyNCcfsdWYPq
         V/bJWcjzyGeL1UMuy0CC5C2DgDrohlE58IRXywwbSfuUET9z+ZmQWIUXgcTO6ixIOW9N
         daFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684500008; x=1687092008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLUm7WZINfPJ8EnyZppR+QB8ZeshYnpRD1lp9jOg8YM=;
        b=aV8D8/saKMmT1OrsMwOfkn1N9VPBCxPpvi14KVb6RcZM0yHZk2w8u/SyNejZA16tUH
         0cMqPph9kl7nVPO61/xNLAnB5SJDcFjikU/HGAoukuA1BKglSMxXMm/GtzOgG7c41fWr
         ORlmG0UDjfMT5BmlH1brNo2SkGmzob2xidoh4pKcp98iHP7Eike6X+irutdFbrEMaZ/d
         iFV1CI8hNFIFjvtes0H7L4G+W5CSWDzZbb2WAA19emSzmY3rSyJ9Znn4wUTYHIGDGB+2
         tcHdC5YT0aIXFcWOX4A6Q9IZyoQB0XUkZU1HHho5VdUgax6Z84j6PYV5SQ62cRtLc7i1
         0gGg==
X-Gm-Message-State: AC+VfDx9LQkfvOmtvjhcISNBLzAOJAkeTShj9mtmfTLsMI/H2+qx5qrV
        ReWDewAyf2sWCSHR3uWd1kfdVA==
X-Google-Smtp-Source: ACHHUZ7oj3yMtwF1chSvwKUqZhCd0vlmhEuYEkCw7mv9MYs7nSCkZ05x4A7DYg+PKersqbn5+LRfWg==
X-Received: by 2002:a17:907:2cc7:b0:965:fb87:4215 with SMTP id hg7-20020a1709072cc700b00965fb874215mr1552073ejc.15.1684500008176;
        Fri, 19 May 2023 05:40:08 -0700 (PDT)
Received: from localhost ([2a02:8070:6389:7d40:e266:3092:9afb:a7b1])
        by smtp.gmail.com with ESMTPSA id m23-20020a1709061ed700b0095337c5da35sm2295229ejj.15.2023.05.19.05.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 05:40:08 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/5] mm: compaction: remove compaction result helpers
Date:   Fri, 19 May 2023 14:39:55 +0200
Message-Id: <20230519123959.77335-2-hannes@cmpxchg.org>
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

The compaction result helpers encode quirks that are specific to the
allocator's retry logic. E.g. COMPACT_SUCCESS and COMPACT_COMPLETE
actually represent failures that should be retried upon, and so on. I
frequently found myself pulling up the helper implementation in order
to understand and work on the retry logic. They're not quite clean
abstractions; rather they split the retry logic into two locations.

Remove the helpers and inline the checks. Then comment on the result
interpretations directly where the decision making happens.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/compaction.h     | 92 ----------------------------------
 include/trace/events/mmflags.h |  4 +-
 mm/page_alloc.c                | 30 ++++++-----
 3 files changed, 19 insertions(+), 107 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index a6e512cfb670..1f0328a2ba48 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -95,78 +95,6 @@ extern enum compact_result compaction_suitable(struct zone *zone, int order,
 extern void compaction_defer_reset(struct zone *zone, int order,
 				bool alloc_success);
 
-/* Compaction has made some progress and retrying makes sense */
-static inline bool compaction_made_progress(enum compact_result result)
-{
-	/*
-	 * Even though this might sound confusing this in fact tells us
-	 * that the compaction successfully isolated and migrated some
-	 * pageblocks.
-	 */
-	if (result == COMPACT_SUCCESS)
-		return true;
-
-	return false;
-}
-
-/* Compaction has failed and it doesn't make much sense to keep retrying. */
-static inline bool compaction_failed(enum compact_result result)
-{
-	/* All zones were scanned completely and still not result. */
-	if (result == COMPACT_COMPLETE)
-		return true;
-
-	return false;
-}
-
-/* Compaction needs reclaim to be performed first, so it can continue. */
-static inline bool compaction_needs_reclaim(enum compact_result result)
-{
-	/*
-	 * Compaction backed off due to watermark checks for order-0
-	 * so the regular reclaim has to try harder and reclaim something.
-	 */
-	if (result == COMPACT_SKIPPED)
-		return true;
-
-	return false;
-}
-
-/*
- * Compaction has backed off for some reason after doing some work or none
- * at all. It might be throttling or lock contention. Retrying might be still
- * worthwhile, but with a higher priority if allowed.
- */
-static inline bool compaction_withdrawn(enum compact_result result)
-{
-	/*
-	 * If compaction is deferred for high-order allocations, it is
-	 * because sync compaction recently failed. If this is the case
-	 * and the caller requested a THP allocation, we do not want
-	 * to heavily disrupt the system, so we fail the allocation
-	 * instead of entering direct reclaim.
-	 */
-	if (result == COMPACT_DEFERRED)
-		return true;
-
-	/*
-	 * If compaction in async mode encounters contention or blocks higher
-	 * priority task we back off early rather than cause stalls.
-	 */
-	if (result == COMPACT_CONTENDED)
-		return true;
-
-	/*
-	 * Page scanners have met but we haven't scanned full zones so this
-	 * is a back off in fact.
-	 */
-	if (result == COMPACT_PARTIAL_SKIPPED)
-		return true;
-
-	return false;
-}
-
-
 bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 					int alloc_flags);
 
@@ -185,26 +113,6 @@ static inline enum compact_result compaction_suitable(struct zone *zone, int ord
 	return COMPACT_SKIPPED;
 }
 
-static inline bool compaction_made_progress(enum compact_result result)
-{
-	return false;
-}
-
-static inline bool compaction_failed(enum compact_result result)
-{
-	return false;
-}
-
-static inline bool compaction_needs_reclaim(enum compact_result result)
-{
-	return false;
-}
-
-static inline bool compaction_withdrawn(enum compact_result result)
-{
-	return true;
-}
-
 static inline void kcompactd_run(int nid)
 {
 }
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index b63e7c0fbbe5..1478b9dd05fa 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -223,8 +223,8 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
 #define compact_result_to_feedback(result)	\
 ({						\
 	enum compact_result __result = result;	\
-	(compaction_failed(__result)) ? COMPACTION_FAILED : \
-		(compaction_withdrawn(__result)) ? COMPACTION_WITHDRAWN : COMPACTION_PROGRESS; \
+	(__result == COMPACT_COMPLETE) ? COMPACTION_FAILED : \
+		(__result == COMPACT_SUCCESS) ? COMPACTION_PROGRESS : COMPACTION_WITHDRAWN; \
 })
 
 #define COMPACTION_FEEDBACK		\
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 47421bedc12b..5a84a0bebc37 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3768,35 +3768,39 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
 	if (fatal_signal_pending(current))
 		return false;
 
-	if (compaction_made_progress(compact_result))
+	/*
+	 * Compaction managed to coalesce some page blocks, but the
+	 * allocation failed presumably due to a race. Retry some.
+	 */
+	if (compact_result == COMPACT_SUCCESS)
 		(*compaction_retries)++;
 
 	/*
-	 * compaction considers all the zone as desperately out of memory
-	 * so it doesn't really make much sense to retry except when the
+	 * All zones were scanned completely and still no result. It
+	 * doesn't really make much sense to retry except when the
 	 * failure could be caused by insufficient priority
 	 */
-	if (compaction_failed(compact_result))
+	if (compact_result == COMPACT_COMPLETE)
 		goto check_priority;
 
 	/*
-	 * compaction was skipped because there are not enough order-0 pages
-	 * to work with, so we retry only if it looks like reclaim can help.
+	 * Compaction was skipped due to a lack of free order-0
+	 * migration targets. Continue if reclaim can help.
 	 */
-	if (compaction_needs_reclaim(compact_result)) {
+	if (compact_result == COMPACT_SKIPPED) {
 		ret = compaction_zonelist_suitable(ac, order, alloc_flags);
 		goto out;
 	}
 
 	/*
-	 * make sure the compaction wasn't deferred or didn't bail out early
-	 * due to locks contention before we declare that we should give up.
-	 * But the next retry should use a higher priority if allowed, so
-	 * we don't just keep bailing out endlessly.
+	 * If compaction backed due to being deferred, due to
+	 * contended locks in async mode, or due to scanners meeting
+	 * after a partial scan, retry with increased priority.
 	 */
-	if (compaction_withdrawn(compact_result)) {
+	if (compact_result == COMPACT_DEFERRED ||
+	    compact_result == COMPACT_CONTENDED ||
+	    compact_result == COMPACT_PARTIAL_SKIPPED)
 		goto check_priority;
-	}
 
 	/*
 	 * !costly requests are much more important than __GFP_RETRY_MAYFAIL
-- 
2.40.0

