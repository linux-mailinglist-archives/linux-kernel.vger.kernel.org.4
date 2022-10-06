Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B145F71B0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbiJFXWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbiJFXWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:22:32 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E5FCD5EC;
        Thu,  6 Oct 2022 16:22:31 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id r20so1750633ilt.11;
        Thu, 06 Oct 2022 16:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+Xo/G55EiERjQPHhle1qrOHDFbfvYNh2DEdV62/lG6s=;
        b=fO1a8EP+HwgtYlc2HlxT7DHN2H5u3ogQw53bVBfZ0MCCmTM4M7n3ijhjF3iXjC2Fmj
         um7eRWaPvodm7yT4rstLUHvZHL+BmLvRf3YWRUwORCzFe5pIJFUcamH6S8wWd9GlWiQ1
         K7NIt0peEuxBmi2QXDd0MtjkkVMu1dMD6PvH4jG7xMtYENIr/PGlvPaBniJy38N0evz9
         BzONwy3aKn7t/L5FSZGN7tELjllXjg5yhhS83KeOJXYHzogEvj9Wd8aAW7j5RSY706dL
         R9qBlmTOOksvZP/jyIy7b5W0pb9Wy4BJkv9rC/2rD+TBThZNAPZPONANRshsznc44zWF
         vdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+Xo/G55EiERjQPHhle1qrOHDFbfvYNh2DEdV62/lG6s=;
        b=LNGK3ru9+MrfRSRZbe2IJMjuHsHuenVtLMwyQiHHSctP/Db/RBjpM0l3tyeXwe7Waa
         xhhdIAuTOm5XPo8mm3MHzj0vJFQYNooqBM1skAfkvZybCKYddmKExdq/kYgKR46qsjy9
         Cx360quloJPPZcjXefXoXciofndMFLiyvDiiGdrFcCcmdsviCFXK8DFUdyHxROcZVU4L
         b4zelFtpQjkQI4W58gWbFElNLwPtLvRqewBz4e5FZCBtca6ahAKpF+UI9bqqP1woDKPD
         qUQsbEgBvOw3y2Btbu0jy3xOOzbunND0Z1HcnpVQfBtgx9ggnqFXprLUumBVhLM7PdDj
         mSfg==
X-Gm-Message-State: ACrzQf0xTU8nUJpZr2eAoYcFfPDt40C9UhfJ2s3Mmwnugf9vkg5wGQJQ
        Ys0MWO14C2qyePY+aJc8BAbeUWQqM/5rDA==
X-Google-Smtp-Source: AMsMyM6s5E4haD0Pg6ScMPylv4PqofKjTBF0rBIoontaBaARwuBGHtEaM3vWi3YgUlhLd40cXKeR5w==
X-Received: by 2002:a05:6e02:19cd:b0:2fa:22ce:5c05 with SMTP id r13-20020a056e0219cd00b002fa22ce5c05mr910900ill.305.1665098550965;
        Thu, 06 Oct 2022 16:22:30 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::d5cc])
        by smtp.gmail.com with UTF8SMTPSA id a10-20020a027a0a000000b003627dc2a94esm273820jac.96.2022.10.06.16.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 16:22:30 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v8 2/3] pinctrl: qcom: do not reinitialize gpio valid mask
Date:   Thu,  6 Oct 2022 19:22:18 -0400
Message-Id: <20221006232219.37505-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221006232219.37505-1-mailingradian@gmail.com>
References: <20221006232219.37505-1-mailingradian@gmail.com>
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

It may be necessary for some devices to specify reserved gpios in the
device-specific DTS, in addition to the reserved gpios common to all
devices with a given SoC. Remove this bitmap_fill() call so that the
settings applied to the gpio valid mask by DTS are not overridden by
the driver's reserved gpios.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index a2abfe987ab1..f697e9f64360 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -687,9 +687,8 @@ static int msm_gpio_init_valid_mask(struct gpio_chip *gc,
 	const int *reserved = pctrl->soc->reserved_gpios;
 	u16 *tmp;
 
-	/* Driver provided reserved list overrides DT and ACPI */
+	/* Driver provided reserved list overrides other settings here */
 	if (reserved) {
-		bitmap_fill(valid_mask, ngpios);
 		for (i = 0; reserved[i] >= 0; i++) {
 			if (i >= ngpios || reserved[i] >= ngpios) {
 				dev_err(pctrl->dev, "invalid list of reserved GPIOs\n");
-- 
2.38.0

