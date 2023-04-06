Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C885D6D9255
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 11:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbjDFJLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 05:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjDFJLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:11:10 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AFC10D5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 02:11:09 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ml21so14726258pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 02:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680772268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e2Q0R+cPtVYASX+kk+skl8+bhqUfxXLWqqya3Wgcy9M=;
        b=TsSR5NO9bT73QD/a++EM0Wle9+oANzmklL5O9zq/yeh5nlokOfOndvFiyKO6gwoA/p
         FPQx0IGsAG9+QM90qX79UwxdcxPZgchCRGoU1FBBzmQ2/3ynI39DC99eVLETjjJPxfLx
         7iGBR4a7anpN7MxEvN002rzCxjmCv1LvoZslSNhJJlK+5Sa2RRQyuG3Lywgpzaa1V4lw
         Z/C/qXDNzUvNVbLsdFf0tGk7G3vazmFT6ia51uXdX7RW7XRh2fWeaagh4tNPvTrduhdv
         CDpRT/h7+QoZf4xljF21yiAPKL8zJOGw4NJC2O/pZV3qeuNZ/FPubL9+HDioZZQlTMj4
         s6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680772268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2Q0R+cPtVYASX+kk+skl8+bhqUfxXLWqqya3Wgcy9M=;
        b=gNDneKn305rI/Mcuee/xEuxkT252n/bpKZTMBNZxvIJdmu2cIuOO1kBqad3lbvh1Ly
         fFcAQd4M7E8qUee5mSEbbGfgO3xK2VNCu1CoWxpHpGKFNn4A0MmE+O8hNqx0/vbZ7gQE
         WCJPYimme0mcji5sYp08tjjM9ZmExPNw4l0QMc2BgUodg2KXj1aXfRFYeLeNAziC7O7m
         Yo1D4grvttvUZY6akGP8v/udL/f9sGQz6h9q+cUE+x4hmAx4GFbzmnjsbGp4CRjGZpVO
         bFfuFlKlTDxOdQkgonhqUsOdydXicbGvdQo8OGJDRHVvUF5TXkyzc1ZMFYNkMw9CY7s+
         7luA==
X-Gm-Message-State: AAQBX9cI7YGR3Kd6/StBRmfvZDmAQId3zRBM3OawhGcvz3ToMl9vKH2h
        MvKX6+TJ1T1dHCPLOEgRW3afOhNqGAHcwelz+cUhRURjr7pcTwwflDLIBOicOlPGwvsOuWcxzKu
        qMiEwfv1Du9Ekr0c=
X-Google-Smtp-Source: AKy350aHGRc2vXS29UWaRDZgtvLUB5/Pf9RPwLjFsMwuDY9X2apLg08tcC9+aOT8GlyiaY6HUTO+kw==
X-Received: by 2002:a17:902:d4d2:b0:1a1:cef2:acd4 with SMTP id o18-20020a170902d4d200b001a1cef2acd4mr5506623plg.21.1680772268462;
        Thu, 06 Apr 2023 02:11:08 -0700 (PDT)
Received: from google.com (41.183.143.34.bc.googleusercontent.com. [34.143.183.41])
        by smtp.gmail.com with ESMTPSA id v6-20020a1709028d8600b001a1faed8707sm932045plo.63.2023.04.06.02.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 02:11:08 -0700 (PDT)
Date:   Thu, 6 Apr 2023 14:40:58 +0530
From:   Ajay Agarwal <ajayagarwal@google.com>
To:     William McVicker <willmcvicker@google.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sajid Dalvi <sdalvi@google.com>,
        Han Jingoo <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, kernel-team@android.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] PCI: dwc: Wait for link up only if link is started
Message-ID: <ZC6Mov/wX4cbIiNG@google.com>
References: <ZC12lN9Cs0QlPhVh@lpieralisi>
 <20230405182753.GA3626483@bhelgaas>
 <ZC3Ev7qnUDdG0cFd@google.com>
 <ZC3Kw4AYiMKY7nCR@google.com>
 <ZC5Bfa2N0aWo0o0l@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC5Bfa2N0aWo0o0l@google.com>
X-ccpol: medium
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is my attempt at a patch which can satisfy all the requirements
(Ideally, I did not want to use `pci->ops` in the host driver but I
could not figure out any other way):

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9952057c8819..39c7219ec7c9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -485,15 +485,18 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err_remove_edma;
 
-	if (!dw_pcie_link_up(pci)) {
-		ret = dw_pcie_start_link(pci);
+	ret = dw_pcie_start_link(pci);
+	if (ret)
+		goto err_remove_edma;
+
+	if (dw_pcie_link_up(pci)) {
+		dw_pcie_print_link_status(pci);
+	} else if (pci->ops && pci->ops->start_link) {
+		ret = dw_pcie_wait_for_link(pci);
 		if (ret)
-			goto err_remove_edma;
+			goto err_stop_link;
 	}
 
-	/* Ignore errors, the link may come up later */
-	dw_pcie_wait_for_link(pci);
-
 	bridge->sysdata = pp;
 
 	ret = pci_host_probe(bridge);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 53a16b8b6ac2..03748a8dffd3 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -644,9 +644,20 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
 	dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
 }
 
-int dw_pcie_wait_for_link(struct dw_pcie *pci)
+void dw_pcie_print_link_status(struct dw_pcie *pci)
 {
 	u32 offset, val;
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
+
+	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
+		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
+		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
+}
+
+int dw_pcie_wait_for_link(struct dw_pcie *pci)
+{
 	int retries;
 
 	/* Check if the link is up or not */
@@ -662,12 +673,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 		return -ETIMEDOUT;
 	}
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
-
-	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
-		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
-		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
+	dw_pcie_print_link_status(pci);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 79713ce075cc..615660640801 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -429,6 +429,7 @@ void dw_pcie_setup(struct dw_pcie *pci);
 void dw_pcie_iatu_detect(struct dw_pcie *pci);
 int dw_pcie_edma_detect(struct dw_pcie *pci);
 void dw_pcie_edma_remove(struct dw_pcie *pci);
+void dw_pcie_print_link_status(struct dw_pcie *pci);
 
 static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
 {
