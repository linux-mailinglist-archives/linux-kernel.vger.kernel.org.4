Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E8D632A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiKURM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiKURMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:12:15 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8437DCEFDE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:12:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 46D35220D3;
        Mon, 21 Nov 2022 17:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669050731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AE6b9Ip1Jv26Xwgek6onVQxbl/nnvniL1XqPDrcyQQ0=;
        b=1/VTn6d3nJ/r68CevB7e+wCDMbxnR2MTtiL6t4eG83n1/xPF5FDa5TmLbvbToZhzqKsJsG
        l1H1iDYpN0lQy3MhKDXrvHx79gVP4a2M9w5yso/OsBylq5lk7y6JIffE9GuiS/e/MVuRij
        9KhvvDaOCrn9Ol6Lx7067yqcmG2QFS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669050731;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AE6b9Ip1Jv26Xwgek6onVQxbl/nnvniL1XqPDrcyQQ0=;
        b=bBKuH2Y7eX+L9HTCPMnlLbK53G+n/K2K3+rWDVILDjbkeZm8pOwpFzT1RXpbmwxlkx6vMn
        KbqVlik0Z4wWhlBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1AB361377F;
        Mon, 21 Nov 2022 17:12:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EJ7dBWuxe2MQeQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 21 Nov 2022 17:12:11 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 04/12] mm, slub: retain no free slabs on partial list with CONFIG_SLUB_TINY
Date:   Mon, 21 Nov 2022 18:11:54 +0100
Message-Id: <20221121171202.22080-5-vbabka@suse.cz>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221121171202.22080-1-vbabka@suse.cz>
References: <20221121171202.22080-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SLUB will leave a number of slabs on the partial list even if they are
empty, to avoid some slab freeing and reallocation. The goal of
CONFIG_SLUB_TINY is to minimize memory overhead, so set the limits to 0
for immediate slab page freeing.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index ab085aa2f1f0..917b79278bad 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -241,6 +241,7 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
 /* Enable to log cmpxchg failures */
 #undef SLUB_DEBUG_CMPXCHG
 
+#ifndef CONFIG_SLUB_TINY
 /*
  * Minimum number of partial slabs. These will be left on the partial
  * lists even if they are empty. kmem_cache_shrink may reclaim them.
@@ -253,6 +254,10 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
  * sort the partial list by the number of objects in use.
  */
 #define MAX_PARTIAL 10
+#else
+#define MIN_PARTIAL 0
+#define MAX_PARTIAL 0
+#endif
 
 #define DEBUG_DEFAULT_FLAGS (SLAB_CONSISTENCY_CHECKS | SLAB_RED_ZONE | \
 				SLAB_POISON | SLAB_STORE_USER)
-- 
2.38.1

