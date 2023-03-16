Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299346BCAAD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjCPJXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjCPJXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:23:16 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E3DA90A3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:23:13 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PchdC38z4z8R039;
        Thu, 16 Mar 2023 17:23:11 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
        by mse-fl2.zte.com.cn with SMTP id 32G9N3Ew025512;
        Thu, 16 Mar 2023 17:23:03 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp03[null])
        by mapi (Zmail) with MAPI id mid14;
        Thu, 16 Mar 2023 17:23:05 +0800 (CST)
Date:   Thu, 16 Mar 2023 17:23:05 +0800 (CST)
X-Zmail-TransId: 2b056412dff932c-66bf9
X-Mailer: Zmail v1.0
Message-ID: <202303161723055514455@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <iamjoonsoo.kim@lge.com>, <yang.yang29@zte.com.cn>,
        <willy@infradead.org>
Subject: =?UTF-8?B?wqBbUEFUQ0ggbGludXgtbmV4dF0gbW06IHdvcmtpbmdzZXQ6IHNpbXBsaWZ5IHRoZcKgY2FsY3VsYXRpb24gb2Ygd29ya2luZ3NldCBzaXpl?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 32G9N3Ew025512
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 6412DFFF.001 by FangMail milter!
X-FangMail-Envelope: 1678958591/4PchdC38z4z8R039/6412DFFF.001/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6412DFFF.001/4PchdC38z4z8R039
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

After we implemented workingset detection for anonymous LRU[1],
the calculation of workingset size is a little complex. Actually there is
no need to call mem_cgroup_get_nr_swap_pages() if refault page is
anonymous page, since we are doing swapping then should always
give pressure to NR_ACTIVE_ANON.
So avoid using mem_cgroup_get_nr_swap_pages() when handling
swapin in workingset_refault(). This also give us a chance to refactor
the code to make it simpler and more understandable.

[1] commit aae466b0052e ("mm/swap: implement workingset detection for anonymous LRU")

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Reviewed-by: Wang Yong <wang.yong12@zte.com.cn>
Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
---
 mm/workingset.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 00c6f4d9d9be..a304e8571d54 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -466,22 +466,23 @@ void workingset_refault(struct folio *folio, void *shadow)
 	/*
 	 * Compare the distance to the existing workingset size. We
 	 * don't activate pages that couldn't stay resident even if
-	 * all the memory was available to the workingset. Whether
-	 * workingset competition needs to consider anon or not depends
-	 * on having swap.
+	 * all the memory was available to the workingset. For page
+	 * cache whether workingset competition needs to consider
+	 * anon or not depends on having swap.
 	 */
 	workingset_size = lruvec_page_state(eviction_lruvec, NR_ACTIVE_FILE);
+	/* For anonymous page */
 	if (!file) {
+		workingset_size += lruvec_page_state(eviction_lruvec,
+						     NR_ACTIVE_ANON);
 		workingset_size += lruvec_page_state(eviction_lruvec,
 						     NR_INACTIVE_FILE);
-	}
-	if (mem_cgroup_get_nr_swap_pages(eviction_memcg) > 0) {
+	/* For page cache */
+	} else if (mem_cgroup_get_nr_swap_pages(eviction_memcg) > 0) {
 		workingset_size += lruvec_page_state(eviction_lruvec,
 						     NR_ACTIVE_ANON);
-		if (file) {
-			workingset_size += lruvec_page_state(eviction_lruvec,
+		workingset_size += lruvec_page_state(eviction_lruvec,
 						     NR_INACTIVE_ANON);
-		}
 	}
 	if (refault_distance > workingset_size)
 		goto out;
-- 
2.25.1
