Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396A56CF1B0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 20:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjC2SFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 14:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjC2SFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:05:51 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CA04201
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:05:50 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-17ebba88c60so17093591fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1680113150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dENL6Fxh5VQz27gw9oq+gG40WY6+FnIBbbcwaGKgL9s=;
        b=qNdPr3T0VVdr5XsrImYxl6M5mYISWBJYMUVpySQaJmLrp1n0HEXIkbs7mD+7nCUiSp
         ENNG3tu4CDNcZ+DpyTBJZDFodUGb4K1yFLrp60aoqGfGdvW0Dmsvq1k9HJ/N6Z5QvPTu
         Ygb3up24v4GYEu7cvd4/V5uZkfb8Wb5oms7YjPsS3nlLz0oF80AVbw7Zt5p/KBGcfFnC
         NNaFo4Eu+4dGrn1PHgq8lAQ/pNE5MYd5pAmX0OXfbRy3u8sH3JC2mgZq+BceIbzvN1PE
         zmWe0CAElijV4k+CORZ8rpFYnUpxNihjsnBZOXRTPW3RoWA8x511sKffG1CbXwVUXlRd
         TvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680113150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dENL6Fxh5VQz27gw9oq+gG40WY6+FnIBbbcwaGKgL9s=;
        b=gsZedmrwJJOHfmXdjNSFnA19TMqvpWAUT1uH34rgqNdi22XUK1I3LmRdWJtauZW7ma
         cubpLP7LigP3MtbHrtE+Qk3xXNA8/J2TZC0yFE1OyqUN0iljdEXixyYegX5bub9lidK7
         HDmukom6Y+IkbwK9+g6NU04h0CqxdZxKasPkF04RtkKq1kbEEzsnRw6D8DpL/FRhhFEN
         sbKi8M7e4lSoYZ/fCZBY9FlQZCk7t/a8o2750vpGU69RVlwUKtr+RivQ8Gmuy5TR10fU
         vBsBDKOYWB0Rrximsyzv+RsCuxlEUdY1VqqFjbvahqq/PZDZwSKGFmM0FxhQvZJ+dUhw
         avng==
X-Gm-Message-State: AO0yUKWwOqy/5JQBJKclIJZ0XdNg9M93Mj5NRhbi68VZmqw4zmUfcuQN
        SuHNw67ehnzpWi1nNopHy8Qimw==
X-Google-Smtp-Source: AKy350ZFzKCHQwib2AWl++pfIuersKFdWtVFGHv0D3aPWMLgI8OfejXGuKK3kkzECOOmF8Pq50ZmJw==
X-Received: by 2002:a05:6870:1d1:b0:17e:c403:a046 with SMTP id n17-20020a05687001d100b0017ec403a046mr12133932oad.12.1680113149906;
        Wed, 29 Mar 2023 11:05:49 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
        by smtp.gmail.com with ESMTPSA id yo7-20020a05687c018700b001777244e3f9sm12098767oab.8.2023.03.29.11.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:05:49 -0700 (PDT)
From:   Caio Novais <caionovais@usp.br>
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Wesley Chalmers <Wesley.Chalmers@amd.com>,
        "Lee, Alvin" <Alvin.Lee2@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Caio Novais <caionovais@usp.br>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Gabe Teeger <gabe.teeger@amd.com>, Roman Li <roman.li@amd.com>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH v2 1/2] drm/amd/display: Remove unused variable 'scl_enable'
Date:   Wed, 29 Mar 2023 15:05:33 -0300
Message-Id: <20230329180534.99151-2-caionovais@usp.br>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230329180534.99151-1-caionovais@usp.br>
References: <20230329180534.99151-1-caionovais@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_rq_dlg_calc_314.c: In function ‘dml_rq_dlg_get_dlg_params’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_rq_dlg_calc_314.c:991:14: warning: variable ‘scl_enable’ set but not used [-Wunused-but-set-variable]

Get rid of it by removing the variable 'scl_enable'.

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 .../gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
index d1c2693a2e28..ea4eb66066c4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
@@ -988,7 +988,6 @@ static void dml_rq_dlg_get_dlg_params(
 	double hratio_c;
 	double vratio_l;
 	double vratio_c;
-	bool scl_enable;
 
 	unsigned int swath_width_ub_l;
 	unsigned int dpte_groups_per_row_ub_l;
@@ -1117,7 +1116,6 @@ static void dml_rq_dlg_get_dlg_params(
 	hratio_c = scl->hscl_ratio_c;
 	vratio_l = scl->vscl_ratio;
 	vratio_c = scl->vscl_ratio_c;
-	scl_enable = scl->scl_enable;
 
 	swath_width_ub_l = rq_dlg_param->rq_l.swath_width_ub;
 	dpte_groups_per_row_ub_l = rq_dlg_param->rq_l.dpte_groups_per_row_ub;
-- 
2.40.0

