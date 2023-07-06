Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A70749AFB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjGFLmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjGFLmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:42:33 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A6B1FD5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 04:42:11 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5979:7b6f:39a:b9cb])
        by michel.telenet-ops.be with bizsmtp
        id Hni62A00145Xpxs06ni620; Thu, 06 Jul 2023 13:42:08 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qHNN3-000faq-HA;
        Thu, 06 Jul 2023 13:42:05 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qHNN7-000QkF-Ro;
        Thu, 06 Jul 2023 13:42:05 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Gray <bgray@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/3] regmap: Replace "default y if" by select
Date:   Thu,  6 Jul 2023 13:42:02 +0200
Message-Id: <525c37a568b10623ffb2d108850afd7e37f9350e.1688643442.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1688643442.git.geert@linux-m68k.org>
References: <cover.1688643442.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merely setting the default to enabled is no guarantee that a Kconfig
option is actually enabled.  While this works for an invisible option,
the user can still disable it manually if the option is visible.
Hence since the REGMAP option was made visible if KUNIT_ALL_TESTS is
enabled, the user can now manually disable REGMAP, causing build
failures if any of the REGMAP_* configuration options are enabled.

Fix this by replacing "default y if ..." by individual "select REGMAP"
statements for all users.

Fixes: 70a640c0efa76674 ("regmap: REGMAP_KUNIT should not select REGMAP")
Reported-by: Benjamin Gray <bgray@linux.ibm.com>
Closes: https://lore.kernel.org/r/20230705003024.1486757-1-bgray@linux.ibm.com
Reported-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Closes: https://lore.kernel.org/r/d8437dd4-63b6-13fb-22fd-9b92c661071c@csgroup.eu
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/base/regmap/Kconfig | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index 0db2021f7477f2ab..e25cc619c75de3d9 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -5,7 +5,6 @@
 
 config REGMAP
 	bool "Register Map support" if KUNIT_ALL_TESTS
-	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_W1 || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ || REGMAP_SOUNDWIRE || REGMAP_SOUNDWIRE_MBQ || REGMAP_SCCB || REGMAP_I3C || REGMAP_SPI_AVMM || REGMAP_MDIO || REGMAP_FSI)
 	select IRQ_DOMAIN if REGMAP_IRQ
 	select MDIO_BUS if REGMAP_MDIO
 	help
@@ -25,10 +24,12 @@ config REGMAP_KUNIT
 
 config REGMAP_AC97
 	tristate
+	select REGMAP
 
 config REGMAP_I2C
 	tristate
 	depends on I2C
+	select REGMAP
 
 config REGMAP_SLIMBUS
 	tristate
@@ -37,23 +38,29 @@ config REGMAP_SLIMBUS
 config REGMAP_SPI
 	tristate
 	depends on SPI
+	select REGMAP
 
 config REGMAP_SPMI
 	tristate
 	depends on SPMI
+	select REGMAP
 
 config REGMAP_W1
 	tristate
 	depends on W1
+	select REGMAP
 
 config REGMAP_MDIO
 	tristate
+	select REGMAP
 
 config REGMAP_MMIO
 	tristate
+	select REGMAP
 
 config REGMAP_IRQ
 	bool
+	select REGMAP
 
 config REGMAP_RAM
 	tristate
@@ -61,23 +68,29 @@ config REGMAP_RAM
 config REGMAP_SOUNDWIRE
 	tristate
 	depends on SOUNDWIRE
+	select REGMAP
 
 config REGMAP_SOUNDWIRE_MBQ
 	tristate
 	depends on SOUNDWIRE
+	select REGMAP
 
 config REGMAP_SCCB
 	tristate
 	depends on I2C
+	select REGMAP
 
 config REGMAP_I3C
 	tristate
 	depends on I3C
+	select REGMAP
 
 config REGMAP_SPI_AVMM
 	tristate
 	depends on SPI
+	select REGMAP
 
 config REGMAP_FSI
 	tristate
 	depends on FSI
+	select REGMAP
-- 
2.34.1

