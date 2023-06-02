Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D07A7204CF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbjFBOrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbjFBOrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:47:09 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1132134
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 07:47:07 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-75b064451d3so205880785a.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 07:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685717227; x=1688309227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FP4gFagKNPHKRp8BSra7FGUts20+QHmvD8L/6jKh1SA=;
        b=MtQrKf3Aq4ywNNmwBn+4KQwmQeG2JkEtU+VwRFhq5xHnjIeHGlyeZJ6dZ8YNsSbXvZ
         j1CapqzyAiqC8lBwiWOA+xAyYTflGylKU2PBwSTTmvHJDFHXdYrdJDiLFu0OYxCVpoQ/
         R4kbl5OU33YR3ax1JbmLqg5f9S/KHZ5IPvGHaBNdE7koFo+9mfzNj6FOaN1LUhjbvJ7q
         QCkGB2Kg4xqOe0l03A1iI3Ox63oKOjG/fW2ygSexk+KfhpPgAZmQSyZFxHb/WrJN0EeO
         JqsvuSo6q4SEf+2jewXSIwmUbbtjcldQtPPsX89C37f29U/tTm3Wp1PhK/onirVoS+vK
         t8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685717227; x=1688309227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FP4gFagKNPHKRp8BSra7FGUts20+QHmvD8L/6jKh1SA=;
        b=UTWqHjJTWd3XCVtUxDrgURJ9pbtZTuNCWBcMobGWsfbAfc7pQmBUlvxXMk9qKbrlXg
         s5CGHo3+uXXAgOUgPnCinrpsIs2SQwRYXrvzwYZYCF+VbKKlrz+TtiYfC8BH0vWxz8Rt
         QepkRMcSLwuZmjBf2MXr/JHYtAbzzB0tg53Y6fTgx1ngefxriddFUo9qhcdJocT2QUK7
         uGu/Id8em2zMJiKYmbbnPUxC+GRUZNr/psUANh4vmrMKOeNpjT8FWvvd18Aai1JCa+z5
         p8OW7LzVFfy7Zl3AXJN6L1owCqjSB4pOG5Lbtt5h53ZrvKs/pT0dhvSM/BHRfALrTd1j
         YUxQ==
X-Gm-Message-State: AC+VfDyUcQLi8Pl8Psj+Pvg2gZ3peq+fkj8Kwi2GciFyUk9Wtknum2Se
        9sB9z+h9T+PVWZ9Kpm+/obxWhg==
X-Google-Smtp-Source: ACHHUZ71No0tnTDpHFcZMCUY7YwJgRdAZHnJ/RAWO+H6cioy23x5MVN+Xmamhs/C+Q84rOWgDPAJRQ==
X-Received: by 2002:a05:620a:215c:b0:75b:23a1:8342 with SMTP id m28-20020a05620a215c00b0075b23a18342mr12555228qkm.61.1685717227013;
        Fri, 02 Jun 2023 07:47:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ec58])
        by smtp.gmail.com with ESMTPSA id t17-20020a05620a035100b0075cdb0381ebsm703636qkm.67.2023.06.02.07.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:47:06 -0700 (PDT)
Date:   Fri, 2 Jun 2023 10:47:05 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/5] mm: compaction: simplify should_compact_retry()
Message-ID: <20230602144705.GB161817@cmpxchg.org>
References: <20230519123959.77335-1-hannes@cmpxchg.org>
 <20230519123959.77335-3-hannes@cmpxchg.org>
 <1c3c9305-a678-279e-f015-7aed544ab3c8@suse.cz>
 <20230529163805.GA84971@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529163805.GA84971@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 12:38:07PM -0400, Johannes Weiner wrote:
> On Mon, May 29, 2023 at 03:03:52PM +0200, Vlastimil Babka wrote:
> > I think you simplified this part too much, so now once it runs out of
> > retries, it will return false, while previously it would increase the priority.

Here is the delta fix. If this looks good to everybody, can you please
fold this into the patch you have in tree? Thanks!

---
From 4b9429f9ef04fcb7bb5ffae0db8ea113b26d097b Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Fri, 2 Jun 2023 16:02:37 +0200
Subject: [PATCH] mm: compaction: simplify should_compact_retry() fix

Vlastimil points out an unintended change. Previously when hitting
max_retries we'd bump the priority level and restart the loop. Now we
bail out and fail instead. Restore the original behavior.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 72660e924b95..e7d7db36582b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3768,6 +3768,15 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
 	if (fatal_signal_pending(current))
 		return false;
 
+	/*
+	 * Compaction was skipped due to a lack of free order-0
+	 * migration targets. Continue if reclaim can help.
+	 */
+	if (compact_result == COMPACT_SKIPPED) {
+		ret = compaction_zonelist_suitable(ac, order, alloc_flags);
+		goto out;
+	}
+
 	/*
 	 * Compaction managed to coalesce some page blocks, but the
 	 * allocation failed presumably due to a race. Retry some.
@@ -3785,17 +3794,10 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
 		if (order > PAGE_ALLOC_COSTLY_ORDER)
 			max_retries /= 4;
 
-		ret = ++(*compaction_retries) <= max_retries;
-		goto out;
-	}
-
-	/*
-	 * Compaction was skipped due to a lack of free order-0
-	 * migration targets. Continue if reclaim can help.
-	 */
-	if (compact_result == COMPACT_SKIPPED) {
-		ret = compaction_zonelist_suitable(ac, order, alloc_flags);
-		goto out;
+		if (++(*compaction_retries) <= max_retries) {
+			ret = true;
+			goto out;
+		}
 	}
 
 	/*
-- 
2.40.1

