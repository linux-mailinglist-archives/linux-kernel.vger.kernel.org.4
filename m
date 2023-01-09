Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3890166206E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbjAIInO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236844AbjAIImX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:42:23 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8045012D2D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:42:22 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3098gFRG027439;
        Mon, 9 Jan 2023 09:42:15 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH 20/22] nolibc/stdlib: Implement `getauxval(3)` function
Date:   Mon,  9 Jan 2023 09:42:06 +0100
Message-Id: <20230109084208.27355-21-w@1wt.eu>
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

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

Previous commits save the address of the auxiliary vector into a global
variable @_auxv. This commit creates a new function 'getauxval()' as a
helper function to get the auxv value based on the given key.

The behavior of this function is identic with the function documented
in 'man 3 getauxval'. This function is also needed to implement
'getpagesize()' function that we will wire up in the next patches.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/stdlib.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index a24000d1e822..894c955d027e 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -12,6 +12,7 @@
 #include "types.h"
 #include "sys.h"
 #include "string.h"
+#include <linux/auxvec.h>
 
 struct nolibc_heap {
 	size_t	len;
@@ -108,6 +109,32 @@ char *getenv(const char *name)
 	return _getenv(name, environ);
 }
 
+static __attribute__((unused))
+unsigned long getauxval(unsigned long type)
+{
+	const unsigned long *auxv = _auxv;
+	unsigned long ret;
+
+	if (!auxv)
+		return 0;
+
+	while (1) {
+		if (!auxv[0] && !auxv[1]) {
+			ret = 0;
+			break;
+		}
+
+		if (auxv[0] == type) {
+			ret = auxv[1];
+			break;
+		}
+
+		auxv += 2;
+	}
+
+	return ret;
+}
+
 static __attribute__((unused))
 void *malloc(size_t len)
 {
-- 
2.17.5

