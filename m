Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4054A6D3621
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 10:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjDBIOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 04:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjDBIOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 04:14:11 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89B931A465
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 01:14:10 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3328E4kc012124;
        Sun, 2 Apr 2023 10:14:04 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux@weissschuh.net, v@vda.io, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 2/2] tools/nolibc: fix build of the test case using glibc
Date:   Sun,  2 Apr 2023 10:13:57 +0200
Message-Id: <20230402081357.12078-3-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230402081357.12078-1-w@1wt.eu>
References: <20230402081357.12078-1-w@1wt.eu>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some extra tests for various integer types and limits were added by
commit d1209597ff00 ("tools/nolibc: add tests for the integer limits
in stdint.h"), but we forgot to retest with glibc. Stddef and stdint
are now needed for the program to build there.

Cc: Vincent Dagonneau <v@vda.io>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 6f2f109569a3..1bafbd8da6af 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -34,6 +34,8 @@
 #include <sched.h>
 #include <signal.h>
 #include <stdarg.h>
+#include <stddef.h>
+#include <stdint.h>
 #include <unistd.h>
 #endif
 #endif
-- 
2.17.5

