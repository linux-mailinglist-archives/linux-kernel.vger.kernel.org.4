Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3FB72D113
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238309AbjFLUtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjFLUrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:47:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172CF2967
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B66AB62F18
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42767C4332A;
        Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602717;
        bh=0zt8I95z1HUq9EJL6kDDSqhW2E6bfWG/BgIkZcsxQ8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WX9V9qKLsrktkGY0S+pZbFzmbFyCgZjOfy8DMZKbSGE+YoFb3FPDQCpbgLs+Dxyfs
         ATd7B767sG4SF1yANN+ZOAcNqeawVfzRtZae3RHkoTsytEbvlLurC1P6tsl28JACzW
         CuPsVGv1peAkwoZ1Qoy8hMk28mfZVyH6q212xIH4vAuyv9VyMIQK+4a0I6kJe7aUf2
         h6Pa1HFguJCyUpstDl3nePUREzp/QG6kWfev3YWSBqJ82Kpf2T3i7nM7JhZEhAKj1K
         cdznNUPJxW7S2jeuqIUWJ3g2Au6A9WCCyHHtAd+NaMdRz1jbkC8KfGRHE73coZdt+u
         amTfMpPOlTfxg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 10216CE3A85; Mon, 12 Jun 2023 13:45:16 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Zhangjin Wu <falcon@tinylab.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 40/53] selftests/nolibc: test_fork: fix up duplicated print
Date:   Mon, 12 Jun 2023 13:45:01 -0700
Message-Id: <20230612204514.292087-40-paulmck@kernel.org>
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

running nolibc-test with glibc on x86_64 got such print issue:

    29 execve_root = -1 EACCES                                       [OK]
    30 fork30 fork = 0                                                      [OK]
    31 getdents64_root = 712                                         [OK]

The fork test case has three printf calls:

    (1) llen += printf("%d %s", test, #name);
    (2) llen += printf(" = %d %s ", expr, errorname(errno));
    (3) llen += pad_spc(llen, 64, "[FAIL]\n"); --> vfprintf()

In the following scene, the above issue happens:

    (a) The parent calls (1)
    (b) The parent calls fork()
    (c) The child runs and shares the print buffer of (1)
    (d) The child exits, flushs the print buffer and closes its own stdout/stderr
        * "30 fork" is printed at the first time.
    (e) The parent calls (2) and (3), with "\n" in (3), it flushs the whole buffer
        * "30 fork = 0 ..." is printed

Therefore, there are two "30 fork" in the stdout.

Between (a) and (b), if flush the stdout (and the sterr), the child in
stage (c) will not be able to 'see' the print buffer.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index d417ca5d976f..fa18e7dc35c8 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -486,7 +486,13 @@ static int test_getpagesize(void)
 static int test_fork(void)
 {
 	int status;
-	pid_t pid = fork();
+	pid_t pid;
+
+	/* flush the printf buffer to avoid child flush it */
+	fflush(stdout);
+	fflush(stderr);
+
+	pid = fork();
 
 	switch (pid) {
 	case -1:
-- 
2.40.1

