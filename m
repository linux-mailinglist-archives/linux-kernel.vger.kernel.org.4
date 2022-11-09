Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8F7623749
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 00:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiKIXKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 18:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiKIXJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 18:09:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE112A40E;
        Wed,  9 Nov 2022 15:09:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9503461D1F;
        Wed,  9 Nov 2022 23:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA487C43470;
        Wed,  9 Nov 2022 23:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668035398;
        bh=jr17mFKpsW2i8xVCNI4y+k87mzG/8DXMLZLvqNoTp4c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QFLVSPjBGWRiiGUTDBSelwI+hMsi0aVHrecfBsmwLUwev0zISa/qzDC0PAL2dJtpr
         MRhpQ+RO1LjpXcMxcyqr8OY1/dMM2prjLH8F0BkLr/Bc0/8pv1uiK8cbDla0C5Id6B
         cjcWfc5DUWLYYY6wtFqlfik8OtezMYz6Pp9ro7qfkR9/dXzGrChXA+XuCG3mO/zqNW
         YXzajQH3gOzFpJNPOIyP5W8No6CTLwtPwBJBdZoomF3zmEPuq+CI4ZNkGRU5ggN/N4
         5E7v32djTDtkLiIEHJ2wb4vnosAxkXWxkzMv+Bqs+Dg3U+sb5GAnyTm9maXWftH3ez
         6giGSOKIamf7Q==
Date:   Wed, 9 Nov 2022 17:09:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robert Richter <rrichter@amd.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 6/9] cxl/pci: Do not ignore PCI config read errors in
 match_add_dports()
Message-ID: <20221109230956.GA581201@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109104059.766720-7-rrichter@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 11:40:56AM +0100, Robert Richter wrote:
> The link capabilities of a PCI device are read when enumerating its
> dports. This is done by reading the PCI config space. If that fails
> port enumeration ignores that error. However, reading the PCI config
> space should reliably work.
> 
> To reduce some complexity to the code flow when factoring out parts of
> the code in match_add_dports() for later reuse, change this to throw
> an error.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 0dbbe8d39b07..8271b8abde7a 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -47,7 +47,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
>  		return 0;
>  	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
>  				  &lnkcap))

You didn't change this, but I recommend using
pcie_capability_read_dword() when reading the PCIe Capability.  It
takes care of some annoying corner cases like devices that don't
implement Link Cap and the different versions of the PCIe Capability.

> -		return 0;
> +		return -ENXIO;
>  
>  	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
>  	if (rc)
> -- 
> 2.30.2
> 
