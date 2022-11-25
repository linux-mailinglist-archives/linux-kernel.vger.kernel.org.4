Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB5963902F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 20:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiKYTKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 14:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKYTKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 14:10:15 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21AA5474F;
        Fri, 25 Nov 2022 11:10:12 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1669403409;
        bh=Cc2ClTVm2l8saukQMqFH86xff8jJ/Zkmp6yCVTzmAQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CNXSiJN+v/zXwLWrJgqlJGajJyPZ+7jU7x3u9+ts6auIIMHQWL5v/ZFxECTf3QJxf
         zUzvLrNg/oI6Y8MFxCFjNNUIA0f2vVUe3HV1ZF3wsuC5TbBcJfacROfdIgv6thy+rX
         tjIWAjg8dDcQm8M7EkhL7B9Fh3bFhr83UEe3LuDY=
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2 2/3] checkpatch: handle new pr_<level>_cont macros
Date:   Fri, 25 Nov 2022 20:09:47 +0100
Message-Id: <20221125190948.2062-3-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125190948.2062-1-linux@weissschuh.net>
References: <20221125190948.2062-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1669403373; l=1632; i=linux@weissschuh.net; s=20211113; h=from:subject; bh=Cc2ClTVm2l8saukQMqFH86xff8jJ/Zkmp6yCVTzmAQI=; b=Uv1SmRxhkAlXNeJpl8GBYcYw6GTCbSPRtF1w2m1VcrJcH7C7QOYyiOMZrST2deFGQxKEXv9JWLkg m0rSB25MBJRBtXF+hi+Jg+AwA7gpFO20zxvfQkexKukujd4f9lHt
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These new macros from include/linux/printk.h replace the usage of plain
pr_cont().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 scripts/checkpatch.pl | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1e5e66ae5a52..fb1747639c9c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -590,7 +590,7 @@ our $zero_initializer = qr{(?:(?:0[xX])?0+$Int_type?|NULL|false)\b};
 
 our $logFunctions = qr{(?x:
 	printk(?:_ratelimited|_once|_deferred_once|_deferred|)|
-	(?:[a-z0-9]+_){1,2}(?:printk|emerg|alert|crit|err|warning|warn|notice|info|debug|dbg|vdbg|devel|cont|WARN)(?:_ratelimited|_once|)|
+	(?:[a-z0-9]+_){1,2}(?:printk|emerg|alert|crit|err|warning|warn|notice|info|debug|dbg|vdbg|devel|cont|WARN)(?:_ratelimited|_once|_cont|)|
 	TP_printk|
 	WARN(?:_RATELIMIT|_ONCE|)|
 	panic|
@@ -6374,11 +6374,17 @@ sub process {
 		}
 
 # check for logging continuations
-		if ($line =~ /\bprintk\s*\(\s*KERN_CONT\b|\bpr_cont\s*\(/) {
+		if ($line =~ /\bprintk\s*\(\s*KERN_CONT\b|\bpr_([a-z]+_)?cont\s*\(/) {
 			WARN("LOGGING_CONTINUATION",
 			     "Avoid logging continuation uses where feasible\n" . $herecurr);
 		}
 
+# check for logging continuations without explicit level
+		if ($line =~ /\bpr_cont\s*\(/) {
+			WARN("LOGGING_CONTINUATION_WITHOUT_LEVEL",
+			     "Avoid logging continuation without level\n" . $herecurr);
+		}
+
 # check for unnecessary use of %h[xudi] and %hh[xudi] in logging functions
 		if (defined $stat &&
 		    $line =~ /\b$logFunctions\s*\(/ &&
-- 
2.38.1

