Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574D5661F84
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbjAIH4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbjAIHzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:55:46 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F46013D64
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 23:55:44 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3097soGv026020;
        Mon, 9 Jan 2023 08:54:50 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 6/6] tools/nolibc: fix the O_* fcntl/open macro definitions for riscv
Date:   Mon,  9 Jan 2023 08:54:42 +0100
Message-Id: <20230109075442.25963-7-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230109075442.25963-1-w@1wt.eu>
References: <20230109075442.25963-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When RISCV port was imported in 5.2, the O_* macros were taken with
their octal value and written as-is in hex, resulting in the getdents64()
to fail in nolibc-test.

Fixes: 582e84f7b779 ("tool headers nolibc: add RISCV support") #5.2
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/arch-riscv.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index ba04771cb3a3..a3bdd9803f8c 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -11,13 +11,13 @@
 #define O_RDONLY            0
 #define O_WRONLY            1
 #define O_RDWR              2
-#define O_CREAT         0x100
-#define O_EXCL          0x200
-#define O_NOCTTY        0x400
-#define O_TRUNC        0x1000
-#define O_APPEND       0x2000
-#define O_NONBLOCK     0x4000
-#define O_DIRECTORY  0x200000
+#define O_CREAT          0x40
+#define O_EXCL           0x80
+#define O_NOCTTY        0x100
+#define O_TRUNC         0x200
+#define O_APPEND        0x400
+#define O_NONBLOCK      0x800
+#define O_DIRECTORY   0x10000
 
 struct sys_stat_struct {
 	unsigned long	st_dev;		/* Device.  */
-- 
2.35.3

