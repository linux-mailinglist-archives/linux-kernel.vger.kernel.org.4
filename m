Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD7C6C05EC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 23:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjCSWCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 18:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjCSWB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 18:01:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEE11D93B;
        Sun, 19 Mar 2023 15:01:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A082611D2;
        Sun, 19 Mar 2023 22:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5F9C4339C;
        Sun, 19 Mar 2023 22:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679263269;
        bh=5aEejQ7EtQqthblpiGHnkd6ifM5j2LwwZNCKwxJWY2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dj21oSvT9z3Ed9zQIOuVK5nwGGD/EqvV3Ixx7fZIDmTRlNnvvymwFxLdN5KS3CH8q
         HhMFUzoMLbKZVndGPuSqJws8OHtUTpsZ9y58wSjxo6Oes/hMdNBSkYmU2PprTeM6IY
         L0T2LHC76nu/Jf7wcAlQm8TrrzbbBtCC+k0KaMLeLH8c9syUdRBiCmhAfOQb2BeTJA
         nEKy78SUkn77LVx3EeUxphJS8tyk9/Qa6akui/E05DL/u7ZY60jAP5R2NT725QsSk+
         4lTdsTiMaMrCi8nhfQgQmSe0DKpKsElEDrQ/GzdER+v3axyyhzfi3QjSy3TIZF5JLB
         TLU2fUa0TYLUg==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 13/15] mm: move kmem_cache_init() declaration to mm/slab.h
Date:   Mon, 20 Mar 2023 00:00:06 +0200
Message-Id: <20230319220008.2138576-14-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230319220008.2138576-1-rppt@kernel.org>
References: <20230319220008.2138576-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

kmem_cache_init() is called only from mm_core_init(), there is no need
to declare it in include/linux/slab.h

Move kmem_cache_init() declaration to mm/slab.h

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/slab.h | 1 -
 mm/mm_init.c         | 1 +
 mm/slab.h            | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index aa4575ef2965..f8b1d63c63a3 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -167,7 +167,6 @@ struct mem_cgroup;
 /*
  * struct kmem_cache related prototypes
  */
-void __init kmem_cache_init(void);
 bool slab_is_available(void);
 
 struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 73964449669e..78b2366e4407 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -27,6 +27,7 @@
 #include <linux/swap.h>
 #include <linux/cma.h>
 #include "internal.h"
+#include "slab.h"
 #include "shuffle.h"
 
 #include <asm/setup.h>
diff --git a/mm/slab.h b/mm/slab.h
index 43966aa5fadf..3f8df2244f5a 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -4,6 +4,7 @@
 /*
  * Internal slab definitions
  */
+void __init kmem_cache_init(void);
 
 /* Reuses the bits in struct page */
 struct slab {
-- 
2.35.1

