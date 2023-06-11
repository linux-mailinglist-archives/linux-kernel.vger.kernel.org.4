Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43F872B231
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbjFKOFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbjFKOEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:04:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AE11BE4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f6da07feb2so34523535e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492240; x=1689084240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aoy/xzTFMDxWBDKIvAVVntbDDOtT71yup8EagJsGpIA=;
        b=i5dVRXoue9OVf98cjFJwqsGRZDcEoPRmw8E1oGwUZsdSi9OkR/0fR+Sj/dY0RGS/ZV
         O3po9+volhPJVXc7veSWl3HKyffsrKIvtILn6BLPvAW73NpKbKCuOMeAAPOUQ+/yn9RD
         xnjQnQeIKxuGBeSwzS8NjaVfMSTDyg7FAW15N6R9NWJ6GPMq0JxJjxbI+tptp7Ho6/37
         wlGCHhGDl316mQem978bCahnucjHYOrPmVbQlPlAtxpbXo8izDCvd8Gubnv/gA5F1nV3
         zX5VS5QQtPv1jERplLnB3e525haYUdMAcfBmcq7UKRN+tJwUizPBHgC/FbRVOgUwvvUK
         /xCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492240; x=1689084240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aoy/xzTFMDxWBDKIvAVVntbDDOtT71yup8EagJsGpIA=;
        b=SMu+84ijeJS84F8qsL0oU1uak9C2Vi9/OKOhb19Sv0Gnah/ScUJULV9+nLQXjKfbnt
         O6c54vSQthI5iwh9+zrPoF6naT8ecSMyKUpnEjALk/SREYb66sPV2PoWGnCBG8L8UO6z
         M1gDg576twn4MXidcBAUexiREFzrlz4NfAASBsoBfAwqQdFgaDjJAA0IFZYxVTdG+i/t
         XiOnAnEW0LA2olV0/cOtrC+M668ttsvRYHQROIjeDAFYzjMB208OYYxsOpG3/nf5YGsW
         Ujtv+ExcaZwsJff+D3KcLqX+F7/M8aDIXT6v9nWPhq2qH1JOF3E51FyKbD8Ozn7x2CkN
         8Oog==
X-Gm-Message-State: AC+VfDzCCSg+jisr8NyAmOddW0Qm7DxmSfMBeuTqUVR6RGqtN04g/KKC
        5c2vSzMKmWUNFeK81nw0YOPLgg==
X-Google-Smtp-Source: ACHHUZ5AKITCV4XE9x0J26TqEDLSRYgE7hZcdaVroypUFRnASqQmBsXuKNEyBrGyLdyF87YfKZKvHQ==
X-Received: by 2002:a7b:ce07:0:b0:3f7:f584:5791 with SMTP id m7-20020a7bce07000000b003f7f5845791mr5425980wmc.35.1686492240110;
        Sun, 11 Jun 2023 07:04:00 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:03:58 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 12/26] nvmem: rockchip-otp: Improve probe error handling
Date:   Sun, 11 Jun 2023 15:03:16 +0100
Message-Id: <20230611140330.154222-13-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
References: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Enhance error handling in the probe function by making use of
dev_err_probe(), which ensures the error code is always printed, in
addition to the specified error message.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Tested-by: Vincent Legoll <vincent.legoll@gmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/rockchip-otp.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index 439aea1f8874..84bf956cc4e1 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -235,10 +235,8 @@ static int rockchip_otp_probe(struct platform_device *pdev)
 	int ret, i;
 
 	data = of_device_get_match_data(dev);
-	if (!data) {
-		dev_err(dev, "failed to get match data\n");
-		return -EINVAL;
-	}
+	if (!data)
+		return dev_err_probe(dev, -EINVAL, "failed to get match data\n");
 
 	otp = devm_kzalloc(&pdev->dev, sizeof(struct rockchip_otp),
 			   GFP_KERNEL);
@@ -249,7 +247,8 @@ static int rockchip_otp_probe(struct platform_device *pdev)
 	otp->dev = dev;
 	otp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(otp->base))
-		return PTR_ERR(otp->base);
+		return dev_err_probe(dev, PTR_ERR(otp->base),
+				     "failed to ioremap resource\n");
 
 	otp->clks = devm_kcalloc(dev, data->num_clks, sizeof(*otp->clks),
 				 GFP_KERNEL);
@@ -261,18 +260,22 @@ static int rockchip_otp_probe(struct platform_device *pdev)
 
 	ret = devm_clk_bulk_get(dev, data->num_clks, otp->clks);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "failed to get clocks\n");
 
 	otp->rst = devm_reset_control_array_get_exclusive(dev);
 	if (IS_ERR(otp->rst))
-		return PTR_ERR(otp->rst);
+		return dev_err_probe(dev, PTR_ERR(otp->rst),
+				     "failed to get resets\n");
 
 	otp_config.size = data->size;
 	otp_config.priv = otp;
 	otp_config.dev = dev;
-	nvmem = devm_nvmem_register(dev, &otp_config);
 
-	return PTR_ERR_OR_ZERO(nvmem);
+	nvmem = devm_nvmem_register(dev, &otp_config);
+	if (IS_ERR(nvmem))
+		return dev_err_probe(dev, PTR_ERR(nvmem),
+				     "failed to register nvmem device\n");
+	return 0;
 }
 
 static struct platform_driver rockchip_otp_driver = {
-- 
2.25.1

