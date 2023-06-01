Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD2C71A1C1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbjFAPEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbjFAPDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:03:50 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C911AE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:02:51 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b05e96dabbso5099865ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685631703; x=1688223703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI+i05lzXUFOa/Wt+qCq2zIVxieQpfBQT3yhV8ufVhA=;
        b=wwR3YiHbsq4MsNehzflmyYgJU031d3xgkoFwx9K1NRelzu1xpXORXsM6c0bxufv8Jk
         nypExqlYkhZRpMpRY1hX1yBnGKw5U5X7gI44H0xFOjDe24YJDCrcWEsad6t/B8gyKAl9
         Z/cuu1gGKqMpnu42YULUxHIIxmKV7v6jXNHaGWqzJOv+2454Hu1UT4Cfd2/YL3/PDYdz
         3ip84OTu27450uy07buA9jgd8aXBJyYbnRx5dwNblPkjD8SZAx94BDNt9G0rcFnDA52v
         CLqDOFfvmO0JULMDnm/ci8KVBWtRrOBsygw8GzEc7l+isWUO/HT31+QXbMse53Se9sGH
         H5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685631703; x=1688223703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FI+i05lzXUFOa/Wt+qCq2zIVxieQpfBQT3yhV8ufVhA=;
        b=kh1dIl5+VP2bwKO6qCUFS5iciYL7gTtAbnPsV+YhuRoTBGQI0pBQCzK1jApcyOMR+f
         a2NyF4AmiLgFdWWz8mmekBeXel9pCmGO418rqOGeDekTFymc4RKdJzGYi3l7FXKwmHB9
         wEGDJ2eH1c31dNMIfvpoNzGUd5BKrpGUq1TmY43go0Zbb9L8VfFJaF1Q3+bYLICGKmxW
         jg/5knXh7YJAbEsxlSD+F2Tv776yjW8ueIOGCjDY/J8rbnYieA3d4DIqwDlaYHsZ3o0e
         BZhB25CkVdMIvJ+p+e1c72jhh7auozEg2belyIlERaL3+0Q5ZBpN4AUbwli1KxKe9vdw
         vS/w==
X-Gm-Message-State: AC+VfDxuWephZcQSJ7nQzDYWRQMw55iV6zdYGuFV9DSmVWt62peOOvmb
        t6dH0AzPp/v4cM4j0urvNIhA
X-Google-Smtp-Source: ACHHUZ57zqVhapjlb0cYnUmObMwdYbBmVVIw+upnf2HfjjUTLZuWi/ubNC0E+9mni4uPwjMxdw6d/g==
X-Received: by 2002:a17:903:22d2:b0:1b0:aec3:ed34 with SMTP id y18-20020a17090322d200b001b0aec3ed34mr4563142plg.52.1685631703088;
        Thu, 01 Jun 2023 08:01:43 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.123])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902dac700b001b0499bee11sm3595480plx.240.2023.06.01.08.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:01:42 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH v5 7/9] PCI: qcom-ep: Add support for BME notification
Date:   Thu,  1 Jun 2023 20:31:01 +0530
Message-Id: <20230601150103.12755-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601150103.12755-1-manivannan.sadhasivam@linaro.org>
References: <20230601150103.12755-1-manivannan.sadhasivam@linaro.org>
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

Add support to pass BME (Bus Master Enable) notification to Endpoint
function driver so that the BME event can be processed by the function.

Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 4ce01ff7527c..1435f516d3f7 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -573,6 +573,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
 		dev_dbg(dev, "Received BME event. Link is enabled!\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
+		pci_epc_bme_notify(pci->ep.epc);
 	} else if (FIELD_GET(PARF_INT_ALL_PM_TURNOFF, status)) {
 		dev_dbg(dev, "Received PM Turn-off event! Entering L23\n");
 		val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
-- 
2.25.1

