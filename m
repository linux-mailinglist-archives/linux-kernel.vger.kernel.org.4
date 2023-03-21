Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A95A6C2722
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 02:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCUBOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 21:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjCUBOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:14:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52EF1FE3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 18:13:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30001B811C2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911A2C433A1;
        Tue, 21 Mar 2023 01:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679361099;
        bh=TtxwyZ2yyBdV44Bz3Oj230Ni7X2FI+pFx4BXXurJI4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mj3U2cHM9CdZOnyGRS+2vZ70cuWOXcFb7SjpFE5x/bitMYYONegiZpty1MCYenuHd
         aTtJ/eFoAL5naFO24Dq2q+gJA0A26POMqlCuLubkKpW8DOQ0Lc2XmnxJBGt1BncJSr
         w9F8u8BuKWo/9kl13ZquH412PM/JQBIzx3YdX9AC0LYHAWQnXlKRo+Pm1rvF9TUYhM
         aAcnLR7usFuQoYyEhnoX5gWsEOaXegRZAZXcXT0f7/HXqJKgo93YCUtBn1jJp5sVi1
         y3ahVFvC9OXn0VeFStya0K/y4a1Ru1pgL8ozyKEYbvWtJroUM5MOn5SaBt8Eeq6wP/
         GpiZMru7Uo0ug==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E9670154039F; Mon, 20 Mar 2023 18:11:38 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 07/14] tools/nolibc: add getuid() and geteuid()
Date:   Mon, 20 Mar 2023 18:11:30 -0700
Message-Id: <20230321011137.51837-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <6a3206d0-e5cd-4990-9604-444a24a8207c@paulmck-laptop>
References: <6a3206d0-e5cd-4990-9604-444a24a8207c@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau <w@1wt.eu>

This can be useful to avoid attempting some privileged operations,
starting from the nolibc-test tool that gets two failures when not
privileged.

We call getuid32() and geteuid32() when they are defined, and fall
back to getuid() and geteuid() otherwise.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
2.40.0.rc2

