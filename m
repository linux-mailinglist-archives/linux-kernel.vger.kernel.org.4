Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAB96F94F0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 01:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjEFX16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 19:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjEFX1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 19:27:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CA31A62C;
        Sat,  6 May 2023 16:27:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-304935cc79bso2964023f8f.2;
        Sat, 06 May 2023 16:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683415658; x=1686007658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfUmN9P7DlgthaW0XDXu/SCHNJ/yWqL0BMYXFISq3mY=;
        b=pZIHZyoskmE3DAtChZfA5R1Y8Dpl8An8woCavYLm9RxLniuygU0hO22S3l3aRaz5B7
         5Q6VSxz0O9RnpN+mKW1luqVy7fBspjnxn8DXO0mbS3QBW6DzO4BZruQ//7+mTmgJTSQp
         fFOyL9fDB7TMHWiliL6CF0CJUawqzuJ5GcNOWVaDi0JeEbLdJcRQV6/69CLY4IIR8ggw
         MMAch9kmYaDVji7P6erO4ebdn4Ms7MaiDyq1bDpX0YfCFrMnMh/4dFDPHFuz/xkExwVS
         6NkYhKQZ/7GOkx/sO4+1ZqjwUFna+iIjSTV4NFNKkNvf5pkgzAyEkHm76UiEcc6vyPP6
         WOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683415658; x=1686007658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfUmN9P7DlgthaW0XDXu/SCHNJ/yWqL0BMYXFISq3mY=;
        b=EEbACz1X+AwHmP/Z4vtOciUW8s2H6UTDONANgrnxcE0a+se8/4Oke9ogY2zzDK4TbD
         LeWJ47Bd41YJ/FoUqxinwfGpWx0dsJPJnfZkbWarhPUgYsbhnPCNuh6fbe5jz0DGpvNV
         OZ+bCFi6wnI20yxNH8j4rHQLQ8k/dTx0riVEYBeJtKWMIh4rxPbO9jNB4NvV66Hixv0H
         zlzz7X6SYMeDz37pkoVWLrp/VGX+HHylYZWSj30QQotKws139wekx9aX1cStye5o7Zj9
         Ac2f4yFrjD1jTRIGqiRt5bs/EwbV11kfA0UEexaPsrjfWUFerg4kjVL8j1TGDpxOpeFZ
         vXeA==
X-Gm-Message-State: AC+VfDwCykJsK2ZkFKMbHUCvkyP3QU+MJuD2KeLES31u9gndH5/FPKnm
        syRJSfirMr1PqqJjCcs7j5U=
X-Google-Smtp-Source: ACHHUZ74RtTob+l2N406yInvbgRhhnjxXQw38H3pS8jI+Z4uv6EUhlXDQlad7bvlWaQMVqe72/wksw==
X-Received: by 2002:a05:6000:11cd:b0:306:2638:6fea with SMTP id i13-20020a05600011cd00b0030626386feamr4588568wrx.54.1683415657935;
        Sat, 06 May 2023 16:27:37 -0700 (PDT)
Received: from localhost.localdomain ([176.221.215.212])
        by smtp.gmail.com with ESMTPSA id p4-20020a1c7404000000b003f1739a0116sm12098655wmc.33.2023.05.06.16.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 16:27:37 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 4/5] spi: sun6i: add support for R329/D1/R528/T113s SPI controllers
Date:   Sun,  7 May 2023 02:26:07 +0300
Message-Id: <20230506232616.1792109-5-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230506232616.1792109-1-bigunclemax@gmail.com>
References: <20230506232616.1792109-1-bigunclemax@gmail.com>
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

These SoCs has two SPI controllers. One of it is quite similar to previous
ones, but with internal clock divider removed; the other added MIPI DBI
Type-C offload based on the first one.

Add basical support for these controllers. As we're not going to
support the DBI functionality now, just implement the two kinds of
controllers as the same.

Co-developed-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/spi/spi-sun6i.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 1e9e9a8159d9..292fd6101283 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -739,9 +739,17 @@ static const struct sun6i_spi_cfg sun8i_h3_spi_cfg = {
 	.has_clk_ctl	= true,
 };
 
+static const struct sun6i_spi_cfg sun50i_r329_spi_cfg = {
+	.fifo_depth	= SUN8I_FIFO_DEPTH,
+};
+
 static const struct of_device_id sun6i_spi_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-spi", .data = &sun6i_a31_spi_cfg },
 	{ .compatible = "allwinner,sun8i-h3-spi",  .data = &sun8i_h3_spi_cfg },
+	{
+		.compatible = "allwinner,sun50i-r329-spi",
+		.data = &sun50i_r329_spi_cfg
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun6i_spi_match);
-- 
2.39.2

