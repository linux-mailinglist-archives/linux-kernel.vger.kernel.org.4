Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733F36508AB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 09:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiLSInX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 03:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiLSInV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 03:43:21 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA96A19A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 00:43:19 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id vv4so19794477ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 00:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kYYaE3bwqOZpjy9bqglp5kw8THeTMFyYTG3Pe3WusMY=;
        b=73G2LxFwIuXcJ8JfikxHBeTK8Ai8+099d7TsNEgBayS3aGnT3o3UhXd2w5UnDtt3Ia
         0sIi4pHg+1OyBNaU//uOizs1AYrUWG3CyYuYFuOI1PE5M5UPmWEfmAZhzFVLQro/CjuR
         nOevReLfQUP7X4vhPqEh1sfp38tL+m0m27GS4zbsfo5WkN1gzXKerBonhxbzgq4fiC+l
         5XQY4rvgo80IFX4GjhiUWF8UjdWrPH9ncuS0egroDJR7bwpeaLjA3a3sZe7nxggczXLQ
         dDh9f93/9dRvQWVcZAD7UwR/uJEhOqRZ0xeNv/HJN2ab/rZYMMolHOLoTxlxZqJKdebN
         v7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYYaE3bwqOZpjy9bqglp5kw8THeTMFyYTG3Pe3WusMY=;
        b=jmHz/FnnyIVv0IHSL3mFDzM1R7EvF9jZ450t0nOYblnXH2y+3r2l3kWv9zW+oFwPUk
         x9KJZA453DJhCC8cjE/Dzj2auUwoABqvdy2EqUlaTHoXFShmK6ObGt1W/XobUiBNipEZ
         BmKjAtWUHyICmTLZxHLOfG8W1LdqZr/bVyptrYuF/qmoOTmiTkmVANqp8q/gMZbaip9R
         gWYsY3TNrHZqnJzmZ/A6tOPDrI2qpmYzFlCgYW8ttP4lis4vLEc5fL+4L0Ukedhxuf/u
         Y5YHYzOC4ta4i+l2tc75EBauxi7EcEY392HYaW6eDA6tt9SBHG3htdTfiw2u6xNJbrVE
         TTOg==
X-Gm-Message-State: ANoB5pnIAdMHt7fIpfQsGyODnIrP2/HysujswGzd3CwZ6+sdIwqW1j03
        tDYgX3eUcW8juzNEXNKlqvTdzQ==
X-Google-Smtp-Source: AA0mqf7famYNciIPKzFQ0QR5iYvihCH5RaB2lTsclMVvpvXA8pM9J4X8rlevPiqjboKSR8SeNzSmuw==
X-Received: by 2002:a17:906:8d08:b0:7c1:700:1e2d with SMTP id rv8-20020a1709068d0800b007c107001e2dmr55156347ejc.20.1671439397658;
        Mon, 19 Dec 2022 00:43:17 -0800 (PST)
Received: from [127.0.1.1] ([2001:b07:5d39:f336:a0ba:cfa5:2107:c2c4])
        by smtp.gmail.com with ESMTPSA id w7-20020a170906b18700b007c0b28b85c5sm4083755ejy.138.2022.12.19.00.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 00:43:17 -0800 (PST)
From:   Carlo Caione <ccaione@baylibre.com>
Date:   Mon, 19 Dec 2022 09:43:05 +0100
Subject: [PATCH] drm/meson: Reduce the FIFO lines held when AFBC is not used
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221216-afbc_s905x-v1-0-033bebf780d9@baylibre.com>
To:     David Airlie <airlied@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having a bigger number of FIFO lines held after vsync is only useful to
SoCs using AFBC to give time to the AFBC decoder to be reset, configured
and enabled again.

For SoCs not using AFBC this, on the contrary, is causing on some
displays issues and a few pixels vertical offset in the displayed image.

Conditionally increase the number of lines held after vsync only for
SoCs using AFBC, leaving the default value for all the others.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Fix display issues for amlogic SoCs not using AFBC

In 24e0d4058eff the number of lines held after VSYNC was incremented to give
time to the AFBC decoder to do its job. This is causing an issue (seen on
S905x) where the image (on some panels) is dislayed with a vertical offset.
With this patch we try to keep the fix only when AFBC is actually used
filtering on the SoC type.

To: Neil Armstrong <neil.armstrong@linaro.org>
To: David Airlie <airlied@gmail.com>
To: Daniel Vetter <daniel@ffwll.ch>
To: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/meson/meson_viu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_viu.c b/drivers/gpu/drm/meson/meson_viu.c
index d4b907889a21..cd399b0b7181 100644
--- a/drivers/gpu/drm/meson/meson_viu.c
+++ b/drivers/gpu/drm/meson/meson_viu.c
@@ -436,15 +436,14 @@ void meson_viu_init(struct meson_drm *priv)
 
 	/* Initialize OSD1 fifo control register */
 	reg = VIU_OSD_DDR_PRIORITY_URGENT |
-		VIU_OSD_HOLD_FIFO_LINES(31) |
 		VIU_OSD_FIFO_DEPTH_VAL(32) | /* fifo_depth_val: 32*8=256 */
 		VIU_OSD_WORDS_PER_BURST(4) | /* 4 words in 1 burst */
 		VIU_OSD_FIFO_LIMITS(2);      /* fifo_lim: 2*16=32 */
 
 	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
-		reg |= VIU_OSD_BURST_LENGTH_32;
+		reg |= (VIU_OSD_BURST_LENGTH_32 | VIU_OSD_HOLD_FIFO_LINES(31));
 	else
-		reg |= VIU_OSD_BURST_LENGTH_64;
+		reg |= (VIU_OSD_BURST_LENGTH_64 | VIU_OSD_HOLD_FIFO_LINES(4));
 
 	writel_relaxed(reg, priv->io_base + _REG(VIU_OSD1_FIFO_CTRL_STAT));
 	writel_relaxed(reg, priv->io_base + _REG(VIU_OSD2_FIFO_CTRL_STAT));

---
base-commit: 84e57d292203a45c96dbcb2e6be9dd80961d981a
change-id: 20221216-afbc_s905x-4baf5fdc9970

Best regards,
-- 
Carlo Caione
