Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49276E766E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjDSJgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjDSJgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:36:49 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC3493FC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:36:39 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b35789313so2359109b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681896999; x=1684488999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LNDvSkvV+/ToXS+qJrVwxLURoAuxWbEh9gZvAqemOP4=;
        b=dsaPplrSm+V7HQC686iPovHEcm4ECYs2V6cZJDJXiu3RytL/PEdS6HOGWQSMiHsVDc
         nCYtjV9irGhfSUBhjNCXJyNElcSm6+piQN2GBwwcRjSO/DSjkwv1Ym+mZ+h1xmyHl11k
         LFrcaftzL1uYsAxTkvxqRMh3Pk2y0pvdrLBCFWowwOsLRHOTTHUG+9vuYP2lcc5EKG/o
         kbs5P2D2b/4fY3Rm+4eN2fQArfpN/jIPBtFYHj/2qlQdL7sPeF8OVFxVccTwtrfz7lzs
         ali08ZRgYoWVH5lVYx/is7qKakyRir3tzoJ720VyBxc6Opx0xEqiEWYhX3ix2DHnN+af
         NPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681896999; x=1684488999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LNDvSkvV+/ToXS+qJrVwxLURoAuxWbEh9gZvAqemOP4=;
        b=Rh3HHMe6CoiaRRov9wxC0CTa9keR0+UQEg2VyLPS6ue34ijat9zmLLcsUv3GN6ZXmM
         0LKLKym6diEfjrV/KMojBz78+m/YTdW5TzrEJfDGUphLxyyWjROYnyBi4DRDZLYy2Tdt
         l35mI9Jd/r/mGF1vdN3mB8yDZ/jqpAh9Dlno/0c5yz7yWonchfdzjxiutA4SGinnPu/T
         GtvFHt3H608I6hnKT02XkR540UI3kGSHLS+B0+bMTIUZL+TQr6EK3IC0sPfEHN/1OXxL
         Yb2wgkEx3AaaDftmtYQIeEeoKvB7TPt7Hbr5e6cjNgahkT+suf1rWZaVL2sOCXzSAScz
         UpAA==
X-Gm-Message-State: AAQBX9fYy78oCvfneBYKGtbDTlHlQ1BZU+NMO+1L3waFgAJ+vPKkwPVx
        DgL2W5Gk7rnvjFzZtAHwmhzpSw==
X-Google-Smtp-Source: AKy350YZ4OSrl1pFAAUYg1YKp/3Afckkw7hOT0Wq6GcrIp9gnsCT+DWQ0wFC0D4d0jLZW/30s9ClDg==
X-Received: by 2002:a05:6a00:1a55:b0:63c:1be4:5086 with SMTP id h21-20020a056a001a5500b0063c1be45086mr3183139pfv.6.1681896998993;
        Wed, 19 Apr 2023 02:36:38 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id c17-20020a62e811000000b0063b8f17768dsm5257165pfi.129.2023.04.19.02.36.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Apr 2023 02:36:38 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH] maple_tree: Fix allocation in mas_sparse_area()
Date:   Wed, 19 Apr 2023 17:36:25 +0800
Message-Id: <20230419093625.99201-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
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

In the case of reverse allocation, mas->index and mas->last do not point
to the correct allocation range, which will cause users to get incorrect
allocation results, so fix it. If the user does not use it in a specific
way, this bug will not be triggered.

Also re-checks whether the size is still satisfied after the lower bound
was increased, which is a corner case and is incorrect in previous versions.

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 9172bcee94b48..110a36479dced 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5250,25 +5250,28 @@ static inline void mas_fill_gap(struct ma_state *mas, void *entry,
  * @size: The size of the gap
  * @fwd: Searching forward or back
  */
-static inline void mas_sparse_area(struct ma_state *mas, unsigned long min,
+static inline int mas_sparse_area(struct ma_state *mas, unsigned long min,
 				unsigned long max, unsigned long size, bool fwd)
 {
-	unsigned long start = 0;
-
-	if (!unlikely(mas_is_none(mas)))
-		start++;
+	if (!unlikely(mas_is_none(mas)) && min == 0) {
+		min++;
+		/*
+		 * At this time, min is increased, we need to recheck whether
+		 * the size is satisfied.
+		 */
+		if (min > max || max - min + 1 < size)
+			return -EBUSY;
+	}
 	/* mas_is_ptr */
 
-	if (start < min)
-		start = min;
-
 	if (fwd) {
-		mas->index = start;
-		mas->last = start + size - 1;
-		return;
+		mas->index = min;
+		mas->last = min + size - 1;
+	} else {
+		mas->last = max;
+		mas->index = max - size + 1;
 	}
-
-	mas->index = max;
+	return 0;
 }
 
 /*
@@ -5297,10 +5300,8 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
 		return -EBUSY;
 
 	/* Empty set */
-	if (mas_is_none(mas) || mas_is_ptr(mas)) {
-		mas_sparse_area(mas, min, max, size, true);
-		return 0;
-	}
+	if (mas_is_none(mas) || mas_is_ptr(mas))
+		return mas_sparse_area(mas, min, max, size, true);
 
 	/* The start of the window can only be within these values */
 	mas->index = min;
@@ -5356,10 +5357,8 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 	}
 
 	/* Empty set. */
-	if (mas_is_none(mas) || mas_is_ptr(mas)) {
-		mas_sparse_area(mas, min, max, size, false);
-		return 0;
-	}
+	if (mas_is_none(mas) || mas_is_ptr(mas))
+		return mas_sparse_area(mas, min, max, size, false);
 
 	/* The start of the window can only be within these values. */
 	mas->index = min;
-- 
2.20.1

