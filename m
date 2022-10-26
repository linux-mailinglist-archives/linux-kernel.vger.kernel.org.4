Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FAD60E17F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiJZNHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiJZNHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:07:21 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3718FAE21C;
        Wed, 26 Oct 2022 06:07:18 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bp11so25675177wrb.9;
        Wed, 26 Oct 2022 06:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyVNISqKQi9jXd38wQpw8MDXfXd5f1BICV0pIG254pc=;
        b=U/tL7gRoPuAUkGJ6rjM8DuHdAsQkYwzQ6cXMYcI1bN3yzkj4m7DrrkVuRNujMOWmP6
         cky4BTcDrY4w8N7ExDcfz4pdyc+/ir9rcUZUPfkW3atK5e2/NxqksC4tuVG5ylJ5DNSm
         Vg+W7KPYaPLk3oYsp8/+T34ReQ/w4itM5E9PQ+lVLArhrF58+g2QsMSsGwIKFTpzJe7W
         CR1kMgtPLTLanukzhavxHsRAexhFCOPruKYxK8f351dO0Boqjm9MUCZuVsUAeXQ71N6k
         G8+4gwGSKDlEM+m4Nonjj647CRiJzGW+x3wWq6FYln4NSQtZ8c6lKZVlMGXdAb2dE1sS
         Yd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyVNISqKQi9jXd38wQpw8MDXfXd5f1BICV0pIG254pc=;
        b=aUnSyTpD60+yMB7xEDFVmEcSPhCOcIJzz+kZxgPRHPg6hL1/BFdmyCK3VVSU7MwgDv
         AI7HnBpvZza0Ie0Kw2zZbIyN369yJbZ3Ng1L1hEL0wNlwiTCO0NfNiWu8it7g13YpDmK
         yeziIgAxgBbHduWo8rBW0c7m3OT8IxISSyQfgVK6IPaQgh4X/qySfqDxRSSKWbpmEqJ+
         uNnQwZ/h5qQtxCv27seUyXcFK3ZYtYgrJb+gz6Q00v7K0jxHY82cXUr7AzU65geAZimE
         nA6fdIHpLGgb3hxHhg6161eDBA5bisyVR0PUxcTobOZ8mYPSObZ9iLjdjrO/MJDTfG+P
         mZrQ==
X-Gm-Message-State: ACrzQf06N/5k2S0VBb83wMAFtxAAxF/BUPcmkiO3cPjDivAiSlQpJ8DP
        UI0ehJjrHK3kvsDdC+sfoGs=
X-Google-Smtp-Source: AMsMyM6dkyokXKAuIfga7S2q7xmvYNtJBmrXeJK+/bn7qRQKvEt6c1fmeUaVN2JXqblEZTrTjUdFlQ==
X-Received: by 2002:adf:e785:0:b0:236:5998:67a0 with SMTP id n5-20020adfe785000000b00236599867a0mr17412045wrm.414.1666789636745;
        Wed, 26 Oct 2022 06:07:16 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:cc:c67c:46e:319e])
        by smtp.gmail.com with ESMTPSA id l3-20020adfa383000000b002366eb01e07sm5245433wrb.114.2022.10.26.06.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 06:07:16 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Shawn Tu <shawnx.tu@intel.com>, Jacopo Mondi <jacopo@jmondi.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v3 1/9] media: i2c: ov5645: Drop fetching the clk reference by name
Date:   Wed, 26 Oct 2022 14:06:50 +0100
Message-Id: <20221026130658.45601-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026130658.45601-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221026130658.45601-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The OV5645 sensor has a single clock source, so just drop fetching the
clk reference by name.

This is in preparation to drop the "clock-names" property from the DT
binding.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v1->v3
* No change

v1:
https://patchwork.kernel.org/project/linux-media/patch/20220919143350.176746-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 drivers/media/i2c/ov5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index 81e4e87e1821..47451238ca05 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -1090,7 +1090,7 @@ static int ov5645_probe(struct i2c_client *client)
 	}
 
 	/* get system clock (xclk) */
-	ov5645->xclk = devm_clk_get(dev, "xclk");
+	ov5645->xclk = devm_clk_get(dev, NULL);
 	if (IS_ERR(ov5645->xclk)) {
 		dev_err(dev, "could not get xclk");
 		return PTR_ERR(ov5645->xclk);
-- 
2.25.1

