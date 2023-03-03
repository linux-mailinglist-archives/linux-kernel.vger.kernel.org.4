Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0C86A8DE3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCCAaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCCA36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:29:58 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5729958B46;
        Thu,  2 Mar 2023 16:29:57 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id f16so734280ljq.10;
        Thu, 02 Mar 2023 16:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677803395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfPgYFPRX/XPtEQf9GsJM1HQG3J7uORukGi3HA1Sn78=;
        b=qRpHStGtdyvSG6C/rpq/wn+qRE1V0RfdCPT1TMSerFLQjDQOxoT9T/klmPdGtNEc+0
         z57A/CItw+EluhWzWFGBiCL6waEFZff2uXARAJoJhwWhrRhzpIblrhsg5KkY4wtxDaM5
         GXHFOh2Ms0rsveAJzyJ1Nl7f4iAy5Sq9iM86r9JfM9lQv10SDvdeNIxUgRMUUdgr1TXJ
         IamFI9FbzCIRXr8HdtcjN9D68llLY38mOVn8T6ktRAS1OA+dlynmbULrVmBH3eeN3Q7i
         wfHaU5PolU5EEcbFHwa0Ja+3radf0s+9c+xZsBx2/Xmc/6x5pryIdcQF9ihQkNJ+JtQR
         VPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677803395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfPgYFPRX/XPtEQf9GsJM1HQG3J7uORukGi3HA1Sn78=;
        b=AIGIG7IEfy5MKVFQA+/zi9Puo7Go6LmWeuwAkSM8+w2vIabM11CPEZXJW1alOWhA2j
         FsW6VjzQG/KM4tXcdcpMdzxmZFLMx3bfk/pKF7klqt82k5GWfH/JmoSCbM3DApKSzdy4
         d/sKCcU5CJ0hmd6wRXwtTWzl2S8+JVHNJdBDyjskH+dm6FCUGvRlPDQTni+vxIMw2y/e
         ntV3uK5yxRPAfCeJN9y1wyQCv8eEn/IXXXLZ2dogTkz3FvuF/P3X7kgLNAx9Xz/9JoTs
         6qMsdUkd1VEVhF0965jzzo3TFY0z5w8ihAA5tNgU6KWejG573eT74XerpoYwRIlXODwU
         KaoQ==
X-Gm-Message-State: AO0yUKVZDid9EmCGu54TeMSuChgao/75DbOelHwCtYhh2QFX0blUUpyf
        NmhvIvMwlz2+gBIG9cwwDK0=
X-Google-Smtp-Source: AK7set8yp4m8XhWqhNfPwz4Sh+24IUYWozDUsslzM6BkeOtlhGN4gt1okfhLATRbHujUT+K6+ZPItw==
X-Received: by 2002:a2e:7c05:0:b0:295:a969:d225 with SMTP id x5-20020a2e7c05000000b00295a969d225mr3636320ljc.1.1677803395571;
        Thu, 02 Mar 2023 16:29:55 -0800 (PST)
Received: from arinc9-PC.lan ([212.68.60.226])
        by smtp.gmail.com with ESMTPSA id v19-20020a2e9f53000000b002932b817990sm64901ljk.31.2023.03.02.16.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 16:29:55 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
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
Subject: [PATCH 02/20] pinctrl: ralink: {mt7620,mt7621}: add new mediatek compatible strings
Date:   Fri,  3 Mar 2023 03:28:31 +0300
Message-Id: <20230303002850.51858-3-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230303002850.51858-1-arinc.unal@arinc9.com>
References: <20230303002850.51858-1-arinc.unal@arinc9.com>
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

This platform from Ralink was acquired by MediaTek in 2011. Then, MediaTek
introduced these SoCs which utilise this platform. Add new compatible
strings to address the incorrect naming.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/pinctrl/ralink/pinctrl-mt7620.c | 1 +
 drivers/pinctrl/ralink/pinctrl-mt7621.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pinctrl/ralink/pinctrl-mt7620.c b/drivers/pinctrl/ralink/pinctrl-mt7620.c
index 06b86c726839..88b0c6a4ee18 100644
--- a/drivers/pinctrl/ralink/pinctrl-mt7620.c
+++ b/drivers/pinctrl/ralink/pinctrl-mt7620.c
@@ -371,6 +371,7 @@ static int mt7620_pinctrl_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id mt7620_pinctrl_match[] = {
+	{ .compatible = "mediatek,mt7620-pinctrl" },
 	{ .compatible = "ralink,mt7620-pinctrl" },
 	{ .compatible = "ralink,rt2880-pinmux" },
 	{}
diff --git a/drivers/pinctrl/ralink/pinctrl-mt7621.c b/drivers/pinctrl/ralink/pinctrl-mt7621.c
index fb5824922e78..2128a94f6d1b 100644
--- a/drivers/pinctrl/ralink/pinctrl-mt7621.c
+++ b/drivers/pinctrl/ralink/pinctrl-mt7621.c
@@ -96,6 +96,7 @@ static int mt7621_pinctrl_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id mt7621_pinctrl_match[] = {
+	{ .compatible = "mediatek,mt7621-pinctrl" },
 	{ .compatible = "ralink,mt7621-pinctrl" },
 	{ .compatible = "ralink,rt2880-pinmux" },
 	{}
-- 
2.37.2

