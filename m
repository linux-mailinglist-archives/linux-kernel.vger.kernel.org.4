Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553666C2B87
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjCUHlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjCUHk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:40:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA04B3B850
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:40:43 -0700 (PDT)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pgk411GCCzKsdc;
        Tue, 21 Mar 2023 15:38:25 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 15:40:40 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>, <david@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mawupeng1@huawei.com>, <kuleshovmail@gmail.com>,
        <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v5 3/4] mm/mempolicy: return EINVAL if len overflows for mbind
Date:   Tue, 21 Mar 2023 15:40:34 +0800
Message-ID: <20230321074035.1526157-4-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230321074035.1526157-1-mawupeng1@huawei.com>
References: <20230321074035.1526157-1-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ma Wupeng <mawupeng1@huawei.com>

Check and return 0 if len == 0 at the beginning of the function.
Return -EINVAL if len overflows for mbind.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 mm/mempolicy.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0a596c6cbed9..134fdc1f6c87 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1276,13 +1276,16 @@ static long do_mbind(unsigned long start, unsigned long len,
 	if (mode == MPOL_DEFAULT)
 		flags &= ~MPOL_MF_STRICT;
 
+	if (!len)
+		return 0;
+
 	len = PAGE_ALIGN(len);
-	end = start + len;
+	if (!len)
+		return -EINVAL;
 
+	end = start + len;
 	if (end < start)
 		return -EINVAL;
-	if (end == start)
-		return 0;
 
 	new = mpol_new(mode, mode_flags, nmask);
 	if (IS_ERR(new))
-- 
2.25.1

