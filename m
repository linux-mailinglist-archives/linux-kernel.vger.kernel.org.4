Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1269F70D50E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbjEWHdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbjEWHcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:32:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670D510CB;
        Tue, 23 May 2023 00:31:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7F80722770;
        Tue, 23 May 2023 07:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684827104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ZEzc5LOCCEl4X9/BHaKPnOKiEHFUp8WpILtxUD4qjNg=;
        b=12BbIW+5OtsAyqRSCvzLDYP3yElbsULJxVddqtKq/f2DjB9ngYqgGSk1x9aJAe2LFl0aT5
        Av9d/xS5Au9Xg+ZXIMYrhmFHYiLJMZCFs1T3yHyWNXlbzGZoY+BYaJLAPzbQ3Hl+NgON2n
        IfGbXRLe/wU9OxcQZ2tmlvn32ZeejU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684827104;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ZEzc5LOCCEl4X9/BHaKPnOKiEHFUp8WpILtxUD4qjNg=;
        b=JjwwBXLwGDpGwrmS1npS/eF+SP7rLitCKRX5eu3zbu10pCWZ8EHThUk1eJoi2X3/KY/Nwv
        RRAeMt35EdLTFWBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5222913588;
        Tue, 23 May 2023 07:31:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cr9ZE+BrbGRSIQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 23 May 2023 07:31:44 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] mm/slab: remove HAVE_HARDENED_USERCOPY_ALLOCATOR
Date:   Tue, 23 May 2023 09:31:36 +0200
Message-Id: <20230523073136.4900-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With SLOB removed, both remaining allocators support hardened usercopy,
so remove the config and associated #ifdef.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/Kconfig       | 2 --
 mm/slab.h        | 9 ---------
 security/Kconfig | 8 --------
 3 files changed, 19 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 7672a22647b4..041f0da42f2b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -221,7 +221,6 @@ choice
 config SLAB
 	bool "SLAB"
 	depends on !PREEMPT_RT
-	select HAVE_HARDENED_USERCOPY_ALLOCATOR
 	help
 	  The regular slab allocator that is established and known to work
 	  well in all environments. It organizes cache hot objects in
@@ -229,7 +228,6 @@ config SLAB
 
 config SLUB
 	bool "SLUB (Unqueued Allocator)"
-	select HAVE_HARDENED_USERCOPY_ALLOCATOR
 	help
 	   SLUB is a slab allocator that minimizes cache line usage
 	   instead of managing queues of cached objects (SLAB approach).
diff --git a/mm/slab.h b/mm/slab.h
index f01ac256a8f5..695ef96b4b5b 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -832,17 +832,8 @@ struct kmem_obj_info {
 void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab);
 #endif
 
-#ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR
 void __check_heap_object(const void *ptr, unsigned long n,
 			 const struct slab *slab, bool to_user);
-#else
-static inline
-void __check_heap_object(const void *ptr, unsigned long n,
-			 const struct slab *slab, bool to_user)
-{
-}
-#endif
-
 #ifdef CONFIG_SLUB_DEBUG
 void skip_orig_size_check(struct kmem_cache *s, const void *object);
 #endif
diff --git a/security/Kconfig b/security/Kconfig
index 97abeb9b9a19..52c9af08ad35 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -127,16 +127,8 @@ config LSM_MMAP_MIN_ADDR
 	  this low address space will need the permission specific to the
 	  systems running LSM.
 
-config HAVE_HARDENED_USERCOPY_ALLOCATOR
-	bool
-	help
-	  The heap allocator implements __check_heap_object() for
-	  validating memory ranges against heap object sizes in
-	  support of CONFIG_HARDENED_USERCOPY.
-
 config HARDENED_USERCOPY
 	bool "Harden memory copies between kernel and userspace"
-	depends on HAVE_HARDENED_USERCOPY_ALLOCATOR
 	imply STRICT_DEVMEM
 	help
 	  This option checks for obviously wrong memory regions when
-- 
2.40.1

