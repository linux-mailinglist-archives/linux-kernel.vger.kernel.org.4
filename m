Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1F75B4B42
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 03:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiIKBtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 21:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiIKBtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 21:49:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D208E30542
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 18:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=v6mxseQc0nruVgsZVFGEuCPSLNpAqC95AVNaz99FMPo=; b=hphRvg2WKZgW9Z3OY+c7gQ1Kfu
        fHd99ai/6FtkPtPPw7uQgj/ChUzuKzaTCftYDzLiVmpsVNVNUjT51m4ZBTsGQTKlp16iIWMgaezlI
        Qlv1zZCF6sXzgdxf8pUnHP5Oxpna8GRC63YS7/uKL/nrf9wk6vlMl47SynEa1lQp4RSMRsxJblFgk
        b0yjS2BdtrYpLD8xENhE4WEjiRmXRfpCsOg1VUvAW5BaMRXryAPC9r6Uf84C93F0EdodsXCBalSic
        apCJH6BxZXcoCJ2gjpOgGtdaqtfNWMPlPxXxQ2QPf7xHIpSdGqLcqmYv2409sZOwla/Q5OUZiEoV2
        L4cfO8WQ==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oXC62-00EZS5-4W; Sun, 11 Sep 2022 01:49:18 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH] ASoC: wm8731: fix build when I2C is not enabled
Date:   Sat, 10 Sep 2022 18:49:11 -0700
Message-Id: <20220911014911.6398-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building wm8731-i2c.c has a kconfig warning and build errors when
I2C is not enabled, so prevent that kconfig-uration.

WARNING: unmet direct dependencies detected for SND_SOC_WM8731_I2C
  Depends on [n]: SOUND [=y] && !UML && SND [=m] && SND_SOC [=m] && I2C [=n]
  Selected by [m]:
  - SND_SOC_DB1200 [=m] && SOUND [=y] && !UML && SND [=m] && SND_SOC [=m] && SND_SOC_AU1XPSC [=m]

and subsequent build errors:

../sound/soc/codecs/wm8731-i2c.c:64:1: warning: data definition has no type or storage class
   64 | module_i2c_driver(wm8731_i2c_driver);
../sound/soc/codecs/wm8731-i2c.c:64:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
../sound/soc/codecs/wm8731-i2c.c:64:1: warning: parameter names (without types) in function declaration
../sound/soc/codecs/wm8731-i2c.c:55:26: warning: 'wm8731_i2c_driver' defined but not used [-Wunused-variable]
   55 | static struct i2c_driver wm8731_i2c_driver = {

Fixes: 9dc15f81baf2 ("ASoC: wm8731: Factor out the I2C and SPI bus code into separate modules")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai
---
 sound/soc/au1x/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/soc/au1x/Kconfig
+++ b/sound/soc/au1x/Kconfig
@@ -54,6 +54,7 @@ config SND_SOC_DB1000
 config SND_SOC_DB1200
 	tristate "DB1200/DB1300/DB1550 Audio support"
 	depends on SND_SOC_AU1XPSC
+	depends on I2C
 	select SND_SOC_AU1XPSC_AC97
 	select SND_SOC_AC97_CODEC
 	select SND_SOC_WM9712
