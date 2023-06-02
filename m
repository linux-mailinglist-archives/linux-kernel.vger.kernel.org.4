Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A015C71FC8D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbjFBIuG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Jun 2023 04:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjFBItk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:49:40 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE0EE59;
        Fri,  2 Jun 2023 01:49:34 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id C586D24DD54;
        Fri,  2 Jun 2023 16:49:27 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 2 Jun
 2023 16:49:27 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX168.cuchost.com (172.16.6.78) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 2 Jun 2023 16:49:26 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v2 0/3]  Add initialization of clock for StarFive JH7110 SoC
Date:   Fri, 2 Jun 2023 16:49:22 +0800
Message-ID: <20230602084925.215411-1-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset adds initial rudimentary support for the StarFive
Quad SPI controller driver. And this driver will be used in
StarFive's VisionFive 2 board. In 6.4, the QSPI_AHB and QSPI_APB
clocks changed from the default ON state to the default OFF state,
so these clocks need to be enabled in the driver.At the same time,
dts patch is added to this series.

Changes v1->v2:
- Renamed the clock names.
- Specified a different array of clocks
- Used clk_bulk_ APIs

The patch series is based on v6.4rc3.

William Qiu (3):
  dt-bindings: qspi: cdns,qspi-nor: Add clocks for StarFive JH7110 SoC
  spi: cadence-quadspi: Add clock configuration for StarFive JH7110 QSPI
  riscv: dts: starfive: Add QSPI controller node for StarFive JH7110 SoC

 .../bindings/spi/cdns,qspi-nor.yaml           | 15 +++++++--
 .../jh7110-starfive-visionfive-2.dtsi         | 32 +++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 18 +++++++++++
 drivers/spi/spi-cadence-quadspi.c             | 20 ++++++++++++
 4 files changed, 82 insertions(+), 3 deletions(-)

--
2.34.1

