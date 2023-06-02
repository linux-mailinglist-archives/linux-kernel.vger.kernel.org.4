Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C9572034B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbjFBN3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbjFBN3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:29:24 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CE21BB;
        Fri,  2 Jun 2023 06:29:23 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352Bxqhe001514;
        Fri, 2 Jun 2023 15:29:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=Jaa9ldqnH9KBfB6bgVSLUH7do/rkSGKUFcgJkRV5qeg=;
 b=eHT1B5x3tld74c/PxAnFGDH2M2q0FHnMDECpqOzJ0JhuZU9osWR+CM8nvmVjnWa7HoL8
 s/nbhzZ9H9UeeR6ke47mwUYSgMznJ+fxS6YQs29mwrWL7Z9jiW642UPAH55KHkc6ozZZ
 EC+yiHJmtrFNNveKaCRIHFyaEW5Ka45eiSBkikRl1V6BsFT5GxWZSngMTj6JQQBIzYJN
 rfnQTtbxnEQ3J7C9IbnlTFavuK6ze+UV1TVermEOWtJfQPRlnVI85gtmcY8lc+Cku8Si
 c0cVgHUJ3VVhEKqIl1WowwPUkc4+O/wj1D6FkG9NP4RXKuxaEjA3Ceks7jUpaRix56MJ 8A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qweqepguk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 15:29:04 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D3A9310002A;
        Fri,  2 Jun 2023 15:29:03 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C4A11236927;
        Fri,  2 Jun 2023 15:29:03 +0200 (CEST)
Received: from localhost (10.201.21.93) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 2 Jun
 2023 15:29:03 +0200
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, <soc@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: [PATCH v2 00/10] Add STM32MP25 support
Date:   Fri, 2 Jun 2023 15:28:49 +0200
Message-ID: <20230602132859.16442-1-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_10,2023-06-02_02,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm pleased to announce extension of the STM32 MPU family with the addition of
the STM32MP25 Armv8 based SoCs.

STM32MP25 family is composed of 4 SoCs defined as following:

  -STM32MP251: common part composed of 1*Cortex-A35, common peripherals like
   SDMMC, UART, SPI, I2C, PCIe, USB3, parallel and DSI display, 1*ETH ...

  -STM32MP253: STM32MP251 + 1*Cortex-A35 (dual CPU), a second ETH, CAN-FD and
   LVDS display.

  -STM32MP255: STM32MP253 + GPU/AI and video encode/decode.
  -STM32MP257: STM32MP255 + ETH TSN switch (2+1 ports).

  A second diversity layer exists for security features/ A35 frequency:
  -STM32MP25xY, "Y" gives information:
    -Y = A means A35@1.2GHz + no cryp IP and no secure boot.
    -Y = C means A35@1.2GHz + cryp IP and secure boot.
    -Y = D means A35@1.5GHz + no cryp IP and no secure boot.
    -Y = F means A35@1.5GHz + cryp IP and secure boot.

This series adds the STM32MP257F EV1 board support. This board embeds a
STM32MP257FAI SoC, with 4GB of DDR4, TSN switch (2+1 ports), 2*USB typeA,
1*USB2 typeC, SNOR OctoSPI, mini PCIe, STPMIC2 for power distribution ...

Changes since v1:

-Add Conor "reviewed-by".
-Drop patch[4] of initial series to not define SoC without board in stm32,yaml.
-Add Krzysztof "Acked-by" after reordering enum in st,stm32-syscon.yaml

Thanks
Alex

Alexandre Torgue (9):
  dt-bindings: pinctrl: stm32: support for stm32mp257 and additional
    packages
  pinctrl: stm32: add stm32mp257 pinctrl support
  arm64: introduce STM32 family on Armv8 architecture
  arm64: dts: st: introduce stm32mp25 SoCs family
  arm64: dts: st: introduce stm32mp25 pinctrl files
  dt-bindings: stm32: document stm32mp257f-ev1 board
  arm64: dts: st: add stm32mp257f-ev1 board support
  arm64: defconfig: enable ARCH_STM32 and STM32 serial driver
  MAINTAINERS: add entry for ARM/STM32 ARCHITECTURE

Patrick Delaunay (1):
  dt-bindings: stm32: add st,stm32mp25-syscfg compatible for syscon

 .../bindings/arm/stm32/st,stm32-syscon.yaml   |    7 +-
 .../devicetree/bindings/arm/stm32/stm32.yaml  |    6 +
 .../bindings/pinctrl/st,stm32-pinctrl.yaml    |    4 +-
 MAINTAINERS                                   |    1 +
 arch/arm64/Kconfig.platforms                  |   14 +
 arch/arm64/boot/dts/Makefile                  |    1 +
 arch/arm64/boot/dts/st/Makefile               |    2 +
 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi |   38 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi        |  279 ++
 arch/arm64/boot/dts/st/stm32mp253.dtsi        |   23 +
 arch/arm64/boot/dts/st/stm32mp255.dtsi        |    9 +
 arch/arm64/boot/dts/st/stm32mp257.dtsi        |    9 +
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |   50 +
 arch/arm64/boot/dts/st/stm32mp25xc.dtsi       |    8 +
 arch/arm64/boot/dts/st/stm32mp25xf.dtsi       |    8 +
 .../boot/dts/st/stm32mp25xxai-pinctrl.dtsi    |   83 +
 .../boot/dts/st/stm32mp25xxak-pinctrl.dtsi    |   71 +
 .../boot/dts/st/stm32mp25xxal-pinctrl.dtsi    |   71 +
 arch/arm64/configs/defconfig                  |    3 +
 drivers/pinctrl/stm32/Kconfig                 |    6 +
 drivers/pinctrl/stm32/Makefile                |    1 +
 drivers/pinctrl/stm32/pinctrl-stm32.h         |    3 +
 drivers/pinctrl/stm32/pinctrl-stm32mp257.c    | 2581 +++++++++++++++++
 include/dt-bindings/pinctrl/stm32-pinfunc.h   |    3 +
 24 files changed, 3277 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/st/Makefile
 create mode 100644 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp251.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp253.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp255.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp257.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
 create mode 100644 arch/arm64/boot/dts/st/stm32mp25xc.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp25xf.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp25xxai-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp25xxak-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp25xxal-pinctrl.dtsi
 create mode 100644 drivers/pinctrl/stm32/pinctrl-stm32mp257.c

-- 
2.17.1

