Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E995973F3D2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 07:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjF0FCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 01:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjF0FB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 01:01:59 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469D4173E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:01:57 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-54f87d5f1abso1897538a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1687842117; x=1690434117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SzyQSNcjOHsaHAZ3PAkRaxQgaQX5KwIR0vuCWz7Tsjs=;
        b=gzHwLn4wOaOazUZEEeYo+L9zcazP7Smm9v049SKuVhFXtoqg+EYTGClSovaP/9Vb2o
         0fSQHnHaOtvH12CQzhDdIkirHfMb+U+KaGRsX+6pzxyvthMOGUgNU6vW/DPiew5phLdi
         KNTDqMI6sauhG5sSAiOrGw4ylH06JxYl+MalXebD4YfXBDyFnett2QpWutcUt/dlyEfK
         tlhHU4iPQsApSq5Soag8J8AmRQ7KC596qOcYwzWEwSHyp9oVL6d8asl8SRxbtv5ure5m
         rRheczWQwipu7X90Uh/Xnb0BUJ8LKseZMpxB6FUT7nigWiY2fGT7SzeopI+4NWLr446s
         fABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687842117; x=1690434117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SzyQSNcjOHsaHAZ3PAkRaxQgaQX5KwIR0vuCWz7Tsjs=;
        b=P3KW1Y+xaX4SbLUxeH5mpHJXcJoWlnyohmk2WLaMFxcJfmVwfF0Jvi4UhIfAy6kluh
         kOGMNbCWvETyIWCZ2/3oem5cWIBiZ2J37OI9ru2uqfZEcdmXEDKLVByF/vi1Vgy2j2Ay
         fi9nM2DDSXd0g8XB6VPpBsrz/GWQnpKaoI4YzA7ApdAgLCQuJa16LkklEIWGRC2Hv2GD
         iolNSrAsIOcULesyu+0J8VhPw+93uByQ/SZjU9WbtGi9nbL8a9O9p/S9lI+NMPwfo2ve
         mBdIeO6Ny3qcd/TtBs0jVhhxxD4gwPRYBKjBXyM2ESFTe9kskPoNuUs00m+DZemob0md
         78Zg==
X-Gm-Message-State: AC+VfDxa+neeR2YLJS7oa1DPH5fV94/7YUxQ4RbgLeFJuMTIZ2P/YY/q
        kUiOkhgjl5RxRWrubNiu6JObQpE8gl+K2CkdD/U=
X-Google-Smtp-Source: ACHHUZ5Qfmqrmo0A86/0Em+JJ9L1w+W9Cm3PVuzsMFP6GWuMHwTWkdxS8Bb73PfQCgCZL9X75rojtQ==
X-Received: by 2002:a17:90b:3909:b0:262:ec71:9371 with SMTP id ob9-20020a17090b390900b00262ec719371mr4118131pjb.43.1687842116741;
        Mon, 26 Jun 2023 22:01:56 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.205])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a004800b00262d6ac0140sm4686104pjb.9.2023.06.26.22.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 22:01:56 -0700 (PDT)
From:   Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To:     sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        airlied@gmail.com, dianders@google.com, hsinyi@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [v2] drm/panel: Fine tune Starry-ili9882t panel HFP and HBP
Date:   Tue, 27 Jun 2023 13:01:48 +0800
Message-Id: <20230627050148.2045691-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the setting of hproch is too small, there will be warning in
kernel log[1]. After fine tune the HFP and HBP, this warning can be
solved. The actual measurement frame rate is 60.1Hz.

[1]: WARNING kernel:[drm] HFP + HBP less than d-phy, FPS will under 60Hz

Fixes: 8716a6473e6c ("drm/panel: Support for Starry-ili9882t TDDI
MIPI-DSI panel")
Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
v2:
  - Update commit add Fixes tag
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 3cc9fb0d4f5d..dc276c346fd1 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -2139,9 +2139,9 @@ static const struct panel_desc starry_himax83102_j02_desc = {
 static const struct drm_display_mode starry_ili9882t_default_mode = {
 	.clock = 165280,
 	.hdisplay = 1200,
-	.hsync_start = 1200 + 32,
-	.hsync_end = 1200 + 32 + 30,
-	.htotal = 1200 + 32 + 30 + 32,
+	.hsync_start = 1200 + 72,
+	.hsync_end = 1200 + 72 + 30,
+	.htotal = 1200 + 72 + 30 + 72,
 	.vdisplay = 1920,
 	.vsync_start = 1920 + 68,
 	.vsync_end = 1920 + 68 + 2,
-- 
2.25.1

