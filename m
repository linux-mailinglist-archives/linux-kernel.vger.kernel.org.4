Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D226C6D89DC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjDEVyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjDEVyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:54:07 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8541BD1;
        Wed,  5 Apr 2023 14:54:05 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 335LrpwN024989;
        Wed, 5 Apr 2023 16:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680731631;
        bh=Tlt1X3EAX2fR3eaDrZRX6kFzsEjXNKkGCpmS5w7MokY=;
        h=From:To:CC:Subject:Date;
        b=wqHnbfTiZepLjszO6S7byOhI8SoAY7uVyQVi2ZbGePXebIUCRSQQsOLfp30IhSCxR
         0UoRFrEDIsCX5QmeQExNCYSU+3eLjIo68lG6NeVVUgemePKhgHL66BIOjfo/QpIFhO
         65iWx22LoJp///NwAHoNIjrdahRNwJcTmeNjivrE=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 335LrpON082748
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Apr 2023 16:53:51 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 5
 Apr 2023 16:53:50 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 5 Apr 2023 16:53:50 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 335LroaV049454;
        Wed, 5 Apr 2023 16:53:50 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keerthy <j-keerthy@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH v3 0/7] add VTM nodes to TI's K3 SoCs
Date:   Wed, 5 Apr 2023 16:53:21 -0500
Message-ID: <20230405215328.3755561-1-bb@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hello again everyone!

This patch series adds in basic VTM nodes for all of TI's K3 SoCs. As of
right now these do not do much other than add thermal entries into the
sysfs directory and power down the device once it exceeds a critical
temperature.

Changes from v1: [0]
- Fixed indexing of thermal nodes[0]

Changes from v2: [1]
- Updated unit address for am62x's &cbass_wakeup
- Dropped my j7* patches and cherry-picked Keerthy's

[0] https://lore.kernel.org/all/20230119221322.12563-1-bb@ti.com/
[1] https://lore.kernel.org/all/20230120003051.9100-1-bb@ti.com/

Thanks for reviewing!
~Bryan

Bryan Brattlof (3):
  arm64: dts: ti: k3-am64-main: add VTM node
  arm64: dts: ti: k3-am62-wakeup: add VTM node
  arm64: dts: ti: k3-am62a-wakeup: add VTM node

Keerthy (4):
  arm64: dts: ti: j784s4: Add VTM node
  arm64: dts: ti: j721e: Add VTM node
  arm64: dts: ti: j7200: Add VTM node
  arm64: dts: ti: j721s2: Add VTM node

 arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi   |  33 ++++++
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi    |   8 ++
 arch/arm64/boot/dts/ti/k3-am62.dtsi           |   8 +-
 arch/arm64/boot/dts/ti/k3-am62a-thermal.dtsi  |  47 ++++++++
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi   |   8 ++
 arch/arm64/boot/dts/ti/k3-am62a.dtsi          |   2 +
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |   8 ++
 arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi   |  33 ++++++
 arch/arm64/boot/dts/ti/k3-am64.dtsi           |   3 +
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |   9 ++
 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi  |  47 ++++++++
 arch/arm64/boot/dts/ti/k3-j7200.dtsi          |   2 +
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |   9 ++
 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi  |  75 +++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          |   2 +
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |   9 ++
 arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi | 101 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi         |   4 +
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |   9 ++
 arch/arm64/boot/dts/ti/k3-j784s4-thermal.dtsi | 101 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi         |   4 +
 21 files changed, 520 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-thermal.dtsi


base-commit: 891db0c48efb48c3af334006f9d7ea6a0aa49cb9
-- 
2.40.0

