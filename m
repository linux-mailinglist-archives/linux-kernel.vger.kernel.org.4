Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A9B6CC7BE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjC1QTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjC1QTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:19:08 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AE61D533
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 09:19:06 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 32SGJ0Z4009628;
        Tue, 28 Mar 2023 18:19:00 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 1/1] tools/nolibc: tests: use volatile to force stack smashing
Date:   Tue, 28 Mar 2023 18:18:45 +0200
Message-Id: <20230328161845.9584-2-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230328161845.9584-1-w@1wt.eu>
References: <20230328161845.9584-1-w@1wt.eu>
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

Use a volatile pointer to write outside the buffer so the compiler can't
optimize it away.

Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
Link: https://lore.kernel.org/lkml/c0584807-511c-4496-b062-1263ea38f349@p183/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 21bacc928bf7..47013b78972e 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -667,17 +667,13 @@ int run_stdlib(int min, int max)
 	return ret;
 }
 
-#if defined(__clang__)
-__attribute__((optnone))
-#elif defined(__GNUC__)
-__attribute__((optimize("O0")))
-#endif
 static int smash_stack(void)
 {
 	char buf[100];
+	volatile char *ptr = buf;
 
 	for (size_t i = 0; i < 200; i++)
-		buf[i] = 'P';
+		ptr[i] = 'P';
 
 	return 1;
 }
-- 
2.17.5

