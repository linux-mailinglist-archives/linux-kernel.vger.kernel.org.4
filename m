Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7488870529E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbjEPPq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjEPPq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:46:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B067F8A6A;
        Tue, 16 May 2023 08:46:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87F1C63B8E;
        Tue, 16 May 2023 15:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8394C4339E;
        Tue, 16 May 2023 15:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684251984;
        bh=QS657WnsM8vdXz+21VxN72PAoIydoXyXYs6qMuHutIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=htRLSIukiytswKjvEU7b5krt5Y3Y7ljURy8QF8CGb+x2h1ssvwjVk6Pwqv4ut3Esw
         CB1OiulX7s10M9KVGVETJOiHcuxpyhee8hUZkmO5UEaMi+KR8LO8hYWzalhm3RlHqo
         09xGWJMYFj2+fN7HqZvVXQrPQTX7Y7qmuRJ61d3Y/JHUn94ohkbZ4djv+Oyi/Mtl+w
         XedetTwh9Y23tsy+DfBDvhPwgSkMUwAXkk+Ad6STis8PVcvL9li3Po/5JkWHc9yLNX
         Yq2AjCQlVGQybK9eMHfvOn6iETC5ttftvRPasbRn7XnG8UUlUFRX/e9rR3DVFZu0bl
         cIvS1mbMNeQRw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 02/16] ARM: traps: hide unused functions on NOMMU
Date:   Tue, 16 May 2023 17:45:51 +0200
Message-Id: <20230516154605.517690-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516154605.517690-1-arnd@kernel.org>
References: <20230516154605.517690-1-arnd@kernel.org>
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

A couple of functions in this file are only used on MMU-enabled
builds, and never even declared otherwise, causing these build
warnings:

arch/arm/kernel/traps.c:759:6: error: no previous prototype for '__pte_error' [-Werror=missing-prototypes]
arch/arm/kernel/traps.c:764:6: error: no previous prototype for '__pmd_error' [-Werror=missing-prototypes]
arch/arm/kernel/traps.c:769:6: error: no previous prototype for '__pgd_error' [-Werror=missing-prototypes]

Protect these in an #ifdef to avoid the warnings and save a little
bit of .text space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/traps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 40c7c807d67f..3bad79db5d6e 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -756,6 +756,7 @@ void __readwrite_bug(const char *fn)
 }
 EXPORT_SYMBOL(__readwrite_bug);
 
+#ifdef CONFIG_MMU
 void __pte_error(const char *file, int line, pte_t pte)
 {
 	pr_err("%s:%d: bad pte %08llx.\n", file, line, (long long)pte_val(pte));
@@ -770,6 +771,7 @@ void __pgd_error(const char *file, int line, pgd_t pgd)
 {
 	pr_err("%s:%d: bad pgd %08llx.\n", file, line, (long long)pgd_val(pgd));
 }
+#endif
 
 asmlinkage void __div0(void)
 {
-- 
2.39.2

