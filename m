Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D505EE226
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbiI1QnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbiI1Qmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:42:50 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E4CE7C1C;
        Wed, 28 Sep 2022 09:42:42 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SGQFUd020655;
        Wed, 28 Sep 2022 18:41:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=8lFpwLfBQhp/XHXOjmu6ATzSxtmoz+37E9iy2AZS3+E=;
 b=UOJtE9FmesbLBtzsQTw0MiOp5z554TUi5DyKrFC6wvq5h3DnVPmSQ0V8OtPpsnjtY5HN
 +09G5ghyaeJbHF8nWBnKPDXRIGyNRFVmuo9tAnfctHlwYxktJe9U3bcj8+K8Kp9J28XY
 bRz5QcbJxtj8cpMqdQANKUWW+JJav2d2klKr3WphRvkr6fmN/qOKqMf2ya2U1HEgf0Fu
 2bVPBtbs+F+kMEj3UIqoVk5R1s9C+xiU/5WBmCpIajl7i2xmz7FpLl1zqycbEjhymg5Q
 6Wo+WiZdhPqLiiQRkwW8jkN6tivUBkwz03TwvOr2O6dWCzxyhIzL6tckFUxoyYepac3f gw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jsqamj87a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 18:41:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1B90010002A;
        Wed, 28 Sep 2022 18:41:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EAA0D23C6B2;
        Wed, 28 Sep 2022 18:41:51 +0200 (CEST)
Received: from localhost (10.75.127.116) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Wed, 28 Sep
 2022 18:41:51 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Yannick Brosseau <yannick.brosseau@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 0/8] iio: stm32-adc: add support of adc for stm32mp13
Date:   Wed, 28 Sep 2022 18:41:06 +0200
Message-ID: <20220928164114.48339-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.116]
X-ClientProxiedBy: GPXDAG2NODE6.st.com (10.75.127.70) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_07,2022-09-28_01,2022-06-22_01
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
 arch/arm/boot/dts/stm32mp135f-dk.dts          |  34 +++
 drivers/iio/adc/stm32-adc-core.c              |  21 ++
 drivers/iio/adc/stm32-adc-core.h              |  32 +++
 drivers/iio/adc/stm32-adc.c                   | 249 +++++++++++++++---
 8 files changed, 442 insertions(+), 43 deletions(-)

-- 
2.25.1

