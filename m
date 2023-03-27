Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462136CB28F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjC0XgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjC0XgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:36:17 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7D030E0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:35:50 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w133so7710456oib.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1679960150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1xhDxA3uWDRifG4IvLBAoRIIiYm0r4QC9LLNbKp2X8=;
        b=hvoaJX2ufI+udaK8mtxiLI21DzeH7JurXG/B43jOARKu83aSms5p/jUB7lwFs6omfL
         C3MvJEbwKrp4+zN7nS9bwwLJRstOf0GeeBnUjX0wuSPeyXQ2hqrkBQek1SQGMIiX+KCX
         /4ZPrhOgZvJ0MEOfcTm3nKfKoZUGeUiv8O33K6TquSH+CmZVXyqzo50twDCInP4i9q9l
         LtUwMM4WfNHC2cmc/CLIiaJJAaok/ssG3j/4jAMDz7SP/mcITFs8jlPilmDmUbIu1rpa
         S8HtZoIjJX3ZkBhEtr41i+hLJVS4ef1KC5FtF535WpCQQdngJk+XZwGB3Wp0bFrZvPsJ
         rcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679960150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1xhDxA3uWDRifG4IvLBAoRIIiYm0r4QC9LLNbKp2X8=;
        b=sZaFtVDmiF1BUV78mBatW9UMhCjDQd9bO+EOTb/S9OmWxzqp+E4YfCig+8WoInXqMA
         7J3DmjngKgzwWIFV0TTvWvqVOEcGQt0IpZLTIvMUX4V1uap/t/m9tC4E05lIYm4+NdXH
         s5zl2omyGVXPS8MuJcN2WgtwSOVuo18q//QI8NzOtLcaDNxnbMYejGLcvsP2+SgEP4mJ
         QQbbUbYzm1Vl7frYKGXH9ZpAlq1Emxu3Mfpyhv6PNlG3GgJXHu9CyZBSVIbUKWg+ke30
         blZp/gANCHSKEG0nLryjjbPdC0MxQERAkCV5XFUegWcv7NlX9h+y/IhhiKVRlMTPS4ur
         +VGw==
X-Gm-Message-State: AO0yUKWBykkt+1dkYHfdknSEjUunW4xzu2nnbOpPubN0lvpR8o4WU6nH
        Bond+lZP3rwuOI1X/8rhUIhGww==
X-Google-Smtp-Source: AK7set8NiGmgJV8HERS4O1DEMBfqAEeV4IytdUJ48dLagBB0+Hq6qQQfvpgB8IkKbofF5pTimWiQAg==
X-Received: by 2002:aca:6507:0:b0:387:3239:61fa with SMTP id m7-20020aca6507000000b00387323961famr5553985oim.30.1679960149872;
        Mon, 27 Mar 2023 16:35:49 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
        by smtp.gmail.com with ESMTPSA id b186-20020aca34c3000000b00389295e8424sm1643409oia.45.2023.03.27.16.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 16:35:49 -0700 (PDT)
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
Subject: [PATCH 10/12] drm/amd/display: Remove unused variable 'cursor_bpp'
Date:   Mon, 27 Mar 2023 20:33:51 -0300
Message-Id: <20230327233353.64081-11-caionovais@usp.br>
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

Compiling AMD GPU drivers displays a warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c: In function ‘dcn32_helper_calculate_mall_bytes_for_cursor’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:62:18: warning: variable ‘cursor_bpp’ set but not used [-Wunused-but-set-variable]

Get rid of it by removing the variable.

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 3a2d7bcc4b6d..a616cf078cf4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -59,25 +59,21 @@ uint32_t dcn32_helper_calculate_mall_bytes_for_cursor(
 {
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
 	uint32_t cursor_size = hubp->curs_attr.pitch * hubp->curs_attr.height;
-	uint32_t cursor_bpp = 4;
 	uint32_t cursor_mall_size_bytes = 0;
 
 	switch (pipe_ctx->stream->cursor_attributes.color_format) {
 	case CURSOR_MODE_MONO:
 		cursor_size /= 2;
-		cursor_bpp = 4;
 		break;
 	case CURSOR_MODE_COLOR_1BIT_AND:
 	case CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA:
 	case CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA:
 		cursor_size *= 4;
-		cursor_bpp = 4;
 		break;
 
 	case CURSOR_MODE_COLOR_64BIT_FP_PRE_MULTIPLIED:
 	case CURSOR_MODE_COLOR_64BIT_FP_UN_PRE_MULTIPLIED:
 		cursor_size *= 8;
-		cursor_bpp = 8;
 		break;
 	}
 
-- 
2.40.0

