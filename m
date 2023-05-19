Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDEA7095FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 13:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjESLOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 07:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjESLOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:14:03 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B59819F
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 04:14:01 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-510e90d785fso2446229a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 04:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1684494840; x=1687086840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4+L9HR/cxdd2EoQqIApS/F4mIL7RlSJb5MUrnsXMoGw=;
        b=yHVqeGy7uesoSL052/4GNJ7wDGNjsh5p/SyHiocWBSC4ig0qJmsUMSFxZjUXQpG4II
         sx7bvOG1WgdahaajQFDCdQNo5lq+Cl3GzPX3bimadgE1GtrCtvkllj7lvNHXlEf11+dO
         FjHor6izgaxO2yKOeW8DZoHHbUaNHgnlV7vka9hwVyN0OidXMy0dIA0MB+2FOrflG1dv
         JgictY+692VK0L9C38hnFv0IPYcg1Zov2Le+udVdTPa4+XcrJYI5cQBn1BxNoCKLO+cO
         GsUWwvGgM4XQXNA4uxQ0MvYUisPfsvHohd3QnI/xMwqqccJQwg0gmpTlarm9RCHajqz1
         rqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684494840; x=1687086840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+L9HR/cxdd2EoQqIApS/F4mIL7RlSJb5MUrnsXMoGw=;
        b=kaSTanGLquAGK6AmcX7EovY2mUKqWs1e0XqygEYp6tP0B0gVsQfvFF2Z4V/PhCxzQ+
         iXupJZquh+NiVyFxqOpc351a8Or+txj5Z6I/qpX246X192e0Tl74i4x+TwyjvY3AByh1
         eEwznpBEFg1acjIzQiY+7nNIGwCKqch/FBXm8302KecO65oymMKuGkX2RCG+rhX+OJGz
         EGcsVvc5lz9gp4NwDQ+ApQC6IC+iSH5BJykBOaVDdfPxxAU0/wSlOH4UT/vhkBYslWke
         XisETqkuvYAX06F4l8TWMNiNGavDhoFXm+ikN0zxh10VDLafZD8HshfUbM3NQgoW5seX
         NaPQ==
X-Gm-Message-State: AC+VfDyC8WYaV8Pg/S81gYfEQiVeVCbDB/uqQdM/eBDT6DznRHvODRXR
        VqjO+PJtycKRfbJ4qbfaO4FsHQ==
X-Google-Smtp-Source: ACHHUZ4FmEnNGPERWDF/ykElYe7/UICJF+x9kwyPXx762MMcpfOmOZUjIwoeNwbPHZr/+1tTVZw0hA==
X-Received: by 2002:aa7:ce02:0:b0:510:d197:e873 with SMTP id d2-20020aa7ce02000000b00510d197e873mr1298299edv.31.1684494839920;
        Fri, 19 May 2023 04:13:59 -0700 (PDT)
Received: from localhost ([2a02:8070:6389:7d40:e266:3092:9afb:a7b1])
        by smtp.gmail.com with ESMTPSA id x23-20020aa7dad7000000b005067d089aafsm1536743eds.11.2023.05.19.04.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 04:13:59 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] mm: compaction: avoid GFP_NOFS ABBA deadlock
Date:   Fri, 19 May 2023 13:13:59 +0200
Message-Id: <20230519111359.40475-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.40.0
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

During stress testing with higher-order allocations, a deadlock
scenario was observed in compaction: One GFP_NOFS allocation was
sleeping on mm/compaction.c::too_many_isolated(), while all CPUs in
the system were busy with compactors spinning on buffer locks held by
the sleeping GFP_NOFS allocation.

Reclaim is susceptible to this same deadlock; we fixed it by granting
GFP_NOFS allocations additional LRU isolation headroom, to ensure it
makes forward progress while holding fs locks that other reclaimers
might acquire. Do the same here.

This code has been like this since compaction was initially merged,
and I only managed to trigger this with out-of-tree patches that
dramatically increase the contexts that do GFP_NOFS compaction. While
the issue is real, it seems theoretical in nature given existing
allocation sites. Worth fixing now, but no Fixes tag or stable CC.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/compaction.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

v2:
- clarify too_many_isolated() comment (Mel)
- split isolation deadlock from no-contiguous-anon lockups as that's
  a different scenario and deserves its own patch

diff --git a/mm/compaction.c b/mm/compaction.c
index c8bcdea15f5f..c9a4b6dffcf2 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -745,8 +745,9 @@ isolate_freepages_range(struct compact_control *cc,
 }
 
 /* Similar to reclaim, but different enough that they don't share logic */
-static bool too_many_isolated(pg_data_t *pgdat)
+static bool too_many_isolated(struct compact_control *cc)
 {
+	pg_data_t *pgdat = cc->zone->zone_pgdat;
 	bool too_many;
 
 	unsigned long active, inactive, isolated;
@@ -758,6 +759,17 @@ static bool too_many_isolated(pg_data_t *pgdat)
 	isolated = node_page_state(pgdat, NR_ISOLATED_FILE) +
 			node_page_state(pgdat, NR_ISOLATED_ANON);
 
+	/*
+	 * Allow GFP_NOFS to isolate past the limit set for regular
+	 * compaction runs. This prevents an ABBA deadlock when other
+	 * compactors have already isolated to the limit, but are
+	 * blocked on filesystem locks held by the GFP_NOFS thread.
+	 */
+	if (cc->gfp_mask & __GFP_FS) {
+		inactive >>= 3;
+		active >>= 3;
+	}
+
 	too_many = isolated > (inactive + active) / 2;
 	if (!too_many)
 		wake_throttle_isolated(pgdat);
@@ -806,7 +818,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 	 * list by either parallel reclaimers or compaction. If there are,
 	 * delay for some time until fewer pages are isolated
 	 */
-	while (unlikely(too_many_isolated(pgdat))) {
+	while (unlikely(too_many_isolated(cc))) {
 		/* stop isolation if there are still pages not migrated */
 		if (cc->nr_migratepages)
 			return -EAGAIN;
-- 
2.40.0

