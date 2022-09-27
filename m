Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6DB5ED0C8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 01:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiI0XI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 19:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiI0XIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 19:08:53 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E084610D0D3;
        Tue, 27 Sep 2022 16:08:49 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id y15so5855092ilq.4;
        Tue, 27 Sep 2022 16:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=IsAY5Uo5fDObS9RzecYH3SXOEEVbvv/Ubv7Rcm4k0lo=;
        b=e5/yCAkBq6bxMA2mydQO6LPHjJxhQ7xuA4r0JRULl8gyFX3ABxBw6Hii70+Z6PeEVn
         Jb4VdIvQ+xrI/71D/5ECqMpSV++YrkqbSxU6bdl5Cwia2WlsKWJ86G+Eq8LyDwxQo7Bb
         AQkOUIqxynCyUpXtj/hejV0ZCGpRUGrgaQEINFBBf7rZXfXURZ5uqYk/rugOp+B+3wHG
         jHkof7sjOMVGDozi64UNlE8O/7S/uOcLkjPbn+G1RBqy6KyXNjEPpGlsXkxoNmSneusG
         eQdWeZWcDbyS6gnLnu/IL9QTzo3J8a7EPiE/Bj/mTyeivI05UoaUmNQI9XqKPwL6UILf
         Ci+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IsAY5Uo5fDObS9RzecYH3SXOEEVbvv/Ubv7Rcm4k0lo=;
        b=QaxHRjUH3auYxjjyhvNQcwnQTW/mZbXX+jYsfWkNQQHmNmyrw7tSwbpsWjRkMActnM
         erqwYUdi5Hagl6GxN/gAnwSdg+77rwCyR6MTbaGyQWMImiQ6At3Yd0GkwBEf0qMcOZTe
         UGDZ/7nEczA89TvA8ZcMlAqZk7Xk6YAzfmb5oZUx1zKffSw66eKBCccg50tBFl2Td7vx
         2r+jHUzu0nFO3CKNp5nOzjSjdlDGWnGR7KszOCNTkeVODzTZjayaVitJTvo86NGH4zK8
         ceqz5Tw56N30TjHgcoHjDykoUhOtyWNhPZZKVqr3hi5MpyDcLB9SNlE3CyREP5DaXA82
         x7MA==
X-Gm-Message-State: ACrzQf1jXCZSVIlE5AdVJmdW/qskioNAoNb4P2xe/9bVq0qgRH6/o5aK
        cRRF9HArUOeC+perZLr6ePQMqmQrWlo=
X-Google-Smtp-Source: AMsMyM4doNgT90t3gKm+YLNePAieZ1d/mnpYek6gBE9EppFlPZqbGRl5RWuGvxCzzfQ2KZt19s+rHQ==
X-Received: by 2002:a05:6e02:1a49:b0:2f8:e491:3d96 with SMTP id u9-20020a056e021a4900b002f8e4913d96mr1154665ilv.239.1664320128955;
        Tue, 27 Sep 2022 16:08:48 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::ac99])
        by smtp.gmail.com with UTF8SMTPSA id n28-20020a056638111c00b003585ff0233asm1086933jal.150.2022.09.27.16.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 16:08:48 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v5 2/3] pinctrl: qcom: add support for complementary reserved gpios
Date:   Tue, 27 Sep 2022 19:08:32 -0400
Message-Id: <20220927230833.125749-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927230833.125749-1-mailingradian@gmail.com>
References: <20220927230833.125749-1-mailingradian@gmail.com>
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

The driver-provided list of reserved gpios normally overrides any valid
ranges provided by the firmware (device tree and ACPI). When the driver
defines dummy pingroups by itself, it should mark these as invalid but
should not prevent the firmware from specifying more reserved gpios. Let
pinctrl drivers indicate that the reserved gpios list complements instead
of overrides other lists from firmware.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 5 +++--
 drivers/pinctrl/qcom/pinctrl-msm.h | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index a2abfe987ab1..cea1d2af8c88 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -687,9 +687,10 @@ static int msm_gpio_init_valid_mask(struct gpio_chip *gc,
 	const int *reserved = pctrl->soc->reserved_gpios;
 	u16 *tmp;
 
-	/* Driver provided reserved list overrides DT and ACPI */
+	/* Driver provided reserved list overrides DT and ACPI by default */
 	if (reserved) {
-		bitmap_fill(valid_mask, ngpios);
+		if (!pctrl->soc->complement_fw_gpio_ranges)
+			bitmap_fill(valid_mask, ngpios);
 		for (i = 0; reserved[i] >= 0; i++) {
 			if (i >= ngpios || reserved[i] >= ngpios) {
 				dev_err(pctrl->dev, "invalid list of reserved GPIOs\n");
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
index dd0d949f7a9e..734fe7b2a472 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.h
+++ b/drivers/pinctrl/qcom/pinctrl-msm.h
@@ -128,6 +128,9 @@ struct msm_gpio_wakeirq_map {
  *              function number for eGPIO and any time we see that function
  *              number used we'll treat it as a request to mux away from
  *              our TLMM towards another owner.
+ * @complement_fw_gpio_ranges: If true, the reserved gpios list from the
+ *                             driver will not override the reserved gpios
+ *                             list from the firmware.
  */
 struct msm_pinctrl_soc_data {
 	const struct pinctrl_pin_desc *pins;
@@ -146,6 +149,7 @@ struct msm_pinctrl_soc_data {
 	bool wakeirq_dual_edge_errata;
 	unsigned int gpio_func;
 	unsigned int egpio_func;
+	bool complement_fw_gpio_ranges;
 };
 
 extern const struct dev_pm_ops msm_pinctrl_dev_pm_ops;
-- 
2.37.3

