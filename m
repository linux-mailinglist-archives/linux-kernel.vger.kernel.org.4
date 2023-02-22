Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B3869FB35
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjBVSkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjBVSkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:40:25 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA6541085;
        Wed, 22 Feb 2023 10:40:12 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id c12so8754896wrw.1;
        Wed, 22 Feb 2023 10:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkrh5PmCKY97yVWMrE2rxg0O6ScEmnhgtHgZ694XhHo=;
        b=pl//qR2xGMfXRxwoPgmQOuAtveiqYg+PzSqwy/kO2G9BIgMD8EbSE1BIA+jaSQGadd
         tHou+DQnlJnpXsUgKZsJ/suRzx4U2wmWUVNopvLbYafjMidYDP8T4Mqw6bjiL8vbh2ua
         nsHtXy38P6lQJtcYJRq01Zcn6iWcNEexz1QF7dq68XKbvCy+tXN3tSZ3vS7tlfOOtQdw
         o8Aq5tCQxPLAT5q85jBocgKiIEPd6ZoRlSjIwRY3OzA/nrHY7djDYOUrsPCn9h6rK6FC
         kDnT/mNC7yOJRNOuc8Ym2L+V5JVAqN2vTc8+uVydneNgyhjM2/9PhP9z15qo195q5/ry
         TXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkrh5PmCKY97yVWMrE2rxg0O6ScEmnhgtHgZ694XhHo=;
        b=ginKCY1WuQnt764k7/Eov3+3c+zzux02Rc2AS2nuK+ecQDHlVLi1Y8i+YkvpwdrpV1
         N3gPQMGxXFd1JjrVFx8y5kXs6Xx+m8LZxv+/t5bgAGQ4sNxb8LJAekqpjhHyrK+avwG1
         tZc9Gi4e0u8EzdaegCzBcFH/PlkOASFMNzGp/1Gyp4PrF0UPwWVj7jU6pdURXZb3lXLr
         udHWHe02DYy0yNDkSloshNdBBfFLT2odCYNrK2rK1exqYjMoOGkGjZpeQGZ0OYB5Vi07
         3CSc+ZrKf+yT0ktt9mbtqbUPxmsYj1FlZ6CDaZumj+yAInOjiRfmeCanwUvemOhm9AuH
         CZRQ==
X-Gm-Message-State: AO0yUKU0f1cnfbh1Dc52nbKqW/ATj4UQB6aioKC0Yqad8iGMptG7KlWD
        w6v2+hGjRzZ4AglYR5Jn1mQ=
X-Google-Smtp-Source: AK7set/++D2xBRox8aFcmSpjULrFCbdHcRtHW2lgb8/1HHdLRWC8O09ROG+CaPS9xdSF25M9R4+yvA==
X-Received: by 2002:a05:6000:1284:b0:2c3:f026:9085 with SMTP id f4-20020a056000128400b002c3f0269085mr8394442wrx.13.1677091210888;
        Wed, 22 Feb 2023 10:40:10 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4112000000b002c56179d39esm9372845wrp.44.2023.02.22.10.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 10:40:10 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Subject: [RFC PATCH 03/16] pinctrl: ralink: rt305x: add compatible string for every SoC
Date:   Wed, 22 Feb 2023 21:39:19 +0300
Message-Id: <20230222183932.33267-4-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230222183932.33267-1-arinc.unal@arinc9.com>
References: <20230222183932.33267-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Add a compatible string for every SoC, or SoCs that use the same pinmux
data. This ensures that the pin muxing information of every SoC, or a set
of SoCs that use the same pinmux data can be properly documented.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/pinctrl/ralink/pinctrl-rt305x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/ralink/pinctrl-rt305x.c b/drivers/pinctrl/ralink/pinctrl-rt305x.c
index ca62997e716c..a112a83085ea 100644
--- a/drivers/pinctrl/ralink/pinctrl-rt305x.c
+++ b/drivers/pinctrl/ralink/pinctrl-rt305x.c
@@ -118,6 +118,8 @@ static int rt305x_pinctrl_probe(struct platform_device *pdev)
 
 static const struct of_device_id rt305x_pinctrl_match[] = {
 	{ .compatible = "mediatek,rt305x-pinctrl" },
+	{ .compatible = "mediatek,rt3352-pinctrl" },
+	{ .compatible = "mediatek,rt5350-pinctrl" },
 	{ .compatible = "ralink,rt305x-pinctrl" },
 	{ .compatible = "ralink,rt2880-pinmux" },
 	{}
-- 
2.37.2

