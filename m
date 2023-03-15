Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750B06BA771
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 06:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjCOF6b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Mar 2023 01:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjCOF60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 01:58:26 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA35A4EE1;
        Tue, 14 Mar 2023 22:58:20 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id EC1C124E0B4;
        Wed, 15 Mar 2023 13:58:14 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Mar
 2023 13:58:14 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX068.cuchost.com (172.16.6.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Wed, 15 Mar 2023 13:58:13 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        William Qiu <william.qiu@starfivetech.com>
Subject: [RESEND v6 0/2] StarFive's SDIO/eMMC driver support
Date:   Wed, 15 Mar 2023 13:58:11 +0800
Message-ID: <20230315055813.94740-1-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
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

Hi,

This patchset adds initial rudimentary support for the StarFive
designware mobile storage host controller driver. And this driver will
be used in StarFive's VisionFive 2 board. The main purpose of adding
this driver is to accommodate the ultra-high speed mode of eMMC.

The last patch should be applied after the patchset [1]:
[1] https://lore.kernel.org/all/20221118011714.70877-1-hal.feng@starfivetech.com/

Changes v5->v6:
- Rebased to 6.3-rc1.
- Changed file name to starfive,jh7110.yaml.
- Modified commit description.
- Added syscon node dts patch to other dependent modules.

Changes v4->v5:
- Added a incremental updates to fix a bug that prev_err is uninitialized.
- Dropped the merged patches.
- Dropped the dts patch.
- Sorted compatible alphabetically in yaml.

Changes v3->v4:
- Added documentation to describe StarFive System Controller Registers.
- Added aon_syscon and stg_syscon node.
- Fixed some checkpatch errors/warnings.

Changes v2->v3:
- Wraped commit message according to Linux coding style.
- Rephrased the description of the patches.
- Changed the description of syscon regsiter.
- Dropped redundant properties.

Changes v1->v2:
- Renamed the dt-binding 'starfive,jh7110-sdio.yaml' to 'starfive,jh7110-mmc.yaml'.
- Changed the type of 'starfive,syscon' and modify its description.
- Deleted unused head files like '#include <linux/gpio.h>'.
- Added comment for the 'rise_point' and 'fall_point'.
- Changed the API 'num_caps' to 'common_caps'.
- Changed the node name 'sys_syscon' to 'syscon'.
- Changed the node name 'sdio' to 'mmc'.

The patch series is based on v6.3.

William Qiu (2):
  dt-bindings: soc: starfive: Add StarFive syscon doc
  riscv: dts: starfive: Add syscon node

 .../soc/starfive/starfive,jh7110-syscon.yaml  | 41 +++++++++++++++++++
 MAINTAINERS                                   |  5 +++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 15 +++++++
 3 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml

--
2.34.1

