Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA0C5FC73B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 16:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJLOYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 10:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiJLOX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 10:23:58 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA81D38FE;
        Wed, 12 Oct 2022 07:23:55 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CAd0eb013878;
        Wed, 12 Oct 2022 16:23:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=e2at5cECV3lmB6YhVf0LWjp6cb4WKD3ere/W0YhLlM0=;
 b=kyGyJREASfcq6DxrIVNDnu7zdMgKTf5qc7zWI9uJaNR3fNR12uZa1YHyNWQxmFAgRCJC
 DXgbhnHpp71W4d3IAhdpePzbj2mzMYy70Xbr5NuCCkR9DqXe5BWPX1kdk4KiosrhyS8e
 a1Q4iP/F8JcbD2/oFTnsLP6tKKpZTebYfN676zCixOs1O96HQNsaUJY0nHwCkrIClnua
 Rr/U9uHUKTkza/LOZKzWEsdme/FRUXepLYA10XYKylktKYcwP37iw3r2PiwVwec7/Jyi
 nWS1/BV6F3U/N24dFOlS4yLLN0f9C0ipjOBIOiwP51ikDTe1cEoqQLO9BahPg1cdFWIN Kg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k31gq3kby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 16:23:34 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C463810002A;
        Wed, 12 Oct 2022 16:23:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BE95222F7D7;
        Wed, 12 Oct 2022 16:23:04 +0200 (CEST)
Received: from localhost (10.75.127.45) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Wed, 12 Oct
 2022 16:23:04 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v4 0/8] iio: stm32-adc: add support of adc for stm32mp13
Date:   Wed, 12 Oct 2022 16:21:57 +0200
Message-ID: <20221012142205.13041-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_07,2022-10-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On STM32MP13 SoCs, each ADC peripheral has a single ADC block.
These ADC peripherals, ADC1 and ADC2, are fully independent.
The STM32MP131 SoC provides only ADC2, while other STM32MP13x
SoCs provide both ADC1 and ADC2.

The STM32MP13 ADC features and characteristics are slightly
different from STM32MP15 ADC ones, requiring a specific support
in the driver.

This patchset enables the ADC peripheral on STM32MP135F-DK board.

On STM32MP135F-DK board the ADC is connected to VDDA voltage
provided by the PMIC LOD1 supply, which has to be enabled through
SCMI regulator framework.
This serie introduces a fixed regulator to allow ADC probing,
while SCMI regulators support is not available. This does
not ensure ADC regulator enabling however.

Changes in v4:
- reformat patch 1 commit message
- reorder adc1 node

v3:
- Remove blank line in tag block
- Use HZ_PER_MHZ unit for max frequency definition
- Coding style updates

v2:
- Rework commit message length
- Add missing spaces
- Remove useless defines

Olivier Moysan (8):
  iio: adc: stm32-adc: fix channel sampling time init
  dt-bindings: iio: adc: stm32-adc: add stm32mp13 compatibles
  iio: adc: stm32-adc: add stm32mp13 support
  iio: adc: stm32: manage min sampling time on all internal channels
  ARM: dts: stm32: add adc support to stm32mp13
  ARM: dts: stm32: add adc pins muxing on stm32mp135f-dk
  ARM: dts: stm32: add dummy vdd_adc regulator on stm32mp135f-dk
  ARM: dts: stm32: add adc support on stm32mp135f-dk

 .../bindings/iio/adc/st,stm32-adc.yaml        |  68 ++++-
 arch/arm/boot/dts/stm32mp13-pinctrl.dtsi      |   7 +
 arch/arm/boot/dts/stm32mp131.dtsi             |  43 +++
 arch/arm/boot/dts/stm32mp133.dtsi             |  31 +++
 arch/arm/boot/dts/stm32mp135f-dk.dts          |  33 +++
 drivers/iio/adc/stm32-adc-core.c              |  30 ++-
 drivers/iio/adc/stm32-adc-core.h              |  30 +++
 drivers/iio/adc/stm32-adc.c                   | 247 +++++++++++++++---
 8 files changed, 443 insertions(+), 46 deletions(-)

-- 
2.25.1

