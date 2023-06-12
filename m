Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDA172D10B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238370AbjFLUvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbjFLUs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:48:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489C61BC0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E30A162F25
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69403C433A7;
        Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602717;
        bh=3mb1rxDwK9cr6fcOzlDmnJ3xR72KXLUFJMoKYnLILJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mwdZ0t0b39BPc5o50RFl54UQdD61/ytGpKB+FK1kL111Fn8m/JfAgyQvZFZxEZZQZ
         7PtDNIZCqwNg5wkwkAvf1NXqBJkJuKfPw2IbFWVhkMM4yVVJrnYtgn3CrB/ZEjnx7e
         D4d8Uu6mnPLL8X481+fOe15uaQRiW6yfqxp1/oBPaKwLZk/CQGZWQnJ2TukfqY4LAq
         ZCL+j4XVrpGr9YWJ2hq4ja+GN/prKLRtX9K9iTIusOL5uhR/aNwr3rcXx8g9SwW3jQ
         s/aXPLp4mBSGsxNYTS4Ntn0/p10seF2hv4Vy8t3kdADhSgjT97hC4OC1dyk9qWwPU7
         1BeZNP2X518Qg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 24B09CE3A1C; Mon, 12 Jun 2023 13:45:16 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Zhangjin Wu <falcon@tinylab.org>, Willy Tarreau <w@1wt.eu>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 49/53] selftests/nolibc: support two errnos with EXPECT_SYSER2()
Date:   Mon, 12 Jun 2023 13:45:10 -0700
Message-Id: <20230612204514.292087-49-paulmck@kernel.org>
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

From: Zhangjin Wu <falcon@tinylab.org>

Some functions may be implemented with different syscalls in different
platforms, these syscalls may set different errnos for the same
arguments, let's support such cases.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/linux-riscv/20230528113325.GJ1956@1wt.eu/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index ff3da9539809..7896bc3f609e 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -300,18 +300,24 @@ static int expect_sysne(int expr, int llen, int val)
 }
 
 
+#define EXPECT_SYSER2(cond, expr, expret, experr1, experr2)		\
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_syserr2(expr, expret, experr1, experr2, llen); } while (0)
+
 #define EXPECT_SYSER(cond, expr, expret, experr)			\
-	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_syserr(expr, expret, experr, llen); } while (0)
+	EXPECT_SYSER2(cond, expr, expret, experr, 0)
 
-static int expect_syserr(int expr, int expret, int experr, int llen)
+static int expect_syserr2(int expr, int expret, int experr1, int experr2, int llen)
 {
 	int ret = 0;
 	int _errno = errno;
 
 	llen += printf(" = %d %s ", expr, errorname(_errno));
-	if (expr != expret || _errno != experr) {
+	if (expr != expret || (_errno != experr1 && _errno != experr2)) {
 		ret = 1;
-		llen += printf(" != (%d %s) ", expret, errorname(experr));
+		if (experr2 == 0)
+			llen += printf(" != (%d %s) ", expret, errorname(experr1));
+		else
+			llen += printf(" != (%d %s %s) ", expret, errorname(experr1), errorname(experr2));
 		llen += pad_spc(llen, 64, "[FAIL]\n");
 	} else {
 		llen += pad_spc(llen, 64, " [OK]\n");
-- 
2.40.1

