Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C735FA98D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 03:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJKBC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 21:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJKBC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 21:02:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344F77A510
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 18:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=PrM3oxAWY+DvolGk6EOkPHlLnCs6oAe+5MGgAOsFI0I=; b=L60wNARaHBVJoHySPpUIA9/43p
        WNHDesmbjQqzQEDl9lwVgBWssR7YxiaLIfTI0iefK4DS1tVKn7dHkfCtltQmxIwoeWgEQL5vAVXoY
        /3X1QuVv9+jrpkuX1JOe7x9kuyFOzE+t726C8n22z7Jz0vuznMSTUaOoDvChEAhw6bQBmC8DcDAnZ
        BNnp2/7FVFPk7kKF5O3VZzucZJRJUgs8OgEuv8D54dot6nPIHjswwBE3IH3cye2O9N+OlcNablsMI
        cw+c0G2XrEo6Gp7mD6RNmq5ZLOq0CHyI5EvuV+2MP/x6NKTACxq+/HM4O+LXj9mp+VaV56qYEK8M1
        sHUu2JCQ==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oi3f4-004bAy-CP; Tue, 11 Oct 2022 01:02:23 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2] ASoC: wm8731: fix build when I2C is not enabled
Date:   Mon, 10 Oct 2022 18:02:13 -0700
Message-Id: <20221011010213.4096-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.3
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
Cc: Takashi Iwai <tiwai@suse.com>
---
v2: add Takashi's email address

 sound/soc/au1x/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff sound/soc/au1x/Kconfig sound/soc/au1x/Kconfig
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
