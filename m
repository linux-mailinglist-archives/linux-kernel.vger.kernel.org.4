Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3150272418A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237464AbjFFL73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbjFFL7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:59:13 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068801731
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:58:55 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-528cdc9576cso3101393a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 04:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686052735; x=1688644735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRwHHVBuwFdTSPfIU1R1ZLyGoM8LybFGSYGhuRMiUuk=;
        b=GDNQ0tGgu2Z5y8Mf/D9JPoPQwu4ld0v9cyfkpZJS5csZsulT3j35QseR+SsQnfTBQC
         xOCAQh5Z7tFWRC0ztLdPhOS7aGuPg+3nb50IMfsVjzmLOOr0oSfNHvA58qaJpp69HbY0
         ADuxzsTs2X4H/XZiXmTOr+s3/g+tWoAv5AunAx5Xkeqr0EwRRVddE2H1ykfRmy02eAiR
         kJ13TIm1dKH9TOloLhbQfqkeW1tq9tdVMTilRVH+vbqZPjlf8bOtU0I4peE4pbz9u3EP
         sTkXNWr+h35oehx9f7j1eiwU3AXVzAK6JGNhNjqjkNUBbyX/MndA38mtAc8VBx1n4vEb
         gPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686052735; x=1688644735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRwHHVBuwFdTSPfIU1R1ZLyGoM8LybFGSYGhuRMiUuk=;
        b=iPHhvnwV8d2tLAcarrsKHd29SC11rF99NVVL/C4sd2ohLQct3uwgMvG8Mtm95t0JQ0
         Dphn7Sihi9N+6heikoFmbhR980Fdgtd1i0K2Tqxz3/G6Z+vhrXKaL4foo8Ci1MNbrOob
         OOPuzKFz9rlc5je1VG5kI5ogXTWexBjD0Ut3fMvUMwQXbk98g6Ny9kkGl7lauv+b9WYK
         0KoLhIuAsWIUH7h48WL/8i2cHtPaVMAdC1R+WgJz2eIUK0jnJt9WIkJvIKkYPlP/6gRF
         BUrNFxuxqZezSh9mMEIOhI9ijhv+PVfadAbIJBAYuBp10oO4qorstCoLyMpdnfw9QNV+
         mLjA==
X-Gm-Message-State: AC+VfDwHNT6rFP8Xs7ow2hRDk+Zby2yvUXctpxunU1tGywpRIijojTr+
        7SqHd9kHZ9hkFj2oH3OjD8Pp
X-Google-Smtp-Source: ACHHUZ4TaSeSgHzzlmzlfHDYxu6B/XdzkWmcSINkszkmDj0Di2XG9vgw4fFsdMUTnnzkxAr8YBTiSw==
X-Received: by 2002:a17:902:7d98:b0:1a6:b971:faf6 with SMTP id a24-20020a1709027d9800b001a6b971faf6mr853968plm.35.1686052735442;
        Tue, 06 Jun 2023 04:58:55 -0700 (PDT)
Received: from localhost.localdomain ([117.202.186.178])
        by smtp.gmail.com with ESMTPSA id b5-20020a170903228500b001acaf7e22bdsm8419226plh.14.2023.06.06.04.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 04:58:55 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 7/7] PCI: endpoint: Add kernel-doc for pci_epc_mem_init() API
Date:   Tue,  6 Jun 2023 17:28:14 +0530
Message-Id: <20230606115814.53319-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230606115814.53319-1-manivannan.sadhasivam@linaro.org>
References: <20230606115814.53319-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing kernel-doc for pci_epc_mem_init() API.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epc-mem.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
index 7dcf6f480b82..a9c028f58da1 100644
--- a/drivers/pci/endpoint/pci-epc-mem.c
+++ b/drivers/pci/endpoint/pci-epc-mem.c
@@ -115,6 +115,16 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
 }
 EXPORT_SYMBOL_GPL(pci_epc_multi_mem_init);
 
+/**
+ * pci_epc_mem_init() - Initialize the pci_epc_mem structure
+ * @epc: the EPC device that invoked pci_epc_mem_init
+ * @base: Physical address of the window region
+ * @size: Total Size of the window region
+ * @page_size: Page size of the window region
+ *
+ * Invoke to initialize a single pci_epc_mem structure used by the
+ * endpoint functions to allocate memory for mapping the PCI host memory
+ */
 int pci_epc_mem_init(struct pci_epc *epc, phys_addr_t base,
 		     size_t size, size_t page_size)
 {
-- 
2.25.1

