Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771886CB27B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjC0XfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjC0Xe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:34:59 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662E32129
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:34:50 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id bk5so7699177oib.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1679960089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QsHyz7gKUkQwkVhf5pyg1KknFMPIvy4LcmMgDotpCM=;
        b=sx01gakuWa2Q5P6dcI4aIQRwIo9i+t9MKVEV2yp/xxLG+XXh5L4SKodd8Ib0rthkhM
         d229sHbxpl6ezpNSYIuE8NQG3fv4OcWLeqiVpughUBDCD6HoXLYQkjPeeOcHA6UVU8G5
         /J+jdLdjufxFxv955wirCwSmbuLxHyCqXYk0my/ciyXJCElao7c90x1rIa/Yh0yTCp3W
         s7+bZXZt1V3nUO4Bba4bODojyT+ct9iMtEBxRi58GmbNQ7mDBbPk1ey70ybCkLX6rMhK
         2vB49cK9mzSLuo9e7QPRVLEHJHwT0WQ6eKElBGY/NK8HFvBSQE8kDrnuupww2QfLMRTD
         Y6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679960089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QsHyz7gKUkQwkVhf5pyg1KknFMPIvy4LcmMgDotpCM=;
        b=RQUmvm3GEGu3++24DvQmx4ppn1XueKY5l/ihMhjaQQLMmILnCqt7p4eKIeydWgSTUm
         a1HuP17DVkwwVJMAKIL1YCnfTOa+pT+Q/woXI8J/p8uuveWBj5BYdcy9VWij16mKw/kF
         pA3EJi8ii3vifbq3k/Q1mSALUucXIogCgMUcFJBBqfinuitSdA8Wm1GRU3aLdu5YPj9q
         LMbc3ueb248pfmksheVRLNvxhAtNY+3r3y7juPMBysiFcuURP7PKMqe0g9YBrQecYROa
         wmAzcl+s9zYGZfDxlk4l63LYJfBLTeb283RE6zFke3Aph68oXEgFxYhLmJr/jwrzbbTw
         NTfg==
X-Gm-Message-State: AAQBX9fHcb6XmL717wJYq2UuYJuOd8T+1twq0uHA6OiD7XLEUGHv6n4M
        6e6gIhI8GNPH07CB1O1Y40J0ww==
X-Google-Smtp-Source: AKy350Zf7TAyCj72D7dBxB05x85USmeaRH3Aok5R7Th4M199ri5mIqKovxSmqM4aYnXWp8ALjUMQfA==
X-Received: by 2002:aca:d0f:0:b0:389:f4a:93ec with SMTP id 15-20020aca0d0f000000b003890f4a93ecmr2974502oin.28.1679960089575;
        Mon, 27 Mar 2023 16:34:49 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
        by smtp.gmail.com with ESMTPSA id b186-20020aca34c3000000b00389295e8424sm1643409oia.45.2023.03.27.16.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 16:34:49 -0700 (PDT)
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
Subject: [PATCH 04/12] drm/amd/display: Remove unused variable 'hubp'
Date:   Mon, 27 Mar 2023 20:33:45 -0300
Message-Id: <20230327233353.64081-5-caionovais@usp.br>
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

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c: In function ‘dcn201_pipe_control_lock’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c:544:22: warning: variable ‘hubp’ set but not used [-Wunused-but-set-variable]

Get rid of it by removing the variable.

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
index 61bcfa03c4e7..1aeb04fbd89d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
@@ -541,8 +541,6 @@ void dcn201_pipe_control_lock(
 	bool lock)
 {
 	struct dce_hwseq *hws = dc->hwseq;
-	struct hubp *hubp = NULL;
-	hubp = dc->res_pool->hubps[pipe->pipe_idx];
 	/* use TG master update lock to lock everything on the TG
 	 * therefore only top pipe need to lock
 	 */
-- 
2.40.0

