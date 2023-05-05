Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875AA6F8298
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjEEMIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjEEMIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:08:22 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0E019D45
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 05:08:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so26433350a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 05:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683288499; x=1685880499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sjj0OGmecbhRci41jqXoma07TF58CTWwV221bLue5bM=;
        b=jfYLAkXv8UVNZCoWwubyE9yolS8KhDUROLBISEhA9vRBsM6MH++4eCpjjYUwYOs79C
         11Wz9HHgQLc8icMStujIu/1ckX70mnce2dnMCHgb8lTu7XKOG5Gb8tnzOYj40LynBmt7
         HxnIDDWFWF9B4pYOgZumBRlFrCAuYpNuCtxUsdCVaTOPLMC42+BshJ9WVjc9BBIwxRNh
         hdZay49jd6C2SWFx5X76EDhCwxqzxrdiY/rWW4rHxBUQnGdtTs6NF0ykBcUZ71D/qReB
         rc/9HJiPL+JoM3Dm25I5KYSn1ulek8BXMmRp8Q5uoM9kg3TeeLWc9XJMG6CyVXWynooA
         8xLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683288499; x=1685880499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sjj0OGmecbhRci41jqXoma07TF58CTWwV221bLue5bM=;
        b=f0rXxP2b9y+1dvNmfxdZxg8xXGrLZeors2nVGPjIDPtjO4NqtZjOTu1O8NBObkao2O
         ybBEpyexxCBY4RswVD3oyaejNLEJfTdHjTb9TG1l+QZt5qRhclJEjeAR0/69JqVoNJsZ
         aR5BODGCl9GquEAocOm7MzDjK3rUHPbZ5ArfqNpAadbiz15q/jtih0/i9VRRl2wk5r6o
         QYQBn7CyNQEU0aAFenvPmoMuMSpcC9PDQXbPRhV3Vx1M2Pbrr2JLL8q1LuHGA0QuUnYA
         hl5wmCDe0aLDwjENs8x3cwwxje1uzqQURVeQBYFVoDJiI4p02+mHpKDBTOUtaYd4EzuS
         Kutg==
X-Gm-Message-State: AC+VfDzoVIBLmCEvh4u568rBL750BsaXZWpYh27Efn0pErF+nakqDn5l
        aGIki9OW0dTLxh5g9W4LM0PpPg==
X-Google-Smtp-Source: ACHHUZ56Sqk2Z8gl+LC1jM63/Ce1MyLWkrArEnS8gfB/XuJ+QL49T963GFreoNZkjNSpFe1jik7USQ==
X-Received: by 2002:a17:906:dc8e:b0:965:f69b:4949 with SMTP id cs14-20020a170906dc8e00b00965f69b4949mr428619ejc.36.1683288499385;
        Fri, 05 May 2023 05:08:19 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id ze16-20020a170906ef9000b00965ec1faf27sm457551ejb.74.2023.05.05.05.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 05:08:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Kumar Thella <sthella@codeaurora.org>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/5] dt-bindings: nvmem: qcom,qfprom: drop unneeded address/size-cells
Date:   Fri,  5 May 2023 14:08:11 +0200
Message-Id: <20230505120814.1057152-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505120814.1057152-1-krzysztof.kozlowski@linaro.org>
References: <20230505120814.1057152-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Referenced nvmem.yaml schema already defines address/size-cells, so
remove redundant entries.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 8d8503dd934b..c898c67c243a 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -64,12 +64,6 @@ properties:
   power-domains:
     maxItems: 1
 
-  # Needed if any child nodes are present.
-  "#address-cells":
-    const: 1
-  "#size-cells":
-    const: 1
-
 required:
   - compatible
   - reg
-- 
2.34.1

