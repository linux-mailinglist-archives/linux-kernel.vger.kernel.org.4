Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C7E62274B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiKIJlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiKIJk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:40:58 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B1E20F4D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:40:57 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id k5so16194902pjo.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 01:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lo6h6p6FWBHRsEGWrM5xsJbmXg08Sbkf7PTpPu43hjU=;
        b=MIw8lRa4aQ/dtDaDBmW6xEHkg7B3FeLz0Ll7WZ3IFFDYFXnbYDoxe4aTHdhukVgXyl
         9w8laJvUBt79YUeG8N2iHWGcP3h6bsNsrzPZRloSMwxFRyYkB04Aaku52/nx4uhdgG22
         dw4iGPRgQ88FOSdXmJXu6WoTUm4KLlvXx38mwRCE4RTvZexMtZ+GWWPI1Ip7KuBiTQQm
         bBHWy6lCZAYZjt4j84pSJ/P0hyW7dyz7GyCp2iNEeOGMzpSYKBz2EPw8gHBtQipV+eQR
         7z4BDIQzdJ3qIXEBqh52naKcPb5ubQWw6KPTAoAsJZEO8vnQe/8q8JUsOdQcvWeWB1fv
         Vtcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lo6h6p6FWBHRsEGWrM5xsJbmXg08Sbkf7PTpPu43hjU=;
        b=215hmFjhU9SqfQ+hYnCsbs6/dRnqruVHg5XF1WzgwLwcUOfmqEmkzZbt/Ba2Jhl079
         tflUo11dccWIcmePqlRuuLH3sm6VsoAYRd0ikn2isMYR2wBF/ZkmscE7dIQG8f3GLkW+
         mUmMw/bmi6TLLWUJdMNk/N/CVnBvQj58txUmhRqT0Tov5SYPV86Q9OlOwuCvagTjirof
         goY2sZ8euMYzBY8OKSHwtm0DjsIHYJhDTD9lhM4hcFesgRkN8y+SB9eMyj2L1WOLPPjd
         F2tJcogD3o/G5MvCfW+z0ALLDwcvAQCDFnVHdlN9x9u7uwJ4FeWYejMwaUaUNFTtTmuy
         //GA==
X-Gm-Message-State: ACrzQf2nCBt2GMwGznDnvt0I6w6LWzJyB6gZX36Wu6ENkXvmybd30T6E
        EXabhLbAjVxMRalgO2sp1vOZ
X-Google-Smtp-Source: AMsMyM4TgKcAGp9qRdk+DnNYN/NFbNSWncFrH3pz4zHfJRxDn83JWjUlYmCnM7kcZ+x+3ERrRgwhDg==
X-Received: by 2002:a17:902:e54f:b0:187:2e45:e191 with SMTP id n15-20020a170902e54f00b001872e45e191mr47313980plf.91.1667986856805;
        Wed, 09 Nov 2022 01:40:56 -0800 (PST)
Received: from localhost.localdomain ([117.202.189.229])
        by smtp.gmail.com with ESMTPSA id ij22-20020a170902ab5600b0017f36638010sm8494048plb.276.2022.11.09.01.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 01:40:55 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org
Cc:     andersson@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] PCI: qcom: Fix error message for reset_control_assert()
Date:   Wed,  9 Nov 2022 15:10:39 +0530
Message-Id: <20221109094039.25753-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the error message to mention "assert" instead of "deassert".

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index f711acacaeaf..cf27345f6575 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1236,7 +1236,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 
 	ret = reset_control_assert(res->pci_reset);
 	if (ret < 0) {
-		dev_err(dev, "cannot deassert pci reset\n");
+		dev_err(dev, "cannot assert pci reset\n");
 		goto err_disable_clocks;
 	}
 
-- 
2.25.1

