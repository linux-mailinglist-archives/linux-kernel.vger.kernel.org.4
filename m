Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71609707ED8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjERLIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjERLI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:08:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAF4B8;
        Thu, 18 May 2023 04:08:04 -0700 (PDT)
Date:   Thu, 18 May 2023 11:08:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684408081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oCi1DmbpTPgutTsGMxhvkAhYR5c4MoOJ0Tep7lmMR/8=;
        b=H6y94iYyqFgzX50S9lgITYuAd+JamGsgVgxP6kq2kgsozovmJj5kgFXpQFBcYB4QyXN9eL
        gOjfS9PUoUwUcklMX4ldWXXrwYHa1HFqk1k8qo3I9vCx9cjc7+mvTHB5klYIZH0MpXmGt2
        po/3nijnYC28xBA4zI/7p25vbcQy1gL6hots50r1nh9SVsnwtabDsYx22whwxDeo9romjM
        GICVskfzrY8gnuMBWYNnulbEcNG0HgiHOfIXD4Jpht/b9dCQoNSPNnRcgiRiYvmDGCNrdj
        mo8wKGrI9+TILgajfmr9L4rzOApuDUXt0uLXLgZ/n1+TZ1ip8NAopzLuuFuuOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684408081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oCi1DmbpTPgutTsGMxhvkAhYR5c4MoOJ0Tep7lmMR/8=;
        b=f88n1st0iDU3Geimdz71dEw2KU77o4zgZtzECtdl1RCvA9EVV4LJVtrMn6FkLNQza0pohp
        kt2vFabD0o8ByrAQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] tools/lib/subcmd: Replace NORETURN usage with __noreturn
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <c7c83d1e6b3d2b0c3e65dd3790c22c772d3b2527.1681853186.git.jpoimboe@kernel.org>
References: <c7c83d1e6b3d2b0c3e65dd3790c22c772d3b2527.1681853186.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168440808137.404.4849730726607986574.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     d59fec29b131f30b27343d54bdf1071ee98eda8e
Gitweb:        https://git.kernel.org/tip/d59fec29b131f30b27343d54bdf1071ee98eda8e
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 18 Apr 2023 14:27:53 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 16 May 2023 06:31:54 -07:00

tools/lib/subcmd: Replace NORETURN usage with __noreturn

NORETURN is redundant with __noreturn, just use the latter.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lore.kernel.org/r/c7c83d1e6b3d2b0c3e65dd3790c22c772d3b2527.1681853186.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/lib/subcmd/parse-options.h | 8 ++------
 tools/lib/subcmd/subcmd-util.h   | 5 ++---
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/lib/subcmd/parse-options.h b/tools/lib/subcmd/parse-options.h
index 41b9b94..8e91473 100644
--- a/tools/lib/subcmd/parse-options.h
+++ b/tools/lib/subcmd/parse-options.h
@@ -6,10 +6,6 @@
 #include <stdbool.h>
 #include <stdint.h>
 
-#ifndef NORETURN
-#define NORETURN __attribute__((__noreturn__))
-#endif
-
 enum parse_opt_type {
 	/* special types */
 	OPTION_END,
@@ -183,9 +179,9 @@ extern int parse_options_subcommand(int argc, const char **argv,
 				const char *const subcommands[],
 				const char *usagestr[], int flags);
 
-extern NORETURN void usage_with_options(const char * const *usagestr,
+extern __noreturn void usage_with_options(const char * const *usagestr,
                                         const struct option *options);
-extern NORETURN __attribute__((format(printf,3,4)))
+extern __noreturn __attribute__((format(printf,3,4)))
 void usage_with_options_msg(const char * const *usagestr,
 			    const struct option *options,
 			    const char *fmt, ...);
diff --git a/tools/lib/subcmd/subcmd-util.h b/tools/lib/subcmd/subcmd-util.h
index b2aec04..dfac76e 100644
--- a/tools/lib/subcmd/subcmd-util.h
+++ b/tools/lib/subcmd/subcmd-util.h
@@ -5,8 +5,7 @@
 #include <stdarg.h>
 #include <stdlib.h>
 #include <stdio.h>
-
-#define NORETURN __attribute__((__noreturn__))
+#include <linux/compiler.h>
 
 static inline void report(const char *prefix, const char *err, va_list params)
 {
@@ -15,7 +14,7 @@ static inline void report(const char *prefix, const char *err, va_list params)
 	fprintf(stderr, " %s%s\n", prefix, msg);
 }
 
-static NORETURN inline void die(const char *err, ...)
+static __noreturn inline void die(const char *err, ...)
 {
 	va_list params;
 
