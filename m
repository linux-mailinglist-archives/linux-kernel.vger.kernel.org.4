Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077C7665A8A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjAKLnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjAKLmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:42:22 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0669A1A21E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:41:16 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so19710630pjk.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hyDFi6BwQQxvnWgZlqZn5l8SdU7JiBSKsGQ5Uy8Nc4=;
        b=P9tGxpvAov1XFTAYprD/CPMh6kLhmqet4jxwfegRwKwi/DkBqaJvFy7gW/kaOJ5wfk
         /r/S3lF9RHrK3d9G8dTIzftnHXDw96hxIoB6lqswUc6gRXe3DiuUSdGWivaKrPA+P8wY
         7kv6qaVenvAZ8tiJ5j4Ot2/JpcVXW7yBXXIuO92Ogz8y2pc4QUxnKcMlAEivUY2bp3q4
         6iG5kOGpS8+x9TiruG1lcHH8bY9m6NWwqxeI1N2DDshLX3dmRBdj1dhkZyPGod0R4c1N
         Ajm/XroavAelHk77wwqsN3zYHuJW8UMkNr4DAIG4r5aq218HVJDcFoH8oOq/wByQURua
         RbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hyDFi6BwQQxvnWgZlqZn5l8SdU7JiBSKsGQ5Uy8Nc4=;
        b=uIwkSnbcUTp6VPt047vhb3HvJ+4ineFm9WuBrJpcBoCV14fgTQ7k2AtwVsxyu5Q+R/
         /vn/ZJoaswIdK8GWgb69cU5eDH3qlUumVuH357RWmlq6U3WPu0si6ju1KeBKCSI+bhqM
         tGsm4GncRasq2IgpThPRyDFUAz8ANnfb0OjXZK0USDt3jPCtXA9OD6ciBeqMQI3z+M1s
         lK6b5n3Tqbvs3Zsl5/cE/KVTgwDQfR58xNL0xcwdxY9U1pFxNCrBO3hApMe52wXRHCYE
         itgwAIYS096yiR06JzcW5xFaxGtgz103IEIv851nY6KDkPmrz4nn/p4214FewGGWO+v4
         frXg==
X-Gm-Message-State: AFqh2kob/wqnWRcJvmlfTXjGU/s9ExBqpQj+OkauBBLclAm5XpWp72BU
        lu0UtVCvOcadpIZrQUJobKB4
X-Google-Smtp-Source: AMrXdXsbFxlz+rm8vf4cfcw4Ucpibd7EUMyp+jMLNsTY2iUogETPytyeDnJXkZv2/0id7rh7Loxd3A==
X-Received: by 2002:a17:903:11cf:b0:192:9550:339a with SMTP id q15-20020a17090311cf00b001929550339amr70120845plh.52.1673437276326;
        Wed, 11 Jan 2023 03:41:16 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.1])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e5ce00b0018958a913a2sm9942688plf.223.2023.01.11.03.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 03:41:15 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RESEND v4 1/5] PCI: dra7xx: Use threaded IRQ handler for "dra7xx-pcie-main" IRQ
Date:   Wed, 11 Jan 2023 17:10:55 +0530
Message-Id: <20230111114059.6553-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230111114059.6553-1-manivannan.sadhasivam@linaro.org>
References: <20230111114059.6553-1-manivannan.sadhasivam@linaro.org>
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

The "dra7xx-pcie-main" hard IRQ handler is just printing the IRQ status
and calling the dw_pcie_ep_linkup() API if LINK_UP status is set. But the
execution of dw_pcie_ep_linkup() depends on the EPF driver and may take
more time depending on the EPF implementation.

In general, hard IRQ handlers are supposed to return quickly and not block
for so long. Moreover, there is no real need of the current IRQ handler to
be a hard IRQ handler. So switch to the threaded IRQ handler for the
"dra7xx-pcie-main" IRQ.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 38462ed11d07..4ae807e7cf79 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -840,7 +840,7 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	}
 	dra7xx->mode = mode;
 
-	ret = devm_request_irq(dev, irq, dra7xx_pcie_irq_handler,
+	ret = devm_request_threaded_irq(dev, irq, NULL, dra7xx_pcie_irq_handler,
 			       IRQF_SHARED, "dra7xx-pcie-main", dra7xx);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
-- 
2.25.1

