Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE63366D1ED
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 23:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbjAPWtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 17:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbjAPWtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 17:49:45 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0603425E0D
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:49:44 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id u8so14650269ilg.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WhKn9vpYj0ZxiZSSc4tqPnBzXR7eLC6wvgnbJOEQQzI=;
        b=KoEiHaFyDKGFL7NUGQ+gD4XhR37U2DYUP57cNixKU2ojj75snLWqSstDcSwABrVX3L
         +XrKiuVr8faxh50TCjhbfVGxMHN6MtFOBGlbQhFVu+KuaaMeRmzwM3DcCu4z4Dasc2mA
         fmWh1gtJTB/FXBX9mOiJwiUfv5sv9gjKrVTfW/JTVEGGQfuE/MzFIEtEFlDzRKsOcQbq
         riikEW1UhMwf1CarxcisIvbykyZDbVBElr0zW+QnKKe2jjlRoxZXI1qgYOQGUALMV1v4
         bg+G/7CCBnrVvU34fKfR/M7pY8w427NXjOMrQZewNE9G7mTEywR2fQb0aomNQHMAgyJU
         DORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WhKn9vpYj0ZxiZSSc4tqPnBzXR7eLC6wvgnbJOEQQzI=;
        b=TALDzyvWRCywBpmFxFhmv6rkg7hKj/rkl5l+29g/7tF+Xcf19W0+ke+slQDa/U17MM
         O5F/7JocJ7O/+4J0YIaNQIJN2HS+hkYf3vQ7EIPRQUHi8A/obSDB5P5z2nI2Gi8rgmMt
         taBv4t+QQBaGHsCyPDyLEXEMfP/RIjC0sGtH6mIJmEWtWTfTpNTvsMUZmx4+rn2Lt6bf
         cFdPiffktOhslKT6G02QEa4pE4zTkGkcysUnr65Q4WWt59pX7EE5Dh+hPyvscK0cV9rJ
         4EGGr58ElVarbKF6Gqxr3sdZRSThujFdz8uQpflyFC38pLzEd275l9WTiEsrZjh0EzP9
         BD1Q==
X-Gm-Message-State: AFqh2kp0P24qfQ66wBQan8JtNSn5fckRaWI9HNpptPEr4IkUjxrMCRhI
        48PGYcq6CcJDzNv4xsYkLgo=
X-Google-Smtp-Source: AMrXdXudPsOAWAYaLNzN3PgDBvrB4kU+FJrVcGLr98Gc5ePGYTXAxagy9IiXqMDwAMCQMl/kQKY/Jw==
X-Received: by 2002:a92:c54f:0:b0:30d:976d:bbe7 with SMTP id a15-20020a92c54f000000b0030d976dbbe7mr528265ilj.4.1673909383338;
        Mon, 16 Jan 2023 14:49:43 -0800 (PST)
Received: from localhost ([2607:fea8:a2df:3d00::6be])
        by smtp.gmail.com with ESMTPSA id z25-20020a056638215900b003a3dd1c7be7sm1791803jaj.128.2023.01.16.14.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 14:49:42 -0800 (PST)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Daniel Mentz <danielmentz@google.com>,
        Caleb Connolly <caleb@connolly.tech>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>
Subject: [RFC PATCH v3 0/3] drm/mipi-dsi: 16-bit Brightness Endianness Fix
Date:   Mon, 16 Jan 2023 17:49:06 -0500
Message-Id: <20230116224909.23884-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2 (20230114010006.50471-1-mailingradian@gmail.com):
 - patch vtdr6130 to use _large (3/3)
 - remove Change-Id again (1/3)
 - change patch subject (1-2/3)
 - correct function name in patch description (2/3)
 - add Tested-by tags (1-2/3)

Changes since v1 (20230113041848.200704-1-mailingradian@gmail.com):
 - move 16-bit brightness handling to new functions and revert API
   change (1/2)
 - remove Change-Id in compliance with checkpatch.pl (1/2)
 - separate panel driver changes (2/2)

This series adds proper support for 16-bit MIPI DSI brightness and
cleans up existing panel drivers with 16-bit brightness.

Both setting and getting works on an external S6E3FA7
(max_brightness = 1023) panel driver with the first patch.

Even though this originally fixed both 8-bit and 16-bit brightness, the
8-bit fix is omitted for now because it affects ~13 panels that would
need to be tested:

    panel-asus-z00t-tm5p5-n35596.c
    panel-boe-bf060y8m-aj0.c
    panel-dsi-cm.c
    panel-ebbg-ft8719.c
    panel-jdi-fhd-r63452.c
    panel-jdi-lt070me05000.c
    panel-novatek-nt35510.c
    panel-novatek-nt35560.c
    panel-orisetech-otm8009a.c
    panel-raydium-rm67191.c
    panel-samsung-s6e63j0x03.c
    panel-sony-acx565akm.c
    panel-sony-tulip-truly-nt35521.c

Daniel Mentz (1):
  drm/mipi-dsi: Fix byte order of 16-bit DCS set/get brightness

Richard Acayan (2):
  drm/panel: sofef00: Use 16-bit brightness function
  drm/panel: vtdr6130: Use 16-bit brightness function

 drivers/gpu/drm/drm_mipi_dsi.c                | 52 +++++++++++++++++++
 drivers/gpu/drm/panel/panel-samsung-sofef00.c |  9 +---
 .../gpu/drm/panel/panel-visionox-vtdr6130.c   |  5 +-
 include/drm/drm_mipi_dsi.h                    |  4 ++
 4 files changed, 59 insertions(+), 11 deletions(-)

-- 
2.39.0

