Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701E86CCCD5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 00:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjC1WKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 18:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjC1WKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:10:03 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67002701
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:10:02 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-17e140619fdso14292931fac.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1680041402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dENL6Fxh5VQz27gw9oq+gG40WY6+FnIBbbcwaGKgL9s=;
        b=TeGGZ62mzEJyrUfX2ccRVZT3lPsNRHD9em3zwi4/mVr57wvmJPnxMVbCVaDDnwBq+R
         0JlVMx2YMAHbMeDCtDSmZ2G3ZR/AwgySjiUjUeAdwq2e7KUotHbJp3Z4yVXKqOgPTlHs
         hSTVwV19mvw1ppeuvuL744Z9QHua2JZOGhyIiQr3xYCrTcm9uC0GbtCe7ESiajbDsOmy
         9V2QALBsInqyI0JmYh69SXZknkNXiLEWXwCNnYA6iB1idT7eGTGdhMeujRblcrSPHZvx
         t28AyK5xmtrASoQ/MHUUVdoZ1BGTwRWk2gxQRR64RUTKeKPSHeIVW7fp8y+8FeR3o8bQ
         AxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680041402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dENL6Fxh5VQz27gw9oq+gG40WY6+FnIBbbcwaGKgL9s=;
        b=zum4zDw6QaqeyUtmkV60/gFUDRkTGZ+KtDVHMEYy1OQfhllszqFp55xmzP5uAcuWD0
         IjNmnQEIkBD0rFZZrRpavWRQIAAax4kUevzLlvZTu8mimlkiTLDTg7mpi7aTUhrKX70r
         OR1eD990DwAcJyupF6bEp5qGePGlb3UokYTU64g3EwrtpRYRi9bvCjkgAIwIN3grCV9r
         8wGTTHUhtluIsoP5gJyiEsJn8xDHnLxODOD8nsQV4upyuOwpC+cAkn1offOOW+lNvV5Y
         AT3VtqZY+CrrsONeE5qXMfHNQ7wTDGX2Lo/BINzzZLPFzr9e5fT13R9imqC6UVRDjPvT
         eoBQ==
X-Gm-Message-State: AAQBX9fWTpSNAy4Zf4JdIzRV/BpcRTYM8k2x3K4ZackcNkxw5qzWzMzB
        OZ4xQSXZC9Dql+0r8lcsgndUVg==
X-Google-Smtp-Source: AK7set/9hzzNUuU4Kkf2sFIlf9BTfuvoZJiOF7XASZcYaJwHgZ1p9n84Nr1VJ/l7iON+8pPL6KWGDg==
X-Received: by 2002:a05:6870:32d3:b0:17e:cb7:29a3 with SMTP id r19-20020a05687032d300b0017e0cb729a3mr10510460oac.15.1680041401995;
        Tue, 28 Mar 2023 15:10:01 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
        by smtp.gmail.com with ESMTPSA id ee39-20020a056870c82700b0017299192eb1sm5400446oab.25.2023.03.28.15.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 15:10:01 -0700 (PDT)
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
Subject: [PATCH 1/2] drm/amd/display: Remove unused variable 'scl_enable'
Date:   Tue, 28 Mar 2023 19:09:46 -0300
Message-Id: <20230328220947.108188-2-caionovais@usp.br>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230328220947.108188-1-caionovais@usp.br>
References: <20230328220947.108188-1-caionovais@usp.br>
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

