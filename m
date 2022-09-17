Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0ACC5BBA9C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 23:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiIQVJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 17:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiIQVJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 17:09:34 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B052AF4;
        Sat, 17 Sep 2022 14:09:32 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id g8so17481165iob.0;
        Sat, 17 Sep 2022 14:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TJGVbLYqargar4DAZ5jQTcR9l+kJlg0aeLqRChhr/3Q=;
        b=iMr3MX6bUhYYBtc4CLD1jBlqFWY+Gv5nVkge6JZIjLUCR5PNplqmDCae+NedLya+gO
         r9g/D9ZvIJzXUaQxLGM4IPhwzBXhKLMhpt1mcQm+kXXdIZU3Kbi7IgwPUrhEDQKcwgeo
         J9QZxxTGMWaUEQqxQlFbB9EjSjTB+lM7ZZD1kGuPp6rPtOPlSaMNTKUcJFxcleMkBYIQ
         fVnYfBgzlaeNPB9mzxSGLaQ5Z3aMEOU5r6vWKWutgP3ZsWRQ1nucJjDwMi55f76+uZip
         1mtUie9CBrVYQ11L8OXlE84/6fUHqbw4j+bUp5gbHyW8dfTqhfQlPzEkOAMRecly6cmT
         yTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TJGVbLYqargar4DAZ5jQTcR9l+kJlg0aeLqRChhr/3Q=;
        b=ue/MOBjhNwSpiSeQ+KJJoFdez+YJ+TeIfpG5ohWnzDyBmmwqsCWw+ixhej2T55x0vX
         r1KrfZfvK42ZNS7Xx5OjpqYCQzvg3iCUWvOtyRnIE2Sa78Ttr0w5T/SQCu+mSzoxNqlG
         JrrwAKqkcI//VHdDXCRTZ5R+bo+gW0RCDo/iQDJxPqSmejTvx1kRhjs2goVe3qWd6oWb
         ssjZoO8xQFnjfjtl8w/yqAooiugK7sFb+aLahRjapl58oVL4ImfMhXi0nWudgGLfvy9m
         CFlSAK98X58voAdRAkDvMpWY+zA54hJkIuNYsOg7+rwq18RehdVLRD4SJIZD5ORj6gQs
         U4OQ==
X-Gm-Message-State: ACrzQf2CgcSTK/eNTgpoZbqKBCQyYeQ8vvHpAFjpymSxnkYOuVQvJVT7
        ABj6QvSCDI3aiC9qGGgPhnFUIZjHzN0=
X-Google-Smtp-Source: AMsMyM6EYZBdbThuqXzRXIvJrgJWseCfBbjA0TwxcG7sAZ5qp0Vc0iN3v+0tD/U5j2eIu5dmKAiRqQ==
X-Received: by 2002:a05:6638:3892:b0:342:8aa5:a050 with SMTP id b18-20020a056638389200b003428aa5a050mr5385258jav.145.1663448971352;
        Sat, 17 Sep 2022 14:09:31 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::2542])
        by smtp.gmail.com with UTF8SMTPSA id c4-20020a029604000000b0034d90222997sm3765592jai.66.2022.09.17.14.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 14:09:30 -0700 (PDT)
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
Subject: [PATCH v2 2/3] pinctrl: qcom: add support for complementary reserved gpios
Date:   Sat, 17 Sep 2022 17:09:14 -0400
Message-Id: <20220917210915.194840-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220917210915.194840-1-mailingradian@gmail.com>
References: <20220917210915.194840-1-mailingradian@gmail.com>
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
 drivers/pinctrl/qcom/pinctrl-msm.c | 3 ++-
 drivers/pinctrl/qcom/pinctrl-msm.h | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index a2abfe987ab1..7bd50df3930e 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -689,7 +689,8 @@ static int msm_gpio_init_valid_mask(struct gpio_chip *gc,
 
 	/* Driver provided reserved list overrides DT and ACPI */
 	if (reserved) {
-		bitmap_fill(valid_mask, ngpios);
+		if (!pctrl->soc->complement_fw_reserved_gpios)
+			bitmap_fill(valid_mask, ngpios);
 		for (i = 0; reserved[i] >= 0; i++) {
 			if (i >= ngpios || reserved[i] >= ngpios) {
 				dev_err(pctrl->dev, "invalid list of reserved GPIOs\n");
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
index dd0d949f7a9e..c13a02b0005c 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.h
+++ b/drivers/pinctrl/qcom/pinctrl-msm.h
@@ -128,6 +128,9 @@ struct msm_gpio_wakeirq_map {
  *              function number for eGPIO and any time we see that function
  *              number used we'll treat it as a request to mux away from
  *              our TLMM towards another owner.
+ * @complement_fw_reserved_gpios: If true, the reserved gpios list from the
+ *                                driver will not override the reserved gpios
+ *                                list from the firmware.
  */
 struct msm_pinctrl_soc_data {
 	const struct pinctrl_pin_desc *pins;
@@ -146,6 +149,7 @@ struct msm_pinctrl_soc_data {
 	bool wakeirq_dual_edge_errata;
 	unsigned int gpio_func;
 	unsigned int egpio_func;
+	bool complement_fw_reserved_gpios;
 };
 
 extern const struct dev_pm_ops msm_pinctrl_dev_pm_ops;
-- 
2.37.3

