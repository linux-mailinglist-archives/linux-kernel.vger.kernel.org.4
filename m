Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE80A70C2BB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbjEVPwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjEVPwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:52:18 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1C2F9;
        Mon, 22 May 2023 08:52:14 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3318961b385so9994175ab.1;
        Mon, 22 May 2023 08:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684770733; x=1687362733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7sLAS1re4t0jepnvIMkPI23rNpmWLJZtcQVM+U6RF+I=;
        b=UGRRnuJymzcFEIgOt1c7jWHGtoRQnT32sQuU0zmMQB1tSkJcX4XXJ3W0th1d0drxkE
         ESQ96vRX9bqIW8Tg01BrHzsKLYQJZySPkmz6HWnGaywLPa0ahg4F6Gi42DZEbJxpFAzh
         iE2qubB1+HAqi0VefqWciMtMiaYqbtLY6lX5S/enNs86b8+HTJbtShyvpqpJF9PxNovG
         lYd4wk0gStVIfBgcTuBkUmakTnhhxpTABaGBvM/lk6ZyheGJDw0hOWL4OmqqN0RQobuR
         pyHn9gP98T8eVK4ZAstf8SfAgiaBHiRHznOyRHx8x+TR9a/WRhqxPxwIrF+gB5EiCWnM
         wSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684770733; x=1687362733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sLAS1re4t0jepnvIMkPI23rNpmWLJZtcQVM+U6RF+I=;
        b=VdKhywX6nwlBj1iWQ5ZZNmnu8nM9zH3cnEFhZ41lxRsHyWuwskyKti0ShBFShHnlJ3
         dHUjsIdmHNlzk5rjBPqDUIszXUz0Q2ZXWB0SS34EOIEWi77EeEhEkxh+UEbLj4agIt0b
         KJb/Wwi6zkgZMQLjDwQb8e8p7rdX1irbHjgHaxbXQVaKxuXts5D4QYH7cYV0vRks9xKn
         vHNRxSyCtzzixbDDr3eMfwImBzbMCsXQksB23bVFZ59HD5JYq9WeAhbRYy1Jxs886O+H
         j0rIPhdfghNLGzw1uRs0BSdMnnLQ7v/JwEA2xidpnRtYgsLHUdV2qeVpnEigc1mc8Qwh
         YMsA==
X-Gm-Message-State: AC+VfDx8xUWwOXRJTFJMvT5b4jnvVwqqA00JYeB5X6mMl7Yy5pcmVUBH
        fK5LCM4gWZ1Th1E7Re6G8E8=
X-Google-Smtp-Source: ACHHUZ7x7GRL661Xm6U+t9Prayc8EdalxBRBQSJ1Esy+V4Z78cjwoFzpNSmy+Zh4M/L/Kv3wz1ocIw==
X-Received: by 2002:a92:db08:0:b0:338:65fc:f4c1 with SMTP id b8-20020a92db08000000b0033865fcf4c1mr6987356iln.9.1684770733275;
        Mon, 22 May 2023 08:52:13 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id bs21-20020a056638451500b0040bd3646d0dsm1794208jab.157.2023.05.22.08.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 08:52:12 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Maxime Ripard <maxime@cerno.tech>,
        Lucas Stach <l.stach@pengutronix.de>,
        Guillaume BRUN <the.cheaterman@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/bridge: dw-hdmi: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 15:52:10 +0000
Message-ID: <20230522155210.2336690-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
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

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 603bb3c51027..9d6dcaf317a1 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -533,7 +533,7 @@ static struct i2c_adapter *dw_hdmi_i2c_adapter(struct dw_hdmi *hdmi)
 	adap->owner = THIS_MODULE;
 	adap->dev.parent = hdmi->dev;
 	adap->algo = &dw_hdmi_algorithm;
-	strlcpy(adap->name, "DesignWare HDMI", sizeof(adap->name));
+	strscpy(adap->name, "DesignWare HDMI", sizeof(adap->name));
 	i2c_set_adapdata(adap, hdmi);
 
 	ret = i2c_add_adapter(adap);

