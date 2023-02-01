Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5181F6861B2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 09:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjBAIcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 03:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjBAIcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:32:14 -0500
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C64160C9D;
        Wed,  1 Feb 2023 00:32:12 -0800 (PST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 46C92200E1F;
        Wed,  1 Feb 2023 09:32:11 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DBF95202089;
        Wed,  1 Feb 2023 09:32:10 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0498B180327D;
        Wed,  1 Feb 2023 16:32:08 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        l.stach@pengutronix.de, shawnguo@kernel.org,
        lorenzo.pieralisi@arm.com, peng.fan@nxp.com, marex@denx.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        frank.li@nxp.com
Cc:     hongxing.zhu@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH DTS v8 0/4] Add i.MX PCIe EP mode support
Date:   Wed,  1 Feb 2023 16:06:49 +0800
Message-Id: <1675238813-18048-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX PCIe controller is one dual mode PCIe controller, and can work either
as RC or EP.

This series add the i.MX PCIe EP mode support. And had been verified on
i.MX8MQ, i.MX8MM EVK and i.MX8MP EVK boards.

In the verification, one EVK board used as RC, the other one used as EP.
Use the cross TX/RX differential cable connect the two PCIe ports of these
two EVK boards.

+-----------+                +------------+
|   PCIe TX |<-------------->|PCIe RX     |
|           |                |            |
|EVK Board  |                |EVK Board   |
|           |                |            |
|   PCIe RX |<-------------->|PCIe TX     |
+-----------+                +------------+

Main changes from v7 -> v8:
Refer to Rob's review comments.
- Merge the binding document changes into one commit.
- To avoid the duplication, restruct the common properties of i.MX PCIe
  schema, thus they can be shared by both RC and Endpoint modes.

Main changes from v6 -> v7:
Refer to Krzysztof's review comments.
- Drop the 2/4/6 patches of v6 series.
- Based on for-next branch of Shawn's git, and the fsl,imx6q-pcie.yaml
  changes in the v4.
  Separate the DT-schema for i.MX PCIe Endpoint modes, and pass the
  dt_binding_check and dtbs_check.

Main changes from v5 -> v6:
- The v6 only contains the DTS changes, since PCIe part had been picked up.
- Based on Shawn's for-next branch, and the following two patch-sets [1]
  and [2] issued by Marek, rebase the DTS changes.
[1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20230116101649.46459-1-marex@denx.de/
[2] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20230116101422.46257-1-marex@denx.de/

Main changes from v4 -> v5:
- Rebase to v6.2-rc1.
- Follow the clock definitions on i.MX8MP platform refer to the
  following commit.
  https://patchwork.kernel.org/project/linux-arm-kernel/patch/20221216195932.3228998-1-l.stach@pengutronix.de/

Main changes from v3 -> v4:
- Add the Rob's ACK in the dt-binding patch.
- Use "i.MX" to keep spell consistent.
- Squash generic endpoint infrastructure changes of
  "[12/14] PCI: imx6: Add iMX8MM PCIe EP mode" into Kconfig changes.

NOTE:
The following commits should be cherried back firstly, when apply this
series.

Shawn's tree (git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git)
d50650500064 arm64: dts: imx8mp-evk: Add PCIe support
9e65987b9584 arm64: dts: imx8mp: Add iMX8MP PCIe support
5506018d3dec soc: imx: imx8mp-blk-ctrl: handle PCIe PHY resets

Philipp's tree (git://git.pengutronix.de/git/pza/linux)
051d9eb40388 reset: imx7: Fix the iMX8MP PCIe PHY PERST support

The PHY changes:
https://patchwork.kernel.org/project/linux-pci/cover/1664174463-13721-1-git-send-email-hongxing.zhu@nxp.com/

Main changes from v2 -> v3:
- Add the i.MX8MP PCIe EP support, and verified on i.MX8MP EVK board.
- Rebase to latest pci/next branch(tag: v6.0-rc1 plus some PCIe changes).

Main changes from v1 -> v2:
- Add Rob's ACK into first two commits.
- Rebase to the tag: pci-v5.20-changes of the pci/next branch.

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml | 121 +++++++++++++++++++++++++++++++++++++++++++
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml     | 217 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml        | 111 +++-------------------------------------
MAINTAINERS                                                      |   2 +
arch/arm64/boot/dts/freescale/imx8mm.dtsi                        |  24 +++++++++
arch/arm64/boot/dts/freescale/imx8mp.dtsi                        |  26 ++++++++++
arch/arm64/boot/dts/freescale/imx8mq.dtsi                        |  32 ++++++++++++
7 files changed, 429 insertions(+), 104 deletions(-)

[PATCH v8 1/4] dt-bindings: imx6q-pcie: Restruct i.MX PCIe schema
[PATCH v8 2/4] arm64: dts: Add i.MX8MM PCIe EP support
[PATCH v8 3/4] arm64: dts: Add i.MX8MQ PCIe EP support
[PATCH v8 4/4] arm64: dts: Add i.MX8MP PCIe EP support
