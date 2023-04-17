Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8EF6E45BF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjDQKvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjDQKvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:51:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F655BB7;
        Mon, 17 Apr 2023 03:50:12 -0700 (PDT)
Date:   Mon, 17 Apr 2023 10:46:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681728406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lHCuVIKv9lJeUMV86l7lW7YN40YLX6EODBOItfrACTY=;
        b=jie2ZkFUYAIOb/ESCiCoALxlQiYXnlsxWvlcUgji4tRIiYEG4VRjfCZEFpW+Hfn4eec64N
        8vAyuIXsxmlUEW7JHUOFwBeBACprfDSeQJ2SaaHnwwDLSyESuZLFC3ggrruS2cv5aQctNs
        JDhbu52tBSAYxBvVj+zNy1EL38DNoqbzZjk/9O7dhyRq8OM03JAmhWuhXFObuDUd790QYV
        dH/AFkcxotigxvkR9IBh6bVkfSvQcJFghvkRAoKoQ13QUyvi+FU2TplASOO7Glb2NO218m
        rvZg2TxMZyljHOajR+6vTkGYd0FO69w8KtOrGFSAW+Eysp92EREm8lBv8OrM+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681728406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lHCuVIKv9lJeUMV86l7lW7YN40YLX6EODBOItfrACTY=;
        b=U9keWq0TBpKplrTDUBvfyDCcRRiQHQkvWhFapBRFh+sxSDCavPCrwn6QW66Pur9nVp0UFA
        RwNTYHuJERFiXvDg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] btrfs: Mark btrfs_assertfail() __noreturn
Cc:     kernel test robot <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <960bd9c0c9e3cfc409ba9c35a17644b11b832956.1681342859.git.jpoimboe@kernel.org>
References: <960bd9c0c9e3cfc409ba9c35a17644b11b832956.1681342859.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168172840624.404.13655279959647957415.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     09c5ae30d007514a1be870fa5873ad55c3319f3a
Gitweb:        https://git.kernel.org/tip/09c5ae30d007514a1be870fa5873ad55c3319f3a
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 12 Apr 2023 16:49:38 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Apr 2023 17:31:26 +02:00

btrfs: Mark btrfs_assertfail() __noreturn

Fixes a bunch of warnings including:

  vmlinux.o: warning: objtool: select_reloc_root+0x314: unreachable instruction
  vmlinux.o: warning: objtool: finish_inode_if_needed+0x15b1: unreachable instruction
  vmlinux.o: warning: objtool: get_bio_sector_nr+0x259: unreachable instruction
  vmlinux.o: warning: objtool: raid_wait_read_end_io+0xc26: unreachable instruction
  vmlinux.o: warning: objtool: raid56_parity_alloc_scrub_rbio+0x37b: unreachable instruction
  ...

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/960bd9c0c9e3cfc409ba9c35a17644b11b832956.1681342859.git.jpoimboe@kernel.org
---
 fs/btrfs/messages.c   | 2 +-
 fs/btrfs/messages.h   | 2 +-
 tools/objtool/check.c | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
index fde5aaa..310a05c 100644
--- a/fs/btrfs/messages.c
+++ b/fs/btrfs/messages.c
@@ -253,7 +253,7 @@ void __cold _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, 
 #endif
 
 #ifdef CONFIG_BTRFS_ASSERT
-void __cold btrfs_assertfail(const char *expr, const char *file, int line)
+void __cold __noreturn btrfs_assertfail(const char *expr, const char *file, int line)
 {
 	pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
 	BUG();
diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 8c516ee..ac2d198 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -160,7 +160,7 @@ do {								\
 } while (0)
 
 #ifdef CONFIG_BTRFS_ASSERT
-void __cold btrfs_assertfail(const char *expr, const char *file, int line);
+void __cold __noreturn btrfs_assertfail(const char *expr, const char *file, int line);
 
 #define ASSERT(expr)						\
 	(likely(expr) ? (void)0 : btrfs_assertfail(#expr, __FILE__, __LINE__))
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ae0c942..ceb9848 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -204,6 +204,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"__ubsan_handle_builtin_unreachable",
 		"arch_call_rest_init",
 		"arch_cpu_idle_dead",
+		"btrfs_assertfail",
 		"cpu_bringup_and_idle",
 		"cpu_startup_entry",
 		"do_exit",
