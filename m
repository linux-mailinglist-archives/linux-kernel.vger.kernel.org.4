Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193D16E26A6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjDNPQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjDNPQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:16:21 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CBBC670;
        Fri, 14 Apr 2023 08:16:13 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33EFFsa3106032;
        Fri, 14 Apr 2023 10:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681485354;
        bh=VOH0wtPIqubPCEZl1iYsvlc7kis3klv81GlWG2U6hx0=;
        h=From:To:CC:Subject:Date;
        b=gcGPTlCrJiEz4H8OOf8YfW5H/t6E1X3ppNQTN3uNFOmhWWK3o18ybFGePRUt2GrKy
         XNJD3eR9k/uc29ICzgbIpDmNsr74Yl6TOAtXUDJVbg010pPyAt8fcOF0q0QnxAKPX0
         ELrVeiVz2Crn3fK/0HiidScXxWjNNkX9GirV6+Ww=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33EFFsbB119533
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Apr 2023 10:15:54 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 14
 Apr 2023 10:15:54 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 14 Apr 2023 10:15:54 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33EFFrAQ096128;
        Fri, 14 Apr 2023 10:15:53 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>
CC:     <s-vadapalli@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: [PATCH v2 0/5] Add peripherals for J784S4
Date:   Fri, 14 Apr 2023 20:45:48 +0530
Message-ID: <20230414151553.339599-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
<https://gist.github.com/Jayesh2000/3ba5a45b6e82f0c5c98d2e8fad56cb52>

Changelog v1->v2:
- Moved J784S4 EVM changes together to the last patch
  (Suggested by Andrew[2])

v1 patch link:
<https://lore.kernel.org/all/20230405111412.151192-1-j-choudhary@ti.com/>

[1]:
<https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=00e34c94987e4fe866f12ad8eac17268c936880c>
<https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=82e6051a48957a89066d15b17bb85d2f662f2bad>
<https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=436b288687176bf4d2c1cd25b86173e5a1649a60>

[2]:
<https://lore.kernel.org/all/e38ea0b2-5e51-05d6-50fc-c7ef3d4b8698@ti.com/>


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

