Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A776E6CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjDRTOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbjDRTOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:14:03 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8CFBB8A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:35 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id gb12so27467599qtb.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845214; x=1684437214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvrO/1+4yglcd2Jvs04tq1hDUyEyh2m1Sh3LN7l5OG8=;
        b=YCxaymFjTOB/xEVxOKn/iRYET7rdfjWPu3AZDYJ5KtaGsEjeOO2z8QOjdpBzKiI+fh
         zq/KjeYnjCaxkKVGYNcD9mghxgZwPN5syoeQUj2HsktOmS7F69bhZq+UdMOlukwdy6mr
         zhoMS/Tx7lhyB4yQTexZo6hq18nMIH/j4LR8HxWWTAFstqWcBJC/+aaBnM/4R2GA77/e
         eaZxJoD9eYoQfHGUVsharCxWu8P9awFx8F/6/oFYKGnqiIiwRsnchL6XPeWp9ufx15vN
         it9IVwB25jyUUFrrcgBYhumIpZbTgM/FEDmcZyOcdKC+L06MuZYxfBEyLL+xGpVRPQMZ
         aekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845214; x=1684437214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvrO/1+4yglcd2Jvs04tq1hDUyEyh2m1Sh3LN7l5OG8=;
        b=UO3EGx4YHvhTZAmSwdCeeEiwWKGwh+jd2ZP6iuYxKnaJF7DZcCGIOfqWujqkZoifcf
         CW9bszHuGILq/d3kT0uPHM+HBZxKPT7yY8BGxa0JHlWMjIViERoTBgMUREJLbRxti7Jk
         PWZ7cf6ZAIl1gnFtvxsJLGRk0W2QuJ7vAL1+7ZnHiVAQQt9BBXOguVa8iT3pDSgqGpnY
         xjhDF8IPtq2U6JFP7Z5BeUFDAPbKfibo8he8jnBzGmJeG4OY4rwoc7fQ7D7rR0oJKJbL
         u9dAdDpwdcIJbfqwQQrC/dpgo9RKxkZZMLbIDJFZDJ6f9oJSY/tnV81oqFBm2BMPhZBM
         S3rQ==
X-Gm-Message-State: AAQBX9cJUUe77mI2MvHurnZ2HMH6H1J3sAogsV4X+HSYoXX1tnwusgki
        A3c5iTvrtYx4B3bge8111POKe7GXt7zAbcBLF8U=
X-Google-Smtp-Source: AKy350b8I9apZCXgd3Fc463SUtxO97BghAjCQl+N88Qns+QuGdCqUDlXOuuktIWM1UP9lMqTVC8ihw==
X-Received: by 2002:ac8:4e93:0:b0:3ef:3880:9db6 with SMTP id 19-20020ac84e93000000b003ef38809db6mr1674175qtp.6.1681845214206;
        Tue, 18 Apr 2023 12:13:34 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id f17-20020a05622a1a1100b003ef415f0184sm39541qtb.69.2023.04.18.12.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:33 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 13/26] mm: compaction: remove compaction result helpers
Date:   Tue, 18 Apr 2023 15:13:00 -0400
Message-Id: <20230418191313.268131-14-hannes@cmpxchg.org>
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

I found myself repeatedly looking up the implementation of these
helpers while working on the code, which suggests they are not a
helpful abstraction. Inline them.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/compaction.h     | 92 ----------------------------------
 include/trace/events/mmflags.h |  4 +-
 mm/page_alloc.c                | 30 ++++++-----
 3 files changed, 19 insertions(+), 107 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 06eeb2e25833..7635e220215a 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -103,78 +103,6 @@ extern enum compact_result compaction_suitable(struct zone *zone, int order,
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
 
@@ -193,26 +121,6 @@ static inline enum compact_result compaction_suitable(struct zone *zone, int ord
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
index 412b5a46374c..47bfeca4cf02 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -222,8 +222,8 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
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
index 5f2a0037bed1..c3b7dc479936 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4620,35 +4620,39 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
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
2.39.2

