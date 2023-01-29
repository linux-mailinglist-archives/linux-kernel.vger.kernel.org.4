Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975E967FDB7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 10:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbjA2JA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 04:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjA2JAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 04:00:52 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7078E20D00
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 01:00:50 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id e6so589558plg.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 01:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScnZcZbb5V5pAaOvJOkYQXxCHW6a6an6BscyyrmyHtQ=;
        b=2FpCFAYP0cmHckXG5sKIz6y4qCTRDcEXKoIhAKX34FvslF0ncTuPRaKOUtNpy1EmCh
         WgpZKATrUNUFKck1nV4UAqGwDcMKDlscS+Sc06+XqQU7LkSDhaWXYb/6aVZHESY77Jrb
         F+GFfpTsZeK4uUZ0Ayc5gZMUhYzAamJM5ggJ9iXoDkaqvL5VcISdIWYxaxW43ugmZqqO
         bjEum0V4dtVtwFgFOHSXHKACt+J8Snoe203X83lEusmHyJJY9atfvNzzp9d9OnEzBVXR
         nj5+mEplqKwzYG6kmZyMx1qdR3Q4BwL4cJfN5XwmhW2TV4fuu0bQawymKtonAcdBf4Fi
         RvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScnZcZbb5V5pAaOvJOkYQXxCHW6a6an6BscyyrmyHtQ=;
        b=RGJrEZUkedHD8v4TD3ln1vDpAwkgeMGoD+jEWl/XChrpuBEb8oqoYigdCpLjsT2Pfb
         Y7M6F7yg5iiluzGSHEMwVsZ767cAv1JJf0m2/h2XqwbMSjqP5rzz2OdNJ7hOqC79DLz8
         g/2e2QuCUtg1a2M/iLkXBYsqCy/V1BQDdfftOSV5lcIBD3Fe/uY5MPp8Ok3bz85ejc2c
         LiWejvVBRr3FETgbo6+sP38DzBoZ8/4qpZydf/1fIrfTJugh7y7ouIPYVoih18DdX5Jt
         I1knSdrI+VOH7S+dhh+r7vjk7fekcV0AGWw2vc26X3zAmsuzy7LV8V47YN4mqPEHe9Nz
         KN6A==
X-Gm-Message-State: AO0yUKVdf4sJmilKboA4+586CG1uCx7O4vWBhxFb/lTgwX6crLdVdC9K
        zKSISGMr8f8+DLbwDAiFZl9hZA==
X-Google-Smtp-Source: AK7set8OItuuxzVtM6QBoIV/KsdOqx0sis6DAF6WZwbVrgroVjmqVqyv63tM6G0OHm9J0+gld1SQOA==
X-Received: by 2002:a17:903:2309:b0:196:11ad:8197 with SMTP id d9-20020a170903230900b0019611ad8197mr4558850plh.66.1674982849733;
        Sun, 29 Jan 2023 01:00:49 -0800 (PST)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902f54d00b0019607984a5esm2142689plf.95.2023.01.29.01.00.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 29 Jan 2023 01:00:49 -0800 (PST)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     rppt@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 2/2] memblock: Avoid useless checks in memblock_merge_regions().
Date:   Sun, 29 Jan 2023 17:00:34 +0800
Message-Id: <20230129090034.12310-3-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230129090034.12310-1-zhangpeng.00@bytedance.com>
References: <20230129090034.12310-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memblock_merge_regions() is called after regions have been modified to
merge the neighboring compatible regions. That will check all regions
but most checks is useless.

Most of the time we only insert one or a few new regions, or modify one
or a few regions. At this time, we don't need to check all regions. We
only need to check the changed regions, because other not related
regions cannot be merged. So this patch add two parameters to
memblock_merge_regions() to indicate the lower and upper boundary to scan.

Test this patch and get numbers like this:

void memblock_merge_regions(struct memblock_type *type) {
	static int iteration_count = 0;
	static int max_nr_regions = 0;

	max_nr_regions = max(max_nr_regions, (int)type->cnt);
	...
	while () {
		iteration_count++;
		...
	}
	pr_info("iteration_count: %d max_nr_regions %d", iteration_count,
max_nr_regions);
}

The folowing numbers is the last output tested on a physical machine
with 1T memory.

Mainline:
[2.472243] iteration_count: 45410 max_nr_regions 178

Patched:
[2.470869] iteration_count: 923 max_nr_regions 176

The actual startup speed seems to change little, but it does reduce the
scan overhead.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 mm/memblock.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 836eb71ea3ea..22e48b0f57ad 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -500,15 +500,19 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
 /**
  * memblock_merge_regions - merge neighboring compatible regions
  * @type: memblock type to scan
- *
- * Scan @type and merge neighboring compatible regions.
+ * @start_rgn: start scanning from (@start_rgn - 1)
+ * @end_rgn: end scanning at (@end_rgn - 1)
+ * Scan @type and merge neighboring compatible regions in [@start_rgn - 1, @end_rgn)
  */
-static void __init_memblock memblock_merge_regions(struct memblock_type *type)
+static void __init_memblock memblock_merge_regions(struct memblock_type *type,
+						   unsigned long start_rgn,
+						   unsigned long end_rgn)
 {
 	int i = 0;
-
-	/* cnt never goes below 1 */
-	while (i < type->cnt - 1) {
+	if (start_rgn)
+		i = start_rgn - 1;
+	end_rgn = min(end_rgn, type->cnt - 1);
+	while (i < end_rgn) {
 		struct memblock_region *this = &type->regions[i];
 		struct memblock_region *next = &type->regions[i + 1];
 
@@ -525,6 +529,7 @@ static void __init_memblock memblock_merge_regions(struct memblock_type *type)
 		/* move forward from next + 1, index of which is i + 2 */
 		memmove(next, next + 1, (type->cnt - (i + 2)) * sizeof(*next));
 		type->cnt--;
+		end_rgn--;
 	}
 }
 
@@ -581,7 +586,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 	bool insert = false;
 	phys_addr_t obase = base;
 	phys_addr_t end = base + memblock_cap_size(base, &size);
-	int idx, nr_new;
+	int idx, nr_new, start_rgn = -1, end_rgn;
 	struct memblock_region *rgn;
 
 	if (!size)
@@ -635,10 +640,14 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 #endif
 			WARN_ON(flags != rgn->flags);
 			nr_new++;
-			if (insert)
+			if (insert) {
+				if (start_rgn == -1)
+					start_rgn = idx;
+				end_rgn = idx + 1;
 				memblock_insert_region(type, idx++, base,
 						       rbase - base, nid,
 						       flags);
+			}
 		}
 		/* area below @rend is dealt with, forget about it */
 		base = min(rend, end);
@@ -647,9 +656,13 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 	/* insert the remaining portion */
 	if (base < end) {
 		nr_new++;
-		if (insert)
+		if (insert) {
+			if (start_rgn == -1)
+				start_rgn = idx;
+			end_rgn = idx + 1;
 			memblock_insert_region(type, idx, base, end - base,
 					       nid, flags);
+		}
 	}
 
 	if (!nr_new)
@@ -666,7 +679,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 		insert = true;
 		goto repeat;
 	} else {
-		memblock_merge_regions(type);
+		memblock_merge_regions(type, start_rgn, end_rgn);
 		return 0;
 	}
 }
@@ -902,7 +915,7 @@ static int __init_memblock memblock_setclr_flag(phys_addr_t base,
 			r->flags &= ~flag;
 	}
 
-	memblock_merge_regions(type);
+	memblock_merge_regions(type, start_rgn, end_rgn);
 	return 0;
 }
 
@@ -1275,7 +1288,7 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
 	for (i = start_rgn; i < end_rgn; i++)
 		memblock_set_region_node(&type->regions[i], nid);
 
-	memblock_merge_regions(type);
+	memblock_merge_regions(type, start_rgn, end_rgn);
 #endif
 	return 0;
 }
-- 
2.20.1

