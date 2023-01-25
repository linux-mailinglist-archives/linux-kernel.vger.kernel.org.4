Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D8F67B3AA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbjAYNpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbjAYNpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:45:21 -0500
Received: from outbound-smtp28.blacknight.com (outbound-smtp28.blacknight.com [81.17.249.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5292913503
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 05:45:20 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp28.blacknight.com (Postfix) with ESMTPS id CA76246026
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:45:18 +0000 (GMT)
Received: (qmail 21935 invoked from network); 25 Jan 2023 13:45:18 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 25 Jan 2023 13:45:18 -0000
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
Subject: [PATCH 3/4] mm, compaction: Finish scanning the current pageblock if requested
Date:   Wed, 25 Jan 2023 13:44:33 +0000
Message-Id: <20230125134434.18017-4-mgorman@techsingularity.net>
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

cc->finish_pageblock is set when the current pageblock should be
rescanned but fast_find_migrateblock can select an alternative
block. Disable fast_find_migrateblock when the current pageblock
scan should be completed.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/compaction.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index 28711a21a8a2..4b3a0238879c 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1762,6 +1762,13 @@ static unsigned long fast_find_migrateblock(struct compact_control *cc)
 	if (cc->ignore_skip_hint)
 		return pfn;
 
+	/*
+	 * If the pageblock should be finished then do not select a different
+	 * pageblock.
+	 */
+	if (cc->finish_pageblock)
+		return pfn;
+
 	/*
 	 * If the migrate_pfn is not at the start of a zone or the start
 	 * of a pageblock then assume this is a continuation of a previous
-- 
2.35.3

