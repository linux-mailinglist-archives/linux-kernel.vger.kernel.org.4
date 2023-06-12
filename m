Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA1472D0EF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbjFLUrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbjFLUqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:46:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6809A211C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABCF0628F5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143D4C4339B;
        Mon, 12 Jun 2023 20:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602716;
        bh=Ks2BcB2HxSbBY7mPbJIjN33LPo2/4OOsJWgK+op14zY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qKsK0qaswOjIPy/bfoiU2TOM1/2acMdTaVJYOdvnom0Yvol6riU4QsLoeVugqdzJd
         ytjj4vt8Zs/NSkQUQZ0cqq8s2ugQCzt0I02kbarHRczMelvrtC5C00E1Dh+S4sadFj
         loHr247JnuzICjBnjykJCDoYd/c1P0uUeA/BiuDfVufh1s1YbKL/nqCeU3sldQXakf
         HjpT3AJDXX44dDApGiDiSW7oQZUFZG+JoT1NTJROAmgJWAHftzC6+BUk60qN065crr
         yUacKFoSUeA5PETCpDvGWv98FFZXWYTzSNXeCgedrfEabEngh29Gbit/FY/OQsN4l8
         61Kx7OOKqbAww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ACF14CE0563; Mon, 12 Jun 2023 13:45:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 02/53] tools/nolibc: tests: fix build on non-c99 compliant compilers
Date:   Mon, 12 Jun 2023 13:44:23 -0700
Message-Id: <20230612204514.292087-2-paulmck@kernel.org>
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

From: Willy Tarreau <w@1wt.eu>

Commit 9735716830f2 ("tools/nolibc: tests: add test for -fstack-protector")
brought a declaration inside the initialization statement of a for loop,
which breaks the build on compilers that do not default to c99
compatibility, making it more difficult to validate that the lib still
builds on such compilers. The fix is trivial, so let's move the
declaration to the variables block of the function instead. No backport
is needed.

Cc: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 47013b78972e..6f2f109569a3 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -671,8 +671,9 @@ static int smash_stack(void)
 {
 	char buf[100];
 	volatile char *ptr = buf;
+	size_t i;
 
-	for (size_t i = 0; i < 200; i++)
+	for (i = 0; i < 200; i++)
 		ptr[i] = 'P';
 
 	return 1;
-- 
2.40.1

