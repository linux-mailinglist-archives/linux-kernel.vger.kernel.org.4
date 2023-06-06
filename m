Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314F07235EA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 05:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjFFDxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 23:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjFFDxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 23:53:05 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B9311C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 20:53:04 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-651ffcc1d3dso3277106b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 20:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686023583; x=1688615583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j8TMuD13iz1+JTkcI0W6rJfcAelcuaGW6bYfzfZtEkI=;
        b=KWjvaOtDIVDZNaWm/wwNioCAPQAQIzsi/qf4qaKorf9By6P7mvXBxsNza8UoM6npDO
         0jsot/kg11j089eqwrgC2PXeJ4FbZKgJbbsWy4cstf3sJCHMISEMTRJ7JZWoTaUaNWxR
         i+NnJoqexiT2/ULkc12zgNqzVjKCtWIaYOh0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686023583; x=1688615583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8TMuD13iz1+JTkcI0W6rJfcAelcuaGW6bYfzfZtEkI=;
        b=ShePTGsQkNTOGBizIVnvQOVpqJtz6TA0C1cs1S8wFQNLh5nOLJGf3Z9FH9Ehep0qAp
         EAUi9tIeR+tQx3AlhOZ6d1WPgoSzYYVZXI6S98kPybgNnzXiz3eYmdbF4sSx9nHCMKx3
         ku+WKGa8y5LQMzDWzLPdIT1aeIdHaz+XVrhdJpUsSVpkuW5BFDDw5knNeePpGYxWj1FB
         Bbf6/YpMA5byZ4JZIHOZ2xCv+ikJpQt6g7wQ1FKcLiWg3a7fqxd+/P57o0bFJBzSKjSc
         PZva2BXkpxcI8IgnllW0YBHolB10MwFO69Wu7VNSG+iciGh/4bYj9/3k2cUEhkCaDX7X
         awXw==
X-Gm-Message-State: AC+VfDx/CFS7i8uGWlNFbMVX6AVcXQ/0m+ibA61AzhpwQrv0zGRCOuFH
        fossrkHh05Ov3hh/B6bxK51Bqw==
X-Google-Smtp-Source: ACHHUZ6b9KdE3IvpkY34oqh4G2E0vTllw32LgahGnbDkLedJ9c14WNdIKEMPr87qubommjUbO18UYg==
X-Received: by 2002:a05:6a20:9591:b0:10f:8798:9ffd with SMTP id iu17-20020a056a20959100b0010f87989ffdmr856191pzb.55.1686023583666;
        Mon, 05 Jun 2023 20:53:03 -0700 (PDT)
Received: from grundler-glapstation.lan ([70.134.62.80])
        by smtp.gmail.com with ESMTPSA id v71-20020a63894a000000b005439aaf0301sm3418452pgd.64.2023.06.05.20.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 20:53:03 -0700 (PDT)
From:   Grant Grundler <grundler@chromium.org>
To:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O \ 'Halloran" <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajat Jain <rajatja@chromium.org>,
        Grant Grundler <grundler@chromium.org>
Subject: [PATCH 1/2] PCI/AER: correctable error message as KERN_INFO
Date:   Mon,  5 Jun 2023 20:52:55 -0700
Message-ID: <20230606035256.2886098-1-grundler@chromium.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

