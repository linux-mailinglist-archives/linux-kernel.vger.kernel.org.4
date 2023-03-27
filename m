Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8076CB293
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjC0Xgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjC0Xgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:36:45 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FFD2D59
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:36:13 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id y184so7699770oiy.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1679960170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMjKJJljMmxLa3Ljhxg1VmcGN3uGAZRfG7BjQI50ULI=;
        b=yZcXL9yyvDZKCVJzbqsl/6xiSdbujypjw3qnCm+WCPI+oYss4rXX79NJb6EhbtXhp5
         LYJdAEiuKIwajKd2vSdA8Vsn+SLgotaZnv312ScdaCXG6RSNfhjqzidGZ5FaTWmOddcu
         UqsdHJyw7JByhHBlwA+ANsEOdFyhKPDFuKMOTDQZxeEmDeFBVCSDD74RXqiDfE4TlQV+
         sTpfn15kjRl3szo+IakedBOdd3wUF6wP+o07P8dSqHEkdd5/zmw/xhwmhb9f3Jl9QUvJ
         nKqDWBehFY5QznZ12WccPFZIrMinZI+bzFXpCrPzOj+NO8w+KAs7YglMRg0fwMJgGOPy
         pFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679960170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMjKJJljMmxLa3Ljhxg1VmcGN3uGAZRfG7BjQI50ULI=;
        b=T2qjHIIxbp1vK+ZhRheFzBxk/ZLh4nIq+LH4HuP2GVMc4SSpiReubG7IKqCJLtCa/I
         3vFcTzVmnQrhouiqutC0Rg5UzbB10Jg5F7BUwhxStzLvxQYP+dG2urklt37DHFzLkygj
         BGRhoiePzxOZSK0VVkgP1tMUTmC+gHziC3ITRmIpV+FQac/+6psLxlUfVzCs8zAJUroa
         ek2SuJLJV2aEsTMp4pM2V5cAZAEk+kq69Lhfdh+uq3yswC/qQZSzKCsWKzkmp8OfX2dC
         wxXXAkOi7Yq8FNVWB5To78meRpzrWXEF1OTjiFAfpRhvnDyGuPn4o7CCz+BEW6fMQZPn
         Xkqw==
X-Gm-Message-State: AO0yUKXaGy3lbODCvCHiKOtZ+kgAnYK3BE/V5UWKwu3OFIytY/qqTqgf
        aQzb9rHBTgjsiUQNTvssPHE0FgPZQhA+RbL2RFKzpA==
X-Google-Smtp-Source: AK7set9oAz6sAJk9i+Yr1zEBONLpWWppxu2w98hCDmfDs6XKH+G2nHgnPlqdPGuqAbSZfcMHN2iseA==
X-Received: by 2002:a05:6808:7cf:b0:383:f04d:5d41 with SMTP id f15-20020a05680807cf00b00383f04d5d41mr5941639oij.59.1679960170022;
        Mon, 27 Mar 2023 16:36:10 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
        by smtp.gmail.com with ESMTPSA id b186-20020aca34c3000000b00389295e8424sm1643409oia.45.2023.03.27.16.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 16:36:09 -0700 (PDT)
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
Subject: [PATCH 12/12] drm/amd/display: Remove two unused variables 'result_write_min_hblank' and 'hblank_size'
Date:   Mon, 27 Mar 2023 20:33:53 -0300
Message-Id: <20230327233353.64081-13-caionovais@usp.br>
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

drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capability.c: In function ‘dpcd_set_source_specific_data’:
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capability.c:1290:32: warning: variable ‘result_write_min_hblank’ set but not used [-Wunused-but-set-variable]

Get rid of it by removing the variable 'result_write_min_hblank' and 'hblank_size'.

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 .../drm/amd/display/dc/link/protocols/link_dp_capability.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index d4370856f164..7392fcf17653 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1287,7 +1287,6 @@ void dc_link_overwrite_extended_receiver_cap(
 void dpcd_set_source_specific_data(struct dc_link *link)
 {
 	if (!link->dc->vendor_signature.is_valid) {
-		enum dc_status result_write_min_hblank = DC_NOT_SUPPORTED;
 		struct dpcd_amd_signature amd_signature = {0};
 		struct dpcd_amd_device_id amd_device_id = {0};
 
@@ -1324,16 +1323,10 @@ void dpcd_set_source_specific_data(struct dc_link *link)
 		if (link->ctx->dce_version >= DCN_VERSION_2_0 &&
 			link->dc->caps.min_horizontal_blanking_period != 0) {
 
-			uint8_t hblank_size = (uint8_t)link->dc->caps.min_horizontal_blanking_period;
-
-			result_write_min_hblank = core_link_write_dpcd(link,
-				DP_SOURCE_MINIMUM_HBLANK_SUPPORTED, (uint8_t *)(&hblank_size),
-				sizeof(hblank_size));
 		}
 		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
 							WPP_BIT_FLAG_DC_DETECTION_DP_CAPS,
 							"result=%u link_index=%u enum dce_version=%d DPCD=0x%04X min_hblank=%u branch_dev_id=0x%x branch_dev_name='%c%c%c%c%c%c'",
-							result_write_min_hblank,
 							link->link_index,
 							link->ctx->dce_version,
 							DP_SOURCE_MINIMUM_HBLANK_SUPPORTED,
-- 
2.40.0

