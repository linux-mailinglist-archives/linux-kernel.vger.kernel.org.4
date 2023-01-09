Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1086628F1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjAIOqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjAIOpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:45:22 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3369338AFB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 06:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=TnpDW0+fbBbPza9wMiMd8HlnPnuskPiG6Rgbq1iBi8g=; b=TWlBIDGPLku7ghz50n9qdn+SRR
        rSsoJ5irFxQwjH15eFYk2IYJNrqpRurnCYXnxw8WGxnaWVqs7UDlgQyYIBvLG24rYFugu5wijcoZv
        D0f6aZZUucwt2K6Z8czdhtetq5QjYHLt51W5IrZuwDpY0zWIa8YnszsUXY/aF8qtWcguCFcJ+L14a
        X89hvd3/m7fir50TxzHQv1WUOJfvo4JiUrZMeQt9uNvQf6xeUrKn9r+fuIGn43F4m6BQRYWY1LPoa
        45WaPqH8IRnEpNo9jpedCoIFIWWrEiWODP/gUFrutpPMPqb06Dt/vkFD/F0gu1cjz6kCdboGFe/fX
        xiBK5j1w==;
Received: from [41.74.137.107] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pEtNx-003TyM-HA; Mon, 09 Jan 2023 15:44:25 +0100
From:   Melissa Wen <mwen@igalia.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     Joshua Ashton <joshua@froggi.es>, alex.hung@amd.com,
        nicholas.kazlauskas@amd.com, sungjoon.kim@amd.com,
        seanpaul@chromium.org, bhawanpreet.lakha@amd.com,
        Shashank Sharma <shashank.sharma@amd.com>,
        ville.syrjala@linux.intel.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, kernel-dev@igalia.com,
        laurent.pinchart+renesas@ideasonboard.com,
        Melissa Wen <mwen@igalia.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 14/18] drm/amd/display: expand array of supported 3D LUT modes
Date:   Mon,  9 Jan 2023 13:38:42 -0100
Message-Id: <20230109143846.1966301-15-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230109143846.1966301-1-mwen@igalia.com>
References: <20230109143846.1966301-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD MPC block support 3D LUTs of dimensions 17 and 9, and also bit
depth 12 and 10, therefore, advertise them to the userspace.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/modules/color/color_gamma.h   | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.h b/drivers/gpu/drm/amd/display/modules/color/color_gamma.h
index 8e159b1eb9c6..69b9a1aa6dd4 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.h
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.h
@@ -47,6 +47,37 @@ static const struct drm_mode_lut3d_mode lut3d_mode_17_12bit = {
 	.flags = 0,
 };
 
+static const struct drm_mode_lut3d_mode amdgpu_lut3d_modes[] = {
+	{
+		.lut_size = 17,
+		.lut_stride = {17, 17, 18},
+		.bit_depth = 12,
+		.color_format = DRM_FORMAT_XRGB16161616,
+		.flags = 0,
+	},
+	{
+		.lut_size = 17,
+		.lut_stride = {17, 17, 18},
+		.bit_depth = 10,
+		.color_format = DRM_FORMAT_XRGB16161616,
+		.flags = 0,
+	},
+	{
+		.lut_size = 9,
+		.lut_stride = {9, 9, 10},
+		.bit_depth = 12,
+		.color_format = DRM_FORMAT_XRGB16161616,
+		.flags = 0,
+	},
+	{
+		.lut_size = 9,
+		.lut_stride = {9, 9, 10},
+		.bit_depth = 10,
+		.color_format = DRM_FORMAT_XRGB16161616,
+		.flags = 0,
+	},
+};
+
 /* For SetRegamma ADL interface support
  * Must match escape type
  */
-- 
2.35.1

