Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFB56C37C9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjCURHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCURGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:06:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BAC25E30;
        Tue, 21 Mar 2023 10:06:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73E9E61D4C;
        Tue, 21 Mar 2023 17:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794FDC433D2;
        Tue, 21 Mar 2023 17:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679418375;
        bh=kFzPprUJrZrfMtq8aGTwnrimjjzrha/o2lraF+v8D9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b7ru+LHiDI2SJfh3/MIunocj7ElHYcDVIn5YPlQ+OOQlPpzyd/kWXiKMFB17fP9C8
         lScS5MaSKccD3ZQRyYv+VFk5QAlIZ9zWBVhIkixa/oX9YGaz+uKlOZ40U9jWItJYyo
         o4PXtvDXC7tdpx2lI+8fUkY2de3E4JdJBhuxTcLAWv9S2alCYB0fYVqXIpMYQD75+u
         XKvvJNZQPEbDMqTELVDfSny//kdykc5pl5pcNxdQliTldaCR8o0YqsFL4UKJBaZoA2
         hp0evxwIQG89CQKscRQp521Xu2sIep1bzaWGs/Q87zcYy8epu6Xk5MJV43PP5DJmoQ
         U0k1viABjv4aQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Doug Berger <opendmb@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 12/14] mm: move kmem_cache_init() declaration to mm/slab.h
Date:   Tue, 21 Mar 2023 19:05:11 +0200
Message-Id: <20230321170513.2401534-13-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230321170513.2401534-1-rppt@kernel.org>
References: <20230321170513.2401534-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
Reviewed-by: David Hildenbrand <david@redhat.com>
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
index 8adadf51bbd2..53fb8e9d1e3b 100644
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

