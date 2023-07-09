Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F87274C445
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 15:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjGINKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 09:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjGINK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 09:10:29 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5181AB
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 06:10:27 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5bb:109a:ec27:6093])
        by albert.telenet-ops.be with bizsmtp
        id K1AQ2A0051ycx4f061AQW7; Sun, 09 Jul 2023 15:10:25 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qIUB9-000xGt-3T;
        Sun, 09 Jul 2023 15:10:24 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qIUBE-003a1C-Cm;
        Sun, 09 Jul 2023 15:10:24 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] [RFC] sh: highlander: Handle virq offset in cascaded IRL demux
Date:   Sun,  9 Jul 2023 15:10:23 +0200
Message-Id: <4fcb0d08a2b372431c41e04312742dc9e41e1be4.1688908186.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take into account the virq offset when translating cascaded IRL
interrupts.

Fixes: a8ac2961148e8c72 ("sh: Avoid using IRQ0 on SH3 and SH4")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only, but the fix is identical to the fix for rts7751r2d.
---
 arch/sh/boards/mach-highlander/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-highlander/setup.c b/arch/sh/boards/mach-highlander/setup.c
index 533393d779c2b97f..a821a1b155473d93 100644
--- a/arch/sh/boards/mach-highlander/setup.c
+++ b/arch/sh/boards/mach-highlander/setup.c
@@ -389,10 +389,10 @@ static unsigned char irl2irq[HL_NR_IRL];
 
 static int highlander_irq_demux(int irq)
 {
-	if (irq >= HL_NR_IRL || irq < 0 || !irl2irq[irq])
+	if (irq >= 16 + HL_NR_IRL || irq < 16 || !irl2irq[irq - 16])
 		return irq;
 
-	return irl2irq[irq];
+	return irl2irq[irq - 16];
 }
 
 static void __init highlander_init_irq(void)
-- 
2.34.1

