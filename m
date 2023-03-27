Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82E56CB291
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjC0XgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjC0XgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:36:03 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1672D70
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:35:40 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id f17so7681593oiw.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1679960140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1A2mIjPdUqhr5Ice4vp7gIRuK6chByRV3cyN7aavT0E=;
        b=hBEZEu/Fg8Z7uqZ/Ekz1hHMkGIiWSFF5sR50cANSTAnWulG9QmfK+wwFoes5VSYTRh
         htMmf303bnpibjbmVMsR9SPCc51HKUstFFhpmUbInbdSvxo7XOCdedKUFZ8ZtXeJ7/FA
         238eQJQE4A1BarBX9h8IbgyVHKEJmOM2bfBO2yN40h1Yw8KQ3rxQ/tQW4pQ1x4wP5cwj
         x4RDRYoVZB/R5SC67RF1rxAyAA1Nu27ewQa8soq4BzP4HWRC7hBCY2FiqLFMYboWuy++
         x2mBeYBSEDmh/XqmaVCK4Cp6GkEDyA9YmnvG/o4ecItjja9Cz2eSbfxPBnJSBpJvtT0J
         pvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679960140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1A2mIjPdUqhr5Ice4vp7gIRuK6chByRV3cyN7aavT0E=;
        b=bDlXIHjoCp9btWNVrRCzApylWJXgFhYB1FdCaR0y4hxaF2EwwYbxpQo+1yv37j0OIH
         b/9wl7ZtQ5raDRefJPzd/v25ljuooSMMPWFMH7uwX9KNGSK+6ISfWMq/a2qxnoQUDJTi
         mNTOY9qqvFFuOfOK9cSWvgUdLAXGwmLGrG0UcqITISzxaa03AYOOitWPAAA3n9NjIODV
         jjpRXWXcfvLTcNtTgdwFUuCS0ia3Zdx91b+d9HjD73alaG9Y/53bHbcZS29G+LLwmiy9
         R3DnBygMrIfSc0oLU1D7pJSXnnDRYVjUmdvWjlH1UiUVGnti+3d5xUcT3ztxJxOfBpOE
         Go4A==
X-Gm-Message-State: AO0yUKXP2n92yEyVA99YFABDyb/jq6gv/6Gylkctn1gcbBoilEDx84Fq
        7EIu44VNoJ0AoCS/0inLyoN7pw==
X-Google-Smtp-Source: AK7set/XpIaBnrd0Il1RA6TJi7frFciWmH9SabrmY2R33L9ZbylSXEKtU1Nfc4VXuM45NiWKMhJC9Q==
X-Received: by 2002:a05:6808:58:b0:386:f58a:2262 with SMTP id v24-20020a056808005800b00386f58a2262mr5575924oic.57.1679960139887;
        Mon, 27 Mar 2023 16:35:39 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
        by smtp.gmail.com with ESMTPSA id b186-20020aca34c3000000b00389295e8424sm1643409oia.45.2023.03.27.16.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 16:35:39 -0700 (PDT)
From:   Caio Novais <caionovais@usp.br>
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>,
        Mukul Joshi <mukul.joshi@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        Alan Liu <HaoPing.Liu@amd.com>,
        Caio Novais <caionovais@usp.br>,
        Joshua Ashton <joshua@froggi.es>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Zhan Liu <zhan.liu@amd.com>, Wayne Lin <wayne.lin@amd.com>,
        Charlene Liu <Charlene.Liu@amd.com>,
        Martin Leung <Martin.Leung@amd.com>,
        Tom Chung <chiahsuan.chung@amd.com>,
        Alvin Lee <alvin.lee2@amd.com>,
        George Shen <George.Shen@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Roman Li <Roman.Li@amd.com>,
        Wesley Chalmers <Wesley.Chalmers@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Jingwen Zhu <Jingwen.Zhu@amd.com>,
        Melissa Wen <mwen@igalia.com>,
        Felipe Clark <felipe.clark@amd.com>,
        Sung Joon Kim <sungjoon.kim@amd.com>,
        Dillon Varone <Dillon.Varone@amd.com>,
        Ethan Wellenreiter <Ethan.Wellenreiter@amd.com>,
        Taimur Hassan <Syed.Hassan@amd.com>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Brian Chang <Brian.Chang@amd.com>,
        Gabe Teeger <gabe.teeger@amd.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        Chaitanya Dhere <chaitanya.dhere@amd.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Ryan Lin <tsung-hua.lin@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 09/12] drm/amd/display: Remove two unused variables 'is_pipe_split_expected' and 'state'
Date:   Mon, 27 Mar 2023 20:33:50 -0300
Message-Id: <20230327233353.64081-10-caionovais@usp.br>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327233353.64081-1-caionovais@usp.br>
References: <20230327233353.64081-1-caionovais@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling AMD GPU drivers displays two warnings:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c: In function ‘dcn32_acquire_post_bldn_3dlut’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:1614:31: warning: variable ‘state’ set but not used [-Wunused-but-set-variable]
and
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c: In function ‘dcn32_populate_dml_pipes_from_context’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:1916:17: warning: variable ‘is_pipe_split_expected’ set but not used [-Wunused-but-set-variable]

Get rid of them by removing the variables.

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 74e50c09bb62..3435d3294e0b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1611,7 +1611,6 @@ bool dcn32_acquire_post_bldn_3dlut(
 		struct dc_transfer_func **shaper)
 {
 	bool ret = false;
-	union dc_3dlut_state *state;
 
 	ASSERT(*lut == NULL && *shaper == NULL);
 	*lut = NULL;
@@ -1620,7 +1619,6 @@ bool dcn32_acquire_post_bldn_3dlut(
 	if (!res_ctx->is_mpc_3dlut_acquired[mpcc_id]) {
 		*lut = pool->mpc_lut[mpcc_id];
 		*shaper = pool->mpc_shaper[mpcc_id];
-		state = &pool->mpc_lut[mpcc_id]->state;
 		res_ctx->is_mpc_3dlut_acquired[mpcc_id] = true;
 		ret = true;
 	}
@@ -1913,7 +1911,6 @@ int dcn32_populate_dml_pipes_from_context(
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe;
 	bool subvp_in_use = false;
-	uint8_t is_pipe_split_expected[MAX_PIPES] = {0};
 	struct dc_crtc_timing *timing;
 
 	dcn20_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
@@ -2002,7 +1999,6 @@ int dcn32_populate_dml_pipes_from_context(
 		}
 
 		DC_FP_START();
-		is_pipe_split_expected[i] = dcn32_predict_pipe_split(context, &pipes[pipe_cnt]);
 		DC_FP_END();
 
 		pipe_cnt++;
-- 
2.40.0

