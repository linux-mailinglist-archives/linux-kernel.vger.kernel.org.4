Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47F472883A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236959AbjFHTWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236946AbjFHTWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:22:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523C12D75;
        Thu,  8 Jun 2023 12:21:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 876EC64FE4;
        Thu,  8 Jun 2023 19:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0D7C433D2;
        Thu,  8 Jun 2023 19:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686252090;
        bh=iE7aCCGB8rGz6ONiIsoW2lt23ahnVYXAdMXiH4My450=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=szREKW3Wd80cpQuUmlQqsqLRgZbPGoww8W5R2pZ1Tk0Mboee0gX3LQCVANiYa8jcG
         pRl97NDUi0SEGb5ryiYY/8PGKVi0AUTC3J8DfEJxiytMdd3B9YJR8r/RTxc3/RdFyV
         G+YuS4HOWVzxaeD7VUsyDGTHhtV7onl0gEcx02syfN08qI5zCgmv4XCm1bJLzrwfed
         7QOGB2Aa3cB7kLdfE4sRGDEzR6VB4Kh8g4Wdb7yK8I5UIYQH6JqsV7QmiCwaiDIU2q
         0zl26OO3Ke/up4CpsKl4tiOC+Bj0dPbJhBxUCS1qzObhH+Z4Uq9HrTEIobtzIEg3N5
         zoRT2flWkVqmA==
Date:   Thu, 8 Jun 2023 14:21:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Terry Bowman <terry.bowman@amd.com>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org, rrichter@amd.com,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v5 26/26] PCI/AER: Unmask RCEC internal errors to enable
 RCH downstream port error handling
Message-ID: <20230608192128.GA1210443@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-27-terry.bowman@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 05:16:51PM -0500, Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> AER corrected and uncorrectable internal errors (CIE/UIE) are masked
> in their corresponding mask registers per default once in power-up
> state. [1][2] Enable internal errors for RCECs to receive CXL
> downstream port errors of Restricted CXL Hosts (RCHs).
> 
> [1] CXL 3.0 Spec, 12.2.1.1 - RCH Downstream Port Detected Errors
> [2] PCIe Base Spec r6.0, 7.8.4.3 Uncorrectable Error Mask Register,
>     7.8.4.6 Correctable Error Mask Register
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pcie/aer.c | 57 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index c354ca5e8f2b..4f9203e27c62 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -948,6 +948,30 @@ static bool find_source_device(struct pci_dev *parent,
>  
>  #ifdef CONFIG_PCIEAER_CXL
>  
> +/**
> + * pci_aer_unmask_internal_errors - unmask internal errors
> + * @dev: pointer to the pcie_dev data structure
> + *
> + * Unmasks internal errors in the Uncorrectable and Correctable Error
> + * Mask registers.
> + *
> + * Note: AER must be enabled and supported by the device which must be
> + * checked in advance, e.g. with pcie_aer_is_native().
> + */
> +static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> +{
> +	int aer = dev->aer_cap;
> +	u32 mask;
> +
> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
> +	mask &= ~PCI_ERR_UNC_INTN;
> +	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
> +
> +	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
> +	mask &= ~PCI_ERR_COR_INTERNAL;
> +	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
> +}
> +
>  static bool is_cxl_mem_dev(struct pci_dev *dev)
>  {
>  	/*
> @@ -1027,7 +1051,39 @@ static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>  }
>  
> +static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
> +{
> +	int *handles_cxl = data;
> +
> +	if (!*handles_cxl)
> +		*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
> +
> +	/* Non-zero terminates iteration */
> +	return *handles_cxl;
> +}
> +
> +static bool handles_cxl_errors(struct pci_dev *rcec)
> +{
> +	int handles_cxl = 0;
> +
> +	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
> +	    pcie_aer_is_native(rcec))
> +		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
> +
> +	return !!handles_cxl;
> +}
> +
> +static void cxl_rch_enable_rcec(struct pci_dev *rcec)
> +{
> +	if (!handles_cxl_errors(rcec))
> +		return;
> +
> +	pci_aer_unmask_internal_errors(rcec);
> +	pci_info(rcec, "CXL: Internal errors unmasked");
> +}
> +
>  #else
> +static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
>  static inline void cxl_rch_handle_error(struct pci_dev *dev,
>  					struct aer_err_info *info) { }
>  #endif
> @@ -1428,6 +1484,7 @@ static int aer_probe(struct pcie_device *dev)
>  		return status;
>  	}
>  
> +	cxl_rch_enable_rcec(port);
>  	aer_enable_rootport(rpc);
>  	pci_info(port, "enabled with IRQ %d\n", dev->irq);
>  	return 0;
> -- 
> 2.34.1
> 
