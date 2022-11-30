Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D1A63CEEE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 06:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbiK3Fzf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Nov 2022 00:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbiK3Fz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 00:55:28 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AF9654D6;
        Tue, 29 Nov 2022 21:55:27 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1CEE524E0AC;
        Wed, 30 Nov 2022 13:52:21 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 30 Nov
 2022 13:52:21 +0800
Received: from ubuntu.localdomain (202.188.176.82) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 30 Nov
 2022 13:52:17 +0800
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>
Subject: [PATCH 0/6] crypto: starfive: Add driver for cryptographic engine
Date:   Wed, 30 Nov 2022 13:52:08 +0800
Message-ID: <20221130055214.2416888-1-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds kernel driver support for Starfive crypto engine.
The engine supports hardware acceleration for HMAC/hash functions,
AES block cipher operations and RSA. The first patch adds basic driver
for device probe and DMA init. The subsequent patches adds supported
crypto primitives to the driver which include hash functions, AES and
RSA. Patch 5 adds documentation to describe device tree bindings and the
last patch adds device node to VisionFive 2 dts.

The driver has been tested with crypto selftest and additional test.

This patch series depends on the following patches:
https://patchwork.kernel.org/project/linux-riscv/cover/20221118010627.70576-1-hal.feng@starfivetech.com/
https://patchwork.kernel.org/project/linux-riscv/cover/20221118011714.70877-1-hal.feng@starfivetech.com/

Jia Jie Ho (6):
  crypto: starfive - Add StarFive crypto engine support
  crypto: starfive - Add hash and HMAC support
  crypto: starfive - Add AES skcipher and aead support
  crypto: starfive - Add Public Key algo support
  dt-bindings: crypto: Add bindings for Starfive crypto driver
  riscv: dts: starfive: Add crypto and DMA node for VisionFive 2

 .../bindings/crypto/starfive-crypto.yaml      |  109 ++
 MAINTAINERS                                   |    7 +
 .../jh7110-starfive-visionfive-v2.dts         |    8 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |   36 +
 drivers/crypto/Kconfig                        |    1 +
 drivers/crypto/Makefile                       |    1 +
 drivers/crypto/starfive/Kconfig               |   20 +
 drivers/crypto/starfive/Makefile              |    4 +
 drivers/crypto/starfive/starfive-aes.c        | 1723 +++++++++++++++++
 drivers/crypto/starfive/starfive-cryp.c       |  324 ++++
 drivers/crypto/starfive/starfive-hash.c       | 1152 +++++++++++
 drivers/crypto/starfive/starfive-pka.c        |  683 +++++++
 drivers/crypto/starfive/starfive-regs.h       |  200 ++
 drivers/crypto/starfive/starfive-str.h        |  194 ++
 14 files changed, 4462 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/starfive-crypto.yaml
 create mode 100644 drivers/crypto/starfive/Kconfig
 create mode 100644 drivers/crypto/starfive/Makefile
 create mode 100644 drivers/crypto/starfive/starfive-aes.c
 create mode 100644 drivers/crypto/starfive/starfive-cryp.c
 create mode 100644 drivers/crypto/starfive/starfive-hash.c
 create mode 100644 drivers/crypto/starfive/starfive-pka.c
 create mode 100644 drivers/crypto/starfive/starfive-regs.h
 create mode 100644 drivers/crypto/starfive/starfive-str.h

-- 
2.25.1

