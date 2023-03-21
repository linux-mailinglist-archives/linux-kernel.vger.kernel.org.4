Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5D06C2C5C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjCUI3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjCUI2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:28:40 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD85B213B;
        Tue, 21 Mar 2023 01:28:36 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32L8ST7t124064;
        Tue, 21 Mar 2023 03:28:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679387309;
        bh=1I3SwyMmX+Es47TVOOv0S0VnKBcom5OjjGLMlCz+ngU=;
        h=From:To:CC:Subject:Date;
        b=KSi6DGvmwDeT0Dd+3Bq6afVi0CznRu06S0EUWoUJ5MwSK7vUNEks7pXf/uZJSqdHu
         pkFt4LpzN0lwhXb1r1UTKrjyLWGvUh4JTZw6utSEI/QEOXrcdRM8zif2kqp7kC16WY
         GD9lX2Q2ZxBgxRvqb6A1V/OIdcv58Mvd3hiWvy1w=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32L8ST6O045132
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Mar 2023 03:28:29 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 21
 Mar 2023 03:28:28 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 21 Mar 2023 03:28:28 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32L8SRDs083044;
        Tue, 21 Mar 2023 03:28:28 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-keerthy@ti.com>, <u-kumar1@ti.com>, <j-luthra@ti.com>,
        <vaishnav.a@ti.com>
Subject: [PATCH v3 0/4] arm64: dts: ti: j7: Add device-tree nodes for MCSPI
Date:   Tue, 21 Mar 2023 13:58:23 +0530
Message-ID: <20230321082827.14274-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds device tree nodes for Multi Channel Serial Peripheral
Interface (MCSPI) on J721E, J7200, J721S2 and J784S4 platforms. All the
MCSPI instances are disabled by default and can be enabled through overlays
as required, the changes were tested using spidev loopback test for all
instances and the data verified only for main_spi4 which is connected
internally as slave to mcu_spi2 for all existing J7 devices.

V2->V3:
 * Add Keerthy's Reviewed-by.
 * Update commit message to mention internal MCSPI loopback.

V1->V2: 
  * Address Nishanth's feedback, combine main, mcu domain
  MCSPI node addition changes to single commit per SoC.

Vaishnav Achath (4):
  arm64: dts: ti: k3-j721e: Add MCSPI nodes
  arm64: dts: ti: k3-j7200: Add MCSPI nodes
  arm64: dts: ti: k3-j721s2: Add MCSPI nodes
  arm64: dts: ti: k3-j784s4: Add MCSPI nodes

 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 88 +++++++++++++++++++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 33 +++++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 88 +++++++++++++++++++
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 33 +++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 88 +++++++++++++++++++
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 33 +++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 88 +++++++++++++++++++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     | 33 +++++++
 8 files changed, 484 insertions(+)

-- 
2.17.1

