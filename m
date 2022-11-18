Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7821362FCE7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242538AbiKRSm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbiKRSmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:42:53 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74FA67128;
        Fri, 18 Nov 2022 10:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668796971; x=1700332971;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V5Hw9NYkCkvMm5f8vj1Mv2/Ssn9brYUwFrrE08qkFnQ=;
  b=b3/F+Qs+F5YQ8Zl7NUx+CyPDJEctrKJMMtNBjDIjdbLtdz0QMTQ2k4DV
   +OT//41XPUXDVB/GkSyhZ2Mp5T/1C4DPfEGJjcR6KD/TxiR7O34a4Fzco
   Duttxh0+OtJJChkqJ2nDuv9vRByrsHg7Q6tGwGEo7MA3NJCd23boMDvIc
   UcuH1Rl8X4A4HWT3S0SZq1lesVFgQgvL1Iv6H589CkxzizyGkZIWlqWFC
   5xmTc5BzgwsloMZ2aRifqehnKNfb4aak5Z81W77jVx7fK4Cv5pphVVw+K
   twcM5ri675RuDljhUQZp/ID/JqbKveyjdItlrnpi2REmffFrQSVtL/PaN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="310836553"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="310836553"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 10:42:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="746101486"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="746101486"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 18 Nov 2022 10:42:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 707EA10E; Fri, 18 Nov 2022 20:43:14 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v1 1/1] atomisp: Make bds_factors_list be type of struct u32_fract
Date:   Fri, 18 Nov 2022 20:43:09 +0200
Message-Id: <20221118184309.60834-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The list contains the Bayer scale index, and rational fraction of it.
The struct u32_fract is suitable type to hold that. Convert the driver
to use latter instead of former.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../pipe/interface/ia_css_pipe_binarydesc.h   | 13 ++---
 .../pci/camera/pipe/src/pipe_binarydesc.c     | 55 ++++++++-----------
 .../atomisp/pci/runtime/binary/src/binary.c   | 42 +++++---------
 .../media/atomisp/pci/sh_css_param_shading.c  | 19 +++----
 4 files changed, 51 insertions(+), 78 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/camera/pipe/interface/ia_css_pipe_binarydesc.h b/drivers/staging/media/atomisp/pci/camera/pipe/interface/ia_css_pipe_binarydesc.h
index 965cfda50707..e42eeaeb3ee4 100644
--- a/drivers/staging/media/atomisp/pci/camera/pipe/interface/ia_css_pipe_binarydesc.h
+++ b/drivers/staging/media/atomisp/pci/camera/pipe/interface/ia_css_pipe_binarydesc.h
@@ -16,6 +16,8 @@
 #ifndef __IA_CSS_PIPE_BINARYDESC_H__
 #define __IA_CSS_PIPE_BINARYDESC_H__
 
+#include <linux/math.h>
+
 #include <ia_css_types.h>		/* ia_css_pipe */
 #include <ia_css_frame_public.h>	/* ia_css_frame_info */
 #include <ia_css_binary.h>		/* ia_css_binary_descr */
@@ -56,17 +58,12 @@ void ia_css_pipe_get_vfpp_binarydesc(
  *
  * @param[in] bds_factor: The bayer downscaling factor.
  *		(= The bds_factor member in the sh_css_bds_factor structure.)
- * @param[out] bds_factor_numerator: The numerator of the bayer downscaling factor.
- *		(= The numerator member in the sh_css_bds_factor structure.)
- * @param[out] bds_factor_denominator: The denominator of the bayer downscaling factor.
- *		(= The denominator member in the sh_css_bds_factor structure.)
+ * @param[out] bds: The rational fraction of the bayer downscaling factor.
+ *		(= The respective member in the sh_css_bds_factor structure.)
  * @return	0 or error code upon error.
  *
  */
-int sh_css_bds_factor_get_numerator_denominator(
-    unsigned int bds_factor,
-    unsigned int *bds_factor_numerator,
-    unsigned int *bds_factor_denominator);
+int sh_css_bds_factor_get_fract(unsigned int bds_factor, struct u32_fract *bds);
 
 /* @brief Get a binary descriptor for preview stage.
  *
diff --git a/drivers/staging/media/atomisp/pci/camera/pipe/src/pipe_binarydesc.c b/drivers/staging/media/atomisp/pci/camera/pipe/src/pipe_binarydesc.c
index 7dd0e4a53c8b..06664ce75b60 100644
--- a/drivers/staging/media/atomisp/pci/camera/pipe/src/pipe_binarydesc.c
+++ b/drivers/staging/media/atomisp/pci/camera/pipe/src/pipe_binarydesc.c
@@ -13,6 +13,9 @@
  * more details.
  */
 
+#include <linux/kernel.h>
+#include <linux/math.h>
+
 #include "ia_css_pipe_binarydesc.h"
 #include "ia_css_frame_format.h"
 #include "ia_css_pipe.h"
@@ -23,7 +26,6 @@
 #include <assert_support.h>
 /* HRT_GDC_N */
 #include "gdc_device.h"
-#include <linux/kernel.h>
 
 /* This module provides a binary descriptions to used to find a binary. Since,
  * every stage is associated with a binary, it implicity helps stage
@@ -126,40 +128,29 @@ void ia_css_pipe_get_vfpp_binarydesc(
 	IA_CSS_LEAVE_PRIVATE("");
 }
 
-static struct sh_css_bds_factor bds_factors_list[] = {
-	{1, 1, SH_CSS_BDS_FACTOR_1_00},
-	{5, 4, SH_CSS_BDS_FACTOR_1_25},
-	{3, 2, SH_CSS_BDS_FACTOR_1_50},
-	{2, 1, SH_CSS_BDS_FACTOR_2_00},
-	{9, 4, SH_CSS_BDS_FACTOR_2_25},
-	{5, 2, SH_CSS_BDS_FACTOR_2_50},
-	{3, 1, SH_CSS_BDS_FACTOR_3_00},
-	{4, 1, SH_CSS_BDS_FACTOR_4_00},
-	{9, 2, SH_CSS_BDS_FACTOR_4_50},
-	{5, 1, SH_CSS_BDS_FACTOR_5_00},
-	{6, 1, SH_CSS_BDS_FACTOR_6_00},
-	{8, 1, SH_CSS_BDS_FACTOR_8_00}
+static struct u32_fract bds_factors_list[] = {
+	[SH_CSS_BDS_FACTOR_1_00] = {1, 1},
+	[SH_CSS_BDS_FACTOR_1_25] = {5, 4},
+	[SH_CSS_BDS_FACTOR_1_50] = {3, 2},
+	[SH_CSS_BDS_FACTOR_2_00] = {2, 1},
+	[SH_CSS_BDS_FACTOR_2_25] = {9, 4},
+	[SH_CSS_BDS_FACTOR_2_50] = {5, 2},
+	[SH_CSS_BDS_FACTOR_3_00] = {3, 1},
+	[SH_CSS_BDS_FACTOR_4_00] = {4, 1},
+	[SH_CSS_BDS_FACTOR_4_50] = {9, 2},
+	[SH_CSS_BDS_FACTOR_5_00] = {5, 1},
+	[SH_CSS_BDS_FACTOR_6_00] = {6, 1},
+	[SH_CSS_BDS_FACTOR_8_00] = {8, 1},
 };
 
-int sh_css_bds_factor_get_numerator_denominator(
-    unsigned int bds_factor,
-    unsigned int *bds_factor_numerator,
-    unsigned int *bds_factor_denominator)
+int sh_css_bds_factor_get_fract(unsigned int bds_factor, struct u32_fract *bds)
 {
-	unsigned int i;
-
-	/* Loop over all bds factors until a match is found */
-	for (i = 0; i < ARRAY_SIZE(bds_factors_list); i++) {
-		if (bds_factors_list[i].bds_factor == bds_factor) {
-			*bds_factor_numerator = bds_factors_list[i].numerator;
-			*bds_factor_denominator = bds_factors_list[i].denominator;
-			return 0;
-		}
-	}
+	/* Throw an error since bds_factor cannot be found in bds_factors_list */
+	if (bds_factor >= ARRAY_SIZE(bds_factors_list))
+		return -EINVAL;
 
-	/* Throw an error since bds_factor cannot be found
-	in bds_factors_list */
-	return -EINVAL;
+	*bds = bds_factors_list[bds_factor];
+	return 0;
 }
 
 int binarydesc_calculate_bds_factor(
@@ -194,7 +185,7 @@ int binarydesc_calculate_bds_factor(
 			    (out_h * num / den <= in_h);
 
 		if (cond) {
-			*bds_factor = bds_factors_list[i].bds_factor;
+			*bds_factor = i;
 			return 0;
 		}
 	}
diff --git a/drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c b/drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c
index 406ed5fb4c6a..768da86b8c2c 100644
--- a/drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c
+++ b/drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c
@@ -13,6 +13,8 @@
  * more details.
  */
 
+#include <linux/math.h>
+
 #include <math_support.h>
 #include <gdc_device.h>	/* HR_GDC_N */
 
@@ -128,16 +130,8 @@ ia_css_binary_compute_shading_table_bayer_origin(
 {
 	int err;
 
-	/* Numerator and denominator of the fixed bayer downscaling factor.
-	(numerator >= denominator) */
-	unsigned int bds_num, bds_den;
-
-	/* Horizontal/Vertical ratio of bayer scaling
-	between input area and output area. */
-	unsigned int bs_hor_ratio_in;
-	unsigned int bs_hor_ratio_out;
-	unsigned int bs_ver_ratio_in;
-	unsigned int bs_ver_ratio_out;
+	/* Rational fraction of the fixed bayer downscaling factor. */
+	struct u32_fract bds;
 
 	/* Left padding set by InputFormatter. */
 	unsigned int left_padding_bqs;			/* in bqs */
@@ -158,19 +152,11 @@ ia_css_binary_compute_shading_table_bayer_origin(
 	unsigned int bad_bqs_on_top_before_bs;	/* in bqs */
 	unsigned int bad_bqs_on_top_after_bs;	/* in bqs */
 
-	/* Get the numerator and denominator of bayer downscaling factor. */
-	err = sh_css_bds_factor_get_numerator_denominator
-	(required_bds_factor, &bds_num, &bds_den);
+	/* Get the rational fraction of bayer downscaling factor. */
+	err = sh_css_bds_factor_get_fract(required_bds_factor, &bds);
 	if (err)
 		return err;
 
-	/* Set the horizontal/vertical ratio of bayer scaling
-	between input area and output area. */
-	bs_hor_ratio_in  = bds_num;
-	bs_hor_ratio_out = bds_den;
-	bs_ver_ratio_in  = bds_num;
-	bs_ver_ratio_out = bds_den;
-
 	/* Set the left padding set by InputFormatter. (ifmtr.c) */
 	if (stream_config->left_padding == -1)
 		left_padding_bqs = _ISP_BQS(binary->left_padding);
@@ -228,18 +214,18 @@ ia_css_binary_compute_shading_table_bayer_origin(
 	located on the shading table during the shading correction. */
 	res->sc_bayer_origin_x_bqs_on_shading_table =
 		((left_padding_adjusted_bqs + bad_bqs_on_left_before_bs)
-		* bs_hor_ratio_out + bs_hor_ratio_in / 2) / bs_hor_ratio_in
+		* bds.denominator + bds.numerator / 2) / bds.numerator
 		+ bad_bqs_on_left_after_bs;
-	/* "+ bs_hor_ratio_in/2": rounding for division by bs_hor_ratio_in */
+	/* "+ bds.numerator / 2": rounding for division by bds.numerator */
 	res->sc_bayer_origin_y_bqs_on_shading_table =
-		(bad_bqs_on_top_before_bs * bs_ver_ratio_out + bs_ver_ratio_in / 2) / bs_ver_ratio_in
+		(bad_bqs_on_top_before_bs * bds.denominator + bds.numerator / 2) / bds.numerator
 		+ bad_bqs_on_top_after_bs;
-	/* "+ bs_ver_ratio_in/2": rounding for division by bs_ver_ratio_in */
+	/* "+ bds.numerator / 2": rounding for division by bds.numerator */
 
-	res->bayer_scale_hor_ratio_in  = (uint32_t)bs_hor_ratio_in;
-	res->bayer_scale_hor_ratio_out = (uint32_t)bs_hor_ratio_out;
-	res->bayer_scale_ver_ratio_in  = (uint32_t)bs_ver_ratio_in;
-	res->bayer_scale_ver_ratio_out = (uint32_t)bs_ver_ratio_out;
+	res->bayer_scale_hor_ratio_in  = bds.numerator;
+	res->bayer_scale_hor_ratio_out = bds.denominator;
+	res->bayer_scale_ver_ratio_in  = bds.numerator;
+	res->bayer_scale_ver_ratio_out = bds.denominator;
 
 	return err;
 }
diff --git a/drivers/staging/media/atomisp/pci/sh_css_param_shading.c b/drivers/staging/media/atomisp/pci/sh_css_param_shading.c
index 41a4c9162319..5b43cc656269 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_param_shading.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_param_shading.c
@@ -13,6 +13,7 @@
  * more details.
  */
 
+#include <linux/math.h>
 #include <linux/slab.h>
 
 #include <math_support.h>
@@ -239,10 +240,9 @@ prepare_shading_table(const struct ia_css_shading_table *in_table,
 {
 	unsigned int input_width, input_height, table_width, table_height, i;
 	unsigned int left_padding, top_padding, left_cropping;
-	unsigned int bds_numerator, bds_denominator;
-	int right_padding;
-
 	struct ia_css_shading_table *result;
+	struct u32_fract bds;
+	int right_padding;
 
 	assert(target_table);
 	assert(binary);
@@ -265,17 +265,16 @@ prepare_shading_table(const struct ia_css_shading_table *in_table,
 	left_cropping = (binary->info->sp.pipeline.left_cropping == 0) ?
 			binary->dvs_envelope.width : 2 * ISP_VEC_NELEMS;
 
-	sh_css_bds_factor_get_numerator_denominator
-	(bds_factor, &bds_numerator, &bds_denominator);
+	sh_css_bds_factor_get_fract(bds_factor, &bds);
 
 	left_padding  = (left_padding + binary->info->sp.pipeline.left_cropping) *
-			bds_numerator / bds_denominator -
+			bds.numerator / bds.denominator -
 			binary->info->sp.pipeline.left_cropping;
 	right_padding = (binary->internal_frame_info.res.width -
-			 binary->effective_in_frame_res.width * bds_denominator /
-			 bds_numerator - left_cropping) * bds_numerator / bds_denominator;
-	top_padding = binary->info->sp.pipeline.top_cropping * bds_numerator /
-		      bds_denominator -
+			 binary->effective_in_frame_res.width * bds.denominator /
+			 bds.numerator - left_cropping) * bds.numerator / bds.denominator;
+	top_padding = binary->info->sp.pipeline.top_cropping * bds.numerator /
+		      bds.denominator -
 		      binary->info->sp.pipeline.top_cropping;
 
 	/*
-- 
2.35.1

