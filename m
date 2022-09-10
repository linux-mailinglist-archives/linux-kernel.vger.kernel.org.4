Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302965B4477
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 08:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiIJGbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 02:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiIJGbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 02:31:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298BE5AA0E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 23:31:04 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e20so6551863wri.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 23:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=A6MnCj2se0faTLxU7PAsnpqHYvC5MdUEcJAJwKpneuk=;
        b=ZQPW/e3uE08A1vHM+0FO//L6uqJ4cOAHftQUFZHMGS15pJ+gT5Qxkc96XA2FacYmVY
         NGvqjg7kNwASl+fgaDj60Adz8wJQQL884QxdjWb+AK1w1Y0SMk1hErNhgRAANqbFcQZ7
         P/yZks6chztgMBBuERVfc8ccOMYiFW/6DKAxZw4Ye/cCPpjas7eMAn1CCit97az4f2e/
         O8aauMJrMp/vOn9zepr8LlwMCjE8Jc2z1DTX8yiQMiBIq2Ve0O+lemmHapd8+QayC9Ly
         RgVLrmwHpSNgFDnuPCm9SvC92M/vXNEnCOJwUrep+JJrA3xs+ojPI1xoJSgOWCG94c5s
         0uVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=A6MnCj2se0faTLxU7PAsnpqHYvC5MdUEcJAJwKpneuk=;
        b=K2Fv9IkzoV66fkRuZVrs65xw2POQAY/qgwCzvLQwoEKaaj4G9mbFh9MzxvCQnb6Xap
         BuwbD35lctrGnu6/f4piV/DawvTAeB/9UnCSP4MZeRzomJrpApNtjs0lv/VgatQEpsEV
         9QmR0HLBxTwBuxrSW64S8UZT2NS3pabRgzdORaa8uxQb5xZF8KmZ7ixXyqF6LD0gDlR3
         z9iFjUbhmLhnx5ClxIC/TbXpjCgSv8eGaN58e4iXBFIZCWI5lFhs2Nux5yCmezWjxlSM
         CQzXQB55L+okm2Vseum/RwC+A4G3vW+n63ZdCrzTTRh0vzgba0tBpP/Y/Tvd182dLHkc
         gkjg==
X-Gm-Message-State: ACgBeo2mk9I2VNfHfpgcVWHJoAV0CmETUVCmZIsrNIx190B4Qqs7gNIt
        wKQtOhq6FAmA3cjcmBl+D6xmpG7QFpyaVpg=
X-Google-Smtp-Source: AA6agR6+DDlQpQMYwmCOlPd/pOo8N8SiqTmfGsE3pKl9js0b8ymhF4lLqfUEpipV8WBJYNJJcHJb/w==
X-Received: by 2002:adf:d215:0:b0:228:6293:10ff with SMTP id j21-20020adfd215000000b00228629310ffmr9728557wrh.171.1662791462703;
        Fri, 09 Sep 2022 23:31:02 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.47])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c4f9000b003a5c7a942edsm2828122wmq.28.2022.09.09.23.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 23:31:01 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 00/12] Improvements to the Qcom PCIe Endpoint driver
Date:   Sat, 10 Sep 2022 12:00:33 +0530
Message-Id: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Hello,

This series contains improvements to the Qualcomm PCIe Endpoint controller
driver. The major improvements are the addition of SM8450 SoC support and
debugfs interface for exposing link transition counts.

This series has been tested on SM8450 based dev board.

Thanks,
Mani

Changes in v3:

* Removed the maxItems property from "items" list
* Reworded the debugfs patch
* Dropped the eDMA patch since that depends on ongoing eDMA series from Sergey
* Added two new patches that helps in saving power during idle and low power
  state

Changes in v2:

* Fixed the comments on bindings patches
* Added Ack from Krzysztof

Manivannan Sadhasivam (12):
  PCI: qcom-ep: Add kernel-doc for qcom_pcie_ep structure
  PCI: qcom-ep: Do not use hardcoded clks in driver
  PCI: qcom-ep: Make use of the cached dev pointer
  PCI: qcom-ep: Disable IRQs during driver remove
  PCI: qcom-ep: Expose link transition counts via debugfs
  PCI: qcom-ep: Gate Master AXI clock to MHI bus during L1SS
  PCI: qcom-ep: Disable Master AXI Clock when there is no PCIe traffic
  dt-bindings: PCI: qcom-ep: Make PERST separation optional
  PCI: qcom-ep: Make PERST separation optional
  dt-bindings: PCI: qcom-ep: Define clocks per platform
  dt-bindings: PCI: qcom-ep: Add support for SM8450 SoC
  PCI: qcom-ep: Add support for SM8450 SoC

 .../devicetree/bindings/pci/qcom,pcie-ep.yaml |  86 +++++++---
 drivers/pci/controller/dwc/pcie-qcom-ep.c     | 154 ++++++++++++++----
 2 files changed, 188 insertions(+), 52 deletions(-)

-- 
2.25.1

