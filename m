Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C8E6C2717
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 02:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjCUBNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 21:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjCUBNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:13:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C7849E3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 18:12:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1787618F5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:11:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A788C433EF;
        Tue, 21 Mar 2023 01:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679361099;
        bh=ODNl9OOZ7GRaMqnxRe71E34bayxsvyWE18W1XmyJcUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fCpVW8xXtAjiy+lHjQ8vuRPOTZ6Yswb3wmiJ6C1gOxD4PPs80PDCRTfEjwJ7js0Fx
         YlJ7JABUz9owixjvDI1eym+GF2gY/WYQ1VIwnCV/j6YwfG/T1LzwsNWEwup4LMn17d
         ahpVCvWGsRuQpJsP8Go6DW81OsM+fcJm+lh2orRphAb/ylMtiZWexMO3iON4J8ffjI
         zMVGVNPfNz9g7zFgYw/AZ8znVaGfNSj8AbX9L+5lMrxiMG7tF/A7AtE6sDKqK/UQnY
         jHklFRT7jj9ePANeT0WFgv+tdHbSd1BrpERZNt0M7KVZcD6tqQR18KGgVqJvIRAdyk
         ZMnFfZR4RqYwQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D1C8B1540395; Mon, 20 Mar 2023 18:11:38 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 01/14] tools/nolibc: always disable stack protector for tests
Date:   Mon, 20 Mar 2023 18:11:24 -0700
Message-Id: <20230321011137.51837-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <6a3206d0-e5cd-4990-9604-444a24a8207c@paulmck-laptop>
References: <6a3206d0-e5cd-4990-9604-444a24a8207c@paulmck-laptop>
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

From: Thomas Weißschuh <linux@weissschuh.net>

Stack protectors need support from libc.
This support is not provided by nolibc which leads to compiler errors
when stack protectors are enabled by default in a compiler:

      CC      nolibc-test
    /usr/bin/ld: /tmp/ccqbHEPk.o: in function `stat':
    nolibc-test.c:(.text+0x1d1): undefined reference to `__stack_chk_fail'
    /usr/bin/ld: /tmp/ccqbHEPk.o: in function `poll.constprop.0':
    nolibc-test.c:(.text+0x37b): undefined reference to `__stack_chk_fail'
    /usr/bin/ld: /tmp/ccqbHEPk.o: in function `vfprintf.constprop.0':
    nolibc-test.c:(.text+0x712): undefined reference to `__stack_chk_fail'
    /usr/bin/ld: /tmp/ccqbHEPk.o: in function `pad_spc.constprop.0':
    nolibc-test.c:(.text+0x80d): undefined reference to `__stack_chk_fail'
    /usr/bin/ld: /tmp/ccqbHEPk.o: in function `printf':
    nolibc-test.c:(.text+0x8c4): undefined reference to `__stack_chk_fail'
    /usr/bin/ld: /tmp/ccqbHEPk.o:nolibc-test.c:(.text+0x12d4): more undefined references to `__stack_chk_fail' follow
    collect2: error: ld returned 1 exit status

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 8fe61d3e3cce..874d141da8c4 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for nolibc tests
 include ../../../scripts/Makefile.include
+# We need this for the "cc-option" macro.
+include ../../../build/Build.include
 
 # we're in ".../tools/testing/selftests/nolibc"
 ifeq ($(srctree),)
@@ -72,6 +74,7 @@ endif
 
 CFLAGS_s390 = -m64
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables $(CFLAGS_$(ARCH))
+CFLAGS  += $(call cc-option,-fno-stack-protector)
 LDFLAGS := -s
 
 help:
-- 
2.40.0.rc2

