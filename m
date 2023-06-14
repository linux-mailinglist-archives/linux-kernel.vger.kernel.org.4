Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949CD72FBE5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbjFNLEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236214AbjFNLDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:03:44 -0400
Received: from out-62.mta1.migadu.com (out-62.mta1.migadu.com [95.215.58.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8069A1BE5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:03:42 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686740617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JUAXO3nF4TYUh7G4bGQ31E/7+rub4uhiLNTBrM2ujC8=;
        b=P06EKQSYiSzPJZCUwYNF5LhDGDRkWumiodO74KPIgoDsJrSSb2UrF6A7dqnDxkcI4mWLjI
        nb9+BJDG2syeWPi7IUgLgHswlfW/eBUTP6IOeABhyIBQQry9VGuTvpKhY+7YUZVYrZN8jH
        k9zNpZiJ+8Ve3g+BfGPpBFZezTn8LhM=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mm/mm_init.c: remove spinlock in early_pfn_to_nid()
Date:   Wed, 14 Jun 2023 19:03:24 +0800
Message-Id: <20230614110324.3839354-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the system boots, only one cpu is enabled before smp_init().
So the spinlock is not needed in most cases, remove it.

Add spinlock in get_nid_for_pfn() because it is after smp_init().

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 drivers/base/node.c | 11 +++++++++--
 mm/mm_init.c        | 18 +++---------------
 2 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 9de524e56307..844102570ff2 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -748,8 +748,15 @@ int unregister_cpu_under_node(unsigned int cpu, unsigned int nid)
 static int __ref get_nid_for_pfn(unsigned long pfn)
 {
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
-	if (system_state < SYSTEM_RUNNING)
-		return early_pfn_to_nid(pfn);
+	static DEFINE_SPINLOCK(early_pfn_lock);
+	int nid;
+
+	if (system_state < SYSTEM_RUNNING) {
+		spin_lock(&early_pfn_lock);
+		nid = early_pfn_to_nid(pfn);
+		spin_unlock(&early_pfn_lock);
+		return nid;
+	}
 #endif
 	return pfn_to_nid(pfn);
 }
diff --git a/mm/mm_init.c b/mm/mm_init.c
index d393631599a7..5895a30435ee 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -584,11 +584,11 @@ struct mminit_pfnnid_cache {
 static struct mminit_pfnnid_cache early_pfnnid_cache __meminitdata;
 
 /*
- * Required by SPARSEMEM. Given a PFN, return what node the PFN is on.
+ * Given a PFN, return what node the PFN is on.
  */
-static int __meminit __early_pfn_to_nid(unsigned long pfn,
-					struct mminit_pfnnid_cache *state)
+int __meminit early_pfn_to_nid(unsigned long pfn)
 {
+	struct mminit_pfnnid_cache *state = &early_pfnnid_cache;
 	unsigned long start_pfn, end_pfn;
 	int nid;
 
@@ -601,20 +601,8 @@ static int __meminit __early_pfn_to_nid(unsigned long pfn,
 		state->last_end = end_pfn;
 		state->last_nid = nid;
 	}
-
-	return nid;
-}
-
-int __meminit early_pfn_to_nid(unsigned long pfn)
-{
-	static DEFINE_SPINLOCK(early_pfn_lock);
-	int nid;
-
-	spin_lock(&early_pfn_lock);
-	nid = __early_pfn_to_nid(pfn, &early_pfnnid_cache);
 	if (nid < 0)
 		nid = first_online_node;
-	spin_unlock(&early_pfn_lock);
 
 	return nid;
 }
-- 
2.25.1

