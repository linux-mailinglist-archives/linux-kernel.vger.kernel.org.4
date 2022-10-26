Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C8B60E197
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbiJZNHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbiJZNHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:07:32 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7886AFAE72;
        Wed, 26 Oct 2022 06:07:27 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i5-20020a1c3b05000000b003cf47dcd316so1443737wma.4;
        Wed, 26 Oct 2022 06:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEu7I9A+1d1yBU6Am+OewhMcYYZSOczpTnlVQrd1DYM=;
        b=cjJngFxaJaLl708ZHAdh+fxZXdLGT/ZiLDibcXXYBuerYzqM9/tyfJBWfNrMzuNe9z
         T973GjsyzcMJcuDxy1bfyy0r3+27tKl1mU7rOPvIL0E+L70YfuVk5qQX4GS8n3xrD5BL
         7SLD3WnQZmINrOU90gL3aMB1ylLzppKrD+1WhOhtRLOngmLO91oNbeB4nH9i/2jVCKR0
         cjoJ2OVRresDZKJWx93l14R8dMGAEZRJAfPSFRQETjHB69lWPdW75cHwsVK2iO6BqLFe
         KXEZuD+DRc7jbNHxSF56p33bZPIwKo2u3AhKMshoNYfdHMjdT6RJTZt7EOrGVf5uX3Wh
         /vrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEu7I9A+1d1yBU6Am+OewhMcYYZSOczpTnlVQrd1DYM=;
        b=l7udgUfNgHzsxdoefOFyYx5b+8KecTlYMMi9I6AghecrLGp3GzDo8eE+CUqM3DsxFX
         +LejW3e2ygRK6wx4jMW8O79IYo5FPADiryNuBNaeH2vzAIMC23ne/AD24VVkJada3+Qj
         mDCy6awrfetRCg9xh6lmd7f5WXqLcMLQwWMBQn6antoz6r+c8RKiEMmW1o7WfqLRDNrf
         27zP3PPNQpgqMWFkRcI5I9LflieNaXMWdQnnXATCt0y1wHXCTLX4SdaTLqhH/zz77Zi8
         /60rRtiKVXkOv/g+ZBWYmMGiGHEy6krAbJuVuHZ2CskXNmHsi5USizaV8q6Yq01SZ1DC
         66pg==
X-Gm-Message-State: ACrzQf2UioojMZI9ECBK7JXh2+of8GJxmBgkyFM/ZmcLjajoowQ2tPWY
        IwQULA6Zff17bdMc14g9yzg=
X-Google-Smtp-Source: AMsMyM5cKNni+vS1VdAMcU0kGbWUB5mxeo7A5g4R+eDKuIjEUyZL8tXaPGk7kVdX3RAfayb2IlMuEQ==
X-Received: by 2002:a05:600c:3d08:b0:3c6:fb56:ac9f with SMTP id bh8-20020a05600c3d0800b003c6fb56ac9fmr2471277wmb.193.1666789645913;
        Wed, 26 Oct 2022 06:07:25 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:cc:c67c:46e:319e])
        by smtp.gmail.com with ESMTPSA id l3-20020adfa383000000b002366eb01e07sm5245433wrb.114.2022.10.26.06.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 06:07:25 -0700 (PDT)
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
Subject: [PATCH v3 8/9] media: i2c: ov5645: Don't return early on failures for s_stream(0)
Date:   Wed, 26 Oct 2022 14:06:57 +0100
Message-Id: <20221026130658.45601-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Make sure we dont stop the code flow in case of errors while stopping
the stream and return the error code of the first error case if any.

v4l2-core takes care of warning the user so no need to add a warning
message in the driver.

Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3
* Now propagating the first error code in case of failure.

v1->v2
* New patch
---
 drivers/media/i2c/ov5645.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index eea3067ddc8b..5702a55607fc 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -996,17 +996,22 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
 		if (ret < 0)
 			goto err_rpm_put;
 	} else {
+		int stream_off_ret = 0;
+
 		ret = ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x40);
 		if (ret < 0)
-			return ret;
+			stream_off_ret = ret;
 
 		ret = ov5645_write_reg(ov5645, OV5645_SYSTEM_CTRL0,
 				       OV5645_SYSTEM_CTRL0_STOP);
-		if (ret < 0)
-			return ret;
+		if (ret < 0 && !stream_off_ret)
+			stream_off_ret = ret;
 
 		pm_runtime_mark_last_busy(ov5645->dev);
 		pm_runtime_put_autosuspend(ov5645->dev);
+
+		if (stream_off_ret)
+			return stream_off_ret;
 	}
 
 	return 0;
-- 
2.25.1

