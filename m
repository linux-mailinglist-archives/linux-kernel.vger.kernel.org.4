Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C660665DFAC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 23:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240489AbjADWMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 17:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240460AbjADWMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 17:12:51 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD897193E7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 14:12:50 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id g10so12923238wmo.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 14:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qyxWpwZrLC0D/z1TOjudaUZ9Mh7byi3hhDukVq1HkVU=;
        b=Egcm8LR+wxVfNvHjtn0fZUQphH9szo/KzOeAEKN5vZ/g39b305WhxRlb0pHFFKPzVr
         UJFvVfPwsOLuwohy4yZ/WDy2xDbbCYOYD8czWjpBLcqoIi2wrJnGTqZDwp5auYZEe+K1
         DLMuDwIysgj74J7gb+D+0RRPrOeJgdKZxXMPAU+nMxNNLxdhVi6E/Ac1rXIGte9Azbe4
         pdw0yfHsS3FaDDfVyDab/JeMJBdf33ykmwc+dm01dei4LDCJH3uBnk8xpjUBsa9gxAeX
         0bwmsiwmIaxQJ0BTbCVDoaiqvlL/y9cjXET/FrPRLJKfEg1xs6lqvY4rt39plejEQEr2
         3aAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qyxWpwZrLC0D/z1TOjudaUZ9Mh7byi3hhDukVq1HkVU=;
        b=sy7y5zCzEvFT2NOHdm/1qOMOzfh3+wpt+YoUaqKODvvuM5J4U/fFducs9+6gOH0EPt
         GFcjH89q5LdOTPD1mbyn7qGvcG5BYsJIlbKZfUTYCApeJAjVRPpEnPdmL2bG4PafCWYO
         g9uI5DihBEmK/lTHNegKlbdD3yiQHPunTRIwrVEVh8dP0Em7z8bL2uDPqxzP9ZmMpc9H
         lPBF8bRl2FNCuudmZasKcIBTFIYJzS2CGH+Xdnsf7vJjjPH45/ydP/Ein7SAr2hMObA9
         KPSDBxw1+xfGa6Sz8Z6kmDrBgPDCUD5BkJvlch5bqvcYiOgpUgOB/jxFcv1p7M3/HS1w
         2/JA==
X-Gm-Message-State: AFqh2koPQjGxMiUPFARz2o/0hvatTEv7WhOknCiy5sXcPdhpBYGMsHaE
        eSL86P66R9asxtXoDJGccQQ=
X-Google-Smtp-Source: AMrXdXvVRHX6G5nROCXAc/gfZf1AAG7SnrFtp2cDaVixa07sqCFDBUnOm6sL2JLBRzHIv+N19hTwZQ==
X-Received: by 2002:a05:600c:a10:b0:3d2:2904:dfe9 with SMTP id z16-20020a05600c0a1000b003d22904dfe9mr38999565wmp.21.1672870369472;
        Wed, 04 Jan 2023 14:12:49 -0800 (PST)
Received: from arch-laptop.. (host31-53-119-24.range31-53.btcentralplus.com. [31.53.119.24])
        by smtp.gmail.com with ESMTPSA id l24-20020a1ced18000000b003d99da8d30asm57164wmh.46.2023.01.04.14.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 14:12:48 -0800 (PST)
From:   Ben Carter <craterrender@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Divya Prakash <divya1.prakash@intel.com>,
        Ben Carter <craterrender@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound: hda: increase timeouts to stop crash on resume with ALC3204 and others
Date:   Wed,  4 Jan 2023 22:10:24 +0000
Message-Id: <20230104221024.23524-1-craterrender@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon waking after system suspend, ALSA often crashed with:
  snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
  snd_hda_codec_hdmi hdaudioC1D2: Unable to sync register 0x2f8100. -5
  snd_hda_codec_realtek hdaudioC1D0: Unable to sync register 0x2b8000. -5
A temporary fix was established by reloading snd_hda_intel, but increasing
the rather strict timeout of 1ms to 100ms has remedied the issue on my
device. Although this is a much larger delay, most hardware took less than
1ms anyway and it's preferable to the whole audio system crashing.

Signed-off-by: Ben Carter <craterrender@gmail.com>
---
 sound/hda/hdac_controller.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index 3c7af6558249..1ab573248452 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -16,7 +16,7 @@ static void azx_clear_corbrp(struct hdac_bus *bus)
 {
 	int timeout;
 
-	for (timeout = 1000; timeout > 0; timeout--) {
+	for (timeout = 100000; timeout > 0; timeout--) {
 		if (snd_hdac_chip_readw(bus, CORBRP) & AZX_CORBRP_RST)
 			break;
 		udelay(1);
@@ -26,7 +26,7 @@ static void azx_clear_corbrp(struct hdac_bus *bus)
 			snd_hdac_chip_readw(bus, CORBRP));
 
 	snd_hdac_chip_writew(bus, CORBRP, 0);
-	for (timeout = 1000; timeout > 0; timeout--) {
+	for (timeout = 100000; timeout > 0; timeout--) {
 		if (snd_hdac_chip_readw(bus, CORBRP) == 0)
 			break;
 		udelay(1);
-- 
2.39.0

