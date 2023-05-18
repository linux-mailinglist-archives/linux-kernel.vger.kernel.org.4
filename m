Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0694708AC6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjERVxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjERVxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:53:32 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7283A10C6
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 14:53:30 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-510b6a24946so4633395a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 14:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684446808; x=1687038808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlPtyGS6echPFRqdeAvpqIqZ+88puFfkVYqQZjYT8zU=;
        b=YgMBYOCLpByZ/EQL80He7Q2afIgzQrE7Gz90I5HJ3+i7R21j1YUUB6HSjQCfIaXu4F
         vuqYvfJa4vxjlKx6edW0ulXmmZji+dCo5oS9krthbLCeIfutrLjBkLeiWxjy+anNKrSv
         aw6YQ6Gdr1en3YSox9U2BVbItNwo3nU1s5hdYETU3y2sZin6oCQcLOLaA2u1o47Lfqrl
         8gaXa/d/+KU3vf29fn3lmoIh1IeyS9kMH0sBakxzoUSTP9/438c86XKboj9W0XRz9CpY
         DNH1yBF/52txAEjycx7fSF2c3xeM/qsw/4vzxM3fiWTUIpq/NKIzP17sOOFsiNjx1MFt
         m2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684446808; x=1687038808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlPtyGS6echPFRqdeAvpqIqZ+88puFfkVYqQZjYT8zU=;
        b=fWN5lO8U5aDEfQc5EP/kWOHHVVpoWeKdo4STr1La0YsTeca6ukRiBBPXWRGu2dTYGG
         /X/fbQbgU9yJu31k6BAmxqdiiLWno25+/ah3gOgjN9irJhCDNDVhbF9BxvkrA1+SLKqP
         pc3u7bFbgLHAouflqQ9VB2gLmLqjHNmJWLT/uSRkeAHa7X5nS7/fjFx4hi5cvH/Dd3ml
         s6P+IdP6GTyJ9i5cL/sV9FPZA1386YGtzwlO43yrkM3shwAMIKJOwEXOjm4oCn8bYOi2
         s5N0rQuxlKjXxV0s5YavHrze/FpSTwrrvzlB9L6ZvJS8b6Q+JEyamT1M5dAha4l8GV0s
         1O4g==
X-Gm-Message-State: AC+VfDwie4ZLNOckpJR5B/YVMme9nwDykcWKw/5j+gddi66Z1mchluXG
        +PrJIbzU6gZCtQlS1yKulD84ZA==
X-Google-Smtp-Source: ACHHUZ6sbUp/PSXlEq+nEi8vOQRSKzVi/PMJp0bSD/bKaSHJfRbPjYFPOTILPUAJWBgB9PxERZmJcw==
X-Received: by 2002:aa7:d752:0:b0:50d:b92e:d1dc with SMTP id a18-20020aa7d752000000b0050db92ed1dcmr7069415eds.14.1684446808692;
        Thu, 18 May 2023 14:53:28 -0700 (PDT)
Received: from Lat-5310.. ([87.116.165.75])
        by smtp.gmail.com with ESMTPSA id l25-20020aa7c319000000b0050bd9d3ddf3sm989822edq.42.2023.05.18.14.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 14:53:28 -0700 (PDT)
From:   Andrey Konovalov <andrey.konovalov@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Subject: [PATCH 1/1] media: camss: set VFE bpl_alignment to 16 for sdm845 and sm8250
Date:   Fri, 19 May 2023 00:52:35 +0300
Message-Id: <20230518215235.1668871-2-andrey.konovalov@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518215235.1668871-1-andrey.konovalov@linaro.org>
References: <20230518215235.1668871-1-andrey.konovalov@linaro.org>
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

From the experiments with camera sensors using SGRBG10_1X10/3280x2464 and
SRGGB10_1X10/3280x2464 formats, it becomes clear that on sdm845 and sm8250
VFE outputs the lines padded to a length multiple of 16 bytes. As in the
current driver the value of the bpl_alignment is set to 8 bytes, the frames
captured in formats with the bytes-per-line value being not a multiple of
16 get corrupted.

Set the bpl_alignment of the camss video output device to 16 for sdm845 and
sm8250 to fix that.

Signed-off-by: Andrey Konovalov <andrey.konovalov@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index e0832f3f4f25..06c95568e5af 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -1541,7 +1541,11 @@ int msm_vfe_register_entities(struct vfe_device *vfe,
 		}
 
 		video_out->ops = &vfe->video_ops;
-		video_out->bpl_alignment = 8;
+		if (vfe->camss->version == CAMSS_845 ||
+		    vfe->camss->version == CAMSS_8250)
+			video_out->bpl_alignment = 16;
+		else
+			video_out->bpl_alignment = 8;
 		video_out->line_based = 0;
 		if (i == VFE_LINE_PIX) {
 			video_out->bpl_alignment = 16;
-- 
2.34.1

