Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4746770F415
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjEXKYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjEXKYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:24:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3065011D
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:23:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C39E2223D9;
        Wed, 24 May 2023 10:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684923837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hliaaV35ugS9mBcv4FyggOLg0wQ/iiY9Q3rhXXLm7AY=;
        b=OnzsDya3ECMF2LW6Tu/DQER+kYAv7897Jlj7xXn2quQ6zFhHc52EY2t73zWroFdhxnRlS8
        T0FQQgynmCyjp6WmPTUgows5xs+X177KlarU2SuH+TM+byVtXWtgxvH8lpKr9tMnUs4Efg
        /phot2QbYeGI56UFHOBRcLzZLJxv7Zs=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1B9BA2C141;
        Wed, 24 May 2023 10:23:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DE97ADA7D7; Wed, 24 May 2023 12:17:50 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH] mm/slab: add new flag SLAB_NO_MERGE to avoid merging per slab
Date:   Wed, 24 May 2023 12:17:48 +0200
Message-Id: <20230524101748.30714-1-dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a flag that allows to disable merging per slab. This can be used for
more fine grained control over the caches or for debugging builds where
separate slabs can verify that no objects leak.

The slab_nomerge boot option is too coarse and would need to be enabled
on all testing hosts. There are some other ways how to disable merging,
e.g. a slab constructor but this disables poisoning besides that it adds
additional overhead. Other flags are internal and may have other
semantics.

A concrete example what motivates the flag. During 'btrfs balance' slab
top reported huge increase in caches like

  1330095 1330095 100%    0.10K  34105       39    136420K Acpi-ParseExt
  1734684 1734684 100%    0.14K  61953       28    247812K pid_namespace
  8244036 6873075  83%    0.11K 229001       36    916004K khugepaged_mm_slot

which was confusing and that it's because of slab merging was not the
first idea.  After rebooting with slab_nomerge all the caches were from
btrfs_ namespace as expected.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 include/linux/slab.h | 3 +++
 mm/slab_common.c     | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 6b3e155b70bf..06b94dfbce65 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -106,6 +106,9 @@
 /* Avoid kmemleak tracing */
 #define SLAB_NOLEAKTRACE	((slab_flags_t __force)0x00800000U)
 
+/* Don't merge slab */
+#define SLAB_NO_MERGE		((slab_flags_t __force)0x01000000U)
+
 /* Fault injection mark */
 #ifdef CONFIG_FAILSLAB
 # define SLAB_FAILSLAB		((slab_flags_t __force)0x02000000U)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 607249785c07..0e0a617eae7d 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -47,7 +47,7 @@ static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
  */
 #define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
 		SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
-		SLAB_FAILSLAB | kasan_never_merge())
+		SLAB_FAILSLAB | SLAB_NO_MERGE | kasan_never_merge())
 
 #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
 			 SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
-- 
2.40.0

