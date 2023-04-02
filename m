Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CB26D3620
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 10:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjDBIOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 04:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjDBIOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 04:14:11 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19E421A443
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 01:14:09 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3328E30a012123;
        Sun, 2 Apr 2023 10:14:03 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux@weissschuh.net, v@vda.io, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 1/2] tools/nolibc: tests: fix build on non-c99 compliant compilers
Date:   Sun,  2 Apr 2023 10:13:56 +0200
Message-Id: <20230402081357.12078-2-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230402081357.12078-1-w@1wt.eu>
References: <20230402081357.12078-1-w@1wt.eu>
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

Commit 9735716830f2 ("tools/nolibc: tests: add test for -fstack-protector")
brought a declaration inside the initialization statement of a for loop,
which breaks the build on compilers that do not default to c99
compatibility, making it more difficult to validate that the lib still
builds on such compilers. The fix is trivial, so let's move the
declaration to the variables block of the function instead. No backport
is needed.

Cc: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 47013b78972e..6f2f109569a3 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -671,8 +671,9 @@ static int smash_stack(void)
 {
 	char buf[100];
 	volatile char *ptr = buf;
+	size_t i;
 
-	for (size_t i = 0; i < 200; i++)
+	for (i = 0; i < 200; i++)
 		ptr[i] = 'P';
 
 	return 1;
-- 
2.17.5

