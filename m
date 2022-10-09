Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5C45F8943
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 05:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJIDmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 23:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJIDmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 23:42:37 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9615E2ED50
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 20:42:36 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 5ABC81E80CE4;
        Sun,  9 Oct 2022 11:36:41 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5QaQ9NT3s5V9; Sun,  9 Oct 2022 11:36:38 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: xupengfei@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id B43F41E80CAE;
        Sun,  9 Oct 2022 11:36:38 +0800 (CST)
From:   XU pengfei <xupengfei@nfschina.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        XU pengfei <xupengfei@nfschina.com>
Subject: [PATCH 1/1] mm/mmap_lock: Remove unnecessary 'NULL' values from Pointer
Date:   Sun,  9 Oct 2022 11:41:54 +0800
Message-Id: <20221009034153.4418-1-xupengfei@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary 'NULL' values from Pointer and goto statement

Signed-off-by: XU pengfei <xupengfei@nfschina.com>
---
 mm/mmap_lock.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 1854850b4b89..d0c2a5eae341 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -198,23 +198,24 @@ void trace_mmap_lock_unreg(void)
  */
 static const char *get_mm_memcg_path(struct mm_struct *mm)
 {
-	char *buf = NULL;
+	char *buf;
 	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
 
 	if (memcg == NULL)
-		goto out;
-	if (unlikely(memcg->css.cgroup == NULL))
-		goto out_put;
+		return NULL;
+	if (unlikely(memcg->css.cgroup == NULL)) {
+		css_put(&memcg->css);
+		return NULL;
+	}
 
 	buf = get_memcg_path_buf();
-	if (buf == NULL)
-		goto out_put;
+	if (buf == NULL) {
+		css_put(&memcg->css);
+		return NULL;
+	}
 
 	cgroup_path(memcg->css.cgroup, buf, MEMCG_PATH_BUF_SIZE);
 
-out_put:
-	css_put(&memcg->css);
-out:
 	return buf;
 }
 
-- 
2.18.2

