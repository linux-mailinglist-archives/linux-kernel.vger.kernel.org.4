Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226AA72F3C8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 06:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242594AbjFNEwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 00:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbjFNEwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:52:24 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF21C184
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:52:23 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b3c0c47675so28067395ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686718343; x=1689310343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqw+pfXvRxFyKtNsvJYgxpMTw9Cw0YTqu9wRT0MEL7w=;
        b=OimPmjXCG8okhtcLCLa7VYDFJqQQBCmFVW5QxbTi/cal0RAl1RvumolnmY/ZWjUCoV
         oAMg/p+5sJnSfGLa1Xgim8Gjoj6vSVlhLWg6RI+cpiA//YXzuXnOnMsIoCQmW9CiYUFp
         f9G02GCCyRDuSQ3CiBOUAfoeGzBbmOsTYD4KmHXoOej4GW5tb3SbIBXbqncciwlS2+lz
         q6ej+NWHVzvPRmC6PhlhVWpjst8vogmOy6yvHFUh6xELCDDufLxDg1YLhsYI6YQ+xCnx
         pFuK5gzixEZjso6CajRcYB+wVKQUCqd8aA3ecRaRhDJ4Huuklx9j7Bv1V/tmNfrDHg8o
         B7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686718343; x=1689310343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqw+pfXvRxFyKtNsvJYgxpMTw9Cw0YTqu9wRT0MEL7w=;
        b=GZdUsxgXwBpnYT8zKdC81WTNcAPV/XirzjdS4TK9UYDI/va4OsLGSQ/zsdDpG+TfTJ
         znkjJ5i4v2U5aOAq1YIS43be4qZbKyjhlrb8/57AKBPSfwqkqXMwb0NGn2zN9PXcg9IQ
         Xq9NgVUfc6L399Y6cXkobOMGhYMfijDW81mLVkLry/wT/LZEwPV5k0ZtcCpAvYdIq3C7
         Bd7c8A830uRCGzOnKKwzBTKxhT/tXRLCxJgAZrPSIdN/3u4Sf1aRvOCQDTNVG7QHXc1A
         ZBeOLXW53ISob8/YdFf7ZYYZRKuodehLlZJpX8K7usQO/bdk/HGsrlGJlmirToCwsFH3
         9JgQ==
X-Gm-Message-State: AC+VfDx9T7UFFJICE3RvNZLi3KKqoDpU5WGzYexTSll7lEiauekZUQRG
        sypD3x46SA7J4QtesU4oPT2dGqjl/EQ=
X-Google-Smtp-Source: ACHHUZ6jDPY4+lPmASsyp2oI0qbUIfUOl/fAixH4E6uT3eg+XAoCsTBbNSW8NksgakF8dI74faRqvw==
X-Received: by 2002:a17:902:e842:b0:1b2:4fea:c62 with SMTP id t2-20020a170902e84200b001b24fea0c62mr12789996plg.30.1686718342949;
        Tue, 13 Jun 2023 21:52:22 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:bf5f:2e99:78f2:6007])
        by smtp.gmail.com with ESMTPSA id z18-20020a170903019200b001acad86ebc5sm11089790plg.33.2023.06.13.21.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 21:52:22 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 1/4] xtensa: move early_trap_init from kasan_early_init to init_arch
Date:   Tue, 13 Jun 2023 21:52:09 -0700
Message-Id: <20230614045212.2534746-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230614045212.2534746-1-jcmvbkbc@gmail.com>
References: <20230614045212.2534746-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There may be other users for the early traps besides KASAN. Move call to
the early_trap_init from kasan_early_init. Protect init_exc_table
initializer with ifdef to make sure it builds on noMMU configurations.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/traps.h | 2 ++
 arch/xtensa/kernel/setup.c      | 6 ++++++
 arch/xtensa/mm/kasan_init.c     | 2 --
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/include/asm/traps.h b/arch/xtensa/include/asm/traps.h
index 6f74ccc0c7ea..acffb02f8760 100644
--- a/arch/xtensa/include/asm/traps.h
+++ b/arch/xtensa/include/asm/traps.h
@@ -64,8 +64,10 @@ void do_unhandled(struct pt_regs *regs);
 static inline void __init early_trap_init(void)
 {
 	static struct exc_table init_exc_table __initdata = {
+#ifdef CONFIG_MMU
 		.fast_kernel_handler[EXCCAUSE_DTLB_MISS] =
 			fast_second_level_miss,
+#endif
 	};
 	xtensa_set_sr(&init_exc_table, excsave1);
 }
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index 94aafa19771b..5c0c0fcac144 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -47,6 +47,7 @@
 #include <asm/smp.h>
 #include <asm/sysmem.h>
 #include <asm/timex.h>
+#include <asm/traps.h>
 
 #if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE)
 struct screen_info screen_info = {
@@ -242,6 +243,11 @@ void __init early_init_devtree(void *params)
 
 void __init init_arch(bp_tag_t *bp_start)
 {
+	/* Initialize basic exception handling if configuration may need it */
+
+	if (IS_ENABLED(CONFIG_KASAN))
+		early_trap_init();
+
 	/* Initialize MMU. */
 
 	init_mmu();
diff --git a/arch/xtensa/mm/kasan_init.c b/arch/xtensa/mm/kasan_init.c
index 1fef24db2ff6..f00d122aa806 100644
--- a/arch/xtensa/mm/kasan_init.c
+++ b/arch/xtensa/mm/kasan_init.c
@@ -14,7 +14,6 @@
 #include <linux/kernel.h>
 #include <asm/initialize_mmu.h>
 #include <asm/tlbflush.h>
-#include <asm/traps.h>
 
 void __init kasan_early_init(void)
 {
@@ -31,7 +30,6 @@ void __init kasan_early_init(void)
 		BUG_ON(!pmd_none(*pmd));
 		set_pmd(pmd, __pmd((unsigned long)kasan_early_shadow_pte));
 	}
-	early_trap_init();
 }
 
 static void __init populate(void *start, void *end)
-- 
2.30.2

