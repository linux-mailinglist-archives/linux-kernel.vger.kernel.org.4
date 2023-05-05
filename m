Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CB16F8494
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 16:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjEEOOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 10:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjEEOOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 10:14:21 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE8811556;
        Fri,  5 May 2023 07:14:19 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 345EE97h126078;
        Fri, 5 May 2023 09:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683296049;
        bh=OVIMJEOTw58a5+zeZXdnuWbw6urjw5K0715hy8nuTNk=;
        h=From:To:CC:Subject:Date;
        b=Gg/ye8sl/ga21PKHywDBiTo+sbJTfaTkJ2iugWkorwIlH2mw5OXrp2SqhxlsxXHiI
         zNhech7D0likr9N/voff6F67zjBU/1CAQJPRaDfB7mCO+Sfm57Y50GuUlxJlrav23F
         7ZpEo3aLRKT/+RFDv+BorweqCvu/YIgicPYIXuBo=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 345EE9mm000557
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 May 2023 09:14:09 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 May 2023 09:14:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 May 2023 09:14:08 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 345EE7xb022255;
        Fri, 5 May 2023 09:14:08 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>,
        <vaishnav.a@ti.com>
Subject: [PATCH 0/4] arm64: dts: ti: j721e: Add HyperFlash support
Date:   Fri, 5 May 2023 19:44:03 +0530
Message-ID: <20230505141407.15134-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
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

This series adds hyperflash support for J721E. J721E SoC has HyperBus
and OSPI controller muxed within the FSS subsystem and the J721E SoM
has a 64 MiB S28 OSPI flash and a 64 MiB Hyperflash present which is
muxed externally also.

* Patch 1/4 adds the hyperbus controller nodes and fixes DT compile
warnings.
* Patch 2/4 adds the hyperflash support in the SoM DTS.
* Patch 3 and 4/4 enables the pinmux for external mux that selects
between hyperflash or OSPI NOR flash, this is done for J7200 and 
J721E platforms since it is required in U-Boot and helps keep the
DT in sync.

Patch 1/4 depends on the following patch:
https://lore.kernel.org/all/20230424184810.29453-1-afd@ti.com/

Patch 3 depends on the below fix for pinmux offsets in J7200:
https://lore.kernel.org/all/20230419040007.3022780-2-u-kumar1@ti.com/

Bootlog and basic hyperflash erase-write-read test:
https://gist.github.com/vaishnavachath/be652108f3e360f1e2d41b499df844ef

Thanks and Regards,
Vaishnav

Vaishnav Achath (4):
  arm64: dts: ti: k3-j721e-mcu-wakeup: Add HyperBus node
  arm64: dts: ti: k3-j721e-som-p0: Add HyperFlash node
  arm64: dts: ti: k3-j7200-common-proc-board: Add OSPI/Hyperflash select
    pinmux
  arm64: dts: ti: k3-j721e-common-proc-board: Add OSPI/Hyperflash select
    pinmux

 .../dts/ti/k3-j7200-common-proc-board.dts     | 11 ++++++
 .../dts/ti/k3-j721e-common-proc-board.dts     | 11 ++++++
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 25 +++++++++++--
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi   | 35 +++++++++++++++++++
 4 files changed, 80 insertions(+), 2 deletions(-)

-- 
2.17.1

