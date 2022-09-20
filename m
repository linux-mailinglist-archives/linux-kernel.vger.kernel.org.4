Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049415BD9FA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 04:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiITCQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 22:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiITCQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 22:16:50 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D08A543F2;
        Mon, 19 Sep 2022 19:16:48 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id d8so1108665iof.11;
        Mon, 19 Sep 2022 19:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TJGVbLYqargar4DAZ5jQTcR9l+kJlg0aeLqRChhr/3Q=;
        b=QTYHBB0M/tnEDRtU/nW4HsM2koLDgPOydjO5YJhZgLReogR650XptX9vWa+d8ne7E2
         k/Z1IzjSnwQH1A9WuBQIlht7GpSMwjDtQEpV1nKk+MHaauWoBGFKoaD7qIP9hfIxElRL
         9bCu4P5s3gQifBLTv2Di4dsxPaf8Go28WzVbGcZxZPUO3f3whmn/BqYUH/E2Y3c+0GBt
         n3ISsTt6dHCiS552n9NsqzUGkfxcQK33L6RWI+gQ61vqEp7KzbWXUPNkPLkicQiTW9Rn
         A8/HWqqYGHAIQPQaoKI+Fv6Fg1hOOOSwey3uJPAcYXs6RArfCK/o+ZfmtROzlZOFOqXw
         7low==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TJGVbLYqargar4DAZ5jQTcR9l+kJlg0aeLqRChhr/3Q=;
        b=n/mIAUp76YFA2uYQcKciniq0N2oH1Z4EvySHZMkJs9nk8f2XywfwqFmmmcOX3t9kOp
         dK78wCz6cQALatqhc+NGcbc0JF/s/M7KzBQPE6AU5eWCEglV/O66uMVOsaJx4vU30rMC
         j1t02U1tL2Onbb7iuaZUhqW5HLz8e+uZiUC916CPNWbQDtfbDFxmaVVMRzrJNWfKTCgW
         GWvyb/ZpC9m7/RrhyxM8lY5KiJV+YsqS/BThaBiwgixxDGB8Y38kD/VwSPCpfGluB8FG
         pUl3J2MK5MzZCuEcR1EWH1AYNFJO5CcAsGuaS8OALQ4OJ0P7Spwm8p7RsPfUNmrCQ4Yx
         /MsQ==
X-Gm-Message-State: ACrzQf2yKghX8H3MtaEmSn74Ot/j6W0iuiP9GVLaMpnaEmCSmPZVuEmC
        jZBEg/l1xzN6pM+wCinpx7CnPVhO9YE=
X-Google-Smtp-Source: AMsMyM5sK84hPQ185AWv2Oz0zLYZpXNcoF2/vmhlV9ojKM7AcZvG0QO7Vl7qf92g3VYwTR9xg3HB4Q==
X-Received: by 2002:a05:6602:5d0:b0:69f:a552:87e8 with SMTP id w16-20020a05660205d000b0069fa55287e8mr8751245iox.110.1663640207370;
        Mon, 19 Sep 2022 19:16:47 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::58d4])
        by smtp.gmail.com with UTF8SMTPSA id cn26-20020a0566383a1a00b0034edaddd1d7sm132255jab.144.2022.09.19.19.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 19:16:46 -0700 (PDT)
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
Subject: [PATCH v3 2/3] pinctrl: qcom: add support for complementary reserved gpios
Date:   Mon, 19 Sep 2022 22:16:35 -0400
Message-Id: <20220920021636.1634-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920021636.1634-1-mailingradian@gmail.com>
References: <20220920021636.1634-1-mailingradian@gmail.com>
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

