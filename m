Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED3673DE7A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjFZMHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjFZMHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:07:36 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141CCE43
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:07:35 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-262fa79e9b3so234844a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1687781254; x=1690373254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dsWwmk/RTc3MCrJdzjtuf6nawuzuNbHJKPGxRq8Ztoo=;
        b=VjdPYhzkhXM3bRJ+9tVCTvwJrS6rzB7mH5eGuTvD2Vh0bA9Si8efDAFhm3BNUPvY/O
         qAS0HGM5cMsULL9Fku+QCYiIDV6QiFtpPQfA8m3JQxO7quOf/jwxGbIjD1Rf25qz/TgD
         TvBkEhak5g1o014HV595HoFzL3I4qSrA7QYwq7FGhJChqVFwq26xsg1X5AbTAey3QkEv
         KlrMzkmA/Kp1CMHrgxO/mk4g5wBk9jixgE69m3RuQkmVxENu0xtMH4yqkPHEEorBxlsd
         R9AJdYFBTqdmuFeHkVdCyozCCgxM4itmuoRQkyyJlpg6oRjuS7A+qqECK76sKtR2mPzn
         luFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687781254; x=1690373254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dsWwmk/RTc3MCrJdzjtuf6nawuzuNbHJKPGxRq8Ztoo=;
        b=CTSEqDfKQjHkv1HAhWkbo3f4WMGWn2tQMW0Mky0wx52bO4P6b2AUmsy9vBsjiXb2Ma
         eV3md8wVvuxJ6ELiN4L0/Kd7racB26xcxRzK8umw/dEXlH/VVjGpknBJiRegd3kTv5V+
         6X+SiEhLZ3K7J/H25jmhoH0lcIelngX6NI0GAmNmjXkh8CdObB3+KQMp/c5fb4UYgU+s
         Xi5Rpr4OALwUs3kZACeyOhuJPXaPEfsUfXddoEmUUBoQSWagJHzHAaKR0GA+JEmibR53
         QmOmOBt8epHFiDBCxk1yB10PTYV6ZSu1xUHjBk8jORUB2C2xgz4S0FOHjLQGWQpmvIaj
         nbeA==
X-Gm-Message-State: AC+VfDwY04RRK6nSc3E9tdyI6ZIfzHLqbipszOyWhabr9EIneJY0TvNt
        eYM8m58IjDfqFXhHAPVzr4rCdg==
X-Google-Smtp-Source: ACHHUZ6Lv+/DVcuw+jeotefNu+yXcBEbRRTnoBocuIPtCLcr2QrLO+/6BWN1wJO2vGsKNXh9ncDknA==
X-Received: by 2002:a17:90a:1a03:b0:262:ce8f:a3e with SMTP id 3-20020a17090a1a0300b00262ce8f0a3emr2070091pjk.42.1687781254513;
        Mon, 26 Jun 2023 05:07:34 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.205])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090aea0500b002532ddc3a00sm6010021pjy.15.2023.06.26.05.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 05:07:34 -0700 (PDT)
From:   Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To:     sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        airlied@gmail.com, dianders@google.com, hsinyi@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH] drm/panel: Fine tune Starry-ili9882t panel HFP and HBP
Date:   Mon, 26 Jun 2023 20:07:24 +0800
Message-Id: <20230626120724.161117-1-yangcong5@huaqin.corp-partner.google.com>
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

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
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

