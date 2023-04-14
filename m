Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C15A6E1B74
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 07:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjDNFIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 01:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjDNFIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:08:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319D244A8;
        Thu, 13 Apr 2023 22:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=d1P4Lb2k3WvTKxpPWQ0Fgfk0BiJfkVHvlpVmM1zJ91o=; b=DqwnBtWGV0bKq17zOTApZ3Ty3T
        udPqRDkRW1Jw8aPmWRpjpvoUlYqek3ute8vM6VwL9HTtizN7T8xk5JEKTWEwszDrd6Ea0xRhixqIe
        lSOkfft0VtkvePiEiL6sb0gtU+Mq4EzfC2g3HaoX9ze0a5otbhjpdGeWXTMPTCtk39do+8hqGXvZ8
        F4yu9B9GVNuQ0BqNTuxMdqZR6c2G/outr+fojM2z8JW+Nomy8VaHsZSkYBaujlaFpisBQPscw9sXm
        GKroLOlcDoKPwao7uq/9cPdYuPDIVREaqhWIOf/tE869yP7hbUcM10hHP9xfzJZNY8yupugCJc/UL
        HZ8rZI0g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnBfp-008KKH-1R;
        Fri, 14 Apr 2023 05:08:37 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, mcgrof@kernel.org
Subject: [PATCH v3 1/4] module: fix kmemleak annotations for non init ELF sections
Date:   Thu, 13 Apr 2023 22:08:33 -0700
Message-Id: <20230414050836.1984746-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230414050836.1984746-1-mcgrof@kernel.org>
References: <20230414050836.1984746-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ac3b43283923 ("module: replace module_layout with module_memory")
reworked the way to handle memory allocations to make it clearer. But it
lost in translation how we handled kmemleak_ignore() or kmemleak_not_leak()
for different ELF sections.

Fix this and clarify the comments a bit more. Contrary to the old way
of using kmemleak_ignore() for init.* ELF sections we stick now only to
kmemleak_not_leak() as per suggestion by Catalin Marinas so to avoid
any false positives and simplify the code.

Fixes: ac3b43283923 ("module: replace module_layout with module_memory")
Reported-by: Jim Cromie <jim.cromie@gmail.com>
Acked-by: Song Liu <song@kernel.org>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5cc21083af04..32554d8a5791 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2231,13 +2231,18 @@ static int move_module(struct module *mod, struct load_info *info)
 		}
 		mod->mem[type].size = PAGE_ALIGN(mod->mem[type].size);
 		ptr = module_memory_alloc(mod->mem[type].size, type);
-
 		/*
-		 * The pointer to this block is stored in the module structure
-		 * which is inside the block. Just mark it as not being a
-		 * leak.
+                 * The pointer to these blocks of memory are stored on the module
+                 * structure and we keep that around so long as the module is
+                 * around. We only free that memory when we unload the module.
+                 * Just mark them as not being a leak then. The .init* ELF
+                 * sections *do* get freed after boot so we *could* treat them
+                 * slightly differently with kmemleak_ignore() and only grey
+                 * them out as they work as typical memory allocations which
+                 * *do* eventually get freed, but let's just keep things simple
+                 * and avoid *any* false positives.
 		 */
-		kmemleak_ignore(ptr);
+		kmemleak_not_leak(ptr);
 		if (!ptr) {
 			t = type;
 			goto out_enomem;
-- 
2.39.2

