Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5221B72D0F6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbjFLUs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjFLUra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:47:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2394F295A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8517262F03
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AFBC43443;
        Mon, 12 Jun 2023 20:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602716;
        bh=tOuRtkHYs9MNwpbcUTDT/8K9pnXHgkjL97lAfJJGhgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZNnxDU1TXOuRT3FMSlYGWrX0TkT4AnPHvMcSbWXHi5JWoxLutDnUjo15h76iV4cKW
         qslqvv7be++VpA8Zr3gwFpBBSiOqQblpmO5Zmed38F94zw01qMYj0ShI3GVKjca1Uk
         zMSSY+BHp81+3g7VxTFbVp3LEZibSYBeoubXkpLFBZsLnQ/vyPASWFl/ljpH0kHC2P
         SMu+jlclqrf6MsdDE++4fzt0ZmYc4NGhtLSfb3xf+CTQmSlcZdk3CGDz9cV8NKfnBd
         f/WP4YI79WjskRDkr5yz6J2y2Ir5xmayucKTJbE2o5qjFNuBT2bW7C/V9MSnNTMuT8
         xOoUzA2A1ILZA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DD080CE3A68; Mon, 12 Jun 2023 13:45:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 23/53] tools/nolibc: mips: add stackprotector support
Date:   Mon, 12 Jun 2023 13:44:44 -0700
Message-Id: <20230612204514.292087-23-paulmck@kernel.org>
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
 tools/include/nolibc/arch-mips.h        | 8 +++++++-
 tools/testing/selftests/nolibc/Makefile | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 8822f150e72f..65c19ccc7f9d 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -179,14 +179,20 @@ struct sys_stat_struct {
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
+#define __ARCH_SUPPORTS_STACK_PROTECTOR
+
 /* startup code, note that it's called __start on MIPS */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __start(void)
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) __start(void)
 {
 	__asm__ volatile (
 		/*".set nomips16\n"*/
 		".set push\n"
 		".set    noreorder\n"
 		".option pic0\n"
+#ifdef NOLIBC_STACKPROTECTOR
+		"jal __stack_chk_init\n" /* initialize stack protector                         */
+		"nop\n"                  /* delayed slot                                       */
+#endif
 		/*".ent __start\n"*/
 		/*"__start:\n"*/
 		"lw $a0,($sp)\n"        /* argc was in the stack                               */
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index ab6e7c0c2494..6d660d922240 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -84,6 +84,7 @@ CFLAGS_STKP_x86_64 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_x86 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_arm64 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_arm = $(CFLAGS_STACKPROTECTOR)
+CFLAGS_STKP_mips = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_loongarch = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_s390 = -m64
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
-- 
2.40.1

