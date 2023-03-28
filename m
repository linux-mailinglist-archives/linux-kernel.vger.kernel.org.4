Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5436CC91B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjC1RVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjC1RVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:21:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E303BE192;
        Tue, 28 Mar 2023 10:21:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FA45618CE;
        Tue, 28 Mar 2023 17:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6738FC433EF;
        Tue, 28 Mar 2023 17:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680024066;
        bh=XG4Gv1uDdcHMJWold8r+MUkd4gUOdU/9HSIAESk1/iI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kcCgVmfoCcOL/fkAXJQsz0LR/9b+X2wFGZS6g8nS9Cva1U101OE0U3EYyXbdkbqTy
         aceP/+FEMtrdQPPfqvP04qtm8sFXLHSaf041pAalMFGJKoaaGgN8X+pOn+S8oI33Ye
         tIOd6sKIwS0xLixDLCa1mNY9dJyX+ECsqXhzOWdH8m5AScZp6HCSXUJID+reaRG3Wz
         Xv6Te2/TzBDwEPhxKQBKWns6Kx3J+HnN4AVGU1YcceA5efROf1luvolQTWIUtyl5IO
         RMLsJC8X3gumbnI1bFdMRIw1+8QGPcoQSwj8r8cEwhoZVTVT+phzktL1gEY8PnExS5
         mxpemz9CNneEQ==
Date:   Tue, 28 Mar 2023 12:21:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robert Richter <rrichter@amd.com>
Cc:     Terry Bowman <terry.bowman@amd.com>, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 4/5] cxl/pci: Forward RCH downstream port-detected
 errors to the CXL.mem dev handler
Message-ID: <20230328172104.GA2897826@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCIPuPM+LZsOFIIZ@rric.localdomain>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc linux-pci, more error handling folks; beginning of thread at
https://lore.kernel.org/all/20230323213808.398039-1-terry.bowman@amd.com/]

On Mon, Mar 27, 2023 at 11:51:39PM +0200, Robert Richter wrote:
> On 24.03.23 17:36:56, Bjorn Helgaas wrote:

> > > The CXL device driver is then responsible to
> > > enable error reporting in the RCEC's AER cap
> > 
> > I don't know exactly what you mean by "error reporting in the RCEC's
> > AER cap", but IIUC, for non-Root Port devices, generation of ERR_COR/
> > ERR_NONFATAL/ERR_FATAL messages is controlled by the Device Control
> > register and should already be enabled by pci_aer_init().
> > 
> > Maybe you mean setting AER mask/severity specifically for Internal
> > Errors?  I'm hoping to get as much of AER management as we can in the
> 
> Richt, this is implemented in patch #5 in function
> rcec_enable_aer_ints().

I think we should add a PCI core interface for this so we can enforce
the AER ownership question (all the crud like pcie_aer_is_native()) in
one place.

> > PCI core and out of drivers, so maybe we need a new PCI interface to
> > do that.
> > 
> > In any event, I assume this sort of configuration would be an
> > enumeration-time thing, while *this* patch is a run-time thing, so
> > maybe this information belongs with a different patch?
> 
> Do you mean once a Restricted CXL host (RCH) is detected, the internal
> errors should be enabled in the device mask, all this done during
> device enumeration? But wouldn't interrupts being enabled then before
> the CXL device is ready?

I'm not sure what you mean by "before the CXL device is ready."  What
makes a CXL device ready, and how do we know when it is ready?

pci_aer_init() turns on PCI_EXP_DEVCTL_CERE, PCI_EXP_DEVCTL_FERE, etc
as soon as we enumerate the device, before any driver claims the
device.  I'm wondering whether we can do this PCI_ERR_COR_INTERNAL and
PCI_ERR_UNC_INTN fiddling around the same time?

> > I haven't worked all the way through this, but I thought Sean Kelley's
> > and Qiuxu Zhuo's work was along the same line and might cover this,
> > e.g.,
> > 
> >   a175102b0a82 ("PCI/ERR: Recover from RCEC AER errors")
> >   579086225502 ("PCI/ERR: Recover from RCiEP AER errors")
> >   af113553d961 ("PCI/AER: Add pcie_walk_rcec() to RCEC AER handling")
> > 
> > But I guess maybe it's not quite the same case?
> 
> Actually, we use this code to handle errors that are reported to the
> RCEC and only implement here the CXL specifics. That is, checking if
> the RCEC receives something from a CXL downstream port and forwarding
> that to a CXL handler (this patch). The handler then checks the AER
> err cap in the RCRB of all CXL downstream ports associated to the RCEC
> (not visible in the PCI hierarchy), but discovered through the :00.0
> RCiEP (patch #5).

There are two calls to pcie_walk_rcec():

  1) The existing one in find_source_device()
  2) The one you add in handle_cxl_error()

Does the call in handle_cxl_error() look at devices that the existing
call in find_source_device() does not?  I'm trying to understand why
we need both calls.

> > > +static bool is_internal_error(struct aer_err_info *info)
> > > +{
> > > +	if (info->severity == AER_CORRECTABLE)
> > > +		return info->status & PCI_ERR_COR_INTERNAL;
> > > +
> > > +	return info->status & PCI_ERR_UNC_INTN;
> > > +}
> > > +
> > > +static void handle_cxl_error(struct pci_dev *dev, struct aer_err_info *info)
> > > +{
> > > +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
> > > +	    is_internal_error(info))
> > 
> > What's unique about Internal Errors?  I'm trying to figure out why you
> > wouldn't do this for *all* CXL errors.
> 
> Per CXL specification downstream port errors are signaled using
> internal errors. 

Maybe a spec reference here to explain is_internal_error()?  Is the
point of the check to *exclude* non-internal errors?  Or is basically
documentation that there shouldn't ever *be* any non-internal errors?
I guess the latter wouldn't make sense because at this point we don't
know whether this is a CXL hierarchy.

> All other errors would be device specific, we cannot
> handle that in a generic CXL driver.

I'm missing the point here.  We don't have any device-specific error
handling in aer.c; it only connects the generic *reporting* mechanism
(AER log registers and Root Port interrupts) to the drivers that do
the device-specific things via err_handler hooks.  I assume we want a
similar model for CXL.

Bjorn
