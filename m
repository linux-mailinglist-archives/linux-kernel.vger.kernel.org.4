Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FCC7122BB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 10:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242839AbjEZIxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 04:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242826AbjEZIxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 04:53:39 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9622499
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:53:35 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b01bd7093aso356585ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1685091215; x=1687683215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NMzZohBzm3grNkWqlJ2ehF7xySxE1C3rcpeNbqkLyjs=;
        b=NklE6UduAZJgJ1Ah+MN/NOXVNOB5UfOrDgXfh9g4uEkWBp2EI9bEPw442dfm096hwU
         vZGQokxLy8z83csOSqPszmJ0Bm9/ejb8bvj/O1sEq1qMU2PBJuI9rI1Kdpp/Ami3ozsC
         HY3Rf6ZYy3SpldjCO0W6d5Rr5ZvcZmiSVoiOOw5yLLiz8yKYAMLGvF42vW4jeomqnBMF
         gELfAS86efZ+CKjIRbVxj/Ku00cZWjonhjkqoX6WQjHUhs/G7S6yMbm60ssyymm+7UKF
         Tg0Qwa6PIYcuDB6s8nlw+Xv+1raP4X1jw4EB2OI5FT2tZe+OXUDs8fqvP0s1T7HX/PP0
         45wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685091215; x=1687683215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMzZohBzm3grNkWqlJ2ehF7xySxE1C3rcpeNbqkLyjs=;
        b=Ec29n9OUUkXBJACXd2WK2JR6tn60SMNylGEEwoteidzlAuVAC5e3aU0A2edXwBJ1yX
         XZyfjuzagYaD8w7MWAfT6/8hK+twGILpF1ctIa2JTQdfpo2xvsTcrSOUVlY3shP6NRRq
         sedk4uUPS8icoAdiQYIyVpSh/cHmqGfJnYHvFYq7VNcCATKbtXDyYcU5wCyvNjS6uqJd
         JAZmkYwBo01SrLq5Ka6IDaTcDlhtmrkogusJJ/TwJRgDhpDAcYEpc9d0L3kT0dBggvEv
         zVm7JenrtspAAc/l/vFV6CAqgnsxv1kvaFzVpN86zIiClPiUlb+LT2reFWixDCbYpWu2
         c4Rg==
X-Gm-Message-State: AC+VfDxQkZvMODAeQlv19HnHA0XkH6heyANYuvBuGiSsQ+qv530Dc+bN
        xx8TSIiJgyKojySxTVvIGek6mQ==
X-Google-Smtp-Source: ACHHUZ57GUUtJWBhLw+aLAVkXRdNHyadME+8V5cu9DIh0bVby1WyvCh7fFKc+hcauC6S7WOndaZX0Q==
X-Received: by 2002:a17:903:1d2:b0:1af:b7cd:5961 with SMTP id e18-20020a17090301d200b001afb7cd5961mr2070704plh.1.1685091215033;
        Fri, 26 May 2023 01:53:35 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id t13-20020a170902b20d00b0019ee045a2b3sm2713911plr.308.2023.05.26.01.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 01:53:34 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     rppt@kernel.org
Cc:     akpm@linux-foundation.org, mhocko@suse.com, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v2 2/2] mm/mm_init.c: do not calculate zone_start_pfn/zone_end_pfn in zone_absent_pages_in_node()
Date:   Fri, 26 May 2023 08:52:51 +0000
Message-Id: <20230526085251.1977-2-haifeng.xu@shopee.com>
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

In calculate_node_totalpages(), zone_start_pfn/zone_end_pfn are already
calculated in zone_spanned_pages_in_node(), so use them as parameters
instead of node_start_pfn/node_end_pfn and the duplicated calculation
process can de dropped.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Suggested-by: Mike Rapoport <rppt@kernel.org>
---
v2:
- remove unrelated whitespace changes
- do not replace pgdat->node_id with a local
  variable
- remove redundant variable 'size'
- add check that whether a zone is empty or not
---
 mm/mm_init.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index f674e5798f7d..2d91bb52c619 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1166,20 +1166,15 @@ unsigned long __init absent_pages_in_range(unsigned long start_pfn,
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
 
-	zone_start_pfn = clamp(node_start_pfn, zone_low, zone_high);
-	zone_end_pfn = clamp(node_end_pfn, zone_low, zone_high);
+	/* zone is empty, we don't have any absent pages */
+	if (zone_start_pfn == zone_end_pfn)
+		return 0;
 
-	adjust_zone_range_for_zone_movable(nid, zone_type,
-			node_start_pfn, node_end_pfn,
-			&zone_start_pfn, &zone_end_pfn);
 	nr_absent = __absent_pages_in_range(nid, zone_start_pfn, zone_end_pfn);
 
 	/*
@@ -1272,7 +1267,7 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 		struct zone *zone = pgdat->node_zones + i;
 		unsigned long zone_start_pfn, zone_end_pfn;
 		unsigned long spanned, absent;
-		unsigned long size, real_size;
+		unsigned long real_size;
 
 		spanned = zone_spanned_pages_in_node(pgdat->node_id, i,
 						     node_start_pfn,
@@ -1280,23 +1275,22 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 						     &zone_start_pfn,
 						     &zone_end_pfn);
 		absent = zone_absent_pages_in_node(pgdat->node_id, i,
-						   node_start_pfn,
-						   node_end_pfn);
+						   zone_start_pfn,
+						   zone_end_pfn);
 
-		size = spanned;
-		real_size = size - absent;
+		real_size = spanned - absent;
 
-		if (size)
+		if (spanned)
 			zone->zone_start_pfn = zone_start_pfn;
 		else
 			zone->zone_start_pfn = 0;
-		zone->spanned_pages = size;
+		zone->spanned_pages = spanned;
 		zone->present_pages = real_size;
 #if defined(CONFIG_MEMORY_HOTPLUG)
 		zone->present_early_pages = real_size;
 #endif
 
-		totalpages += size;
+		totalpages += spanned;
 		realtotalpages += real_size;
 	}
 
-- 
2.25.1

