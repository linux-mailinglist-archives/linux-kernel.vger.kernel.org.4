Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9645724B40
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238916AbjFFSXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjFFSWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:22:55 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EBA1981;
        Tue,  6 Jun 2023 11:22:38 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 356IMNfL019415;
        Tue, 6 Jun 2023 13:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686075743;
        bh=PJgqz0kh/FBk5jEhPe/SR1hC1VgO9snRF9ReAW7NWIo=;
        h=From:To:CC:Subject:Date;
        b=jQE05N87CWxMDPo/rAP0yVkohG93FKY2amapD2cGC2p/cdbz8123zcBM2nMiRRLgQ
         6di/AMNMvgOl7s9Q45v8jxa2wh6I8O38uQERaL4Tlcz+84Xep1BwO1Iv5jtZ2NooGg
         P81eoTwmRAOd/XJLsfZg8j9lg2dM3IeivKuU5mXg=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 356IMNC4012367
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 13:22:23 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 13:22:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 13:22:22 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 356IMMoM024130;
        Tue, 6 Jun 2023 13:22:22 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Udit Kumar <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 00/14] arm64: dts: ti: Fix up references to phandles
Date:   Tue, 6 Jun 2023 13:22:06 -0500
Message-ID: <20230606182220.3661956-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When referring to array of phandles, using <> to separate the array
entries is better notation as it makes potential errors with phandle and
cell arguments easier to catch. Fix the outliers to be consistent with
the rest of the usage.

This set was caught by using: git grep '\s&' arch/arm64/boot/dts/ti/
and manually going through the list.

Changes since V1:
* Few formatting changes included to keep consistent
* Picked a Reviewed-by
* ai64 gets a few fixes as part of the cleanup (patches #3, #4)
* Picked up Reviewed-by from Jan.

V1: https://lore.kernel.org/all/20230601152636.858553-1-nm@ti.com/

Nishanth Menon (14):
  arm64: dts: ti: k3-j721e-sk: Fixup reference to phandles array
  arm64: dts: ti: k3-j721e-som-p0/common-proc-board: Fixup reference to
    phandles array
  arm64: dts: ti: k3-j721e-beagleboneai64: Move camera gpio pinctrl to
    gpio node
  arm64: dts: ti: k3-j721e-beagleboneai64: Move eeprom WP gpio pinctrl
    to eeprom node
  arm64: dts: ti: k3-j721e-beagleboneai64: Fixup reference to phandles
    array
  arm64: dts: ti: k3-am642-phyboard-electra-rdk: Fixup reference to
    phandles array
  arm64: dts: ti: k3-j7200-som/common-proc-board: Fixup reference to
    phandles array
  arm64: dts: ti: k3-j721s2-common-proc-board: Fixup reference to
    phandles array
  arm64: dts: ti: k3-am625-sk: Fixup reference to phandles array
  arm64: dts: ti: k3-am64-evm: Fixup reference to phandles array
  arm64: dts: ti: k3-am64-sk: Fixup reference to phandles array
  arm64: dts: ti: k3-am65-iot*: Fixup reference to phandles array
  arm64: dts: ti: k3-am654-base-board: Fixup reference to phandles array
  arm64: dts: ti: k3-am68-sk-base-board: Fixup reference to phandles
    array

 arch/arm64/boot/dts/ti/k3-am625-sk.dts        |  3 +-
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       | 11 +++---
 .../dts/ti/k3-am642-phyboard-electra-rdk.dts  |  2 +-
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        | 11 +++---
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 17 +++++----
 .../arm64/boot/dts/ti/k3-am654-base-board.dts |  4 +--
 .../dts/ti/k3-am6548-iot2050-advanced-m2.dts  | 18 +++++-----
 .../boot/dts/ti/k3-am68-sk-base-board.dts     |  2 +-
 .../dts/ti/k3-j7200-common-proc-board.dts     |  2 +-
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   |  8 ++---
 .../boot/dts/ti/k3-j721e-beagleboneai64.dts   | 36 +++++++++++--------
 .../dts/ti/k3-j721e-common-proc-board.dts     |  4 +--
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 20 +++++------
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi   | 18 +++++-----
 .../dts/ti/k3-j721s2-common-proc-board.dts    |  2 +-
 15 files changed, 80 insertions(+), 78 deletions(-)

-- 
2.40.0

