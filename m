Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FED3749AFC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjGFLmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjGFLmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:42:33 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8697B1BEE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 04:42:11 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5979:7b6f:39a:b9cb])
        by laurent.telenet-ops.be with bizsmtp
        id Hni62A00445Xpxs01ni6ha; Thu, 06 Jul 2023 13:42:08 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qHNN3-000fav-Hy;
        Thu, 06 Jul 2023 13:42:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qHNN7-000QkI-Td;
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
Subject: [PATCH 2/3] regmap: REGMAP_SLIMBUS should select REGMAP
Date:   Thu,  6 Jul 2023 13:42:03 +0200
Message-Id: <7519324a34015e1c046227269409fef688889f4f.1688643442.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1688643442.git.geert@linux-m68k.org>
References: <cover.1688643442.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_SND_SOC_WCD934X=y, CONFIG_COMPILE_TEST=y,
CONFIG_MFD_WCD934X=n, CONFIG_REGMAP=n:

    sound/soc/codecs/wcd934x.c:518:38: error: array type has incomplete element type ‘struct regmap_range_cfg’
      518 | static const struct regmap_range_cfg wcd934x_ifc_ranges[] = {
	  |                                      ^~~~~~~~~~~~~~~~~~

Fix this by making REGMAP_SLIMBUS select REGMAP.

Drop the selection of REGMAP by MFD_WCD934X, as this is not needed
(now both REGMAP_SLIMBUS and REGMAP_IRQ select REGMAP).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/base/regmap/Kconfig | 1 +
 drivers/mfd/Kconfig         | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index e25cc619c75de3d9..c3a260ed4e864959 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -34,6 +34,7 @@ config REGMAP_I2C
 config REGMAP_SLIMBUS
 	tristate
 	depends on SLIMBUS
+	select REGMAP
 
 config REGMAP_SPI
 	tristate
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 0b6af476f554a191..5857dad2c64828fa 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2121,7 +2121,6 @@ config MFD_STMFX
 config MFD_WCD934X
 	tristate "Support for WCD9340/WCD9341 Codec"
 	depends on SLIMBUS
-	select REGMAP
 	select REGMAP_SLIMBUS
 	select REGMAP_IRQ
 	select MFD_CORE
-- 
2.34.1

