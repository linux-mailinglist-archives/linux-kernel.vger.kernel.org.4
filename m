Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3449169DFEE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbjBUMIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbjBUMIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:08:16 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9947D84;
        Tue, 21 Feb 2023 04:07:38 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31LC6HXw044705;
        Tue, 21 Feb 2023 06:06:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1676981177;
        bh=nKb9BMtjlsv//lqkpvMaFi9UhdglRUvYrX81wVjf+Qk=;
        h=From:To:CC:Subject:Date;
        b=V1HpjwXqr3yI6FNOpRlYUvJrn1k8WnUo9WF2cLC75BZnTsldJsEc29TFqZrCbapbN
         yCPWmZMkgy1q0UobTo/dOpz1I2esTZW4ffLL1m6MLfohVF/I9BIxJyvzvDUzfqE7ko
         9KXyUeRh/j3zySRHNaQbIBuQjLXc+XdnEDPgBSDc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31LC6H0Z125608
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Feb 2023 06:06:17 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 21
 Feb 2023 06:06:16 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 21 Feb 2023 06:06:16 -0600
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31LC6CbN030829;
        Tue, 21 Feb 2023 06:06:13 -0600
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <r-gunasekaran@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 0/9] arm64: j721s2: Add support for additional IPs
Date:   Tue, 21 Feb 2023 17:36:03 +0530
Message-ID: <20230221120612.27366-1-r-gunasekaran@ti.com>
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

Changes from v1:
* Resolve issues with dt schema reporting
* Minor changes related to consistency on node naming and value

Changes from v2:
* Added PCIe RC + EP enablement patchsets
* Added device-id for j722s2 PCIe host in dt documentation
* Reworked SERDES + WIZ enablement patchset to use properies for clocks
  defines versus entire devicetree nodes. Results in cleaner code that
  doesn't break dt-schema or the driver functionality.

Changes from v3:
* Rebased changes on top of '[PATCH 00/12] TI J7x Disable Incomplete DT Nodes'
* Removed "dt-bindings: PCI: Add host mode device-id for j721s2 platform" patch and
  send it own series to avoid a dependency that would hold up other patches in this
  series

Changes from v4:
* Add my Signed-off-by lines to all patchsets

Changes from v5:
* Removed Cc from commit messages to reduce clutter
* Squashed changes for device tree nodes that get modified latter in the patchset
  series

Changes from v6:
* Changes to ti,j721s2-wiz-10g compatible string from ti,am64-wiz-10g but
  requires this series to be merged first
  Ref: https://lore.kernel.org/linux-arm-kernel/20221122092203.762308-1-mranostay@ti.com/
* Removed unused pcie1_ep based on feedback
* Switch from incorrect "ti,j721e-system-controller", "syscon", "simple-mfd" compatible for
  SPI node to "simple-bus"

Changes from v7:
* Fix node names as per bindings document

Changes from v8:
* Update the ti,j721e-system-controller bindings document
* Fix dtbs warnings

Changes from v9:
* Disable nodes in main.dtsi and enable them in the board
  specific DT file

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

Ravi Gunasekaran (1):
  dt-bindings: mfd: ti,j721e-system-controller: Fix mux node regex

 .../mfd/ti,j721e-system-controller.yaml       |   8 +-
 .../dts/ti/k3-j721s2-common-proc-board.dts    |  98 ++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 147 ++++++++++++++++++
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  47 ++++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  |  43 +++++
 5 files changed, 342 insertions(+), 1 deletion(-)

-- 
2.17.1

