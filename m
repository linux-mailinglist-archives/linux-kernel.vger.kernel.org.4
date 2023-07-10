Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4FD74E23D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 01:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjGJXb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 19:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjGJXbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 19:31:53 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C69CA0;
        Mon, 10 Jul 2023 16:31:51 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3FDA21BF204;
        Mon, 10 Jul 2023 23:31:47 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v2] sh: hd64461: fix virq offsets
Date:   Tue, 11 Jul 2023 01:31:32 +0200
Message-ID: <20230710233132.69734-1-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: contact@artur-rojek.eu
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent change to start counting SuperH IRQ #s from 16 breaks support
for the Hitachi HD64461 companion chip.

Move the offchip IRQ base and HD64461 IRQ # by 16 in order to
accommodate for the new virq numbering rules.

Fixes: a8ac2961148e ("sh: Avoid using IRQ0 on SH3 and SH4")
Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---

v2: Make the IRQ base offset an explicit (64 + 16), as per review.

 arch/sh/cchips/Kconfig        | 4 ++--
 arch/sh/include/asm/hd64461.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/cchips/Kconfig b/arch/sh/cchips/Kconfig
index efde2edb5627..9659a0bc58de 100644
--- a/arch/sh/cchips/Kconfig
+++ b/arch/sh/cchips/Kconfig
@@ -29,9 +29,9 @@ endchoice
 config HD64461_IRQ
 	int "HD64461 IRQ"
 	depends on HD64461
-	default "36"
+	default "52"
 	help
-	  The default setting of the HD64461 IRQ is 36.
+	  The default setting of the HD64461 IRQ is 52.
 
 	  Do not change this unless you know what you are doing.
 
diff --git a/arch/sh/include/asm/hd64461.h b/arch/sh/include/asm/hd64461.h
index afb24cb034b1..d2c485fa333b 100644
--- a/arch/sh/include/asm/hd64461.h
+++ b/arch/sh/include/asm/hd64461.h
@@ -229,7 +229,7 @@
 #define	HD64461_NIMR		HD64461_IO_OFFSET(0x5002)
 
 #define	HD64461_IRQBASE		OFFCHIP_IRQ_BASE
-#define	OFFCHIP_IRQ_BASE	64
+#define	OFFCHIP_IRQ_BASE	(64 + 16)
 #define	HD64461_IRQ_NUM		16
 
 #define	HD64461_IRQ_UART	(HD64461_IRQBASE+5)
-- 
2.41.0

