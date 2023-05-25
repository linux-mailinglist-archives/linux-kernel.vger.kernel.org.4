Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A628E71039D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237435AbjEYEDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237470AbjEYEDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:03:09 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B403189
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 21:03:04 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d3e5e5980so1966418b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 21:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1684987384; x=1687579384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WOXFBlEjJcJ6V9YFOI8yptpCpDKRZLgBqb3BFNypKaI=;
        b=VO447nLYcNslTB95FdoOTJFuskVQk5jMcKcrP02WXeDjykcP5O7h70FE25NHPd1yFv
         V4lah2jbdvfrDYCxZH9TSktvenzbogw/teitAJ6Hd43cc2hQAZYnrAzlFxSOaTCqcZEY
         DE9HcPswNSY/ZvpSIXfcZEEA/RDdMPVCTj3R3LVLJ2T7g66Bh/OftP86auFWO43QYn0x
         9c8fP4xxNH9Yg69myVOoct77jVdwhD3mOs4qiY1whhlIA9PIqoV5lxOJ2OkQOyIH1uXp
         UrrmDHERBpGc/UpuyXoMe5tVDKr3DH9Rbn21GdqzSaujFFDFbRjBt4LQxuR02H04bcKR
         PtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684987384; x=1687579384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WOXFBlEjJcJ6V9YFOI8yptpCpDKRZLgBqb3BFNypKaI=;
        b=LqZ0d49cqdBwqxfQVmwQCPcdo/2fAXCUWb44MAB2oRYJR1a1pgMe59YHkOWW9ICuVL
         MmEsJ7RN/3rkXbF1cy49bVcuTaPUCJUESea+CbCuvuGNZFNF5uOQyzLVvngmoO8HxIr6
         CRUVZ2tzMCCa0d5fqTZ7oqYPxBQiqsfo9vrvPNcC0Af7lf9VCX+uvKLbYV3MEVuDEQNj
         gPxjzITgu/cbT1PbpL9+E6PlIxc+0yGZdFW2khNrS1/F3cFJDRVQ/C9T6XMrQjnMaGPv
         MTe4t+eJ7WvKY/xeY0cp2QSnkIHCU5YdCdhC2ZRMee2x8liZF9tuyOMqQb7p3iIS9886
         6Vew==
X-Gm-Message-State: AC+VfDw546u+jS1XaQJtKINdUJksswbCu+MJBYq38i6bVNbqbHsZ+szH
        0SrIKWLIAsrFXfcVdvYPuKzotQ==
X-Google-Smtp-Source: ACHHUZ5KDLvsnPMttA35NNkIYcWPtfzYRaU6CCRv6/FNJJk83SuplTOTM88OJQEdxRwdyk+G+FcUBA==
X-Received: by 2002:a05:6a20:a115:b0:100:b137:3563 with SMTP id q21-20020a056a20a11500b00100b1373563mr19314283pzk.32.1684987384404;
        Wed, 24 May 2023 21:03:04 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id i11-20020aa7908b000000b0064c56d04316sm189916pfa.193.2023.05.24.21.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 21:03:04 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH 2/3] mm/mm_init.c: account absent_page only if spanned_page is non-zero
Date:   Thu, 25 May 2023 04:01:49 +0000
Message-Id: <20230525040150.1588-2-haifeng.xu@shopee.com>
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

If spanned_page is zero, it's pointless to calculate the number of
absent_page. Also, the real size can be assigned to zero directly.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/mm_init.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index cf55bba04b23..898af4eb9ce2 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1260,31 +1260,30 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 		struct zone *zone = pgdat->node_zones + i;
 		unsigned long zone_start_pfn, zone_end_pfn;
 		unsigned long spanned, absent;
-		unsigned long size, real_size;
+		unsigned long real_size;
 
 		spanned = zone_spanned_pages_in_node(pgdat->node_id, i,
 						     node_start_pfn,
 						     node_end_pfn,
 						     &zone_start_pfn,
 						     &zone_end_pfn);
-		absent = zone_absent_pages_in_node(pgdat->node_id, i,
-						   node_start_pfn,
-						   node_end_pfn);
-
-		size = spanned;
-		real_size = size - absent;
-
-		if (size)
+		if (spanned) {
+			absent = zone_absent_pages_in_node(pgdat->node_id, i,
+							   node_start_pfn,
+							   node_end_pfn);
+			real_size = spanned - absent;
 			zone->zone_start_pfn = zone_start_pfn;
-		else
+		} else {
+			real_size = 0;
 			zone->zone_start_pfn = 0;
-		zone->spanned_pages = size;
+		}
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

