Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EDF6D7271
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 04:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbjDEC1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 22:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjDEC1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 22:27:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A668F2697;
        Tue,  4 Apr 2023 19:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/zFMu+hCUyA4Z/2f84k8anH54tplY3/TfwT6JNMhL7g=; b=UjurHh14lS41LO3RhiYhdywUTf
        UEGL5ucwoWlBmR4Hh56vx44CPgIURTZMI+Sr8oPTudV3S1Fcxp4zufGjiC43e1ePkCMeBV+l4AuMR
        /+HFs3mc3aVXV+s66JFe+6Q3nYSF9IF1M+BCuEkQKFBiioYOWtcRJoNb48oOOKVL1vyQ/p9WNnNGT
        M1J7y9MPKOwQFj8/Ye23sAKx2zZsk+zHocAPyVlq99hFg8XUnbHmBDmqfPWdZIwMpN6ewNhd05eox
        KXhCOHRNjv2ytJo4Vf9IuwS/F8EH6fnRFtdknAq6LH8q7YYuzEuerM5aoWv6Vlxk+d6vKujoj8nKh
        vMShxgIA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjsrb-003A05-1W;
        Wed, 05 Apr 2023 02:27:07 +0000
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
Subject: [PATCH v2 1/6] module: fix kmemleak annotations for non init ELF sections
Date:   Tue,  4 Apr 2023 19:26:57 -0700
Message-Id: <20230405022702.753323-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230405022702.753323-1-mcgrof@kernel.org>
References: <20230405022702.753323-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ac3b43283923 ("module: replace module_layout with module_memory")
reworked the way to handle memory allocations to make it clearer. But it
lost in translation how we handled kmemleak_ignore() or kmemleak_not_leak()
for different ELF sections.

Fix this and clarify the comments a bit more.

Fixes: ac3b43283923 ("module: replace module_layout with module_memory")
Reported-by: Jim Cromie <jim.cromie@gmail.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5cc21083af04..d8bb23fa6989 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2233,11 +2233,23 @@ static int move_module(struct module *mod, struct load_info *info)
 		ptr = module_memory_alloc(mod->mem[type].size, type);
 
 		/*
-		 * The pointer to this block is stored in the module structure
-		 * which is inside the block. Just mark it as not being a
-		 * leak.
+		 * The pointer to these blocks of memory are stored on the module
+		 * structure and we keep that around so long as the module is
+		 * around. We only free that memory when we unload the module.
+		 * Just mark them as not being a leak then. The .init* ELF
+		 * sections *do* get freed after boot so we treat them slightly
+		 * differently and only grey them out -- they work as typical
+		 * memory allocations which *do* eventually get freed.
 		 */
-		kmemleak_ignore(ptr);
+		switch (type) {
+		case MOD_INIT_TEXT: /* fallthrough */
+		case MOD_INIT_DATA: /* fallthrough */
+		case MOD_INIT_RODATA: /* fallthrough */
+			kmemleak_ignore(ptr);
+			break;
+		default:
+			kmemleak_not_leak(ptr);
+		}
 		if (!ptr) {
 			t = type;
 			goto out_enomem;
-- 
2.39.2

