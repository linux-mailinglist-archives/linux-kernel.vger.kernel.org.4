Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F81F67FC25
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 02:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjA2BfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 20:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjA2Bem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 20:34:42 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838536E90;
        Sat, 28 Jan 2023 17:34:40 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so7812374wma.1;
        Sat, 28 Jan 2023 17:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFBA6s5bUSQHKQZCR86FqzNyuwtdgl9QTJx6x9ni9F4=;
        b=VH5GtG2GT8h1gDoyFtU+s0tcejchUSM7o9pZfktwqqMoncROB3KT271+9lnG8DvUlu
         Z18QiusI/CkhwGksNq+j1M6fxmGmjfq48ji++DoLiqKvfl08R1M+THPACq0FjYXT+rM2
         T/4Ep0s1MRJ+XF5sgeRTpuv/qwEPUb+Vi8L986VvpFkdR4da5oaUeE6BzkMtJsKjbGAu
         RBxk7+r+fyRo+SNNvVkJpyIEdGVwH+tQGcH6zFufPH7c/pSMhwl44KwVQcgR8l2GKyot
         WDb28KOtsZkdasgmJT+MXDs8CziuMBb6vFjo6lGNNVsiMDYt3VuSuFW9gJt8ir8ANhnK
         OM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFBA6s5bUSQHKQZCR86FqzNyuwtdgl9QTJx6x9ni9F4=;
        b=hlJ7N3Fimw8plmvJdXJW+948Pl03A9jOicnyavMs9j8+iylanIhu1BJ5D1/IaeY2Oc
         lxJSoJ0E/89qY8cowA2oDoWaiFe/NYaUJgYLvrVeaahAC486Vp5rzjY84zjS+F6cvHeN
         TdZHrneoiesS+I2zHcIH6Oykbj8oe/dJ5NTs+9dpOnpBMM75zIIROaYyx4Vk2Efvnhum
         J9pbFAi8yG+jzGbA8HcPYzBjS4PDzEPLDw1r4DONCiDk4Ls/T8iHczf2iYuADxnxApfL
         dCeMfcZw5yaGgX1VFD6p7WsFCTg3hHzYWBrvaDuArC7+/cTQKT//IiNWRfbuEkvPqtxC
         qZkg==
X-Gm-Message-State: AFqh2kryAxiFoNjgcAXNXh4VLAANiiZbZbL6O+H7QA5M2l364qKXrf0m
        F9mFCiI/Go2GARyg9zS72a/F86Eud8Y=
X-Google-Smtp-Source: AMrXdXsE73BjVrDiu1Be+/qn/WFA+vMxgCMo1PvaH0Id3EU6JhoDwuyzVYqPUQQCBV1cR7XoeCf63w==
X-Received: by 2002:a05:600c:540d:b0:3d9:fb59:c16b with SMTP id he13-20020a05600c540d00b003d9fb59c16bmr41793830wmb.36.1674956078932;
        Sat, 28 Jan 2023 17:34:38 -0800 (PST)
Received: from localhost.localdomain (143.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.143])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c434700b003dc3f195abesm5197132wme.39.2023.01.28.17.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 17:34:38 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] iio: pressure: bmp280: Make read calibration callback optional
Date:   Sun, 29 Jan 2023 02:33:05 +0100
Message-Id: <61b0aee1c4838caed97774dccd88ed9fae279f76.1674954271.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1674954271.git.ang.iglesiasg@gmail.com>
References: <cover.1674954271.git.ang.iglesiasg@gmail.com>
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

Newer models do not require read the calibration parameters and apply the
compensation algorithms in the sensor.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6467034b1d3e..22addaaa5393 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1631,10 +1631,12 @@ int bmp280_common_probe(struct device *dev,
 	 * time once. They will not change.
 	 */
 
-	ret = data->chip_info->read_calib(data);
-	if (ret < 0)
-		return dev_err_probe(data->dev, ret,
-				     "failed to read calibration coefficients\n");
+	if (data->chip_info->read_calib) {
+		ret = data->chip_info->read_calib(data);
+		if (ret < 0)
+			return dev_err_probe(data->dev, ret,
+					     "failed to read calibration coefficients\n");
+	}
 
 	/*
 	 * Attempt to grab an optional EOC IRQ - only the BMP085 has this
-- 
2.39.1

