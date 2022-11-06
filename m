Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51AD61E089
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 07:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKFGZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 01:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKFGZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 01:25:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221C3DF59;
        Sat,  5 Nov 2022 23:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=5SDRXSxMWlUUbPkDm/PxbafoOSGwgChTiTX8o4kcnFs=; b=OtHvTeo+vzTRfVCnhEJDuEKv1/
        wV69kB36ag1cN6N67bOEKgN9X9koB+S2VWXL3eBOnzdvqpSeDPSxrWI7T7fWvlOhjUgOLJZS8+LN/
        dMCVzDce7fZeTobLxQcy8JVI2IMJ3YeFFCs64bmKIGTIJaDnkIHJEYSh/jhsla/ygVlsWOp6iON7v
        UEH/laLwCPmvF+ZSAz9NqVD3pYUkOSRny2IWBlV43UEbvigmZvsONWUmxkl61W6jmx0QmzOoHcIW8
        WMjCEK2oXyXPePRd/clLr1cv6gAikUeQghlPyjZ0dABCsCUUwmnS/ZvIbqkry5jvh2X7pwYZYAsHN
        nmokIXcQ==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1orZ6J-008eYA-0p; Sun, 06 Nov 2022 06:25:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: [PATCH] ARM: omap1: set ARCH_OMAP1_ANY for ARCH_OMAP1
Date:   Sat,  5 Nov 2022 23:25:36 -0700
Message-Id: <20221106062536.26369-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a build error by setting ARCH_OMAP1_ANY Kconfig symbol.
Fixes this build error:

arm-linux-gnueabi-ld: drivers/video/backlight/omap1_bl.o: in function `omapbl_probe':
omap1_bl.c:(.text+0x1b4): undefined reference to `omap_cfg_reg'

Fixes: 7036440eab3e ("ARM: omap1: enable multiplatform")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
---
 arch/arm/mach-omap1/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -- a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -47,7 +47,8 @@ config ARCH_OMAP16XX
 
 config ARCH_OMAP1_ANY
 	select ARCH_OMAP
-	def_bool ARCH_OMAP730 || ARCH_OMAP850 || ARCH_OMAP15XX || ARCH_OMAP16XX
+	def_bool ARCH_OMAP730 || ARCH_OMAP850 || ARCH_OMAP15XX || \
+		ARCH_OMAP16XX || ARCH_OMAP1
 
 config ARCH_OMAP
 	bool
