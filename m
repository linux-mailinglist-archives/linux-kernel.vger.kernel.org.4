Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F8D6C8F11
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 16:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjCYPpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 11:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjCYPps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 11:45:48 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 814C312079
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 08:45:46 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 32PFjQRv008050;
        Sat, 25 Mar 2023 16:45:26 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 5/8] tools/nolibc: tests: fold in no-stack-protector cflags
Date:   Sat, 25 Mar 2023 16:45:13 +0100
Message-Id: <20230325154516.7995-6-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230325154516.7995-1-w@1wt.eu>
References: <20230325154516.7995-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

For the cflags to enable stack protectors to work properly they need to
be specified after -fno-stack-protector.

To do this fold all cflags into a single variable and move
-fno-stack-protector before the arch-specific cflags and another
one specific to stack protectors since we don't want to enable them
on all archs.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index c99bbcda7495..4469dcb0c9d7 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -77,8 +77,9 @@ Q=@
 endif
 
 CFLAGS_s390 = -m64
-CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables $(CFLAGS_$(ARCH))
-CFLAGS  += $(call cc-option,-fno-stack-protector)
+CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables \
+		$(call cc-option,-fno-stack-protector) \
+		$(CFLAGS_STKP_$(ARCH)) $(CFLAGS_$(ARCH))
 LDFLAGS := -s
 
 help:
-- 
2.17.5

