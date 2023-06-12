Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C5272D0FB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjFLUsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjFLUrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:47:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFE8198E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B56B62F01
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8314C433EF;
        Mon, 12 Jun 2023 20:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602716;
        bh=gQgf+u3NBWRBckdfBH59WpO3TYAdJrxhNyjBgomyf/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z4tZYLuGu9qQc2msHRhMR2GA/ycznYe5DLVs0YBXqDL+91RFnKWySPRk4Uy59aGTn
         ee0mJ4EU6Iutt+Msxb7t1LwiLP9NLeauzS81LAUKJjL+hdQ3M2ei3ryIr7RulwmiqQ
         X3hmBvpGVi+OhtkBxPyw5+0cOgjINMWRz1O+kmmaQrBiGvCX9WSBs2DCMlv1lV8E5t
         ZfUhPazdoTmtFCv6U9EdUDo0dYY58ni+tj14U/8C4URTPZ7Umu3MFkE8mKR51iHGjj
         q/MXI3FP7s3SKNykmPVSIvqwCrkrshSAl73DmBfcYcxodpBNnsAJLnjh6ryOXyeXYR
         fcQrhr1hpGT1A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CF971CE3A59; Mon, 12 Jun 2023 13:45:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 17/53] tools/nolibc/unistd: add syscall()
Date:   Mon, 12 Jun 2023 13:44:38 -0700
Message-Id: <20230612204514.292087-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
References: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

syscall() is used by "normal" libcs to allow users to directly call
syscalls.
By having the same syntax inside nolibc users can more easily write code
that works with different libcs.

The macro logic is adapted from systemtaps STAP_PROBEV() macro that is
released in the public domain / CC0.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/unistd.h                | 15 +++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/tools/include/nolibc/unistd.h b/tools/include/nolibc/unistd.h
index ac7d53d986cd..0e832e10a0b2 100644
--- a/tools/include/nolibc/unistd.h
+++ b/tools/include/nolibc/unistd.h
@@ -56,6 +56,21 @@ int tcsetpgrp(int fd, pid_t pid)
 	return ioctl(fd, TIOCSPGRP, &pid);
 }
 
+#define _syscall(N, ...)                                                      \
+({                                                                            \
+	long _ret = my_syscall##N(__VA_ARGS__);                               \
+	if (_ret < 0) {                                                       \
+		SET_ERRNO(-_ret);                                             \
+		_ret = -1;                                                    \
+	}                                                                     \
+	_ret;                                                                 \
+})
+
+#define _syscall_narg(...) __syscall_narg(__VA_ARGS__, 6, 5, 4, 3, 2, 1, 0)
+#define __syscall_narg(_0, _1, _2, _3, _4, _5, _6, N, ...) N
+#define _syscall_n(N, ...) _syscall(N, __VA_ARGS__)
+#define syscall(...) _syscall_n(_syscall_narg(__VA_ARGS__), ##__VA_ARGS__)
+
 /* make sure to include all global symbols */
 #include "nolibc.h"
 
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index f042a6436b6b..54bf91847af3 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -588,6 +588,8 @@ int run_syscall(int min, int max)
 		CASE_TEST(waitpid_child);     EXPECT_SYSER(1, waitpid(getpid(), &tmp, WNOHANG), -1, ECHILD); break;
 		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), -1, EBADF); break;
 		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
+		CASE_TEST(syscall_noargs);    EXPECT_SYSEQ(1, syscall(__NR_getpid), getpid()); break;
+		CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_fstat, 0, NULL), -1, EFAULT); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */
-- 
2.40.1

