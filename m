Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDA26EBFFA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjDWOMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjDWOMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:12:32 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE04F1FD6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=61KSS5+ykrC2EpBhN11Qk1hbuXSnyOrLMv+gxM8XJiM=; b=EBlbem39+WObZkXT6cpRxHLypm
        sJSX69u+V+8TBPnkSJlNRH2ttHSacdtg9acvMnz/55ocsu8Koe3dKdyxugqLT+mOC+NnTEXXt1dKz
        RQs6n6CDGQW0lJ4r5DOh133lEtV+qPnPSEb2hr3uCJwGA7ijCsDz4soKbSIEA5RuAU4DiUkw5i0dT
        O/9CYFrOesSGjOPUk+BYFj7ICUN1USFkiHw3SF4VfEQd0TcILVY+Z/HCIPUWv9oiqI9adixNsMslC
        98FsXi0h9xA9AnU7MEcxaBA7ThvHTt0mcpwcSl7oVDiU0IQdpNRCRkou3+Tb8FUuwPUOoU8eSQauZ
        HTuMR28Q==;
Received: from nat-wifi.fi.muni.cz ([147.251.43.9] helo=killbill.fi.muni.cz)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pqaRh-00ANVs-QW; Sun, 23 Apr 2023 16:12:05 +0200
From:   Melissa Wen <mwen@igalia.com>
To:     amd-gfx@lists.freedesktop.org,
        Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        sunpeng.li@amd.com, Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     Joshua Ashton <joshua@froggi.es>,
        Sebastian Wick <sebastian.wick@redhat.com>,
        Xaver Hugl <xaver.hugl@gmail.com>,
        Shashank Sharma <Shashank.Sharma@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        sungjoon.kim@amd.com, Alex Hung <alex.hung@amd.com>,
        Melissa Wen <mwen@igalia.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 04/40] drm/drm_mode_object: increase max objects to accommodate new color props
Date:   Sun, 23 Apr 2023 13:10:16 -0100
Message-Id: <20230423141051.702990-5-mwen@igalia.com>
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

In the next patches we are adding 17 new properties for color
correction:
- CRTC: 3D LUT+size, shaper LUT+size, regamma TF (5)
- Plane: Degamma LUT+size+TF, HDR multiplier, shaper LUT+size+TF, 3D LUT+size, blend
  LUT+size+TF (12)
We still need to detach driver-private counter from DRM/KMS-generic, by
now, increase max objs to 41.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 include/drm/drm_mode_object.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_mode_object.h b/include/drm/drm_mode_object.h
index 912f1e415685..7e4fb7536c6a 100644
--- a/include/drm/drm_mode_object.h
+++ b/include/drm/drm_mode_object.h
@@ -60,7 +60,7 @@ struct drm_mode_object {
 	void (*free_cb)(struct kref *kref);
 };
 
-#define DRM_OBJECT_MAX_PROPERTY 24
+#define DRM_OBJECT_MAX_PROPERTY 47
 /**
  * struct drm_object_properties - property tracking for &drm_mode_object
  */
-- 
2.39.2

