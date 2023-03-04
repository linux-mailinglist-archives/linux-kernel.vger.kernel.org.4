Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537726AAA6C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 15:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjCDO3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 09:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCDO3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 09:29:12 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5467975A
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 06:29:09 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 324ESto3006570;
        Sat, 4 Mar 2023 15:28:55 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     paulmck@kernel.org
Cc:     chenhuacai@loongson.cn, chenfeiyang@loongson.cn,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 1/5] tools/nolibc: add getuid() and geteuid()
Date:   Sat,  4 Mar 2023 15:28:40 +0100
Message-Id: <20230304142844.6522-2-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230304142844.6522-1-w@1wt.eu>
References: <20230304142844.6522-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can be useful to avoid attempting some privileged operations,
starting from the nolibc-test tool that gets two failures when not
privileged.

We call getuid32() and geteuid32() when they are defined, and fall
back to getuid() and geteuid() otherwise.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys.h | 42 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index b5f8cd35c03b..115579e7f1db 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -410,6 +410,27 @@ int getdents64(int fd, struct linux_dirent64 *dirp, int count)
 }
 
 
+/*
+ * uid_t geteuid(void);
+ */
+
+static __attribute__((unused))
+uid_t sys_geteuid(void)
+{
+#ifdef __NR_geteuid32
+	return my_syscall0(__NR_geteuid32);
+#else
+	return my_syscall0(__NR_geteuid);
+#endif
+}
+
+static __attribute__((unused))
+uid_t geteuid(void)
+{
+	return sys_geteuid();
+}
+
+
 /*
  * pid_t getpgid(pid_t pid);
  */
@@ -544,6 +565,27 @@ int gettimeofday(struct timeval *tv, struct timezone *tz)
 }
 
 
+/*
+ * uid_t getuid(void);
+ */
+
+static __attribute__((unused))
+uid_t sys_getuid(void)
+{
+#ifdef __NR_getuid32
+	return my_syscall0(__NR_getuid32);
+#else
+	return my_syscall0(__NR_getuid);
+#endif
+}
+
+static __attribute__((unused))
+uid_t getuid(void)
+{
+	return sys_getuid();
+}
+
+
 /*
  * int ioctl(int fd, unsigned long req, void *value);
  */
-- 
2.17.5

