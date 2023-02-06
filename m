Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296A868C6E7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjBFTg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjBFTg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:36:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785F51F498
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:36:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E236060FFF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 19:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FC7C4339C;
        Mon,  6 Feb 2023 19:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675712185;
        bh=435YKhMguJ+9O/ZhUCGPU1ciyU6mxfmgLgKQ7YXvQf8=;
        h=From:To:Cc:Subject:Date:From;
        b=nuUR+ZrmFv51dZBilEEq1bxC/lV3NEAy7U0/pDrXJwHMM2zYx6I+RYrNdvAE14wdE
         /BiWz9jCpFIx3avzDoPS4R298WX/zUcMeZ/CyoUBS77m2G5OJ9MZRdFYLemhjGFKu7
         aQ9gbvW/Po6NEoprYltN/kwepbn+7ZMr/tK9BOtDb7f9OyAR3pxY4hnJ7BcIBG6DyH
         O3aCJGxOZZ21FxgNpiSvDZV7a1CsBclRhiw8WRkf82mCE0GyhRk4n8/hYINMDRHyRp
         KHt3xMxn9/sGoHIpoE2y6hXlthpDJQoerRUTMGjIpAMnxSQFvzKZ3JEI2DtVbpPrMB
         TwCjV7l8mDjQw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Aric Cyr <aric.cyr@amd.com>,
        Nevenko Stupar <Nevenko.Stupar@amd.com>,
        Pavle Kotarac <Pavle.Kotarac@amd.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Jun Lei <Jun.Lei@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [SUBMITTED 20210927] [RESEND^2] drm/amdgpu: fix enum odm_combine_mode mismatch
Date:   Mon,  6 Feb 2023 20:36:02 +0100
Message-Id: <20230206193620.69550-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A conversion from 'bool' to 'enum odm_combine_mode' was incomplete,
and gcc warns about this with many instances of

display/dc/dml/dcn20/display_mode_vba_20.c:3899:44: warning: implicit conversion from 'enum <anonymous>' to 'enum
odm_combine_mode' [-Wenum-conversion]
 3899 |     locals->ODMCombineEnablePerState[i][k] = false;

Change the ones that we get a warning for, using the same numerical
values to leave the behavior unchanged.

Fixes: 5fc11598166d ("drm/amd/display: expand dml structs")
Link: https://lore.kernel.org/all/20201026210039.3884312-3-arnd@kernel.org/
Link: https://lore.kernel.org/all/20210927100659.1431744-1-arnd@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I sent this in 2020 and in 2021, but never got a reply and the warning
is still there.
---
 .../amd/display/dc/dml/dcn20/display_mode_vba_20.c   |  8 ++++----
 .../amd/display/dc/dml/dcn20/display_mode_vba_20v2.c | 10 +++++-----
 .../amd/display/dc/dml/dcn21/display_mode_vba_21.c   | 12 ++++++------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index f34bc3c8da41..69c41e3e3ba2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -3901,14 +3901,14 @@ void dml20_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine = mode_lib->vba.PixelClock[k] / 2
 							* (1 + mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
 
-				locals->ODMCombineEnablePerState[i][k] = false;
+				locals->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_disabled;
 				mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithoutODMCombine;
 				if (mode_lib->vba.ODMCapability) {
 					if (locals->PlaneRequiredDISPCLKWithoutODMCombine > mode_lib->vba.MaxDispclkRoundedDownToDFSGranularity) {
-						locals->ODMCombineEnablePerState[i][k] = true;
+						locals->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
 						mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine;
 					} else if (locals->HActive[k] > DCN20_MAX_420_IMAGE_WIDTH && locals->OutputFormat[k] == dm_420) {
-						locals->ODMCombineEnablePerState[i][k] = true;
+						locals->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
 						mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine;
 					}
 				}
@@ -3961,7 +3961,7 @@ void dml20_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				locals->RequiredDISPCLK[i][j] = 0.0;
 				locals->DISPCLK_DPPCLK_Support[i][j] = true;
 				for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++) {
-					locals->ODMCombineEnablePerState[i][k] = false;
+					locals->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_disabled;
 					if (locals->SwathWidthYSingleDPP[k] <= locals->MaximumSwathWidth[k]) {
 						locals->NoOfDPP[i][j][k] = 1;
 						locals->RequiredDPPCLK[i][j][k] = locals->MinDPPCLKUsingSingleDPP[k]
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index 366138df0fe2..f475a0ae946c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -4012,17 +4012,17 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
 					mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine = mode_lib->vba.PixelClock[k] / 2
 							* (1 + mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
 
-				locals->ODMCombineEnablePerState[i][k] = false;
+				locals->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_disabled;
 				mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithoutODMCombine;
 				if (mode_lib->vba.ODMCapability) {
 					if (locals->PlaneRequiredDISPCLKWithoutODMCombine > MaxMaxDispclkRoundedDown) {
-						locals->ODMCombineEnablePerState[i][k] = true;
+						locals->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
 						mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine;
 					} else if (locals->DSCEnabled[k] && (locals->HActive[k] > DCN20_MAX_DSC_IMAGE_WIDTH)) {
-						locals->ODMCombineEnablePerState[i][k] = true;
+						locals->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
 						mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine;
 					} else if (locals->HActive[k] > DCN20_MAX_420_IMAGE_WIDTH && locals->OutputFormat[k] == dm_420) {
-						locals->ODMCombineEnablePerState[i][k] = true;
+						locals->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
 						mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine;
 					}
 				}
@@ -4075,7 +4075,7 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
 				locals->RequiredDISPCLK[i][j] = 0.0;
 				locals->DISPCLK_DPPCLK_Support[i][j] = true;
 				for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++) {
-					locals->ODMCombineEnablePerState[i][k] = false;
+					locals->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_disabled;
 					if (locals->SwathWidthYSingleDPP[k] <= locals->MaximumSwathWidth[k]) {
 						locals->NoOfDPP[i][j][k] = 1;
 						locals->RequiredDPPCLK[i][j][k] = locals->MinDPPCLKUsingSingleDPP[k]
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index eeb4d3441e1d..3a896d0172a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -4106,17 +4106,17 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine = mode_lib->vba.PixelClock[k] / 2
 							* (1 + mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
 
-				locals->ODMCombineEnablePerState[i][k] = false;
+				locals->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_disabled;
 				mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithoutODMCombine;
 				if (mode_lib->vba.ODMCapability) {
 					if (locals->PlaneRequiredDISPCLKWithoutODMCombine > MaxMaxDispclkRoundedDown) {
-						locals->ODMCombineEnablePerState[i][k] = true;
+						locals->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
 						mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine;
 					} else if (locals->DSCEnabled[k] && (locals->HActive[k] > DCN21_MAX_DSC_IMAGE_WIDTH)) {
-						locals->ODMCombineEnablePerState[i][k] = true;
+						locals->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
 						mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine;
 					} else if (locals->HActive[k] > DCN21_MAX_420_IMAGE_WIDTH && locals->OutputFormat[k] == dm_420) {
-						locals->ODMCombineEnablePerState[i][k] = true;
+						locals->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
 						mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine;
 					}
 				}
@@ -4169,7 +4169,7 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				locals->RequiredDISPCLK[i][j] = 0.0;
 				locals->DISPCLK_DPPCLK_Support[i][j] = true;
 				for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++) {
-					locals->ODMCombineEnablePerState[i][k] = false;
+					locals->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_disabled;
 					if (locals->SwathWidthYSingleDPP[k] <= locals->MaximumSwathWidth[k]) {
 						locals->NoOfDPP[i][j][k] = 1;
 						locals->RequiredDPPCLK[i][j][k] = locals->MinDPPCLKUsingSingleDPP[k]
@@ -5234,7 +5234,7 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			mode_lib->vba.ODMCombineEnabled[k] =
 					locals->ODMCombineEnablePerState[mode_lib->vba.VoltageLevel][k];
 		} else {
-			mode_lib->vba.ODMCombineEnabled[k] = false;
+			mode_lib->vba.ODMCombineEnabled[k] = dm_odm_combine_mode_disabled;
 		}
 		mode_lib->vba.DSCEnabled[k] =
 				locals->RequiresDSC[mode_lib->vba.VoltageLevel][k];
-- 
2.39.0

