Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDB069186B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 07:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjBJGR3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Feb 2023 01:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjBJGRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 01:17:25 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EA15BA71;
        Thu,  9 Feb 2023 22:17:23 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 5AFF824DC09;
        Fri, 10 Feb 2023 14:17:16 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 10 Feb
 2023 14:17:16 +0800
Received: from ubuntu.localdomain (183.27.96.33) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 10 Feb
 2023 14:17:15 +0800
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Jack Zhu <jack.zhu@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v1 0/4] Add JH7110 MIPI DPHY RX support
Date:   Thu, 9 Feb 2023 22:17:09 -0800
Message-ID: <20230210061713.6449-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.96.33]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds power mipi dphy rx driver for the StarFive JH7110 SoC.
It use to transfer the CSI cameras data. The series has been tested on
the VisionFive 2 board.

This patchset should be applied after the patchset [1]:
[1] https://lore.kernel.org/all/20230120024445.244345-1-xingyu.wu@starfivetech.com/

Changhuang Liang (4):
  riscv: dts: starfive: jh7110: Add aon syscon node
  dt-bindings: phy: Add starfive,jh7110-dphy-rx
  phy: starfive: Add mipi dphy rx support
  riscv: dts: starfive: Add dphy rx node

 .../bindings/phy/starfive,jh7110-dphy-rx.yaml |  78 ++++
 MAINTAINERS                                   |   7 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  18 +
 drivers/phy/Kconfig                           |   1 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/starfive/Kconfig                  |  13 +
 drivers/phy/starfive/Makefile                 |   2 +
 drivers/phy/starfive/phy-starfive-dphy-rx.c   | 362 ++++++++++++++++++
 8 files changed, 482 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
 create mode 100644 drivers/phy/starfive/Kconfig
 create mode 100644 drivers/phy/starfive/Makefile
 create mode 100644 drivers/phy/starfive/phy-starfive-dphy-rx.c


base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
prerequisite-patch-id: 4dc515731ce237184553c1606ffb3afaeb51c3d8
prerequisite-patch-id: 09c98554df52d17ba5fd604125f8cdd62cbe80d1
prerequisite-patch-id: a798370d170dc2bcc79ed86f741c21c1e6d87c78
prerequisite-patch-id: bd9fd8b5cb2376dc7a5e08e1a1fbb969cf475926
prerequisite-patch-id: c57ebb83bc43ccd2a8366ff166eb499da1e1d2cf
prerequisite-patch-id: a1673a9e9f19d6fab5a51abb721e54e36636f067
prerequisite-patch-id: 94860423c7acc9025249d4bb36652a585bd0a797
prerequisite-patch-id: b5084253283929d9a6d0e66c350400c7c85d034d
prerequisite-patch-id: 6e369dbe9dca2785e4ea7d0b80e525e227a90a6e
prerequisite-patch-id: e08806183c152714c563f3a21c6d7b2f539c4d6e
prerequisite-patch-id: 79db8036abdc48fd36da227652ec62627a6b548b
prerequisite-patch-id: 06971b8e6bddc0e87e63bfdb0ce8bfb653bd73aa
prerequisite-patch-id: 16309a0e23811a2c55d2e56886de3e8eccc51554
prerequisite-patch-id: bf4f7ab0b6cfa90b6e49e66c7d75ed2eaaebbe78
prerequisite-patch-id: 38468d532e87867990055d3320679f18c5f52278
prerequisite-patch-id: 4710f2ac22dca0bdd9ff5d744d2c37cab3c74515
prerequisite-patch-id: 6bb9a780c62af3bcc2368dfd20303c7b1bc91e23
prerequisite-patch-id: 258ea5f9b8bf41b6981345dcc81795f25865d38f
prerequisite-patch-id: 8b6f2c9660c0ac0ee4e73e4c21aca8e6b75e81b9
prerequisite-patch-id: e3b986b9c60b2b93b7812ec174c9e1b4cfb14c97
prerequisite-patch-id: a2b3a9cff8a683422eb0ccf3a0850091401812d4
prerequisite-patch-id: e0ba7af0f8d3d41844da9fbcba14b548cbc18f55
prerequisite-patch-id: bc0176325c11a632c6abaa83e54e891cc92d1c74
prerequisite-patch-id: bd3076c3fde77b417bc5b402b97563f2928d623d
prerequisite-patch-id: 795c5ea9868c12fd62c14220140f0706f3db66ce
prerequisite-patch-id: 2ddada18ab6ea5cd1da14212aaf59632f5203d40
prerequisite-patch-id: c65a2ff3aaed45702d1b52ae7827940a8d33268a
prerequisite-patch-id: 7acbc9c924e802712d3574dd74a6b3576089f78c
prerequisite-patch-id: b43dd09005f22eae3f0b25830d06797adfd7ffa8
prerequisite-patch-id: d426704849c21687b4ef32c7d399081706e34c51
prerequisite-patch-id: 9f71c539a241baf1e73c7e7dfde5b0b04c66a502
prerequisite-patch-id: 83b1dd8af8868e86d33f8f70eb458d3cc0200719
prerequisite-patch-id: 9fddcb61301b615ad6f0102f2235265a01ccc2a2
prerequisite-patch-id: 0c04762f1d20f09cd2a1356334a86e520907d111
prerequisite-patch-id: 40240bed0abde4db2387a70bfc6066d9062c635c
prerequisite-patch-id: 69f1d40d67a5c3f0425ba5b3c52924d5dcd41af0
prerequisite-patch-id: 2bc43b375b470f7e8bbe937b78678ba3856e3b8f
--
2.25.1
