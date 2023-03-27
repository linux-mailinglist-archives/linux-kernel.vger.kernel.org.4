Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9946CB26B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjC0XeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjC0XeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:34:14 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7EC186
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:34:11 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id l18so7673564oic.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1679960051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vbzg6klph6Te7iP3dSPIgG+vur+g/ph0Zdn9JxzzG40=;
        b=mcQCDHjIc1z0MV59hCiOPGbf9ypVcTa63Zwj9+4vczjxJ6xemxCHmB/bdG09R3ulGk
         wBRb0c4NRKQIeZ9AmKn4cZ2/cFiH43pbFxCU+Xwm10+2LXyU5IjgKYxYNni8iIny2BPJ
         Uyr5muaupR7SGOpBiiBp1e6Xl+GGq0CmFO3dc10hLq2qt7VhnOQk2AJ+iHp9AXHIRwtm
         NfAZ1fiK7syP88hnm8TuaCtSHzva6H/mfeVe+aCvNEeLItolg2ox+I9LK8+rwppC0E4X
         9Wxs02kRtS2zhYkR/OGYEL/mZEdqfxZ29EIIZi0qzdkVJ30c88TyYqgnmei/AGim0NxW
         27Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679960051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vbzg6klph6Te7iP3dSPIgG+vur+g/ph0Zdn9JxzzG40=;
        b=oyfXbPQ1FWMCAL9ux7ZsfRQYfiCzni6NkQt2D4Cxwlr9Lfb37F8egZULK3nTaCq21X
         FOoK9mBURraK8LouPsXD4lRq8cU4E/XMuNJupxlnRXmWeU6LZFpCD/ERri0WXSD6z4HS
         1Hc0TORD+PnN8TL8EENT2/T3F1kagf0fgtEdGZSDiuyn3OChp5lgSNn9x+n2868mz13/
         vue7f82tkjMmom4adiMLdJHiIGKVUs3Sd+/Yr8c0ya+A3/wTzcQZUBOS7TUQxvf3XVBt
         v/GRr06DzWdNK2TnT3+BSyXwFY5BUK563mXHtZhH1NraldJBjyCANLcoV5KRYdYmOFBa
         Bczg==
X-Gm-Message-State: AAQBX9dSdyQpVS2FGaCp8oEXV1zBoxZkwgnfi38S5biABf+Tov5NrxgO
        DhIiz6kZtN3KEj3KEm1uYiM/uA==
X-Google-Smtp-Source: AKy350aksGEh2UFglgdrglLJ3Yf7o8c/xLC1c9h/rH18JSGJMJx2XpH4So8mvyXTcj3EdZ87KQZm9Q==
X-Received: by 2002:a05:6808:1386:b0:389:4d2f:1c23 with SMTP id c6-20020a056808138600b003894d2f1c23mr1162500oiw.29.1679960049461;
        Mon, 27 Mar 2023 16:34:09 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
        by smtp.gmail.com with ESMTPSA id b186-20020aca34c3000000b00389295e8424sm1643409oia.45.2023.03.27.16.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 16:34:09 -0700 (PDT)
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
Subject: [PATCH 00/12] drm/amd: Remove unused variables
Date:   Mon, 27 Mar 2023 20:33:41 -0300
Message-Id: <20230327233353.64081-1-caionovais@usp.br>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset cleans the code removing unused variables and one unused
function.

Caio Novais (12):
  Remove unused variable 'r'
  Remove unused variable 'value0'
  Remove unused variable 'pixel_width'
  Remove unused variable 'hubp'
  Remove unused variable 'speakers'
  Remove unused variable 'mc_vm_apt_default'
  Remove unused variable 'optc'
  Remove two unused variables 'speakers' and 'channels' and remove
    unused function 'speakers_to_channels'
  Remove two unused variables 'is_pipe_split_expected' and 'state'
  Remove unused variable 'cursor_bpp'
  Remove unused variable 'scl_enable'
  Remove two unused variables 'result_write_min_hblank' and
    'hblank_size'

 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  8 ----
 .../amd/display/dc/dcn10/dcn10_link_encoder.c |  3 --
 .../drm/amd/display/dc/dcn201/dcn201_dpp.c    |  6 ---
 .../drm/amd/display/dc/dcn201/dcn201_hwseq.c  |  2 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c |  2 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c |  4 --
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  3 --
 .../gpu/drm/amd/display/dc/dcn31/dcn31_apg.c  | 39 -------------------
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  4 --
 .../display/dc/dcn32/dcn32_resource_helpers.c |  4 --
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |  2 -
 .../dc/link/protocols/link_dp_capability.c    |  7 ----
 12 files changed, 84 deletions(-)

-- 
2.40.0

