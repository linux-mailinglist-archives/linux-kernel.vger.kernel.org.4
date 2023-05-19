Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DB5709EEA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 20:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjESSJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 14:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjESSJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 14:09:31 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75515121;
        Fri, 19 May 2023 11:09:29 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-94a342f7c4cso678047466b.0;
        Fri, 19 May 2023 11:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684519768; x=1687111768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MF33tdMj9iVHCsjXUVoEa1ZEru2AhDHukTYWsA8encE=;
        b=bm7RAQh6sbBla4vNjrqGC5WqJ+/w35iby80F2IEn4lfhiajLAQZK8zrOwn+VUdYVc1
         5vr8TZGpub1V6modDXJzHvOZm0KbrmORsP201upDRJncrMrqBosCAR+X9RgXdNHqmb+g
         rHSuzRcNajsuOLEms/pFWpK1/OApbZ5gCIsILsO62ev4+PcjrKnb+Hcgzstco3XI3iSH
         IBhm3MZq1H9zNQACcIOfw8whprOqQPTb8ueGk5h/YB4wHDMqc9f/TkAnINdLJAP+TBZX
         HrtkKrictRIJZnCHsUinUGfIYj8HkDYfcdU5oj/Py6Gojc0cZMXl12wyiArGpvkIo43Y
         31fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684519768; x=1687111768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MF33tdMj9iVHCsjXUVoEa1ZEru2AhDHukTYWsA8encE=;
        b=KU4YXpDm7vrO7kjR8EIXWiwdG641LLHs/fciMXpA6h9KhZyEvZc5zqOoIeEFrym9bc
         HGt2e7RV1rXYO/30FKeJJ0XKHApMSYUFT9HiYWlzaGNEqNlVaSSOuoKE46RgUvLkC6iq
         fRFpDyWePQbSp885aqjmJD6EFJH/jNSsJx5oIe0V7v7oNcCsDQ7jMyepPlvfK7osSw1m
         ju5HzweRCNY38pDt8BMfQmmuF+AfY96ESgCqf++fO4wLaqXGMUbDli8Q7jlcgmWNT9qT
         1giDoddDH/tEYkmgI5sbqTHZ68wJ8DjxO2sU2ZeKQwSGOxqNLIhlk4sVqM+M3VcT+oya
         z4oA==
X-Gm-Message-State: AC+VfDwsk6wUgCV5ucdeRCpNHjCKQw5vgwZa2WmMSOHR+LA6kIrfw2rL
        umqlWOGSzz6tVaBof1RMkqk=
X-Google-Smtp-Source: ACHHUZ6SJoTanHKm7kR2LK1v+KjCScFJDXFOZCH/ufqcyH+1iKc+sO94xdQxG9FrUnCxyLb6Q97YqQ==
X-Received: by 2002:a17:906:fe41:b0:96a:138:c1a0 with SMTP id wz1-20020a170906fe4100b0096a0138c1a0mr2982368ejb.9.1684519767821;
        Fri, 19 May 2023 11:09:27 -0700 (PDT)
Received: from localhost.my.domain (83.11.222.198.ipv4.supernova.orange.pl. [83.11.222.198])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7c85a000000b0050690bc07a3sm19824edt.18.2023.05.19.11.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 11:09:27 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Helge Deller <deller@gmx.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Luca Weiss <luca@z3ntu.xyz>,
        Artur Weber <aweber.kernel@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2 4/4] arm64: dts: adapt to LP855X bindings changes
Date:   Fri, 19 May 2023 20:07:28 +0200
Message-Id: <20230519180728.2281-5-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519180728.2281-1-aweber.kernel@gmail.com>
References: <20230519180728.2281-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change underscores in ROM node names to dashes, and remove deprecated
pwm-period property.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
index 38f4ff229bef..a6a58e51822d 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
@@ -58,19 +58,17 @@ backlight: backlight@2c {
 			dev-ctrl = /bits/ 8 <0x80>;
 			init-brt = /bits/ 8 <0xff>;
 
-			pwm-period = <29334>;
-
 			pwms = <&pwm 0 29334>;
 			pwm-names = "lp8557";
 
 			/* boost frequency 1 MHz */
-			rom_13h {
+			rom-13h {
 				rom-addr = /bits/ 8 <0x13>;
 				rom-val = /bits/ 8 <0x01>;
 			};
 
 			/* 3 LED string */
-			rom_14h {
+			rom-14h {
 				rom-addr = /bits/ 8 <0x14>;
 				rom-val = /bits/ 8 <0x87>;
 			};
-- 
2.40.1

