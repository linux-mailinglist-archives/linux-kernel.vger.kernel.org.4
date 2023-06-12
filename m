Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B039C72D0F1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbjFLUtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbjFLUrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:47:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A201981
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A91AD62F14
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2284FC43324;
        Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602717;
        bh=651zibUdG42x8RfDbrif5fkpzpSwW8yz5Rd3sGWo/wk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a82OsQVlu7us9TzK3FQuGOYW/U69y0waSi8CHJl+1cQ/k8Zrh2qSO6nyHbJbtGOo/
         U738RkKgw7v9ZZlrNS+SDLTXUZ0TB8/KqSDtfoQxK0hPrtyyFDULmNCtmKD4WtqAQL
         Akg0Sg4YXl6jaMbbLkFs9iLuw+vo+VkCnknM+Z6KagWZpn+bfkjnRd+vB7jEyB0Yks
         xc1l1aB3YpbB1pjK6UVysvg4CautgASiGi5Ym7FByQf/X+Ttb9EordiGoJz8hLiE40
         CIn0GU7VNKfudSq4tbFS7ujQokszZK+F2zYTSiq/VZR5ER//IVK+Q6OVIJVtA+tWq7
         sBo+bB2MYKaFw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F3E23CE3A7C; Mon, 12 Jun 2023 13:45:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 33/53] tools/nolibc: s390: disable stackprotector in _start
Date:   Mon, 12 Jun 2023 13:44:54 -0700
Message-Id: <20230612204514.292087-33-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
References: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

s390 does not support the "global" stack protector mode that is
implemented in nolibc.

Now that nolibc detects if stack protectors are enabled at runtime it
could happen that a future compiler does indeed use global mode on
and nolibc would compile but segfault at runtime.

To avoid this hypothetic case and to align s390 with the other
architectures disable stack protectors when compiling _start().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/arch-s390.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index a738e7f3f8e8..516dff5bff8b 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -8,6 +8,8 @@
 #include <asm/signal.h>
 #include <asm/unistd.h>
 
+#include "compiler.h"
+
 /* The struct returned by the stat() syscall, equivalent to stat64(). The
  * syscall returns 116 bytes and stops in the middle of __unused.
  */
@@ -164,7 +166,7 @@ char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
 /* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		"lg	%r2,0(%r15)\n"		/* argument count */
-- 
2.40.1

