Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718A95ED9E4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiI1KOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbiI1KOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:14:43 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D52D33C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 03:14:38 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:5556:1b6:16f5:2874])
        by michel.telenet-ops.be with bizsmtp
        id RNEa2800L40fT9J06NEaHS; Wed, 28 Sep 2022 12:14:35 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1odThb-0005yI-Uf; Wed, 28 Sep 2022 11:50:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1odQlw-001YTc-7P; Wed, 28 Sep 2022 08:42:20 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Bolle <pebolle@tiscali.nl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ARM: remove check for CONFIG_DEBUG_LL_SER3
Date:   Wed, 28 Sep 2022 08:42:19 +0200
Message-Id: <e8b573d81168c33ed4f3d5e5e2d3b951c323fc23.1664347239.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Bolle <pebolle@tiscali.nl>

A check for CONFIG_DEBUG_LL_SER3 was added in v2.5.43. But the related
symbol DEBUG_LL_SER3 was already removed in v2.5.8. This check has
always evaluated to false. Remove it.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Still valid after 8 years...
Link: https://lore.kernel.org/r/1400055127.31197.1.camel@x220
---
 arch/arm/boot/compressed/head.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index bf79f2f78d232306..9f406e9c0ea6f74b 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -67,11 +67,7 @@
 #if defined(CONFIG_ARCH_SA1100)
 		.macro	loadsp, rb, tmp1, tmp2
 		mov	\rb, #0x80000000	@ physical base address
-#ifdef CONFIG_DEBUG_LL_SER3
-		add	\rb, \rb, #0x00050000	@ Ser3
-#else
 		add	\rb, \rb, #0x00010000	@ Ser1
-#endif
 		.endm
 #else
 		.macro	loadsp,	rb, tmp1, tmp2
-- 
2.25.1

