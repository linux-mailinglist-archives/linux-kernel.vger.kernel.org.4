Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237D967B3A9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbjAYNpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbjAYNpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:45:18 -0500
Received: from outbound-smtp41.blacknight.com (outbound-smtp41.blacknight.com [46.22.139.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9F814239
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 05:45:09 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp41.blacknight.com (Postfix) with ESMTPS id 7E3781F90
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:45:08 +0000 (GMT)
Received: (qmail 21346 invoked from network); 25 Jan 2023 13:45:08 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 25 Jan 2023 13:45:07 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chuyi Zhou <zhouchuyi@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/4] mm, compaction: Check if a page has been captured before draining PCP pages
Date:   Wed, 25 Jan 2023 13:44:32 +0000
Message-Id: <20230125134434.18017-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230125134434.18017-1-mgorman@techsingularity.net>
References: <20230125134434.18017-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a page has been captured then draining is unnecssary so check first
for a captured page.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/compaction.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index c018b0e65720..28711a21a8a2 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2441,6 +2441,12 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 			}
 		}
 
+		/* Stop if a page has been captured */
+		if (capc && capc->page) {
+			ret = COMPACT_SUCCESS;
+			break;
+		}
+
 check_drain:
 		/*
 		 * Has the migration scanner moved away from the previous
@@ -2459,12 +2465,6 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 				last_migrated_pfn = 0;
 			}
 		}
-
-		/* Stop if a page has been captured */
-		if (capc && capc->page) {
-			ret = COMPACT_SUCCESS;
-			break;
-		}
 	}
 
 out:
-- 
2.35.3

