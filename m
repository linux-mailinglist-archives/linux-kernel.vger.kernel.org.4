Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B405B6548
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 03:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiIMBzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 21:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiIMBzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 21:55:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285A5DF07
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 18:55:43 -0700 (PDT)
Received: from kwepemi500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MRRLj3DM5znV8Z;
        Tue, 13 Sep 2022 09:53:01 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemi500002.china.huawei.com (7.221.188.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 13 Sep 2022 09:55:40 +0800
From:   Ze Zuo <zuoze1@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>, ze zuo <zuoze1@huawei.com>
Subject: [PATCH-next] mm/mempolicy: use PAGE_ALIGN instead of open-coding it
Date:   Tue, 13 Sep 2022 01:55:05 +0000
Message-ID: <20220913015505.1998958-1-zuoze1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500002.china.huawei.com (7.221.188.171)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ze zuo <zuoze1@huawei.com>

Replace the simple calculation with PAGE_ALIGN.

Signed-off-by: ze zuo <zuoze1@huawei.com>
---
 mm/mempolicy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 143e2eaaa6ec..a937eaec5b68 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1270,7 +1270,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 	if (mode == MPOL_DEFAULT)
 		flags &= ~MPOL_MF_STRICT;
 
-	len = (len + PAGE_SIZE - 1) & PAGE_MASK;
+	len = PAGE_ALIGN(len);
 	end = start + len;
 
 	if (end < start)
@@ -1507,7 +1507,7 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
 	if (home_node >= MAX_NUMNODES || !node_online(home_node))
 		return -EINVAL;
 
-	len = (len + PAGE_SIZE - 1) & PAGE_MASK;
+	len = PAGE_ALIGN(len);
 	end = start + len;
 
 	if (end < start)
-- 
2.25.1

