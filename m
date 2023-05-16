Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24837052B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbjEPPsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbjEPPr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:47:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED0B8A4C;
        Tue, 16 May 2023 08:47:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6615063BA7;
        Tue, 16 May 2023 15:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA8AC4339C;
        Tue, 16 May 2023 15:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684252016;
        bh=bqx6S1zj75BZV7GkFI5F7m35pIzL0uAA+EcyqyJVBbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pl+zExTT7Seum5jw84Hath8EhW8XZl7y7ykf6GyNZGhiiuKgf40tRtoIsqwPQ0ebH
         pRTSoJQbG0O4di6rjIBv3hj/Jjw8N0hXgwy3//vBKEtgokV+dMcvrW9502msvdbNjj
         TdTs9Tnmv+Nz2fpWs+kVl1xjG34VN5rVC7hOEj26bS7ECtRooC40ClNmmVOmRCze7v
         ZTZEwElgudJSE1aSqS9wEv9zi9/odbmBhCRiGwpv4To33saLRSw+nhQ8u+M62UjEbo
         OK3hUZehXq1MqRikGqeNs66/NIA1eGGJwzaajtbB+NtGUzSGdiYM9qxfXuZNzcdTwJ
         kO6e7aGswN36w==
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
Subject: [PATCH 11/16] ARM: move setup functions to header
Date:   Tue, 16 May 2023 17:46:00 +0200
Message-Id: <20230516154605.517690-12-arnd@kernel.org>
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

A couple of functions are declared in arch/arm/mm/mmu.c rather than in a header,
which causes W=1 build warnings:

arch/arm/mm/init.c:97:13: error: no previous prototype for 'setup_dma_zone' [-Werror=missing-prototypes]
arch/arm/mm/mmu.c:118:13: error: no previous prototype for 'init_default_cache_policy' [-Werror=missing-prototypes]
arch/arm/mm/mmu.c:1195:13: error: no previous prototype for 'adjust_lowmem_bounds' [-Werror=missing-prototypes]
arch/arm/mm/mmu.c:1761:13: error: no previous prototype for 'paging_init' [-Werror=missing-prototypes]
arch/arm/mm/mmu.c:1794:13: error: no previous prototype for 'early_mm_init' [-Werror=missing-prototypes]

Move the declaratsion to asm/setup.h so they can be seen by the compiler
while building the definition.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/setup.h | 7 +++++++
 arch/arm/kernel/setup.c      | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
index ba0872a8dcda..28ca2a17394a 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -28,4 +28,11 @@ extern void save_atags(const struct tag *tags);
 static inline void save_atags(const struct tag *tags) { }
 #endif
 
+struct machine_desc;
+void init_default_cache_policy(unsigned long);
+void paging_init(const struct machine_desc *desc);
+void early_mm_init(const struct machine_desc *);
+void adjust_lowmem_bounds(void);
+void setup_dma_zone(const struct machine_desc *desc);
+
 #endif
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 75cd4699e7b3..703233a7bfe3 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -76,13 +76,6 @@ static int __init fpe_setup(char *line)
 __setup("fpe=", fpe_setup);
 #endif
 
-extern void init_default_cache_policy(unsigned long);
-extern void paging_init(const struct machine_desc *desc);
-extern void early_mm_init(const struct machine_desc *);
-extern void adjust_lowmem_bounds(void);
-extern enum reboot_mode reboot_mode;
-extern void setup_dma_zone(const struct machine_desc *desc);
-
 unsigned int processor_id;
 EXPORT_SYMBOL(processor_id);
 unsigned int __machine_arch_type __read_mostly;
-- 
2.39.2

