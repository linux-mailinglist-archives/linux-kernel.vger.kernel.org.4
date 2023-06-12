Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54C272D122
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjFLUvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238233AbjFLUt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:49:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358B31BFB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:47:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1125062F2D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFE2C43445;
        Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602717;
        bh=m6VW9L1DfLWVSVi0RNl6hit3N3enOx/+urG9Qu9XTN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p0Ohgdl5koVAi4NEWD3gyKQla9v1Znt/dlMhMqbKNxXuOrDZyMlTGgp2OhL4j31H7
         DdLqVvl+gc1fSiIiLDYbCL95Clf3cwRZHI40wnNnURs3TQQjPOA366vHS51bY1+V09
         u3CbgcCz1kVQfKkkSkOaHn9vku+k2BWUT1ZQl16sEZXSzoUaJEAyymSmvdOhMhJfo6
         HJ6dtFzW3PKq3wMkZsPUy37BJXepc8L+fkb7B90ABwOwKgSpEYvdPfTZ0IWUfzGvN9
         G1Vv332VaM6wGTw+jY4jgG+571m9h+7N6yT5CFPzLVDDSd1NH0ZHgsSkmNVk3SjhTH
         xXSq+V8IpCQkg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E6798CE3A6F; Mon, 12 Jun 2023 13:45:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 27/53] tools/nolibc: ensure stack protector guard is never zero
Date:   Mon, 12 Jun 2023 13:44:48 -0700
Message-Id: <20230612204514.292087-27-paulmck@kernel.org>
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

The all-zero pattern is one of the more probable out-of-bound writes so
add a special case to not accidentally accept it.

Also it enables the reliable detection of stack protector initialization
during testing.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/stackprotector.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/stackprotector.h b/tools/include/nolibc/stackprotector.h
index 77e5251c4490..b0156fc077a0 100644
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
 #endif /* defined(NOLIBC_STACKPROTECTOR) */
 
-- 
2.40.1

