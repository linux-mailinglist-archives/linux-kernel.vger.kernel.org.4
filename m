Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F376CB275
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjC0Xek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjC0Xeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:34:37 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D63B270B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:34:31 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id s8so7715058ois.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1679960071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCjnRFQPvAGnNx5L3qglgkfLmLwG3nPN+a/hM9CacEs=;
        b=GtnEi/KsBIrFkxShd3lvYGNJ9gUrQ2buWtvBFztcLMpjZHYnpfC2btTyNI2wDsx8gP
         PDOwtTF/TcTUNyeDxR4+oqyXUYAWrwKZvEptBJqEajGlOvHQG/N2hgJNqoRivII1xx51
         srSRUFm+TSmPWghIrj0BJh5li74VwsAaLfH1KqwWeaR6TO4B41nDX8EIySGgAXFLkN8F
         YdwEqm/wd8FQ3RikiVit9f33f8/yakAEXCIUHf2m4mD8ZPr83k/J/9pPD+iRpgpI1jss
         eOoS5rgPZHuaXhSaw/dfu9zrMhREgjPL3L5P57orkSVqAnny3ybOMPodpqyInQTfYtTE
         TpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679960071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCjnRFQPvAGnNx5L3qglgkfLmLwG3nPN+a/hM9CacEs=;
        b=mMy5JZWptBBx8E+pPmQjB/t+S6RgCGzZYg3lXZz3Uu5YpLos5A+2RfjCXd38++S8WJ
         FLPgJndLBea7LNV8UJNBCajg/fYwlS9QcuV9NrADSfykZJwJ20iy/zWdPlJhpf7bRtOk
         a1s5O/6VHaPyK2SHcf546Ksrczsz6fEl/+/E2reVc7RY1pdnZ3j5iFpDsQLqqFl7PQia
         jip4YocKNnKwCnR+3zcCQbZdexZFaB258rPHX+jP14YgEADtnfUSCGoqTsgVn/32d1IZ
         Elvfpz+56Uyabkts6tbwwKnkZxm0Zzf57UIeh9dhOJ2M//geOjSGs9Xvz4+Raf9+8fvd
         l9Mw==
X-Gm-Message-State: AO0yUKWs3PmMhJ4ulKIwQv78o6vJPJDudeePNcheE9+2LCkPGkTd3PGU
        Eudaqd0OIRb3okCNn+5AyvFdBg==
X-Google-Smtp-Source: AK7set8rDxFHQB6rrg/v8At+R+vD2rhk2qXsj5IgrUWpiFpg9BehvyB3jSFGPbGLp8x0w8YllHWLbA==
X-Received: by 2002:a05:6808:2d3:b0:386:ca6d:b602 with SMTP id a19-20020a05680802d300b00386ca6db602mr3723586oid.41.1679960069565;
        Mon, 27 Mar 2023 16:34:29 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
        by smtp.gmail.com with ESMTPSA id b186-20020aca34c3000000b00389295e8424sm1643409oia.45.2023.03.27.16.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 16:34:29 -0700 (PDT)
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
Subject: [PATCH 02/12] drm/amd: Remove unused variable 'value0'
Date:   Mon, 27 Mar 2023 20:33:43 -0300
Message-Id: <20230327233353.64081-3-caionovais@usp.br>
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

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_link_encoder.c: In function ‘dcn10_link_encoder_update_mst_stream_allocation_table’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_link_encoder.c:1222:18: warning: variable ‘value0’ set but not used [-Wunused-but-set-variable]

Get rid of it by removing the variable.

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
index c4287147b853..81aa1631945a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
@@ -1219,7 +1219,6 @@ void dcn10_link_encoder_update_mst_stream_allocation_table(
 	const struct link_mst_stream_allocation_table *table)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	uint32_t value0 = 0;
 	uint32_t value1 = 0;
 	uint32_t value2 = 0;
 	uint32_t slots = 0;
@@ -1321,8 +1320,6 @@ void dcn10_link_encoder_update_mst_stream_allocation_table(
 	do {
 		udelay(10);
 
-		value0 = REG_READ(DP_MSE_SAT_UPDATE);
-
 		REG_GET(DP_MSE_SAT_UPDATE,
 				DP_MSE_SAT_UPDATE, &value1);
 
-- 
2.40.0

