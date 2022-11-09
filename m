Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B086230A5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiKIQzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiKIQzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:55:02 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1758275C2;
        Wed,  9 Nov 2022 08:53:56 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9EDNjP027347;
        Wed, 9 Nov 2022 10:53:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=k8YRcTfT3aisaN5ZDbd2wMS/yi2Pyuz/u1QMiJhNTwA=;
 b=cnm30tkJRhHdUYk9JnJo8U30jfv7PnB/Ij+Dk58cTRsrvux0IA78y8MMYKCbSb+tpjAK
 Qw2YsTqkw+vN4/aKHfbwnanHRVMEDi3woFvTyxkl3mBbvOfAjMK85kOM3y686SDBCD5v
 YhsP753gLYkMphI7cKRa1lPbd4NVz9WihstDrKZV187YJz/tANHLZZtf9smI0nZ8IOuw
 mpk2UenwqL/0Bi/4bKM2oOals4dbrB8JjlLJSzRZyBBhHktQsdlsvnGfzBQvPrBTF71m
 op7hNtnVJWoCtT1oou4i2EA/ji0Xu2Usb/6kDgHhcfN556ncGi1ax6lGg+sYGk22A5HT Qw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3knm8pde7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 10:53:34 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Wed, 9 Nov
 2022 10:53:32 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.15 via Frontend Transport; Wed, 9 Nov 2022 10:53:32 -0600
Received: from debianA11184.ad.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.92])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8D91E468;
        Wed,  9 Nov 2022 16:53:31 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <broonie@kernel.org>, <tglx@linutronix.de>, <maz@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 00/12] Add support for the Cirrus Logic CS48L32 audio codecs
Date:   Wed, 9 Nov 2022 16:53:19 +0000
Message-ID: <20221109165331.29332-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7OgRwOdDiCAARw0Ea_LvKQSL2ZxiXG9y
X-Proofpoint-GUID: 7OgRwOdDiCAARw0Ea_LvKQSL2ZxiXG9y
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CS48L32 is a high-performance low-power audio DSP for smartphones
and other portable audio devices. It has various digital audio I/O,
a programmable Halo Core DSP, fixed-function audio processors,
configurable GPIO and microphone bias regulators.

The CS48L31 and CS48L33 were derivatives of the CS48L32.

Piotr Stankiewicz (2):
  mfd: cs48l32: Add support for CS48L31/32/33 codecs
  pinctrl: cirrus: Add support for CS48L31/32/33 codecs

Richard Fitzgerald (9):
  dt-bindings: mfd: Add Cirrus Logic CS48L32 audio codec
  mfd: cs48l32: Add register definitions for Cirrus Logic CS48L31/32/33
  dt-bindings: pinctrl: Add Cirrus Logic CS48L31/32/33
  regulator: arizona-micsupp: Don't hardcode use of ARIZONA defines
  regulator: arizona-micsupp: Don't use a common regulator name
  regulator: arizona-micsupp: Support Cirrus Logic CS48L31/32/33
  irqchip: cirrus: Add driver for Cirrus Logic CS48L31/32/33 codecs
  ASoC: wm_adsp: Allow client to hook into pre_run callback
  dt-bindings: sound: Add Cirrus Logic CS48L31/32/33 codecs

Stuart Henderson (1):
  ASoC: cs48l32: Add codec driver for Cirrus Logic CS48L31/32/33

 .../bindings/mfd/cirrus,cs48l32.yaml          |  166 +
 .../bindings/pinctrl/cirrus,cs48l32.yaml      |   98 +
 .../bindings/sound/cirrus,cs48l32.yaml        |   96 +
 MAINTAINERS                                   |   12 +-
 drivers/irqchip/Kconfig                       |    3 +
 drivers/irqchip/Makefile                      |    1 +
 drivers/irqchip/irq-cirrus-cs48l32.c          |  281 ++
 drivers/irqchip/irq-cirrus-cs48l32.h          |   74 +
 drivers/mfd/Kconfig                           |   13 +
 drivers/mfd/Makefile                          |    2 +
 drivers/mfd/cs48l32-tables.c                  |  541 ++++
 drivers/mfd/cs48l32.c                         |  434 +++
 drivers/mfd/cs48l32.h                         |   28 +
 drivers/pinctrl/cirrus/Kconfig                |    5 +
 drivers/pinctrl/cirrus/Makefile               |    2 +
 drivers/pinctrl/cirrus/pinctrl-cs48l32.c      |  932 ++++++
 drivers/pinctrl/cirrus/pinctrl-cs48l32.h      |   62 +
 drivers/regulator/Kconfig                     |    8 +-
 drivers/regulator/arizona-micsupp.c           |   78 +-
 include/dt-bindings/sound/cs48l32.h           |   25 +
 include/linux/irqchip/irq-cirrus-cs48l32.h    |  101 +
 include/linux/mfd/cs48l32/core.h              |   49 +
 include/linux/mfd/cs48l32/registers.h         |  509 +++
 include/sound/cs48l32.h                       |   89 +
 sound/soc/codecs/Kconfig                      |    9 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/cs48l32-core.c               | 2782 +++++++++++++++++
 sound/soc/codecs/cs48l32.c                    | 1211 +++++++
 sound/soc/codecs/cs48l32.h                    |  386 +++
 sound/soc/codecs/wm_adsp.c                    |   11 +
 sound/soc/codecs/wm_adsp.h                    |    1 +
 31 files changed, 7997 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,cs48l32.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs48l32.yaml
 create mode 100644 drivers/irqchip/irq-cirrus-cs48l32.c
 create mode 100644 drivers/irqchip/irq-cirrus-cs48l32.h
 create mode 100644 drivers/mfd/cs48l32-tables.c
 create mode 100644 drivers/mfd/cs48l32.c
 create mode 100644 drivers/mfd/cs48l32.h
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-cs48l32.c
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-cs48l32.h
 create mode 100644 include/dt-bindings/sound/cs48l32.h
 create mode 100644 include/linux/irqchip/irq-cirrus-cs48l32.h
 create mode 100644 include/linux/mfd/cs48l32/core.h
 create mode 100644 include/linux/mfd/cs48l32/registers.h
 create mode 100644 include/sound/cs48l32.h
 create mode 100644 sound/soc/codecs/cs48l32-core.c
 create mode 100644 sound/soc/codecs/cs48l32.c
 create mode 100644 sound/soc/codecs/cs48l32.h

-- 
2.30.2

