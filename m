Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363CD71A13B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbjFAO6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjFAO6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:58:19 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8234210C3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:57:59 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b034ca1195so4141735ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685631479; x=1688223479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sY5A5rnt2NOAJyTtKsWtQc3JsasD9KssrsfBlXW2O/Q=;
        b=IYdJVlCJSotPGPtwC4vW7HGAcnaVr8EUU9A9Vpe3FcjgsEEcYLSYXOVevPY4etW0Xx
         v9i1p9qr9HDz5xCW+L3itd4/e6EfUH4d5/LfAW0Y1uVOGTPqcqTzdQxkgnybCXu9mjmi
         WxJH+t8oMEJi757fq79Ja3/1VeVGCkH/UgNtTSdVocbOVp6/QACzEsWV6K6SNXBvBafM
         Q23sn+ZkR6OLWqNF3U11ltfADhK24OFMq+5bJE8pP7FMzw4Hh91SL2+C/r7Isne6IwhZ
         LODBjOC4qxYF0hDzDMOAxItuyy+2BV7LuH8DxUQIEwh3wFpblbsKYcVLKGES2cMJqzNL
         rjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685631479; x=1688223479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sY5A5rnt2NOAJyTtKsWtQc3JsasD9KssrsfBlXW2O/Q=;
        b=HAfV+jWC0ZBFNIBevVH+xLc1K8mzY7MOgOq360UhTezR0qQZWH2wAOVjLja1DN34Xp
         d7tri7hnm6nGMTZgyDy+dGBrkTYDvMluUjpT5MLeI1HxEBaujetgIj9U2L7vGjP+lup6
         ATd4EL9cRbvjIirXAG9VUv7KOQ2vg1UTMsaeYqDObbygcwUkBRRhcFBuSKJCfcbUKlxM
         /JEgOzWJ92iGaSCdI80lW4tw+ZXXvwJzaFwAs2LNRdZMY6L+uQe7kn5sZI61sVJhAEGx
         rCxHwZTSSCz6QeE8ify5OY0FeQUmJ04O4BFxZj7UwmG18f+aGohVGRBVFkmxKlew2cUF
         9hjw==
X-Gm-Message-State: AC+VfDyGzIWcVTvlbbtmQXOAKwjzDufbRy31cCJ4ufCuA7JVApgX4K96
        Z6t99Hylem/G9+wKYjBdkN+f
X-Google-Smtp-Source: ACHHUZ4AZwJEH5Uke4HzwXK238eiOsWpJ4bFvKceGGcasL4YsACMeBIUw23yGAYRH3xhjNg7kz5mgA==
X-Received: by 2002:a17:903:234b:b0:1ae:3e5b:31b1 with SMTP id c11-20020a170903234b00b001ae3e5b31b1mr7817350plh.9.1685631478915;
        Thu, 01 Jun 2023 07:57:58 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.123])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b001b0603829a0sm3577826plg.199.2023.06.01.07.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 07:57:58 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 7/9] PCI: qcom-ep: Add support for Link down notification
Date:   Thu,  1 Jun 2023 20:27:16 +0530
Message-Id: <20230601145718.12204-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601145718.12204-1-manivannan.sadhasivam@linaro.org>
References: <20230601145718.12204-1-manivannan.sadhasivam@linaro.org>
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

Add support to pass Link down notification to Endpoint function driver
so that the LINK_DOWN event can be processed by the function.

Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 19b32839ea26..4ce01ff7527c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -569,6 +569,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	if (FIELD_GET(PARF_INT_ALL_LINK_DOWN, status)) {
 		dev_dbg(dev, "Received Linkdown event\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_DOWN;
+		pci_epc_linkdown(pci->ep.epc);
 	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
 		dev_dbg(dev, "Received BME event. Link is enabled!\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
-- 
2.25.1

