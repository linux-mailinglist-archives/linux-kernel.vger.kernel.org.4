Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28C768F381
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjBHQkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjBHQkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:40:35 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE0839B9A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 08:40:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 06F60CE2247
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 16:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A29C433D2;
        Wed,  8 Feb 2023 16:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675874425;
        bh=wo/uMi/XKqmv4ZfEoOSWzfRWU2jBLxW4mP+OJhOyZ2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q1mVQCj5l1GVpNB7Kz/TXLUj/sGQvi8ZPMLHBFoMpbCI8ebfhNAivUbJywKe175rQ
         bALfIw4nCofYgEs6piTnSGSdsEm8jDvdH4Fi7hUHrpwgz1jzJ0/qpiONTPMbdhMhfG
         lZymSFQ4arYPRqfeu7IycuYSeZxd5AVofIMCzFs2filiBmYlRv7RALWgeFBCtIYVHx
         q6H07blzaLAo2gzBWlOaCGXQyLNuh1ryaFSwEh1+bfuEGG2QMg3jE+KoeA4o8epStL
         EdOwr6QVCbwTH9HyqS5q3EmXl/NeHZxL2V9Nbwftx+Xujj4z5x9hyEXVu+AQ+IoYb2
         hyeGjbdlKaxsw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>
Cc:     kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] kmsan: disable ftrace in kmsan core code
Date:   Wed,  8 Feb 2023 17:39:56 +0100
Message-Id: <20230208164011.2287122-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208164011.2287122-1-arnd@kernel.org>
References: <20230208164011.2287122-1-arnd@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

objtool warns about some suspicous code inside of kmsan:

vmlinux.o: warning: objtool: __msan_metadata_ptr_for_load_n+0x4: call to __fentry__() with UACCESS enabled
vmlinux.o: warning: objtool: __msan_metadata_ptr_for_store_n+0x4: call to __fentry__() with UACCESS enabled
vmlinux.o: warning: objtool: __msan_metadata_ptr_for_load_1+0x4: call to __fentry__() with UACCESS enabled
vmlinux.o: warning: objtool: __msan_metadata_ptr_for_store_1+0x4: call to __fentry__() with UACCESS enabled
vmlinux.o: warning: objtool: __msan_metadata_ptr_for_load_2+0x4: call to __fentry__() with UACCESS enabled
vmlinux.o: warning: objtool: __msan_metadata_ptr_for_store_2+0x4: call to __fentry__() with UACCESS enabled
vmlinux.o: warning: objtool: __msan_metadata_ptr_for_load_4+0x4: call to __fentry__() with UACCESS enabled
vmlinux.o: warning: objtool: __msan_metadata_ptr_for_store_4+0x4: call to __fentry__() with UACCESS enabled
vmlinux.o: warning: objtool: __msan_metadata_ptr_for_load_8+0x4: call to __fentry__() with UACCESS enabled
vmlinux.o: warning: objtool: __msan_metadata_ptr_for_store_8+0x4: call to __fentry__() with UACCESS enabled
vmlinux.o: warning: objtool: __msan_instrument_asm_store+0x4: call to __fentry__() with UACCESS enabled
vmlinux.o: warning: objtool: __msan_chain_origin+0x4: call to __fentry__() with UACCESS enabled
vmlinux.o: warning: objtool: __msan_poison_alloca+0x4: call to __fentry__() with UACCESS enabled
vmlinux.o: warning: objtool: __msan_warning+0x4: call to __fentry__() with UACCESS enabled
vmlinux.o: warning: objtool: __msan_get_context_state+0x4: call to __fentry__() with UACCESS enabled
vmlinux.o: warning: objtool: kmsan_copy_to_user+0x4: call to __fentry__() with UACCESS enabled
vmlinux.o: warning: objtool: kmsan_unpoison_memory+0x4: call to __fentry__() with UACCESS enabled
vmlinux.o: warning: objtool: kmsan_unpoison_entry_regs+0x4: call to __fentry__() with UACCESS enabled
vmlinux.o: warning: objtool: kmsan_report+0x4: call to __fentry__() with UACCESS enabled

Similar code already exists in kasan, which avoids this by skipping
ftrace annotations, so do the same thing here.

Fixes: f80be4571b19 ("kmsan: add KMSAN runtime core")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/kmsan/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/kmsan/Makefile b/mm/kmsan/Makefile
index 98eab2856626..389fd767a11f 100644
--- a/mm/kmsan/Makefile
+++ b/mm/kmsan/Makefile
@@ -16,6 +16,14 @@ CC_FLAGS_KMSAN_RUNTIME += -DDISABLE_BRANCH_PROFILING
 
 CFLAGS_REMOVE.o = $(CC_FLAGS_FTRACE)
 
+# Disable ftrace to avoid recursion.
+CFLAGS_REMOVE_core.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_hooks.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_init.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_instrumentation.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_shadow.o = $(CC_FLAGS_FTRACE)
+
 CFLAGS_core.o := $(CC_FLAGS_KMSAN_RUNTIME)
 CFLAGS_hooks.o := $(CC_FLAGS_KMSAN_RUNTIME)
 CFLAGS_init.o := $(CC_FLAGS_KMSAN_RUNTIME)
-- 
2.39.1

