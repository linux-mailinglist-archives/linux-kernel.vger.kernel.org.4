Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697FE709760
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjESMkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjESMkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:40:21 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F04B12B
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 05:40:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso588459366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 05:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1684500011; x=1687092011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4v+oqRzENdCCjglWNqDJ+55Ca3cK8hCc7vsdYbZrmE=;
        b=20CNqbvJsj1aXxY3uCUm45tf9ezX9S2bW71I97+RgtCqHWhejBmT7D8t6SgGPjZ4D0
         78NGrpoPPgmK0cvKKi0ScZpI0FqlVDon7QXVVExvNnUuac/erh7fmnnN3w4DhzvLGwft
         WCQyIYWLBRXqrhGVyJEHXh8X9AnxXKhTN9drGkBpCz7ERqa241WhCyvJ98dXO21xlppI
         Sen2Lkn8tmpr3cNnF999AOPTRPS/iKGGc5L/ADLTcg86p/eC2uxUGukPE+/gtpo5wxcu
         PtBvaa/bveFRu5G2nltWcfYX1Yo0Ff93a5HBQCDMqcQ4Ts5TTOtSy8ylgH/sNIc0mkNn
         i6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684500011; x=1687092011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4v+oqRzENdCCjglWNqDJ+55Ca3cK8hCc7vsdYbZrmE=;
        b=V0SntLQils5e2GWyjbGDLagdwtatrF+dcwCQCzygzr/emQ+GfKePttPj8r6RiZG3wW
         I0/6fCMR/kQ/flDFi/eH/4ddi9BWZu61Mig5tvoWRDy5xS6PKWpDmx8o5FTer+PfI3NH
         d6k2egyQK1cOevN58USPnUy1MdCwwhXGQ+mB5Pyr9oiPyR14uj4W1UrlZEB4DlUsCgOi
         8IuGMqjHFULhv9mJ21hnDDe0lnW2HiMgGqnmYAX5bJ8GzZoYahNmxTx7bqff3DeT9Ced
         2HBHKPq87RF11lPWFeo/FdBfMHOttdk59Ls5pMJP+EEMn6V04VHCx16jLVqojh50wrzn
         tveA==
X-Gm-Message-State: AC+VfDyK+GbAXq/Y/c5+Ht251ylqKy0ElCrTiC5yvwyChOKZgIf6A+Ag
        JvQYMHvge7XlkUZf6FWzY2Cqkw==
X-Google-Smtp-Source: ACHHUZ5HyrBz4voNu4RQsLSn8EHNU2geTDUc+VN5aCe45DZsHq2yRGRL9hB9xWE6eywvCBf1dsLcEQ==
X-Received: by 2002:a17:907:26ca:b0:962:582d:89bf with SMTP id bp10-20020a17090726ca00b00962582d89bfmr1351778ejc.55.1684500011653;
        Fri, 19 May 2023 05:40:11 -0700 (PDT)
Received: from localhost ([2a02:8070:6389:7d40:e266:3092:9afb:a7b1])
        by smtp.gmail.com with ESMTPSA id a21-20020a170906191500b0096f7ae359a5sm318552eje.30.2023.05.19.05.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 05:40:11 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/5] mm: compaction: drop redundant watermark check in compaction_zonelist_suitable()
Date:   Fri, 19 May 2023 14:39:59 +0200
Message-Id: <20230519123959.77335-6-hannes@cmpxchg.org>
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

The watermark check in compaction_zonelist_suitable(), called from
should_compact_retry(), is sandwiched between two watermark checks
already: before, there are freelist attempts as part of direct reclaim
and direct compaction; after, there is a last-minute freelist attempt
in __alloc_pages_may_oom().

The check in compaction_zonelist_suitable() isn't necessary. Kill it.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/compaction.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 83ecbc829c62..40ce4e6dd17e 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2291,13 +2291,6 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
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
 
 		/*
 		 * Do not consider all the reclaimable memory because we do not
-- 
2.40.0

