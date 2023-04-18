Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BA26E6CC9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjDRTO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbjDRTOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:14:05 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242D1A26F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:42 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id l11so30662402qtj.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845221; x=1684437221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bns8+mp3X6nXdCFxV2tvIrIcPUTCwJdDXntfPdL7pp0=;
        b=mwxAjt5FHbXosh8eO+VsA0QaIzkPHSj509IMResMBLrFCDtFqQuAb39AWA+k+QpfGQ
         2sTi7ak9g0/7anwaLuFZa8TnEH9/W0IsasBzTf35DDXZIjNZ/+iQTItjl6xvXY6x+qbV
         svWyu0WEhJTQsOP5r4KsHn0kvCVHMCqKPohNvbGE7v7GTuISWCmFDVvEjh+wYDMd6gPV
         QPpD51iUk1E7ChSCX2CJ4//Jg45qmYKpV2D2NrCvvOkGI9qVSedCxygcX/hpgxgpYiRw
         KQnkSn73bb0v0CpIU4XcXH/w9PR1l/pMtfWeS5WYklu48+aB4n8+2PHRP8wlzmglM4v3
         6yMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845221; x=1684437221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bns8+mp3X6nXdCFxV2tvIrIcPUTCwJdDXntfPdL7pp0=;
        b=O5Yzh06/KAHcbfpl5i+VkqQcw8YOe0pzlXC4+CO5gbzJy4X0fMHA8f4zwmAfCGjbfH
         +RQi4TkmuPyBI4A84GQGJcjxMm8ONryyZjC2T5VUud2M2bheeJw4UuyCjOVEwCRcWJEk
         Iz2mK0rUaQspW7Wffo7wt3uEbkm2MUa/GUjOdFVH5s2BYC2KzjB7WOCWkn6iNYQhI/SS
         Ip43J40jvm2AvkCLd46506dyegJuCIEKcYc44Ymq8YipmUp/BnPiP3BvLK/8s5gXsYu7
         4pDCGANX0kg7vg1mBxz15PLtFJG1JF0JC6XNGgPPfKAUqwVnh6ufyiKD5Bs20VgHU7aZ
         liAg==
X-Gm-Message-State: AAQBX9dH43aZJXTUY8oFNBZN9ury+87A2YMglcF4sTiS7poFWALXeTGz
        L8XPvt98J2oUi6zpDJ4A6thr0w==
X-Google-Smtp-Source: AKy350YxL97fUsu7ft+nTwgxWroY8EhxqBqMYvhNTWaLrHbHqzHqIxvgWZLrQ3ewFfKTOzgKcfLxmQ==
X-Received: by 2002:a05:622a:20a:b0:3e4:e94a:5082 with SMTP id b10-20020a05622a020a00b003e4e94a5082mr1611125qtx.5.1681845221305;
        Tue, 18 Apr 2023 12:13:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id r15-20020a05622a034f00b003e4d43038e2sm1829712qtw.5.2023.04.18.12.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:41 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 19/26] mm: compaction: drop redundant watermark check in compaction_zonelist_suitable()
Date:   Tue, 18 Apr 2023 15:13:06 -0400
Message-Id: <20230418191313.268131-20-hannes@cmpxchg.org>
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

should_compact_retry() is called after direct reclaim and compaction
have failed to produce a page, to check if there is still enough
compactable memory to warrant continuing. If there aren't, one last
attempt at the freelists happens in __alloc_pages_may_oom(). The
watermark check in should_compact_retry() is not necessary. Kill it.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/compaction.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 0aa2a0a192dc..52103545d58c 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2263,13 +2263,6 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,
 				ac->highest_zoneidx, ac->nodemask) {
 		unsigned long available;
-		unsigned long watermark;
-
-		/* Allocation can already succeed, nothing to do */
-		watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
-		if (zone_watermark_ok(zone, order, watermark,
-				      ac->highest_zoneidx, alloc_flags))
-			continue;
 
 		available = zone_page_state_snapshot(zone, NR_FREE_MOVABLE);
 		available += zone_page_state_snapshot(zone, NR_FREE_CMA_PAGES);
-- 
2.39.2

