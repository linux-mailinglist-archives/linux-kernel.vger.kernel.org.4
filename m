Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CED86944FC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjBMMAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjBMMAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:00:07 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C3F18A9C;
        Mon, 13 Feb 2023 04:00:04 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31DBxtui124222;
        Mon, 13 Feb 2023 05:59:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1676289595;
        bh=R4rTrEgdp3H52NSenfg8n8fI6UiYoEKyF15EQe3mI6c=;
        h=From:To:CC:Subject:Date;
        b=NJtduee+6PoexX/Brw7GfNAhnu721isDdjE4IKTn5QibPhBkwRGDsnPoTPRW1y+x3
         p6edrjd9/2w1Rv4xUTiNeofd2pGltLFRjGSUdC9yGi7a+YaauGFAzmE94ih5kInBoN
         P2e4FIUZlNQg7ordIGLJRI5PnQ2pa3YxrVx3Wzfs=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31DBxt1j037591
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Feb 2023 05:59:55 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 13
 Feb 2023 05:59:55 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 13 Feb 2023 05:59:55 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31DBxsCj015516;
        Mon, 13 Feb 2023 05:59:54 -0600
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Tomi Valkeinen <tomba@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Linux Clock List <linux-clk@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v2 0/2] Introduce support for AM62 DSS VP0 Divider Clock
Date:   Mon, 13 Feb 2023 17:29:52 +0530
Message-ID: <20230213115954.553-1-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Introduce clock divider driver and bindings for AM62 DSS (VP0).

The OLDI transmitters in AM62 SoC, require a serial clock, which is 7
times the pixel clock required by the Video Port 0 (VP0) of the DSS.

The clock architecture is such that the relevant PLL is connected to the
DSS VP0 through a clock divider (by-7). The DSS requests the pixel clock
to the clock divider, which forwards the request to parent PLL. The PLL,
in turn, is supposed to generate a 7x pixel-clock (serial clock) to feed
the OLDI transmitters directly, and the DSS through the said divider.
This ensures that both the OLDI TXes and DSS get their required clocks.

Change Log:
v2:
  - Create separate devicetree binding and driver for the clock.
    The previous version of the series added the compatible inside the
    fixed-factor clock driver, and explicitly set the flag
    CLK_SET_RATE_PARENT to have the set clock rate request propagate to
    the parent PLL. The driver is referenced from the fixed-factor clock
    driver and modified specifically to support AM62 DSS requirements.

Links:
V1: https://lore.kernel.org/all/20221226095745.19757-1-a-bhatia1@ti.com/

Aradhya Bhatia (2):
  dt-bindings: clock: Add binding documentation for TI AM62 DSS Clock
  clk: keystone: Add support AM62 DSS clock divider

 .../clock/ti,am62-dss-vp0-div-clk.yaml        |  44 +++++
 drivers/clk/keystone/Kconfig                  |   9 +
 drivers/clk/keystone/Makefile                 |   1 +
 drivers/clk/keystone/clk-am62-dss.c           | 164 ++++++++++++++++++
 4 files changed, 218 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti,am62-dss-vp0-div-clk.yaml
 create mode 100644 drivers/clk/keystone/clk-am62-dss.c

-- 
2.39.1

