Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80ADF6FC2D4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbjEIJcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbjEIJcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:32:08 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB02100FD
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:31:40 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3499UbRL022662;
        Tue, 9 May 2023 04:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683624637;
        bh=10h0Sa3wyvgTwCRAgmBW5D49q0Vu8XxsUPdYAxgx1dw=;
        h=From:To:CC:Subject:Date;
        b=GHoZFIT2W7tsOnBrEynvJ1kAq0Lxe+SAiRyiav0FBR1/hxk5SlxdqrT4KVBjTUldL
         o1iT8T1xUK5txE+ZCaBPYxjog+TkV5nFxXAiw4VcEaVavhmNcuqy4bOuCp1DG98wsc
         huxiQXSCGlPjpYo1BZaZnFUbg4jvQIwCqExiSYFk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3499UbmZ107090
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 May 2023 04:30:37 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 May 2023 04:30:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 May 2023 04:30:37 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3499UaES020381;
        Tue, 9 May 2023 04:30:36 -0500
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
        Rahul T R <r-ravikumar@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Francesco Dolcini <francesco@dolcini.it>
CC:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v6 0/8] drm/tidss: Use new connector model for tidss
Date:   Tue, 9 May 2023 15:00:28 +0530
Message-ID: <20230509093036.3303-1-a-bhatia1@ti.com>
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
the "next_AttachNoConn" branch on my github fork[2].

Thanks,
Aradhya

[1]: https://patchwork.freedesktop.org/series/82765/#rev5
[2]: https://github.com/aradhya07/linux-ab/tree/next_AttachNoConn

Change Log:
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

Previous series:
V1 to V5: https://patchwork.freedesktop.org/series/82765/

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

 .../drm/bridge/cadence/cdns-mhdp8546-core.c   |  80 ++++++----
 .../drm/bridge/cadence/cdns-mhdp8546-core.h   |   2 +-
 .../drm/bridge/cadence/cdns-mhdp8546-j721e.c  |   9 +-
 .../drm/bridge/cadence/cdns-mhdp8546-j721e.h  |   2 +-
 drivers/gpu/drm/bridge/sii902x.c              |  41 +++++
 drivers/gpu/drm/bridge/ti-tfp410.c            |  42 ++++++
 drivers/gpu/drm/tidss/tidss_encoder.c         | 140 +++++++++++-------
 drivers/gpu/drm/tidss/tidss_encoder.h         |   5 +-
 drivers/gpu/drm/tidss/tidss_kms.c             |  12 +-
 9 files changed, 238 insertions(+), 95 deletions(-)

-- 
2.40.1

