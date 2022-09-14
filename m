Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52ED65B7E36
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 03:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiINBV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 21:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiINBVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:21:55 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC9F165569
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 18:21:53 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 8CD771E80D5E;
        Wed, 14 Sep 2022 09:19:34 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ifbq9yNsUG8n; Wed, 14 Sep 2022 09:19:32 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: xupengfei@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id B06711E80D58;
        Wed, 14 Sep 2022 09:19:31 +0800 (CST)
From:   XU pengfei <xupengfei@nfschina.com>
To:     mike.kravetz@oracle.com, songmuchun@bytedance.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        XU pengfei <xupengfei@nfschina.com>
Subject: [PATCH 1/1] mm/hugetlb: Remove unnecessary 'NULL' values from Pointer
Date:   Wed, 14 Sep 2022 09:21:14 +0800
Message-Id: <20220914012113.6271-1-xupengfei@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Pointer variables allocate memory first, and then judge. There is no
need to initialize the assignment.

Signed-off-by: XU pengfei <xupengfei@nfschina.com>
---
 mm/hugetlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e070b8593b37..a05f22b1ab1e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -257,7 +257,7 @@ static inline struct hugepage_subpool *subpool_vma(struct vm_area_struct *vma)
 static struct file_region *
 get_file_region_entry_from_cache(struct resv_map *resv, long from, long to)
 {
-	struct file_region *nrg = NULL;
+	struct file_region *nrg;
 
 	VM_BUG_ON(resv->region_cache_count <= 0);
 
@@ -339,7 +339,7 @@ static bool has_same_uncharge_info(struct file_region *rg,
 
 static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
 {
-	struct file_region *nrg = NULL, *prg = NULL;
+	struct file_region *nrg, *prg;
 
 	prg = list_prev_entry(rg, link);
 	if (&prg->link != &resv->regions && prg->to == rg->from &&
-- 
2.18.2

