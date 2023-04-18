Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FCE6E6A59
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjDRQ7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjDRQ7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:59:48 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D53AB455
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:59:20 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a50cb65c92so26452355ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681837160; x=1684429160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6+Cu265ve+v/mYTevQG7B1gRVZEieX1Qo5P1wD9Qx14=;
        b=XKJ57OQqx/2PUHBsVuJiKQWKGxI0zf38e+uy5+3VzxmqWT5D9CoR9d/c3NX3CPvdvm
         tsgZ6wXl9/jMJbsaEYrw+C5mAR0OeNteAq7KXdnzEKsYopxMIY0VbeAXnjWrgKmmQLvy
         g2J7T3XZsbWjZKBQL8Hn4B+80abDhZ8JayM+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681837160; x=1684429160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+Cu265ve+v/mYTevQG7B1gRVZEieX1Qo5P1wD9Qx14=;
        b=erQASUG9Z4NpVDDWsUIrPKGBhZ4/7PwNoGvOBGrnBacTISWJH6rb8I64iZvEFg3t0y
         Hj/6z0oDjU/+So9aaZzCE/qbvVI1cQvTGf6Jr3c7rNqPWbP2YOXpho8nX/BNgeyTfPy/
         13p+6LTkWgjkm2QU9fWPflLvW+e89R8d7R4HtSJjepp4U3RP8DmzqC5nMZbW+pl/n2iD
         x0e4hz7+u6IrT8ln6YNSMoetbDhZ2KPTAdyHlLjkD0qcm6Hqg7l0rcPh4s98XGrxHJ+M
         ldi3GFst0LCb864zt90CrZuRvPh4Oj21LB6g8UxigW6hSDasTJEjnqhgqEuliQ91vyOr
         uGsg==
X-Gm-Message-State: AAQBX9dneL8St09t4w3/LEti1lbMozWmixPKEnenL6tzp6puwNo1tzTK
        GO9S8vVkGXfEGthGAfcEeIu3SA==
X-Google-Smtp-Source: AKy350ZOEbHETwSEaZ9aaPXnM/w14ni5nkHS+Z3blNn8sd9VN/rBzsneJLLLBdUDfsOIvzVqBV9T7A==
X-Received: by 2002:a17:903:280d:b0:1a5:31f2:9036 with SMTP id kp13-20020a170903280d00b001a531f29036mr2645410plb.11.1681837159865;
        Tue, 18 Apr 2023 09:59:19 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:15a7:1899:efc0:f521])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902bd4600b001a216d44440sm9829786plx.200.2023.04.18.09.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 09:59:19 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Yu Zhao <yuzhao@google.com>, Ying <ying.huang@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Douglas Anderson <dianders@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC PATCH] mm, compaction: kcompactd work shouldn't count towards memory PSI
Date:   Tue, 18 Apr 2023 09:58:54 -0700
Message-ID: <20230418095852.RFC.1.I53bf7f0c7d48fe7af13c5dd3ad581d3bcfd9d1bd@changeid>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the main kcompactd thread is doing compaction then it's always
proactive compaction. This is a little confusing because kcompactd has
two phases and one of them is called the "proactive" phase.
Specifically:
* Phase 1 (the "non-proactive" phase): we've been told by someone else
  that it would be a good idea to try to compact memory.
* Phase 2 (the "proactive" phase): we analyze memory fragmentation
  ourselves and compact if it looks fragmented.

From the context of kcompactd, the above naming makes sense. However,
from the context of the kernel as a whole both phases are "proactive"
because in both cases we're trying compact memory ahead of time and
we're not actually blocking (stalling) any task who is trying to use
memory.

Specifically, if any task is actually blocked needing memory to be
compacted then it will be in direct reclaim. That won't block waiting
on kcompactd task but instead call try_to_compact_pages() directly.
The caller of that direct compaction, __alloc_pages_direct_compact(),
already marks itself as counting towards PSI.

Sanity checking by looking at this from another perspective, we can
look at all the people who explicitly ask kcompactd to do a reclaim by
calling wakeup_kcompactd(). That leads us to 3 places in vmscan.c.
Those are all requests from kswapd, which is also a "proactive"
mechanism in the kernel (tasks aren't blocked waiting for it).

Fixes: eb414681d5a0 ("psi: pressure stall information for CPU, memory, and IO")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I stumbled upon this while researching for a different patch [1].
Although both the other patch and this one affect kcompactd, they are
otherwise unrelated. It can be noted that ${SUBJECT} patch was created
solely by code inspection. I don't have any specific test cases that
are made better by it, the code just didn't seem quite right to me.

My knowledge of the memory subsystem is shaky at best, so please take
this patch with a grain of salt. If you're a memory system expert and
this patch looks totally misguided to you then it probably is. ;-)

[1] https://lore.kernel.org/r/20230413182313.RFC.1.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid

 mm/compaction.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 5a9501e0ae01..5a8d78b506e4 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -22,7 +22,6 @@
 #include <linux/kthread.h>
 #include <linux/freezer.h>
 #include <linux/page_owner.h>
-#include <linux/psi.h>
 #include "internal.h"
 
 #ifdef CONFIG_COMPACTION
@@ -2954,8 +2953,6 @@ static int kcompactd(void *p)
 	pgdat->kcompactd_highest_zoneidx = pgdat->nr_zones - 1;
 
 	while (!kthread_should_stop()) {
-		unsigned long pflags;
-
 		/*
 		 * Avoid the unnecessary wakeup for proactive compaction
 		 * when it is disabled.
@@ -2967,9 +2964,8 @@ static int kcompactd(void *p)
 			kcompactd_work_requested(pgdat), timeout) &&
 			!pgdat->proactive_compact_trigger) {
 
-			psi_memstall_enter(&pflags);
 			kcompactd_do_work(pgdat);
-			psi_memstall_leave(&pflags);
+
 			/*
 			 * Reset the timeout value. The defer timeout from
 			 * proactive compaction is lost here but that is fine
-- 
2.40.0.634.g4ca3ef3211-goog

