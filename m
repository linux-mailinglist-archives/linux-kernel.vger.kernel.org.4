Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE916589E4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 08:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiL2HRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 02:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiL2HQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 02:16:57 -0500
X-Greylist: delayed 211 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Dec 2022 23:16:55 PST
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D610224F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 23:16:55 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id DD43D1A00935;
        Thu, 29 Dec 2022 15:13:28 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YN6QHQj31uzm; Thu, 29 Dec 2022 15:13:28 +0800 (CST)
Received: from kernel.localdomain (unknown [219.141.250.2])
        (Authenticated sender: lvqian@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 14CD61A0092A;
        Thu, 29 Dec 2022 15:13:28 +0800 (CST)
From:   lvqian@nfschina.com
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        lvqian <lvqian@nfschina.com>
Subject: [PATCH] mm/page_alloc.c: Remove function return value
Date:   Thu, 29 Dec 2022 15:13:18 +0800
Message-Id: <20221229071318.174109-1-lvqian@nfschina.com>
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
so the original bool type is replaced with a void type, 
which reduces the execution time of one return.

Signed-off-by: lvqian <lvqian@nfschina.com>
---
 mm/page_alloc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0745aedebb37..5304bd5d2f6c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -834,11 +834,10 @@ static int __init debug_guardpage_minorder_setup(char *buf)
 
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

