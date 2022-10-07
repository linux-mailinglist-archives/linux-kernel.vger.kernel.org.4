Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5E45F8007
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 23:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJGVdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 17:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiJGVcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 17:32:51 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF12B8F25E;
        Fri,  7 Oct 2022 14:32:50 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id l127so4603753iof.12;
        Fri, 07 Oct 2022 14:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3AMzfQVn5/7lBdhsiiw7qcfMcMHO7OrRK+ejqLQydQ=;
        b=Z135OM4KoIIALO4jJCCshxXY7WmAogfxkPAvtQ11asH70YNldexuBsYAVrKj45wt/E
         3ZN8WX5jMmLT98fzgdYc0HAMI14Kz58Fr96fKZINGBdpVpQzSvTDJIFWfOSxRDYUQhuz
         L1C4oy4uqpahad94+Yvfjh83vakAfoyFX24u4B/BJEp9aEzxviV6TrPKMuQQDECj+JZJ
         GTCrxJDfG9vxxsJHmHR1BRbRbAW9oZ19syyK7PmcQ91Oy7BwNz/cO/YWBhzc1vWzzeOA
         lqk9wNozVI5+TcZQ73qj60QXsjIADe/p8EtKjMNnwVQiSWLoaBzqsFEeQ9/LCP5Z6ee5
         fdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3AMzfQVn5/7lBdhsiiw7qcfMcMHO7OrRK+ejqLQydQ=;
        b=qjgVRibHVKn9PRx39/R9z9ci+IaAdx38dq+i10sR9E2NZJwGv2aWxYixYazea4Czso
         xd0yT+2JlLAoCZu2PIjsMx36qfE7+c4eAcTXsJIgux7Pvw7sozTyzpyGFGRrJjm0gmY8
         93c3dzXUZdfjymaG3TeTnh6eTJroXhBcWqH886KlDwXs1rVKWOeNtb5K9J7oEKcJf2mX
         zJz1ZNkNy3vgZmHmNYwglXqfxGBYx5H+g6Pw/57lDu3mWyIBbnpw89o3gl/irCX5t7Pc
         FZfUOyrAGuQV/c8aNcTuLcbeYdGqvvzlmFRrdoFLvI/AhmDRox4w3/V4UfugYMlopnaS
         5bBA==
X-Gm-Message-State: ACrzQf3mY/YlVXYFcYC/sJI9e4KwdkRsCMDHpWLdJeNTmEUjz5YbFtwt
        pwT/zY6zMLgGRVpemA4fR6FVZavsVscLzg==
X-Google-Smtp-Source: AMsMyM7ONcoHyQoQKjJIAMRhQEP4EpC/IvIYRGV4gZxQAlRlRuzmVOFtBj+J71nED21eQtPbjm3T1Q==
X-Received: by 2002:a05:6638:34a9:b0:363:6fb0:250a with SMTP id t41-20020a05663834a900b003636fb0250amr3509808jal.167.1665178369969;
        Fri, 07 Oct 2022 14:32:49 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::b714])
        by smtp.gmail.com with UTF8SMTPSA id k5-20020a02c765000000b0035b61be147fsm1309471jao.21.2022.10.07.14.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 14:32:49 -0700 (PDT)
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
Subject: [PATCH v9 2/3] pinctrl: qcom: do not reinitialize gpio valid mask
Date:   Fri,  7 Oct 2022 17:32:40 -0400
Message-Id: <20221007213241.84962-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221007213241.84962-1-mailingradian@gmail.com>
References: <20221007213241.84962-1-mailingradian@gmail.com>
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
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index a2abfe987ab1..c5c9e588fb13 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -687,9 +687,8 @@ static int msm_gpio_init_valid_mask(struct gpio_chip *gc,
 	const int *reserved = pctrl->soc->reserved_gpios;
 	u16 *tmp;
 
-	/* Driver provided reserved list overrides DT and ACPI */
+	/* Remove driver-provided reserved GPIOs from valid_mask */
 	if (reserved) {
-		bitmap_fill(valid_mask, ngpios);
 		for (i = 0; reserved[i] >= 0; i++) {
 			if (i >= ngpios || reserved[i] >= ngpios) {
 				dev_err(pctrl->dev, "invalid list of reserved GPIOs\n");
-- 
2.38.0

