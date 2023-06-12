Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7415D72D115
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbjFLUvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238225AbjFLUt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:49:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6189410FA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:47:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05FEB62F2C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8F6C433A8;
        Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602717;
        bh=169K0FYgwINVjwhMoliOpWOqrdexyS9jQw6SkXAUMq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TFlmnBI++Cbbi6mA9MNQOX7y2dKwK2tr7gq6Rr5+noFltmNnqvuZ9VEIKS5RwqSlg
         +2TXs4igXdebipyGxk9hwotbhqRPavFWP8o2hshow0oG8UBWClDNjWD5ZFTKyBZoug
         Fc/qdSUAfP/q4/+2mPWBx1zR+jD55cNDPXkJCJQ/8Px1KkIvFUlU72YdCmlIWMVUgq
         TBjhc9JN7Zv5sQTmBof1xp6SNUuaU91q1JFvW5pZW5xWQIYq+QgX0/Fz76S+TI71v3
         QvBGgigXXUFt0/OJ9H/HZFx3iN6u6re2Vyt6S1zbcwuGg3bT2zYm8lIqyKMcRF3ClA
         hY1JZwX9rvldw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 292D4CE3A93; Mon, 12 Jun 2023 13:45:16 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Zhangjin Wu <falcon@tinylab.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 51/53] selftests/nolibc: add new gettimeofday test cases
Date:   Mon, 12 Jun 2023 13:45:12 -0700
Message-Id: <20230612204514.292087-51-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
References: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhangjin Wu <falcon@tinylab.org>

These 2 test cases are added to cover the normal using scenes of
gettimeofday().

They have been used to trigger and fix up such issue with nolibc:

    nolibc-test.c:(.text.gettimeofday+0x54): undefined reference to `__aeabi_ldivmod'

This issue happens while there is no "unsigned int" conversion in the
coming new clock_gettime / clock_gettime64 syscall path of
gettimeofday():

    tv->tv_usec = ts.tv_nsec / 1000;

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/linux-riscv/280867a8-7601-4a96-9b85-87668e1f1282@t-8ch.de/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index b1f3ad25de35..486334981e60 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -539,6 +539,8 @@ static int test_stat_timestamps(void)
  */
 int run_syscall(int min, int max)
 {
+	struct timeval tv;
+	struct timezone tz;
 	struct stat stat_buf;
 	int euid0;
 	int proc;
@@ -593,6 +595,8 @@ int run_syscall(int min, int max)
 		CASE_TEST(fork);              EXPECT_SYSZR(1, test_fork()); break;
 		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
 		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;
+		CASE_TEST(gettimeofday_tv);   EXPECT_SYSZR(1, gettimeofday(&tv, NULL)); break;
+		CASE_TEST(gettimeofday_tv_tz);EXPECT_SYSZR(1, gettimeofday(&tv, &tz)); break;
 		CASE_TEST(getpagesize);       EXPECT_SYSZR(1, test_getpagesize()); break;
 		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
 		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
-- 
2.40.1

