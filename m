Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A156AE62A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjCGQR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjCGQRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:17:44 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AFA85B27;
        Tue,  7 Mar 2023 08:17:38 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 327GHFD6085462;
        Tue, 7 Mar 2023 10:17:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678205836;
        bh=TIz0wj83tGtFyVuB+1Uhg4HM0KaXiat40rbW5+4Mhnk=;
        h=From:To:CC:Subject:Date;
        b=CJAcvncaQnOpYLF1FSGwLlnLMrrk+2fatrnGtQUesQjn+tP5G+8kIuvaNB8PrIO5B
         xoPyLvu2vM3n7MkKnmk0F093VKpS3VlTvOmtt1uybKLx4b3xHeEK3y7LcHQH2X1jUC
         cTay6f2bzR200AuiX61/Kr+YNtuJ3R7Idp/aKYco=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 327GHFfr008390
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Mar 2023 10:17:15 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 7
 Mar 2023 10:17:15 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 7 Mar 2023 10:17:15 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 327GHFEu003079;
        Tue, 7 Mar 2023 10:17:15 -0600
From:   Andrew Davis <afd@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v4 0/3] AM57x EVM Device Tree Overlays
Date:   Tue, 7 Mar 2023 10:17:12 -0600
Message-ID: <20230307161715.15209-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hello all,

These are a set of uncontroversial (hopefully) DT Overlays to support the
TI AM57x EVM and displays for AM57x IDKs. More complex cases are staged
and ready to follow, but wanted to test the water with these first.

For some reason dtbs_check does not get run on overlays, this
will need further investigation to fix in kbuild. For now I ran
it through manually but am not 100% sure it actually checked it,
so double checks here very welcome.

Thanks,
Andrew

Changes from v3:
 - Rebased on v6.3-rc1

Changes from v2:
 - Rebased on v6.2-rc5

Changes from v1:
 - Made touchscreen node name generic
 - Used proper interrupt flags

Andrew Davis (3):
  ARM: dts: ti: Add AM57xx GP EVM board support
  ARM: dts: ti: Add AM57xx GP EVM Rev A3 board support
  ARM: dts: am57xx-idk: Add IDK displays and touchscreens

 arch/arm/boot/dts/Makefile                    |   8 ++
 arch/arm/boot/dts/am571x-idk-touchscreen.dtso |  32 +++++
 arch/arm/boot/dts/am572x-idk-touchscreen.dtso |  32 +++++
 arch/arm/boot/dts/am57xx-evm.dtso             | 127 ++++++++++++++++++
 .../boot/dts/am57xx-idk-lcd-osd101t2045.dtso  |  63 +++++++++
 .../boot/dts/am57xx-idk-lcd-osd101t2587.dtso  |  66 +++++++++
 6 files changed, 328 insertions(+)
 create mode 100644 arch/arm/boot/dts/am571x-idk-touchscreen.dtso
 create mode 100644 arch/arm/boot/dts/am572x-idk-touchscreen.dtso
 create mode 100644 arch/arm/boot/dts/am57xx-evm.dtso
 create mode 100644 arch/arm/boot/dts/am57xx-idk-lcd-osd101t2045.dtso
 create mode 100644 arch/arm/boot/dts/am57xx-idk-lcd-osd101t2587.dtso

-- 
2.39.2

