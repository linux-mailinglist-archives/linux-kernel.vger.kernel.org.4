Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD8C67F536
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 07:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjA1Gcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 01:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjA1Gcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 01:32:46 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37372166FA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 22:32:44 -0800 (PST)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4P3kz26ScqzJqXP;
        Sat, 28 Jan 2023 14:28:14 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 28 Jan 2023 14:32:39 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mawupeng1@huawei.com>, <kuleshovmail@gmail.com>,
        <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v3 3/4] mm/mempolicy: return EINVAL if len overflows for mbind
Date:   Sat, 28 Jan 2023 14:32:28 +0800
Message-ID: <20230128063229.989058-4-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230128063229.989058-1-mawupeng1@huawei.com>
References: <20230128063229.989058-1-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
index 85c5d3c2503b..7791be5a2677 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1275,13 +1275,16 @@ static long do_mbind(unsigned long start, unsigned long len,
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

