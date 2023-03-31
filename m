Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774896D1B16
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjCaJBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjCaJAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:00:54 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B797A1E705;
        Fri, 31 Mar 2023 02:00:47 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32V90Xkv005749;
        Fri, 31 Mar 2023 04:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680253233;
        bh=8jdfQo2sTBKDW1ccx7r/PVdtTj5RsNkUP6bylditeTo=;
        h=From:To:CC:Subject:Date;
        b=j4pipfp7JpidHDwZDCsfvh0YTk3ULUHyBE0QegBGkX72vpYo10uKJGLL8xi49YKWl
         G6MLIuQXQHJpbVZ0VIetmgraNfbZ2UVdVQv9Cos34v2klCTmCq1C++3Pka0CkOAFJx
         Pr3QlYXIf24c7y24xS84nzGoCsz6kEmkYyFHCKIE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32V90X5f029779
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Mar 2023 04:00:33 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 31
 Mar 2023 04:00:32 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 31 Mar 2023 04:00:32 -0500
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32V90SuY125579;
        Fri, 31 Mar 2023 04:00:29 -0500
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <vaishnav.a@ti.com>, <r-gunasekaran@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v14 0/8] arm64: j721s2: Add support for additional IPs
Date:   Fri, 31 Mar 2023 14:30:20 +0530
Message-ID: <20230331090028.8373-1-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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

Changes from v13:
* Rebased on linux-next master as there were merge conflicts

Changes from v12:
* Disabled only the nodes that need additonal info

Changes from v11:
* Cleaned up comments for disabled nodes
* Removed deprecated properties for flash node

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

v13: https://lore.kernel.org/all/20230309082940.31535-1-r-gunasekaran@ti.com/
v12: https://lore.kernel.org/all/20230301091136.17862-1-r-gunasekaran@ti.com/
v11: https://lore.kernel.org/all/20230224102438.6541-1-r-gunasekaran@ti.com/
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

 .../dts/ti/k3-j721s2-common-proc-board.dts    |  87 +++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 145 ++++++++++++++++++
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  44 ++++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  |  41 +++++
 4 files changed, 317 insertions(+)


base-commit: 4b0f4525dc4fe8af17b3daefe585f0c2eb0fe0a5
-- 
2.17.1

