Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC00F6D7F57
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbjDEOZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238113AbjDEOZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:25:23 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953E459EC;
        Wed,  5 Apr 2023 07:25:13 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 335EOg8U059430;
        Wed, 5 Apr 2023 09:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680704682;
        bh=2GVvLPXBxCQGXMB3CvvaO2iHJZB4fTMWkS8HlWuLcC4=;
        h=From:To:CC:Subject:Date;
        b=WhtrtJLVnPdfHhM3bDUboFsDseL1gnyUF77Z9z0K6c1WeXcCAQXfOavPka8YtSf6f
         EHMP1qcuIxOZnyfutO9RauCu4xzaLVar9CSYJP2BiMuOdjMnxD2NtW8VPzsFecA197
         D3ERgm9Y65lyuKDHv2twAGNxYGdZpKCaq0nNjiLQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 335EOgr9026283
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Apr 2023 09:24:42 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 5
 Apr 2023 09:24:41 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 5 Apr 2023 09:24:42 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 335EOeDY068562;
        Wed, 5 Apr 2023 09:24:41 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
        <rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <sam@ravnborg.org>,
        <jani.nikula@intel.com>, <tzimmermann@suse.de>,
        <javierm@redhat.com>, <ville.syrjala@linux.intel.com>,
        <r-ravikumar@ti.com>, <lyude@redhat.com>,
        <alexander.deucher@amd.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <a-bhatia1@ti.com>,
        <tomi.valkeinen@ideasonboard.com>, <j-choudhary@ti.com>
Subject: [PATCH v2 0/2] "no-hpd" support in CDNS DP bridge driver
Date:   Wed, 5 Apr 2023 19:54:38 +0530
Message-ID: <20230405142440.191939-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In J721s2 EVM, DP0 HPD is not connected to correct HPD pin on SOC
which results in HPD detect as always connnected, so when display
is not connected driver continuously retries to read EDID and DPCD
registers.

To handle such cases add support for no hpd configuration in
cdns-mhdp driver.

DT changes for display in j721s2 will be posted once we have no-hpd
support and multilink DP support[1] merged.

[1]:
<https://lore.kernel.org/all/20230227133104.29788-1-sjakhade@cadence.com/>

Changelog v1->v2:
- edit the commit message for the bindings to clarify why we exactly need
  no-hpd indication for mhdp.

v1 patch-link:
<https://lore.kernel.org/all/20230316140823.234263-1-j-choudhary@ti.com/>

Rahul T R (2):
  dt-bindings: drm/bridge: Add no-hpd property
  drm: bridge: cdns-mhdp8546: Add support for no-hpd

 .../display/bridge/cdns,mhdp8546.yaml         |  6 +++
 .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 37 ++++++++++++++++---
 .../drm/bridge/cadence/cdns-mhdp8546-core.h   |  1 +
 3 files changed, 39 insertions(+), 5 deletions(-)

-- 
2.25.1

