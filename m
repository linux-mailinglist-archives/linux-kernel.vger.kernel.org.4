Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5C46EB87F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 12:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjDVKQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 06:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjDVKPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 06:15:41 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0409E26B5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 03:15:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VgfnVJl_1682158527;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VgfnVJl_1682158527)
          by smtp.aliyun-inc.com;
          Sat, 22 Apr 2023 18:15:28 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     ying.huang@intel.com, mgorman@techsingularity.net, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm/page_alloc: drop the unnecessary pfn_valid() for start pfn
Date:   Sat, 22 Apr 2023 18:15:17 +0800
Message-Id: <c2eee65ecd15779721af85c9ff109a35345b52d4.1682158312.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've already used pfn_to_online_page() for start pfn to make sure
it is online and valid, so the pfn_valid() for the start pfn is
unnecessary, drop it.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9de2a18519a1..6457b64fe562 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1512,7 +1512,7 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
 	/* end_pfn is one past the range we are checking */
 	end_pfn--;
 
-	if (!pfn_valid(start_pfn) || !pfn_valid(end_pfn))
+	if (!pfn_valid(end_pfn))
 		return NULL;
 
 	start_page = pfn_to_online_page(start_pfn);
-- 
2.27.0

