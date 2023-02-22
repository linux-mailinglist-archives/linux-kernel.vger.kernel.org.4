Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0717B69FB52
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjBVSkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjBVSkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:40:20 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBC63E61C;
        Wed, 22 Feb 2023 10:40:10 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v3so8677741wrp.2;
        Wed, 22 Feb 2023 10:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxit4cASxxHL2nm1xYvDVxIdY14POx45+l2xWlfbrB8=;
        b=llZRZ6E9KMqHcgEWIp1r+RA3hxjZpkIGflmlHx7+dk6rqpu9dvNStfDRr6gBs6YsnF
         ToFasIk+nTjzAmCpFOoD0r9fXxdCGnVxALwwc7iSLqjvdQG6aQP2/p2B+26ZMtOrcQUk
         P2G7j1XBx6TfFi6EvCdd0OyHQpMWk+mN/x3Mvx5/hgj6GuhXHZTwqZiiE8qnrAghcSEy
         ieVI7lcTzJxo8xc+sXiLQ2roVdoprar+8UuTjCxfnbkkNhp5mKH7KYfl0JXF2m4FlsGF
         y+9J/RrfsI7wtn4TDkq/OhtqP/pSNjxnueSZthEUOwnPVEWgqhn1du3skR2hjRtzHoRX
         GgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxit4cASxxHL2nm1xYvDVxIdY14POx45+l2xWlfbrB8=;
        b=P0aff3iKb3QU0DuDB6AexM3t5xLKUp/NCG0bpsmnWpUD9eNOgzWEOmsrPnN6lQkSu/
         m7R4TLyys6xixNo6Rpi/rhlzboIWkJRTvsPKcX90phaiTMrUFOg3Cbqw9/YAqZsFc7YF
         kYiP+nVVdsjEZWWDAk1w9FyUaj2ydLgGDjLajC4jUjwzhgdotJo/6TiIAB7QhBaVOe8X
         fvAwcSOZpExjQIqSKbLE5WNSdl/wkeqod+m3/MnxUmqPGAOhHd8kfJ3y/KlnhLA/mV2N
         JFvS+T6vZuXlPn1qwYod1yJIVvrJAuRqpU49pNEu15wW/+AdO6CfbSbzQap2t7vwF7R6
         b9tA==
X-Gm-Message-State: AO0yUKXi0RHFScDawFumMOHs44p8zXFLTcQE66sZc1Jnzk/1V4qXXC5M
        bexDBw7XQ27XbO0v+Sy+UFA=
X-Google-Smtp-Source: AK7set9Up+ufj2qC9Aht1MB/gSjPPDEHD7mb82o3uQ/byVmKxtfMDrBUFf6MoAEKSkWeh/wg56t8hQ==
X-Received: by 2002:a05:6000:1cd:b0:2c5:8575:c37 with SMTP id t13-20020a05600001cd00b002c585750c37mr8183636wrx.66.1677091208546;
        Wed, 22 Feb 2023 10:40:08 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4112000000b002c56179d39esm9372845wrp.44.2023.02.22.10.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 10:40:08 -0800 (PST)
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
Subject: [RFC PATCH 02/16] pinctrl: ralink: add mediatek compatible strings
Date:   Wed, 22 Feb 2023 21:39:18 +0300
Message-Id: <20230222183932.33267-3-arinc.unal@arinc9.com>
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

Ralink was acquired by MediaTek in 2011. These SoCs have been rebranded as
MediaTek. Add new compatible strings to reflect that.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/pinctrl/ralink/pinctrl-mt7620.c | 1 +
 drivers/pinctrl/ralink/pinctrl-mt7621.c | 1 +
 drivers/pinctrl/ralink/pinctrl-rt2880.c | 1 +
 drivers/pinctrl/ralink/pinctrl-rt305x.c | 1 +
 drivers/pinctrl/ralink/pinctrl-rt3883.c | 1 +
 5 files changed, 5 insertions(+)

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
diff --git a/drivers/pinctrl/ralink/pinctrl-rt2880.c b/drivers/pinctrl/ralink/pinctrl-rt2880.c
index d7a65fcc7755..e57b1c5d03dd 100644
--- a/drivers/pinctrl/ralink/pinctrl-rt2880.c
+++ b/drivers/pinctrl/ralink/pinctrl-rt2880.c
@@ -40,6 +40,7 @@ static int rt2880_pinctrl_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id rt2880_pinctrl_match[] = {
+	{ .compatible = "mediatek,rt2880-pinctrl" },
 	{ .compatible = "ralink,rt2880-pinctrl" },
 	{ .compatible = "ralink,rt2880-pinmux" },
 	{}
diff --git a/drivers/pinctrl/ralink/pinctrl-rt305x.c b/drivers/pinctrl/ralink/pinctrl-rt305x.c
index f6092c64383e..ca62997e716c 100644
--- a/drivers/pinctrl/ralink/pinctrl-rt305x.c
+++ b/drivers/pinctrl/ralink/pinctrl-rt305x.c
@@ -117,6 +117,7 @@ static int rt305x_pinctrl_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id rt305x_pinctrl_match[] = {
+	{ .compatible = "mediatek,rt305x-pinctrl" },
 	{ .compatible = "ralink,rt305x-pinctrl" },
 	{ .compatible = "ralink,rt2880-pinmux" },
 	{}
diff --git a/drivers/pinctrl/ralink/pinctrl-rt3883.c b/drivers/pinctrl/ralink/pinctrl-rt3883.c
index 5f766d76bafa..b687c70d3555 100644
--- a/drivers/pinctrl/ralink/pinctrl-rt3883.c
+++ b/drivers/pinctrl/ralink/pinctrl-rt3883.c
@@ -87,6 +87,7 @@ static int rt3883_pinctrl_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id rt3883_pinctrl_match[] = {
+	{ .compatible = "mediatek,rt3883-pinctrl" },
 	{ .compatible = "ralink,rt3883-pinctrl" },
 	{ .compatible = "ralink,rt2880-pinmux" },
 	{}
-- 
2.37.2

