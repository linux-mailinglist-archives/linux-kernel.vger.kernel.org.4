Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C349A6CB27C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjC0Xey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjC0Xet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:34:49 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43E426B6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:34:41 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id y184so7697665oiy.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1679960081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IwF6Kj9QYhpJPxCrtGOCcjZaHDRHTEbDHEOQ0Q0o5c=;
        b=jfYnm0x5boN6VyBUnMWPRzz97xGu/bVZkk8ot1nSNhbtqM525wpnumuPPxj2g6SBmt
         iqmmB2Tb3gG2gIqDlHDVBtcb5bLSyxASg2JlHy4W5rzyjFd0wER0kSIGXZ7mUjS5562+
         4imgqjAZwoauhGi0X9/tsjF17nKL8f44lyAP2Z9q8WVM+VVX4Mrf8rvcYLk8k6Yypltz
         55syccSk7F6t6/C4ZpQlbrqQ+AQDGC3FjX9vijwQatYhvkvfGErtohIi3PnBdcogv/Fr
         i1LAISm1WjJdeH7GRdOWbnkEjnvTOG2OW2321C8y6x5FfqRTcO49qcGEIHuN8EzxTkpx
         KDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679960081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IwF6Kj9QYhpJPxCrtGOCcjZaHDRHTEbDHEOQ0Q0o5c=;
        b=wmJFl4wS9l1lKxUjvAXohLo0EBFRBslE3ltooqYOAL8B0TbTKgmhMNWZen7T6SbIGA
         1Ns8aLxfoUitgAAEw3QT2fQXThWjp+/LBzg+FBzrl92EnwWMHW/VHzIfLzhtL0Ulm2tf
         1FVkgXAOeBPpKRtJEn3eQhG3QNzFwYrAz3fcOArD9TltNAIbSuQ9+PthXtmjzQkkNfSF
         a6sBKdwLw4mHijfQuxAsKjbhB142hE3Wp5uzG0hPrcJ2/+zZmRdGa91qMS1THIDesB55
         +CLPZWYB++kKdno4W8NZj2X9nc2bEYTqcgMOafDRm/Zgsdhh9zpE6j0YRm+CEQHGGYbH
         +8lA==
X-Gm-Message-State: AAQBX9e5WIiOPN45++EOVEMcNE03KnXh1bAqgV0EZtam6s2Pg9YNMHd3
        Fum55vONnlXFVpHHARCmCMDrHA==
X-Google-Smtp-Source: AKy350amlW4hmJ5oi6zfnFlDhNs8qcwQpjdMENIe7wdz31yjBqJqQIgig25+IFqaAxHNxlomgZLO+Q==
X-Received: by 2002:aca:2b09:0:b0:389:4f27:9e0 with SMTP id i9-20020aca2b09000000b003894f2709e0mr676851oik.26.1679960079586;
        Mon, 27 Mar 2023 16:34:39 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
        by smtp.gmail.com with ESMTPSA id b186-20020aca34c3000000b00389295e8424sm1643409oia.45.2023.03.27.16.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 16:34:39 -0700 (PDT)
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
Subject: [PATCH 03/12] drm/amd/display: Remove unused variable 'pixel_width'
Date:   Mon, 27 Mar 2023 20:33:44 -0300
Message-Id: <20230327233353.64081-4-caionovais@usp.br>
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

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.c: In function ‘dpp201_get_optimal_number_of_taps’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.c:188:18: warning: variable ‘pixel_width’ set but not used [-Wunused-but-set-variable]

Get rid of it by removing the variable.

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
index f50ab961bc17..f8ffc06593b2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
@@ -185,12 +185,6 @@ static bool dpp201_get_optimal_number_of_taps(
 		struct scaler_data *scl_data,
 		const struct scaling_taps *in_taps)
 {
-	uint32_t pixel_width;
-
-	if (scl_data->viewport.width > scl_data->recout.width)
-		pixel_width = scl_data->recout.width;
-	else
-		pixel_width = scl_data->viewport.width;
 
 	if (scl_data->viewport.width  != scl_data->h_active &&
 		scl_data->viewport.height != scl_data->v_active &&
-- 
2.40.0

