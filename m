Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600DB6EAA94
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjDUMmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjDUMmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:42:16 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70915B80;
        Fri, 21 Apr 2023 05:41:36 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 9F26140006;
        Fri, 21 Apr 2023 12:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682080894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wPUr6k3hoHACmnMjvKMllT2pYnYBLSNWQbpWAPrti6c=;
        b=ZY1kyb2J62UJI4c0SfVLqsVPO1m7nV0B93j0DP4ZGCaAOzE1CbG/rfJQcX37ZRFoVehfhh
        upR/4/e72nslwE2fTICG1qEMN8ng6UgnW/um2dvgBFTXvUlNqWoB3igr2a4t1uuY/7Lkro
        Q/JhPYuDi5GxZpU0fQy2OP38mAcOcXNchUoMIQqo7M40VyXV+qkS7V+ez7cPrUcQq/dwQJ
        7RiV6UZ0It/tQHwGbleMlub0joaN3sIPkqhES+YpLHAMaqCugaNyCLSPE7nBv6bFDncT8L
        wVATcJ86n+Yo+oKKILY2rhK1ZNkc/tVbJZfasc01RiuXZTPB9ryuz3nqDHFcZQ==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 0/4] Add support for IIO devices in ASoC
Date:   Fri, 21 Apr 2023 14:41:18 +0200
Message-Id: <20230421124122.324820-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several weeks ago, I sent a series [1] for adding a potentiometer as an
auxiliary device in ASoC. The feedback was that the potentiometer should
be directly handled in IIO (as other potentiometers) and something more
generic should be present in ASoC in order to have a binding to import
some IIO devices into sound cards.

The series related to the IIO potentiometer device is already under
review [2].

This series introduces simple-iio-aux. Its goal is to offer the binding
between IIO and ASoC.
It exposes attached IIO devices as ASoC auxiliary devices and allows to
control them through mixer controls.

On my system, the IIO device is a potentiometer and it is present in an
amplifier design present in the audio path.

Best regards,
Hervé

[1] https://lore.kernel.org/linux-kernel/20230203111422.142479-1-herve.codina@bootlin.com/
[2] https://lore.kernel.org/linux-kernel/20230421085245.302169-1-herve.codina@bootlin.com/

Herve Codina (4):
  dt-bindings: sound: Add simple-iio-aux
  iio: inkern: Add a helper to query an available minimum raw value
  ASoC: soc-dapm.h: Add a helper to build a DAPM widget dynamically
  ASoC: codecs: Add support for the generic IIO auxiliary devices

 .../bindings/sound/simple-iio-aux.yaml        |  65 ++++
 drivers/iio/inkern.c                          |  67 ++++
 include/linux/iio/consumer.h                  |  11 +
 include/sound/soc-dapm.h                      |  12 +-
 sound/soc/codecs/Kconfig                      |  12 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/simple-iio-aux.c             | 307 ++++++++++++++++++
 7 files changed, 475 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/simple-iio-aux.yaml
 create mode 100644 sound/soc/codecs/simple-iio-aux.c

-- 
2.39.2

