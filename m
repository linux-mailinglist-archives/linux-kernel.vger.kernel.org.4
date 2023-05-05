Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C977A6F829A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjEEMI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjEEMIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:08:24 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B1F1A62C
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 05:08:22 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-965f7bdab6bso24058266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 05:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683288501; x=1685880501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gBgZGB2bEIFktr1qkY6AiQNPmmdhmRh1tLggMSoGz4=;
        b=NoHFuOHFJE782btFNmfxDrM+gE0y+XwmDdR2+aD7CCe6721pIxHon+vhykZWfdcVgM
         FbM+o5y0qrCYjih+/SOnAnNoNkn8KZLZJZPUhj9i3QVLZ3P6YXTQb2JPlWhaJNnuzICz
         dlyABdQ0Sexl9BM7USe6dcCgCBvJC5ZSMShIkotx5Knqq3dQdkZTHyMAiPjniMGsnHq6
         V2P8k5xXxlYQL9sLbTfYXqAvqRsmYcWIavSVeHUiHtzxAkpfsfqY0qYD+zjrNzUtMsjo
         f8w1efL0wkhfQwHgDqcGxPu4rfdHPxzRa0+eHUeXvdN1AhFD9b11f6ibcaSP6XTICm34
         dQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683288501; x=1685880501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gBgZGB2bEIFktr1qkY6AiQNPmmdhmRh1tLggMSoGz4=;
        b=dJbAdXvjpfSFUzHfTRRgnORIhCFN0WPfWDwx/TBiROHj4WdZASYVIKu4Ea7jPaiNtX
         xQzYnlJOok+3DL6w0Y92PTOBATonS3xOEGMW9n17RVnWj3UpqQwHazlaXZeOn7xajA2e
         Xrcpo7xgek9/Yz2/Ty/AlLiX3E80aLVKjovVfeS3vlZAzTX+sLhMtIzwOJ1u5leZPdbl
         /Rl5/hVN/Vd7jNeGxCXmcG83BNAKm64FZci2NnJvAFtmoP0rIo/feMrsLA01bFMBmX8r
         uDMdWSqeOCrpIk61rFkndWUjX9j/P+i2WKMv6PHl1zokviEkSHgL1qXTM4OR7iHinqxV
         XGmA==
X-Gm-Message-State: AC+VfDxSsa5r5Kot4Hw5/nzYeI3TtaqSK/rNeXkWowwzxxXLqD9M++UC
        4tRpnu/avFsYx4r5i+5kpnETng==
X-Google-Smtp-Source: ACHHUZ6zGz6thFQpO8Q01/ymUIvqeROCHPEzLbyq2CsniFFrOKPgnph/E31HbCKXKtkk2lVtzlB/WQ==
X-Received: by 2002:a17:906:ee84:b0:959:a9a1:589e with SMTP id wt4-20020a170906ee8400b00959a9a1589emr829109ejb.76.1683288500874;
        Fri, 05 May 2023 05:08:20 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id ze16-20020a170906ef9000b00965ec1faf27sm457551ejb.74.2023.05.05.05.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 05:08:20 -0700 (PDT)
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
Subject: [PATCH 3/5] dt-bindings: nvmem: qcom,spmi-sdam: drop unneeded address/size-cells
Date:   Fri,  5 May 2023 14:08:12 +0200
Message-Id: <20230505120814.1057152-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505120814.1057152-1-krzysztof.kozlowski@linaro.org>
References: <20230505120814.1057152-1-krzysztof.kozlowski@linaro.org>
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

Referenced nvmem.yaml schema already defines address/size-cells, so
remove redundant entries.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
index dce0c7d84ce7..cd980def97b8 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
@@ -25,12 +25,6 @@ properties:
   reg:
     maxItems: 1
 
-  "#address-cells":
-    const: 1
-
-  "#size-cells":
-    const: 1
-
   ranges: true
 
 required:
-- 
2.34.1

