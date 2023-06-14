Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EE872FFCF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244799AbjFNNSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbjFNNSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:18:24 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815B1184
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:18:22 -0700 (PDT)
X-QQ-mid: bizesmtp89t1686748693tz1bp2p7
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 14 Jun 2023 21:18:11 +0800 (CST)
X-QQ-SSF: 01200000000000B08000000A0000000
X-QQ-FEAT: rZJGTgY0+YOEKJckuG39pki7gnHxgidzDka2DFvr3e+5oWDc4cW1ifbtlpg1V
        PaKRRHApQvtMF2/mV5rCE2ua/TK5fMZp5F1XsJ8cCdgKBiPWBLhMCsu79Zpic840oPALn2b
        oVbGbJ8JVs8414qiXHNxm82vXtQTO6BpSASSyDipGU7SYOTo6ht929MkB9yFeIyVI3MlVb6
        gb80s3+VFfu9paZ2etZzJgMx6miVRN3ZyzTiryRh8TJXX6VxPPkTcrA4sz6e+OVXbFb/rpu
        lJ14l/StXJbfq38kfwaIIeyaZ4MA8Ci9mICfq0okcIUTlvC3WOjKh1w8X/dR8gnZZM4165x
        IMrsQ6BHBY4aUu5kr+GA2FVXUWF0itnxQF4yGWEMkafUjBUx7o=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17931232792479222361
From:   Song Shuai <songshuaishuai@tinylab.org>
To:     rppt@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH] memblock: Add error message when memblock_can_resize is not ready
Date:   Wed, 14 Jun 2023 21:17:46 +0800
Message-Id: <20230614131746.3670303-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memblock APIs are always correct, thus the callers usually don't
handle the return code. But the failure caused by unready memblock_can_resize
is hard to recognize without the return code. Like this piece of log:

```
[    0.000000] memblock_phys_alloc_range: 4096 bytes align=0x1000 from=0x0000000000000000 max_addr=0x0000000000000000 alloc_pmd_fixmap+0x14/0x1c
[    0.000000] memblock_reserve: [0x000000017ffff000-0x000000017fffffff] memblock_alloc_range_nid+0xb8/0x128
[    0.000000] Oops - store (or AMO) access fault [#1]
```

So add an error message for this kind of failure:

```
[    0.000000] memblock_phys_alloc_range: 4096 bytes align=0x1000 from=0x0000000000000000 max_addr=0x0000000000000000 alloc_pmd_fixmap+0x14/0x1c
[    0.000000] memblock_reserve: [0x000000017ffff000-0x000000017fffffff] memblock_alloc_range_nid+0xb8/0x128
[    0.000000] memblock: Can't double reserved array for area start 0x000000017ffff000 size 4096
[    0.000000] Oops - store (or AMO) access fault [#1]
```

Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 mm/memblock.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 3feafea06ab2..ab952a164f62 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -418,8 +418,11 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
 	/* We don't allow resizing until we know about the reserved regions
 	 * of memory that aren't suitable for allocation
 	 */
-	if (!memblock_can_resize)
+	if (!memblock_can_resize) {
+		pr_err("memblock: Can't double %s array for area start %pa size %ld\n",
+			type->name, &new_area_start, (unsigned long)new_area_size);
 		return -1;
+	}
 
 	/* Calculate new doubled size */
 	old_size = type->max * sizeof(struct memblock_region);
-- 
2.20.1

