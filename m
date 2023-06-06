Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA583723B50
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbjFFIWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236403AbjFFIWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:22:18 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6474E62
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:22:13 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3568Lj5h013059;
        Tue, 6 Jun 2023 03:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686039705;
        bh=Kl7IYcWHDhOXEbtjKsmUMDfDTwInFa3veP2B2cudDHM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Zi0niMUGGsiLmMrMcGKT0SJj9txsJItgUXsRIQyMH6rFwtQX6GgplPu4q6y3o0ECo
         vM12K3ZsMySVT7MJaBfc2zuqFoX18C/bmEjeFoLLK4MbFlld7U93bJYjaL9yXfchtA
         iasEn1nuqtsh6b57jM7jKzQ3N7oMGAvaEwljALKM=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3568Ljr3012375
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 03:21:45 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 03:21:44 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 03:21:44 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3568LiFS019490;
        Tue, 6 Jun 2023 03:21:44 -0500
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
Subject: [PATCH v7 1/8] drm/bridge: tfp410: Support format negotiation hooks
Date:   Tue, 6 Jun 2023 13:51:35 +0530
Message-ID: <20230606082142.23760-2-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606082142.23760-1-a-bhatia1@ti.com>
References: <20230606082142.23760-1-a-bhatia1@ti.com>
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

From: Nikhil Devshatwar <nikhil.nd@ti.com>

With new connector model, tfp410 will not create the connector and
SoC driver will rely on format negotiation to setup the encoder format.

Support format negotiations hooks in the drm_bridge_funcs.
Use helper functions for state management.

Input format is the one selected by the bridge from DT properties.

Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>
[a-bhatia1: Removed output fmt condition check]
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---

Notes:
    changes from v1:
    * Use only MEDIA_BUS_FMT_FIXED for output

    changes from V5:
    * Drop the output format check condition because the output
      format for HDMI bridges should be RGB888_1X24 and not FIXED.
      Hence, also drop Tomi Valkeinen's and Laurent Pinchart's R-b
      tags.

 drivers/gpu/drm/bridge/ti-tfp410.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index ab63225cd635..7dacc7e03eee 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -206,12 +206,38 @@ static enum drm_mode_status tfp410_mode_valid(struct drm_bridge *bridge,
 	return MODE_OK;
 }
 
+static u32 *tfp410_get_input_bus_fmts(struct drm_bridge *bridge,
+				      struct drm_bridge_state *bridge_state,
+				      struct drm_crtc_state *crtc_state,
+				      struct drm_connector_state *conn_state,
+				      u32 output_fmt,
+				      unsigned int *num_input_fmts)
+{
+	struct tfp410 *dvi = drm_bridge_to_tfp410(bridge);
+	u32 *input_fmts;
+
+	*num_input_fmts = 0;
+
+	input_fmts = kzalloc(sizeof(*input_fmts), GFP_KERNEL);
+	if (!input_fmts)
+		return NULL;
+
+	*num_input_fmts = 1;
+	input_fmts[0] = dvi->bus_format;
+
+	return input_fmts;
+}
+
 static const struct drm_bridge_funcs tfp410_bridge_funcs = {
 	.attach		= tfp410_attach,
 	.detach		= tfp410_detach,
 	.enable		= tfp410_enable,
 	.disable	= tfp410_disable,
 	.mode_valid	= tfp410_mode_valid,
+	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_get_input_bus_fmts = tfp410_get_input_bus_fmts,
 };
 
 static const struct drm_bridge_timings tfp410_default_timings = {
-- 
2.40.1

