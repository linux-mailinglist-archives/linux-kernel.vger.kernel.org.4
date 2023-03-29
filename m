Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8926CED07
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjC2PeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjC2Pdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:33:51 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F20859EE;
        Wed, 29 Mar 2023 08:33:40 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9F10024E0FC;
        Wed, 29 Mar 2023 23:33:32 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 29 Mar
 2023 23:33:32 +0800
Received: from localhost.localdomain (113.72.144.76) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 29 Mar
 2023 23:33:32 +0800
From:   Walker Chen <walker.chen@starfivetech.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Walker Chen <walker.chen@starfivetech.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v1 0/3] Add TDM audio on StarFive JH7110
Date:   Wed, 29 Mar 2023 23:33:17 +0800
Message-ID: <20230329153320.31390-1-walker.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.76]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds TDM audio driver for the StarFive JH7110 SoC. The
first patch adds device tree binding for TDM module. The second patch
adds tdm driver support for JH7110 SoC. The last patch adds device node
of tdm and sound card to JH7110 dts.

The series has been tested on the VisionFive 2 boards which equip with
JH7110 SoC and works normally.

The last patch should be applied after the following patchset:
https://lore.kernel.org/all/20230322094820.24738-1-walker.chen@starfivetech.com/

Walker Chen (3):
  dt-bindings: sound: Add TDM for StarFive JH7110
  ASoC: starfive: Add JH7110 TDM driver
  riscv: dts: starfive: add tdm node and sound card

 .../bindings/sound/starfive,jh7110-tdm.yaml   |  95 +++
 MAINTAINERS                                   |   6 +
 .../jh7110-starfive-visionfive-2.dtsi         |  87 +++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  34 +
 sound/soc/Kconfig                             |   1 +
 sound/soc/Makefile                            |   1 +
 sound/soc/starfive/Kconfig                    |  15 +
 sound/soc/starfive/Makefile                   |   2 +
 sound/soc/starfive/jh7110_tdm.c               | 579 ++++++++++++++++++
 sound/soc/starfive/jh7110_tdm.h               | 155 +++++
 10 files changed, 975 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/starfive,jh7110-tdm.yaml
 create mode 100644 sound/soc/starfive/Kconfig
 create mode 100644 sound/soc/starfive/Makefile
 create mode 100644 sound/soc/starfive/jh7110_tdm.c
 create mode 100644 sound/soc/starfive/jh7110_tdm.h


base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
prerequisite-patch-id: c3a6b87df79b338fc97766406d010fedb79ab428
prerequisite-patch-id: b49509523cf7c098f684647bdc4fdaece48b61bc
prerequisite-patch-id: 46cc850aa0e9e03ccf5ed23d8458babfca3d71af
prerequisite-patch-id: a6975e61ee5803fbd74b1c21ab925fd81c3c0eab
prerequisite-patch-id: ac150a8c622e858e088df8121093d448df49c245
prerequisite-patch-id: 044263ef2fb9f1e5a586edbf85d5f67814a28430
prerequisite-patch-id: 89f049f951e5acf75aab92541992f816fd0acc0d
prerequisite-patch-id: 9f3dbc9073eee89134e68977e941e457593c2757
prerequisite-patch-id: 8600b156a235be2b3db53be3f834e7a370e2cfb9
prerequisite-patch-id: 1b2d0982b18da060c82134f05bf3ce16425bac8d
prerequisite-patch-id: 090ba4b78d47bc19204916e76fdbc70021785388
prerequisite-patch-id: a5d9e0f7d4f8163f566678894cf693015119f2d9
prerequisite-patch-id: 4c12d958e3a3d629d86dddb1e4f099d8909393e0
prerequisite-patch-id: bb939c0c7c26b08addfccd890f9d3974b6eaec53
prerequisite-patch-id: 8f5c66dfb14403424044192f6fa05b347ad356a7
prerequisite-patch-id: fd93763b95469912bde9bdfa4cd827c8d5dba9c6
prerequisite-patch-id: 6987950c2eb4b3773b2df8f7934eff434244aeab
prerequisite-patch-id: 258ea5f9b8bf41b6981345dcc81795f25865d38f
prerequisite-patch-id: 8b6f2c9660c0ac0ee4e73e4c21aca8e6b75e81b9
prerequisite-patch-id: dbb0c0151b8bdf093e6ce79fd2fe3f60791a6e0b
prerequisite-patch-id: e7773c977a7b37692e9792b21cc4f17fa58f9215
prerequisite-patch-id: d57e95d31686772abc4c4d5aa1cadc344dc293cd
prerequisite-patch-id: 9f911969d0a550648493952c99096d26e05d4d83
prerequisite-patch-id: 2ddada18ab6ea5cd1da14212aaf59632f5203d40
prerequisite-patch-id: 398744c61913c76a35754de867c4f820ca7a8d99
prerequisite-patch-id: be3d7a6a13098884ec26cd5e543cc95c39045e35
prerequisite-patch-id: b3ce7955a80d90d992b7d1bca3409f465810b2bb
prerequisite-patch-id: db2f66860cc5b2fd2f71747c4428287b6e3153fb
prerequisite-patch-id: 9da71dcd3af4c68da9d855b43aab6927103e7525
prerequisite-patch-id: 2d9e4f185631549094b6136cf8717a507b68c5bb
prerequisite-patch-id: bb8e071ed43998874b9d98292c0dcdeedc0760ca
prerequisite-patch-id: cd0b464336aabfbfad96c1a3595c0f9ce9401638
prerequisite-patch-id: 24eab3d30274700c2be4727bece743c76d2618bd
prerequisite-patch-id: 584c256c9acb52ee2773d0c81c3f4977fc18155a
prerequisite-patch-id: 2bc43b375b470f7e8bbe937b78678ba3856e3b8f
prerequisite-patch-id: 32deea16304859842af5c2151bc41d91cf6dfc9b
prerequisite-patch-id: d85dbedbb3b36bbd6806f4eb84a2129c8f8963aa
prerequisite-patch-id: c0bdbdd3db98f7ebae0661dd331edac2c84c70f8
prerequisite-patch-id: 6abf359fa445f4104432ddee27044dfbfb128417
-- 
2.17.1

