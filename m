Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AECD67F537
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 07:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjA1Gcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 01:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjA1Gcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 01:32:46 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C3279630
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 22:32:44 -0800 (PST)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4P3kz32VdVzJqM6;
        Sat, 28 Jan 2023 14:28:15 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 28 Jan 2023 14:32:40 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mawupeng1@huawei.com>, <kuleshovmail@gmail.com>,
        <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v3 4/4] mm/msync: return ENOMEM if len overflows for msync
Date:   Sat, 28 Jan 2023 14:32:29 +0800
Message-ID: <20230128063229.989058-5-mawupeng1@huawei.com>
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
Return -ENOMEM if len overflows for msync.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 mm/msync.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/msync.c b/mm/msync.c
index ac4c9bfea2e7..3104c97d70d3 100644
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -46,13 +46,16 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, len, int, flags)
 	if ((flags & MS_ASYNC) && (flags & MS_SYNC))
 		goto out;
 	error = -ENOMEM;
+	if (!len)
+		return 0;
+
 	len = (len + ~PAGE_MASK) & PAGE_MASK;
+	if (!len)
+		goto out;
+
 	end = start + len;
 	if (end < start)
 		goto out;
-	error = 0;
-	if (end == start)
-		goto out;
 	/*
 	 * If the interval [start,end) covers some unmapped address ranges,
 	 * just ignore them, but return -ENOMEM at the end. Besides, if the
-- 
2.25.1

