Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E606CB292
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjC0Xgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjC0Xg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:36:29 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B0F30C1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:36:00 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id l18so7676082oic.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1679960160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1STa2/pWkCDUQgTVLH0svd7MRisCAzPtmwfg6lpY0tI=;
        b=qPr+/DvkkL35CXSg4gE7/ktKUvTDyUTO7/IL0lvUrUhq8xvT+h0HhqzQfjWn1sHUfq
         En1aRSU2RJDmigFYzTkS8EzveTOuSZurTNaXQXuMC6z/L0zjjcJ8pOP/RAK6YNbcQw4q
         N5w7bZZE64NLFvAe+hhsuZfaHKcZTlvPLUVB9WGh8vWvbT6Bw4YEgTBixKkzkX8laK7u
         c3mserAVKXZC8U5cNFsmkDDulr/6NVBOx3crHKcKt03a7xXztRoIGeA5RCQKYfaqLqZm
         P+MTr26pEMPaE0/LT8tYpGLXoDohT7fYS5w7xLTwM+j6dYp92VoQgWbJwQ7Uly27Grox
         qGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679960160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1STa2/pWkCDUQgTVLH0svd7MRisCAzPtmwfg6lpY0tI=;
        b=xT+IrSrCl/yKP6NN1mts34fVrJpCr9zlU/ariqZ/Ffn7FUsR/DLfYWLNdiXq0N6v0o
         i1pn4nbaVgBCn7qXo+UF9qfRUPSKQuHQ2VkOPJe3PK9IXOKP8D5i6SGnhdg8RsGpzSxx
         vQr8UEPDI7QKV5GOylmpXY5u0IoZJ+8NlW6twKMB++k+ZqGUdG6imaRXr+s5Mfw+PCDA
         E2OJ1iiL9oDhZoVXxcOuZwV58/98IMO1o37kSgi1IXeRsP2Ru57gMalMXGHQJ7mpM5mY
         /TwZSSrtSziD/R4s8LNbVmF1ipEZddaxAYdcxpvqMow+3wasTvm001JrYjKLst5stTcw
         oS/Q==
X-Gm-Message-State: AO0yUKVO8JRzzS9J4nRUeHcuQgJYKofDnygA7YSJoTF7ylo1o7oyp8vQ
        X8bCEKfAFPmXtn+PsCA0sJ6Klg==
X-Google-Smtp-Source: AK7set8j4D0nhypplSsU3HBthDUICnrtCgmJYFcK94O5rdy1CxC8OtORoO7uyBWCp1vj0T0Q4dZCWA==
X-Received: by 2002:a05:6808:659:b0:383:caf3:a30e with SMTP id z25-20020a056808065900b00383caf3a30emr5533117oih.17.1679960159943;
        Mon, 27 Mar 2023 16:35:59 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
        by smtp.gmail.com with ESMTPSA id b186-20020aca34c3000000b00389295e8424sm1643409oia.45.2023.03.27.16.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 16:35:59 -0700 (PDT)
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
Subject: [PATCH 11/12] drm/amd/display: Remove unused variable 'scl_enable'
Date:   Mon, 27 Mar 2023 20:33:52 -0300
Message-Id: <20230327233353.64081-12-caionovais@usp.br>
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

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c: In function ‘dml_rq_dlg_get_dlg_params’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c:905:14: warning: variable ‘scl_enable’ set but not used [-Wunused-but-set-variable]

Get rid of it by removing the variable.

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 .../gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c   | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
index 35d10b4d018b..2244e4fb8c96 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
@@ -902,7 +902,6 @@ static void dml_rq_dlg_get_dlg_params(
 	double hratio_c;
 	double vratio_l;
 	double vratio_c;
-	bool scl_enable;
 
 	unsigned int swath_width_ub_l;
 	unsigned int dpte_groups_per_row_ub_l;
@@ -1020,7 +1019,6 @@ static void dml_rq_dlg_get_dlg_params(
 	hratio_c = scl->hscl_ratio_c;
 	vratio_l = scl->vscl_ratio;
 	vratio_c = scl->vscl_ratio_c;
-	scl_enable = scl->scl_enable;
 
 	swath_width_ub_l = rq_dlg_param->rq_l.swath_width_ub;
 	dpte_groups_per_row_ub_l = rq_dlg_param->rq_l.dpte_groups_per_row_ub;
-- 
2.40.0

