Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1910D627CA2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbiKNLoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236626AbiKNLoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:44:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E87821807
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:44:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 170CC6106D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8743BC433D7;
        Mon, 14 Nov 2022 11:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426257;
        bh=rN/KT1Epf0fvqNeXEc1oWJfGIaRJw5s06AqXjEWOiHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NVMO3KRkZoQJ0VQ15+L8MX3UIZgB6LL180PhW7aAbxYsAXZOM3YZXmueMCaXNu3FE
         +tC8/fnpZwvQGQxMGr2LWQHorJ2d8P5C79kfc2FIlVi0md18cXDAZSyLuSvXEyQxcZ
         OaFpogWZTE0C+CdZ9ef90IfWCESKNhhnYrbRlQuYrRYCy5v3ggm2jwQ0eoXJ0m0AbP
         d+rNs7VkLxZwEjOfDXy6mJrLBxvZWtnM1gyERvo387/zZK/OcLiTH5DikylrNCXtgg
         fKxZsBnUGs90tFM0PiNwCscaye2ymTpjnLRT690iTuiLZDm7lcAw2CPEY1kV5jKzR/
         JMxzRXbASSaEw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <andi@firstfloor.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 10/46] static_call, lto: Mark func_a() as __visible_on_lto
Date:   Mon, 14 Nov 2022 12:43:08 +0100
Message-Id: <20221114114344.18650-11-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <andi@firstfloor.org>

Symbols referenced from assembler (either directly or e.f. from
DEFINE_STATIC_KEY()) need to be global and visible in gcc LTO because
they could end up in a different object file than the assembler. This
can lead to linker errors without this patch.

So mark func_a() as __visible_on_lto as it was static.

[js] use __visible_on_lto

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Andi Kleen <andi@firstfloor.org>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 kernel/static_call_inline.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/static_call_inline.c b/kernel/static_call_inline.c
index dc5665b62814..6933b4437597 100644
--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -501,7 +501,7 @@ early_initcall(static_call_init);
 
 #ifdef CONFIG_STATIC_CALL_SELFTEST
 
-static int func_a(int x)
+__visible_on_lto int sc_func_a(int x)
 {
 	return x+1;
 }
@@ -511,7 +511,7 @@ static int func_b(int x)
 	return x+2;
 }
 
-DEFINE_STATIC_CALL(sc_selftest, func_a);
+DEFINE_STATIC_CALL(sc_selftest, sc_func_a);
 
 static struct static_call_data {
       int (*func)(int);
@@ -520,7 +520,7 @@ static struct static_call_data {
 } static_call_data [] __initdata = {
       { NULL,   2, 3 },
       { func_b, 2, 4 },
-      { func_a, 2, 3 }
+      { sc_func_a, 2, 3 }
 };
 
 static int __init test_static_call_init(void)
-- 
2.38.1

