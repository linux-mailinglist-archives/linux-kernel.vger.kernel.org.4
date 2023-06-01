Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC10771A297
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbjFAP0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjFAP0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:26:50 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D31113D;
        Thu,  1 Jun 2023 08:26:47 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 351FQdr3075761;
        Thu, 1 Jun 2023 10:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685633199;
        bh=XZfDJQify0P1w8TilzOki4hAM1x2B/98Xn6r8YVtPXA=;
        h=From:To:CC:Subject:Date;
        b=hl/EN9mliiGcFO7mxLzT/pe+3jEr4oxCyiHvBmmjhuFR8AC+zrYDm1QYEjHLbbaI7
         z3gbVBlpUHFIPrlOr2TlWS+97v09FxJCCOQnEwM9G8Pt1MfpmNO37y+1ncFNDyhu2M
         ir4+aukZLxFh8r3NKUJ1nWu9UXiiuPY+PF3bl2ug=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 351FQda2038106
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Jun 2023 10:26:39 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Jun 2023 10:26:39 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Jun 2023 10:26:39 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 351FQdk9123521;
        Thu, 1 Jun 2023 10:26:39 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 00/12] arm64: dts: ti: Fix up references to phandles
Date:   Thu, 1 Jun 2023 10:26:24 -0500
Message-ID: <20230601152636.858553-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Nishanth Menon (12):
  arm64: dts: ti: k3-j721e-sk: Fixup reference to phandles array
  arm64: dts: ti: k3-j721e-som-p0/common-proc-board: Fixup reference to
    phandles array
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

 arch/arm64/boot/dts/ti/k3-am625-sk.dts        |  4 +--
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       | 12 ++++----
 .../dts/ti/k3-am642-phyboard-electra-rdk.dts  |  2 +-
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        | 12 ++++----
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 17 +++++------
 .../arm64/boot/dts/ti/k3-am654-base-board.dts |  4 +--
 .../dts/ti/k3-am6548-iot2050-advanced-m2.dts  | 18 +++++-------
 .../boot/dts/ti/k3-am68-sk-base-board.dts     |  2 +-
 .../dts/ti/k3-j7200-common-proc-board.dts     |  2 +-
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   |  8 ++---
 .../boot/dts/ti/k3-j721e-beagleboneai64.dts   | 29 ++++++++++---------
 .../dts/ti/k3-j721e-common-proc-board.dts     |  4 +--
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 20 ++++++-------
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi   | 18 ++++++------
 .../dts/ti/k3-j721s2-common-proc-board.dts    |  2 +-
 15 files changed, 76 insertions(+), 78 deletions(-)

-- 
2.40.0

