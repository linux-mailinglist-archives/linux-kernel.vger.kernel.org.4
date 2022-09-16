Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736AD5BAD78
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiIPM34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiIPM3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:29:41 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDB01103
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:29:31 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n8so8471006wmr.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ZIu7s3K4+u7oP2s+yRQB4MCBJbH4a9+nIR767W2HTCo=;
        b=HM0PX8aBtfDpBSw8wWnR+KIEZ5a+cvTFkcvdZLX41FPb2v5LpVB4XaCOUdCO3NHX/N
         msjEPqqhauJ/vGN7IGoHL0dCihZ/POVO10DiF5QIjnI8w9AaRMNd1EJTBo6fOqr6ExsJ
         8LT5qQPclOQ0H8j2ZgcXno1rp1/wgiMV/Xn7hUynite/sshc7hbG9cgJC4ywlES95ITy
         oW+h9g4JSaC9L9YJUl9M75vSmbvGIm3nebis86mN4zVpREMZSVUofCdjUasT1FYcvG7y
         xg6+YnbFUFZfDDsBDyMWddwCYTwHMo+8Ku1wcTYsKZw3xrBAVKvY+KLc2d84F/cjZGuM
         c0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZIu7s3K4+u7oP2s+yRQB4MCBJbH4a9+nIR767W2HTCo=;
        b=e8UB182IhLVqJokd7VA71+CGCuxP+GXmHt7Vvcg80bm1HhzyD3uAwjYuurFDscAaj0
         VZgO206tEHCKLsxMO9nhegEeyD8/MiZZFtTaL+Ltg0lHvOOWaW0Ad7rv5uP9p6e+MSrG
         ndPtIn9yjC3IHpf+XQ7ZqS14ll3w/KNBYBTSjkznpQig4dfSLDbIN8k2m1wVMzpvm/eA
         E8QWn6M0Tb8wyXFg8WEdOk2H29ukWwoijUjbbDtzkuCSQ1BmlAD/RItq/oCMl4l9MXI5
         X5exofYEoBmAbC9JMy/lIgjKs12YR72Jlsw/6kFLALrE7DLC1uiR1RPKG0KdN77nhhB7
         MagA==
X-Gm-Message-State: ACrzQf11Ve0bWIjQmzmboB3Iv7NmvVrjv4Y+YOe1DR+R/ukjyAdKbjDy
        cRbetxztLog7ezCQ5/cHLn6DIw==
X-Google-Smtp-Source: AMsMyM4XDPi1HUFDfx+5m1YH4AhqH2iOV44V4I7kCA1hJXDpEsim4II/VGFLyyUOJ5EQbgVBizhexA==
X-Received: by 2002:a05:600c:4f11:b0:3b4:bf6c:4566 with SMTP id l17-20020a05600c4f1100b003b4bf6c4566mr1048183wmq.34.1663331370096;
        Fri, 16 Sep 2022 05:29:30 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id m188-20020a1c26c5000000b003b4a68645e9sm1990825wmm.34.2022.09.16.05.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 05:29:29 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] slimbus: qcom-ngd: simplify error paths with dev_err_probe
Date:   Fri, 16 Sep 2022 13:29:09 +0100
Message-Id: <20220916122910.170730-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916122910.170730-1-srinivas.kandagatla@linaro.org>
References: <20220916122910.170730-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Use dev_err_probe to skip printing of deferred probe errors and to
simplify error paths.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index bacc6af1d51e..cec11aa106bf 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1543,10 +1543,8 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(dev, ret, qcom_slim_ngd_interrupt,
 			       IRQF_TRIGGER_HIGH, "slim-ngd", ctrl);
-	if (ret) {
-		dev_err(&pdev->dev, "request IRQ failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "request IRQ failed\n");
 
 	ctrl->nb.notifier_call = qcom_slim_ngd_ssr_notify;
 	ctrl->notifier = qcom_register_ssr_notifier("lpass", &ctrl->nb);
@@ -1575,15 +1573,14 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 
 	ctrl->pdr = pdr_handle_alloc(slim_pd_status, ctrl);
 	if (IS_ERR(ctrl->pdr)) {
-		dev_err(dev, "Failed to init PDR handle\n");
-		ret = PTR_ERR(ctrl->pdr);
+		ret = dev_err_probe(dev, PTR_ERR(ctrl->pdr),
+				    "Failed to init PDR handle\n");
 		goto err_pdr_alloc;
 	}
 
 	pds = pdr_add_lookup(ctrl->pdr, "avs/audio", "msm/adsp/audio_pd");
 	if (IS_ERR(pds) && PTR_ERR(pds) != -EALREADY) {
-		ret = PTR_ERR(pds);
-		dev_err(dev, "pdr add lookup failed: %d\n", ret);
+		ret = dev_err_probe(dev, PTR_ERR(pds), "pdr add lookup failed\n");
 		goto err_pdr_lookup;
 	}
 
-- 
2.25.1

