Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BDF632A81
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiKURMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiKURMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:12:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CB4CE9DA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:12:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 15D30220D1;
        Mon, 21 Nov 2022 17:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669050731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jdtJevUfKFpur3mHBr5toAQMEnA3Zpl/FSyOEJ3hxb4=;
        b=oA2ggNUI6fF0SsaSV4V/A2Sxe7Vd2+DBkLUa3690zSiTrqO8Aga92oF54EPtwfqxLYoie/
        DY3yvh8hAh4kLpOZMxG/jb34xmn+FyKHVKabi2e7yCbjwJ88ZU/71+8vPKUldFvMqyjtAb
        ktd3CQpxc/WckHocsEgVGNhm7hRFhG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669050731;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jdtJevUfKFpur3mHBr5toAQMEnA3Zpl/FSyOEJ3hxb4=;
        b=3/jntdVvQT0EpMHLXt5ERtf8cfleYLhtlr/mNu7GPDDF89TxcaQxSwuekc6lo6qqOM8c29
        6mEe9L08sDd5U4Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE7F813B03;
        Mon, 21 Nov 2022 17:12:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8FW2NWqxe2MQeQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 21 Nov 2022 17:12:10 +0000
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
Subject: [PATCH 03/12] mm, slub: disable SYSFS support with CONFIG_SLUB_TINY
Date:   Mon, 21 Nov 2022 18:11:53 +0100
Message-Id: <20221121171202.22080-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221121171202.22080-1-vbabka@suse.cz>
References: <20221121171202.22080-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently SLUB enables its sysfs support depending unconditionally on
the general CONFIG_SYSFS setting. To reduce the configuration
combination space, make CONFIG_SLUB_TINY disable SLUB's sysfs support by
reusing the existing SLAB_SUPPORTS_SYSFS define. It is unlikely that
real tiny systems would combine CONFIG_SLUB_TINY with CONFIG_SYSFS, but
a randconfig might.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slub_def.h |  2 +-
 mm/slub.c                | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index f9c68a9dac04..c186f25c8148 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -142,7 +142,7 @@ struct kmem_cache {
 	struct kmem_cache_node *node[MAX_NUMNODES];
 };
 
-#ifdef CONFIG_SYSFS
+#if defined(CONFIG_SYSFS) && !defined(CONFIG_SLUB_TINY)
 #define SLAB_SUPPORTS_SYSFS
 void sysfs_slab_unlink(struct kmem_cache *);
 void sysfs_slab_release(struct kmem_cache *);
diff --git a/mm/slub.c b/mm/slub.c
index 157527d7101b..ab085aa2f1f0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -298,7 +298,7 @@ struct track {
 
 enum track_item { TRACK_ALLOC, TRACK_FREE };
 
-#ifdef CONFIG_SYSFS
+#ifdef SLAB_SUPPORTS_SYSFS
 static int sysfs_slab_add(struct kmem_cache *);
 static int sysfs_slab_alias(struct kmem_cache *, const char *);
 #else
@@ -2935,7 +2935,7 @@ static noinline void free_debug_processing(
 }
 #endif /* CONFIG_SLUB_DEBUG */
 
-#if defined(CONFIG_SLUB_DEBUG) || defined(CONFIG_SYSFS)
+#if defined(CONFIG_SLUB_DEBUG) || defined(SLAB_SUPPORTS_SYSFS)
 static unsigned long count_partial(struct kmem_cache_node *n,
 					int (*get_count)(struct slab *))
 {
@@ -2949,7 +2949,7 @@ static unsigned long count_partial(struct kmem_cache_node *n,
 	spin_unlock_irqrestore(&n->list_lock, flags);
 	return x;
 }
-#endif /* CONFIG_SLUB_DEBUG || CONFIG_SYSFS */
+#endif /* CONFIG_SLUB_DEBUG || SLAB_SUPPORTS_SYSFS */
 
 static noinline void
 slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid)
@@ -4924,7 +4924,7 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
 	return 0;
 }
 
-#ifdef CONFIG_SYSFS
+#ifdef SLAB_SUPPORTS_SYSFS
 static int count_inuse(struct slab *slab)
 {
 	return slab->inuse;
@@ -5182,7 +5182,7 @@ static void process_slab(struct loc_track *t, struct kmem_cache *s,
 #endif  /* CONFIG_DEBUG_FS   */
 #endif	/* CONFIG_SLUB_DEBUG */
 
-#ifdef CONFIG_SYSFS
+#ifdef SLAB_SUPPORTS_SYSFS
 enum slab_stat_type {
 	SL_ALL,			/* All slabs */
 	SL_PARTIAL,		/* Only partially allocated slabs */
@@ -6056,7 +6056,7 @@ static int __init slab_sysfs_init(void)
 }
 
 __initcall(slab_sysfs_init);
-#endif /* CONFIG_SYSFS */
+#endif /* SLAB_SUPPORTS_SYSFS */
 
 #if defined(CONFIG_SLUB_DEBUG) && defined(CONFIG_DEBUG_FS)
 static int slab_debugfs_show(struct seq_file *seq, void *v)
-- 
2.38.1

