Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67487739E16
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjFVKMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjFVKMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:12:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E850810F0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 03:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68A83617C0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A930C433C8;
        Thu, 22 Jun 2023 10:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687428730;
        bh=LHQoMIKlPCUVdYDVCU+rYUKAonEIdfte0Fij6zTMRmM=;
        h=From:To:Cc:Subject:Date:From;
        b=rxLossX0EbeSaaBeVLTFvPuG7sSp18ayt72v2KAtT/YGRyU4hKHuUo6kbsVZ8B9K4
         ucwp80MO1u8fUoMOms09Kw8YM3Nd0JMp2MkepNIsN2dckdiiFXY+KJjR+UBES6ExcD
         zr1njea+km9wev3tF+JjGyjZ12NRw+t9oSKnxJroYrYwaVSE2/hhwJmQiZdRYfBF5b
         sAORaC1pCfMDuQ2USst8jnSEKu6PkL7ftZRwhfKI/GItuE08mmorW9pSv9mbHtXHFq
         i+OViyXgiGJjfjQM5sFEUec5ShO+P4IFp9esgUqLT3Avs3dv/aWLkokJXZd+3pMtkW
         vWHCB7ORroxQw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Shenghao Ding <13916275206@139.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: tas2781: fix Kconfig dependencies
Date:   Thu, 22 Jun 2023 12:11:23 +0200
Message-Id: <20230622101205.3180938-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

The new driver has two modules that both get enabled for build testing
when all codecs are selected. The comlib part has an i2c dependency,
so this remains disabled on builds without i2c, but then the other
one fails to link:

ERROR: modpost: "tasdevice_dev_bulk_write" [sound/soc/codecs/snd-soc-tas2781-fmwlib.ko] undefined!
ERROR: modpost: "tasdevice_dev_update_bits" [sound/soc/codecs/snd-soc-tas2781-fmwlib.ko] undefined!
ERROR: modpost: "tasdevice_dev_bulk_read" [sound/soc/codecs/snd-soc-tas2781-fmwlib.ko] undefined!
ERROR: modpost: "tasdevice_dev_read" [sound/soc/codecs/snd-soc-tas2781-fmwlib.ko] undefined!
ERROR: modpost: "tasdevice_dev_write" [sound/soc/codecs/snd-soc-tas2781-fmwlib.ko] undefined!

There are many ways to address this, adding an explicit dependency seems
to be the clearest method that keeps the structure of the driver otherwise
unchanged.

Fixes: ef3bcde75d06d ("ASoC: tas2781: Add tas2781 driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f481f02a35710..2a62dbd5339e4 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1741,6 +1741,7 @@ config SND_SOC_TAS2781_COMLIB
 	tristate
 
 config SND_SOC_TAS2781_FMWLIB
+	depends on SND_SOC_TAS2781_COMLIB
 	tristate
 	default n
 
-- 
2.39.2

