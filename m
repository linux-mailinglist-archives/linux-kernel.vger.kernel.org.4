Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9DA723A7C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbjFFHvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbjFFHu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:50:58 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A2D30DF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:47:18 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b160f3f185so1715487a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 00:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686037629; x=1688629629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MlFTV010nZQAE6a30Glk0hPHQmKZoo0vKsFtf+4D2Uk=;
        b=HIGV/CmWz7y7WrCFPo3V41nbzrubjgc5bQ1J/hcSntZSJCUYc1H0PYn7ddavlOfLhC
         HNlTNIZxixuQufsN1uIHgSQVKtGbcbp7WnHO4qCF8ea3ryQlbTmrc6BFh1UsgsDQUdPp
         akoLeV4s/a/XYd+z0Zn2o/xjqN3V5ZJsKeMrM4Z0wUcPTNdH2qsRHqqpk+d3sxotNQhi
         AMmEnODQR85S9AwfSyP7QZkbxToObBv2U/o7sQL8M/5XGGbjJZfEQ44zTjQsvZcjLc/w
         75gldNdlLGjy7/h5kwdDffrpxgzvYKTgfUr0sC5qmXe65ZU1TLyBFnQKGO4xw0fNtPu3
         GNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686037629; x=1688629629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlFTV010nZQAE6a30Glk0hPHQmKZoo0vKsFtf+4D2Uk=;
        b=YisFdExy6aUBo2imP0A4TxP21orwenii8Nk8bhTrbm/wh81RfSQqGIt/Lxg3ZNmyKd
         nyXtcOdKzbjFBd0wyX0BoZbJkRN34VQ7pqkOHqV7rECOCbVQscEqwyF5kKLa4mThaEvX
         G5G971DaW3f6BG5chQldMLHGgFsTwAPVmxHUErMwHPZXXGLtnogPVfx/9COWYur4ENFy
         390gsfeVM9dOpQ8vlhx77b940r1cjTH9yUToqwslnp32sGrJKAJwQwnBLML3MwoTRc6e
         5GY3anLFIBJl9X+ElmMHqThJVAKxRDJV6wTUpdgk8jC5fnb3Tb2dcSX4YljszdaaZOvY
         1S/w==
X-Gm-Message-State: AC+VfDyXojDiVQ2kbdQYtWDlQb2suGPoQVUGOXF6nwCx8KfyuFHd4mq0
        myMxQWlCvmK36HE4MPat7OV1
X-Google-Smtp-Source: ACHHUZ7LAgd37C5kKnCNBQWTGKJbGCJ5fd/gl0zPmNmKxpAwVLpglV/5zNTs1pfze7+ZOctzhxe41g==
X-Received: by 2002:a05:6358:c027:b0:129:c886:9603 with SMTP id ez39-20020a056358c02700b00129c8869603mr931501rwb.11.1686037628588;
        Tue, 06 Jun 2023 00:47:08 -0700 (PDT)
Received: from localhost.localdomain ([117.202.186.178])
        by smtp.gmail.com with ESMTPSA id k16-20020a63d110000000b00528b78ddbcesm6927063pgg.70.2023.06.06.00.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 00:47:08 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] PCI: endpoint: epf-mhi: Fix the outbound window offset handling
Date:   Tue,  6 Jun 2023 13:16:57 +0530
Message-Id: <20230606074657.31622-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

__pci_epf_mhi_alloc_map() allocates and maps the PCI outbound window memory
to endpoint local memory. For taking care of alignment restrictions, the
caller needs to specify the address alignment offset. Currently, this
offset is not added to the allocated physical and virtual addresses before
returning from the function.

But __pci_epf_mhi_unmap_free() function substracts the offset before
unmapping and freeing the memory, leading to incorrect unmap and free.

Fix this issue by adding the offset to physical and virtual addresses in
__pci_epf_mhi_alloc_map() itself. This also removes the need to add the
offset while doing memcpy in iatu_{read/write}.

Fixes: fd0fda1ef61a ("PCI: endpoint: Add PCI Endpoint function driver for MHI bus")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index f5bbaded49d4..18e46ee446c2 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -148,6 +148,9 @@ static int __pci_epf_mhi_alloc_map(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr,
 		return ret;
 	}
 
+	*paddr = *paddr + offset;
+	*vaddr = *vaddr + offset;
+
 	return 0;
 }
 
@@ -158,17 +161,9 @@ static int pci_epf_mhi_alloc_map(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr,
 	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
 	struct pci_epc *epc = epf_mhi->epf->epc;
 	size_t offset = pci_addr & (epc->mem->window.page_size - 1);
-	int ret;
 
-	ret = __pci_epf_mhi_alloc_map(mhi_cntrl, pci_addr, paddr, vaddr,
+	return __pci_epf_mhi_alloc_map(mhi_cntrl, pci_addr, paddr, vaddr,
 				      offset, size);
-	if (ret)
-		return ret;
-
-	*paddr = *paddr + offset;
-	*vaddr = *vaddr + offset;
-
-	return 0;
 }
 
 static void __pci_epf_mhi_unmap_free(struct mhi_ep_cntrl *mhi_cntrl,
@@ -230,7 +225,7 @@ static int pci_epf_mhi_iatu_read(struct mhi_ep_cntrl *mhi_cntrl, u64 from,
 		return ret;
 	}
 
-	memcpy_fromio(to, tre_buf + offset, size);
+	memcpy_fromio(to, tre_buf, size);
 
 	__pci_epf_mhi_unmap_free(mhi_cntrl, from, tre_phys, tre_buf, offset,
 				 size);
@@ -258,7 +253,7 @@ static int pci_epf_mhi_iatu_write(struct mhi_ep_cntrl *mhi_cntrl,
 		return ret;
 	}
 
-	memcpy_toio(tre_buf + offset, from, size);
+	memcpy_toio(tre_buf, from, size);
 
 	__pci_epf_mhi_unmap_free(mhi_cntrl, to, tre_phys, tre_buf, offset,
 				 size);
-- 
2.25.1

