Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD716F8921
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbjEES6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbjEES6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:58:16 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B912074A;
        Fri,  5 May 2023 11:58:11 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f4000ec71dso15026915e9.2;
        Fri, 05 May 2023 11:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683313090; x=1685905090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1b+OLvSRoYfyljr8mg5KeVPnX55ONCXJ476XEVumh/s=;
        b=oY2AQu9BVNjD3rwPFri5qbdOkPAjl7SrIGW9Ei9AmmSOu2oV2+G/beYc90CDGkjJIN
         WTSL3cPsucYZ447qlImb2JtqhI6aty5P2Z/LTF8ZWp3nVzA9CJDqRupN8sd2FekjDFJO
         9v/iVdx5Uch4kEmRJk9vqtfsQ57sPvHCJQu6TfiPCDF1TbBgygBgNH0QX/P2G8lFDjuX
         W+oT5yq+4tQ/0FSzEbBY3gVSJnboeZhLFywzBA+nw1N30AeE16ltvStZwUWIvPCR/usj
         7Bcvo/acWnikPWTiY/YPx/Tgin/jDb8fHkoV24523JrUt2zj1dBEEqWGNccwnS/1JA0/
         70cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683313090; x=1685905090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1b+OLvSRoYfyljr8mg5KeVPnX55ONCXJ476XEVumh/s=;
        b=LyV0KHm7AWUVhLb8rcnpcyXw+CcU/GCEKv5F0azL9diK5W4m71/2eQ/16CgebOXxQ7
         E8j6UsjooJXxJxWzScN4WxdqXPaogDi6oef72cuo/q72emO6VnWNfCqk5oXUe7sfFpd/
         aGSw1R+yevaA/An7HmhSPYf1zzJtQwrlg3MmedvShEfECjPSi3ML2tRgD3ZKLEZYoabl
         qTxuN0BdoKODEpTP3hU62ER8NUZS1el/qp2CPvI13xDkhYiLMqvS6sivhptdTpcBeXVA
         8DHWowQgq8EU0+K/eZmUHhiTgoAmq3LDeSBzFvUq+vRo2uzcNldGgVKbVrUPGYzVns55
         tJnQ==
X-Gm-Message-State: AC+VfDy0vmg49dCD5EL8moPtJm9negXYnpG+P/7MLsyJeanIQuwwEjVF
        BK75pD4x5mdpWREK4AmDtPU=
X-Google-Smtp-Source: ACHHUZ6fJO8vyrwjBhFmq93Y3W8Pkix0SQ38ShAcZelUn741btCGidGkn5mGRo4vUfDutDIFv5ll7Q==
X-Received: by 2002:a05:600c:d7:b0:3f1:82d5:997b with SMTP id u23-20020a05600c00d700b003f182d5997bmr1773498wmm.18.1683313089697;
        Fri, 05 May 2023 11:58:09 -0700 (PDT)
Received: from koko.localdomain (cgn-89-1-213-9.nc.de. [89.1.213.9])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c114900b003f4069417absm5825061wmz.24.2023.05.05.11.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 11:58:09 -0700 (PDT)
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
Subject: [PATCH v1] backlight: lm3630a: turn off both led strings when display is blank
Date:   Fri,  5 May 2023 20:57:52 +0200
Message-Id: <20230505185752.969476-1-mweigand2017@gmail.com>
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

Use display_is_blank() to determine if the led strings should be turned
off in the update_status() functions of both strings.

Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
---
 drivers/video/backlight/lm3630a_bl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index d8c42acecb5d..5498b57329f9 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -202,7 +202,9 @@ static int lm3630a_bank_a_update_status(struct backlight_device *bl)
 	usleep_range(1000, 2000);
 	/* minimum brightness is 0x04 */
 	ret = lm3630a_write(pchip, REG_BRT_A, bl->props.brightness);
-	if (bl->props.brightness < 0x4)
+
+	if (backlight_is_blank(bl) || (bl->props.brightness < 0x4))
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
+	if (backlight_is_blank(bl) || (bl->props.brightness < 0x4))
+		/* turn the string off  */
 		ret |= lm3630a_update(pchip, REG_CTRL, LM3630A_LEDB_ENABLE, 0);
 	else
 		ret |= lm3630a_update(pchip, REG_CTRL,

base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4
--
2.39.2

