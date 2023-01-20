Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87543674965
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 03:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjATCgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 21:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjATCgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 21:36:20 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC30CAA5DF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 18:36:14 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NykC06Mgzz508D2;
        Fri, 20 Jan 2023 10:36:12 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
        by mse-fl1.zte.com.cn with SMTP id 30K2a7LV064230;
        Fri, 20 Jan 2023 10:36:07 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
        by mapi (Zmail) with MAPI id mid14;
        Fri, 20 Jan 2023 10:36:09 +0800 (CST)
Date:   Fri, 20 Jan 2023 10:36:09 +0800 (CST)
X-Zmail-TransId: 2b0663c9fe19ffffffff8dd475c6
X-Mailer: Zmail v1.0
Message-ID: <202301201036092738081@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <mike.kravetz@oracle.com>, <muchun.song@linux.dev>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <sidhartha.kumar@oracle.com>, <akpm@linux-foundation.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIG1tL2h1Z2V0bGI6IHJlcGxhY2UgZ2V0X2h3cG9pc29uX2h1Z2VfcGFnZSgpIHdpdGggZ2V0X2h3cG9pc29uX2h1Z2V0bGJfZm9saW8oKSB3aGVuwqAhQ09ORklHX0hVR0VUTEJGUw==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 30K2a7LV064230
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63C9FE1C.000 by FangMail milter!
X-FangMail-Envelope: 1674182172/4NykC06Mgzz508D2/63C9FE1C.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63C9FE1C.000/4NykC06Mgzz508D2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

When CONFIG_HUGETLBFS is not set, there are two problems. One
is implicit declaration of function get_hwpoison_hugetlb_folio(),
the other is get_hwpoison_huge_page() is defined but not used.
Fix them all by defining get_hwpoison_hugetlb_folio() instead of
get_hwpoison_huge_page() when !CONFIG_HUGETLB_PAGE.

Fixes: 92e109a2c5a7 ("mm/hugetlb: convert get_hwpoison_huge_page() to folios")
Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 include/linux/hugetlb.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f14a6bd2a6ed..9189cc359c64 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -417,7 +417,8 @@ static inline int isolate_hugetlb(struct folio *folio, struct list_head *list)
 	return -EBUSY;
 }

-static inline int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison)
+static inline int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb,
+			bool unpoison)
 {
 	return 0;
 }
-- 
2.25.1
