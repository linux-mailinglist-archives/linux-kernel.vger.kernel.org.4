Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBAF6AD4FA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjCGCq7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Mar 2023 21:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjCGCqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:46:53 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2D065465;
        Mon,  6 Mar 2023 18:46:51 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 0121E24E236;
        Tue,  7 Mar 2023 10:46:48 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Mar
 2023 10:46:48 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX068.cuchost.com (172.16.6.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Tue, 7 Mar 2023 10:46:47 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        William Qiu <william.qiu@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        <linux-riscv@lists.infradead.org>
Subject: [PATCH v5 0/2] StarFive's SDIO/eMMC driver support
Date:   Tue, 7 Mar 2023 10:46:44 +0800
Message-ID: <20230307024646.10216-1-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
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

The patch series is based on v6.1.

William Qiu (2):
  dt-bindings: syscon: Add StarFive syscon doc
  mmc: starfive: Add initialization of prev_err

 .../bindings/soc/starfive/jh7110-syscon.yaml  | 41 +++++++++++++++++++
 MAINTAINERS                                   |  5 +++
 drivers/mmc/host/dw_mmc-starfive.c            |  2 +-
 3 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml

--
2.34.1

