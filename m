Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35DF6EC047
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjDWOPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjDWOPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:15:24 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78996273A
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=1pDv9ml0fMW1552wzaK0WkxguQ7efaI2g4W2c2iLaSQ=; b=Eox+XIAfqqBlMEmXETYlxVXbEh
        JHMNZPiMHotm9iHBFLCgTg0eMle01wIqFJm4RqTCF4aAo33wH93VNrc75eNg9GhToaQQ8MZR10sVS
        VVcU/Ad/u2MW3uASchmgY0rh/ZmfaZ2M0uPRWalgkOBjLFHWxJtajKLCq7TTFWO3KxZiHb/hsg7vB
        lm7esmn/xAWZc5vjeCb7V5QRcsbOCl8FLRoDuqvkvkMTTq9sRIXEff+iMavZKHEIa39gNBNpgOTDG
        0V1X62DnqJA3REts/k7ijvTFdNinuGn+fMbGrnxYflTLiqHR+qSut+0U8lXTcgUikMRUGJoXot13l
        iqFJGnhw==;
Received: from nat-wifi.fi.muni.cz ([147.251.43.9] helo=killbill.fi.muni.cz)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pqaSf-00ANVs-T7; Sun, 23 Apr 2023 16:13:06 +0200
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
Subject: [RFC PATCH 21/40] drm/amd/display: allow BYPASS 3D LUT but keep shaper LUT settings
Date:   Sun, 23 Apr 2023 13:10:33 -0100
Message-Id: <20230423141051.702990-22-mwen@igalia.com>
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

HW allows us to program shaper LUT without 3D LUT settings and it is
also good for testing shaper LUT behavior, therefore, DC driver should
allow acquiring both 3D and shaper LUT, but programing shaper LUT
without 3D LUT (not initialized).

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 3303c9aae068..bacb0a001d68 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -113,7 +113,6 @@ static bool dcn30_set_mpc_shaper_3dlut(struct pipe_ctx *pipe_ctx,
 	}
 
 	if (stream->lut3d_func &&
-	    stream->lut3d_func->state.bits.initialized == 1 &&
 	    stream->lut3d_func->state.bits.rmu_idx_valid == 1) {
 		if (stream->lut3d_func->state.bits.rmu_mux_num == 0)
 			mpcc_id_projected = stream->lut3d_func->state.bits.mpc_rmu0_mux;
@@ -131,8 +130,12 @@ static bool dcn30_set_mpc_shaper_3dlut(struct pipe_ctx *pipe_ctx,
 		if (acquired_rmu != stream->lut3d_func->state.bits.rmu_mux_num)
 			BREAK_TO_DEBUGGER();
 
-		result = mpc->funcs->program_3dlut(mpc, &stream->lut3d_func->lut_3d,
-						   stream->lut3d_func->state.bits.rmu_mux_num);
+		if (stream->lut3d_func->state.bits.initialized == 1)
+			result = mpc->funcs->program_3dlut(mpc, &stream->lut3d_func->lut_3d,
+							   stream->lut3d_func->state.bits.rmu_mux_num);
+		else
+			result = mpc->funcs->program_3dlut(mpc, NULL,
+							   stream->lut3d_func->state.bits.rmu_mux_num);
 		result = mpc->funcs->program_shaper(mpc, shaper_lut,
 						    stream->lut3d_func->state.bits.rmu_mux_num);
 	} else {
-- 
2.39.2

