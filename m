Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7D27017AB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 16:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239167AbjEMOR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 10:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjEMORZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 10:17:25 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED661BF9;
        Sat, 13 May 2023 07:17:23 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34DEHDTc092956;
        Sat, 13 May 2023 09:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683987433;
        bh=iCdVBAVFivAQfYQiaNPekIvg6+i7v2YxN0OvWHDQxys=;
        h=From:To:CC:Subject:Date;
        b=PbgjGckzHcQmT+tFGAcZNlTLLngU9oixr5vgv3Ouppn2nXKgMCSntwKSDwJ2sdUiK
         xCk1W9XsuiUvv2lwDhvMG2Iv3jYFcrxk3LTzmbv+R5iOJdIxoz8A3G5JO9DARRDhFj
         SgQh7aZG6qxYsxNEEhMGlZZjWQEHXDMHGgxLdTVw=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34DEHDwK128619
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 13 May 2023 09:17:13 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 13
 May 2023 09:17:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 13 May 2023 09:17:13 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34DEHClc047382;
        Sat, 13 May 2023 09:17:13 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <conor+dt@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>
CC:     <vaishnav.a@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
Subject: [PATCH v2 0/6] arm64: dts: ti: Describe flash partitions
Date:   Sat, 13 May 2023 19:47:06 +0530
Message-ID: <20230513141712.27346-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
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

This series adds flash partition description through DT, currently
the flash partitions for most TI ARM64 platforms is described through the
mtdparts commandline parameter passed from bootloader, this requires
maintenance of the partition information in a mtdparts string which is
error prone.

Once the flash partitions are described through DT, the support for
mtdparts can be removed for these platforms from u-boot also.

V1->V2:
 * Add partition information for all K3 platforms.
 * Combine patches per platform.

Vaishnav Achath (6):
  arm64: dts: ti: k3-j721e-som: Describe OSPI/QSPI flash partition info
  arm64: dts: ti: k3-j721e-sk: Describe OSPI flash partition info
  arm64: dts: ti: k3-j7200-som: Describe OSPI and Hyperflash partition
    info
  arm64: dts: ti: k3-am654-baseboard: Describe OSPI flash partition info
  arm64: dts: ti: k3-am642-sk/evm: Describe OSPI flash partition info
  arm64: dts: ti: k3-am64-phycore-som: Describe OSPI flash partition
    info

 .../boot/dts/ti/k3-am64-phycore-som.dtsi      | 41 +++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       | 41 +++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        | 41 +++++++++++
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 46 ++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   | 72 +++++++++++++++++++
 .../dts/ti/k3-j721e-common-proc-board.dts     | 46 ++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 46 ++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi   | 46 ++++++++++++
 8 files changed, 379 insertions(+)

-- 
2.17.1

