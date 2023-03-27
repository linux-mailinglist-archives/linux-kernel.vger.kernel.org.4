Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782026CB289
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjC0Xfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjC0Xfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:35:42 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E08273C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:35:20 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id bj20so7706189oib.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1679960120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIwazwlkbXfr/mhs4ygPSCHkxMgXqhz2v9oIbK7e01k=;
        b=TTy7nMwv8iMo9KYVcMt30TmODMyElVifkej9lEeLYbHgK0TUC3YmQlbcg+Xo46YJmz
         PYiDPL6xk4c/s7E6SmIBKoazamO9F5A6s5w8jMtY+oTyZhW3eEnO100xmx22j7SDJZtP
         6VsCIUno/jksYrlZ4XP3qSFj9Rm6alVqr8qpzlU9CFbwS4sL9mfnoIPXpCJolwmgjbec
         FqTmiiFznHEg0Ddqp6e4A3sJMsba+tXsBaNtiwGKtPEAF0nk1OARrZNSGtGNt0fS4gbn
         9S1YXKcidghXj5K610oyihoMZCyGAk9I/eY8AXEE+1iuCHHW2VWqcqvzcS54KAC10+rI
         MiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679960120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIwazwlkbXfr/mhs4ygPSCHkxMgXqhz2v9oIbK7e01k=;
        b=orZZ0OayWUEOhGM76Z0Yyd9uBskekyHoNoHT8NwCU/szx5vMCeSY90cz/v8LFwsSIN
         59ZMvRlspMWV21vB97dgoT7hwHocBWbROdaupGv/+F+dTIgnOucizV3XUPyRdIc68Fpq
         2HLDnnRysP0vndeq05kGxFnID748860AOyMTPbmvja1Wepw2luweX9rSKwe+IanGcZRN
         yNDZ6u9py/wndRnCoIHgeDkB/4nZDvxK74AQPKZQpe5L2fJAv+Rn2V4N1R0DWE6Lhd4N
         ggxfKw3Ivzh7mDUwY+YEbrHTEOySImoMc7y3Uve86N2DjeV2kJCxCltzScMFgRonihIZ
         tuTg==
X-Gm-Message-State: AAQBX9fAzC1JZGeW6807sqXGEv2abTivljFnpRvbRf6S/hW5wwjm2ebD
        GOh7U8fpVULqDDD3VIS1EDdnhA==
X-Google-Smtp-Source: AKy350aybt0Fe2KHw7h4hdkKAaCWXQkSMi8faLZ2/V9VaQBsYk7eWBNPEMr15jlKWRpkhkGERzjJYw==
X-Received: by 2002:a05:6808:21a0:b0:388:edc5:3373 with SMTP id be32-20020a05680821a000b00388edc53373mr5891957oib.14.1679960119763;
        Mon, 27 Mar 2023 16:35:19 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
        by smtp.gmail.com with ESMTPSA id b186-20020aca34c3000000b00389295e8424sm1643409oia.45.2023.03.27.16.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 16:35:19 -0700 (PDT)
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
Subject: [PATCH 07/12] drm/amd/display: Remove unused variable 'optc'
Date:   Mon, 27 Mar 2023 20:33:48 -0300
Message-Id: <20230327233353.64081-8-caionovais@usp.br>
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

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c: In function ‘dcn30_enable_writeback’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:326:34: warning: variable ‘optc’ set but not used [-Wunused-but-set-variable]

Get rid of it by removing the variable.

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 3b4d4d68359b..6ef85e71380c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -323,13 +323,10 @@ void dcn30_enable_writeback(
 {
 	struct dwbc *dwb;
 	struct mcif_wb *mcif_wb;
-	struct timing_generator *optc;
 
 	dwb = dc->res_pool->dwbc[wb_info->dwb_pipe_inst];
 	mcif_wb = dc->res_pool->mcif_wb[wb_info->dwb_pipe_inst];
 
-	/* set the OPTC source mux */
-	optc = dc->res_pool->timing_generators[dwb->otg_inst];
 	DC_LOG_DWB("%s dwb_pipe_inst = %d, mpcc_inst = %d",\
 		__func__, wb_info->dwb_pipe_inst,\
 		wb_info->mpcc_inst);
-- 
2.40.0

