Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D1A735117
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjFSJ5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjFSJ4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:56:51 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715BEE58;
        Mon, 19 Jun 2023 02:56:46 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35J5L9Dq009890;
        Mon, 19 Jun 2023 04:56:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=TfGrH3Uleie1Co1qiJ5GXAl8Q/ErU0G0tmVgE1EhgVI=;
 b=fPahJfu1hiHC0O+7Ef5ILbXEx81HpcTUo+uDRypi6ALV7e9sV9AcHvnndrqgZbnAva0J
 PD0jp0oq92RqYroI3/jc1K5oIN6Q1d8i5aP2ttrEWRoeTp3gv8p28SEC3S7GZB/gBwoA
 EsMasIH/Cytq1ouI8WBW0NHoaNvcJSQyZ0ItzDnHKDhOfZrS7ni7743t4P1prh/3Czfd
 QymCk75DkZJkMAcfcf5hO0c1580kAz5XlYniBh95ZdGoh+pEUFJJQU/2+QqsDe+/PaFt
 KTIPplZM/4g/sYf8fobXPAIq2yr3o05Ajhas1g88EuAVBvKQZCYE/ZfxQ9RQdjibUQas iw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3r9a809n3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 04:56:25 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Mon, 19 Jun
 2023 10:56:23 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 19 Jun 2023 10:56:23 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 386D246B;
        Mon, 19 Jun 2023 09:56:23 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>, <lee@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <conor+dt@kernel.org>, <lgirdwood@gmail.com>,
        <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/6] Add cs42l43 PC focused SoundWire CODEC
Date:   Mon, 19 Jun 2023 10:56:17 +0100
Message-ID: <20230619095623.1987742-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TwJIzOos5_RoQCCaIygw3wlU1xV9vY00
X-Proofpoint-GUID: TwJIzOos5_RoQCCaIygw3wlU1xV9vY00
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch chain adds support for the Cirrus Logic cs42l43 PC focused
SoundWire CODEC. The chain is currently based of Lee's for-mfd-next
branch.

Thanks,
Charles

Charles Keepax (4):
  dt-bindings: mfd: cirrus,cs42l43: Add initial DT binding
  mfd: cs42l43: Add support for cs42l43 core driver
  pinctrl: cs42l43: Add support for the cs42l43
  ASoC: cs42l43: Add support for the cs42l43

Lucas Tanure (2):
  soundwire: bus: Allow SoundWire peripherals to register IRQ handlers
  spi: cs42l43: Add SPI controller support

 .../bindings/sound/cirrus,cs42l43.yaml        |  313 +++
 MAINTAINERS                                   |    4 +
 drivers/mfd/Kconfig                           |   23 +
 drivers/mfd/Makefile                          |    3 +
 drivers/mfd/cs42l43-i2c.c                     |   98 +
 drivers/mfd/cs42l43-sdw.c                     |  239 ++
 drivers/mfd/cs42l43.c                         | 1189 +++++++++
 drivers/mfd/cs42l43.h                         |   28 +
 drivers/pinctrl/cirrus/Kconfig                |   11 +
 drivers/pinctrl/cirrus/Makefile               |    2 +
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c      |  609 +++++
 drivers/soundwire/bus.c                       |   32 +
 drivers/soundwire/bus_type.c                  |   12 +
 drivers/spi/Kconfig                           |    7 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/spi-cs42l43.c                     |  281 ++
 include/linux/mfd/cs42l43-regs.h              | 1184 +++++++++
 include/linux/mfd/cs42l43.h                   |  102 +
 include/linux/soundwire/sdw.h                 |    9 +
 include/sound/cs42l43.h                       |   17 +
 sound/soc/codecs/Kconfig                      |   16 +
 sound/soc/codecs/Makefile                     |    4 +
 sound/soc/codecs/cs42l43-jack.c               |  969 +++++++
 sound/soc/codecs/cs42l43-sdw.c                |   74 +
 sound/soc/codecs/cs42l43.c                    | 2278 +++++++++++++++++
 sound/soc/codecs/cs42l43.h                    |  131 +
 26 files changed, 7636 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs42l43.yaml
 create mode 100644 drivers/mfd/cs42l43-i2c.c
 create mode 100644 drivers/mfd/cs42l43-sdw.c
 create mode 100644 drivers/mfd/cs42l43.c
 create mode 100644 drivers/mfd/cs42l43.h
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-cs42l43.c
 create mode 100644 drivers/spi/spi-cs42l43.c
 create mode 100644 include/linux/mfd/cs42l43-regs.h
 create mode 100644 include/linux/mfd/cs42l43.h
 create mode 100644 include/sound/cs42l43.h
 create mode 100644 sound/soc/codecs/cs42l43-jack.c
 create mode 100644 sound/soc/codecs/cs42l43-sdw.c
 create mode 100644 sound/soc/codecs/cs42l43.c
 create mode 100644 sound/soc/codecs/cs42l43.h

-- 
2.30.2

