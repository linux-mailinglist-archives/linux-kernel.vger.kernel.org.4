Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3216C73345B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345947AbjFPPJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345804AbjFPPJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:09:33 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190084208;
        Fri, 16 Jun 2023 08:09:12 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35GF91oc005267;
        Fri, 16 Jun 2023 10:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686928141;
        bh=LceLaKBNi5WxPZRer//yhHpngvhHGpG7GcT+OXkw6EQ=;
        h=From:To:CC:Subject:Date;
        b=EmBXhzHcTv9Bvahdln5pbEuKfD8xjUqFsDpimTPTTIq4E3E/wxSij+RGZ7teotXWJ
         OeHhQMvTphKVpzaLL+2N0bDUHbUlCXDKYC+Nz08v3O/3q761DEPfF1UpqWiYApxURx
         +dmCIxRteCZOyEaKtdnndEiL4A1dywaTmQ5LieTQ=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35GF91J1123826
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Jun 2023 10:09:01 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 Jun 2023 10:09:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 Jun 2023 10:09:01 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35GF9024091272;
        Fri, 16 Jun 2023 10:09:01 -0500
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
Subject: [PATCH v9 0/2] Add DSS support for AM625 SoC
Date:   Fri, 16 Jun 2023 20:38:58 +0530
Message-ID: <20230616150900.6617-1-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

I have tested these patches on AM625 SK-EVM and AM625 based Beagle Play.
To test this series on AM625 based platforms, basic display support
patches (for driver + devicetree) can be found in the
"next_am62-base_support-V2" branch on my github fork[2].

[1]: V3: https://patchwork.freedesktop.org/series/105373/
[2]: https://github.com/aradhya07/linux-ab/tree/next_am62-base_support-V2

Previous versions:
- V8: https://patchwork.freedesktop.org/series/119088/
- V7: https://patchwork.freedesktop.org/series/113328/
- V6: https://patchwork.freedesktop.org/series/111106/
- V5: https://patchwork.freedesktop.org/series/109194/

Changelog:
V9:
  - Edit the commit message for Patch 2/2.
  - Add Krzysztof Kozlowski's and Tomi Valkeinen's tags.

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

