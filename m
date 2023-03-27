Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4056CB274
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjC0XeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjC0XeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:34:22 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364322129
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:34:20 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id r84so6413123oih.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1679960059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATSF4wL+BzdBMa6MQ9WEbv1t9xTPovSyTP8ALVjMP/g=;
        b=jjeTndIjow57RXIs03XG4zTCjcQS7/ijT5BWQdjbh4qY+GsQ5sYgm1M7PfuUXOSubb
         RrcSC2LSZIQfp0531wAMUZRsj1uVKqOISsBGGNSY5U6pNoa1kNuv43aD/NYjC6A0KQAw
         NT3ZDNcHFzDJJVeOAgZLF9F0vKbnjWCpGSlH6vBP4QDYysI59nc8P7J+kUnT8x4lBZJp
         FYbdsN9mU0vDTXG1HHo3ScuOB+bDR2fxQyorBOuoG76lU68szVA2oeX+KQjILaM4guk7
         /vn8xua0wWVLPjP/ShDuq9R6Lij2bknq4mBHwqNGQM7y9Z7y1F/u1tIdneevves42NeF
         BK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679960059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATSF4wL+BzdBMa6MQ9WEbv1t9xTPovSyTP8ALVjMP/g=;
        b=Om+YlFIoMN5Vk5wG+HpF8jphXCTJrt/JVEPv6QuLTshYXVliAjajMxgrhjC4G06esL
         HH5y2vWcv8t/YGij8Zzqvad7uHI7dpXQRNOAkgZYladE4WYUlA6zzCcs8+HAthwyWsUH
         P1yBJbbai66EWUmS2A/yFQcgKFA5OKbuWyx/e4MjpNq4tmgtCfiC0M+p0EXCB5CV5GJc
         DpMQ1EMhTnRFENXoQ6WCxBVAR++zGoCIVpGGl1KD6su6sANVoydcGgUs5G2K7DMpC14j
         WLql2mOHkhz9T0y2Ap1t8jeuHytcMhZLAZBdHoP0XhaGY4E/UIB/TjhX2LhgdogpCz7C
         OX6g==
X-Gm-Message-State: AO0yUKULKCq1uXbxMHx/TR8HEacpPmWRZxoUTnExJ6rQcmlPcSQubh2w
        Re5K6y+N597Vnj0WF74wqhZwug==
X-Google-Smtp-Source: AK7set9DW5uNG3ER+wZDWGxBetFSD6HDWjyxXA+KWrXZQuX9MkweyGj2xhoBwNRWBg7ILEXEH0kkjQ==
X-Received: by 2002:a05:6808:b22:b0:383:f572:2646 with SMTP id t2-20020a0568080b2200b00383f5722646mr4940712oij.5.1679960059520;
        Mon, 27 Mar 2023 16:34:19 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
        by smtp.gmail.com with ESMTPSA id b186-20020aca34c3000000b00389295e8424sm1643409oia.45.2023.03.27.16.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 16:34:19 -0700 (PDT)
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
Subject: [PATCH 01/12] drm/amd: Remove unused variable 'r'
Date:   Mon, 27 Mar 2023 20:33:42 -0300
Message-Id: <20230327233353.64081-2-caionovais@usp.br>
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

drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c: In function ‘amdgpu_mes_ctx_alloc_meta_data’:
drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1099:13: warning: variable ‘r’ set but not used [-Wunused-but-set-variable]

Get rid of it by removing the variable.

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 82e27bd4f038..e0130536f778 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1096,14 +1096,6 @@ uint32_t amdgpu_mes_get_aggregated_doorbell_index(struct amdgpu_device *adev,
 int amdgpu_mes_ctx_alloc_meta_data(struct amdgpu_device *adev,
 				   struct amdgpu_mes_ctx_data *ctx_data)
 {
-	int r;
-
-	r = amdgpu_bo_create_kernel(adev,
-			    sizeof(struct amdgpu_mes_ctx_meta_data),
-			    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
-			    &ctx_data->meta_data_obj,
-			    &ctx_data->meta_data_mc_addr,
-			    &ctx_data->meta_data_ptr);
 	if (!ctx_data->meta_data_obj)
 		return -ENOMEM;
 
-- 
2.40.0

