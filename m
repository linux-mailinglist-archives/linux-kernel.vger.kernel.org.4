Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF5A5F849F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 11:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiJHJkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 05:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJHJkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 05:40:16 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2C1D3DBF9
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 02:40:14 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 3BB601E80D72;
        Sat,  8 Oct 2022 17:34:27 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bxIa5yYX8fkl; Sat,  8 Oct 2022 17:34:24 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: xupengfei@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 724261E80D4D;
        Sat,  8 Oct 2022 17:34:24 +0800 (CST)
From:   XU pengfei <xupengfei@nfschina.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        XU pengfei <xupengfei@nfschina.com>
Subject: [PATCH 1/1] mm/mmap_lock: Remove unnecessary 'NULL' values from Pointer
Date:   Sat,  8 Oct 2022 17:39:43 +0800
Message-Id: <20221008093942.3982-1-xupengfei@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer variables allocate memory first, and then judge. There is no
need to initialize the assignment.

Signed-off-by: XU pengfei <xupengfei@nfschina.com>
---
 mm/mmap_lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 1854850b4b89..65a57731aa15 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -198,7 +198,7 @@ void trace_mmap_lock_unreg(void)
  */
 static const char *get_mm_memcg_path(struct mm_struct *mm)
 {
-	char *buf = NULL;
+	char *buf;
 	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
 
 	if (memcg == NULL)
-- 
2.18.2

