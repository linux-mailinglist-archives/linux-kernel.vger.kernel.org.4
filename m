Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D906C8878
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjCXWhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjCXWhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:37:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF573A8F;
        Fri, 24 Mar 2023 15:36:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E28E62CF8;
        Fri, 24 Mar 2023 22:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E65C433EF;
        Fri, 24 Mar 2023 22:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679697417;
        bh=FHDfGSZzbmTk+//HRHt6i1lfo5GNVr0Ttjxyt2cvrTI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=opspLHEaeKbA4uehjxQMn6exzH/017owytagqPFzVQdcJl536gnEN64GBiPUmAyiB
         nkhTOe8hxUoKIgfKA2/noNzkq2iI7qSAr+e6EI1bGcsn7+6Q2ren9bEtvGR3glJMZ8
         wXGFvY2AnC0MWDGnpwSbuFq9o0rZ+Wle8Hra8SsUGWt69aEdtGMzlVbXlLuoPWrTEH
         gE6ieb5aXzPTWrweJdQZPIM7mX3fjdSJaIhmpXYfF2V+puHUeP6IO3hgGe5cRVMdqv
         S+BMaM48YuloMttbmQMEOFOPh7svdazWoIu2ZLzu1ubNMQ/8o/VUeR/cVweXWiVIL0
         myMh+tp2rymVQ==
Date:   Fri, 24 Mar 2023 17:36:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Terry Bowman <terry.bowman@amd.com>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org, rrichter@amd.com,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v2 4/5] cxl/pci: Forward RCH downstream port-detected
 errors to the CXL.mem dev handler
Message-ID: <20230324223656.GA2660301@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323213808.398039-5-terry.bowman@amd.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'd call this a "PCI/AER: ..." patch since that's where all the
changes are.

On Thu, Mar 23, 2023 at 04:38:07PM -0500, Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> In RCD mode a CXL device (RCD) is exposed as an RCiEP, but CXL
> downstream and upstream ports are not enumerated and not visible in
> the PCIe hierarchy. Protocol and link errors are sent to an RCEC.

"RCD" isn't a common term in drivers/pci; can you expand it once here?

> Now, RCH downstream port-detected errors are signaled as internal AER
> errors (UIE/CIE) with the RCEC's source ID. A CXL handler must then

Similarly, "UIE" and "CIE" are new to drivers/pci; can you expand them
before using?  I assume Uncorrectable Internal Error (UIE) and
Corrected Internal Error (CIE)?  (Annoying that the PCIe spec uses
"Correctable" in general, but "Corrected" for Internal Errors.)

> inspect the error status in various CXL registers residing in the
> dport's component register space (CXL RAS cap) or the dport's RCRB
> (AER ext cap). [1]
> 
> This patch connects errors showing up in the RCEC's error handler with

"Connect errors ..." (we already know this text applies to *this
patch*).

> the CXL subsystem. Implement this by forwarding the error to all CXL
> devices below the RCEC. Since the entire CXL device is controlled only
> using PCIe Configuration Space of device 0, Function 0, only pass it
> there [2]. These devices have the Memory Device class code set
> (PCI_CLASS_MEMORY_CXL, 502h) and the existing cxl_pci driver can
> implement the handler.

> The CXL device driver is then responsible to
> enable error reporting in the RCEC's AER cap

I don't know exactly what you mean by "error reporting in the RCEC's
AER cap", but IIUC, for non-Root Port devices, generation of ERR_COR/
ERR_NONFATAL/ERR_FATAL messages is controlled by the Device Control
register and should already be enabled by pci_aer_init().

Maybe you mean setting AER mask/severity specifically for Internal
Errors?  I'm hoping to get as much of AER management as we can in the
PCI core and out of drivers, so maybe we need a new PCI interface to
do that.

In any event, I assume this sort of configuration would be an
enumeration-time thing, while *this* patch is a run-time thing, so
maybe this information belongs with a different patch?

> (esp. CIE and UIE) and to
> inspect the dport's CXL registers in addition (CXL RAS cap and AER ext
> cap).
> 
> The reason for choosing this implementation is that a CXL RCEC device
> is bound to the AER port driver, but the driver does not allow it to
> register a custom specific handler to support CXL. Connecting the RCEC
> hard-wired with a CXL handler does not work, as the CXL subsystem
> might not be present all the time. The alternative to add an
> implementation to the portdrv to allow the registration of a custom
> RCEC error handler isn't worth doing it as CXL would be its only user.
> Instead, just check for an CXL RCEC and pass it down to the connected
> CXL device's error handler.
> 
> [1] CXL 3.0 spec, 12.2.1.1 RCH Downstream Port-detected Errors
> [2] CXL 3.0 spec, 8.1.3 PCIe DVSEC for CXL Devices
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Since you're sending this patch (Terry) your Signed-off-by should be
last.

> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/pcie/aer.c | 45 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 7f0f52d094a4..d250a4caa85a 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -943,6 +943,49 @@ static bool find_source_device(struct pci_dev *parent,
>  	return true;
>  }
>  
> +#if IS_ENABLED(CONFIG_CXL_PCI)
> +
> +static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info);
> +
> +static int handle_cxl_error_iter(struct pci_dev *dev, void *data)
> +{
> +	struct aer_err_info *e_info = (struct aer_err_info *)data;
> +

Thanks for explaining the :00.0 in the commit log.  I think a one-line
comment here would be useful too so future readers don't have to dig
out the commit to understand.

> +	if (dev->devfn != PCI_DEVFN(0, 0))
> +		return 0;
> +
> +	/* Right now there is only a CXL.mem driver */
> +	if ((dev->class >> 8) != PCI_CLASS_MEMORY_CXL)
> +		return 0;
> +
> +	/* pci_dev_put() in handle_error_source() */
> +	dev = pci_dev_get(dev);

I don't see why you need this.  Didn't we get here via this path?

  aer_isr
    aer_isr_one_error
      find_source_device
        find_device_iter
          if (is_error_source())
            add_error_device
              pci_dev_get          <-- existing pci_dev_get()
      aer_process_err_devices
        for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++)
          if (aer_get_device_error_info(e_info->dev[i], e_info))
            handle_error_source
  +           handle_cxl_error
              pci_dev_put(dev)     <-- existing pci_dev_put()

So it looks like we wouldn't call handle_error_source() unless we had
a valid e_info->dev[i], which has already had pci_dev_get() called on
it.

Oh, I think I see ... handle_cxl_error() itself was called because an
RCEC reported an error on behalf of a CXL RCiEP (?), and then you use
pcie_walk_rcec() to look through all the associated RCiEPs, and
recursively call handle_error_source(), and we haven't acquired a
reference to those RCiEPs.  Right?

But I thought the CXL things were not enumerated (first paragraph of
commit log)?  But obviously these RCiEPs must be enumerated as PCI
devices or pcie_walk_rcec() and pci_dev_get() wouldn't work.

I haven't worked all the way through this, but I thought Sean Kelley's
and Qiuxu Zhuo's work was along the same line and might cover this,
e.g.,

  a175102b0a82 ("PCI/ERR: Recover from RCEC AER errors")
  579086225502 ("PCI/ERR: Recover from RCiEP AER errors")
  af113553d961 ("PCI/AER: Add pcie_walk_rcec() to RCEC AER handling")

But I guess maybe it's not quite the same case?

If you *do* need this, I know pci_dev_get(NULL) is a no-op, but since
you're testing for NULL anyway, I'd put it inside the "if" body.

> +	if (dev)
> +		handle_error_source(dev, e_info);
> +
> +	return 0;
> +}
> +
> +static bool is_internal_error(struct aer_err_info *info)
> +{
> +	if (info->severity == AER_CORRECTABLE)
> +		return info->status & PCI_ERR_COR_INTERNAL;
> +
> +	return info->status & PCI_ERR_UNC_INTN;
> +}
> +
> +static void handle_cxl_error(struct pci_dev *dev, struct aer_err_info *info)
> +{
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
> +	    is_internal_error(info))

What's unique about Internal Errors?  I'm trying to figure out why you
wouldn't do this for *all* CXL errors.

> +		pcie_walk_rcec(dev, handle_cxl_error_iter, info);
> +}
> +
> +#else
> +static inline void handle_cxl_error(struct pci_dev *dev,
> +				    struct aer_err_info *info) { }
> +#endif
> +
>  /**
>   * handle_error_source - handle logging error into an event log
>   * @dev: pointer to pci_dev data structure of error source device
> @@ -954,6 +997,8 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>  {
>  	int aer = dev->aer_cap;
>  
> +	handle_cxl_error(dev, info);
> +
>  	if (info->severity == AER_CORRECTABLE) {
>  		/*
>  		 * Correctable error does not need software intervention.
> -- 
> 2.34.1
> 
