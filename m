Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45336B89D6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 05:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjCNErV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 00:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCNErE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 00:47:04 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F9392F08
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 21:46:50 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so13929297pjp.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 21:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678769209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAvWJkbCnkvCCrjEbntOUm0v01njPW2wZQKEuX5KGW0=;
        b=HENhfj0P03xr4pXsqionBzTdpzKD7bzfpTmWxv1zG9XLdzfuqmAzYXa0p8UyaQe7P9
         JjNHpcepgZ65Cmcb76UJ7O3A3f+Ba80/6TCRKpaygXfseEcQ0EdYcfW6zS2einNVa64d
         N4z1jYsZgT/ee6CsmcKWqqT39VTB+OU0mVGDT8xk1CiVxiMPr7Pq3U3WR5EWqzFh5JDM
         2FyMUwUQYwjIkDTL0zB5BEE7uycfk5izuGY4Q8kwNBZIQ7TyGslhBaUDApxeSoBwD0Qh
         wgNW5wNLKDkmBcaeMRuZFBDAnA8bioxImOWJmodGh0lkQ42zNuubC845Bwh3JwSmczTD
         sx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678769209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAvWJkbCnkvCCrjEbntOUm0v01njPW2wZQKEuX5KGW0=;
        b=26f1aKwTaSM5N+OzmpSegYJjYHYallBVI2MRVgeIJixy9IXHqx2/gqqgWAdJKa77wI
         77zhX0Ll/szcSqNSldAFUUfIqvle0vfv7UHKhaLgbX6KpK8R6rmF3Mzgz/q3iQTr99Lx
         mlYFuQbcw8BXSFFO6uvFtz4nOpOF4itGGIA8jKhJXwl792xBIH8RKKE68clHVwC6X8UW
         ba24A4KuupN4U13Hfx57b3M0QNGoyXA4G/7ppasgih6mcIU5ufLnA+/l5+mknuG06731
         eBwWa7S38ZyvsHML4AaQf6hP4Q3UpRuuW3hblRsdc4+lNtpa1I6Q2db/qUrc0I0TN+fN
         Rgxg==
X-Gm-Message-State: AO0yUKUWhTdzM+xAX+7zEU0Mwe+hwNPtT/nSIEHTVOjvj1wLTpN1+NZl
        McjNnHXbyRjCHy9KxHtms/k1qQ0D/wdoctlzxg==
X-Google-Smtp-Source: AK7set+nZrfC0w1qfwoqNz9kFHZqLBxRV1QtjpFIzv9Ysz4MPjqQne3T13vL4vmZo02zcYgnEiDEDw==
X-Received: by 2002:a17:902:d4cc:b0:19d:af20:3fe8 with SMTP id o12-20020a170902d4cc00b0019daf203fe8mr44973116plg.21.1678769209331;
        Mon, 13 Mar 2023 21:46:49 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id lh13-20020a170903290d00b0019c2b1c4ad4sm690125plb.6.2023.03.13.21.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 21:46:48 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 5/7] PCI: qcom-ep: Add support for Link down notification
Date:   Tue, 14 Mar 2023 10:16:21 +0530
Message-Id: <20230314044623.10254-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314044623.10254-1-manivannan.sadhasivam@linaro.org>
References: <20230314044623.10254-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to pass Link down notification to Endpoint function driver
so that the LINK_DOWN event can be processed by the function.

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

