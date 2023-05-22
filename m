Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785C070C2B6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjEVPvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbjEVPvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:51:54 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3771EB5;
        Mon, 22 May 2023 08:51:53 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-76c5558ba95so68307339f.1;
        Mon, 22 May 2023 08:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684770712; x=1687362712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BqOE5x2+ni1n15spyoB1Lf2HOj8Vrz/keawyBSdQh6Q=;
        b=FeDPVWKX1y/A+/QN/GgyITdBkWKhzQmBXtOAeveM9fakQRw+0yCSiYgtoP3FdEHP/A
         OQpw7FZ2D2R7+5M7D+epBC9QXCtZWDUbXwtAa3HDGSK3FX9KobZHcA0ewL2ThRfwrJtL
         NeJkQ4kdJ1zHLLgH4Ai2bulcF5EyuHLk7wan0cKr3v+JIQa1veewHE/Yq9LpCND12YUt
         3i6UpQIY/gh9EmgYuvIROAW9HaYXBKsbshfCoL1aFxneOx+qtzwUYmcxvHJNCtXWGav8
         53CtWiKN6P4giZYGPfQuhz7zps1qF3XLoGMEc2VQ5ZdAPXyY4cXv73X5kYAMJcF9evxi
         Mqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684770712; x=1687362712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BqOE5x2+ni1n15spyoB1Lf2HOj8Vrz/keawyBSdQh6Q=;
        b=JP4ZjWCeOczTBrGIwGYrmA57YVB4tqF0mPH5jvvQn8x0c4QGm5JcKKDAzZ7bkk8BH1
         4qVRrCGvh0aNSm9yZ+Hr/EEV/cd9qrEbEwyTjp3p5mWG65+U9+F2ul71wCvumvFZzTR2
         zt1p7sVBrAo6X83n1KqaMACPLRLDNhssXOAuhfoTTH02vcOpSUh1lZucDZN/HjtMm02E
         6AKfkudNppQyxOJ/ImJEKEhfqifPCPUGjBDMIskdQzrc8XJzo1sw+rZt5FjqAfmCJ2BO
         cuUpBs+CTWxwikzPwAoF9nTlyidIPOaXnL3OO9c+4sCXXWWI4o6Ns2eSaeGii35jbi+4
         O5mg==
X-Gm-Message-State: AC+VfDz3kwLGnTnMfhAUFDVeziHumpMRojWcvoGQa2KoZ6DozBt0uvgV
        VsoltckNVesacpdkLCLMoo4=
X-Google-Smtp-Source: ACHHUZ7g1TMkvP1QL7x3isKwGwC18gojdks6P7npooE82OjMS3tbyVL8pfNYyS+woUW674ZPdO+mUw==
X-Received: by 2002:a5e:8912:0:b0:76c:8cbe:c8fc with SMTP id k18-20020a5e8912000000b0076c8cbec8fcmr7928967ioj.3.1684770712392;
        Mon, 22 May 2023 08:51:52 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id n15-20020a056602220f00b0076c6f5b8db5sm2083125ion.16.2023.05.22.08.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 08:51:51 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] drm/rockchip: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 15:51:49 +0000
Message-ID: <20230522155149.2336620-1-azeemshaikh38@gmail.com>
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
 drivers/gpu/drm/rockchip/inno_hdmi.c   |    2 +-
 drivers/gpu/drm/rockchip/rk3066_hdmi.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index f51774866f41..9afb889963c1 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -797,7 +797,7 @@ static struct i2c_adapter *inno_hdmi_i2c_adapter(struct inno_hdmi *hdmi)
 	adap->dev.parent = hdmi->dev;
 	adap->dev.of_node = hdmi->dev->of_node;
 	adap->algo = &inno_hdmi_algorithm;
-	strlcpy(adap->name, "Inno HDMI", sizeof(adap->name));
+	strscpy(adap->name, "Inno HDMI", sizeof(adap->name));
 	i2c_set_adapdata(adap, hdmi);
 
 	ret = i2c_add_adapter(adap);
diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index 90145ad96984..b5d042ee052f 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -730,7 +730,7 @@ static struct i2c_adapter *rk3066_hdmi_i2c_adapter(struct rk3066_hdmi *hdmi)
 	adap->dev.parent = hdmi->dev;
 	adap->dev.of_node = hdmi->dev->of_node;
 	adap->algo = &rk3066_hdmi_algorithm;
-	strlcpy(adap->name, "RK3066 HDMI", sizeof(adap->name));
+	strscpy(adap->name, "RK3066 HDMI", sizeof(adap->name));
 	i2c_set_adapdata(adap, hdmi);
 
 	ret = i2c_add_adapter(adap);

