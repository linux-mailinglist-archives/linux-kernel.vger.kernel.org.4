Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAFD749AFD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjGFLmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjGFLme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:42:34 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DF01BFE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 04:42:11 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5979:7b6f:39a:b9cb])
        by laurent.telenet-ops.be with bizsmtp
        id Hni62A00545Xpxs01ni6hb; Thu, 06 Jul 2023 13:42:08 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qHNN3-000fay-Ik;
        Thu, 06 Jul 2023 13:42:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qHNN7-000QkN-Ut;
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
Subject: [PATCH 3/3] ASoC: codecs: SND_SOC_WCD934X should select REGMAP_IRQ
Date:   Thu,  6 Jul 2023 13:42:04 +0200
Message-Id: <cafd878747e7951914a7d9fea33788a4a230d1f0.1688643442.git.geert@linux-m68k.org>
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

If CONFIG_SND_SOC_WCD934X=y, CONFIG_COMPILE_TEST=y,
CONFIG_MFD_WCD934X=n, CONFIG_REGMAP_IRQ=n:

    aarch64-linux-gnu-ld: sound/soc/codecs/wcd934x.o: in function `wcd934x_codec_probe':
    wcd934x.c:(.text+0x33cc): undefined reference to `regmap_irq_get_virq'
    aarch64-linux-gnu-ld: sound/soc/codecs/wcd934x.o: in function `wcd934x_comp_probe':
    wcd934x.c:(.text+0x4cb0): undefined reference to `regmap_irq_get_virq'
    aarch64-linux-gnu-ld: wcd934x.c:(.text+0x4cc0): undefined reference to `regmap_irq_get_virq'
    aarch64-linux-gnu-ld: wcd934x.c:(.text+0x4cd0): undefined reference to `regmap_irq_get_virq'
    aarch64-linux-gnu-ld: wcd934x.c:(.text+0x4ce0): undefined reference to `regmap_irq_get_virq'
    aarch64-linux-gnu-ld: sound/soc/codecs/wcd934x.o:wcd934x.c:(.text+0x4cf0): more undefined references to `regmap_irq_get_virq' follow

Fix this by making SND_SOC_WCD934X select REGMAP_IRQ.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 2a62dbd5339e4a3a..958499050c8b6a3f 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1942,6 +1942,7 @@ config SND_SOC_WCD934X
 	tristate "WCD9340/WCD9341 Codec"
 	depends on COMMON_CLK
 	depends on SLIMBUS
+	select REGMAP_IRQ
 	select REGMAP_SLIMBUS
 	select SND_SOC_WCD_MBHC
 	depends on MFD_WCD934X || COMPILE_TEST
-- 
2.34.1

