Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D462E6E6E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjDRV2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjDRV2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:28:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270FFC671
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:28:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 172B96393D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 21:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98FCC433A1;
        Tue, 18 Apr 2023 21:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681853281;
        bh=rKNOJA2iFxFHQD00gPxbX9WeLPWBE9JGs0wdA5OiRv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c0blbe4lLqfHHadAtOQFMEbIpw6pqLcijlz7BFygBypbTqIXXrbuq+bnKXo2qQOBu
         NULyMH4LXCIdMoKckY0Yr3CwAt3oS6pyE/2aJnwD2NwZHBFsAKwEMBGJInOdBwf3lC
         QX8TAaHzTIS1uGJ+DJHBuWCMZrryJYd9PLT8qK4Z+//BZSiSJG7y/o/Q5tf6sRg4m8
         DlbxA992QxOtLr9oD9r+tS5cCJcI+batN2VA+4n9ZspK1y4iZ/xAaO5kKpZp+4iXxd
         UTqRKHX/qAq8KrnFuqhjgFUPbc0Oq7pl3Ky20SgdthWPVxxSBowFQxl14CXSxakaNZ
         NXx5512m9DnWQ==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3 7/8] tools/lib/subcmd: Replace NORETURN usage with __noreturn
Date:   Tue, 18 Apr 2023 14:27:53 -0700
Message-Id: <c7c83d1e6b3d2b0c3e65dd3790c22c772d3b2527.1681853186.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681853186.git.jpoimboe@kernel.org>
References: <cover.1681853186.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
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

NORETURN is redundant with __noreturn, just use the latter.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/lib/subcmd/parse-options.h | 8 ++------
 tools/lib/subcmd/subcmd-util.h   | 5 ++---
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/lib/subcmd/parse-options.h b/tools/lib/subcmd/parse-options.h
index 41b9b942504d..8e9147358a28 100644
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
index b2aec04fce8f..dfac76e35ac7 100644
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
 
-- 
2.39.2

