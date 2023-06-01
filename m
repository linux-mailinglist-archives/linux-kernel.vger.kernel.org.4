Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E2E71A26B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjFAPVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbjFAPUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:20:52 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AFE1AB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:20:43 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5149e65c244so1449331a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685632841; x=1688224841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AIeQ2/lsiYoThkaM/iRVe1rvj796gjOf4pjaRKczNA=;
        b=g+CqcM3a0K8v5hRlgVv/g4iE/8ozOgc/Qc4CwCtEK9OTmTVvmvjm46Th834Bcn6MlZ
         Z59jP/726shOY0dWtxYzDhyM60VuqPhNE53rO9hSSN8rtzq/SFf/Lx1GURXoZ+jlGTXm
         4H9Gtrs+uZ9PFqhJ9xmSInROARJY0kNiQ8bZ6y+2LzhceED8881RMebzUex9/bczyvZB
         Dl/6bmfewEYx26T2rOf3LPwK8c7zt9ZITPuUb0mabgFZI8G8MRBIauzKQ540RjDSf3DD
         +jRn4JBJ6g1bgYcn4Vg4LK0QhkeGIdqckQejyUrkk8R5q/YFszh6zfnILNisxq6XFm+W
         gyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685632841; x=1688224841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AIeQ2/lsiYoThkaM/iRVe1rvj796gjOf4pjaRKczNA=;
        b=hGGctLieZFyL/MJtLRt1Fto4exB6G6cugCpzf3C2qny+cskoYW3FNmEmENRGE4MOwB
         LItYvvZ9pPXqhWUhxP7rPXZ9OYDx0VnVvqwCdUdK4R4PDSAU38dWY/U9U+fUf2WfndiH
         SPRqX1UB9/lYRwYdoFm7DD0eQ1tOWUxIKDmNLnzyiCbfJG/sIEWLhJDYiMW7ZWqkYrzU
         QadEzIjIpf9pGdzVYPPK5lfDvh127h15ashU4981RV9tSpQSU4QS73fdGuuftvH44QwS
         x/iPOMdhGBmIuxKKfErB517/UxFxAIjR6YaP6YodBMRD7CDOkeDD5EV2Q/EVhJEkLU7V
         fVjg==
X-Gm-Message-State: AC+VfDwjUSyOFH390m3T4VjZastUoYppjapPEaFV2LOKsj0WEz9Xhp2v
        o8kuXmFR/pNfpDrm5+fenF/Pf0DqRXz5/gOEbUE=
X-Google-Smtp-Source: ACHHUZ5zsjAbDpaa6ldRS82porWOJNaWql4VObFNDnr36plQKpGtwIlFlEv6O3kOxAK0dVKl2a3Fvg==
X-Received: by 2002:a05:6402:618:b0:514:667f:5ac4 with SMTP id n24-20020a056402061800b00514667f5ac4mr206200edv.10.1685632841204;
        Thu, 01 Jun 2023 08:20:41 -0700 (PDT)
Received: from krzk-bin.. ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id f14-20020a056402160e00b0051422f31b1bsm7298664edv.63.2023.06.01.08.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:20:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/8] pinctrl: qcom: fix indentation in Kconfig
Date:   Thu,  1 Jun 2023 17:20:20 +0200
Message-Id: <20230601152026.1182648-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601152026.1182648-1-krzysztof.kozlowski@linaro.org>
References: <20230601152026.1182648-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use tab for correct Kconfig indentation.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 28b19458b20d..9f957d16cd68 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -245,7 +245,7 @@ config PINCTRL_QCOM_SPMI_PMIC
 	select PINMUX
 	select PINCONF
 	select GENERIC_PINCONF
-  select GPIOLIB
+	select GPIOLIB
 	select GPIOLIB_IRQCHIP
 	select IRQ_DOMAIN_HIERARCHY
 	help
@@ -260,7 +260,7 @@ config PINCTRL_QCOM_SSBI_PMIC
 	select PINMUX
 	select PINCONF
 	select GENERIC_PINCONF
-  select GPIOLIB
+	select GPIOLIB
 	select GPIOLIB_IRQCHIP
 	select IRQ_DOMAIN_HIERARCHY
 	help
-- 
2.34.1

