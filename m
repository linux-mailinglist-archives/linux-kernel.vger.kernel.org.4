Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F1A6639F5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbjAJH1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 02:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237938AbjAJH1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:27:13 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CA761001
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 23:25:58 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30A7OeHk003948;
        Tue, 10 Jan 2023 08:24:40 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v2 21/22] nolibc/sys: Implement `getpagesize(2)` function
Date:   Tue, 10 Jan 2023 08:24:33 +0100
Message-Id: <20230110072434.3863-22-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230110072434.3863-1-w@1wt.eu>
References: <20230110072434.3863-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

This function returns the page size used by the running kernel. The
page size value is taken from the auxiliary vector at 'AT_PAGESZ' key.

'getpagesize(2)' is assumed as a syscall becuase the manpage placement
of this function is in entry 2 ('man 2 getpagesize') despite there is
no real 'getpagesize(2)' syscall in the Linux syscall table. Define
this function in 'sys.h'.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 47bf67668860..b5f8cd35c03b 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -19,6 +19,7 @@
 #include <linux/fs.h>
 #include <linux/loop.h>
 #include <linux/time.h>
+#include <linux/auxvec.h>
 
 #include "arch.h"
 #include "errno.h"
@@ -499,6 +500,26 @@ pid_t gettid(void)
 	return sys_gettid();
 }
 
+static unsigned long getauxval(unsigned long key);
+
+/*
+ * long getpagesize(void);
+ */
+
+static __attribute__((unused))
+long getpagesize(void)
+{
+	long ret;
+
+	ret = getauxval(AT_PAGESZ);
+	if (!ret) {
+		SET_ERRNO(ENOENT);
+		return -1;
+	}
+
+	return ret;
+}
+
 
 /*
  * int gettimeofday(struct timeval *tv, struct timezone *tz);
-- 
2.17.5

