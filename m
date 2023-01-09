Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F84F66207F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbjAIIrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237010AbjAIIqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:46:21 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04199140C1
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:42:58 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3098gC9b027424;
        Mon, 9 Jan 2023 09:42:12 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 05/22] tools/nolibc: make errno a weak symbol instead of a static one
Date:   Mon,  9 Jan 2023 09:41:51 +0100
Message-Id: <20230109084208.27355-6-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230109084208.27355-1-w@1wt.eu>
References: <20230109084208.27355-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Till now errno was declared static so that it could be eliminated if
unused. While the goal is commendable for tiny executables as it allows
to eliminate any data and bss segments when not used, this comes with
some limitations, one of which being that the errno symbol seen in
different units are not the same. Even though this has never been a
real issue given the nature of the programs involved till now, it
happens that referencing the same symbol from multiple units can also
be achieved using weak symbols, with a difference being that only one
of them will be used for all of them. Compared to weak symbols, static
basically have no benefit for regular programs since there are always
at least a few variables in most of these, so the bss segment cannot
be eliminated. E.g:

  $ size nolibc-test-static-errno
     text    data     bss     dec     hex filename
    11531       0      48   11579    2d3b nolibc-test-static-errno

Furthermore, the weak symbol doesn't use bss storage at all, resulting
in a slightly section:

  $ size nolibc-test-weak-errno
     text    data     bss     dec     hex filename
    11531       0      40   11571    2d33 nolibc-test-weak-errno

This patch thus converts errno from static to weak.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/errno.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/include/nolibc/errno.h b/tools/include/nolibc/errno.h
index 9dc4919c769b..a44486ff0477 100644
--- a/tools/include/nolibc/errno.h
+++ b/tools/include/nolibc/errno.h
@@ -9,11 +9,9 @@
 
 #include <asm/errno.h>
 
-/* this way it will be removed if unused */
-static int errno;
-
 #ifndef NOLIBC_IGNORE_ERRNO
 #define SET_ERRNO(v) do { errno = (v); } while (0)
+int errno __attribute__((weak));
 #else
 #define SET_ERRNO(v) do { } while (0)
 #endif
-- 
2.17.5

