Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5131B656A48
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbiL0L7q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Dec 2022 06:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiL0L7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:59:13 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C918B7F8;
        Tue, 27 Dec 2022 03:59:08 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id A5D3024DD82;
        Tue, 27 Dec 2022 19:59:04 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 27 Dec
 2022 19:58:58 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX168.cuchost.com (172.16.6.78) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Tue, 27 Dec 2022 19:58:57 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@linux.starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] StarFive's SDIO/eMMC driver support
Date:   Tue, 27 Dec 2022 19:58:53 +0800
Message-ID: <20221227115856.460790-1-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset adds initial rudimentary support for the StarFive
designware mobile storage host controller driver. And this driver will
be used in StarFive's VisionFive 2 board. The main purpose of adding
this driver is to accommodate the ultra-high speed mode of eMMC.

The last patch should be applied after the patchset [1]:
[1] https://lore.kernel.org/all/20221118011714.70877-1-hal.feng@starfivetech.com/

Changes since v1:
- Renamed the dt-binding 'starfive,jh7110-sdio.yaml' to 'starfive,jh7110-mmc.yaml'.
- Changed the type of 'starfive,syscon' and modify its description.
- Deleted unused head files like '#include <linux/gpio.h>'.
- Added comment for the 'rise_point' and 'fall_point'.
- Changed the API 'num_caps' to 'common_caps'.
- Changed the node name 'sys_syscon' to 'syscon'.
- Changed the node name 'sdio' to 'mmc'.

The patch series is based on v6.1-rc5.

William Qiu (3):
  dt-bindings: mmc: Add bindings for StarFive
  mmc: starfive: Add sdio/emmc driver support
  riscv: dts: starfive: Add mmc node

 .../bindings/mmc/starfive,jh7110-mmc.yaml     |  72 +++++++
 MAINTAINERS                                   |   6 +
 .../jh7110-starfive-visionfive-v2.dts         |  25 +++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  38 ++++
 drivers/mmc/host/Kconfig                      |  10 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/dw_mmc-starfive.c            | 185 ++++++++++++++++++
 7 files changed, 337 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
 create mode 100644 drivers/mmc/host/dw_mmc-starfive.c

--
2.34.1

