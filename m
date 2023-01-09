Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5239661F7D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbjAIHzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbjAIHzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:55:06 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 153BADF3B
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 23:55:04 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3097sn4s026015;
        Mon, 9 Jan 2023 08:54:49 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 1/6] nolibc: fix fd_set type
Date:   Mon,  9 Jan 2023 08:54:37 +0100
Message-Id: <20230109075442.25963-2-w@1wt.eu>
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

From: Sven Schnelle <svens@linux.ibm.com>

The kernel uses unsigned long for the fd_set bitmap,
but nolibc use u32. This works fine on little endian
machines, but fails on big endian. Convert to unsigned
long to fix this.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/types.h | 53 ++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 959997034e55..300e0ff1cd58 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -89,39 +89,46 @@
 #define EXIT_SUCCESS 0
 #define EXIT_FAILURE 1
 
+#define FD_SETIDXMASK (8 * sizeof(unsigned long))
+#define FD_SETBITMASK (8 * sizeof(unsigned long)-1)
+
 /* for select() */
 typedef struct {
-	uint32_t fd32[(FD_SETSIZE + 31) / 32];
+	unsigned long fds[(FD_SETSIZE + FD_SETBITMASK) / FD_SETIDXMASK];
 } fd_set;
 
-#define FD_CLR(fd, set) do {                                            \
-		fd_set *__set = (set);                                  \
-		int __fd = (fd);                                        \
-		if (__fd >= 0)                                          \
-			__set->fd32[__fd / 32] &= ~(1U << (__fd & 31)); \
+#define FD_CLR(fd, set) do {						\
+		fd_set *__set = (set);					\
+		int __fd = (fd);					\
+		if (__fd >= 0)						\
+			__set->fds[__fd / FD_SETIDXMASK] &=		\
+				~(1U << (__fd & FX_SETBITMASK));	\
 	} while (0)
 
-#define FD_SET(fd, set) do {                                            \
-		fd_set *__set = (set);                                  \
-		int __fd = (fd);                                        \
-		if (__fd >= 0)                                          \
-			__set->fd32[__fd / 32] |= 1U << (__fd & 31);    \
+#define FD_SET(fd, set) do {						\
+		fd_set *__set = (set);					\
+		int __fd = (fd);					\
+		if (__fd >= 0)						\
+			__set->fds[__fd / FD_SETIDXMASK] |=		\
+				1 << (__fd & FD_SETBITMASK);		\
 	} while (0)
 
-#define FD_ISSET(fd, set) ({                                                  \
-		fd_set *__set = (set);                                        \
-		int __fd = (fd);                                              \
-		int __r = 0;                                                  \
-		if (__fd >= 0)                                                \
-			__r = !!(__set->fd32[__fd / 32] & 1U << (__fd & 31)); \
-		__r;                                                          \
+#define FD_ISSET(fd, set) ({						\
+			fd_set *__set = (set);				\
+			int __fd = (fd);				\
+		int __r = 0;						\
+		if (__fd >= 0)						\
+			__r = !!(__set->fds[__fd / FD_SETIDXMASK] &	\
+1U << (__fd & FD_SET_BITMASK));						\
+		__r;							\
 	})
 
-#define FD_ZERO(set) do {                                               \
-		fd_set *__set = (set);                                  \
-		int __idx;                                              \
-		for (__idx = 0; __idx < (FD_SETSIZE+31) / 32; __idx ++) \
-			__set->fd32[__idx] = 0;                         \
+#define FD_ZERO(set) do {						\
+		fd_set *__set = (set);					\
+		int __idx;						\
+		int __size = (FD_SETSIZE+FD_SETBITMASK) / FD_SETIDXMASK;\
+		for (__idx = 0; __idx < __size; __idx++)		\
+			__set->fds[__idx] = 0;				\
 	} while (0)
 
 /* for poll() */
-- 
2.35.3

