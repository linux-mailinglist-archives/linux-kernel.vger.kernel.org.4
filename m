Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3046FC2D3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbjEIJby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbjEIJbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:31:47 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C99E72B
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:31:22 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3499UkDp030787;
        Tue, 9 May 2023 04:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683624646;
        bh=QxtvhK8W40hctV3hPFsZ3fKHSmpeqUJ/FdzCKSSQfhY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=L2+LejUXXrh49fmEqLxmNz1nQDCXu36jSxGjroeTUEpS/lFn2vHCfYSWecKya9f15
         WQEESh/hyY8eed5X17zDXwY7SGK4tLdC3YRU3KuhDPdQDUr6ieooFU/Q8+BrmN8ijz
         yS0uyweWUu4RSN1+SK9H1aEupTWmbbFJzp9xf+yI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3499UkII111946
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 May 2023 04:30:46 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 May 2023 04:30:46 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 May 2023 04:30:46 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3499UjhW100387;
        Tue, 9 May 2023 04:30:45 -0500
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
Subject: [PATCH v6 6/8] drm/bridge: sii902x: Set input_bus_flags in atomic_check
Date:   Tue, 9 May 2023 15:00:34 +0530
Message-ID: <20230509093036.3303-7-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509093036.3303-1-a-bhatia1@ti.com>
References: <20230509093036.3303-1-a-bhatia1@ti.com>
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

input_bus_flags are specified in drm_bridge_timings (legacy) as well
as drm_bridge_state->input_bus_cfg.flags

The flags from the timings will be deprecated. Bridges are supposed
to validate and set the bridge state flags from atomic_check.

Implement atomic_check hook for the same.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 drivers/gpu/drm/bridge/sii902x.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 662b6cb4aa62..4d1f10532fa6 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -495,6 +495,20 @@ static u32 *sii902x_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 	return input_fmts;
 }
 
+static int sii902x_bridge_atomic_check(struct drm_bridge *bridge,
+				       struct drm_bridge_state *bridge_state,
+				       struct drm_crtc_state *crtc_state,
+				       struct drm_connector_state *conn_state)
+{
+	/*
+	 * There might be flags negotiation supported in future but
+	 * set the bus flags in atomic_check statically for now.
+	 */
+	bridge_state->input_bus_cfg.flags = bridge->timings->input_bus_flags;
+
+	return 0;
+}
+
 static const struct drm_bridge_funcs sii902x_bridge_funcs = {
 	.attach = sii902x_bridge_attach,
 	.mode_set = sii902x_bridge_mode_set,
@@ -506,6 +520,7 @@ static const struct drm_bridge_funcs sii902x_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_get_input_bus_fmts = sii902x_bridge_atomic_get_input_bus_fmts,
+	.atomic_check = sii902x_bridge_atomic_check,
 };
 
 static int sii902x_mute(struct sii902x *sii902x, bool mute)
-- 
2.40.1

