Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EDA5F09FF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiI3LW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiI3LWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:22:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3C810EDBC
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:11:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeDuz-0002AL-F6; Fri, 30 Sep 2022 13:10:57 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeDux-003n0o-3u; Fri, 30 Sep 2022 13:10:53 +0200
Received: from ukl by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeDuu-005RAJ-VD; Fri, 30 Sep 2022 13:10:52 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] printf: Emit "SUCCESS" if NULL is passed for %pe
Date:   Fri, 30 Sep 2022 13:10:50 +0200
Message-Id: <20220930111050.1296018-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For code that emits a string representing a usual return value it's
convenient to have a 0 result in a string representation of success
instead of "00000000".

A usecase is tracing where the return value of a callback is emitted,
see
https://lore.kernel.org/linux-pwm/20220916151506.298488-2-u.kleine-koenig@pengutronix.de
for an example.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 lib/errname.c  | 1 +
 lib/vsprintf.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/errname.c b/lib/errname.c
index 05cbf731545f..2fd430f25059 100644
--- a/lib/errname.c
+++ b/lib/errname.c
@@ -15,6 +15,7 @@
  */
 #define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = "-" #err
 static const char *names_0[] = {
+	[0] = "SUCCESS",
 	E(E2BIG),
 	E(EACCES),
 	E(EADDRINUSE),
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3c1853a9d1c0..2a27218bab48 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2448,7 +2448,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		return pointer_string(buf, end, ptr, spec);
 	case 'e':
 		/* %pe with a non-ERR_PTR gets treated as plain %p */
-		if (!IS_ERR(ptr))
+		if (!IS_ERR_OR_NULL(ptr))
 			return default_pointer(buf, end, ptr, spec);
 		return err_ptr(buf, end, ptr, spec);
 	case 'u':
-- 
2.30.2

