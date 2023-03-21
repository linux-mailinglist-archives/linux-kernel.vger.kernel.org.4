Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189B16C276A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 02:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjCUBYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 21:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjCUBYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:24:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A592728E98
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 18:24:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33BD9B811C3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBA6C4339E;
        Tue, 21 Mar 2023 01:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679361099;
        bh=tdYkPh59mpPBLtefCTS0P4bFAwFRVtfHKbi4mc8Dr4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nccVPcKqXasqtjfsvpZHJs5MhCoy2mT7q4zuGQ1iW/syWQKgFNqRkMQtQVcZ3wY9N
         fy9v+rEhD6/OgK6TELyMBy9rImlvThdq4GBHxcI9nZQSwPBMDhBJWvtDN9z6Jf6XsK
         z4kHgGo2aVcbMO9zNp8VJUyctEDQto3seZPqiwiOaKHXEjo7sJaf/bl5S1TcrQPiEY
         ZZlOgPSnmCVqE1gSH50iebMYRbwmDG2pbfMhQHa7Hu0d3gqVzykhRF+GiWTS/Y5NlP
         7nz4t0AiW6opzYHAgvAVCtJM4O3jqqTPx9Aq2eLYxX9eDY03N/TDaXRKio0U94TOHV
         GdZ7Mstu2wd/g==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id ECD2115403A0; Mon, 20 Mar 2023 18:11:38 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 08/14] selftests/nolibc: skip the chroot_root and link_dir tests when not privileged
Date:   Mon, 20 Mar 2023 18:11:31 -0700
Message-Id: <20230321011137.51837-8-paulmck@kernel.org>
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

These two tests always fail when the program is started natively as an
unprivileged user, and require the user to carefully check the output
of "make run-user" and ignore them.

Let's add an euid check and condition these two tests to euid==0. Now
the test case stops needlessly reporting failures. E.g.:

  $ make -C tools/testing/selftests/nolibc run-user
  ...
    CC      nolibc-test
  123 test(s) passed.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 772f88bda0f1..6a7c13f0cd61 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -477,6 +477,7 @@ static int test_getpagesize(void)
 int run_syscall(int min, int max)
 {
 	struct stat stat_buf;
+	int euid0;
 	int proc;
 	int test;
 	int tmp;
@@ -486,6 +487,9 @@ int run_syscall(int min, int max)
 	/* <proc> indicates whether or not /proc is mounted */
 	proc = stat("/proc", &stat_buf) == 0;
 
+	/* this will be used to skip certain tests that can't be run unprivileged */
+	euid0 = geteuid() == 0;
+
 	for (test = min; test >= 0 && test <= max; test++) {
 		int llen = 0; // line length
 
@@ -511,7 +515,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(chmod_net);         EXPECT_SYSZR(proc, chmod("/proc/self/net", 0555)); break;
 		CASE_TEST(chmod_self);        EXPECT_SYSER(proc, chmod("/proc/self", 0555), -1, EPERM); break;
 		CASE_TEST(chown_self);        EXPECT_SYSER(proc, chown("/proc/self", 0, 0), -1, EPERM); break;
-		CASE_TEST(chroot_root);       EXPECT_SYSZR(1, chroot("/")); break;
+		CASE_TEST(chroot_root);       EXPECT_SYSZR(euid0, chroot("/")); break;
 		CASE_TEST(chroot_blah);       EXPECT_SYSER(1, chroot("/proc/self/blah"), -1, ENOENT); break;
 		CASE_TEST(chroot_exe);        EXPECT_SYSER(proc, chroot("/proc/self/exe"), -1, ENOTDIR); break;
 		CASE_TEST(close_m1);          EXPECT_SYSER(1, close(-1), -1, EBADF); break;
@@ -536,7 +540,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
 		CASE_TEST(link_root1);        EXPECT_SYSER(1, link("/", "/"), -1, EEXIST); break;
 		CASE_TEST(link_blah);         EXPECT_SYSER(1, link("/proc/self/blah", "/blah"), -1, ENOENT); break;
-		CASE_TEST(link_dir);          EXPECT_SYSER(1, link("/", "/blah"), -1, EPERM); break;
+		CASE_TEST(link_dir);          EXPECT_SYSER(euid0, link("/", "/blah"), -1, EPERM); break;
 		CASE_TEST(link_cross);        EXPECT_SYSER(proc, link("/proc/self/net", "/blah"), -1, EXDEV); break;
 		CASE_TEST(lseek_m1);          EXPECT_SYSER(1, lseek(-1, 0, SEEK_SET), -1, EBADF); break;
 		CASE_TEST(lseek_0);           EXPECT_SYSER(1, lseek(0, 0, SEEK_SET), -1, ESPIPE); break;
-- 
2.40.0.rc2

