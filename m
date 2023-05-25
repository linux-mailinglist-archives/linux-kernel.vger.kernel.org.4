Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D32371039E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbjEYEDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjEYEDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:03:15 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183B683
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 21:03:13 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d341bdedcso1283592b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 21:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1684987392; x=1687579392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gNj2e5Vi2WIkbEKvTOMKfGlxOu0bnyuA1VYYGOrr0Yo=;
        b=C1d4liKZ6puRJ9AH2oIPiS+SjvAzvsi3FfHBafsUWZksEXzfcpaeZOiYFlSc+3EW4C
         taHtMK6aihD0auG7B6m7TjdFHvOIVce7NXLlxnXdz9fQrfaChbk6HMazh/LuToWoah8i
         8OxUImfnhXnQpCFMTYpyIYOA8cJyGzXTdYqyVZ+P1fOqx+7rVFVWXNF9PJy25pyri55f
         /KxbDXv8WalhMh27Pdc/v5vpjpfMnLVSvuoynurGKjBOmLlxUvPI78yq+8Lk9HKKkU/7
         yxUjqWtn1CURH1hJ7nzteV3fY8iW0g2wbbryr0KergvkyF1lo+smv1sjR+oMkRkgZPOY
         YYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684987392; x=1687579392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gNj2e5Vi2WIkbEKvTOMKfGlxOu0bnyuA1VYYGOrr0Yo=;
        b=hG0b0mTF5oUbvtRPfrikLopEHJU4Cm5ougdvrsimCLblv7xo2RCVA6lms4pfqhkvru
         PaAV8LuGyKIda8gDc8FnIXU8Pm5pPyq6GOoT7cxNJBJt7rza0O9CRDLmoE25uG0Pv1+I
         M0wGcN7j1diGwV9mrC9XfzYc3bN0kiQ3DCBydQFNkGU+OFRqb2tT58IeQ2gV6sGIDpLU
         QqA7Egp/vyVEHrcVjDgJ7MQ/LDIQoXTM3MHI6mFYNoz5visTXkyJEowvRnueLTPKSNc6
         BjzK0ZVXjQ5dqBpEKLcg1OvO3QB658kb4HATjLZuQgJoUiNdZrd6igVLjXH4dT+3iOGy
         hE3A==
X-Gm-Message-State: AC+VfDwKh5U9csAr6DvAsE953McywmCaHOiw/a8upP5/GBKX6vGF+DjB
        hnxTVeOFgSgck6a4AJ+gMYwHFg==
X-Google-Smtp-Source: ACHHUZ46LHkUfFKGLmC9bs93CWNBwcjgxU+AsZIPWLPp2Gx/kJ5+kN6V2e3c83ee06SiuTOfIrHARg==
X-Received: by 2002:aa7:888f:0:b0:648:ebb2:3d6 with SMTP id z15-20020aa7888f000000b00648ebb203d6mr6505780pfe.26.1684987392528;
        Wed, 24 May 2023 21:03:12 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id i11-20020aa7908b000000b0064c56d04316sm189916pfa.193.2023.05.24.21.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 21:03:12 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH 3/3] mm/mm_init.c: do not calculate zone_start_pfn/zone_end_pfn in zone_absent_pages_in_node()
Date:   Thu, 25 May 2023 04:01:50 +0000
Message-Id: <20230525040150.1588-3-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In calculate_node_totalpages(), zone_start_pfn/zone_end_pfn are
calculated in zone_spanned_pages_in_node(), so use them as parameters
instead of node_start_pfn/node_end_pfn and the duplicated calculation
process can de dropped.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/mm_init.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 898af4eb9ce2..88c4a9266e2a 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1166,23 +1166,11 @@ unsigned long __init absent_pages_in_range(unsigned long start_pfn,
 /* Return the number of page frames in holes in a zone on a node */
 static unsigned long __init zone_absent_pages_in_node(int nid,
 					unsigned long zone_type,
-					unsigned long node_start_pfn,
-					unsigned long node_end_pfn)
+					unsigned long zone_start_pfn,
+					unsigned long zone_end_pfn)
 {
-	unsigned long zone_low = arch_zone_lowest_possible_pfn[zone_type];
-	unsigned long zone_high = arch_zone_highest_possible_pfn[zone_type];
-	unsigned long zone_start_pfn, zone_end_pfn;
 	unsigned long nr_absent;
 
-	if (!node_start_pfn && !node_end_pfn)
-		return 0;
-
-	zone_start_pfn = clamp(node_start_pfn, zone_low, zone_high);
-	zone_end_pfn = clamp(node_end_pfn, zone_low, zone_high);
-
-	adjust_zone_range_for_zone_movable(nid, zone_type,
-			node_start_pfn, node_end_pfn,
-			&zone_start_pfn, &zone_end_pfn);
 	nr_absent = __absent_pages_in_range(nid, zone_start_pfn, zone_end_pfn);
 
 	/*
@@ -1254,6 +1242,7 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 						unsigned long node_end_pfn)
 {
 	unsigned long realtotalpages = 0, totalpages = 0;
+	int nid = pgdat->node_id;
 	enum zone_type i;
 
 	for (i = 0; i < MAX_NR_ZONES; i++) {
@@ -1262,15 +1251,15 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 		unsigned long spanned, absent;
 		unsigned long real_size;
 
-		spanned = zone_spanned_pages_in_node(pgdat->node_id, i,
-						     node_start_pfn,
-						     node_end_pfn,
-						     &zone_start_pfn,
-						     &zone_end_pfn);
+		spanned = zone_spanned_pages_in_node(nid, i,
+						node_start_pfn,
+						node_end_pfn,
+						&zone_start_pfn,
+						&zone_end_pfn);
 		if (spanned) {
-			absent = zone_absent_pages_in_node(pgdat->node_id, i,
-							   node_start_pfn,
-							   node_end_pfn);
+			absent = zone_absent_pages_in_node(nid, i,
+							zone_start_pfn,
+							zone_end_pfn);
 			real_size = spanned - absent;
 			zone->zone_start_pfn = zone_start_pfn;
 		} else {
@@ -1289,7 +1278,7 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 
 	pgdat->node_spanned_pages = totalpages;
 	pgdat->node_present_pages = realtotalpages;
-	pr_debug("On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
+	pr_debug("On node %d totalpages: %lu\n", nid, realtotalpages);
 }
 
 static unsigned long __init calc_memmap_size(unsigned long spanned_pages,
-- 
2.25.1

