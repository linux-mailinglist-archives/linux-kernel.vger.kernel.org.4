Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CB072B235
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbjFKOF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbjFKOE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:04:56 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC38B30D2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:08 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f70fc4682aso24019095e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492248; x=1689084248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycP+xRy/VWyCOqLTxi1hrje5JnaEgTDqDo7RQcUi+rI=;
        b=b+oJmoJg8ePMCrrmsnzz9diY/KM46IK3z/Kq6nPfvJIHoWxwPMORh3g82MJlAB6mIR
         CXlP0f/m/8rCQmOh7vUaMyW5cGqnPxaCw7YQknV9mG2x3YwsaEjwFA4TBTDijNAvfxsw
         h4zZ7ciGDe3e5ATCBn9aavmbW5ppZmWExMz3GI3dPsQzIGqA77VouMZRlB52+b/9foB2
         YQzjGXniHSunZWNxupRf67Hik3DnrwBZ66GUtK0+PPygoRK9/89+COi7m0g0iBo6hNMF
         4UlS683QtPNsHzoB4ck+0hxmxpv+VwRAMOHIACfd5iK4EN4JYBHm2TFEa1xtEc/ijppa
         zKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492248; x=1689084248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycP+xRy/VWyCOqLTxi1hrje5JnaEgTDqDo7RQcUi+rI=;
        b=GefhhIs/tXsdzDIW/3VfirKWHfU/xdtGs6vxJRLdiSc3R8jbtD8sXxblhZlbO0Kdwu
         Orxz5jiKths9ExXm2HypSUeaXCm38sWdT3p5VWIow9UZVA91G4SSn18TAp6zaFQhEQ4k
         7aIEYvtxSyZDez+OJx4mjU9ARww3mbsbHMsGjD4qKCHHkwqorwNzAfJRQ6kP6D2Eg5fq
         /STX0MxSlqcR6l6/WYUWOTShkSj9oU/K7T9YH74YEXFnnqx9w5whkaHMMBcFvythS24W
         62sYsL4lNXtIs5YOw2Wci8MDphcGwAT2OoVmHj3H1OVDYHTo2VUkVYNztZdDHSXRUOEV
         3Fgw==
X-Gm-Message-State: AC+VfDxuDfigsWE1wNWgvYSEhm5+JwC9P2QCVkYNAECumXOl60DkkO5q
        h+HergOD+xleZ4+y2UHbwVDieg==
X-Google-Smtp-Source: ACHHUZ6OZ04jYejs7O09SwPIumYlMY4In7fyiGyOKraE6BIF1r+JcEQepHk0nwT0OWL0Q/R5/yNIDw==
X-Received: by 2002:a7b:c846:0:b0:3f5:1241:6cfa with SMTP id c6-20020a7bc846000000b003f512416cfamr4448576wml.37.1686492248261;
        Sun, 11 Jun 2023 07:04:08 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:04:07 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 18/26] dt-bindings: nvmem: sunplus,sp7021-ocotp: drop unneeded address/size-cells
Date:   Sun, 11 Jun 2023 15:03:22 +0100
Message-Id: <20230611140330.154222-19-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
References: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Referenced nvmem.yaml schema already defines address/size-cells, so
remove redundant entries.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml     | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
index 8877c2283e9e..da3f1de7d281 100644
--- a/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
@@ -28,12 +28,6 @@ properties:
   clocks:
     maxItems: 1
 
-  "#address-cells":
-    const: 1
-
-  "#size-cells":
-    const: 1
-
   thermal-calibration:
     type: object
     description: thermal calibration values
-- 
2.25.1

