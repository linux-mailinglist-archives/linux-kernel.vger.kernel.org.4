Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB835B4804
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 21:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiIJTDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 15:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIJTDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 15:03:38 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B249C491EC
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 12:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=IfGYbbeCCpVUgPtnr7pWT4b/nUnNPSzqNx/sB1Pg1Rg=; b=AKxX8bxiBjG+q7+EXxVAD2UqlV
        0EaltR9bt2kbEQOvHj8A2K1UcB8UWy7LqGe0B017nQrGYk8Lh8PG5j2OqlHqRjY2tVTbbbEocFOSF
        0q05iQASdmmpXabrWYpnAwx7IxpxkL+HFgp9Xs1sPTv+rVxl7Hwn8tE4CLskPFNUVsNxSv0G75OF3
        63Uu3kTOKkTOPmHM47zgOWW5TNEW/wFCce3aQqXibytFBX4RwuApxR6sM+bUwsqZYev8T+FoHqeFJ
        CsBTqGPIFTRZjEaoqbaQ3EXhYE6bJ+13qnqviwkoU/mJUEJjqMNK+5Jf7D5EWeldbgK3nrCSwk12o
        WfnZ89GA==;
Received: from [38.44.74.92] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oX5l9-00Eggr-3W; Sat, 10 Sep 2022 21:03:19 +0200
From:   Melissa Wen <mwen@igalia.com>
To:     rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, igormtorrente@gmail.com
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Melissa Wen <mwen@igalia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        kernel test robot <lkp@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/vkms: fix 32bit compilation error by replacing macros
Date:   Sat, 10 Sep 2022 18:03:03 -0100
Message-Id: <20220910190303.682897-1-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
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

Replace vkms_formats macro for fixed-point operations with functions
from drm/drm_fixed.h to do the same job and fix 32-bit compilation
errors.

v2:
- don't cast results to s32 (Igor)
- add missing drm_fixp2int conversion (Igor)

Fixes: a19c2ac9858 ("drm: vkms: Add support to the RGB565 format")
Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com> (v1)
Reviewed-by: Alex Deucher <alexander.deucher@amd.com> (v1)
Reported-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 53 +++++++++++------------------
 1 file changed, 19 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 300abb4d1dfe..d4950688b3f1 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -1,27 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <drm/drm_rect.h>
+#include <linux/kernel.h>
 #include <linux/minmax.h>
+#include <drm/drm_rect.h>
+#include <drm/drm_fixed.h>
 
 #include "vkms_formats.h"
 
-/* The following macros help doing fixed point arithmetic. */
-/*
- * With Fixed-Point scale 15 we have 17 and 15 bits of integer and fractional
- * parts respectively.
- *  | 0000 0000 0000 0000 0.000 0000 0000 0000 |
- * 31                                          0
- */
-#define SHIFT 15
-
-#define INT_TO_FIXED(a) ((a) << SHIFT)
-#define FIXED_MUL(a, b) ((s32)(((s64)(a) * (b)) >> SHIFT))
-#define FIXED_DIV(a, b) ((s32)(((s64)(a) << SHIFT) / (b)))
-/* This macro converts a fixed point number to int, and round half up it */
-#define FIXED_TO_INT_ROUND(a) (((a) + (1 << (SHIFT - 1))) >> SHIFT)
-#define INT_TO_FIXED_DIV(a, b) (FIXED_DIV(INT_TO_FIXED(a), INT_TO_FIXED(b)))
-#define INT_TO_FIXED_DIV(a, b) (FIXED_DIV(INT_TO_FIXED(a), INT_TO_FIXED(b)))
-
 static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int y)
 {
 	return frame_info->offset + (y * frame_info->pitch)
@@ -137,19 +122,19 @@ static void RGB565_to_argb_u16(struct line_buffer *stage_buffer,
 	int x_limit = min_t(size_t, drm_rect_width(&frame_info->dst),
 			       stage_buffer->n_pixels);
 
-	s32 fp_rb_ratio = INT_TO_FIXED_DIV(65535, 31);
-	s32 fp_g_ratio = INT_TO_FIXED_DIV(65535, 63);
+	s64 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(31));
+	s64 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(63));
 
 	for (size_t x = 0; x < x_limit; x++, src_pixels++) {
 		u16 rgb_565 = le16_to_cpu(*src_pixels);
-		s32 fp_r = INT_TO_FIXED((rgb_565 >> 11) & 0x1f);
-		s32 fp_g = INT_TO_FIXED((rgb_565 >> 5) & 0x3f);
-		s32 fp_b = INT_TO_FIXED(rgb_565 & 0x1f);
+		s64 fp_r = drm_int2fixp((rgb_565 >> 11) & 0x1f);
+		s64 fp_g = drm_int2fixp((rgb_565 >> 5) & 0x3f);
+		s64 fp_b = drm_int2fixp(rgb_565 & 0x1f);
 
 		out_pixels[x].a = (u16)0xffff;
-		out_pixels[x].r = FIXED_TO_INT_ROUND(FIXED_MUL(fp_r, fp_rb_ratio));
-		out_pixels[x].g = FIXED_TO_INT_ROUND(FIXED_MUL(fp_g, fp_g_ratio));
-		out_pixels[x].b = FIXED_TO_INT_ROUND(FIXED_MUL(fp_b, fp_rb_ratio));
+		out_pixels[x].r = drm_fixp2int(drm_fixp_mul(fp_r, fp_rb_ratio));
+		out_pixels[x].g = drm_fixp2int(drm_fixp_mul(fp_g, fp_g_ratio));
+		out_pixels[x].b = drm_fixp2int(drm_fixp_mul(fp_b, fp_rb_ratio));
 	}
 }
 
@@ -248,17 +233,17 @@ static void argb_u16_to_RGB565(struct vkms_frame_info *frame_info,
 	int x_limit = min_t(size_t, drm_rect_width(&frame_info->dst),
 			    src_buffer->n_pixels);
 
-	s32 fp_rb_ratio = INT_TO_FIXED_DIV(65535, 31);
-	s32 fp_g_ratio = INT_TO_FIXED_DIV(65535, 63);
+	s64 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(31));
+	s64 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(63));
 
 	for (size_t x = 0; x < x_limit; x++, dst_pixels++) {
-		s32 fp_r = INT_TO_FIXED(in_pixels[x].r);
-		s32 fp_g = INT_TO_FIXED(in_pixels[x].g);
-		s32 fp_b = INT_TO_FIXED(in_pixels[x].b);
+		s64 fp_r = drm_int2fixp(in_pixels[x].r);
+		s64 fp_g = drm_int2fixp(in_pixels[x].g);
+		s64 fp_b = drm_int2fixp(in_pixels[x].b);
 
-		u16 r = FIXED_TO_INT_ROUND(FIXED_DIV(fp_r, fp_rb_ratio));
-		u16 g = FIXED_TO_INT_ROUND(FIXED_DIV(fp_g, fp_g_ratio));
-		u16 b = FIXED_TO_INT_ROUND(FIXED_DIV(fp_b, fp_rb_ratio));
+		u16 r = drm_fixp2int(drm_fixp_div(fp_r, fp_rb_ratio));
+		u16 g = drm_fixp2int(drm_fixp_div(fp_g, fp_g_ratio));
+		u16 b = drm_fixp2int(drm_fixp_div(fp_b, fp_rb_ratio));
 
 		*dst_pixels = cpu_to_le16(r << 11 | g << 5 | b);
 	}
-- 
2.35.1

