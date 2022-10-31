Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7B7612E79
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 02:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJaBGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 21:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJaBGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 21:06:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25B8A1A2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 18:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667178368; x=1698714368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EMDXCRdwqlGlnOwAqWbXNb8UnPKBXi5/6JNHQV9oHYo=;
  b=Rc4hZU6pbFJ/ujbgG31gzzi9SDobqf527RhzyyRZaCWOEYaRQ7PCzcs4
   TJMq1VVoK5OlLckouXVGsgwbhuJAgEbHZHYByl5zWgJ2f3UbazMFIx7Ub
   K0RQfpuR5o3qgHQq5aq521ne84egwAMPQTqqitcy/23AWHwrl9K3VW/AI
   uC4F6aLdQVbZqpMFR7sb6wKdAEobefF35/PhDYdtE5N9SCT0fMAzn7DHL
   vWcx4R7KbiFg0jKnVlA2J9dcAdX4ju5mCnyW2S6KDAE9JUCcrhHG72nIM
   fXgX25uyaZDKFZLu9A9sIy1EHfoYbVQGruakZwPPQsnhLxzx9wMJRVhUF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="373001668"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="373001668"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 18:06:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="584496166"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="584496166"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga003.jf.intel.com with ESMTP; 30 Oct 2022 18:06:06 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v14 04/13] PCI: Enable PASID only when ACS RR & UF enabled on upstream path
Date:   Mon, 31 Oct 2022 08:59:08 +0800
Message-Id: <20221031005917.45690-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221031005917.45690-1-baolu.lu@linux.intel.com>
References: <20221031005917.45690-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Requester ID/Process Address Space ID (PASID) combination
identifies an address space distinct from the PCI bus address space,
e.g., an address space defined by an IOMMU.

But the PCIe fabric routes Memory Requests based on the TLP address,
ignoring any PASID (PCIe r6.0, sec 2.2.10.4), so a TLP with PASID that
SHOULD go upstream to the IOMMU may instead be routed as a P2P
Request if its address falls in a bridge window.

To ensure that all Memory Requests with PASID are routed upstream,
only enable PASID if ACS P2P Request Redirect and Upstream Forwarding
are enabled for the path leading to the device.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Tony Zhu <tony.zhu@intel.com>
---
 drivers/pci/ats.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index c967ad6e2626..f9cc2e10b676 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -382,6 +382,9 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (!pasid)
 		return -EINVAL;
 
+	if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
+		return -EINVAL;
+
 	pci_read_config_word(pdev, pasid + PCI_PASID_CAP, &supported);
 	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
 
-- 
2.34.1

