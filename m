Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6776593FC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 02:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbiL3BMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 20:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiL3BMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 20:12:52 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5786DFD0B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 17:12:51 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NjnLV0XKMz8R039;
        Fri, 30 Dec 2022 09:12:50 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
        by mse-fl2.zte.com.cn with SMTP id 2BU1CiXg057579;
        Fri, 30 Dec 2022 09:12:44 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Fri, 30 Dec 2022 09:12:44 +0800 (CST)
Date:   Fri, 30 Dec 2022 09:12:44 +0800 (CST)
X-Zmail-TransId: 2b0363ae3b0c59fb2628
X-Mailer: Zmail v1.0
Message-ID: <202212300912449061763@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <akpm@linux-foundation.org>
Cc:     <david@redhat.com>, <imbrenda@linux.ibm.com>,
        <jiang.xuexin@zte.com.cn>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin.sc@gmail.com>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHY1IDEvNl0ga3NtOiBhYnN0cmFjdCB0aGUgZnVuY3Rpb24gdHJ5X3RvX2dldF9vbGRfcm1hcF9pdGVt?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2BU1CiXg057579
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63AE3B12.000 by FangMail milter!
X-FangMail-Envelope: 1672362770/4NjnLV0XKMz8R039/63AE3B12.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63AE3B12.000/4NjnLV0XKMz8R039
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

A new function try_to_get_old_rmap_item is abstracted from
get_next_rmap_item. This function will be reused by the subsequent
patches about counting ksm_zero_pages.

The patch improves the readability and reusability of KSM code.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Cc: David Hildenbrand <david@redhat.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
---
 mm/ksm.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 83e2f74ae7da..5b0a7343ff4a 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2214,23 +2214,36 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 	}
 }

-static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
-					    struct ksm_rmap_item **rmap_list,
-					    unsigned long addr)
+static struct ksm_rmap_item *try_to_get_old_rmap_item(unsigned long addr,
+					 struct ksm_rmap_item **rmap_list)
 {
-	struct ksm_rmap_item *rmap_item;
-
 	while (*rmap_list) {
-		rmap_item = *rmap_list;
+		struct ksm_rmap_item *rmap_item = *rmap_list;
 		if ((rmap_item->address & PAGE_MASK) == addr)
 			return rmap_item;
 		if (rmap_item->address > addr)
 			break;
 		*rmap_list = rmap_item->rmap_list;
+		/* Running here indicates it's vma has been UNMERGEABLE */
 		remove_rmap_item_from_tree(rmap_item);
 		free_rmap_item(rmap_item);
 	}

+	return NULL;
+}
+
+static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
+					    struct ksm_rmap_item **rmap_list,
+					    unsigned long addr)
+{
+	struct ksm_rmap_item *rmap_item;
+
+	/* lookup if we have a old rmap_item matching the addr*/
+	rmap_item = try_to_get_old_rmap_item(addr, rmap_list);
+	if (rmap_item)
+		return rmap_item;
+
+	/* Need to allocate a new rmap_item */
 	rmap_item = alloc_rmap_item();
 	if (rmap_item) {
 		/* It has already been zeroed */
-- 
2.15.2
