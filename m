Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B18712E26
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbjEZUcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjEZUb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:31:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A281114;
        Fri, 26 May 2023 13:31:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B06E360E75;
        Fri, 26 May 2023 20:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F54C433EF;
        Fri, 26 May 2023 20:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685133116;
        bh=dgC43JNVASW0J73pGR7cjG6PDm1SnaU+sa3pg7UyPTM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HKUvPsNDMdMUCpYOuXiMJGS3ghlofdtQWNhOdtK934p4Msmm+XWZ4BHhOwz/Jq4J7
         jOTVpx+9Tpib4DJiSSLWGPfKJ/QygEgMmdSMiXmlfHXQqPaMMWDqrWzz8Ygj+r6u+i
         ITrmUIfw9VvSrNyvAFSmodoF3Ohgax85FZoHoHJLcq3vl17HnLtqT5cG5VURALJi0H
         LgkSKDeV56isZvePgaU56KK0xXUzqOFZewxXpKRZnZNOfS64CjZisZLrRsqGsJ6uta
         WX9N9b5t6IpIFs3BCrjiI+8n5LCq/KI3zMA1tp4XHn7rQVUvhGsoU/BRjKz/ouIRe+
         m54GG6kchVkxA==
Date:   Fri, 26 May 2023 15:31:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robert Richter <rrichter@amd.com>
Cc:     Terry Bowman <terry.bowman@amd.com>, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v4 23/23] PCI/AER: Unmask RCEC internal errors to enable
 RCH downstream port error handling
Message-ID: <ZHEXOlxfCCApI+NE@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG/cYUaZerXNqqJl@rric.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 12:08:33AM +0200, Robert Richter wrote:
> On 24.05.23 16:45:06, Bjorn Helgaas wrote:
> > On Tue, May 23, 2023 at 06:22:14PM -0500, Terry Bowman wrote:
> > > From: Robert Richter <rrichter@amd.com>
> > > 
> > > AER corrected and uncorrectable internal errors (CIE/UIE) are masked
> > > in their corresponding mask registers per default once in power-up
> > > state. [1][2] Enable internal errors for RCECs to receive CXL
> > > downstream port errors of Restricted CXL Hosts (RCHs).
> > > ...

> > > +static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
> > > +{
> > > +	int *handles_cxl = data;
> > > +
> > > +	*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
> > 
> > This effectively only looks at the *last* RCiEP associated with this
> > RCEC.  I would expect a logical OR of all of them.
> > 
> > > +	return *handles_cxl;
> 
> If this is non-zero, the iteration stops. So as soon we find a cxl
> device we can stop the loop. Else, all devices are non-cxl devs and
> the last return is zero too.
> 
> Now checking the code, pci_walk_bus() works that way, but walk_rcec()
> does not break in all cases. I think this function not working as
> expected. We would need to check if pci_walk_bus() stopped the
> iteration, e.g. with a return code.
> 
> Alternatively we could add this check:
> 
> 	if (!*handles_cxl)
> 		*handles_cxl = ...

If handles_cxl_error_iter() returns 1 (device is CXL mem, etc),
pci_walk_bus() will terminate.  And handles_cxl_error_iter() also sets
*userdata to 1, so handles_cxl_errors() will return true.

I think that's all you need in this case: at least one associated
RCiEP might report errors you care about, so you should unmask RCEC
internal errors.  You don't need to look at *all* the RCiEPs to know
that.

In the other case, cxl_rch_handle_error() does need to look at all the
RCiEPs, and cxl_rch_handle_error_iter() always returns 0, so it should
never terminate pci_walk_bus().

So I think I raised a false alarm here, and the current patches work
fine as-is.  But I do think it's a little bit tricky to set
*handles_cxl and also use that as the return value and rely on it
terminating the loop.  Maybe something like this would be more
straightforward?

  static int handles_cxl_error_iter(...)
  {
    ...
    *handles_cxl |= is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
    return 0;
  }

Certainly not as efficient because it looks at more RCiEPs than
strictly necessary.

> > > +static bool handles_cxl_errors(struct pci_dev *rcec)
> > > +{
> > > +	int handles_cxl = 0;
> > > +
> > > +	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
> > > +	    pcie_aer_is_native(rcec))
> > > +		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
> > > +
> > > +	return !!handles_cxl;

> > > @@ -1432,6 +1495,7 @@ static int aer_probe(struct pcie_device *dev)
> > >  		return status;
> > >  	}
> > >  
> > > +	cxl_rch_enable_rcec(port);
> > 
> > Could this be done by the driver that claims the CXL RCiEP?  There's
> > no point in unmasking the errors before there's a driver with
> > pci_error_handlers that can do something with them anyway.
> 
> This sounds reasonable at the first glance. The problem is there could
> be many devices associated with the RCEC. Not all of them will be
> bound to a driver and handler at the same time. We would need to
> refcount it or maintain a list of enabled devices. But there is
> already something similar by checking dev->driver. But right, AER
> errors could be seen and handled then at least on PCI level. I tent to
> permanently enable RCEC AER, but that could cause side-effects. What
> do you think?

IIUC, this really just affects CXL devices, so I think the choice is
(1) always unmask internal errors for RCECs where those CXL devices
report errors (as this patch does), or (2) unmask when first CXL
driver that can handle the errors is loaded and restore previous state
when last one is unloaded.

If the RCEC *only* handles errors for CXL devices, i.e., not for a mix
of vanilla PCIe RCiEPs and CXL RCiEPs, I think I'm OK with (1).  I
think you said only the CXL driver knows how to collect and interpret
the error data.  Is it OK that when no such driver is loaded, we field
error interrupts silently, without even mentioning that an error
occurred?  I guess without the driver, the device is probably not in
use.

Bjorn
