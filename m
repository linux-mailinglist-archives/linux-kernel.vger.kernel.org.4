Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89725614199
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJaXXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiJaXWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:22:38 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ED715A10;
        Mon, 31 Oct 2022 16:22:18 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso236915wmb.0;
        Mon, 31 Oct 2022 16:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4LiAqleogBkG8NOm3VowQ575ICtW67soXi7PB0llYs=;
        b=cJK+/X3jEyeQ2Es1QFj2uoZp4BYmhWP4k+uzNhatrXacbRSw8ei+x9SzH+tX6LHt47
         K7gUQPZCZ3+sptPPay8wgi2hNjQOQxQRF19KcxDIvek4UsSGXL/uAdZRlAHaLcHIV+I/
         jJ5rULwV0ifD5e56vOt4a5LkbbbJsmoNcaGib5WIRQXGJt7iE453Fx2Sre0cAuISGAT5
         alT9LvH5LgXUSIzJh6WLlO6ni1ZpuJKqhBVB1nJH4kvswHH+G2TUBi9UDrVg349YORUI
         Z1cL5q3KHLphyRQTRyRyKA7buTwK0muwHIVQmSUS5GehZ43ZDQZIpg2XdeNJ/qTv1fLy
         sd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4LiAqleogBkG8NOm3VowQ575ICtW67soXi7PB0llYs=;
        b=qNVibSlG2HHLzwRlKZZJOUCsdcKKyUE/9o16Yw9s/+VukkCud64voG5h4MGI8Nf7Vo
         hqy3q4dvrH3rn2kniM4e480FQvhSwlPs5mYCKhpSBXUPHES50cbtsfm19vxgQHBG4cjk
         rbDsH9xFe5hWYzOeUbuqBKE1a786Lz7q3GT6UrTSSYcpv8xN1vTZ31uU6QLaHMo6pa75
         C6io1WqnTCUjJBHL6dXpUGUZTvFxSgsNy/dC7TkMfAgRbE5VR7a8ePEoWOMB24eRqyU5
         b650papZhEd5Fwf0XL01SFhvIkm2S5LSl6xbu6vwtTus7AXsLrJanekwTky6vHTSmSgs
         W5pQ==
X-Gm-Message-State: ACrzQf2066chCo994PDUAKfgalQbe12j+mGO51gF341vchTTX5OYVDPi
        ONvIeJe+oeteFa2Gpn8D6iuxPsPXE2cQc2JY
X-Google-Smtp-Source: AMsMyM6R2VdJ2gyF7g8C0Bh7WSaajyMcwehD1icOTPDlj8Zv096mXbB349vLgpuktAsZBY4NnR6kVg==
X-Received: by 2002:a05:600c:4e45:b0:3cd:f141:b7d8 with SMTP id e5-20020a05600c4e4500b003cdf141b7d8mr9768739wmq.196.1667258536834;
        Mon, 31 Oct 2022 16:22:16 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:15da:d6ab:ec79:436])
        by smtp.gmail.com with ESMTPSA id l24-20020a1c7918000000b003cf7928e731sm2190343wme.9.2022.10.31.16.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:22:16 -0700 (PDT)
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
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 8/9] media: i2c: ov5645: Make sure to call PM functions
Date:   Mon, 31 Oct 2022 23:22:01 +0000
Message-Id: <20221031232202.131945-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Make sure we call the PM functions while s_stream(0) even in case of
errors in the code flow.

v4l2-core takes care of warning the user so no need to add a warning
message in the driver.

Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4
* Fixed comments pointed by Marco

v2->v3
* Now propagating the first error code in case of failure.

v1->v2
* New patch
---
 drivers/media/i2c/ov5645.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index 6897f542737a..0a889283da36 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -998,15 +998,12 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
 	} else {
 		ret = ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x40);
 		if (ret < 0)
-			return ret;
+			goto stream_off_rpm_put;
 
 		ret = ov5645_write_reg(ov5645, OV5645_SYSTEM_CTRL0,
 				       OV5645_SYSTEM_CTRL0_STOP);
-		if (ret < 0)
-			return ret;
 
-		pm_runtime_mark_last_busy(ov5645->dev);
-		pm_runtime_put_autosuspend(ov5645->dev);
+		goto stream_off_rpm_put;
 	}
 
 	return 0;
@@ -1014,6 +1011,11 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
 err_rpm_put:
 	pm_runtime_put_sync(ov5645->dev);
 	return ret;
+
+stream_off_rpm_put:
+	pm_runtime_mark_last_busy(ov5645->dev);
+	pm_runtime_put_autosuspend(ov5645->dev);
+	return ret;
 }
 
 static const struct v4l2_subdev_video_ops ov5645_video_ops = {
-- 
2.25.1

