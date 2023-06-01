Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C6671A1BD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbjFAPD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbjFAPDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:03:41 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F245212B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:02:34 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b011cffef2so8754825ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685631683; x=1688223683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAFeVd+dwK+9T/TQ3aqc3usXxG9M6VjGUKGIkkMeOq4=;
        b=SX+BIkngzKzYRFKhsNp95dh7zWKTA1kb5QAAFgWG2NWebTcfDnznm+pD+ff915iZMO
         tBOaulh0/a8u4OLG+4/YaTkThYpYmHjmEDAe8hkLkzILwsYDgxlpmGARw1iZO6bwYrqo
         DgcoO2jriCI2vU6d+KQU0mA0uJ3m/fJzlix3nz4gpST3dIWfOk98xvJT5ipyoSL4XH1m
         GL3hp6b3f7+To59JkvAJhxc0V5S3BkU4NvfbhxPKon0SfcVB6S1m+qI9+C6/hHCxm0Up
         tdhC6VMzJ8RgHmZA+pdAJKnsBg6DFFQ7zQNCgvVCVN/jV1RlUNJDNlg1UKHJRVNnOkQb
         SG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685631683; x=1688223683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAFeVd+dwK+9T/TQ3aqc3usXxG9M6VjGUKGIkkMeOq4=;
        b=NQ5cNraBZGBdwFZaAn0nx1BDJE7wumr/CIGDgmZZpF1/oEqMOtsC6x5DdggEY5/FcQ
         VqpoMN529yPwKDLBxV1xINKm1CpgBlWX16HqWJ57qri5cRekvPiSV2Bqzu1Hpf6HpzLW
         XDFxhsb8BC+OqZPsjmDqpyP3vegtGg6nWY29kxFBNM9gGhP6xVkJyLCovL7ahTAar3gI
         Rlo7YOqWmQdZJwhfmmEzSYCSuP3C88N2UHD+0j3ZCGgcFtG+tQpAYGAjd7MdfP20SJKM
         bVcfvtRSEiFS21F7aanPijebOd9O9vqRiflAv2Zvy2c9hLj4l3J9mRLEebQ7l2RtUePp
         D0LA==
X-Gm-Message-State: AC+VfDzOq9z1F5RpeWYZAIbX787OvKPthJqHc7tWwP04QKP1aIM87p3g
        vnPNgRbfl6aYrMocUObgX9kk
X-Google-Smtp-Source: ACHHUZ6QOo5ARvwszO6PQhxgQry+278ZPmIgukEv7g4yVmOVQsDHcTNEAQtS0AKFVAYwq6GWYgheXA==
X-Received: by 2002:a17:902:c20d:b0:1b0:4c32:5d6d with SMTP id 13-20020a170902c20d00b001b04c325d6dmr8966653pll.31.1685631683470;
        Thu, 01 Jun 2023 08:01:23 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.123])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902dac700b001b0499bee11sm3595480plx.240.2023.06.01.08.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:01:23 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH v5 1/9] PCI: endpoint: Add missing documentation about the MSI/MSI-X range
Date:   Thu,  1 Jun 2023 20:30:55 +0530
Message-Id: <20230601150103.12755-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601150103.12755-1-manivannan.sadhasivam@linaro.org>
References: <20230601150103.12755-1-manivannan.sadhasivam@linaro.org>
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

Both pci_epc_raise_irq() and pci_epc_map_msi_irq() APIs expects the
MSI/MSI-X vectors to start from 1 but it is not documented. Add the
range info to the kdoc of the APIs to make it clear.

Fixes: 5e8cb4033807 ("PCI: endpoint: Add EP core layer to enable EP controller and EP functions")
Fixes: 87d5972e476f ("PCI: endpoint: Add pci_epc_ops to map MSI IRQ")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 46c9a5c3ca14..0cf602c83d4a 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -213,7 +213,7 @@ EXPORT_SYMBOL_GPL(pci_epc_start);
  * @func_no: the physical endpoint function number in the EPC device
  * @vfunc_no: the virtual endpoint function number in the physical function
  * @type: specify the type of interrupt; legacy, MSI or MSI-X
- * @interrupt_num: the MSI or MSI-X interrupt number
+ * @interrupt_num: the MSI or MSI-X interrupt number with range (1-N)
  *
  * Invoke to raise an legacy, MSI or MSI-X interrupt
  */
@@ -246,7 +246,7 @@ EXPORT_SYMBOL_GPL(pci_epc_raise_irq);
  * @func_no: the physical endpoint function number in the EPC device
  * @vfunc_no: the virtual endpoint function number in the physical function
  * @phys_addr: the physical address of the outbound region
- * @interrupt_num: the MSI interrupt number
+ * @interrupt_num: the MSI interrupt number with range (1-N)
  * @entry_size: Size of Outbound address region for each interrupt
  * @msi_data: the data that should be written in order to raise MSI interrupt
  *            with interrupt number as 'interrupt num'
-- 
2.25.1

