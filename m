Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B58E675192
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjATJut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjATJuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:50:46 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A08C83E5;
        Fri, 20 Jan 2023 01:50:45 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id BF483FF810;
        Fri, 20 Jan 2023 09:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674208243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lhmoz3o5whEWeMQjpRNQYi4NdVypuHsB2pUQfSBp09A=;
        b=cV+FiBTWA5HBwpddXDbEkqJt1WcV6bG6R1zMmPTLcBKYWDOp/IY5jF6dl2tlqf+guLHUhA
        ymJlJIAbqVlnZp8N5BBTNfMfwagzJjQ3iFAvXLfe5bAuYUTBPk1oQJqKj4trCYL64b5TUa
        gZKpI5UO3nHyi1fL+jg7o6CZYjkzsdqZvFG8wEAvgqy113s2lMKZQ2DKyTeq7TfN9Vh4uU
        N4P87OdGkme28/3mgoYkjjkX7Wqm7IlFa+GyvKDxBQMlYUnDBRxNNW5qtFyAg8R+unKmpu
        4yvLSt5HuLWCiAwdsj/+LDG8BS6w0kBskS64+FJ//i5azLpKZhyJ5iPCsHVzeg==
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
Subject: [PATCH v2 0/3] Add the Renesas IDT821034 codec support
Date:   Fri, 20 Jan 2023 10:50:33 +0100
Message-Id: <20230120095036.514639-1-herve.codina@bootlin.com>
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

Based on previous iteration:
  https://lore.kernel.org/all/20230111134905.248305-1-herve.codina@bootlin.com/
the bigger change is the codec driver rework in order to remove the
regmap virtual registers layer.

Best regards,
Herve Codina

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
 sound/soc/codecs/Kconfig                      |   12 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/idt821034.c                  | 1200 +++++++++++++++++
 5 files changed, 1296 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/renesas,idt821034.yaml
 create mode 100644 sound/soc/codecs/idt821034.c

-- 
2.39.0

