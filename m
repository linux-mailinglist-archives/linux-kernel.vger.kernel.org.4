Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92AD723B5D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbjFFIWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236373AbjFFIWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:22:19 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565BDE67
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:22:14 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3568Lhb5038618;
        Tue, 6 Jun 2023 03:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686039703;
        bh=36NwgeETF+6wKwG4vZrXnjewoibnFd49vn/bQOk7I10=;
        h=From:To:CC:Subject:Date;
        b=eKb7Nij5m+KiINVRJXwiN63H00/eumZ4WoOyiYprHerpglBdX/8Vao4DrPg7vmcJo
         6ILf3n29d/QUO4MaJBRH1UZ2Fx2dSGVKqXVRiSu7I5QgPAaQ88SBmSbgK37h+/Jihz
         o0jughnz7OXZP5vVm0Pmr84WdAahi1bKRf3Q6TYs=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3568LhFv012273
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 03:21:43 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 03:21:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 03:21:43 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3568LgAH090120;
        Tue, 6 Jun 2023 03:21:43 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Tomi Valkeinen <tomba@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Francesco Dolcini <francesco@dolcini.it>
CC:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v7 0/8] drm/tidss: Use new connector model for tidss
Date:   Tue, 6 Jun 2023 13:51:34 +0530
Message-ID: <20230606082142.23760-1-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.40.1
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

Hi all,

I have picked up this long standing series from Nikhil Devshatwar[1].

This series moves the tidss to using new connectoe model, where the SoC
driver (tidss) creates the connector and all the bridges are attached
with the flag DRM_BRIDGE_ATTACH_NO_CONNECTOR. It also now creates bridge
to support format negotiation and and 'simple' encoder to expose it to
the userspace.

Since the bridges do not create the connector, the bus_format and
bus_flag is set via atomic hooks.

Support format negotiations in the tfp410, sii902x and mhdp-8546 bridge
drivers as a first step before moving the connector model.

These patches were tested on AM625-SK EVM, AM625 SoC based BeaglePlay,
and J721E-SK. Display support for AM625 SoC has not been added upstream
and is a WIP. To test this series on AM625 based platforms, basic
display support patches, (for driver + devicetree), can be found in
the "next_AttachNoConn-v2" branch on my github fork[2].

Thanks,
Aradhya

[1]: https://patchwork.freedesktop.org/series/82765/#rev5
[2]: https://github.com/aradhya07/linux-ab/tree/next_AttachNoConn-v2

Change Log:
V6 -> V7
  - Rebase and cosmetic changes.
  - Drop the output format check condition for mhdp8546 and hence,
    drop Tomi Valkeinen's R-b tag.
  - Added tags wherever suggested.

V5 -> V6
  - Rebase and cosmetic changes
  - Dropped the output format check condition for tfp410 and hence,
    dropped Tomi Valkeinen's and Laurent Pinchart's R-b tags.
  - Based on Boris Brezillon's comments: dropped patches 5 and 6 from
    the series and instead created a single patch that,
      1. Creates tidss bridge for format negotiation.
      2. Creates 'simple' encoder for userspace exposure.
      3. Creates a tidss connector.
      4. Attaches the next-bridge to encoder with the
         DRM_BRIDGE_ATTACH_NO_CONNECTOR flag.
  - Add format negotiation support for sii902x driver.

Previous versions:
V1 to V6: https://patchwork.freedesktop.org/series/82765/

Aradhya Bhatia (3):
  drm/bridge: sii902x: Support format negotiation hooks
  drm/bridge: sii902x: Set input_bus_flags in atomic_check
  drm/tidss: Update encoder/bridge chain connect model

Nikhil Devshatwar (5):
  drm/bridge: tfp410: Support format negotiation hooks
  drm/bridge: tfp410: Set input_bus_flags in atomic_check
  drm/bridge: mhdp8546: Add minimal format negotiation
  drm/bridge: mhdp8546: Set input_bus_flags from atomic_check
  drm/bridge: cdns-mhdp8546: Fix the interrupt enable/disable

 .../drm/bridge/cadence/cdns-mhdp8546-core.c   |  77 ++++++----
 .../drm/bridge/cadence/cdns-mhdp8546-core.h   |   2 +-
 .../drm/bridge/cadence/cdns-mhdp8546-j721e.c  |   9 +-
 .../drm/bridge/cadence/cdns-mhdp8546-j721e.h  |   2 +-
 drivers/gpu/drm/bridge/sii902x.c              |  40 +++++
 drivers/gpu/drm/bridge/ti-tfp410.c            |  43 ++++++
 drivers/gpu/drm/tidss/tidss_encoder.c         | 140 +++++++++++-------
 drivers/gpu/drm/tidss/tidss_encoder.h         |   5 +-
 drivers/gpu/drm/tidss/tidss_kms.c             |  12 +-
 9 files changed, 235 insertions(+), 95 deletions(-)

-- 
2.40.1

