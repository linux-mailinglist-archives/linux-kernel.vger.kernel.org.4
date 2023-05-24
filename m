Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF9B710028
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 23:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbjEXVpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 17:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjEXVpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 17:45:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C89C5;
        Wed, 24 May 2023 14:45:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FB7D64085;
        Wed, 24 May 2023 21:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B258C4339B;
        Wed, 24 May 2023 21:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684964708;
        bh=WaEeFFzTqpv+HNMhHAynRB9YJ9frgX58WwRJJkCGpiw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZeYvJ8j+Aw1LpTcHTkY9XfBSRWf45Qoy+J2+HGHzkXd/nqSif32UHMKVjyrDfrp3O
         bEY+ATJnLbymLf+/Q1Z8UTphPRnNkvynaoQUW2mGUbY+IiuHd2TJY0JD0PfibtNK/h
         HCibg2qlUQB5nEuSAnPQ48mVOMh3va11WdCIJL02siWM3VVlpAj9V/ZnPd1iOilC4I
         RkLd8sP+8GH7thNecbQAt7SuimTK+OBm/FVSCyTkRv4whh+TJoKISLkTC/yXYRWYOh
         nQB/fmUHtn7efTrZ5Z81thn+LsIhVSGp5GPg9btPnu6TL+ALg2JL5AkzM2CD5rHNse
         53APTa6Qu3mAw==
Date:   Wed, 24 May 2023 16:45:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Terry Bowman <terry.bowman@amd.com>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org, rrichter@amd.com,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v4 23/23] PCI/AER: Unmask RCEC internal errors to enable
 RCH downstream port error handling
Message-ID: <ZG6FYhegl3+UlX76@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523232214.55282-24-terry.bowman@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 06:22:14PM -0500, Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> AER corrected and uncorrectable internal errors (CIE/UIE) are masked
> in their corresponding mask registers per default once in power-up
> state. [1][2] Enable internal errors for RCECs to receive CXL
> downstream port errors of Restricted CXL Hosts (RCHs).
> 
> [1] CXL 3.0 Spec, 12.2.1.1 - RCH Downstream Port Detected Errors
> [2] PCIe Base Spec 6.0, 7.8.4.3 Uncorrectable Error Mask Register,
>     7.8.4.6 Correctable Error Mask Register

I use "r6.0" to make sure it isn't mistaken for a section number.

> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/pci/pcie/aer.c | 64 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 2e3f00b6a5bd..c5076ae4eb58 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -948,6 +948,32 @@ static bool find_source_device(struct pci_dev *parent,
>  
>  #ifdef CONFIG_PCIEAER_CXL
>  
> +static int pci_aer_unmask_internal_errors(struct pci_dev *dev)
> +{
> +	int aer, rc;
> +	u32 mask;
> +
> +	if (!pcie_aer_is_native(dev))
> +		return -EIO;
> +
> +	aer = dev->aer_cap;
> +	rc = pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
> +	if (rc)
> +		return rc;

I don't think there's much value in checking all these config accesses
for failure.  A failure return really just means you called it with
invalid parameters; it doesn't tell you whether it was successful on
PCI.

> +	mask &= ~PCI_ERR_UNC_INTN;
> +	rc = pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
> +	if (rc)
> +		return rc;
> +	mask &= ~PCI_ERR_COR_INTERNAL;
> +	rc = pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
> +
> +	return rc;
> +}
> +
>  static bool is_cxl_mem_dev(struct pci_dev *dev)
>  {
>  	/*
> @@ -1031,7 +1057,44 @@ static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>  }
>  
> +static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
> +{
> +	int *handles_cxl = data;
> +
> +	*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);

This effectively only looks at the *last* RCiEP associated with this
RCEC.  I would expect a logical OR of all of them.

I see this is another use of is_cxl_mem_dev() and
cxl_error_is_native() that really requires them to be in this file.

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
> +	/*
> +	 * Internal errors are masked by default, unmask RCEC's here
> +	 * PCI6.0 7.8.4.3 Uncorrectable Error Mask Register (Offset 08h)
> +	 * PCI6.0 7.8.4.6 Correctable Error Mask Register (Offset 14h)

The spec references seem superfluous here.  The PCI_ERR_UNCOR_MASK and
PCI_ERR_COR_MASK in pci_aer_unmask_internal_errors() are pretty good
pointers.

> +	 */
> +	if (pci_aer_unmask_internal_errors(rcec))
> +		pci_err(rcec, "CXL: Failed to unmask internal errors");
> +	else
> +		pci_info(rcec, "CXL: Internal errors unmasked");
> +}
> +
>  #else
> +static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
>  static inline void cxl_rch_handle_error(struct pci_dev *dev,
>  					struct aer_err_info *info) { }
>  #endif
> @@ -1432,6 +1495,7 @@ static int aer_probe(struct pcie_device *dev)
>  		return status;
>  	}
>  
> +	cxl_rch_enable_rcec(port);

Could this be done by the driver that claims the CXL RCiEP?  There's
no point in unmasking the errors before there's a driver with
pci_error_handlers that can do something with them anyway.

>  	aer_enable_rootport(rpc);
>  	pci_info(port, "enabled with IRQ %d\n", dev->irq);
>  	return 0;
> -- 
> 2.34.1
> 
