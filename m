Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57541728541
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbjFHQjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbjFHQjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:39:00 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B48530FF;
        Thu,  8 Jun 2023 09:38:34 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 358GbZKv030694;
        Thu, 8 Jun 2023 11:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686242255;
        bh=VbHCQQyX0Q4Isb3AVJlABulcKhJpikMUrdGhUaatJss=;
        h=From:To:CC:Subject:Date;
        b=qB89RuMgm4OShI/YOcKl+3WeObEE+1MJv2bWueXOVo/ooguvRoR5aV5swUYNd+/OU
         NaUrKtQesqhIUEAlcBTyrxX4uJtz6tKRl6kM2EiY/eXyPqhmkMtZyNtD5Qe5J/fj05
         mpAuP7KAmHUn5ajmGaoCZUe2L254dXGBuwInbl10=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 358GbZJq024218
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Jun 2023 11:37:35 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Jun 2023 11:37:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Jun 2023 11:37:35 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 358GbYQ7061224;
        Thu, 8 Jun 2023 11:37:34 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Tomi Valkeinen <tomba@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v8 0/2] Add DSS support for AM625 SoC
Date:   Thu, 8 Jun 2023 22:07:32 +0530
Message-ID: <20230608163734.2578-1-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.40.1
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

This patch series adds a new compatible for the Display SubSystem (DSS)
controller on TI's AM625 SoC. It further adds the required support for
the same in the tidss driver.

The AM625-DSS is a newer version of the DSS from the AM65X version with
the major change being the addition of another OLDI TX. With the help of
2 OLDI TXes, the AM625 DSS can support dual-linked OLDI displays with a
resolution of up-to 2K or WUXGA (1920x1200@60fps) at half the OLDI clock
frequency or even cloned video outputs on each of the TXes.

This patch series acts as a continuation of the patches posted in v3[1].
The OLDI support patches combined from v5 onwards are now separated
again. The OLDI support will be added subsequently with a separte patch
series.

I have dropped Krzysztof Kozlowski's and Rahul T R's R-b tags from patch
1/2 considering the changes involved in the binding.

I have tested these patches on AM625 SK-EVM and AM625 based Beagle Play.
To test this series on AM625 based platforms, basic display support
patches, (for driver + devicetree) can be found in the
"next_am62-base_support" branch on my github fork[2].

[1]: V3: https://patchwork.freedesktop.org/series/105373/
[2]: https://github.com/aradhya07/linux-ab/tree/next_am62-base_support

Previous versions:

- V7: https://patchwork.freedesktop.org/series/113328/
- V6: https://patchwork.freedesktop.org/series/111106/
- V5: https://patchwork.freedesktop.org/series/109194/

Changelog:
V8:
  - Rebase for current merge window.
  - Drop all the OLDI support patches.
  - Update the binding to remove the 2nd OLDI port instances.
  - Drop the Reviewed-by tags of Krzysztof Kozlowski and Rahul T R
    because of the changes.

V7:
  - Rebase to current linux-next.
  - Address Tomi Valkeinen's comments.
    1. Separate the DSS VP and output port coupling.
       v6 introduced 'output_port_bus_type' in addition to 'vp_bus_type'
       but having both of the variables was redundant. Hence, in v7
       the 'output_port_bus_type' essentially replaces 'vp_bus_type'.
    2. Break Patch v6 2/5 into 2 separate patches (v7 1/6 and v7 3/6).
    3. Change in name and addition of OLDI mode macros.
    4. Other minor changes.

V6:
  - Rebase for current merge window.
  - Add 'allOf:' condition in the DT binding.
  - Address Tomi Valkeinen's comments.
    1. Combine DT binding patches for new compatible and 3rd DSS port.
    2. Further separate DSS VPs and output ports.
    3. Separate OLDI mode discovery logic from the panel/bridge
       discovery (which allowed support for OLDI bridges as well.)
    4. Organize OLDI IO control register macros platform wise.

V5:
  - Rebase for current merge window.
  - Add max DT ports in DSS features.
  - Combine the OLDI support series.

(Changes from OLDI support series v1)
  - Address Tomi Valkeinen's comments.
    1. Update the OLDI link detection approach.
    2. Add port #3 for 2nd OLDI TX.
    3. Configure 2 panel-bridges for cloned panels.
    4. Drop the OLDI clock set patch.
    5. Drop rgb565-to-888 patch.

V3:
  - Change yaml enum in alphabetical order.
  - Correct a typo.

V2:
  - Remove redundant register array.

Aradhya Bhatia (2):
  dt-bindings: display: ti,am65x-dss: Add am625 dss compatible
  drm/tidss: Add support for AM625 DSS

 .../bindings/display/ti/ti,am65x-dss.yaml     | 18 ++++--
 drivers/gpu/drm/tidss/tidss_dispc.c           | 57 ++++++++++++++++++-
 drivers/gpu/drm/tidss/tidss_dispc.h           |  2 +
 drivers/gpu/drm/tidss/tidss_drv.c             |  1 +
 4 files changed, 71 insertions(+), 7 deletions(-)

-- 
2.40.1

