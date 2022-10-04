Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0185F4B4B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiJDV6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiJDV6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:58:30 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79C146D94;
        Tue,  4 Oct 2022 14:58:29 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id s16so585339ioa.6;
        Tue, 04 Oct 2022 14:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+Xo/G55EiERjQPHhle1qrOHDFbfvYNh2DEdV62/lG6s=;
        b=Uq6uvxR5XhTcH0osSWAxoT9bSEQwtlYueIU0FYw0XslDGWxprv8odTI9RhM2EtE33q
         icJSL5khvohQspLXDjgsjbhyJ8qxtI7Rn02teu5iteFjP7W9xKTggWW2J2ahIZmftWlZ
         SLzVg4cGQP/h0R9Q680/QP925t6uOMVld/jws+H0SAQXzaJpvglN925cvzF8AFErpIbG
         obCV08pM530x0Iryu6MlNWknBDBha1aXHLAAsYeMI+5fdibMMO6BpxjOMFNz8H3u+ZCK
         tipBM9rcnTSp66EjLHhOviMqMMHAXR81wut/eQxdcky6RzwPyYu6LEwXQGGq/HYch42d
         S/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+Xo/G55EiERjQPHhle1qrOHDFbfvYNh2DEdV62/lG6s=;
        b=SbM2793Zo49idudhnHpFWVFEzeDAvKdjgwXxQfYCSzo1rrMtCdp8gBWvhyisj4LASw
         7dVyPBE7SvuaC1Sxzx8rjrgdZQDr0dKXOXZDI39yns4e0EXKi797AbizQHR7Q3l2fnPE
         5zzksEhp3agN00ncBtrjoW2VAJiOV9wUvNUEV0B/dodQGmjY+GMKEKFcOVUlkREJZcqm
         Lusl9dXcI+8D/aCpHwQua3UH5XeqxGNw3jtEJ12GgFWMJbVBeCZoW/8SP8aFrS/wrS+T
         Mi+Fw2gyispE/Qo15OwCpsyutYCFvceTg35Z9VR8Cx82mAfgpytVh4UYuquSa8BInPEI
         CecQ==
X-Gm-Message-State: ACrzQf1YPGCilDNP9WK7/5Lr7uAKkIw+wGXdDfprFOxeZ2GMkGplffUi
        k5ssK+NnFKU4XfKjy8qKLFCliQCuy38PLw==
X-Google-Smtp-Source: AMsMyM7glgIADqUNSACHH8EVQo29ENe347X+FG217Iz1yahUC7pR5ZrF7cWWBOM905OmJ8ihpzKyAA==
X-Received: by 2002:a6b:e003:0:b0:6a0:d55b:a3ae with SMTP id z3-20020a6be003000000b006a0d55ba3aemr12092448iog.167.1664920709081;
        Tue, 04 Oct 2022 14:58:29 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::1eda])
        by smtp.gmail.com with UTF8SMTPSA id l14-20020a02cd8e000000b0035b666ecc84sm5503158jap.133.2022.10.04.14.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 14:58:28 -0700 (PDT)
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
Subject: [PATCH v7 2/3] pinctrl: qcom: do not reinitialize gpio valid mask
Date:   Tue,  4 Oct 2022 17:58:13 -0400
Message-Id: <20221004215814.11694-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221004215814.11694-1-mailingradian@gmail.com>
References: <20221004215814.11694-1-mailingradian@gmail.com>
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

