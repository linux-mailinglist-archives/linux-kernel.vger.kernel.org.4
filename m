Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78027235F2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 05:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjFFDyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 23:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjFFDyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 23:54:51 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2CC11C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 20:54:49 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-39810ce3e13so4940718b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 20:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686023689; x=1688615689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j8TMuD13iz1+JTkcI0W6rJfcAelcuaGW6bYfzfZtEkI=;
        b=QpxIc2VnmTj9/INYg1A0nn8sp2zJBZu5bxuzrB09dhHZB0PeeThnP8gmIwn4t9B0qf
         dwVMuS2NRq+l7UFNzxumKjEm834j84JIgEua2biyCGqA1F6ACLj+UiWYGg7ZDX5cE5wA
         FKmDIaUwwjnUbN2dfgNtMsk1ywIs/k9AcaVPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686023689; x=1688615689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8TMuD13iz1+JTkcI0W6rJfcAelcuaGW6bYfzfZtEkI=;
        b=AT74JlZTrarYb7Wfqzwkz3LaVd3ewDuHIzy7eau2U/1sTJ6+mI5TwAlXTP0X8kqC0p
         TcBy0CE90QlTClV8LgtnoTjpgRvI7s0QDEq6ae3vDh9G3FC/uG0PF9zlb76hkGvwnq72
         jmT6/m8nd3FniJZOR3zXKd4T2gSiYDQ+CHNE3lWvm+nVpC52TlRu/4u0twVtNQxoPa2O
         oAg97FRDH7hI9mhi/X4WBp/8jBrWrqyaGB7EkuJ32L8ykqKJwSzKSBFRUn5CUmsfsyVF
         6j2+m7bStCfSbcEzOQWch6h8I2Aqc5bo3EObbjqGfvR/1++/8zhJ/rUT5k/Hnz3ba1aM
         mgsQ==
X-Gm-Message-State: AC+VfDz4/cQSKl0L9rVV8htrJP45iAeq4y2A46Om9zTfDJkdj/hwx3pd
        DC+gZWpKWkLWVFzXpLNTj3Rq/x3b6B285f3x9S8=
X-Google-Smtp-Source: ACHHUZ4UMtRYy/7qpFF0vsG8ysIeFfKeyckX76RWB+ia2WJH2a01zyqRwhcOXLfvNCIpcppeJ0gVDQ==
X-Received: by 2002:a05:6808:a88:b0:398:2b78:3272 with SMTP id q8-20020a0568080a8800b003982b783272mr828963oij.26.1686023689209;
        Mon, 05 Jun 2023 20:54:49 -0700 (PDT)
Received: from grundler-glapstation.lan ([70.134.62.80])
        by smtp.gmail.com with ESMTPSA id e11-20020a17090301cb00b001ac5b0a959bsm7346636plh.24.2023.06.05.20.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 20:54:48 -0700 (PDT)
From:   Grant Grundler <grundler@chromium.org>
To:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O \ 'Halloran" <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajat Jain <rajatja@chromium.org>,
        Grant Grundler <grundler@chromium.org>
Subject: [PATCHv3 pci-next 1/2] PCI/AER: correctable error message as KERN_INFO
Date:   Mon,  5 Jun 2023 20:54:41 -0700
Message-ID: <20230606035442.2886343-1-grundler@chromium.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since correctable errors have been corrected (and counted), the dmesg output
should not be reported as a warning, but rather as "informational".

Otherwise, using a certain well known vendor's PCIe parts in a USB4 docking
station, the dmesg buffer can be spammed with correctable errors, 717 bytes
per instance, potentially many MB per day.

Given the "WARN" priority, these messages have already confused the typical
user that stumbles across them, support staff (triaging feedback reports),
and more than a few linux kernel devs. Changing to INFO will hide these
messages from most audiences.

Signed-off-by: Grant Grundler <grundler@chromium.org>
---
 drivers/pci/pcie/aer.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f6c24ded134c..d7bfc6070ddb 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -692,7 +692,7 @@ static void __aer_print_error(struct pci_dev *dev,
 
 	if (info->severity == AER_CORRECTABLE) {
 		strings = aer_correctable_error_string;
-		level = KERN_WARNING;
+		level = KERN_INFO;
 	} else {
 		strings = aer_uncorrectable_error_string;
 		level = KERN_ERR;
@@ -724,7 +724,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
 	agent = AER_GET_AGENT(info->severity, info->status);
 
-	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
+	level = (info->severity == AER_CORRECTABLE) ? KERN_INFO : KERN_ERR;
 
 	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
 		   aer_error_severity_string[info->severity],
@@ -797,14 +797,22 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 	info.mask = mask;
 	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
 
-	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
+	if (aer_severity == AER_CORRECTABLE)
+		pci_info(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
+	else
+		pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
+
 	__aer_print_error(dev, &info);
-	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
-		aer_error_layer[layer], aer_agent_string[agent]);
 
-	if (aer_severity != AER_CORRECTABLE)
+	if (aer_severity == AER_CORRECTABLE) {
+		pci_info(dev, "aer_layer=%s, aer_agent=%s\n",
+			aer_error_layer[layer], aer_agent_string[agent]);
+	} else {
+		pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
+			aer_error_layer[layer], aer_agent_string[agent]);
 		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
 			aer->uncor_severity);
+	}
 
 	if (tlp_header_valid)
 		__print_tlp_header(dev, &aer->header_log);
-- 
2.41.0.rc0.172.g3f132b7071-goog

