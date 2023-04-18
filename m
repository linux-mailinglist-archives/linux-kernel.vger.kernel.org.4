Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AEF6E6CC2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjDRTOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjDRTNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:13:39 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88007EE5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:25 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id e13so12949890qvd.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845205; x=1684437205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTPdiQIdreogGm8cBWdKbYJibQNRp8zcbNt+du8HIBU=;
        b=HuPalACvDhuLF7KvDz6g49PPKO7XyqovkGZVXCYy6pLcxgFDYRU6w4grAPkt0YvGk6
         pHJ521bPBzsCouaZvOOPJXwsvNRmORjMrJzURqRnWoJKVVIQ0LYCfgJo8dAWEnQZSnm/
         +qvQ+RSmv9XdJ2WBvUINtpcBP4b/WzY099qV6MGA2jIRIxot+itSnsyKvOmEvArOiu1Q
         S+M3Q1BZHNM97/Br+cYmnpOE4izzfu1L2C7HfcIzhT5hZSS40LopQDZ3JnFsmhJL3dMJ
         Cq3x+nKbD8VyFtiLxqGEhPZyLptBiJ+Tm3yhwtrd5LnIqpPyDSHTFaSAvqO642ZLRgyW
         OGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845205; x=1684437205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTPdiQIdreogGm8cBWdKbYJibQNRp8zcbNt+du8HIBU=;
        b=RJgHCDlx9YOsQviBzUV5tCT7r5k3GubSVCBWoshZPlC2dmuDVwKTTLZAFWnjTOl/je
         EaTfx/rwLW2IyTwFVFVd6A+tDEELsbeBtu45mqoC6NaXaslo5NbG6DqVPEK43g7gU5GN
         WSzFFuZepfz0PkEXy5bjkx03+k1LCb/PIyT5sqPfSHUNjWAWdc6Ps/zhYAY6Qty42uhv
         oTMXtmGf2NH5uFCQP/KiCEHAHShxTfeLeW5P9fCWYwMatk3CmF3OopCkVgt4f075KXi3
         HUPAmEQZe7NuNNbkM7vJighgFqM3k/eKr1wdzzihX9ELqEHyYnbgeVUr+HSxd1FL41fZ
         yxmw==
X-Gm-Message-State: AAQBX9f9zOmJaSChIbwPA4CtXcs4SStcxsSgxH5tsE9qjKinA/T7QAZG
        CLmsxA+vNWV+mCGXVBvOibkucgzOJyAIHCiTgW8=
X-Google-Smtp-Source: AKy350aDUeUhXJBSWIivTN/XnDLT5DJ+ST1mc086iGBK1cA1BfRASnqlSz8S0NO45keDkBhRWTpTfw==
X-Received: by 2002:a05:6214:2305:b0:5f1:6a35:60be with SMTP id gc5-20020a056214230500b005f16a3560bemr288353qvb.23.1681845204992;
        Tue, 18 Apr 2023 12:13:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id m8-20020a05620a220800b007468b183a65sm4166837qkh.30.2023.04.18.12.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:24 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 05/26] mm: page_alloc: per-migratetype pcplist for THPs
Date:   Tue, 18 Apr 2023 15:12:52 -0400
Message-Id: <20230418191313.268131-6-hannes@cmpxchg.org>
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

Right now, there is only one pcplist for THP allocations. However,
while most THPs are movable, the huge zero page is not. This means a
movable THP allocation can grab an unmovable block from the pcplist,
and a subsequent THP split, partial free, and reallocation of the
remainder will mix movable and unmovable pages in the block.

While this isn't a huge source of block pollution in practice, it
happens often enough to trigger debug warnings fairly quickly under
load. In the interest of tightening up pageblock hygiene, make the THP
pcplists fully migratetype-aware, just like the lower order ones.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/mmzone.h | 8 +++-----
 mm/page_alloc.c        | 4 ++--
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index cd28a100d9e4..53e55882a4e7 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -552,13 +552,11 @@ enum zone_watermarks {
 };
 
 /*
- * One per migratetype for each PAGE_ALLOC_COSTLY_ORDER. One additional list
- * for THP which will usually be GFP_MOVABLE. Even if it is another type,
- * it should not contribute to serious fragmentation causing THP allocation
- * failures.
+ * One per migratetype for each PAGE_ALLOC_COSTLY_ORDER. One additional set
+ * for THP (usually GFP_MOVABLE, but with exception of the huge zero page.)
  */
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define NR_PCP_THP 1
+#define NR_PCP_THP MIGRATE_PCPTYPES
 #else
 #define NR_PCP_THP 0
 #endif
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5e04a69f6a26..d3d01019ce77 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -710,7 +710,7 @@ static inline unsigned int order_to_pindex(int migratetype, int order)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (order > PAGE_ALLOC_COSTLY_ORDER) {
 		VM_BUG_ON(order != pageblock_order);
-		return NR_LOWORDER_PCP_LISTS;
+		return NR_LOWORDER_PCP_LISTS + migratetype;
 	}
 #else
 	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
@@ -724,7 +724,7 @@ static inline int pindex_to_order(unsigned int pindex)
 	int order = pindex / MIGRATE_PCPTYPES;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (pindex == NR_LOWORDER_PCP_LISTS)
+	if (pindex >= NR_LOWORDER_PCP_LISTS)
 		order = pageblock_order;
 #else
 	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
-- 
2.39.2

