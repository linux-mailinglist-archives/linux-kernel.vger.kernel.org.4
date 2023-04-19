Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CF76E7305
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjDSGRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjDSGR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:17:28 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D4D5249;
        Tue, 18 Apr 2023 23:17:27 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33J6HBju124832;
        Wed, 19 Apr 2023 01:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681885031;
        bh=VGHbi0oJgL1qmQOp3YO+KPZ9VWHxOlwOKogoET5tOWo=;
        h=From:To:CC:Subject:Date;
        b=xFf2xvyfT7KHpvAOu/5NO3grnYDgOBaR3DBd8j7YHALRShTQozu2M3PTB17Pkut+w
         A3LvdWrZb9t83v7mSz7RnOETkw+ktBjyfOowk/SwQ38EdyPwxHVbSoMEg3eXbBKcM0
         OINYgPRV6dCil+88yXaQNvq/9BbwVyO4ngSqTBas=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33J6HBcA125717
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Apr 2023 01:17:11 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 19
 Apr 2023 01:17:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 19 Apr 2023 01:17:11 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33J6HAoJ045391;
        Wed, 19 Apr 2023 01:17:11 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>
CC:     <s-vadapalli@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <a-bhatia1@ti.com>, <j-choudhary@ti.com>
Subject: [PATCH v3 0/5] Add peripherals for J784S4
Date:   Wed, 19 Apr 2023 11:47:05 +0530
Message-ID: <20230419061710.290068-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
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

This series adds support for:
- SERDES, WIZ DT nodes, Serdes lane control mux
- MAIN CPSW2G nodes
- DSS and DisplayPort-0 nodes

This series depends on DMA support patches for J784S4[1] which are
applied to linux-next.

DisplayPort has been tested on local J784S4 EVM. Test log:
<https://gist.github.com/Jayesh2000/b1465fc170cd97db4f0956770fafbc50>

Changelog v3->v2:
- fix dtc warnings for 'scm_conf' and 'serdes_ln_ctrl' nodes
  (Checked all the changes of the series with W=12 option during build)
- added clock-frequency for serdes_refclk along with other EVM changes
  This refclk is being used by all the instances of serdes_wiz which
  are disabled by default. So configuring refclk when the serdes nodes
  are used for the first time is okay.

Changelog v1->v2:
- Moved J784S4 EVM changes together to the last patch
  (Suggested by Andrew)

v2 patch link:
<https://lore.kernel.org/all/20230414151553.339599-1-j-choudhary@ti.com/>

[1]:
<https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=00e34c94987e4fe866f12ad8eac17268c936880c>
<https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=82e6051a48957a89066d15b17bb85d2f662f2bad>
<https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=436b288687176bf4d2c1cd25b86173e5a1649a60>


Rahul T R (2):
  arm64: dts: ti: k3-j784s4-main: Add DSS and DP-bridge node
  arm64: dts: ti: k3-j784s4-evm: Enable DisplayPort-0

Siddharth Vadapalli (3):
  arm64: dts: ti: k3-j784s4-main: Add system controller and SERDES lane
    mux
  arm64: dts: ti: k3-j784s4: Add Main CPSW2G node
  arm64: dts: ti: k3-j784s4: Add WIZ and SERDES PHY nodes

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   | 164 ++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 338 +++++++++++++++++++++
 2 files changed, 502 insertions(+)

-- 
2.25.1

