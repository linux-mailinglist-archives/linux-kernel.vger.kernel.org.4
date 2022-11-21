Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA28632A78
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiKURMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiKURMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:12:15 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838DCCC142
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:12:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DAF4E220BD;
        Mon, 21 Nov 2022 17:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669050730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LiNIx3D+Vcqg/oY9PQmVLgvvCSLDF2Y8YpP6qaxgdmQ=;
        b=LPKd/io8qKI9K8EVw1r7vw2cy1PMA7Kwg6zn0iDq6kJHW5T8swTh27ag8LKyXvwjda1rbG
        ltPXt0gGx55SaIlg+ElNJXJWohazAtUZvWqniSm5gZt5gX6895aJRDMgb8ydR8k+o8nja+
        MzbKnQSYnFGrW9m2Iy81tDRhhu7a5Dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669050730;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LiNIx3D+Vcqg/oY9PQmVLgvvCSLDF2Y8YpP6qaxgdmQ=;
        b=vV+8DIg+0WjsTwBQs+6XsipNzWjMdZc2I2kHsyMeo4zoE2ygokXewN4JweFLNzXHAo0Su2
        CavHWb6InA0DkQBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0CAC1377F;
        Mon, 21 Nov 2022 17:12:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cC6MKmqxe2MQeQAAMHmgww
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
Subject: [PATCH 02/12] mm, slub: add CONFIG_SLUB_TINY
Date:   Mon, 21 Nov 2022 18:11:52 +0100
Message-Id: <20221121171202.22080-3-vbabka@suse.cz>
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

For tiny systems that have used SLOB until now, SLUB might be
impractical due to its higher memory usage. To help with that, introduce
an option CONFIG_SLUB_TINY that modifies SLUB to use less memory.
This is done by sacrificing scalability, security and debugging
features, therefore not recommended for any system with more than 16MB
RAM.

This commit introduces the option and uses it to set other related
options in a way that reduces memory usage.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/Kconfig       | 21 +++++++++++++++++----
 mm/Kconfig.debug |  2 +-
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 57e1d8c5b505..5941cb34e30d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -230,6 +230,19 @@ config SLOB
 
 endchoice
 
+config SLUB_TINY
+	bool "Configure SLUB for minimal memory footprint"
+	depends on SLUB && EXPERT
+	select SLAB_MERGE_DEFAULT
+	help
+	   Configures the SLUB allocator in a way to achieve minimal memory
+	   footprint, sacrificing scalability, debugging and other features.
+	   This is intended only for the smallest system that had used the
+	   SLOB allocator and is not recommended for systems with more than
+	   16MB RAM.
+
+	   If unsure, say N.
+
 config SLAB_MERGE_DEFAULT
 	bool "Allow slab caches to be merged"
 	default y
@@ -247,7 +260,7 @@ config SLAB_MERGE_DEFAULT
 
 config SLAB_FREELIST_RANDOM
 	bool "Randomize slab freelist"
-	depends on SLAB || SLUB
+	depends on SLAB || SLUB && !SLUB_TINY
 	help
 	  Randomizes the freelist order used on creating new pages. This
 	  security feature reduces the predictability of the kernel slab
@@ -255,7 +268,7 @@ config SLAB_FREELIST_RANDOM
 
 config SLAB_FREELIST_HARDENED
 	bool "Harden slab freelist metadata"
-	depends on SLAB || SLUB
+	depends on SLAB || SLUB && !SLUB_TINY
 	help
 	  Many kernel heap attacks try to target slab cache metadata and
 	  other infrastructure. This options makes minor performance
@@ -267,7 +280,7 @@ config SLAB_FREELIST_HARDENED
 config SLUB_STATS
 	default n
 	bool "Enable SLUB performance statistics"
-	depends on SLUB && SYSFS
+	depends on SLUB && SYSFS && !SLUB_TINY
 	help
 	  SLUB statistics are useful to debug SLUBs allocation behavior in
 	  order find ways to optimize the allocator. This should never be
@@ -279,7 +292,7 @@ config SLUB_STATS
 
 config SLUB_CPU_PARTIAL
 	default y
-	depends on SLUB && SMP
+	depends on SLUB && SMP && !SLUB_TINY
 	bool "SLUB per cpu partial cache"
 	help
 	  Per cpu partial caches accelerate objects allocation and freeing
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index ce8dded36de9..fca699ad1fb0 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -56,7 +56,7 @@ config DEBUG_SLAB
 config SLUB_DEBUG
 	default y
 	bool "Enable SLUB debugging support" if EXPERT
-	depends on SLUB && SYSFS
+	depends on SLUB && SYSFS && !SLUB_TINY
 	select STACKDEPOT if STACKTRACE_SUPPORT
 	help
 	  SLUB has extensive debug support features. Disabling these can
-- 
2.38.1

