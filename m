Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D850697C96
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjBONB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjBONBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:01:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4E432E7D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 05:01:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40593B821C3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 13:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33BFC4339C;
        Wed, 15 Feb 2023 13:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676466079;
        bh=2ZHB4kXmO9QIInQQshGPPjNMQQVO/B7ppuR6Groskjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lu0J/SbIWS9+ixPccMmPzBFd9wQGiDgHS5tGpdfzu2X1ttNScPufVWKN4YxkY+2Fd
         yEvd/lrDUelvVUcKUlWelk6i41CpM+iakWnqD+45tJAakIshZlQoIASn/DShugRUdF
         LIAYGi8BbC04s3E6k7lyzwqfRsRdZFZ2paJdd6c4ZESmWCoX17BK/JqQwnUGpLEz9e
         b6yfeo3A3vbGVPmkyqDkRZ6v9UTwjWYjn4t9p9uVQmW1sSiZEzZPXmsGTmsHHdhxaq
         2hmIuC3PhRN+4c4XlFCh79d4evkN+67G1XPbt2USq4bhhs0V1sugylow7OFJb9XcSi
         gi/4JcPUzP61A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Marco Elver <elver@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] [v2] kmsan: disable ftrace in kmsan core code
Date:   Wed, 15 Feb 2023 14:00:57 +0100
Message-Id: <20230215130058.3836177-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215130058.3836177-1-arnd@kernel.org>
References: <20230215130058.3836177-1-arnd@kernel.org>
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

The Makefile contained a line to turn off ftrace for the entire directory,
but this does not work. Replace it with individual lines, matching the
approach in kasan.

Fixes: f80be4571b19 ("kmsan: add KMSAN runtime core")
Acked-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: remove the old "CFLAGS_REMOVE.o = $(CC_FLAGS_FTRACE)" line
---
 mm/kmsan/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/kmsan/Makefile b/mm/kmsan/Makefile
index 98eab2856626..91cfdde642d1 100644
--- a/mm/kmsan/Makefile
+++ b/mm/kmsan/Makefile
@@ -14,7 +14,13 @@ CC_FLAGS_KMSAN_RUNTIME := -fno-stack-protector
 CC_FLAGS_KMSAN_RUNTIME += $(call cc-option,-fno-conserve-stack)
 CC_FLAGS_KMSAN_RUNTIME += -DDISABLE_BRANCH_PROFILING
 
-CFLAGS_REMOVE.o = $(CC_FLAGS_FTRACE)
+# Disable ftrace to avoid recursion.
+CFLAGS_REMOVE_core.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_hooks.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_init.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_instrumentation.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_shadow.o = $(CC_FLAGS_FTRACE)
 
 CFLAGS_core.o := $(CC_FLAGS_KMSAN_RUNTIME)
 CFLAGS_hooks.o := $(CC_FLAGS_KMSAN_RUNTIME)
-- 
2.39.1

