Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D58868C6F7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjBFTlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBFTlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:41:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B432196E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:41:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE00B60C64
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 19:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511F6C433EF;
        Mon,  6 Feb 2023 19:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675712490;
        bh=a6DtrmiggjLPQaBSVozYOQxEVgxPuX0p9umWyQ+FPvA=;
        h=From:To:Cc:Subject:Date:From;
        b=MLF6pw+Gwa+wXs1Rugqs3F6hSQkLaBbnTr9L9o8spmIGgr49adolFbcbjdSV+TpZe
         iTcoiGAbePu9XmaGJSP6Yw1N9/WwxIP7xdZf6h8lRMRWcHAGLkU+tjKBLaWr+0oeNQ
         k/VzyaiuMZ1xZTs/0yOSQ6RL3T/MGWMxYU0TVhGnULllpTP69IQEYiVfB+Od6rUr4S
         dvw39PeBW+yS17rF2i1n6kEAocUp59uSrwJ1coSdplF15EXuz+YHJ0r0K7CsfYjrEl
         xkekk7vxnYac41y3L521B47U4ZQfVpNlVWx/V/jftvnDqeP8/LGHK1OC7TKAavkssl
         W88yCpXbwXNjQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND v4] printf: fix errname.c list
Date:   Mon,  6 Feb 2023 20:40:57 +0100
Message-Id: <20230206194126.380350-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

On most architectures, gcc -Wextra warns about the list of error
numbers containing both EDEADLK and EDEADLOCK:

lib/errname.c:15:67: warning: initialized field overwritten [-Woverride-init]
   15 | #define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = "-" #err
      |                                                                   ^~~
lib/errname.c:172:2: note: in expansion of macro 'E'
  172 |  E(EDEADLK), /* EDEADLOCK */
      |  ^

On parisc, a similar error happens with -ECANCELLED, which is an
alias for ECANCELED.

Make the EDEADLK printing conditional on the number being distinct
from EDEADLOCK, and remove the -ECANCELLED bit completely as it
can never be hit.

To ensure these are correct, add static_assert lines that verify
all the remaining aliases are in fact identical to the canonical
name.

Fixes: 57f5677e535b ("printf: add support for printing symbolic error names")
Cc: Petr Mladek <pmladek@suse.com>
Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Acked-by: Uwe Kleine-König <uwe@kleine-koenig.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/all/20210514213456.745039-1-arnd@kernel.org/
Link: https://lore.kernel.org/all/20210927123409.1109737-1-arnd@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I sent this a few times, but it never made it in so far. The warning
still shows up when enabling extra warnings, and this is an actual bug.
---
 lib/errname.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/lib/errname.c b/lib/errname.c
index 05cbf731545f..67739b174a8c 100644
--- a/lib/errname.c
+++ b/lib/errname.c
@@ -21,6 +21,7 @@ static const char *names_0[] = {
 	E(EADDRNOTAVAIL),
 	E(EADV),
 	E(EAFNOSUPPORT),
+	E(EAGAIN), /* EWOULDBLOCK */
 	E(EALREADY),
 	E(EBADE),
 	E(EBADF),
@@ -31,15 +32,17 @@ static const char *names_0[] = {
 	E(EBADSLT),
 	E(EBFONT),
 	E(EBUSY),
-#ifdef ECANCELLED
-	E(ECANCELLED),
-#endif
+	E(ECANCELED), /* ECANCELLED */
 	E(ECHILD),
 	E(ECHRNG),
 	E(ECOMM),
 	E(ECONNABORTED),
+	E(ECONNREFUSED), /* EREFUSED */
 	E(ECONNRESET),
+	E(EDEADLK), /* EDEADLOCK */
+#if EDEADLK != EDEADLOCK /* mips, sparc, powerpc */
 	E(EDEADLOCK),
+#endif
 	E(EDESTADDRREQ),
 	E(EDOM),
 	E(EDOTDOT),
@@ -166,14 +169,17 @@ static const char *names_0[] = {
 	E(EUSERS),
 	E(EXDEV),
 	E(EXFULL),
-
-	E(ECANCELED), /* ECANCELLED */
-	E(EAGAIN), /* EWOULDBLOCK */
-	E(ECONNREFUSED), /* EREFUSED */
-	E(EDEADLK), /* EDEADLOCK */
 };
 #undef E
 
+#ifdef EREFUSED /* parisc */
+static_assert(EREFUSED == ECONNREFUSED);
+#endif
+#ifdef ECANCELLED /* parisc */
+static_assert(ECANCELLED == ECANCELED);
+#endif
+static_assert(EAGAIN == EWOULDBLOCK); /* everywhere */
+
 #define E(err) [err - 512 + BUILD_BUG_ON_ZERO(err < 512 || err > 550)] = "-" #err
 static const char *names_512[] = {
 	E(ERESTARTSYS),
-- 
2.39.0

