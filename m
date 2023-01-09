Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B7E661F7E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbjAIHze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbjAIHzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:55:25 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D128913DE9
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 23:55:15 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3097sos7026016;
        Mon, 9 Jan 2023 08:54:50 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Warner Losh <imp@bsdimp.com>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 2/6] tools/nolibc: Fix S_ISxxx macros
Date:   Mon,  9 Jan 2023 08:54:38 +0100
Message-Id: <20230109075442.25963-3-w@1wt.eu>
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

From: Warner Losh <imp@bsdimp.com>

The mode field has the type encoded as an value in a field, not as a bit
mask. Mask the mode with S_IFMT instead of each type to test. Otherwise,
false positives are possible: eg S_ISDIR will return true for block
devices because S_IFDIR = 0040000 and S_IFBLK = 0060000 since mode is
masked with S_IFDIR instead of S_IFMT. These macros now match the
similar definitions in tools/include/uapi/linux/stat.h.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/types.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 300e0ff1cd58..f1d64fca7cf0 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -26,13 +26,13 @@
 #define S_IFSOCK       0140000
 #define S_IFMT         0170000
 
-#define S_ISDIR(mode)  (((mode) & S_IFDIR)  == S_IFDIR)
-#define S_ISCHR(mode)  (((mode) & S_IFCHR)  == S_IFCHR)
-#define S_ISBLK(mode)  (((mode) & S_IFBLK)  == S_IFBLK)
-#define S_ISREG(mode)  (((mode) & S_IFREG)  == S_IFREG)
-#define S_ISFIFO(mode) (((mode) & S_IFIFO)  == S_IFIFO)
-#define S_ISLNK(mode)  (((mode) & S_IFLNK)  == S_IFLNK)
-#define S_ISSOCK(mode) (((mode) & S_IFSOCK) == S_IFSOCK)
+#define S_ISDIR(mode)  (((mode) & S_IFMT) == S_IFDIR)
+#define S_ISCHR(mode)  (((mode) & S_IFMT) == S_IFCHR)
+#define S_ISBLK(mode)  (((mode) & S_IFMT) == S_IFBLK)
+#define S_ISREG(mode)  (((mode) & S_IFMT) == S_IFREG)
+#define S_ISFIFO(mode) (((mode) & S_IFMT) == S_IFIFO)
+#define S_ISLNK(mode)  (((mode) & S_IFMT) == S_IFLNK)
+#define S_ISSOCK(mode) (((mode) & S_IFMT) == S_IFSOCK)
 
 /* dirent types */
 #define DT_UNKNOWN     0x0
-- 
2.35.3

