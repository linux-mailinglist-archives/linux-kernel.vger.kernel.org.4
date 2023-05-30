Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0310E716054
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjE3MrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjE3MrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:47:00 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5439AE49;
        Tue, 30 May 2023 05:46:42 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UC5UDP018243;
        Tue, 30 May 2023 14:46:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=Dfpj5XCO79UdCapiGApqIcRuxymrn2cJZCDN8Dsb798=;
 b=OmbFVyE6ljb7l3QmrVehVJ7eoCrwQzTBaxDSWeBmjNjXG/97i/3cQC65jOKbhhrKaXU8
 KuUtnKWDemaTGM8cSfGFH3wtwIbXpRneTGITVu4QaAKR0fMOPhRLnvU0jDHnPq6ayRHc
 Q/h5tZ7/qK0NtyZY+2B2iavZRwmsZxYjNiu/G4uVfevqnpKBj8YLlnDftVF1T/CoXjBT
 MB2ZKTnzte/8lPlKGFfCV5ZJ492sxnM/UQVb7hlttJ1piDQwDH37mpY2p8E07wFN8klu
 ye/mFJTgZq/CA94b8qNkFGNhDloPXLCXQ7B80n+2zuPuIwr1eGAkZcGebgL8un7Urjyi cg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qwdm5hryn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 14:46:12 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 634B910002A;
        Tue, 30 May 2023 14:46:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5B65D2248D8;
        Tue, 30 May 2023 14:46:12 +0200 (CEST)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 30 May
 2023 14:46:12 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marek Vasut <marex@denx.de>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@dh-electronics.com>
Subject: [PATCH v2 0/9] ARM: dts: stm32: add adc internal channels on stm32mp15
Date:   Tue, 30 May 2023 14:45:28 +0200
Message-ID: <20230530124538.621760-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_09,2023-05-30_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add STM32 ADC2 internal channels VREFINT and VDDCORE to STM32MP15x SoCs.

Add support of vrefint channel by adding access to vrefint calibration
data in OTP.

The internal channels are defined in STM32MP15 SoC DT according to
generic channel bindings. The STM32 driver does not support a mixed use
of legacy and generic channels. When generic channels are defined,
legacy channel are ignored. This involves that the board device trees
using legacy bindings have to be changed to generic bindings.

Adopt generic iio bindings on STM32 boards implementing the ADC.

Changes in v2:
- Add patch from https://lore.kernel.org/linux-arm-kernel/20230518020547.487670-1-marex@denx.de/T/
- Change node name from vrefin_cal to vrefin-cal

Marek Vasut (1):
  ARM: dts: stm32: Update to generic ADC channel binding on DHSOM
    systems

Olivier Moysan (8):
  ARM: dts: stm32: add adc internal channels to stm32mp15
  ARM: dts: stm32: add vrefint calibration on stm32mp15
  ARM: dts: stm32: add vrefint support to adc2 on stm32mp15
  ARM: dts: stm32: enable adc on stm32mp15xx-dkx boards
  ARM: dts: stm32: adopt generic iio bindings for adc channels on
    stm32mp157c-ed1
  ARM: dts: stm32: adopt generic iio bindings for adc channels on
    emstamp-argon
  ARM: dts: stm32: adopt generic iio bindings for adc channels on
    dhcor-drc
  ARM: dts: stm32: adopt generic iio bindings for adc channels on
    dhcor-testbench

 arch/arm/boot/dts/stm32mp151.dtsi             | 17 +++++++++
 arch/arm/boot/dts/stm32mp157c-ed1.dts         | 16 ++++++--
 .../boot/dts/stm32mp157c-emstamp-argon.dtsi   |  6 ++-
 arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi  | 18 +++++----
 .../boot/dts/stm32mp15xx-dhcor-avenger96.dtsi | 38 +++++++++++++++----
 .../dts/stm32mp15xx-dhcor-drc-compact.dtsi    | 28 ++++++++++++--
 .../boot/dts/stm32mp15xx-dhcor-testbench.dtsi | 28 ++++++++++++--
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi        | 29 +++++++++-----
 8 files changed, 142 insertions(+), 38 deletions(-)

-- 
2.25.1

