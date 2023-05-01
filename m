Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3AF6F2E3B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbjEAD3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjEAD2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:28:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C5024838;
        Sun, 30 Apr 2023 20:13:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF40660FE6;
        Mon,  1 May 2023 03:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAEEC433EF;
        Mon,  1 May 2023 02:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910002;
        bh=vMe4OubmVDGRrStYhGVQzgVmHDPgzMSdfH8kKW3lcSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Na57OSg6w+Ud9e1/fpfLX7yuDtoQr+jTrihBGF7IHvy0uFRULzj3GvzQDBinRBDgw
         wIfWKu+GTfX2QDLkEvtKzp3bicfvtstiCDLnoUG60MEudG6Lz09JauLHwQGekrOZpx
         +XkXA0kb50hhDF8jQ4UeLK35C/1XHGSNlgUdv5jwyjpdreTggza1L3vwou8HFHttU3
         /xE5ws9F6o2fHG74P1EOcRXi8Hy4p7Bgf+mBaAk3jQrKl3GtEc6oVOHYsyiX09YgTJ
         EXgfMGjGgkZJrPz4Cet41dai8bvDZEKHDdau6ODqFE6w4uZA1YFhJtWiOiB26mWGop
         +VBDDVxkjtC8A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Hsieh <Paul.Hsieh@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, nathan@kernel.org, Charlene.Liu@amd.com,
        yang.lee@linux.alibaba.com, arthurgrillo@riseup.net,
        mairacanal@riseup.net, Jun.Lei@amd.com, Daniel.Miess@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.2 03/37] drm/amd/display: Correct DML calculation to align HW formula
Date:   Sun, 30 Apr 2023 22:59:11 -0400
Message-Id: <20230501025945.3253774-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501025945.3253774-1-sashal@kernel.org>
References: <20230501025945.3253774-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Hsieh <Paul.Hsieh@amd.com>

[ Upstream commit 26a9f53198c955b15161da48cdb51041a38d5325 ]

[Why]
In 2560x1440@240p eDP panel, some use cases will enable MPC
combine with RGB MPO then underflow happened. This case is
not allowed from HW formula. 

[How]
Correct eDP, DP and DP2 output bpp calculation to align HW
formula.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Paul Hsieh <Paul.Hsieh@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dc/dml/dcn31/display_mode_vba_31.c        | 298 ++++++++++++------
 .../dc/dml/dcn314/display_mode_vba_314.c      | 298 ++++++++++++------
 2 files changed, 392 insertions(+), 204 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index ec351c8418cbb..3c42ba6039863 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -4304,11 +4304,11 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							v->AudioSampleRate[k],
 							v->AudioSampleLayout[k],
 							v->ODMCombineEnablePerState[i][k]);
-				} else if (v->Output[k] == dm_dp || v->Output[k] == dm_edp) {
+				} else if (v->Output[k] == dm_dp || v->Output[k] == dm_edp || v->Output[k] == dm_dp2p0) {
 					if (v->DSCEnable[k] == true) {
 						v->RequiresDSC[i][k] = true;
 						v->LinkDSCEnable = true;
-						if (v->Output[k] == dm_dp) {
+						if (v->Output[k] == dm_dp || v->Output[k] == dm_dp2p0) {
 							v->RequiresFEC[i][k] = true;
 						} else {
 							v->RequiresFEC[i][k] = false;
@@ -4316,107 +4316,201 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					} else {
 						v->RequiresDSC[i][k] = false;
 						v->LinkDSCEnable = false;
-						v->RequiresFEC[i][k] = false;
-					}
-
-					v->Outbpp = BPP_INVALID;
-					if (v->PHYCLKPerState[i] >= 270.0) {
-						v->Outbpp = TruncToValidBPP(
-								(1.0 - v->Downspreading / 100.0) * 2700,
-								v->OutputLinkDPLanes[k],
-								v->HTotal[k],
-								v->HActive[k],
-								v->PixelClockBackEnd[k],
-								v->ForcedOutputLinkBPP[k],
-								v->LinkDSCEnable,
-								v->Output[k],
-								v->OutputFormat[k],
-								v->DSCInputBitPerComponent[k],
-								v->NumberOfDSCSlices[k],
-								v->AudioSampleRate[k],
-								v->AudioSampleLayout[k],
-								v->ODMCombineEnablePerState[i][k]);
-						v->OutputBppPerState[i][k] = v->Outbpp;
-						// TODO: Need some other way to handle this nonsense
-						// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR"
-					}
-					if (v->Outbpp == BPP_INVALID && v->PHYCLKPerState[i] >= 540.0) {
-						v->Outbpp = TruncToValidBPP(
-								(1.0 - v->Downspreading / 100.0) * 5400,
-								v->OutputLinkDPLanes[k],
-								v->HTotal[k],
-								v->HActive[k],
-								v->PixelClockBackEnd[k],
-								v->ForcedOutputLinkBPP[k],
-								v->LinkDSCEnable,
-								v->Output[k],
-								v->OutputFormat[k],
-								v->DSCInputBitPerComponent[k],
-								v->NumberOfDSCSlices[k],
-								v->AudioSampleRate[k],
-								v->AudioSampleLayout[k],
-								v->ODMCombineEnablePerState[i][k]);
-						v->OutputBppPerState[i][k] = v->Outbpp;
-						// TODO: Need some other way to handle this nonsense
-						// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR2"
-					}
-					if (v->Outbpp == BPP_INVALID && v->PHYCLKPerState[i] >= 810.0) {
-						v->Outbpp = TruncToValidBPP(
-								(1.0 - v->Downspreading / 100.0) * 8100,
-								v->OutputLinkDPLanes[k],
-								v->HTotal[k],
-								v->HActive[k],
-								v->PixelClockBackEnd[k],
-								v->ForcedOutputLinkBPP[k],
-								v->LinkDSCEnable,
-								v->Output[k],
-								v->OutputFormat[k],
-								v->DSCInputBitPerComponent[k],
-								v->NumberOfDSCSlices[k],
-								v->AudioSampleRate[k],
-								v->AudioSampleLayout[k],
-								v->ODMCombineEnablePerState[i][k]);
-						v->OutputBppPerState[i][k] = v->Outbpp;
-						// TODO: Need some other way to handle this nonsense
-						// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR3"
-					}
-					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 10000.0 / 18) {
-						v->Outbpp = TruncToValidBPP(
-								(1.0 - v->Downspreading / 100.0) * 10000,
-								4,
-								v->HTotal[k],
-								v->HActive[k],
-								v->PixelClockBackEnd[k],
-								v->ForcedOutputLinkBPP[k],
-								v->LinkDSCEnable,
-								v->Output[k],
-								v->OutputFormat[k],
-								v->DSCInputBitPerComponent[k],
-								v->NumberOfDSCSlices[k],
-								v->AudioSampleRate[k],
-								v->AudioSampleLayout[k],
-								v->ODMCombineEnablePerState[i][k]);
-						v->OutputBppPerState[i][k] = v->Outbpp;
-						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "10x4";
+						if (v->Output[k] == dm_dp2p0) {
+							v->RequiresFEC[i][k] = true;
+						} else {
+							v->RequiresFEC[i][k] = false;
+						}
 					}
-					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 12000.0 / 18) {
-						v->Outbpp = TruncToValidBPP(
-								12000,
-								4,
-								v->HTotal[k],
-								v->HActive[k],
-								v->PixelClockBackEnd[k],
-								v->ForcedOutputLinkBPP[k],
-								v->LinkDSCEnable,
-								v->Output[k],
-								v->OutputFormat[k],
-								v->DSCInputBitPerComponent[k],
-								v->NumberOfDSCSlices[k],
-								v->AudioSampleRate[k],
-								v->AudioSampleLayout[k],
-								v->ODMCombineEnablePerState[i][k]);
-						v->OutputBppPerState[i][k] = v->Outbpp;
-						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "12x4";
+					if (v->Output[k] == dm_dp2p0) {
+						v->Outbpp = BPP_INVALID;
+						if ((v->OutputLinkDPRate[k] == dm_dp_rate_na || v->OutputLinkDPRate[k] == dm_dp_rate_uhbr10) &&
+							v->PHYCLKD18PerState[k] >= 10000.0 / 18.0) {
+							v->Outbpp = TruncToValidBPP(
+									(1.0 - v->Downspreading / 100.0) * 10000,
+									v->OutputLinkDPLanes[k],
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+							if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[k] < 13500.0 / 18.0 &&
+								v->DSCEnable[k] == true && v->ForcedOutputLinkBPP[k] == 0) {
+								v->RequiresDSC[i][k] = true;
+								v->LinkDSCEnable = true;
+								v->Outbpp = TruncToValidBPP(
+										(1.0 - v->Downspreading / 100.0) * 10000,
+										v->OutputLinkDPLanes[k],
+										v->HTotal[k],
+										v->HActive[k],
+										v->PixelClockBackEnd[k],
+										v->ForcedOutputLinkBPP[k],
+										v->LinkDSCEnable,
+										v->Output[k],
+										v->OutputFormat[k],
+										v->DSCInputBitPerComponent[k],
+										v->NumberOfDSCSlices[k],
+										v->AudioSampleRate[k],
+										v->AudioSampleLayout[k],
+										v->ODMCombineEnablePerState[i][k]);
+							}
+							v->OutputBppPerState[i][k] = v->Outbpp;
+							// TODO: Need some other way to handle this nonsense
+							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " UHBR10"
+						}
+						if (v->Outbpp == BPP_INVALID &&
+							(v->OutputLinkDPRate[k] == dm_dp_rate_na || v->OutputLinkDPRate[k] == dm_dp_rate_uhbr13p5) &&
+							v->PHYCLKD18PerState[k] >= 13500.0 / 18.0) {
+							v->Outbpp = TruncToValidBPP(
+									(1.0 - v->Downspreading / 100.0) * 13500,
+									v->OutputLinkDPLanes[k],
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+							if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[k] < 20000.0 / 18.0 &&
+								v->DSCEnable[k] == true && v->ForcedOutputLinkBPP[k] == 0) {
+								v->RequiresDSC[i][k] = true;
+								v->LinkDSCEnable = true;
+								v->Outbpp = TruncToValidBPP(
+										(1.0 - v->Downspreading / 100.0) * 13500,
+										v->OutputLinkDPLanes[k],
+										v->HTotal[k],
+										v->HActive[k],
+										v->PixelClockBackEnd[k],
+										v->ForcedOutputLinkBPP[k],
+										v->LinkDSCEnable,
+										v->Output[k],
+										v->OutputFormat[k],
+										v->DSCInputBitPerComponent[k],
+										v->NumberOfDSCSlices[k],
+										v->AudioSampleRate[k],
+										v->AudioSampleLayout[k],
+										v->ODMCombineEnablePerState[i][k]);
+							}
+							v->OutputBppPerState[i][k] = v->Outbpp;
+							// TODO: Need some other way to handle this nonsense
+							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " UHBR13p5"
+						}
+						if (v->Outbpp == BPP_INVALID &&
+							(v->OutputLinkDPRate[k] == dm_dp_rate_na || v->OutputLinkDPRate[k] == dm_dp_rate_uhbr20) &&
+							v->PHYCLKD18PerState[k] >= 20000.0 / 18.0) {
+							v->Outbpp = TruncToValidBPP(
+									(1.0 - v->Downspreading / 100.0) * 20000,
+									v->OutputLinkDPLanes[k],
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+							if (v->Outbpp == BPP_INVALID && v->DSCEnable[k] == true &&
+								v->ForcedOutputLinkBPP[k] == 0) {
+								v->RequiresDSC[i][k] = true;
+								v->LinkDSCEnable = true;
+								v->Outbpp = TruncToValidBPP(
+										(1.0 - v->Downspreading / 100.0) * 20000,
+										v->OutputLinkDPLanes[k],
+										v->HTotal[k],
+										v->HActive[k],
+										v->PixelClockBackEnd[k],
+										v->ForcedOutputLinkBPP[k],
+										v->LinkDSCEnable,
+										v->Output[k],
+										v->OutputFormat[k],
+										v->DSCInputBitPerComponent[k],
+										v->NumberOfDSCSlices[k],
+										v->AudioSampleRate[k],
+										v->AudioSampleLayout[k],
+										v->ODMCombineEnablePerState[i][k]);
+							}
+							v->OutputBppPerState[i][k] = v->Outbpp;
+							// TODO: Need some other way to handle this nonsense
+							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " UHBR20"
+						}
+					} else {
+						v->Outbpp = BPP_INVALID;
+						if (v->PHYCLKPerState[i] >= 270.0) {
+							v->Outbpp = TruncToValidBPP(
+									(1.0 - v->Downspreading / 100.0) * 2700,
+									v->OutputLinkDPLanes[k],
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+							v->OutputBppPerState[i][k] = v->Outbpp;
+							// TODO: Need some other way to handle this nonsense
+							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR"
+						}
+						if (v->Outbpp == BPP_INVALID && v->PHYCLKPerState[i] >= 540.0) {
+							v->Outbpp = TruncToValidBPP(
+									(1.0 - v->Downspreading / 100.0) * 5400,
+									v->OutputLinkDPLanes[k],
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+							v->OutputBppPerState[i][k] = v->Outbpp;
+							// TODO: Need some other way to handle this nonsense
+							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR2"
+						}
+						if (v->Outbpp == BPP_INVALID && v->PHYCLKPerState[i] >= 810.0) {
+							v->Outbpp = TruncToValidBPP(
+									(1.0 - v->Downspreading / 100.0) * 8100,
+									v->OutputLinkDPLanes[k],
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+							v->OutputBppPerState[i][k] = v->Outbpp;
+							// TODO: Need some other way to handle this nonsense
+							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR3"
+						}
 					}
 				}
 			} else {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index cb7c0c8784230..e6e98ee491429 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -4402,11 +4402,11 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 							v->AudioSampleRate[k],
 							v->AudioSampleLayout[k],
 							v->ODMCombineEnablePerState[i][k]);
-				} else if (v->Output[k] == dm_dp || v->Output[k] == dm_edp) {
+				} else if (v->Output[k] == dm_dp || v->Output[k] == dm_edp || v->Output[k] == dm_dp2p0) {
 					if (v->DSCEnable[k] == true) {
 						v->RequiresDSC[i][k] = true;
 						v->LinkDSCEnable = true;
-						if (v->Output[k] == dm_dp) {
+						if (v->Output[k] == dm_dp || v->Output[k] == dm_dp2p0) {
 							v->RequiresFEC[i][k] = true;
 						} else {
 							v->RequiresFEC[i][k] = false;
@@ -4414,107 +4414,201 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 					} else {
 						v->RequiresDSC[i][k] = false;
 						v->LinkDSCEnable = false;
-						v->RequiresFEC[i][k] = false;
-					}
-
-					v->Outbpp = BPP_INVALID;
-					if (v->PHYCLKPerState[i] >= 270.0) {
-						v->Outbpp = TruncToValidBPP(
-								(1.0 - v->Downspreading / 100.0) * 2700,
-								v->OutputLinkDPLanes[k],
-								v->HTotal[k],
-								v->HActive[k],
-								v->PixelClockBackEnd[k],
-								v->ForcedOutputLinkBPP[k],
-								v->LinkDSCEnable,
-								v->Output[k],
-								v->OutputFormat[k],
-								v->DSCInputBitPerComponent[k],
-								v->NumberOfDSCSlices[k],
-								v->AudioSampleRate[k],
-								v->AudioSampleLayout[k],
-								v->ODMCombineEnablePerState[i][k]);
-						v->OutputBppPerState[i][k] = v->Outbpp;
-						// TODO: Need some other way to handle this nonsense
-						// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR"
-					}
-					if (v->Outbpp == BPP_INVALID && v->PHYCLKPerState[i] >= 540.0) {
-						v->Outbpp = TruncToValidBPP(
-								(1.0 - v->Downspreading / 100.0) * 5400,
-								v->OutputLinkDPLanes[k],
-								v->HTotal[k],
-								v->HActive[k],
-								v->PixelClockBackEnd[k],
-								v->ForcedOutputLinkBPP[k],
-								v->LinkDSCEnable,
-								v->Output[k],
-								v->OutputFormat[k],
-								v->DSCInputBitPerComponent[k],
-								v->NumberOfDSCSlices[k],
-								v->AudioSampleRate[k],
-								v->AudioSampleLayout[k],
-								v->ODMCombineEnablePerState[i][k]);
-						v->OutputBppPerState[i][k] = v->Outbpp;
-						// TODO: Need some other way to handle this nonsense
-						// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR2"
-					}
-					if (v->Outbpp == BPP_INVALID && v->PHYCLKPerState[i] >= 810.0) {
-						v->Outbpp = TruncToValidBPP(
-								(1.0 - v->Downspreading / 100.0) * 8100,
-								v->OutputLinkDPLanes[k],
-								v->HTotal[k],
-								v->HActive[k],
-								v->PixelClockBackEnd[k],
-								v->ForcedOutputLinkBPP[k],
-								v->LinkDSCEnable,
-								v->Output[k],
-								v->OutputFormat[k],
-								v->DSCInputBitPerComponent[k],
-								v->NumberOfDSCSlices[k],
-								v->AudioSampleRate[k],
-								v->AudioSampleLayout[k],
-								v->ODMCombineEnablePerState[i][k]);
-						v->OutputBppPerState[i][k] = v->Outbpp;
-						// TODO: Need some other way to handle this nonsense
-						// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR3"
-					}
-					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 10000.0 / 18) {
-						v->Outbpp = TruncToValidBPP(
-								(1.0 - v->Downspreading / 100.0) * 10000,
-								4,
-								v->HTotal[k],
-								v->HActive[k],
-								v->PixelClockBackEnd[k],
-								v->ForcedOutputLinkBPP[k],
-								v->LinkDSCEnable,
-								v->Output[k],
-								v->OutputFormat[k],
-								v->DSCInputBitPerComponent[k],
-								v->NumberOfDSCSlices[k],
-								v->AudioSampleRate[k],
-								v->AudioSampleLayout[k],
-								v->ODMCombineEnablePerState[i][k]);
-						v->OutputBppPerState[i][k] = v->Outbpp;
-						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "10x4";
+						if (v->Output[k] == dm_dp2p0) {
+							v->RequiresFEC[i][k] = true;
+						} else {
+							v->RequiresFEC[i][k] = false;
+						}
 					}
-					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 12000.0 / 18) {
-						v->Outbpp = TruncToValidBPP(
-								12000,
-								4,
-								v->HTotal[k],
-								v->HActive[k],
-								v->PixelClockBackEnd[k],
-								v->ForcedOutputLinkBPP[k],
-								v->LinkDSCEnable,
-								v->Output[k],
-								v->OutputFormat[k],
-								v->DSCInputBitPerComponent[k],
-								v->NumberOfDSCSlices[k],
-								v->AudioSampleRate[k],
-								v->AudioSampleLayout[k],
-								v->ODMCombineEnablePerState[i][k]);
-						v->OutputBppPerState[i][k] = v->Outbpp;
-						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "12x4";
+					if (v->Output[k] == dm_dp2p0) {
+						v->Outbpp = BPP_INVALID;
+						if ((v->OutputLinkDPRate[k] == dm_dp_rate_na || v->OutputLinkDPRate[k] == dm_dp_rate_uhbr10) &&
+							v->PHYCLKD18PerState[k] >= 10000.0 / 18.0) {
+							v->Outbpp = TruncToValidBPP(
+									(1.0 - v->Downspreading / 100.0) * 10000,
+									v->OutputLinkDPLanes[k],
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+							if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[k] < 13500.0 / 18.0 &&
+								v->DSCEnable[k] == true && v->ForcedOutputLinkBPP[k] == 0) {
+								v->RequiresDSC[i][k] = true;
+								v->LinkDSCEnable = true;
+								v->Outbpp = TruncToValidBPP(
+										(1.0 - v->Downspreading / 100.0) * 10000,
+										v->OutputLinkDPLanes[k],
+										v->HTotal[k],
+										v->HActive[k],
+										v->PixelClockBackEnd[k],
+										v->ForcedOutputLinkBPP[k],
+										v->LinkDSCEnable,
+										v->Output[k],
+										v->OutputFormat[k],
+										v->DSCInputBitPerComponent[k],
+										v->NumberOfDSCSlices[k],
+										v->AudioSampleRate[k],
+										v->AudioSampleLayout[k],
+										v->ODMCombineEnablePerState[i][k]);
+							}
+							v->OutputBppPerState[i][k] = v->Outbpp;
+							// TODO: Need some other way to handle this nonsense
+							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " UHBR10"
+						}
+						if (v->Outbpp == BPP_INVALID &&
+							(v->OutputLinkDPRate[k] == dm_dp_rate_na || v->OutputLinkDPRate[k] == dm_dp_rate_uhbr13p5) &&
+							v->PHYCLKD18PerState[k] >= 13500.0 / 18.0) {
+							v->Outbpp = TruncToValidBPP(
+									(1.0 - v->Downspreading / 100.0) * 13500,
+									v->OutputLinkDPLanes[k],
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+							if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[k] < 20000.0 / 18.0 &&
+								v->DSCEnable[k] == true && v->ForcedOutputLinkBPP[k] == 0) {
+								v->RequiresDSC[i][k] = true;
+								v->LinkDSCEnable = true;
+								v->Outbpp = TruncToValidBPP(
+										(1.0 - v->Downspreading / 100.0) * 13500,
+										v->OutputLinkDPLanes[k],
+										v->HTotal[k],
+										v->HActive[k],
+										v->PixelClockBackEnd[k],
+										v->ForcedOutputLinkBPP[k],
+										v->LinkDSCEnable,
+										v->Output[k],
+										v->OutputFormat[k],
+										v->DSCInputBitPerComponent[k],
+										v->NumberOfDSCSlices[k],
+										v->AudioSampleRate[k],
+										v->AudioSampleLayout[k],
+										v->ODMCombineEnablePerState[i][k]);
+							}
+							v->OutputBppPerState[i][k] = v->Outbpp;
+							// TODO: Need some other way to handle this nonsense
+							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " UHBR13p5"
+						}
+						if (v->Outbpp == BPP_INVALID &&
+							(v->OutputLinkDPRate[k] == dm_dp_rate_na || v->OutputLinkDPRate[k] == dm_dp_rate_uhbr20) &&
+							v->PHYCLKD18PerState[k] >= 20000.0 / 18.0) {
+							v->Outbpp = TruncToValidBPP(
+									(1.0 - v->Downspreading / 100.0) * 20000,
+									v->OutputLinkDPLanes[k],
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+							if (v->Outbpp == BPP_INVALID && v->DSCEnable[k] == true &&
+								v->ForcedOutputLinkBPP[k] == 0) {
+								v->RequiresDSC[i][k] = true;
+								v->LinkDSCEnable = true;
+								v->Outbpp = TruncToValidBPP(
+										(1.0 - v->Downspreading / 100.0) * 20000,
+										v->OutputLinkDPLanes[k],
+										v->HTotal[k],
+										v->HActive[k],
+										v->PixelClockBackEnd[k],
+										v->ForcedOutputLinkBPP[k],
+										v->LinkDSCEnable,
+										v->Output[k],
+										v->OutputFormat[k],
+										v->DSCInputBitPerComponent[k],
+										v->NumberOfDSCSlices[k],
+										v->AudioSampleRate[k],
+										v->AudioSampleLayout[k],
+										v->ODMCombineEnablePerState[i][k]);
+							}
+							v->OutputBppPerState[i][k] = v->Outbpp;
+							// TODO: Need some other way to handle this nonsense
+							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " UHBR20"
+						}
+					} else {
+						v->Outbpp = BPP_INVALID;
+						if (v->PHYCLKPerState[i] >= 270.0) {
+							v->Outbpp = TruncToValidBPP(
+									(1.0 - v->Downspreading / 100.0) * 2700,
+									v->OutputLinkDPLanes[k],
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+							v->OutputBppPerState[i][k] = v->Outbpp;
+							// TODO: Need some other way to handle this nonsense
+							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR"
+						}
+						if (v->Outbpp == BPP_INVALID && v->PHYCLKPerState[i] >= 540.0) {
+							v->Outbpp = TruncToValidBPP(
+									(1.0 - v->Downspreading / 100.0) * 5400,
+									v->OutputLinkDPLanes[k],
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+							v->OutputBppPerState[i][k] = v->Outbpp;
+							// TODO: Need some other way to handle this nonsense
+							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR2"
+						}
+						if (v->Outbpp == BPP_INVALID && v->PHYCLKPerState[i] >= 810.0) {
+							v->Outbpp = TruncToValidBPP(
+									(1.0 - v->Downspreading / 100.0) * 8100,
+									v->OutputLinkDPLanes[k],
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+							v->OutputBppPerState[i][k] = v->Outbpp;
+							// TODO: Need some other way to handle this nonsense
+							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR3"
+						}
 					}
 				}
 			} else {
-- 
2.39.2

