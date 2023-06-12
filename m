Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F176E72D0F5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238069AbjFLUtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbjFLUrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:47:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C074919A7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A38D062F0F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9BFC4331E;
        Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602717;
        bh=NIJsLUCkPm+SlEyAKKZ+JWMSEL2gT9Xxru+zz8R8kig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qdpXve/ZQctJnAKEwXta+3CR84M0ydiwRgzAwsMvH+1IVHWwYSAf8I9HzbiRvUT6W
         nEL3XqqPScLydNBucfB4/Cb4mpR/g1Y7Vtna80a8ClLUjqDHRezODsChULKNiX/6ei
         luDd3+JfPrEVZx35Vol9KWiwWvMGJQyvjjiweLJtztuodVVrYaLIMO51atRhVQHFkK
         qFpZ5OnQPZ7rbvCIAgYjoeeAHPrbiLeftANE8uGxkAbFZoM4PJPF5b7a9jekXnMmyq
         uEVUTxmMD17Xrm85eTlMWXeDc0vigOnVMnGYXpA/FtSVSUaG9/jJqfCit1c3KMqxKo
         9f0Tw0/Q+ABew==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E89F0CE3A70; Mon, 12 Jun 2023 13:45:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 28/53] tools/nolibc: add test for __stack_chk_guard initialization
Date:   Mon, 12 Jun 2023 13:44:49 -0700
Message-Id: <20230612204514.292087-28-paulmck@kernel.org>
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

From: Thomas Weißschuh <linux@weissschuh.net>

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index d5d4dea63cd6..861b9a74b71f 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -808,6 +808,14 @@ static int run_protection(int min, int max)
 	return 0;
 #endif
 
+#if defined(NOLIBC_STACKPROTECTOR)
+	if (!__stack_chk_guard) {
+		llen += printf("__stack_chk_guard not initialized");
+		pad_spc(llen, 64, "[FAIL]\n");
+		return 1;
+	}
+#endif
+
 	pid = -1;
 	pid = fork();
 
-- 
2.40.1

