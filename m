Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28224666A69
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 05:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbjALEie convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Jan 2023 23:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbjALEia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 23:38:30 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B4845650;
        Wed, 11 Jan 2023 20:38:26 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id A38A424DBC0;
        Thu, 12 Jan 2023 12:38:19 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 12 Jan
 2023 12:38:19 +0800
Received: from ubuntu.localdomain (202.188.176.82) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 12 Jan
 2023 12:38:15 +0800
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v4 0/3] hwrng: starfive: Add driver for TRNG module
Date:   Thu, 12 Jan 2023 12:38:09 +0800
Message-ID: <20230112043812.150393-1-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
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

This patch series adds kernel support for StarFive hardware random
number generator. First 2 patches add binding docs and device driver for
this module. Patch 3 adds devicetree entry for VisionFive 2 SoC.

Patch 3 needs to be applied on top of:
https://patchwork.kernel.org/project/linux-riscv/patch/20221220011247.35560-7-hal.feng@starfivetech.com/

Patch 3 also depends on additional clock and reset patches for stg domain
that are yet to be submitted to mailing list.

Changes v3 -> v4:
- move init completion before IRQ registration to be prepared for
  spurious interrupts. (Herbert)
- add locks to guard concurrent write to same register in Patch 2.
  (Herbert)

Changes v2 -> v3:
- use constant usecs and convert to jiffies in Patch 2. (Herbert)
- remove sleep in irq handler in Patch 2. (Herbert)
- limit wait timer to 40us if wait == 0 for trng read. (Herbert)

Changes v1 -> v2:
- updated of_match_ptr and added pm_sleep_ptr in Patch 2. (by Krzysztof)
- drop "status" in dts as module is always on in Patch 3. (by Krzysztof)

Jia Jie Ho (3):
  dt-bindings: rng: Add StarFive TRNG module
  hwrng: starfive - Add TRNG driver for StarFive SoC
  riscv: dts: starfive: Add TRNG node for VisionFive 2

 .../bindings/rng/starfive,jh7110-trng.yaml    |  55 +++
 MAINTAINERS                                   |   6 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  10 +
 drivers/char/hw_random/Kconfig                |  11 +
 drivers/char/hw_random/Makefile               |   1 +
 drivers/char/hw_random/starfive-trng.c        | 397 ++++++++++++++++++
 6 files changed, 480 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/starfive,jh7110-trng.yaml
 create mode 100644 drivers/char/hw_random/starfive-trng.c

-- 
2.25.1

