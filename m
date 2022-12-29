Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C5B6589E6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 08:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiL2HRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 02:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiL2HRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 02:17:39 -0500
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA84E24F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 23:17:37 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 80B701A00931;
        Thu, 29 Dec 2022 15:17:44 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id URFiTjXp3l3C; Thu, 29 Dec 2022 15:17:43 +0800 (CST)
Received: from kernel.localdomain (unknown [219.141.250.2])
        (Authenticated sender: lvqian@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id B1BF81A0092A;
        Thu, 29 Dec 2022 15:17:43 +0800 (CST)
From:   lvqian@nfschina.com
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        lvqian <lvqian@nfschina.com>
Subject: [PATCH] mm/page_alloc.c: Remove function return value
Date:   Thu, 29 Dec 2022 15:17:30 +0800
Message-Id: <20221229071730.174444-1-lvqian@nfschina.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lvqian <lvqian@nfschina.com>

The return value of this function has no meaning,
so the original int type is replaced with a void type,
which reduces the execution time of one return.

Signed-off-by: lvqian <lvqian@nfschina.com>
---
 mm/page_alloc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0745aedebb37..fffe16d854a9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -828,17 +828,16 @@ static int __init early_debug_pagealloc(char *buf)
 }
 early_param("debug_pagealloc", early_debug_pagealloc);
 
-static int __init debug_guardpage_minorder_setup(char *buf)
+static void __init debug_guardpage_minorder_setup(char *buf)
 {
 	unsigned long res;
 
 	if (kstrtoul(buf, 10, &res) < 0 ||  res > MAX_ORDER / 2) {
 		pr_err("Bad debug_guardpage_minorder value\n");
-		return 0;
+	} else {
+		_debug_guardpage_minorder = res;
+		pr_info("Setting debug_guardpage_minorder to %lu\n", res);
 	}
-	_debug_guardpage_minorder = res;
-	pr_info("Setting debug_guardpage_minorder to %lu\n", res);
-	return 0;
 }
 early_param("debug_guardpage_minorder", debug_guardpage_minorder_setup);
 
-- 
2.34.1

