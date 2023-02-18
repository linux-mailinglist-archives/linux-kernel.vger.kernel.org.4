Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AE869A865
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjBQJkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjBQJkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:40:10 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DDE95ECBB;
        Fri, 17 Feb 2023 01:40:05 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 91613E0EB0;
        Fri, 17 Feb 2023 12:40:04 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=89Ho1QIRcZKfX5soZrCE2EzO1YSV3CvfzfRXmtNkSVI=; b=DmZKi+izA4wM
        ZlfiOENvY/BchS7+ZKZ1J/EcKu+MnRlCC/0WK1dVp0CXSQYgDMZk7+EXjsrGQE64
        xeJEWpR/hSHbn+wyTyWgOcDMg9NGAr6mU2VNxAxJC0R4dVTuEK0A7ZqH8VItZlBF
        kA4sqb7SHiC4bcqtBnJSHGI3ClNOAos=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 7AEFFE0E6A;
        Fri, 17 Feb 2023 12:40:04 +0300 (MSK)
Received: from localhost (10.8.30.14) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Fri, 17 Feb 2023 12:40:04 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/11] PCI: bt1: Enable async probe type
Date:   Fri, 17 Feb 2023 12:39:49 +0300
Message-ID: <20230217093956.27126-5-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230217093956.27126-1-Sergey.Semin@baikalelectronics.ru>
References: <20230217093956.27126-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.14]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's safe to enable the asyncronous probe type since the PCIe peripheral
devices probing order isn't essential for booting the system. Moreover
enabling that feature saves 0.5 seconds of bootup time if no any device
attached to the PCIe root port. It's a significant performance gain seeing
the total bootup time takes about 3 seconds.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/pci/controller/dwc/pcie-bt1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-bt1.c b/drivers/pci/controller/dwc/pcie-bt1.c
index 3346770e6654..036a22886d17 100644
--- a/drivers/pci/controller/dwc/pcie-bt1.c
+++ b/drivers/pci/controller/dwc/pcie-bt1.c
@@ -634,6 +634,7 @@ static struct platform_driver bt1_pcie_driver = {
 	.driver = {
 		.name	= "bt1-pcie",
 		.of_match_table = bt1_pcie_of_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 module_platform_driver(bt1_pcie_driver);
-- 
2.39.0


