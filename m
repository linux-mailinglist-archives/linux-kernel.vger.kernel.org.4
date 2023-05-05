Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F67E6F829E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjEEMIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjEEMIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:08:25 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6811163D
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 05:08:24 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-956ff2399b1so311967366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 05:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683288503; x=1685880503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ed6pQ8Jv0woMB8pCe9CrwPsuj3qE7mzNeUftZwY93Q=;
        b=zMEKt5DHn7D/+Kr5Kz4o3nV2XzCJppVOXeBQrixZksHA4cTed8yixbF999tT2h/bl0
         tDC9I2+GjdpsMvEz6jbtglydLJIs/9BGCpXACZz7NQFucNn3YQ1WgIU6sn/auPzZcANT
         MdwaB+FUyYKgqfx8q5pd/aFwwxMeILkIChZx7htq1a8362snsd/TyubKPsqkdc3bKR8+
         V8qi8C1DoOVtHrCHSCFdBk97Vv5+bVUeKqsJ5yR52YshV/++67CGJlqgwL6GUyJNrneW
         APPcj3Q+xROO5i6RCkn+35efIYJZVGRRNpKyYaPfUArjCz2MULLF/Ab5orvuIwlWq1C4
         +2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683288503; x=1685880503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ed6pQ8Jv0woMB8pCe9CrwPsuj3qE7mzNeUftZwY93Q=;
        b=LmJMo5M4Smhio5dHocgRKxeaCkQDV8VK/iS7TCpAXuyHSnkSeNCOqAcTVKaeP/0GcF
         SfhFcMtNokYcTARIgamWAyPkgW27B14VIz1znCxH5YPQab2ZGCYn4Ta3/5OYetrd8Yuk
         9CBsHrx3lAj/vI3RXl0AMq6DZDGl6edJZBgtZblmR1rxeXQJTRl6h9oTbgM7OC2cO3hY
         XY2UEg/1933D1xE5Tmh/xvtyF2UMVOGJvw3xc1KjAR3wicHr4HutyrrmmYAmYQd5axGB
         SuAuUVeT6kD7H5GS7I1PlWnO5CVaXDpBABbSrPoFGmLgVTdWsgPWVl5q4bXisIZuwaMp
         85qw==
X-Gm-Message-State: AC+VfDzCvj7X1xBLs4qmI9nZGeEuiDoap5WcBb+bax97ndIA224I2Lfy
        7tjST344GLRDrAgMD1988Qlb2A==
X-Google-Smtp-Source: ACHHUZ77NuLjQuDE8k4p+a4rjhRWrxqlpzjTntCrTGyBJcS5ySmwPQ4Qx7zF8dawe3ZKrzcLXmLyaQ==
X-Received: by 2002:a17:907:26c6:b0:91f:b13f:a028 with SMTP id bp6-20020a17090726c600b0091fb13fa028mr844439ejc.34.1683288502827;
        Fri, 05 May 2023 05:08:22 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id ze16-20020a170906ef9000b00965ec1faf27sm457551ejb.74.2023.05.05.05.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 05:08:22 -0700 (PDT)
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
Subject: [PATCH 4/5] dt-bindings: nvmem: socionext,uniphier-efuse: drop unneeded address/size-cells
Date:   Fri,  5 May 2023 14:08:13 +0200
Message-Id: <20230505120814.1057152-4-krzysztof.kozlowski@linaro.org>
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
 .../devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml    | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml b/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
index b8bca0599c45..efccc5aacbe0 100644
--- a/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
@@ -14,9 +14,6 @@ allOf:
   - $ref: nvmem.yaml#
 
 properties:
-  "#address-cells": true
-  "#size-cells": true
-
   compatible:
     const: socionext,uniphier-efuse
 
-- 
2.34.1

