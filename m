Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CCF68F389
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjBHQlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjBHQkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:40:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701D74DE00
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 08:40:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D09D61734
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 16:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B31C433EF;
        Wed,  8 Feb 2023 16:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675874432;
        bh=GGeAEaRt65it3PXlOo+5hSPcgSq11pcqA9eKquHfzZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ewkkWjBPkbuENbTspA2LMFcdZN6Zua6IVR1vYYB/KD3R8+7kCWOzWIfI2C/nmkE3G
         zMm/o67vRk2/twf7DStLfKvMwqqsWuL0MN77JEipi6dwrltf0RiCyAWs5Wchgq0UjO
         rbO3uDttgAqTQeVRyfLfxxrAmoSQk+4BJqwIrjQ2gFvPeqWPypeJRxy+5AxKYMbpOx
         NDJMkTEda9UD98e1awEk2Hf054FJmvlaq83KvxIqVAUeYsOG52SOMXxSS3VXKE9YI5
         iMzucZ84z3ZsxGPSIkYVCSmQug3Kh521Mo+qCZm1fRabb9tzLa7fOJvFKIwMUulRCE
         TioEaRvHFnyCQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     kasan-dev@googlegroups.com, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
        Miroslav Benes <mbenes@suse.cz>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] objdump: add UACCESS exception for more stringops
Date:   Wed,  8 Feb 2023 17:39:57 +0100
Message-Id: <20230208164011.2287122-3-arnd@kernel.org>
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

The memset/memmove/memcpy string functions are wrapped in different
ways based on configuration. While the __asan_mem* functions already
have exceptions, the ones called from those do not:

mm/kasan/shadow.o: warning: objtool: __asan_memset+0x30: call to __memset() with UACCESS enabled
mm/kasan/shadow.o: warning: objtool: __asan_memmove+0x51: call to __memmove() with UACCESS enabled
mm/kasan/shadow.o: warning: objtool: __asan_memcpy+0x51: call to __memcpy() with UACCESS enabled
vmlinux.o: warning: objtool: .altinstr_replacement+0x1406: call to memcpy_erms() with UACCESS enabled
vmlinux.o: warning: objtool: .altinstr_replacement+0xed0: call to memset_erms() with UACCESS enabled
vmlinux.o: warning: objtool: memset+0x4: call to memset_orig() with UACCESS enabled
vmlinux.o: warning: objtool: memset+0x4: call to memset_orig() with UACCESS enabled

Add these to the list as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 tools/objtool/check.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0f67c6a8bc98..e8fb3bf7a2e3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1248,6 +1248,13 @@ static const char *uaccess_safe_builtin[] = {
 	"clear_user_erms",
 	"clear_user_rep_good",
 	"clear_user_original",
+	"__memset",
+	"__memcpy",
+	"__memmove",
+	"memset_erms",
+	"memcpy_erms",
+	"memset_orig",
+	"memcpy_orig",
 	NULL
 };
 
-- 
2.39.1

