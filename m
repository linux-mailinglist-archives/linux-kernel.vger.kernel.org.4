Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CB3745214
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 22:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjGBUHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 16:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjGBUH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 16:07:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897CA5599;
        Sun,  2 Jul 2023 13:05:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60DFA60C71;
        Sun,  2 Jul 2023 19:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA99C433C8;
        Sun,  2 Jul 2023 19:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688327869;
        bh=PR80scmzQp4U0vGt2Ne4nKASw/hrc6FoWE374ZYdT9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rnZ07aok0Gva4BWuX5Me7LDMdbNj2yAz2mJhj/3j1L+hKpSna7xlK3qbur448eqUW
         ps+STaK0/Rh5M5+GNnHZ77gsF0i76CxPO0xDVQaUduQAP5mjo9gDcU5RngbY2vv6ko
         FJustEeN4p5s8G54pbImfbehmcKFWW2F9WoYZvH8RfPGm4sn4AVVTCS/Vz775ununu
         6FZC0m0pvLHVWD50y/8mpebBxVYNjsCqLb11H9TggWxQ8kkrmxnGophLzz1499PSXl
         fk1VPERcGSbmMfl4qQF+AsTxLb7G+woFl/Am8jC3pnBn9nm+T2II+Uq1M8YnhUjjYw
         ceS+AJ2JVQp8Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.4 4/4] tools/nolibc: ensure stack protector guard is never zero
Date:   Sun,  2 Jul 2023 15:57:42 -0400
Message-Id: <20230702195743.1793074-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702195743.1793074-1-sashal@kernel.org>
References: <20230702195743.1793074-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.1
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

[ Upstream commit 88fc7eb54ecc6db8b773341ce39ad201066fa7da ]

The all-zero pattern is one of the more probable out-of-bound writes so
add a special case to not accidentally accept it.

Also it enables the reliable detection of stack protector initialization
during testing.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/nolibc/stackprotector.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/stackprotector.h b/tools/include/nolibc/stackprotector.h
index d119cbbbc256f..9890e86c26172 100644
--- a/tools/include/nolibc/stackprotector.h
+++ b/tools/include/nolibc/stackprotector.h
@@ -45,8 +45,9 @@ __attribute__((weak,no_stack_protector,section(".text.nolibc_stack_chk")))
 void __stack_chk_init(void)
 {
 	my_syscall3(__NR_getrandom, &__stack_chk_guard, sizeof(__stack_chk_guard), 0);
-	/* a bit more randomness in case getrandom() fails */
-	__stack_chk_guard ^= (uintptr_t) &__stack_chk_guard;
+	/* a bit more randomness in case getrandom() fails, ensure the guard is never 0 */
+	if (__stack_chk_guard != (uintptr_t) &__stack_chk_guard)
+		__stack_chk_guard ^= (uintptr_t) &__stack_chk_guard;
 }
 #endif // defined(NOLIBC_STACKPROTECTOR)
 
-- 
2.39.2

