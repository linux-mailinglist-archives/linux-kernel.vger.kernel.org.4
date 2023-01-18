Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E66E6719E8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjARLGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjARLFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:05:16 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B0038B42
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 02:11:42 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e3so24157958wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 02:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X9erqJru4XPgjOURANw2ncUgTgC8yFwhYsbY0uUOyl8=;
        b=aetc572Jkz81PofCbQdsfwcHdm8KluXPcZ6+I3ifpv1I/B3j4TBDMH2yjxmIxMAS9R
         JPeU2+G7hMcQXLsi07akridWxfeGElEi5Yxty1YIXhnbocYaQvn7ClpsEsdS8wjILVAF
         EmzEdq8u1Pn2LB939plEC4a7yRmCG79QXq2eOeWlz3N9stVyj8iCv6HTbJfdvmTptLvF
         1FtOpZ78FLu30c5aPtEeXTTTtgO03BDjT3U+RRrof24v8ktVT/+Q8AvdOMkKpjehrrug
         +Cr3mbbMIi7LMfR5p0WTyE5dEKPBAVNfh1syL1wW6rd9WoiJtVdoFfWe5kHYFGzHpGBQ
         axtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9erqJru4XPgjOURANw2ncUgTgC8yFwhYsbY0uUOyl8=;
        b=pzLD3E2D9/AyeX97r7OckeKdyybo91bUe6jtND/3AwGH4bh+kcuJ6lpllgZ69bxo7n
         SLgmHNuEcw/zB6N0pXjL69oUVN2e5isRQ/8/6nj1pgrC4ijKI/sR9lBtCd6+zLIdGoAd
         3qgtujn5nK+4IIgJGjREInCpdVy7iW3LzeDwW6Xm1RPyOrZlXqSChjcXbDdyb+3js9AH
         NjM25aS09qUwyBEiit0f7P/4VxPel/YuVF8aXvMGDxtYAK741VGIfl1hG8wk+c/LbQ0G
         wqmbW9X2+1LAFnfviDQFbKUwVxTDAdSViBmV6Fo799Bo/ASXc006eWlm7dhEHq3UBA8o
         wo3A==
X-Gm-Message-State: AFqh2ko4W3HS29AzUzs0/Wx4jTM0kmfOkxRFDpSBGMo5kRE5g9Y2PxN2
        6/aGpVAYvY9UpgqtMnPQ7EhU3PmAca8CH6Bs
X-Google-Smtp-Source: AMrXdXs/tYTCR9qwFQpShs1CcYyu71qYkTmhz7D33Q/9wLUaLCCGuYZGvTol6zaRTTnGbS8z7gCe9g==
X-Received: by 2002:a5d:5608:0:b0:2b6:daf8:52ad with SMTP id l8-20020a5d5608000000b002b6daf852admr1567589wrv.52.1674036701073;
        Wed, 18 Jan 2023 02:11:41 -0800 (PST)
Received: from localhost.localdomain ([93.119.166.152])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d6152000000b002425be3c9e2sm30323113wrt.60.2023.01.18.02.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 02:11:40 -0800 (PST)
From:   Nicu Borta <nicuborta123@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Nicu Borta <nicuborta123@gmail.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] amd/dcn20: Fix high mem clock with multiple displays
Date:   Wed, 18 Jan 2023 12:11:08 +0200
Message-Id: <20230118101107.10173-1-nicuborta123@gmail.com>
X-Mailer: git-send-email 2.38.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On RX5000 series GPUs, using a high refresh rate monitor causes the VRAM to
always stay at the highest clock (according to AMD, this is done to prevent
flickering).

However, when using 2 monitors (e.g. one at 165Hz and another at 60Hz), then
disconnecting the high refresh monitor, before this patch the VRAM clock didn't
decrease like it should.

This patch fixes that bug, and now, when disconnecting the high refresh rate
monitor, the VRAM clock jumps to the minimum.

Tested for a few months, I haven't noticed any visual artifacts or other errors
(RX5700XT).

Signed-off-by: Nicu Borta <nicuborta123@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 8a0dd0d7134b..481a15b02126 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -714,7 +714,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.timing_trace = false,
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
-		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
+		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
-- 
2.38.2

