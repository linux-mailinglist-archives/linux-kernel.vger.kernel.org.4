Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E046F674CBE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjATFuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjATFuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:50:37 -0500
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF6E11669;
        Thu, 19 Jan 2023 21:50:36 -0800 (PST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0FE231A0007;
        Fri, 20 Jan 2023 06:50:35 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A1EFC1A0B4A;
        Fri, 20 Jan 2023 06:50:34 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DE9EA1802204;
        Fri, 20 Jan 2023 13:50:32 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, peng.fan@nxp.com, marex@denx.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        frank.li@nxp.com
Cc:     lorenzo.pieralisi@arm.com, hongxing.zhu@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH DTS v6 0/6] Add i.MX PCIe EP mode support
Date:   Fri, 20 Jan 2023 13:25:46 +0800
Message-Id: <1674192352-4473-1-git-send-email-hongxing.zhu@nxp.com>
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

arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 13 +++++++++++++
arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 24 ++++++++++++++++++++++++
arch/arm64/boot/dts/freescale/imx8mp-evk.dts  |  6 ++++++
arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 26 ++++++++++++++++++++++++++
arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 11 +++++++++++
arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 32 ++++++++++++++++++++++++++++++++
6 files changed, 112 insertions(+)

[PATCH v6 1/6] arm64: dts: Add i.MX8MM PCIe EP support
[PATCH v6 2/6] arm64: dts: Add i.MX8MM PCIe EP support on EVK board
[PATCH v6 3/6] arm64: dts: Add i.MX8MQ PCIe EP support
[PATCH v6 4/6] arm64: dts: Add i.MX8MQ PCIe EP support on EVK board
[PATCH v6 5/6] arm64: dts: Add i.MX8MP PCIe EP support
[PATCH v6 6/6] arm64: dts: Add i.MX8MP PCIe EP support on EVK board
