Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63189626E20
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 08:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbiKMHoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 02:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMHoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 02:44:16 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B82E085;
        Sat, 12 Nov 2022 23:44:15 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id n17so135449pgh.9;
        Sat, 12 Nov 2022 23:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qL9/GcihZbBgWiJpiQOaCK02h1wcxZCDXO7uyUTbbw8=;
        b=exHblae4M4MunjcOekShbyrgIe/nxUgEbvn46rsg4RBRR0o05I2r3Mqz4IM7u4DI+w
         tQpM4t0IJAwXJmjKsyw18yBCPqNKE8BhfQm/Gk6c79TTi4uX7HSdzRB8qcXQF5R0pJzm
         79Of43NBlAbmsBszgp1iTIVxNIjO4PrOgOtENIb8U9X4PPHpVaY00K9kntqvzokJ4rZy
         dwe1JVDl/pUegx3+S6oUbhxZdDJRD9cXUkHxgWB2s3XeJ4pn3wjbUBuY6bmXAleRgWLS
         qsr/lveeC06QExsBi30GM5qyFYmblLJ8rAi3xzo+5+q9U4ANzx5EZ1aI7KhNfUlxwie8
         IEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qL9/GcihZbBgWiJpiQOaCK02h1wcxZCDXO7uyUTbbw8=;
        b=svt28T8cKEK2xNiJipbVOMykF7TTUh4kRSpM/rrpRl7oJ0E2A9nkTDt7GK3lksBRvD
         hst+2qQ/fgq1b6kyxc2vIQWPiOKDYR41eRnStuWsWmJ87RuNhaDng2HGj4Py/LSgoJZU
         3VlCaI5Fj2mhDyuuLHInsyZWdi2QjxZEGUrdysFSATkD58Ay1ihuoetecoG6fzdAqL7c
         888D4KIff6UvU8RfQY+J5eogPUzIrRXEi9Wvz9CxPvDsP/Nlf88RQfksdMgJITcKoGgY
         wECrByhxZIZJvoj+SdOxDhl8lZOHzr0MelkBcKakOAomfjiGxs15iDGkFLKE/KzHYhbP
         czqg==
X-Gm-Message-State: ANoB5pm6CsWtUpJXUCU/7YozV5Awi0hWPt15cW5LscJE+j9EvbJwCeqI
        AKdNV5F4FPp8AMFfEq4fYtI=
X-Google-Smtp-Source: AA0mqf7xCPxr3QdLrQQtVMxQusmnnPZ/wGEg3gbqNmLmxC1Ol2OkKmcY36w5wQYnwrPkF7wsQMntew==
X-Received: by 2002:a63:cf50:0:b0:470:4522:f317 with SMTP id b16-20020a63cf50000000b004704522f317mr7721909pgj.129.1668325454453;
        Sat, 12 Nov 2022 23:44:14 -0800 (PST)
Received: from mail.google.com (125-237-50-34-fibre.sparkbb.co.nz. [125.237.50.34])
        by smtp.gmail.com with ESMTPSA id i7-20020a1709026ac700b00176c0e055f8sm4700960plt.64.2022.11.12.23.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 23:44:14 -0800 (PST)
Date:   Sun, 13 Nov 2022 20:44:05 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Slark Xiao <slark_xiao@163.com>,
        Rongguang Wei <weirongguang@kylinos.cn>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: [PATCH] [next] drm/amdgpu: Replace one-elements array with
 flex-array members
Message-ID: <Y3CgReK3e519a7bs@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with
flexible array members instead. So, replace one-element array with
flexible-array member in structs ATOM_I2C_VOLTAGE_OBJECT_V3,
ATOM_ASIC_INTERNAL_SS_INFO_V2, ATOM_ASIC_INTERNAL_SS_INFO_V3,
and refactor the rest of the code accordingly.

Important to mention is that doing a build before/after this patch
results in no functional binary output differences.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/238
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
Binary difference findings:

	Some changes took more than a single line which changed the line
	number parameter passed to the drm_dbg function (which leverages
	kernel's dynamic debugging). Functionally-wise, nothing changed
	after doing a before/after patch build.

---
 .../gpu/drm/amd/display/dc/bios/bios_parser.c | 22 ++++++++++++-------
 drivers/gpu/drm/amd/include/atombios.h        |  6 ++---
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 6b9e64cd4379..a1a00f432168 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -665,8 +665,9 @@ static enum bp_result get_ss_info_v3_1(
 	if (!DATA_TABLES(ASIC_InternalSS_Info))
 		return BP_RESULT_UNSUPPORTED;
 
-	ss_table_header_include = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V3,
-		DATA_TABLES(ASIC_InternalSS_Info));
+	ss_table_header_include = ((ATOM_ASIC_INTERNAL_SS_INFO_V3 *) bios_get_image(&bp->base,
+				DATA_TABLES(ASIC_InternalSS_Info),
+				struct_size(ss_table_header_include, asSpreadSpectrum, 1)));
 	table_size =
 		(le16_to_cpu(ss_table_header_include->sHeader.usStructureSize)
 				- sizeof(ATOM_COMMON_TABLE_HEADER))
@@ -1032,8 +1033,10 @@ static enum bp_result get_ss_info_from_internal_ss_info_tbl_V2_1(
 	if (!DATA_TABLES(ASIC_InternalSS_Info))
 		return result;
 
-	header = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V2,
-		DATA_TABLES(ASIC_InternalSS_Info));
+	header = ((ATOM_ASIC_INTERNAL_SS_INFO_V2 *) bios_get_image(
+				&bp->base,
+				DATA_TABLES(ASIC_InternalSS_Info),
+				struct_size(header, asSpreadSpectrum, 1)));
 
 	memset(info, 0, sizeof(struct spread_spectrum_info));
 
@@ -1712,8 +1715,10 @@ static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_v2_1(
 	if (!DATA_TABLES(ASIC_InternalSS_Info))
 		return 0;
 
-	header_include = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V2,
-			DATA_TABLES(ASIC_InternalSS_Info));
+	header_include = ((ATOM_ASIC_INTERNAL_SS_INFO_V2 *) bios_get_image(
+				&bp->base,
+				DATA_TABLES(ASIC_InternalSS_Info),
+				struct_size(header_include, asSpreadSpectrum, 1)));
 
 	size = (le16_to_cpu(header_include->sHeader.usStructureSize)
 			- sizeof(ATOM_COMMON_TABLE_HEADER))
@@ -1749,8 +1754,9 @@ static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_V3_1(
 	if (!DATA_TABLES(ASIC_InternalSS_Info))
 		return number;
 
-	header_include = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V3,
-			DATA_TABLES(ASIC_InternalSS_Info));
+	header_include = ((ATOM_ASIC_INTERNAL_SS_INFO_V3 *) bios_get_image(&bp->base,
+				DATA_TABLES(ASIC_InternalSS_Info),
+				struct_size(header_include, asSpreadSpectrum, 1)));
 	size = (le16_to_cpu(header_include->sHeader.usStructureSize) -
 			sizeof(ATOM_COMMON_TABLE_HEADER)) /
 					sizeof(ATOM_ASIC_SS_ASSIGNMENT_V3);
diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/include/atombios.h
index 60c44a8a067f..4dc738c51771 100644
--- a/drivers/gpu/drm/amd/include/atombios.h
+++ b/drivers/gpu/drm/amd/include/atombios.h
@@ -5146,7 +5146,7 @@ typedef struct  _ATOM_I2C_VOLTAGE_OBJECT_V3
    UCHAR  ucVoltageControlOffset;
    UCHAR  ucVoltageControlFlag;              // Bit0: 0 - One byte data; 1 - Two byte data
    UCHAR  ulReserved[3];
-   VOLTAGE_LUT_ENTRY asVolI2cLut[1];         // end with 0xff
+   VOLTAGE_LUT_ENTRY asVolI2cLut[];         // end with 0xff
 }ATOM_I2C_VOLTAGE_OBJECT_V3;
 
 // ATOM_I2C_VOLTAGE_OBJECT_V3.ucVoltageControlFlag
@@ -6679,7 +6679,7 @@ typedef struct _ATOM_ASIC_INTERNAL_SS_INFO
 typedef struct _ATOM_ASIC_INTERNAL_SS_INFO_V2
 {
   ATOM_COMMON_TABLE_HEADER         sHeader;
-  ATOM_ASIC_SS_ASSIGNMENT_V2        asSpreadSpectrum[1];      //this is point only.
+  ATOM_ASIC_SS_ASSIGNMENT_V2        asSpreadSpectrum[];      //this is point only.
 }ATOM_ASIC_INTERNAL_SS_INFO_V2;
 
 typedef struct _ATOM_ASIC_SS_ASSIGNMENT_V3
@@ -6701,7 +6701,7 @@ typedef struct _ATOM_ASIC_SS_ASSIGNMENT_V3
 typedef struct _ATOM_ASIC_INTERNAL_SS_INFO_V3
 {
   ATOM_COMMON_TABLE_HEADER         sHeader;
-  ATOM_ASIC_SS_ASSIGNMENT_V3        asSpreadSpectrum[1];      //this is pointer only.
+  ATOM_ASIC_SS_ASSIGNMENT_V3        asSpreadSpectrum[];      //this is pointer only.
 }ATOM_ASIC_INTERNAL_SS_INFO_V3;
 
 
-- 
2.37.3

