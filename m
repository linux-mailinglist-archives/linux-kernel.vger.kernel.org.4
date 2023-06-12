Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C4E72D0F9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238092AbjFLUtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237397AbjFLUra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:47:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADE2295D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 897D1628DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB265C433D2;
        Mon, 12 Jun 2023 20:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602716;
        bh=EDCKj1t3cMrbH8q5QIPGb5JPV2twW1putED5vpkf138=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FO82VxxSEFUyIv6IbL2j/ZwF7wqdxAxZCuySjIOEYZpFm+iRPSQqlVhd7cK1iLu9z
         PUtQOtQ5+xf3gQ1ueYU/aEfYEcgOoi6b8DpNVWv19fjjaWvjHU4udUOj315FB9sFvU
         cTY0UT2JC76ydSvsX7GtX6MGSp4TeaRUiWSJZCiSbD+/cdUkkbJxuhu2mGtfXyf6Kj
         o8f76w7/xcrkM4Ei+e/yrMAvzGAinWrUxxA73tyXl4K4604fZlMfKhC5cJc8NXuwEf
         tZ8ZyM66Aq7yun6zbn+QpU0VzT1B+yz+489IdHkesRAZrKz7UQae91TpS82ad1ppGl
         F/F0LCEohcKTA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D8799CE3A64; Mon, 12 Jun 2023 13:45:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 21/53] tools/nolibc: arm: add stackprotector support
Date:   Mon, 12 Jun 2023 13:44:42 -0700
Message-Id: <20230612204514.292087-21-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
References: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/arch-arm.h         | 7 ++++++-
 tools/testing/selftests/nolibc/Makefile | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index 2eab1aef321b..202e64f537dc 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -199,10 +199,15 @@ struct sys_stat_struct {
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
+#define __ARCH_SUPPORTS_STACK_PROTECTOR
+
 /* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
 {
 	__asm__ volatile (
+#ifdef NOLIBC_STACKPROTECTOR
+		"bl __stack_chk_init\n"       /* initialize stack protector                          */
+#endif
 		"pop {%r0}\n"                 /* argc was in the stack                               */
 		"mov %r1, %sp\n"              /* argv = sp                                           */
 
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index fa0075479a26..7585035cbb0d 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -83,6 +83,7 @@ CFLAGS_STKP_i386 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_x86_64 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_x86 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_arm64 = $(CFLAGS_STACKPROTECTOR)
+CFLAGS_STKP_arm = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_s390 = -m64
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
 		$(call cc-option,-fno-stack-protector) \
-- 
2.40.1

