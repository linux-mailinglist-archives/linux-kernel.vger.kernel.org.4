Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4565F721B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbiJFX6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJFX6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:58:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A562142CB2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 16:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Gxc90LALKCGw03i9q6AW2ibojsSeeP/54Gweysctd9E=; b=kZzdyoudU3Qd4nKIuVaPDxHP96
        nd+DEpGujDwPt7F+Spxgqyv0ik832ldoYu9KRgn+wdNUeY64rNibQRyNZlVj7TVyLgxesEA9vAgm5
        I3GPDtw/a686JMn9wjjRHC7issOKllcV/QA9j7Ee6A88WaODaRdh5ZfwI6/OCmSHazRqq8vvk4VcH
        NFSXCq6mRH+63L6FFr/Hs+KG3UNgH7X7dzeXdRil080MqaI721O//5psJ/1EX8yQlgAQH4d/jaPGH
        9AzFxmtfErihsyQqzuTcSWElTHV3uzfZP4niLsGNm0rQ6EQNLUrRlvTIqi9ZS9C/KtIxy+PFBivCw
        dP591g3Q==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogalI-001XLV-Bz; Thu, 06 Oct 2022 23:58:44 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ASoC: codecs: wsa883x: add GPIOLIB dependency
Date:   Thu,  6 Oct 2022 16:58:35 -0700
Message-Id: <20221006235835.31072-1-rdunlap@infradead.org>
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

Fix a build error when GPIOLIB is not set/enabled:

../sound/soc/codecs/wsa883x.c: In function 'wsa883x_probe':
../sound/soc/codecs/wsa883x.c:1394:25: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_regulator_get_optional'? [-Werror=implicit-function-declaration]
 1394 |         wsa883x->sd_n = devm_gpiod_get_optional(&pdev->dev, "powerdown",
../sound/soc/codecs/wsa883x.c:1395:49: error: 'GPIOD_FLAGS_BIT_NONEXCLUSIVE' undeclared (first use in this function)
 1395 |                                                 GPIOD_FLAGS_BIT_NONEXCLUSIVE);
../sound/soc/codecs/wsa883x.c:1414:9: error: implicit declaration of function 'gpiod_direction_output'; did you mean 'gpio_direction_output'? [-Werror=implicit-function-declaration]
 1414 |         gpiod_direction_output(wsa883x->sd_n, 1);


Fixes: 43b8c7dc85a14 ("ASoC: codecs: add wsa883x amplifier support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Banajit Goswami <bgoswami@quicinc.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
---
 sound/soc/codecs/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -2029,6 +2029,7 @@ config SND_SOC_WSA881X
 config SND_SOC_WSA883X
 	tristate "WSA883X Codec"
 	depends on SOUNDWIRE
+	depends on GPIOLIB
 	select REGMAP_SOUNDWIRE
 	tristate
 	help
