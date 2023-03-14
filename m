Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBEA6B98F4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjCNP00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjCNP0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:26:24 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BADFA90A8;
        Tue, 14 Mar 2023 08:26:21 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32EFQC0s033125;
        Tue, 14 Mar 2023 10:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678807572;
        bh=rCSe3awC47T3cNdH3EF+HwUDzp5NAPmqi6MhcDNsK94=;
        h=From:To:CC:Subject:Date;
        b=htQvNmPc46BB8mi+AiLviv0zOgsa6oPRFi00jeTR34PpUAEpBe10JTvKIjz1vGcaY
         qnN6pyiA0DZ359kGQ5WF+ZRjROcQnlMmCsKxsMPcjQKYeu727MYTxvTShs74u5lizp
         b7uAK2q4jjtWE83ozzlKH9M07u1rfFeHcra4+68g=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32EFQCeI104797
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Mar 2023 10:26:12 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 14
 Mar 2023 10:26:12 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 14 Mar 2023 10:26:12 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32EFQBRu001628;
        Tue, 14 Mar 2023 10:26:12 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <a-nandan@ti.com>,
        <hnagalla@ti.com>, <vaishnav.a@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <j-choudhary@ti.com>
Subject: [PATCH v2 0/2] Add Crypto Support for J784S4 SoC
Date:   Tue, 14 Mar 2023 20:56:09 +0530
Message-ID: <20230314152611.140969-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
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

This series adds the crypto node for sa2ul for j784s4 platform.

First patch adds the device-id for NAVSS without which the probe
for dma-controller fails due to 'ti,sci-dev-id' read failure.
Second patch adds the crypto node.

This series has functional dependency on j784s4 k3_soc_id[1] and
PSIL-thread support[2] but it does not affect the boot.

[1]:
<https://lore.kernel.org/all/20230314085500.10597-1-j-choudhary@ti.com/>

[2]:
<https://lore.kernel.org/all/20230308201513.116638-1-j-choudhary@ti.com/>

For testing the crypto support, crypto extra tests and self tests were
enabled and tcrypt tests were used to verify SHA-1/256/512, AES and DES3
algorithms.

Changelog v1->v2:
- add deviceID for mcu_navss as well and add the 'Fixes:' tag
- retain 'Reviewed-by' tag in both patches from v1:
  <https://lore.kernel.org/all/87v8j3v9fc.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me/>

Jayesh Choudhary (2):
  arm64: dts: ti: k3-j784s4-*: Add 'ti,sci-dev-id' for NAVSS nodes
  arm64: dts: ti: k3-j784s4-main: Enable crypto accelerator

 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 20 +++++++++++++++++++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |  1 +
 2 files changed, 21 insertions(+)

-- 
2.25.1

