Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDAA6E3100
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 13:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjDOLBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 07:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjDOLBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 07:01:05 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4667693
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 04:01:04 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id bx15so19622848ljb.7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 04:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681556462; x=1684148462;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gxs5lrZiuUMHb5dYpFm0IIyfMKZX7kJZib+sRP8GGTk=;
        b=kdlO5bcc480qfQKisepn4Mr4sTybTQtn5tGn5m2rtYjUSm0Gjtx9zaWF0anm/S/Trp
         ggFU/W7Y4BU3H2UGjcxzVYASVZj3yCE/d0IiJM6G+GAH7wYPETYyUaGpLivow4Re9qw5
         XEuYgJA/fFsgxa9QG2MoHLf2wuRvk5ZjtOejmsbTr4iTd0L4JrbPdgwvABJnkvF6xI8Y
         if4BRED7+IMf87V3Zwyml23sGO76XvZsNsDoO7Pgj8sUluxMvmWFaxA1QRpfoIVwIcqc
         3C5GMtA5nvnbzgAS4vSEaAEIWKF/dL8xOk7m3+DQU3ZAtbYMkorGMT4z1tDUJz8vCGPt
         Wh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681556462; x=1684148462;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gxs5lrZiuUMHb5dYpFm0IIyfMKZX7kJZib+sRP8GGTk=;
        b=QNqldWcUE7guqnkh0Gy2TTDfNIVzaIl7j0VNn3J5dYkSOIT1ssnpLjIwgdRfDCGnn/
         TSrn0/9AWS8TJ0BquKguxq62NG2NT6OL1ipqXxUPq2Ku5N5/T9PLyF7iV4hpl5Btjq5r
         Wg6fTXGpo5tFxNpF+MQ7pAwyQcudHaZBUZFls/6gO1crTDH7pAyvPltQ0XPpaUwHoyFQ
         STqpDb3evJbN+MYD0qWAfTTMhpDwII9EDjooYl1hOZbxkutlp14QHpUpSG5FV8Y1CNW9
         UoRrmMqscJlWZRgxAfnMvFfn74qy4UsMmqZeVQs5koPH8ZNTeZN/76o7McWtodDQVOxi
         4Whw==
X-Gm-Message-State: AAQBX9fL7ZuVjPTPNNr7m0wErEwdac7/q7qquAMIeei7BLXAtU398fOc
        0vU89utUprakpYpf/Tin5RU3GTRoS+DVBmX+EKk=
X-Google-Smtp-Source: AKy350bVjU523dSJdWRv3YB7nrXwNMFf/bpzrH+1dTJMw8eM6dkJ/1UM5ONhbyeFmmLTHRGZyoRWkw==
X-Received: by 2002:a2e:7c16:0:b0:2a7:6544:8e42 with SMTP id x22-20020a2e7c16000000b002a765448e42mr2680129ljc.19.1681556462447;
        Sat, 15 Apr 2023 04:01:02 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id o6-20020a2e7306000000b002a77792f2c5sm1250470ljc.62.2023.04.15.04.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 04:01:02 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 15 Apr 2023 13:00:30 +0200
Subject: [PATCH] drm/panel: novatek-nt35950: Improve error handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230415-konrad-longbois-next-v1-1-ce695dc9df84@linaro.org>
X-B4-Tracking: v=1; b=H4sIAM2DOmQC/x2N0QrCMAwAf2Xk2cBWOyb+iviQrHELllRSlcHYv
 1t8vIPjdqjiKhWu3Q4uX61arMFw6mBeyRZBTY0h9OHcx2HEZzGnhLnYwkUrmmxvvMQpjRMxxxS
 gpUxVkJ1sXltsn5ybfLk8dPu/bvfj+AHXrGiqewAAAA==
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681556461; l=1735;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=GYsGlCcltfmdrDXO+aOe/68DSe4OLB+OCq4VQr9q5rk=;
 b=qX0g3RtIKAy8Nfq9bAUTgYgSz6DAnZPpT76Q7UeSQBoRm7gqApfY3f/4y8hglOm2kjT2dlObSL6K
 TK783grBCgyvBdW+Kh5+CCNxlGyjQtfUzV3PRVHcLhVHtNYdnfgA
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a very peculiar case when probing and registering with the secondary
DSI host succeeds, but the OF backlight or DSI attachment fails, the
primary DSI device is automatically cleaned up, but the secondary one
is not, leading to -EEXIST when the driver core tries to handle
-EPROBE_DEFER.

Unregister the DSI1 device manually on failure to prevent that.

Fixes: 623a3531e9cf ("drm/panel: Add driver for Novatek NT35950 DSI DriverIC panels")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/panel/panel-novatek-nt35950.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
index abf752b36a52..7498fc6258bb 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
@@ -585,8 +585,11 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
 		       DRM_MODE_CONNECTOR_DSI);
 
 	ret = drm_panel_of_backlight(&nt->panel);
-	if (ret)
+	if (ret) {
+		mipi_dsi_device_unregister(nt->dsi[1]);
+
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
+	}
 
 	drm_panel_add(&nt->panel);
 
@@ -602,6 +605,9 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
 
 		ret = mipi_dsi_attach(nt->dsi[i]);
 		if (ret < 0) {
+			/* If we fail to attach to either host, we're done */
+			mipi_dsi_device_unregister(nt->dsi[1]);
+
 			return dev_err_probe(dev, ret,
 					     "Cannot attach to DSI%d host.\n", i);
 		}

---
base-commit: 035ba5f9cf511b9299fd9c9d0688ef930d33c886
change-id: 20230415-konrad-longbois-next-847d57abb4d2

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

