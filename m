Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34B75EC47A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbiI0Nbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbiI0NbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:31:14 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FA9E7E18
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:26:51 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:d95b:5c9b:4085:7c0d])
        by albert.telenet-ops.be with bizsmtp
        id R1Sl2800E3Qogd1061Sl7e; Tue, 27 Sep 2022 15:26:47 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1odAbk-006Qb7-KW; Tue, 27 Sep 2022 15:26:44 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1odAbk-000uvu-7K; Tue, 27 Sep 2022 15:26:44 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ARM: Drop CMDLINE_FORCE dependency on !ARCH_MULTIPLATFORM
Date:   Tue, 27 Sep 2022 15:26:26 +0200
Message-Id: <c557b149780faa2299700585afc9d270ede7f78b.1664285062.git.geert+renesas@glider.be>
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

On older platforms that boot an image with an appended DTB, or where
the boot loader has no support for updating chosen/bootargs, it is
common to rely on CMDLINE_FORCE.

While a fixed command line can make the kernel unbootable on other
platforms, it is not guaranteed to cause that.  E.g. all Renesas boards
use the same chosen/bootargs in upstream DTS, which works fine if your
DHCP server hands out proper nfsroot parameters.

Fixes: 84fc863606239d8b ("ARM: make ARCH_MULTIPLATFORM user-visible")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 22f62ad919bfd831..ea8adbf25651438a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1616,7 +1616,6 @@ config CMDLINE_EXTEND
 
 config CMDLINE_FORCE
 	bool "Always use the default kernel command string"
-	depends on !ARCH_MULTIPLATFORM
 	help
 	  Always use the default kernel command string, even if the boot
 	  loader passes other arguments to the kernel.
-- 
2.25.1

