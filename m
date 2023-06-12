Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA26272D119
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238334AbjFLUu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjFLUsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:48:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBF919B3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D792762F20
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58847C43333;
        Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602717;
        bh=ujkkeF6CcwcL8JLlTc5iUkI9cAxPzJGXzBROQQtoy1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=de0Ij0MsBENh8xMB3pYY6EZViEWela8BfBAsysvMNUIvg2yZhKeyFYZiEwkXrWuv8
         ge54p3sKsyTZWknh/NpW1yHg1sDETCOQBOwBAg0uGI76I5P01s3iDiVJmvo35uHbYr
         BUHxY8RsIUEFNtb5TxIo29lr2IvvxkXad9ALk67kKZ4jxZMWjjf4JEa+VLgQ4ARP1g
         oISwYta3Dk97PsSA6mikU55RwTZejoLyv7KavLt2CgP7IP52bdAuaHW9u/f6hC4vfR
         C5xin0VMtowPRnosRed+L+rryBO7+ii5Ozt3dcriHIqL8bgWKzmUWHCdedGZUwRu4c
         Az5SzCrPvrIOw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 20401CE3A90; Mon, 12 Jun 2023 13:45:16 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Zhangjin Wu <falcon@tinylab.org>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 47/53] tools/nolibc: arm: add missing my_syscall6
Date:   Mon, 12 Jun 2023 13:45:08 -0700
Message-Id: <20230612204514.292087-47-paulmck@kernel.org>
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

From: Zhangjin Wu <falcon@tinylab.org>

This is required by the coming removal of the oldselect and newselect
support.

pselect6/pselect6_time64 will be used unconditionally, they have 6
arguments.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-riscv/bf3e07c1-75f5-425b-9124-f3f2b230e63a@app.fastmail.com/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/arch-arm.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index 45b89ffe8247..ca4c66987497 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -198,6 +198,29 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                  \
+({                                                                            \
+	register long _num  __asm__(_NOLIBC_SYSCALL_REG) = (num);             \
+	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("r2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("r3") = (long)(arg4);                    \
+	register long _arg5 __asm__ ("r4") = (long)(arg5);                    \
+	register long _arg6 __asm__ ("r5") = (long)(arg6);                    \
+	                                                                      \
+	__asm__  volatile (                                                   \
+		_NOLIBC_THUMB_SET_R7                                          \
+		"svc #0\n"                                                    \
+		_NOLIBC_THUMB_RESTORE_R7                                      \
+		: "=r"(_arg1), "=r" (_num)                                    \
+		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
+		  "r"(_arg6), "r"(_num)                                       \
+		: "memory", "cc", "lr"                                        \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
-- 
2.40.1

