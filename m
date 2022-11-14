Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37D7627C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbiKNLor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbiKNLoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:44:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9408521805
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:44:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3008361046
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F554C433D6;
        Mon, 14 Nov 2022 11:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426252;
        bh=S8zV5neWzdzrlGujgojwhqUti56G0WJU8dL7d971SiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SihAYQgv52omW1PHZ7cmu4VDkPbbFO0lMbLv/yfk8erdeDjAQyjrBr3yGTTwox7IF
         Ez9f5u2OzS1qjPZx2X4xADHcbceCYo8rGgROF9gCcRzQEhv9EypZxQ6bU4rBaFwd75
         HlCpTRlUj3Mi4Y6o/m1lQWqlhCJiPGjKyyDG0opL7PI3mksDmV+Lg1p6F/PELxh62b
         n70ERWMmGlZ8Gif7c+RgN3L4z/OXk41zToHMprzJX4ncClKV1QV3+ZLkKp0Apa4x3+
         9v1G3ZTOrimok0l0MzFd/dh2NaoW7PY5Md7wnJQYAq8Y1azQg0B3p2vfVrJ+Wd48RS
         EEDp7zxbepynw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <andi@firstfloor.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 08/46] static_call, lto: Mark static keys as __visible
Date:   Mon, 14 Nov 2022 12:43:06 +0100
Message-Id: <20221114114344.18650-9-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
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

From: Andi Kleen <andi@firstfloor.org>

Symbols referenced from assembler (either directly or e.f. from
DEFINE_STATIC_KEY()) need to be global and visible in gcc LTO because
they could end up in a different object file than the assembler. This
can lead to linker errors without this patch.

So mark static call functions as __visible, namely static keys here.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Andi Kleen <andi@firstfloor.org>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/static_call.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index df53bed9d71f..e629ab0c4ca3 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -182,7 +182,7 @@ extern long __static_call_return0(void);
 
 #define DEFINE_STATIC_CALL(name, _func)					\
 	DECLARE_STATIC_CALL(name, _func);				\
-	struct static_call_key STATIC_CALL_KEY(name) = {		\
+	__visible struct static_call_key STATIC_CALL_KEY(name) = {		\
 		.func = _func,						\
 		.type = 1,						\
 	};								\
@@ -190,7 +190,7 @@ extern long __static_call_return0(void);
 
 #define DEFINE_STATIC_CALL_NULL(name, _func)				\
 	DECLARE_STATIC_CALL(name, _func);				\
-	struct static_call_key STATIC_CALL_KEY(name) = {		\
+	__visible struct static_call_key STATIC_CALL_KEY(name) = {	\
 		.func = NULL,						\
 		.type = 1,						\
 	};								\
@@ -198,7 +198,7 @@ extern long __static_call_return0(void);
 
 #define DEFINE_STATIC_CALL_RET0(name, _func)				\
 	DECLARE_STATIC_CALL(name, _func);				\
-	struct static_call_key STATIC_CALL_KEY(name) = {		\
+	__visible struct static_call_key STATIC_CALL_KEY(name) = {		\
 		.func = __static_call_return0,				\
 		.type = 1,						\
 	};								\
@@ -227,14 +227,14 @@ static inline int static_call_init(void) { return 0; }
 
 #define DEFINE_STATIC_CALL(name, _func)					\
 	DECLARE_STATIC_CALL(name, _func);				\
-	struct static_call_key STATIC_CALL_KEY(name) = {		\
+	__visible struct static_call_key STATIC_CALL_KEY(name) = {		\
 		.func = _func,						\
 	};								\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
 
 #define DEFINE_STATIC_CALL_NULL(name, _func)				\
 	DECLARE_STATIC_CALL(name, _func);				\
-	struct static_call_key STATIC_CALL_KEY(name) = {		\
+	__visible struct static_call_key STATIC_CALL_KEY(name) = {	\
 		.func = NULL,						\
 	};								\
 	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
@@ -288,7 +288,7 @@ static inline long __static_call_return0(void)
 
 #define __DEFINE_STATIC_CALL(name, _func, _func_init)			\
 	DECLARE_STATIC_CALL(name, _func);				\
-	struct static_call_key STATIC_CALL_KEY(name) = {		\
+	__visible struct static_call_key STATIC_CALL_KEY(name) = {	\
 		.func = _func_init,					\
 	}
 
-- 
2.38.1

