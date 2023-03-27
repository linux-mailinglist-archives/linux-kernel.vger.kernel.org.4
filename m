Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BED6CB280
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjC0XfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjC0XfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:35:13 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718A2272A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:35:00 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id bi31so7682658oib.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1679960099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZvChWzT9y/5zLeIHf5uAQzD/BtvkDRJ3FwyLW2ZaHk=;
        b=wm7ahbRIhc9RvuZcZDoeymhlv3zgD7q8vtlddoiFgyPuYrCF2UQHw1qVFatPY38lbk
         L2MDcqf4eFfFC9CD4fkQf+dipCiiaXWG8ig6gj/1+WLjtVv9dPoPoWUW0OdVyljtevBj
         P1tAYeCjhmjGlaaJoO3h1AsREJwGADm4oAyEWnyxhNQmZEp/yuGqEhppic9GwJ497+6m
         cdfMze0NchXZo6iFtJ+LC4Uj2Wt37hP+m0Yhw2h11qHaiAf+GKNcfNcWz6Vr8UPFQ20/
         qqdrotLRu9N+cgoUH8F8M74KXSdu7eKJD2CI9iaISd9WZdaUnoQcd733g9l1a2Q1kQib
         AJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679960099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZvChWzT9y/5zLeIHf5uAQzD/BtvkDRJ3FwyLW2ZaHk=;
        b=5+qZo9ndILh9ZvpC3jp9ki3OW1AYzDs9kh+AsSIC1Xx4Fn6cFaq2Fx0H42WJM9KBbG
         zA/0EWKmqnBPanKz9PL0194cip7KpcpMTO6MkXo6SMYbbkiScR5elxBzSx+HzI/Ylxk3
         FMBpZ72H2R+9uBldMfBa/qOD7vVGJG/LZu/nWSnqunUNtc/L7QZbfs4L67utmpDI5gIK
         ap75/jZDZaMjpQdycbOZs1h8pS1sj5jCy8C5ZNsoTka7ebvPOfyTAqB9u5odIjFNGrP+
         4q7WAyQ4m18ycs8Ow9T/mAMW4Tnpgh9NcjFcDkxAffX5xxojW22IzJG5Kl9B6BoCIeIJ
         dhFg==
X-Gm-Message-State: AO0yUKVcN0E9d84MjS5Z/hvOi6ZzXlXv7uvNJMlTbaKPgI8EOiXtIfcs
        qHj5Admdp1s2WNEyU7FrLfOELw==
X-Google-Smtp-Source: AK7set/8tjEH59vf8bLWrjpQFwfi5OJxvuo18LnQL3tRmSwfL7lkONT3v+KQNmF/JKJ6LyaDvpfYzA==
X-Received: by 2002:aca:220a:0:b0:387:3a49:4733 with SMTP id b10-20020aca220a000000b003873a494733mr5203770oic.59.1679960099653;
        Mon, 27 Mar 2023 16:34:59 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
        by smtp.gmail.com with ESMTPSA id b186-20020aca34c3000000b00389295e8424sm1643409oia.45.2023.03.27.16.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 16:34:59 -0700 (PDT)
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
Subject: [PATCH 05/12] drm/amd/display: Remove unused variable 'speakers'
Date:   Mon, 27 Mar 2023 20:33:46 -0300
Message-Id: <20230327233353.64081-6-caionovais@usp.br>
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

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_afmt.c: In function ‘afmt3_se_audio_setup’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_afmt.c:126:18: warning: variable ‘speakers’ set but not used [-Wunused-but-set-variable]

Get rid of it by removing the variable.

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c
index 95528e5ef89e..55e388c4c98b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c
@@ -123,7 +123,6 @@ void afmt3_se_audio_setup(
 {
 	struct dcn30_afmt *afmt3 = DCN30_AFMT_FROM_AFMT(afmt);
 
-	uint32_t speakers = 0;
 	uint32_t channels = 0;
 
 	ASSERT(audio_info);
@@ -131,7 +130,6 @@ void afmt3_se_audio_setup(
 	if (audio_info == NULL)
 		return;
 
-	speakers = audio_info->flags.info.ALLSPEAKERS;
 	channels = speakers_to_channels(audio_info->flags.speaker_flags).all;
 
 	/* setup the audio stream source select (audio -> dig mapping) */
-- 
2.40.0

