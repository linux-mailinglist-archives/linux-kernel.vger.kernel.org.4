Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CBA6A1A36
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjBXK06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjBXK04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:26:56 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2836567990;
        Fri, 24 Feb 2023 02:26:19 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31OAOhsL118566;
        Fri, 24 Feb 2023 04:24:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1677234283;
        bh=/iQ3iStdTlNQkLqKEq1E77rDZBkv90EtIOlvk33gVcU=;
        h=From:To:CC:Subject:Date;
        b=meybk1Uyk8Ce1EyLxHyRBuG9Ubs2UmwjBK+B/Vnxa+LgCry2k7kvgo+sGtBHdFUbB
         ERyeIFTwV6yx+S44/DHwMESKfQXfW4OduezR2ukutjuCpRl4pFAwiziy/lH6dBEDwQ
         uNy/yP8OxozsAmj3Mh1YGbosdcKns6UVMR5ifduU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31OAOh1Y044410
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Feb 2023 04:24:43 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 24
 Feb 2023 04:24:42 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 24 Feb 2023 04:24:42 -0600
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31OAOcXa016652;
        Fri, 24 Feb 2023 04:24:39 -0600
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <vaishnav.a@ti.com>, <r-gunasekaran@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 0/8] arm64: j721s2: Add support for additional IPs
Date:   Fri, 24 Feb 2023 15:54:30 +0530
Message-ID: <20230224102438.6541-1-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches add support for the following
on J721S2 common processor board,

- USB
- SerDes
- OSPI
- PCIe

Changes from v10:
* Removed the ti,j721e-system-controller bindings document
  patch introduced in v9
* Updated mux-controller node with "reg" property to fix dtbs
  warnings
* For the nodes which are disabled by default, added comments to
  provide the reason behind it
* Dropped Link tags in all patches

Changes from v9:
* Disabled nodes in main.dtsi and enable them in the board
  specific DT file

Changes from v8:
* Update the ti,j721e-system-controller bindings document
* Fix dtbs warnings

Changes from v7:
* Fix node names as per bindings document

Changes from v6:
* Changes to ti,j721s2-wiz-10g compatible string from ti,am64-wiz-10g but
  requires this series to be merged first
  Ref: https://lore.kernel.org/linux-arm-kernel/20221122092203.762308-1-mranostay@ti.com/
* Removed unused pcie1_ep based on feedback
* Switch from incorrect "ti,j721e-system-controller", "syscon", "simple-mfd" compatible for
  SPI node to "simple-bus"

Changes from v5:
* Removed Cc from commit messages to reduce clutter
* Squashed changes for device tree nodes that get modified latter in the patchset
  series

Changes from v4:
* Add my Signed-off-by lines to all patchsets

Changes from v3:
* Rebased changes on top of '[PATCH 00/12] TI J7x Disable Incomplete DT Nodes'
* Removed "dt-bindings: PCI: Add host mode device-id for j721s2 platform" patch and
  send it own series to avoid a dependency that would hold up other patches in this
  series.

Changes from v2:
* Added PCIe RC + EP enablement patchsets
* Added device-id for j722s2 PCIe host in dt documentation
* Reworked SERDES + WIZ enablement patchset to use properies for clocks
  defines versus entire devicetree nodes. Results in cleaner code that
  doesn't break dt-schema or the driver functionality.

Changes from v1:
* Resolve issues with dt schema reporting
* Minor changes related to consistency on node naming and value

v10: https://lore.kernel.org/all/20230221120612.27366-1-r-gunasekaran@ti.com/
v9: https://lore.kernel.org/all/20230220111408.9476-1-r-gunasekaran@ti.com/
v8: https://lore.kernel.org/all/20230123095733.31657-1-r-gunasekaran@ti.com/
v7: https://lore.kernel.org/all/20221122101616.770050-1-mranostay@ti.com/
v6: https://lore.kernel.org/all/20221119040906.9495-1-mranostay@ti.com/
v5: https://lore.kernel.org/all/20221103044125.172864-1-mranostay@ti.com/
v4: https://lore.kernel.org/all/20221101033204.33048-1-mranostay@ti.com/
v3: https://lore.kernel.org/all/20220921031327.4135-1-mranostay@ti.com/
v2: https://lore.kernel.org/all/20220908011911.3319-1-mranostay@ti.com/
v1: https://lore.kernel.org/all/20220125131113.727-1-a-govindraju@ti.com/

Aswath Govindraju (7):
  arm64: dts: ti: k3-j721s2-main: Add support for USB
  arm64: dts: ti: k3-j721s2-mcu-wakeup: Add support of OSPI
  arm64: dts: ti: k3-j721s2-common-proc-board: Enable SERDES0
  arm64: dts: ti: k3-j721s2-common-proc-board: Add USB support
  arm64: dts: ti: k3-j721s2: Add support for OSPI Flashes
  arm64: dts: ti: k3-j721s2-main: Add PCIe device tree node
  arm64: dts: ti: k3-j721s2-common-proc-board: Enable PCIe

Matt Ranostay (1):
  arm64: dts: ti: k3-j721s2-main: Add SERDES and WIZ device tree node

 .../dts/ti/k3-j721s2-common-proc-board.dts    |  98 ++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 173 ++++++++++++++++++
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  62 +++++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  |  43 +++++
 4 files changed, 376 insertions(+)

-- 
2.17.1

