Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1202D61046B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbiJ0VaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbiJ0VaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:30:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67414E635;
        Thu, 27 Oct 2022 14:30:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7ED862502;
        Thu, 27 Oct 2022 21:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC74C433C1;
        Thu, 27 Oct 2022 21:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666906212;
        bh=l3fIpRXljQEvqf+6oNMQQggxOWliUf7OCRru66C9w+o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=K0lrezsupKUjvCBZKwUvrC5aMYWr/fHwTJPhauAcNH1gEPx9jmeMlfW8+Y9CZyUVt
         Oq5uUWLvZxjAph26l/t2Jc/TsYUwGHkwOzjtOxn6DsnyL7fDfkrmQcA8vqsA+Zni4j
         pdDaoliguOJVaY7vDCz7Y4N/BTH6R66jclGhYPi1z+o02IaBJwLq4WjuHLpyXYz3eR
         nzFOqm0G/SI7iYl5j2AYAcsawmtC8g5EEfO4XRlbOYZ+KdIA9NgpQihVc9dk/T4/oN
         YQy/f+hizNiQTcLFpWCX0GKYSEwRVvhxgnp1TsakArnnIj9JhpWJKw6co3K+96jEMO
         LmZFT4Cb1Rg2Q==
Date:   Thu, 27 Oct 2022 16:30:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Terry Bowman <terry.bowman@amd.com>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        rafael@kernel.org, lenb@kernel.org, Jonathan.Cameron@huawei.com,
        dave@stgolabs.net, rrichter@amd.com
Subject: Re: [PATCH 5/5] cxl/pci: Log CXL device's PCIe AER and CXL RAS error
 information
Message-ID: <20221027213010.GA827560@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021185615.605233-6-terry.bowman@amd.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 01:56:15PM -0500, Terry Bowman wrote:
> The CXL downport PCIe AER and CXL RAS capability information needs to be
> logged during PCIe AER error handling.
> 
> The existing PCIe AER error handler logs native AER errors but does not
> log upport/downport AER capability residing in the RCRB. The CXL1.1
> RCRB does not have a BDF and is not enunmerable. The existing error handler
> logic does not display CXL RAS details either.

s/enunmerable/enumerable/

The patch itself doesn't seem to reference RCRB.  What's the
connection?

Is this specific to CXL?  The base PCIe spec also documents an RCRB,
though I don't think Linux does anything with it.

I guess at least the RCRB discovery must be CXL-specific, since I have
no idea how to find a generic PCIe RCRB.

> +static void cxl_error_report(struct cxl_memdev *cxlmd)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlmd->cxlds->dev);
> +	struct aer_capability_regs *aer_cap;
> +	struct ras_cap *ras_cap;
> +
> +	aer_cap = (struct aer_capability_regs *)cxlmd->cxlds->aer_map.base;
> +	ras_cap = (struct ras_cap *)cxlmd->cxlds->ras_map.base;

I don't think you need casts since .base is void *.

> +	pci_err(pdev, "CXL Error Report\n");
> +	pci_err(pdev, "AER Errors:\n");
> +	if (aer_cap) {
> +		cxl_print_aer(pdev, AER_CORRECTABLE, aer_cap);
> +		cxl_print_aer(pdev, AER_NONFATAL, aer_cap);
> +		cxl_print_aer(pdev, AER_FATAL, aer_cap);
> +	}
> +
> +	pci_err(pdev, "RAS Errors:\n");
> +	if (ras_cap) {
> +		pci_err(pdev, "RAS: uc_error_status = %X\n", readl(&ras_cap->uc_error_status));

"%X" will look a lot different than what cper_print_aer() logged
above.  No "0x", upper-case vs lower-case, "=" vs ":", etc.  Maybe
there should be a hint to connect RAS with CXL (maybe there's already
a dev_fmt somewhere that I missed)?

> +static void cxl_error_detected(struct pci_dev *pdev)
> +{
> +	struct cxl_memdev *cxlmd;
> +
> +	if (!is_cxl_memdev(&pdev->dev)) {
> +		pci_err(pdev, "CXL memory device is invalid\n");
> +		return;
> +	}
> +
> +	cxlmd = dev_get_drvdata(&pdev->dev);
> +	if (!cxlmd) {
> +		pci_err(pdev, "CXL memory device is NULL\n");
> +		return;
> +	}
> +
> +	if (!cxlmd->cxlds) {
> +		pci_err(pdev, "CXL device state object is NULL\n");
> +		return;
> +	}

Would these NULL pointers indicate a programming error, or do they
indicate lack of an optional feature?  If the former, I generally
prefer to just take the NULL pointer dereference oops instead of just
printing an easily-missed message.  But maybe the CXL style is to be
more defensive.

> +void cxl_print_aer(struct pci_dev *dev, int aer_severity,
> +		    struct aer_capability_regs *aer)
> +{
> +	cper_print_aer(dev, aer_severity, aer);

What is the purpose of this wrapper?  I guess you need an exported
symbol for some reason?

> +}
> +EXPORT_SYMBOL_GPL(cxl_print_aer);

> +static void report_cxl_errors(struct aer_rpc *rpc,
> +			      struct aer_err_source *e_src)
> +{
> +	struct pci_dev *pdev = rpc->rpd;
> +	struct aer_err_info e_info;
> +	u32 uncor_status, cor_status;
> +
> +	pci_read_config_dword(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS, &uncor_status);
> +	pci_read_config_dword(pdev, pdev->aer_cap + PCI_ERR_COR_STATUS, &cor_status);

I think it's kind of an existing defect that we don't have a single
place to read these registers.  I think they should be read either in
firmware (for firmware-first error handling, where Linux basically
gets a package of these register contents) or in Linux (for native
handling).  Ideally I think these paths would converge right after
Linux reads them.

Anyway, I don't think we should read these registers *again* for CXL.
And I assume firmware-first error handling should work for CXL as well
as for base PCIe?  That would imply that we wouldn't read them at all
here for the firmware-first case.

> +	if (!uncor_status && !cor_status)
> +		return;
> +
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_EC)
> +		pcie_walk_rcec(pdev, report_cxl_errors_iter, &e_info);
> +	else
> +		pci_walk_bus(pdev->subordinate, report_cxl_errors_iter, &e_info);
> +
> +	pci_write_config_dword(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS, uncor_status);
> +	pci_write_config_dword(pdev, pdev->aer_cap + PCI_ERR_COR_STATUS, cor_status);

Shouldn't this clearing be somehow contingent on pcie_aer_is_native()?

> +++ b/include/linux/pci.h
> @@ -827,6 +827,10 @@ enum pci_ers_result {
>  
>  /* PCI bus error event callbacks */
>  struct pci_error_handlers {
> +
> +	/* CXL error detected on this device */

Nit on the comment: calling this function doesn't imply that a CXL
error was detected; we *always* call it.  Apparently it's just an
opportunity to log any CXL-specific errors that may have occurred?

I think we need a comment about why this couldn't be done in the
existing .error_detected() callback.  I gather it might be related to
AER_CORRECTABLE errors, for which we don't call .error_detected()?

If the purpose is only to learn about correctable errors, maybe the
callback doesn't need to be CXL-specific and could be called at the
point where we test for AER_CORRECTABLE?

> +	void (*cxl_error_detected)(struct pci_dev *dev);
> +
>  	/* PCI bus error detected on this device */
>  	pci_ers_result_t (*error_detected)(struct pci_dev *dev,
>  					   pci_channel_state_t error);
> -- 
> 2.34.1
> 
