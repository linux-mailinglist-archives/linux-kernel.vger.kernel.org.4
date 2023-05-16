Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F2F705443
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjEPQoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjEPQoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:44:23 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0F3D3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:44:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f475366514so53078795e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1684255460; x=1686847460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9RRIvZyK8CQAM0dAt4H7LQ/6jjtstZYibAABduiNmKg=;
        b=1pki32CkIzhFh7JpQ37UTbB0z/0EiqVq7PJo2o0rHD72vTZTKzznUr+zstjp6pW7Ek
         5Nncvby+RBLpFydfYP84Daneai9k97DsMIaSrrbDD2SGqejUaoLaDb0kwqmgr6LTOVBM
         EEZ0w0sgFmstOkKPYLbUfMogrU9cEIaCLDXfBZicSZMEg6NLwUAlaWZoUQNcHuT9Y1e5
         xkgjVm2RC8QFLOhwL+EmZsEC7sLbKn/TUoGwMc9S928xL1uFyTbzKBPxqhNiqBE1wjVw
         mM4oNJk0AEedy4oa0o3oQ4fzrwbHGgQyzhjNX2iz0tBRCnhfq/utsw5L2htW22SNNyMk
         9T8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684255460; x=1686847460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RRIvZyK8CQAM0dAt4H7LQ/6jjtstZYibAABduiNmKg=;
        b=HsUlomHn1Lutp99xUWYLMNgW5b1xIgVAn3WjnUYBAtxw0nfMekSEMRNWO8QzZhoDU+
         6+ywBmM8S8ONiGqI8S7c/CU6/lKNvQjRqm2cxH647EzD1L2FJa8JqshMPx+7Bbbc1iig
         bHP+o9POAcniGuelzKnbYKgECPeCOf4jTHqQy+8ICZ+pwsq9+kDY+WnYUSwlw05QKM0X
         cTt3wPELcPYt1/mIQl4x02J9O0745WaiHZKlPxO5hwRrM2T51l/p8KU+iyIoKXpshV6/
         wZ7hMWemHsPuiJfea/tOKxt1GF9N09hhqXTbahiwZFRqqcoT0HsnmDbVK6Q1kgLzjtVl
         OYZg==
X-Gm-Message-State: AC+VfDwCxjmCBcjak0xn6SsePb8kL1HvVCrC9ChZZtr8qH6NsUWko5kd
        5y/IkRulpe0q39q2gviiwi3FyfnzNXw40BJgt5k=
X-Google-Smtp-Source: ACHHUZ5PPeGhNUMDjhJMuSkkih/heMu/8CXLe09tt0djJBA5eZwtYs6f1RnDINUQqmnUi5x8iIBd0g==
X-Received: by 2002:a7b:ca51:0:b0:3f4:2148:e8e5 with SMTP id m17-20020a7bca51000000b003f42148e8e5mr23269068wml.1.1684255460042;
        Tue, 16 May 2023 09:44:20 -0700 (PDT)
Received: from localhost.localdomain ([188.27.132.2])
        by smtp.gmail.com with ESMTPSA id h18-20020adffd52000000b003063db8f45bsm3219899wrs.23.2023.05.16.09.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 09:44:19 -0700 (PDT)
From:   Alexandru Ardelean <alex@shruggie.ro>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        Bogdan Togorean <bogdan.togorean@analog.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] drm: adv7511: Fix low refresh rate register for ADV7533/5
Date:   Tue, 16 May 2023 19:44:16 +0300
Message-Id: <20230516164416.11616-1-alex@shruggie.ro>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bogdan Togorean <bogdan.togorean@analog.com>

For ADV7533 and ADV7535 low refresh rate is selected using
bits [3:2] of 0x4a main register.
So depending on ADV model write 0xfb or 0x4a register.

Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
---
 drivers/gpu/drm/i2c/adv7511.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i2c/adv7511.c b/drivers/gpu/drm/i2c/adv7511.c
index 61aa824d45d2..e016105a8fbe 100644
--- a/drivers/gpu/drm/i2c/adv7511.c
+++ b/drivers/gpu/drm/i2c/adv7511.c
@@ -729,8 +729,13 @@ static void adv7511_encoder_mode_set(struct drm_encoder *encoder,
 	else
 		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_NONE;
 
-	regmap_update_bits(adv7511->regmap, 0xfb,
-		0x6, low_refresh_rate << 1);
+	if (adv7511->type == ADV7511)
+		regmap_update_bits(adv7511->regmap, 0xfb,
+			0x6, low_refresh_rate << 1);
+	else
+		regmap_update_bits(adv7511->regmap, 0x4a,
+			0xc, low_refresh_rate << 2);
+
 	regmap_update_bits(adv7511->regmap, 0x17,
 		0x60, (vsync_polarity << 6) | (hsync_polarity << 5));
 
-- 
2.40.1

