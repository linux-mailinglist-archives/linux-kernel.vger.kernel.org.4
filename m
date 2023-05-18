Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3A7708452
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjEROzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjEROz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:55:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F3E12E
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:55:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0259764FD9
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 14:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633CFC4339B;
        Thu, 18 May 2023 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684421723;
        bh=Ks2BcB2HxSbBY7mPbJIjN33LPo2/4OOsJWgK+op14zY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bNS+TekKDdkvsHrj3RcZ9hgMDDRdzgoHGGrErRzo9MA2Zow+POuD6WovfiWP2Jgsp
         PQUbyODWIX8J72tFeD7CV80O0qTjvIPGu2Gzz8mQ9EUiWTt/DaM86rHWlcaEzhzC2G
         GnjfrAlJl6ebtRnFELp9cPQdUPCmI2H82de93QX4C38jLPyGuOgO7wFMbg3V+C2tOZ
         37Vof3pSyINO9knyDddsfeZ41kWd6UbNJ0+xCY0CYme0lBQr4BPlMSJmLZWR1HVwX2
         LeTPM5goZ+1HPI5+rLZXOS3ouLPB3F4j3N6DHbcAz7Bzt3WQ04rdPIhkRS+32U0REI
         YH5IRbqHugzmA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 159FBCE04B0; Thu, 18 May 2023 07:55:23 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 02/15] tools/nolibc: tests: fix build on non-c99 compliant compilers
Date:   Thu, 18 May 2023 07:55:08 -0700
Message-Id: <20230518145521.3806117-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <4817a4dc-69e6-4937-84d5-f2f630ff646c@paulmck-laptop>
References: <4817a4dc-69e6-4937-84d5-f2f630ff646c@paulmck-laptop>
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

