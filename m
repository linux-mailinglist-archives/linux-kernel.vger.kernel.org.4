Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA4E6B1E28
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCIIcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjCIIbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:31:40 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76DFDF261;
        Thu,  9 Mar 2023 00:29:54 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3298Tjg3088676;
        Thu, 9 Mar 2023 02:29:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678350585;
        bh=EN6Y82ER0dPTcUGEYF3Fi4KOCr+DQRU5Jm1MApYxGmI=;
        h=From:To:CC:Subject:Date;
        b=KS41o0cMsSXIxZycxeH9OIezRZcyJy/qULzAM0R6bH6jV9RKmKM1Fd6OC5GfiLQpT
         5EdRp0gIgtcWof7GKrQqOK8bji/8WvRkMIRR59vq7Svn9bHNKjS5LDODm4e3duJO+d
         rJPENsp9yQYGZX0F7JQNJ6Tin/C6xGkC3IcBbZz8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3298TjGn022718
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Mar 2023 02:29:45 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 9
 Mar 2023 02:29:45 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 9 Mar 2023 02:29:45 -0600
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3298Tf59063317;
        Thu, 9 Mar 2023 02:29:41 -0600
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <vaishnav.a@ti.com>, <r-gunasekaran@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 0/8] arm64: j721s2: Add support for additional IPs
Date:   Thu, 9 Mar 2023 13:59:32 +0530
Message-ID: <20230309082940.31535-1-r-gunasekaran@ti.com>
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


base-commit: 2c6433e9294b6d0f4d8f08c3c70a3eac434d3ec8
-- 
2.17.1

