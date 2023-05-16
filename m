Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF4A7052BD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbjEPPtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbjEPPsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:48:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BB49EEB;
        Tue, 16 May 2023 08:47:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16A5663BAF;
        Tue, 16 May 2023 15:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E2EC433D2;
        Tue, 16 May 2023 15:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684252020;
        bh=Npxydn52yNm/V36pPXxMeglIGETaw+vXx4GeRAC3zdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nxtqi0WvFSlHGYKBv/f3fm7o9hL3K1bNtnja2ASbeAJIlcaB8frJ16v2Tr5vxA72j
         QIS2ucqJFlN3AvvuNr8oWbDkrwt3zlx+O/pDzwLuCC1X9AGzOcn1QOLG5uEq/scTET
         4OBbIcE4bPK+GoIgPoPRvQUY0iB4N7WNY98jlmvm4V05vrUT+Y2pV11HVT9na/eaNl
         XYSOnhzIijZvTI7jf5VXiZbCSY4NSqPqqJX5v9LtKgjUtrvu9n0IOTyZy9o6h0y8FB
         iRaAiSUG88ROpRuVU2V2rWeA/jn3gSomOm3+LFP3uG+HNumJ4SH3FmP8QxJFPmCAq/
         cls4GlKSlcD3g==
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
Subject: [PATCH 12/16] ARM: fiq: include asm/mach/irq.h for prototypes
Date:   Tue, 16 May 2023 17:46:01 +0200
Message-Id: <20230516154605.517690-13-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516154605.517690-1-arnd@kernel.org>
References: <20230516154605.517690-1-arnd@kernel.org>
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

There are two global functions in fiq.c that get called from
other files through an extern declaration, but a W=1 build
warns about the header not being included before the definition:

arch/arm/kernel/fiq.c:85:5: error: no previous prototype for 'show_fiq_list' [-Werror=missing-prototypes]
arch/arm/kernel/fiq.c:159:13: error: no previous prototype for 'init_FIQ' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/fiq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
index 98ca3e3fa847..d2c8e5313539 100644
--- a/arch/arm/kernel/fiq.c
+++ b/arch/arm/kernel/fiq.c
@@ -45,6 +45,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
 #include <asm/fiq.h>
+#include <asm/mach/irq.h>
 #include <asm/irq.h>
 #include <asm/traps.h>
 
-- 
2.39.2

