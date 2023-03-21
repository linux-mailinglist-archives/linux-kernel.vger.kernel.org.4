Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB626C2C73
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCUIcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjCUIcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:32:07 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBDF6A73
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:31:10 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by michel.telenet-ops.be with bizsmtp
        id awX12900E1C8whw06wX1Zd; Tue, 21 Mar 2023 09:31:08 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1peXNr-00E6VQ-Gp;
        Tue, 21 Mar 2023 09:31:01 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1peXOX-007g6A-62;
        Tue, 21 Mar 2023 09:31:01 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] mm/slab: Fix undefined init_cache_node_node() for NUMA and !SMP
Date:   Tue, 21 Mar 2023 09:30:59 +0100
Message-Id: <67261c513706241d479b8b4cf46eb4e6fb0417ba.1679387262.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sh/migor_defconfig:

    mm/slab.c: In function ‘slab_memory_callback’:
    mm/slab.c:1127:23: error: implicit declaration of function ‘init_cache_node_node’; did you mean ‘drain_cache_node_node’? [-Werror=implicit-function-declaration]
     1127 |                 ret = init_cache_node_node(nid);
	  |                       ^~~~~~~~~~~~~~~~~~~~
	  |                       drain_cache_node_node

The #ifdef condition protecting the definition of init_cache_node_node()
no longer matches the conditions protecting the (multiple) users.

Fix this by syncing the conditions.

Fixes: 76af6a054da40553 ("mm/migrate: add CPU hotplug to demotion #ifdef")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/r/b5bdea22-ed2f-3187-6efe-0c72330270a4@infradead.org
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 mm/slab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab.c b/mm/slab.c
index ba454246ee13dd4d..de1523a78f2e7367 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -839,7 +839,7 @@ static int init_cache_node(struct kmem_cache *cachep, int node, gfp_t gfp)
 	return 0;
 }
 
-#if (defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)) || defined(CONFIG_SMP)
+#if defined(CONFIG_NUMA) || defined(CONFIG_SMP)
 /*
  * Allocates and initializes node for a node on each slab cache, used for
  * either memory or cpu hotplug.  If memory is being hot-added, the kmem_cache_node
-- 
2.34.1

