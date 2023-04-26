Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE4C6EEEA5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 08:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbjDZG7A convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Apr 2023 02:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjDZG65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 02:58:57 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868A81FE9;
        Tue, 25 Apr 2023 23:58:55 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 5D68E7FD6;
        Wed, 26 Apr 2023 14:58:54 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 26 Apr
 2023 14:58:54 +0800
Received: from ubuntu.localdomain (202.188.176.82) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 26 Apr
 2023 14:58:51 +0800
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v6 0/4] crypto: starfive - Add drivers for crypto engine
Date:   Wed, 26 Apr 2023 14:58:44 +0800
Message-ID: <20230426065848.842221-1-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds kernel driver support for StarFive JH7110 crypto
engine. The first patch adds Documentations for the device and Patch 2
adds device probe and DMA init for the module. Patch 3 adds crypto and
DMA dts node for VisionFive 2 board. Patch 4 adds hash/hmac support to
the module.

Patch 3 needs to be applied on top of:
https://lore.kernel.org/lkml/20230424135409.6648-3-xingyu.wu@starfivetech.com/

Patch 4 needs to be applied on top of:
https://lore.kernel.org/linux-crypto/ZEEOXIHwqKblKfBJ@gondor.apana.org.au/T/#u

Changes v5->v6
- Remove set_crypt in export as request will have been created by
  init/updated calls (Herbert)
- Use new helper to set statesize of crypto_ahash (Herbert)
- Use crypto_ahash_blocksize instead of crypto_ahash_tfm (Herbert)
- Switch to init_tfm/exit_tfm instead of cra_init/cra_exit (Herbert)

Changes v4->v5
- Schedule tasklet from IRQ handler instead of using completion to sync
  events (Herbert)

Changes v3->v4:
- Use fallback for non-aligned cases as hardware doesn't support
  hashing piece-meal (Herbert)
- Use ahash_request_set_* helpers to update members of ahash_request
  (Herbert)
- Set callbacks for async fallback (Herbert)
- Remove completion variable and use dma_callback to do the rest of
  processing instead. (Herbert)

Changes v2->v3:
- Only implement digest and use fallback for other ops (Herbert)
- Use interrupt instead of polling for hash complete (Herbert)
- Remove manual data copy from out-of-bound memory location as it will
  be handled by DMA API. (Christoph & Herbert)

Changes v1->v2:
- Fixed yaml filename and format (Krzysztof)
- Removed unnecessary property names in yaml (Krzysztof)
- Moved of_device_id table close to usage (Krzysztof)
- Use dev_err_probe for error returns (Krzysztof)
- Dropped redundant readl and writel wrappers (Krzysztof)
- Updated commit signed offs (Conor)
- Dropped redundant node in dts, module set to on in dtsi (Conor)

Jia Jie Ho (4):
  dt-bindings: crypto: Add StarFive crypto module
  crypto: starfive - Add crypto engine support
  riscv: dts: starfive: Add crypto and DMA node for VisionFive 2
  crypto: starfive - Add hash and HMAC support

 .../crypto/starfive,jh7110-crypto.yaml        |  70 ++
 MAINTAINERS                                   |   7 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  28 +
 drivers/crypto/Kconfig                        |   1 +
 drivers/crypto/Makefile                       |   1 +
 drivers/crypto/starfive/Kconfig               |  21 +
 drivers/crypto/starfive/Makefile              |   4 +
 drivers/crypto/starfive/jh7110-cryp.c         | 237 +++++
 drivers/crypto/starfive/jh7110-cryp.h         | 127 +++
 drivers/crypto/starfive/jh7110-hash.c         | 896 ++++++++++++++++++
 10 files changed, 1392 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml
 create mode 100644 drivers/crypto/starfive/Kconfig
 create mode 100644 drivers/crypto/starfive/Makefile
 create mode 100644 drivers/crypto/starfive/jh7110-cryp.c
 create mode 100644 drivers/crypto/starfive/jh7110-cryp.h
 create mode 100644 drivers/crypto/starfive/jh7110-hash.c

-- 
2.25.1

