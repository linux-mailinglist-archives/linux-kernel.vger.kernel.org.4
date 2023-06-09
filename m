Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C0C72A507
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjFIU5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFIU5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:57:17 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D20E30FC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:57:16 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-53404873a19so877351a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 13:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686344236; x=1688936236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0nInAwiPSY59EHfwf1REBhxEW/sYaJRe5sRuFLMxcAo=;
        b=ULS+iR+tAH8ihvJrorv5atpE1iOo8M10PeWzgUVQ3NmATAWYZuuTU0H0JISMkElRiy
         JcfUYVyHC0veT8E/nVnIglqM8Fwou0ypjKc9s/RGKb0WhzS88jv3A3vzfZM5cEimhsdo
         nYJYAwCZsXobTkbZouIJHa5xu5xEgVfIg0HWva2ZQUYhKZBfIR2bZ0ZQj8E2pyWmRwJf
         HX2UuqYpWKMaH0sokAMKhdQGTDd7HxJvqGFRjZnDZfoH6jniHMnqNeWwtjCnwj0UgQsl
         Cbl1TodOE9I8jVHYVHzfGqbmM38Uu+zchGgsyQFa6DXXy70YATzi0zLe3QGWaBKHkHve
         OsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686344236; x=1688936236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0nInAwiPSY59EHfwf1REBhxEW/sYaJRe5sRuFLMxcAo=;
        b=jfwwOUinTlotTYC88oQkgOiFOV2vOzUlYAV+Wi/EPi8mINarNTWeRlmQE3TExQnsrF
         WlJKe0rfm36VmnX6k6zOCdZXVusAMSEVl0QU+jxiLnDeNArpOObhAwLYC+deAT96JiL6
         BnbsMcpiXsi4qhKf0aZQq4kfgyJr/AnJHQ46XlHNjilL9/4Oj7sbdCalQICY1/+ttyu9
         CMZeXUqEUPFg/bFyvnK0wlNySgEz4ySU3y9nIwUVk2tb2tdfvMAUkROE0mtZCSJaKZTo
         VPu4bbCYyFUM1R0LKocc0Mm1LpA29X11+UNeRvSBK4W25sKGQKVTDOKNSpRHPqp6MJEw
         PxbA==
X-Gm-Message-State: AC+VfDzNJn0ER4o3ZBHdNYkZw6TgTwQ2K7a0f8yQfk882pGly+ruf9nH
        hO3c6uzvXQO7ZLyp8X73FZ4n0nb2fkM=
X-Google-Smtp-Source: ACHHUZ7X8OzTk42X+kw+89W/ZvldhqZoWIpw6cJPyVcc4mhUwudpnd142QYiWJUYNm9J9n3Nj8joQg==
X-Received: by 2002:a17:90a:1d1:b0:256:2ef:92ec with SMTP id 17-20020a17090a01d100b0025602ef92ecmr1872152pjd.1.1686344235616;
        Fri, 09 Jun 2023 13:57:15 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:1bc3:5645:d3d:e4be])
        by smtp.gmail.com with ESMTPSA id g193-20020a636bca000000b0053b8a4f9465sm3323304pgc.45.2023.06.09.13.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:57:14 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: drop ARCH_WANT_FRAME_POINTERS
Date:   Fri,  9 Jun 2023 13:57:09 -0700
Message-Id: <20230609205709.1984611-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
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

ARCH_WANT_FRAME_POINTERS was enabled in the xtensa Kconfig in the commit
8f371c752154 ("xtensa: enable lockdep support"), but neither windowed
nor call0 xtensa ABI need frame pointers for stack tracing.
Drop ARCH_WANT_FRAME_POINTERS from the xtensa Kconfig.
Drop ftrace_return_address0 definition as the generic implementation is
correct.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Kconfig              | 1 -
 arch/xtensa/include/asm/ftrace.h | 9 ---------
 arch/xtensa/kernel/stacktrace.c  | 4 ----
 3 files changed, 14 deletions(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 46051edc5ed3..45f72c8fa911 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -16,7 +16,6 @@ config XTENSA
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
-	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_TABLE_SORT
 	select CLONE_BACKWARDS
diff --git a/arch/xtensa/include/asm/ftrace.h b/arch/xtensa/include/asm/ftrace.h
index 6c6d9a9f185f..0ea4f84cd558 100644
--- a/arch/xtensa/include/asm/ftrace.h
+++ b/arch/xtensa/include/asm/ftrace.h
@@ -13,17 +13,8 @@
 #include <asm/processor.h>
 
 #ifndef __ASSEMBLY__
-#define ftrace_return_address0 ({ unsigned long a0, a1; \
-		__asm__ __volatile__ ( \
-			"mov %0, a0\n" \
-			"mov %1, a1\n" \
-			: "=r"(a0), "=r"(a1)); \
-		MAKE_PC_FROM_RA(a0, a1); })
-
-#ifdef CONFIG_FRAME_POINTER
 extern unsigned long return_address(unsigned level);
 #define ftrace_return_address(n) return_address(n)
-#endif
 #endif /* __ASSEMBLY__ */
 
 #ifdef CONFIG_FUNCTION_TRACER
diff --git a/arch/xtensa/kernel/stacktrace.c b/arch/xtensa/kernel/stacktrace.c
index 7f7755cd28f0..f643ea5e36da 100644
--- a/arch/xtensa/kernel/stacktrace.c
+++ b/arch/xtensa/kernel/stacktrace.c
@@ -237,8 +237,6 @@ EXPORT_SYMBOL_GPL(save_stack_trace);
 
 #endif
 
-#ifdef CONFIG_FRAME_POINTER
-
 struct return_addr_data {
 	unsigned long addr;
 	unsigned skip;
@@ -271,5 +269,3 @@ unsigned long return_address(unsigned level)
 	return r.addr;
 }
 EXPORT_SYMBOL(return_address);
-
-#endif
-- 
2.30.2

