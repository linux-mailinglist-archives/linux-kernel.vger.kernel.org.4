Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CF56690D0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjAMI2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjAMI1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:27:41 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10B342633
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:27:16 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so8584942pjl.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4Az0GQIpAo5qLK4eslBRX7WJSl1cxutE/mioG/uZxc=;
        b=MpnWYaJF2T4qlC9e913gYzl9AiD8aMnsvQKAqLMg1yjsF0soBswn5aF6VSp72MhgAY
         2g1ioFdZFpeEptHS5Sm2x3Qgtz45T3zAYavuNbvTxLAbmG/8Up0DSPdD6FjIMBbuf++z
         dD5W8xWo6PA1QZ67Tit3KfPwWe/sqvW96xIpG/jn+owrIeO3WTd3MetvHFgZ7sDV1+XV
         owF5gECfqxzfyOuGrjseOKHUtJEzOhq02ccaTKLB5WdzfWOYT3DnaniY/u5eJALne30V
         10JMG9ugSSxV3R/E/LOj1nLFQefTA2CuZIUEfsE/GV68ojR8OnoK2zg8HWRRwTnyD2+X
         KyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4Az0GQIpAo5qLK4eslBRX7WJSl1cxutE/mioG/uZxc=;
        b=d9hQ4vS4MuvQht4ZNC/IAefBEcNzhBp6A/Z+Y7y67Sip6pDa7BIfmcZ7u19SHP9Yaj
         oBUJN/lHG0eV7+uif0XdXqEBsLK9UCQczOSwdGayt6dTzJQgMzX1Naptp80fFpeu4nw4
         4o5Th3VYH5/2K21GAkVowrDoK0bHBFnTJhRauRBAM+Hy7QW8jdtDNMUDtSCd8MhPDMC1
         PHg7m3VXN6a26mVOGiA45CgWhCpRypAgGzeJAqHtaaGqXGoFLMbNpdglrURubYSqRrlA
         xFqhSs4E602SFw0RDvY7xcRU84jUqPNfb/xFNcCOt/mKX7hVP+0Dmi7h6xO9B4YxT6Xq
         Z6zg==
X-Gm-Message-State: AFqh2krucnsPYF8AdF0Q7VWKXTwp+U/SYYZggjfo/x9zPVQppQyVu+ja
        0/w3s03a7y0nw35YgzoJF/WNUA==
X-Google-Smtp-Source: AMrXdXvRnSFAvuVDnwL5a9P9gCpjSMEYNO2QmBFJKhOEtNTetuC8pqV8Qm9f2UXHHySTaHSwQvLUag==
X-Received: by 2002:a05:6a20:9f48:b0:ac:29b6:a235 with SMTP id ml8-20020a056a209f4800b000ac29b6a235mr91778538pzb.54.1673598436328;
        Fri, 13 Jan 2023 00:27:16 -0800 (PST)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id l123-20020a622581000000b005818d429d98sm13092738pfl.136.2023.01.13.00.27.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Jan 2023 00:27:16 -0800 (PST)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     rppt@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 3/3] memblock: Avoid useless checks in memblock_merge_regions().
Date:   Fri, 13 Jan 2023 16:26:59 +0800
Message-Id: <20230113082659.65276-4-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230113082659.65276-1-zhangpeng.00@bytedance.com>
References: <20230113082659.65276-1-zhangpeng.00@bytedance.com>
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

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 mm/memblock.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index cb92770ac22e..e19eb08efc73 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -523,15 +523,18 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
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
+						   int start_rgn,
+						   int end_rgn)
 {
-	int i = 0;
+	int i = max(start_rgn - 1, 0);
 
-	/* cnt never goes below 1 */
-	while (i < type->cnt - 1) {
+	end_rgn = min(end_rgn, (int)type->cnt - 1);
+	while (i < end_rgn) {
 		struct memblock_region *this = &type->regions[i];
 		struct memblock_region *next = &type->regions[i + 1];
 
@@ -548,6 +551,7 @@ static void __init_memblock memblock_merge_regions(struct memblock_type *type)
 		/* move forward from next + 1, index of which is i + 2 */
 		memmove(next, next + 1, (type->cnt - (i + 2)) * sizeof(*next));
 		type->cnt--;
+		end_rgn--;
 	}
 }
 
@@ -604,7 +608,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 	bool insert = false;
 	phys_addr_t obase = base;
 	phys_addr_t end = base + memblock_cap_size(base, &size);
-	int idx, start_idx, nr_new;
+	int idx, start_idx, nr_new, start_rgn = -1, end_rgn;
 	struct memblock_region *rgn;
 
 	if (!size)
@@ -659,10 +663,14 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
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
@@ -671,9 +679,13 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
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
@@ -690,7 +702,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 		insert = true;
 		goto repeat;
 	} else {
-		memblock_merge_regions(type);
+		memblock_merge_regions(type, start_rgn, end_rgn);
 		return 0;
 	}
 }
@@ -927,7 +939,7 @@ static int __init_memblock memblock_setclr_flag(phys_addr_t base,
 			r->flags &= ~flag;
 	}
 
-	memblock_merge_regions(type);
+	memblock_merge_regions(type, start_rgn, end_rgn);
 	return 0;
 }
 
@@ -1300,7 +1312,7 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
 	for (i = start_rgn; i < end_rgn; i++)
 		memblock_set_region_node(&type->regions[i], nid);
 
-	memblock_merge_regions(type);
+	memblock_merge_regions(type, start_rgn, end_rgn);
 #endif
 	return 0;
 }
-- 
2.20.1

