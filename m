Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07586CCCD7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 00:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjC1WKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 18:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjC1WKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:10:09 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843F6270B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:10:07 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-17e140619fdso14293138fac.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1680041407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMy24C/CJcL1RyDSHpFHuRxO0kvwZUu109+roAxOPvo=;
        b=wxQsMiagHFYlELTncl0hVTUbjRXDTYyc0shHS8KtaDM9gucPXxqsiP5rlVSKWZ9NZn
         o30RV+ztg5Jgevmjti145HOT0cI+vZGnuvDK8RizrBkp0woDIK49oY87qFabeAMij/0R
         FUZWqbBzU6C33hlLHTRpYNJlxNuaSgKFgfcnvOlpBagpHaYpTa9cEGouuz8enCLlYGk6
         g+LkeoO6UocTqpTHJ/4YIm3WugYUN+BlZmDgnZT55SahWZ1xFO7+LUEmv79sjuQmKLdc
         QaVcILCHIwgUyjO+cfztirPbx3dgoJJ4kAwez0dm631znIcTeZ5sel8n0azV1RSFlkXO
         ltWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680041407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMy24C/CJcL1RyDSHpFHuRxO0kvwZUu109+roAxOPvo=;
        b=L8t0ff4tPLnZYLYN2Dre9I6eEJKXhwGCB7/K5uOotYyaArV7U+26pQRGr3f49vupBo
         r9bx4aC5NfUEP0s989l9GGdax7SHXgA1LbxMFMC4uHjf7jjQNE7U/iSpLMfdKqGdon84
         yfIZgUhcpC0VSFFWiwocrOcUSZn+chBncTscdeJ5LFhcE1f8MKPPDwPShELQhCLhaS0i
         YuWFgmGfkvbh+7Ik6V1Ct8egJPUd1KK1Ubo4noyUf2ZKEmpjsHrR7LENv1tBaLBiYhAM
         3K6S3vLsMYyCPSQPPKhzD33kia1XeuDzP1oEUDMDQ8pmIEsNdh9l0VeO9Ol2boQ7Ve56
         AtAQ==
X-Gm-Message-State: AAQBX9eMTbP5nApJOAfohOS5uJrR4y4BA6eTvulwB+OHH/SQZy3+X8AK
        OBmEg3FEonfdE+tb/IwWU1YAHw==
X-Google-Smtp-Source: AKy350aJnaHV5C1f+VmPzg7uN9QmuXGUTkdN5gRu4FDHIoqC0Av0XrBR+egsb2rAmrDRVizrVOri0w==
X-Received: by 2002:a05:6870:2194:b0:17e:cb7:29c0 with SMTP id l20-20020a056870219400b0017e0cb729c0mr12101988oae.13.1680041407250;
        Tue, 28 Mar 2023 15:10:07 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
        by smtp.gmail.com with ESMTPSA id ee39-20020a056870c82700b0017299192eb1sm5400446oab.25.2023.03.28.15.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 15:10:06 -0700 (PDT)
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
Subject: [PATCH 2/2] drm/amd/display: Add previous prototype to 'optc3_wait_drr_doublebuffer_pending_clear'
Date:   Tue, 28 Mar 2023 19:09:47 -0300
Message-Id: <20230328220947.108188-3-caionovais@usp.br>
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

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.c:294:6: warning: no previous prototype for ‘optc3_wait_drr_doublebuffer_pending_clear’ [-Wmissing-prototypes]

Get rid of it by adding a function prototype

'optc3_wait_drr_doublebuffer_pending_clear(struct timing_generator *optc)' on drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
index fb06dc9a4893..2e3ba6e2f336 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
@@ -331,6 +331,8 @@ void optc3_lock_doublebuffer_enable(struct timing_generator *optc);
 
 void optc3_lock_doublebuffer_disable(struct timing_generator *optc);
 
+void optc3_wait_drr_doublebuffer_pending_clear(struct timing_generator *optc);
+
 void optc3_set_drr_trigger_window(struct timing_generator *optc,
 		uint32_t window_start, uint32_t window_end);
 
-- 
2.40.0

