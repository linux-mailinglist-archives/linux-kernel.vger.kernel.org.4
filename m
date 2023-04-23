Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3796EC04A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjDWOQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjDWOPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:15:36 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE2F3C3A
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cUSOYLuQjdiS9Ja6dEexWHo4C4Y5Ft7LRX3bN1lCnPA=; b=Hb2Dt82V6RFUBwoDi4OOl2AXD6
        W25R+uc2mmPiqDDZdhT/qjdm9B2ExG7lHDc6ZSDHhEriZSu1Hsdenn/F1dLW+OC9hKfOa3L5l2pRD
        EzRoTJFneYRBuQu7Ltjmch4nxIhf7CK45/fBxGFI6GZTcrxJdVfAu9hiTth+25f4hinBoq+ezULAL
        1LdBNRSzQtdELh+smst/0SliQMRLRYFhkmxtInCi8O0dj8vuhiI8VFXjszCZdBRxp7RolpA3g56UY
        9t8/UqwevdkKIyOWXG1A4Z8kyizgGLVLeB8gvORC8dxiI3jCdDDrU02Zntxg7V2zZL9pK20gzt2gM
        BdVYLpOA==;
Received: from nat-wifi.fi.muni.cz ([147.251.43.9] helo=killbill.fi.muni.cz)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pqaTb-00ANVs-JK; Sun, 23 Apr 2023 16:14:03 +0200
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
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 37/40] drm/amd/display: handle empty LUTs in __set_input_tf
Date:   Sun, 23 Apr 2023 13:10:49 -0100
Message-Id: <20230423141051.702990-38-mwen@igalia.com>
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

From: Joshua Ashton <joshua@froggi.es>

Unlike degamma, blend gamma doesn't support hardcoded curve
(predefined/ROM), but we can use AMD color module to fill blend gamma
parameters when we have non-linear plane gamma TF without plane gamma
LUT. The regular degamma path doesn't hit this.

Signed-off-by: Joshua Ashton <joshua@froggi.es>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index e17141fc8d12..baa7fea9ebae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -349,21 +349,26 @@ static int __set_input_tf(struct dc_transfer_func *func,
 	struct dc_gamma *gamma = NULL;
 	bool res;
 
-	gamma = dc_create_gamma();
-	if (!gamma)
-		return -ENOMEM;
+	if (lut_size) {
+		gamma = dc_create_gamma();
+		if (!gamma)
+			return -ENOMEM;
 
-	gamma->type = GAMMA_CUSTOM;
-	gamma->num_entries = lut_size;
+		gamma->type = GAMMA_CUSTOM;
+		gamma->num_entries = lut_size;
 
-	__drm_lut_to_dc_gamma(lut, gamma, false);
+		__drm_lut_to_dc_gamma(lut, gamma, false);
+	}
 
-	res = mod_color_calculate_degamma_params(NULL, func, gamma, true);
-	dc_gamma_release(&gamma);
+	res = mod_color_calculate_degamma_params(NULL, func, gamma, gamma != NULL);
+
+	if (gamma)
+		dc_gamma_release(&gamma);
 
 	return res ? 0 : -ENOMEM;
 }
 
+
 #ifdef CONFIG_STEAM_DECK
 static enum dc_transfer_func_predefined drm_tf_to_dc_tf(enum drm_transfer_function drm_tf)
 {
-- 
2.39.2

