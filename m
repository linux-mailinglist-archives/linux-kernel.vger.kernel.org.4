Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AE66CB290
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjC0Xf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjC0Xfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:35:54 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943982D48
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:35:30 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id w133so7710013oib.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1679960130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUkta+0S5SLkoZECV+gOZOOKUmxnKipm+UrOigNAFFk=;
        b=swJb8KVfeXLvtuIhEIeBE9NbxPQxoD9VVnzPlKqChCd6u3oKt2nYGhQip4wsSdXnlJ
         jy4oScaGOmGE/uhRqfkOwL/RWknbsB9S60gJG298OwojfzpZLrOsoRlH61rPhFFJiuta
         dWDWYo+kOd572NhZl5aYIYYGL+W6RhDlZ35j906H/+Z9GMS7nlX0Pp4ZekMwTH243tt4
         qNZJ81RkxI5g0r/vzzlr5AyIQBJPAaKi6tl4vRxYEsirvujARmH8IpruV76ntFA4ulpd
         xGjd2XZWA6to4BdtnP5AQ7pR6fKMoFnmiF6PkqqmB5flk0x1JZ0JvTSnf2XLJamsuZBL
         hhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679960130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUkta+0S5SLkoZECV+gOZOOKUmxnKipm+UrOigNAFFk=;
        b=0j5Te4HMnTdDZRFkxu2JRwu73xEc89Y01MhbvequOHygchdrQEWgWlceG2K3NXqMUZ
         V8nxYrs0iIFgyigmvyxblmYTS/mW4pYLPCa7bfXcaCto0c1iTD650YW/Obtd5ZDv68As
         wyLVF63PhFhs3EjCsI+Jqw6n8+diM7/pqAlouGjEDpodXosiFQK7IBfiynFCAihLpRN0
         PJ8sYFvi+SawYZz7ogDmnlekYrqZdXpkJE/kXNUUsK5X+QInGqEHsodGgDlbLSkUPu4a
         KF/WiHas/N+hCgkTXyRiQl0QC+hy7tf0Htpswa86G97Sbh14BWyTsAqQ69eO5MiiJRse
         tyyg==
X-Gm-Message-State: AO0yUKXCKsEuJYRLOhQV4bbzGIjSW2D6ED53OGii1B3GLc+S9GZV4dl8
        yrC164V57SjWP4hE4bPnqGvD8Q==
X-Google-Smtp-Source: AK7set+QyePXkuvYL4djaRZGrEn+bFJpxBVjzKR7R2A7NNFYEfpsX+JwGBSrTo3Ckjv7Q5X9M18xqQ==
X-Received: by 2002:a05:6808:634a:b0:383:febf:2a97 with SMTP id eb10-20020a056808634a00b00383febf2a97mr5828896oib.11.1679960129822;
        Mon, 27 Mar 2023 16:35:29 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
        by smtp.gmail.com with ESMTPSA id b186-20020aca34c3000000b00389295e8424sm1643409oia.45.2023.03.27.16.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 16:35:29 -0700 (PDT)
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
Subject: [PATCH 08/12] drm/amd/display: Remove two unused variables 'speakers' and 'channels' and remove unused function 'speakers_to_channels'
Date:   Mon, 27 Mar 2023 20:33:49 -0300
Message-Id: <20230327233353.64081-9-caionovais@usp.br>
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

Compiling AMD GPU drivers displays two warnings:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_apg.c: In function ‘apg31_se_audio_setup’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_apg.c:117:18: warning: variable ‘channels’ set but not used [-Wunused-but-set-variable]
and
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_apg.c:116:18: warning: variable ‘speakers’ set but not used [-Wunused-but-set-variable]

Get rid of them by removing the variables and the function
"speakers_to_channels".

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 .../gpu/drm/amd/display/dc/dcn31/dcn31_apg.c  | 39 -------------------
 1 file changed, 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
index 24e9ff65434d..e94d0ba915ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
@@ -72,40 +72,6 @@ static void apg31_disable(
 	REG_UPDATE(APG_CONTROL2, APG_ENABLE, 0);
 }
 
-static union audio_cea_channels speakers_to_channels(
-	struct audio_speaker_flags speaker_flags)
-{
-	union audio_cea_channels cea_channels = {0};
-
-	/* these are one to one */
-	cea_channels.channels.FL = speaker_flags.FL_FR;
-	cea_channels.channels.FR = speaker_flags.FL_FR;
-	cea_channels.channels.LFE = speaker_flags.LFE;
-	cea_channels.channels.FC = speaker_flags.FC;
-
-	/* if Rear Left and Right exist move RC speaker to channel 7
-	 * otherwise to channel 5
-	 */
-	if (speaker_flags.RL_RR) {
-		cea_channels.channels.RL_RC = speaker_flags.RL_RR;
-		cea_channels.channels.RR = speaker_flags.RL_RR;
-		cea_channels.channels.RC_RLC_FLC = speaker_flags.RC;
-	} else {
-		cea_channels.channels.RL_RC = speaker_flags.RC;
-	}
-
-	/* FRONT Left Right Center and REAR Left Right Center are exclusive */
-	if (speaker_flags.FLC_FRC) {
-		cea_channels.channels.RC_RLC_FLC = speaker_flags.FLC_FRC;
-		cea_channels.channels.RRC_FRC = speaker_flags.FLC_FRC;
-	} else {
-		cea_channels.channels.RC_RLC_FLC = speaker_flags.RLC_RRC;
-		cea_channels.channels.RRC_FRC = speaker_flags.RLC_RRC;
-	}
-
-	return cea_channels;
-}
-
 static void apg31_se_audio_setup(
 	struct apg *apg,
 	unsigned int az_inst,
@@ -113,17 +79,12 @@ static void apg31_se_audio_setup(
 {
 	struct dcn31_apg *apg31 = DCN31_APG_FROM_APG(apg);
 
-	uint32_t speakers = 0;
-	uint32_t channels = 0;
 
 	ASSERT(audio_info);
 	/* This should not happen.it does so we don't get BSOD*/
 	if (audio_info == NULL)
 		return;
 
-	speakers = audio_info->flags.info.ALLSPEAKERS;
-	channels = speakers_to_channels(audio_info->flags.speaker_flags).all;
-
 	/* DisplayPort only allows for one audio stream with stream ID 0 */
 	REG_UPDATE(APG_CONTROL2, APG_DP_AUDIO_STREAM_ID, 0);
 
-- 
2.40.0

