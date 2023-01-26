Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799C467C637
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbjAZIwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbjAZIwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:52:02 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7C1442D3;
        Thu, 26 Jan 2023 00:51:57 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id CC2ED40023;
        Thu, 26 Jan 2023 08:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674723115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Fb4xrMYpWKXqyARukWe11gMYfz6J7B9pExDFH2CdKBE=;
        b=milrD4gEphaJ7kPdpchUKyFVd1T6kzhe2LKCbkaMDTiOqBwF/BigSNxn2+7t/ZZx+X2Tjj
        Bonod7PAvsY9udm2OugALZtPl/8lHKhr4LPjTa/+Zwk5IIWZFKsC3+SykNBKKKg+I//Mp3
        q3w7MYdAQL3bp9nw0GwqEiYveKp7DCOf6CRVhP9YRH+kMqXu2XLU6CMbcq+Y8imrqfl7E6
        SkIiejKBnHayvFcChzX8xREMlITHail0j6KPfC00tzfVmzPxaIbv23wEWFs/56Q4IZPraL
        19CgAJL+PC+xWetseYwIxetJw+KmDBcaRggZXvpaFqztHcHwZ/euj1KFA7miRw==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 0/3] Add the Renesas IDT821034 codec support
Date:   Thu, 26 Jan 2023 09:51:34 +0100
Message-Id: <20230126085137.375814-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Renesas IDT821034 codec is four channel PCM codec with on-chip
filters and programmable gain setting.
It also provides SLIC (Subscriber Line Interface Circuit) signals as
GPIOs.

Based on previous iteration,
  https://lore.kernel.org/linux-kernel/20230120095036.514639-1-herve.codina@bootlin.com/
this v3 series mainly:
  - Fixes _put() methods
  - Introduces and uses idt821034_2x8bit_write()
  - Removes the '#if IS_ENABLED(CONFIG_GPIOLIB)' conditional

Best regards,
Herve Codina

Changes v2 -> v3:
  - Patch 1
    Fix the example node name.
    Add 'Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>'

  - Patch 2
    Fix _put() methods return code.
    Remove 'select REGMAP_SPI' from Kconfig
    Introduce and use idt821034_2x8bit_write()
    Remove the '#if IS_ENABLED(CONFIG_GPIOLIB)' conditional
    Fix comments and other minor code simplifications

Changes v1 -> v2:
  - All patches
    Reformat commit log

  - Patch 1
    Remove '$ref: /schemas/gpio/gpio.yaml#'
    Use 'unevaluatedProperties: false'
    Update the node name and remove the sound node in the example

  - Patch 2
    Change the file header comment format
    Rework in order to remove the regmap virtual registers

Herve Codina (3):
  dt-bindings: sound: Add Renesas IDT821034 codec
  ASoC: codecs: Add support for the Renesas IDT821034 codec
  MAINTAINERS: add the Renesas IDT821034 codec entry

 .../bindings/sound/renesas,idt821034.yaml     |   75 ++
 MAINTAINERS                                   |    7 +
 sound/soc/codecs/Kconfig                      |   11 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/idt821034.c                  | 1180 +++++++++++++++++
 5 files changed, 1275 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/renesas,idt821034.yaml
 create mode 100644 sound/soc/codecs/idt821034.c

-- 
2.39.0

