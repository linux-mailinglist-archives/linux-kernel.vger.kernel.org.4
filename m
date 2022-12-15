Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC3F64DF63
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiLORKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiLORKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:10:05 -0500
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Dec 2022 09:09:36 PST
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E1B2ED53
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:09:36 -0800 (PST)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTPS id ABE2C5203A6;
        Thu, 15 Dec 2022 18:04:11 +0100 (CET)
Received: from vmlxhi-182.adit-jv.com (10.72.92.141) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.16; Thu, 15 Dec
 2022 18:04:11 +0100
From:   Michael Rodin <mrodin@de.adit-jv.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     Michael Rodin <mrodin@de.adit-jv.com>, <michael@rodin.online>,
        <erosca@de.adit-jv.com>, <laurent.pinchart@ideasonboard.com>
Subject: [PATCH] drm: override detected status for connectors which are forced on
Date:   Thu, 15 Dec 2022 18:03:59 +0100
Message-ID: <20221215170359.92422-1-mrodin@de.adit-jv.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107123657.24vbgep3jqeklb2s@houat>
References: <20221107123657.24vbgep3jqeklb2s@houat>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.72.92.141]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The detected status of a connector should be ignored when a connector is
forced as hinted in the commit d50ba256b5f1 ("drm/kms: start
adding command line interface using fb."). One negative side effect of
not ignoring this is observed on the RCar3 SoCs which use the dw-hdmi
driver. It continues executing drm_helper_hpd_irq_event even if its
connector is forced to ON. As consequence drm_helper_hpd_irq_event calls
"detect" so the connector status is updated to "disconnected":

[  420.201527] [drm:drm_helper_hpd_irq_event] [CONNECTOR:76:HDMI-A-1] status updated from connected to disconnected

This status is corrected by drm_helper_probe_single_connector_modes shortly
after this because this function checks if a connector is forced:

[  420.218703] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:76:HDMI-A-1] status updated from disconnected to connected

To avoid similar issues this commit adapts functions which call "detect"
so they check additionally if a connector is forced and override the status
returned by "detect".

Fixes: 816da85a0990 ("drm: handle HPD and polled connectors separately")
Signed-off-by: Michael Rodin <mrodin@de.adit-jv.com>
---
 drivers/gpu/drm/drm_probe_helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index bcd9611dabfd..0a3b8223c87a 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -304,6 +304,12 @@ drm_helper_probe_detect_ctx(struct drm_connector *connector, bool force)
 	if (WARN_ON(ret < 0))
 		ret = connector_status_unknown;
 
+	if (connector->force == DRM_FORCE_ON ||
+	    connector->force == DRM_FORCE_ON_DIGITAL)
+		ret = connector_status_connected;
+	else if (connector->force == DRM_FORCE_OFF)
+		ret = connector_status_disconnected;
+
 	if (ret != connector->status)
 		connector->epoch_counter += 1;
 
@@ -346,6 +352,12 @@ drm_helper_probe_detect(struct drm_connector *connector,
 	else
 		ret = connector_status_connected;
 
+	if (connector->force == DRM_FORCE_ON ||
+	    connector->force == DRM_FORCE_ON_DIGITAL)
+		ret = connector_status_connected;
+	else if (connector->force == DRM_FORCE_OFF)
+		ret = connector_status_disconnected;
+
 	if (ret != connector->status)
 		connector->epoch_counter += 1;
 
-- 
2.25.1

