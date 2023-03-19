Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13876C0225
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 14:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjCSNvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 09:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjCSNv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 09:51:27 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59FE118A8C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 06:51:25 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 32JDpDh3031996;
        Sun, 19 Mar 2023 14:51:13 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 1/1] tools/nolibc: always disable stack protector for tests
Date:   Sun, 19 Mar 2023 14:51:00 +0100
Message-Id: <20230319135100.31952-2-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230319135100.31952-1-w@1wt.eu>
References: <20230319135100.31952-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
2.17.5

