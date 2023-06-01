Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F9671A26C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjFAPVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbjFAPVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:21:01 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEA3123
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:20:59 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5149bdb59daso1488929a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685632858; x=1688224858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugAOEQ2nTkuc90Va4TrL0v0+dppCm6u1UGyEyUaYNgs=;
        b=XPz/a1scgmMVSUakvsBV8c+8lVtYzeIYcLYRwymYAzZ7bwa9g45Mp7Fvfx9o4VIkH2
         SRlfhBjhUzJVDjhmkhy5J49dbC9c67BHCwLJJlKQ7VxEANndNuJ2T9NZFbceuZcWkTxb
         RrERw/tL7MByyEFV6YlV/J5QjEDfQ8FX2oW8SHIUb9o31Mw7sU1rhfNlhosVnbevhXJa
         gerfnQYpWI5g6Exr9ko2I0LZZkeST6dQJclG6oVH6cdZLyYuU3x2qk/Pk+jid7/2D6EU
         bioGqxyMlKi2U1c+zdMBOny+aU3S8GIq8NgDJsCFCeo3R8vfiF1q0Kx9FhlyLOzXOiBa
         TCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685632858; x=1688224858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugAOEQ2nTkuc90Va4TrL0v0+dppCm6u1UGyEyUaYNgs=;
        b=BOMVl1526nM19Lqx7L9eSWoJQyxugEaMKRP3uD1qUtLiKciRx5XS9kT7i1n0G9s6g8
         A4QRrCoGYwvw8QAQD1ri9fhm5XYPzSMHp7mvhwZ5qBKUBr0H3lWNUsje+mSpYI1VuqXc
         MIRKlNWafaUb/afNK7H6gsteQlK3GeaTKvPLzAZVgzwkWRYqUTpoJ8i+9J0gKBHYTSpF
         5T7E+Pg1uRJxuovh8M8L/gQfgItbRrTCWsz5DUD/tWeEX1wTVlrVcaG/vhgBNZiUwlSO
         vM2NyJ0yX9xiDDZHNNWrfTZggDA5caYQkCfntosL4jBvs7NI+F5bk7nTTp4TuaXNnrG4
         XUeg==
X-Gm-Message-State: AC+VfDxzxSdNlc5JnLLjSAGEgOGRQhOCHRibz0VEcIGlgJKSLG0vP6Lj
        6L9/G6hPtWDSxgkSBlZZyCx+Pw==
X-Google-Smtp-Source: ACHHUZ4RJXc5al0Ye4S0KDvje7nG2/3qDVl8+kTbtql+bYotRdRBBV7hfss0NVLOYZ/7E0pF/WpREg==
X-Received: by 2002:aa7:d9d5:0:b0:514:9e61:e7bc with SMTP id v21-20020aa7d9d5000000b005149e61e7bcmr200480eds.0.1685632858026;
        Thu, 01 Jun 2023 08:20:58 -0700 (PDT)
Received: from krzk-bin.. ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id f14-20020a056402160e00b0051422f31b1bsm7298664edv.63.2023.06.01.08.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:20:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 6/8] pinctrl: qcom: allow true compile testing
Date:   Thu,  1 Jun 2023 17:20:24 +0200
Message-Id: <20230601152026.1182648-6-krzysztof.kozlowski@linaro.org>
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

Makefile selected Qualcomm pinctrl drivers only for ARCH_QCOM, making
any COMPILE_TEST options inside Kconfig ((ARCH_QCOM || COMPILE_TEST) or
(OF || COMPILE_TEST)) not effective.  Always descent to the qcom
subdirectory to fix this.  All individual drivers are selected in
Makefile via dedicated CONFIG entries, thus this should not have
functional impact except when compile testing.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index e196c6e324ad..482b391b5deb 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -66,7 +66,7 @@ obj-y				+= nomadik/
 obj-y				+= nuvoton/
 obj-y				+= nxp/
 obj-$(CONFIG_PINCTRL_PXA)	+= pxa/
-obj-$(CONFIG_ARCH_QCOM)		+= qcom/
+obj-y				+= qcom/
 obj-$(CONFIG_PINCTRL_RENESAS)	+= renesas/
 obj-$(CONFIG_PINCTRL_SAMSUNG)	+= samsung/
 obj-$(CONFIG_PINCTRL_SPEAR)	+= spear/
-- 
2.34.1

