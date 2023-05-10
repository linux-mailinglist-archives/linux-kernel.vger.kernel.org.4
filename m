Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BFA6FDA0A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbjEJIx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236892AbjEJIxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:53:07 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A333140F6;
        Wed, 10 May 2023 01:52:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-306dbad5182so4441705f8f.1;
        Wed, 10 May 2023 01:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683708770; x=1686300770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sRhXhkL36qHDCTJUPZJ0gK4JtbzzIKwrgaPUffLmcS4=;
        b=oG8mhrPN17kkUirhBiS9xZM7Nax7ezuXWWn0z7PndTZ7BTrMJoaOch4OdduhXkfI/f
         F1tcjT9OW1w49Za65TxRxLWsa9AL+CNPIfkH/jdoiHdrE6d0se+xpilb9SaU/rerV+Wt
         4GFVTbr+8REGG65ejKLrTU1YW1y+aLP4O00vl9Bh8M5xPYuySq67zgv6JW+bn7harRR+
         oLOzsTjCdD0tHiDuZeOM9QnRzJR5PXNTlGnUH7wrqVbXaQqk0WXabCF5fX8h+zMKdVm1
         WferQ9/7qxOGapUd9MCkFIUIyz7ci2aXsW9lKl6Ou1AO7idtk9agds/AY87tU/a901/B
         Zy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683708770; x=1686300770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sRhXhkL36qHDCTJUPZJ0gK4JtbzzIKwrgaPUffLmcS4=;
        b=gwbkbrZdxKlQ/EXfSIsKq4tK+cGod9UBwLn0NxBp3zMMXC/SqPVzz0n0g5RWRB1rPo
         1XU6+exWP81GuJkpdifnJGmL0QWMeQUbgnaGLtgFTZ4dGfWD/JhXfUXFBQOR1sSi0hPK
         l+excmylyn+JpsK+EqZNUWU5sH825tgXDLSNeczD5ngE8MjFBlUM3gnGEXRLOgYJEOBF
         4ozuXGteAcjLoV6Gpz6Wz9CxRDAKzSnS15Y7VjXFtkbiJKdLdOargyWj/3JeVtMiJtst
         W2+n7ts5j/x0ZT5+r44NyfjCLuIOPBTwSjFaA46vHmFQpMhmwjA6K+eQOzryIVt3kGCx
         FsZw==
X-Gm-Message-State: AC+VfDx7KYYr6mr+cIVw9BBpQUm8dh/ONmTWm61fBashYtqQE6e/ctHj
        x/cj0sKB4GpfiicPodba4Oo=
X-Google-Smtp-Source: ACHHUZ7ih61hE9Yfr+pU8+QPzsVKR+QvTP+Uv980w8E1G8xoVAtDcpQ/O5PinNK/Mlk2eFtDJjKS/g==
X-Received: by 2002:a5d:5082:0:b0:307:a36b:e7a5 with SMTP id a2-20020a5d5082000000b00307a36be7a5mr3554624wrt.60.1683708769923;
        Wed, 10 May 2023 01:52:49 -0700 (PDT)
Received: from koko.localdomain (cgn-89-1-213-9.nc.de. [89.1.213.9])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d4e8f000000b0030629536e64sm16730766wru.30.2023.05.10.01.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 01:52:49 -0700 (PDT)
From:   Maximilian Weigand <mweigand2017@gmail.com>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Maximilian Weigand <mweigand@mweigand.net>
Subject: [PATCH v2] backlight: lm3630a: turn off both led strings when display is blank
Date:   Wed, 10 May 2023 10:52:39 +0200
Message-Id: <20230510085239.1253896-1-mweigand2017@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maximilian Weigand <mweigand@mweigand.net>

Use backlight_is_blank() to determine if the led strings should be turned
off in the update_status() functions of both strings.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
---
Changes in v2:
- fix description, replace display_is_black() with backlight_is_black()
- use backlight_get_brightness() instead of accessing the property
  directly

 drivers/video/backlight/lm3630a_bl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index d8c42acecb5d..faf92c8d70c1 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -202,7 +202,9 @@ static int lm3630a_bank_a_update_status(struct backlight_device *bl)
 	usleep_range(1000, 2000);
 	/* minimum brightness is 0x04 */
 	ret = lm3630a_write(pchip, REG_BRT_A, bl->props.brightness);
-	if (bl->props.brightness < 0x4)
+
+	if (backlight_is_blank(bl) || (backlight_get_brightness(bl) < 0x4))
+		/* turn the string off  */
 		ret |= lm3630a_update(pchip, REG_CTRL, LM3630A_LEDA_ENABLE, 0);
 	else
 		ret |= lm3630a_update(pchip, REG_CTRL,
@@ -277,7 +279,9 @@ static int lm3630a_bank_b_update_status(struct backlight_device *bl)
 	usleep_range(1000, 2000);
 	/* minimum brightness is 0x04 */
 	ret = lm3630a_write(pchip, REG_BRT_B, bl->props.brightness);
-	if (bl->props.brightness < 0x4)
+
+	if (backlight_is_blank(bl) || (backlight_get_brightness(bl) < 0x4))
+		/* turn the string off  */
 		ret |= lm3630a_update(pchip, REG_CTRL, LM3630A_LEDB_ENABLE, 0);
 	else
 		ret |= lm3630a_update(pchip, REG_CTRL,

base-commit: ac9a78681b921877518763ba0e89202254349d1b
--
2.39.2

