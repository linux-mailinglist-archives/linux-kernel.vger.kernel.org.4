Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EC86EC049
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjDWOPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjDWOPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:15:34 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFC73C0A
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4GQm73N05wdyDPvLOueAQrdj1CPYaUCZeKkaAs7VjXY=; b=h2ixzavpfQLRZTKkPcsvUCerpa
        LoWyHwwWnSdmYYg+hC/Hnz4QMtMT7U68Rvz7ux818FUzfSWXCVmsN8eWeKnzaILchgmSYHg2gwph+
        ke043JYgzHR+pr+v5CcOeYqNdOt7qZFyhmctCzqoPOV6hkqIHC7As5ZjpgZ+obUKlh1VhUKyKiRw1
        cI1EU41E+TYX6+B2QSNH7eFjttLv/ar2/wHCjT/hoNPLcnheUAxZp7BcSmRvGuQc/jwdRgoUnrkni
        PdtbyQbeh6ROOvboSKntvevX6ke1BEKqEjBabV0BoivARn+hynJAbfVGHPYXXmlTiYLSqRthR6Dfi
        2ghFpcpA==;
Received: from nat-wifi.fi.muni.cz ([147.251.43.9] helo=killbill.fi.muni.cz)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pqaTL-00ANVs-Dv; Sun, 23 Apr 2023 16:13:47 +0200
From:   Melissa Wen <mwen@igalia.com>
To:     amd-gfx@lists.freedesktop.org,
        Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        sunpeng.li@amd.com, Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     Joshua Ashton <joshua@froggi.es>,
        Sebastian Wick <sebastian.wick@redhat.com>,
        Xaver Hugl <xaver.hugl@gmail.com>,
        Shashank Sharma <Shashank.Sharma@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        sungjoon.kim@amd.com, Alex Hung <alex.hung@amd.com>,
        Melissa Wen <mwen@igalia.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 33/40] drm/amd/display: reject atomic commit if setting both plane and CRTC degamma
Date:   Sun, 23 Apr 2023 13:10:45 -0100
Message-Id: <20230423141051.702990-34-mwen@igalia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230423141051.702990-1-mwen@igalia.com>
References: <20230423141051.702990-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DC only has pre-blending degamma caps (pre-blending/DPP) that is
currently in use for CRTC/post-blending degamma, so that we don't have
HW caps to perform plane and CRTC degamma at the same time. Reject
atomic updates when serspace sets both plane and CRTC degamma
properties.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c   | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 693168cc1d9c..07303c9f3618 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -949,6 +949,17 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 	if (ret != -EINVAL)
 		return ret;
 
+	/* We only have one degamma block available (pre-blending) for the
+	 * whole color correction pipeline, so that we can't actually perform
+	 * plane and CRTC degamma at the same time. Reject atomic updates when
+	 * userspace sets both plane and CRTC degamma properties.
+	 */
+	if (has_crtc_cm_degamma && ret == -EINVAL){
+		drm_dbg_kms(crtc->base.crtc->dev,
+			    "doesn't support plane and CRTC degamma at the same time\n");
+			return -EINVAL;
+	}
+
 	/* As we don't have plane degamma, check if we have CRTC degamma
 	 * waiting for mapping to pre-blending degamma block */
 #endif
-- 
2.39.2

