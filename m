Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629535B4498
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 08:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiIJGcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 02:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiIJGcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 02:32:21 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945675AA31
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 23:32:10 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso6492817wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 23:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=UaIe6nvb9frcJULOPfASw/VY+z26bpOj35NUY7Eb3q4=;
        b=OGDhA1TSodVEWzmSkT/FH1LuvihKRTLoFzUsyNzUEzYNg23ASmoIx1TCYuNHlDcxcy
         +OjkvdYUHy5UXwos9bBvlvxCph8DRzzNPYVHab0OpCGb2yF4aS0aAu8Aw07/GzOUM+JL
         pDaLW1EIbPrKOEllah2+WMnqsa1UK2BvpR9O3ZSLh5b84fkSaOMGlQMopVsCDu/9Av36
         oHKnvsB+eZMh3vYTHO2WVn/GbkwYf4au8fg8fxjnUQ2OgUCJpyLZ58Jxdy5eQXNDEism
         wiSkr5e3PiCbz6Sgo6crpPVEGcDV39BUGq86/W+CXhhH0IOKZULa1CJvBrTzxfNAyjIc
         HAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UaIe6nvb9frcJULOPfASw/VY+z26bpOj35NUY7Eb3q4=;
        b=qsTR4KAL1q3t84yEwB/kgeaGIfMr8crrJd7scJpjdNoBHW0BZUPKgPktsCwu6Cb/RS
         GClOLHBCLHcCNDmzK8mUgGGRsW8dc1krDguYlWcwWCM0FszrTJRA8YHBdTqDJ7WUuaF4
         8DGgdBYUNgSyXybDgyTkCbeJlhnzaqWMHsyc6rgbe45ivGnJyqKWeoAbHdKS9by2bW52
         92tlToqqz7b5+TRrWuplZ2dE9TygGXx2b1I0JN2XJ8PHcXjdIJXidBBWWx7Y0miq4xiE
         Gb7NWuHUEmS8yWZydzN9BIgkhovUFZ+rA9mULYzVYWQMu8B2tuaZzimRSk8hJpQLca4j
         HaRQ==
X-Gm-Message-State: ACgBeo0lQSOsfllHMpO9AF31WsDw4E+EmHm7r+vA9jWfvBy2fG2MgYsb
        kJ5MLwLet/y/qoLRmBMMMOfG
X-Google-Smtp-Source: AA6agR4kDtP6P5suxqsV5BAbulnccW72C+2FPBs7C8ryw9stW4gaKDsYjm+VCN2i9lSrm+3yc0I/yQ==
X-Received: by 2002:a05:600c:1989:b0:3b2:b5a4:8d42 with SMTP id t9-20020a05600c198900b003b2b5a48d42mr7179343wmq.140.1662791524707;
        Fri, 09 Sep 2022 23:32:04 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.47])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c4f9000b003a5c7a942edsm2828122wmq.28.2022.09.09.23.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 23:32:04 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 08/12] dt-bindings: PCI: qcom-ep: Make PERST separation optional
Date:   Sat, 10 Sep 2022 12:00:41 +0530
Message-Id: <20220910063045.16648-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org>
References: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org>
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

PERST separation is an optional debug feature used to collect the crash
dump from the PCIe endpoint devices by the PCIe host when the endpoint
crashes. This feature keeps the PCIe link up by separating the PCIe IP
block from the SoC reset logic.

So remove the corresponding property "qcom,perst-regs" from the required
properties list.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index 3d23599e5e91..b728ede3f09f 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -105,7 +105,6 @@ required:
   - reg-names
   - clocks
   - clock-names
-  - qcom,perst-regs
   - interrupts
   - interrupt-names
   - reset-gpios
-- 
2.25.1

