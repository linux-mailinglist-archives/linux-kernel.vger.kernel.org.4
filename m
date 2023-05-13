Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCDD701666
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 13:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbjEML3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 07:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjEML3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 07:29:19 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3532D5A
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 04:29:18 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-966287b0f72so1575002066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 04:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683977357; x=1686569357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rNewWpP+GvEj2PXHB6K/3b6wTSDIQG0EkEwU6jgQeQo=;
        b=q+zz4WuFUeDnQ814WpwLd5PeEwSdt9wDOQLQg6oc3OAn4TsEcOFt8joc7p4D2oVdr9
         RGCtgpYuadZinGs/FbPCNIaIVa19Ttw7K9e0ESB6BME3SEVT2sVZnTwULS52lAVhGXBP
         D8ztSp7SDf25ag4Ng+e6vYPvORuUlyJj7ovRHv8J02er5jCRJTJBEYXACGeUOdB41889
         rXO5d4ABvFxc9H7e271eDdeIUYQiji5ztGQ0VUSZj98J1jpXWtrIIImAU5UJl1QfJbWL
         rr7tpiimtNT0sWw7cI45lHjijZ36qCxSoKrc07MPp9N4psD1Inm9gep95oVsMInHy6LZ
         emjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683977357; x=1686569357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNewWpP+GvEj2PXHB6K/3b6wTSDIQG0EkEwU6jgQeQo=;
        b=bIfw46OZ+DdxEpK96bV8GgsrfT9MzIlmmrqtF6Gz0POgBTvAR3l3uApXFZ/GwL+yUu
         M1fK4v+/+STGrLSGqqxRRSR6U+1h7ZbfbFgRCioIGIts0T6SbJa6GM8YamjFIv8Qsdlh
         ykvF0uvVa8chiawOCf9Xuz2glsGInuzxcrtu5TFjRaTPHg4xIPTpkD6LswgIQUQLnVQi
         1CQNsmEjmkMHif9Kpr/kwCSsDRxw5mCdNzVLIYrLeEQARsh5/QlN/aDAsVV5qadUX0U2
         fl0+PMew4bruISStW7yhDlRLW82wVALWvIduP2SDXSuLJMrASDuoFr7PqFK88VoXs6cz
         Dc1w==
X-Gm-Message-State: AC+VfDyBrH8I3/P+SvwrazD2VFYs/5mw9ysvoTqUQK4JbdKBi6fWYerJ
        2UjzpS8+MasnvOl3rcGrve9G4w==
X-Google-Smtp-Source: ACHHUZ4zxTbmxyFC1jvKbWdjOOk7lP2nWP61ZL3CmZygSjUd1zsFpqf7tj69dL7vqjJEi+vOaHK3Ig==
X-Received: by 2002:a17:907:d1c:b0:966:5912:c4b with SMTP id gn28-20020a1709070d1c00b0096659120c4bmr20162276ejc.76.1683977356798;
        Sat, 13 May 2023 04:29:16 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a3aa:fd4:f432:676b])
        by smtp.gmail.com with ESMTPSA id k10-20020a1709067aca00b0096a1ba4e0d1sm5063946ejo.32.2023.05.13.04.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 04:29:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] soc: qcom: rpmh-rsc: drop redundant unsigned >=0 comparision
Date:   Sat, 13 May 2023 13:29:13 +0200
Message-Id: <20230513112913.176009-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unsigned int "minor" is always >= 0 as reported by Smatch:

  drivers/soc/qcom/rpmh-rsc.c:1076 rpmh_rsc_probe() warn: always true condition '(drv->ver.minor >= 0) => (0-u32max >= 0)'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index f93544f6d796..0dd4363ebac8 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -1073,7 +1073,7 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	drv->ver.minor = rsc_id & (MINOR_VER_MASK << MINOR_VER_SHIFT);
 	drv->ver.minor >>= MINOR_VER_SHIFT;
 
-	if (drv->ver.major == 3 && drv->ver.minor >= 0)
+	if (drv->ver.major == 3)
 		drv->regs = rpmh_rsc_reg_offset_ver_3_0;
 	else
 		drv->regs = rpmh_rsc_reg_offset_ver_2_7;
-- 
2.34.1

