Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A832161417E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJaXWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiJaXWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:22:10 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B9E14D04;
        Mon, 31 Oct 2022 16:22:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so11830703wms.0;
        Mon, 31 Oct 2022 16:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEzFrhTkWeCjs8Cm9lOhIpriWE8/5AdjGdiuH64P3Yc=;
        b=PT4L1vjavEaxPRpEIodvzJuUESfGuBT+zTCjle8LroCDLCvGpDzrHsmG1iz+HP6zRQ
         e2TtL68l9ZunbfMLuwYnWdlE84NwQmn+cMaNPBNXjqglleM2mF36fGuIxynWrisPAaON
         +kakU5urRZqjz7wdXuiMQDg2jVrRshNJX/OaCzTqhmkklmrcm6PAO+F/9QStgaUojnmF
         vOc9Nm4pr+dQisstoXvDA6CENVYvuXkUKJQH1wK/63O7yyEkTBwg0/Ydzhl6LRSO+/c1
         rTn4r/AkrcHR7Cw8K6k3grk2FAgQKbkzoUkXlGr2hyVaLdRcLY5oAMY6JfBxr/JxIdjw
         hMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEzFrhTkWeCjs8Cm9lOhIpriWE8/5AdjGdiuH64P3Yc=;
        b=epvcAbM58ddr2+CxhmFb2m6Ndl6YaZd7gPxx2n9IvH0I/im8GziiQV2ZwgcKorkUa0
         Y13LAns9ENVhZBHBkCT0vHBfHOODacq/09Y2kq4piXvpcm7lycG+3Ny0egQbvua41QYc
         uNHiyEdR6zNpIXAe5kWQncDNhl5ysZ3uUnFKFCK789E1Qa6ilc+Mcu82IrIOy+meCMYF
         ImNAdjZRa8pMLWk9NTIWcoPDazIg1Lq+s/QMbqhCh83afM9vkQZHryl5AT/2AKo2edOk
         M1J4dzEmzcTLrgd738QEjou6ZOY6fmdRRkZAnWLVMfG7DNiIwrcjqo83ovcu4EcXWqSS
         dBew==
X-Gm-Message-State: ACrzQf384pQDoW8Xpvtfs8zlrlvdOvQoSkTF1ffa2IYy8I5yXn53j2Ni
        EU9heW7aaWUkx31EdE2gKrE=
X-Google-Smtp-Source: AMsMyM5TismXTZIFkjjeFN7VZPXoAt37JH4GYKLKFt9pAmo6rv7ZxGtL94Tp26DOy9ExUOUf5NAeoQ==
X-Received: by 2002:a05:600c:46ce:b0:3c6:f274:33b2 with SMTP id q14-20020a05600c46ce00b003c6f27433b2mr9790385wmo.27.1667258528012;
        Mon, 31 Oct 2022 16:22:08 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:15da:d6ab:ec79:436])
        by smtp.gmail.com with ESMTPSA id l24-20020a1c7918000000b003cf7928e731sm2190343wme.9.2022.10.31.16.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:22:07 -0700 (PDT)
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
Subject: [PATCH v4 1/9] media: i2c: ov5645: Drop fetching the clk reference by name
Date:   Mon, 31 Oct 2022 23:21:54 +0000
Message-Id: <20221031232202.131945-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031232202.131945-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221031232202.131945-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v3->v4
* No change

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

