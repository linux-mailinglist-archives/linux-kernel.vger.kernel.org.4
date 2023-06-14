Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4300F7119EB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 00:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241777AbjEYWBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 18:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjEYWBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 18:01:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DDE183;
        Thu, 25 May 2023 15:01:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03ECA615C8;
        Thu, 25 May 2023 22:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A547C433D2;
        Thu, 25 May 2023 22:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685052063;
        bh=ptE4zUO2N1qn5e28e8ELQ07KDbno8edydjVNz2FJipk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tlUgaxrF3z9IwUeA0DGL4h+NIbcmOJM/r14l3L3I9HRklMIf5eX3CeONLvzDEntda
         osuUN5uTSj89B76YksTuXRcjG3o8fnn1/nKVfoBt6SjNv1TMJy8pxP0weYoXN08/LZ
         NnWpZaqHEPkpZ9EFY31YI9li4C+FWhtxNf9dtO5psADQ1v26O4DYueomEjqdkpDHdo
         L9s2ilCnNe0E8J44KETH5vfeLzcAjK1qIvGazQyKlmwaBwWn7amMIDus4DjZp+Q/fw
         CgxEXg46iB38Nmidqd9ugZLtJxkJb0isTuKOi0eGXQXe/NfDzgbtfkzFzNEvgjyGAN
         CxYZdeN6e4wtQ==
Date:   Thu, 25 May 2023 17:01:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robert Richter <rrichter@amd.com>
Cc:     alison.schofield@intel.com, dave.jiang@intel.com,
        Terry Bowman <terry.bowman@amd.com>, vishal.l.verma@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        bhelgaas@google.com, Oliver O'Halloran <oohall@gmail.com>,
        Jonathan.Cameron@huawei.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com
Subject: Re: [PATCH v4 22/23] PCI/AER: Forward RCH downstream port-detected
 errors to the CXL.mem dev handler
Message-ID: <ZG/anZ78FukSpERs@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG/TKOgMTSljryHN@rric.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 11:29:58PM +0200, Robert Richter wrote:
> eOn 24.05.23 16:32:35, Bjorn Helgaas wrote:
> > On Tue, May 23, 2023 at 06:22:13PM -0500, Terry Bowman wrote:
> > > From: Robert Richter <rrichter@amd.com>
> > > 
> > > In Restricted CXL Device (RCD) mode a CXL device is exposed as an
> > > RCiEP, but CXL downstream and upstream ports are not enumerated and
> > > not visible in the PCIe hierarchy. Protocol and link errors are sent
> > > to an RCEC.
> > >
> > > Restricted CXL host (RCH) downstream port-detected errors are signaled
> > > as internal AER errors, either Uncorrectable Internal Error (UIE) or
> > > Corrected Internal Errors (CIE). 
> > 
> > From the parallelism with RCD above, I first thought that RCH devices
> > were non-RCD mode and *were* enumerated as part of the PCIe hierarchy,
> > but actually I suspect it's more like the following?
> > 
> >   ... but CXL downstream and upstream ports are not enumerated and not
> >   visible in the PCIe hierarchy.
> > 
> >   Protocol and link errors from these non-enumerated ports are
> >   signaled as internal AER errors ... via a CXL RCEC.
> 
> Exactly, except the RCEC is standard PCIe and also must not
> necessarily on the same PCI bus as the CXL RCiEPs are.

So make it "RCEC" instead of "CXL RCEC", I guess?  PCIe r6.0, sec
7.9.10.3, allows an RCEC to be associated with RCiEPs on different
buses, so nothing to see there.

> > > The error source is the id of the RCEC.
> > 
> > This seems odd; I assume this refers to the RCEC's AER Error Source
> > Identification register, and the ERR_COR or ERR_FATAL/NONFATAL Source
> > Identification would ordinarily be the Requester ID of the RCiEP that
> > "sent" the Error Message.  But you're saying it's actually the ID of
> > the *RCEC*, not the RCiEP?
> 
> Right, the downstream port has its own AER ext capability in
> non-config (io mapped) RCRB register range. Errors originating from
> there are signaled as internal AER errors via the RCEC *with* the
> RCEC's Requester ID. Code walks through all associated CXL endpoints,
> determines the dport and checks its AER.
> 
> There is also an RDPAS structure defined in CXL but that is only a
> different way to provide the RCEC to dport association instead of
> using the RCEC's Endpoint Association Extended Capability. In the end
> we get all associated RCHs and check the AER of all their dports.
> 
> The upstream port is signaled using the RCiEP's AER. CXL spec is
> strict here: "Upstream Port RCRB shall not implement the AER Extended
> Capability." The RCiEP's requestor ID is used then and its config
> space the AER is in.
> 
> CXL.cachemem errors are reported with the RCiEP as requester
> too. Status is in the CXL RAS cap and the UIE or CIE is set
> respectively in the AER status of the RCiEP.
>
> > We're going to call pci_aer_handle_error() as well, to handle the
> > non-internal errors, and I'm pretty sure that path expects the RCiEP
> > ID there.
> > 
> > Whatever the answer, I'm not sure this sentence is actually relevant
> > to this patch, since this patch doesn't read PCI_ERR_ROOT_ERR_SRC or
> > look at struct aer_err_source.id.
> 
> The source id is used in aer_process_err_devices() which finally calls
> handle_error_source() for the device with the requestor id. This is
> the place where cxl_rch_handle_error() checks if it is an RCEC that
> received an internal error and has cxl devices connected to it. Then,
> the request is forwarded to the cxl_mem handler which also needs to
> check the dport now. That is, pcie_walk_rcec() in
> cxl_rch_handle_error() is called with the RCEC's pci handle,
> cxl_rch_handle_error_iter() with the RCiEP's pci handle.

I'm still not sure this is relevant.  Isn't that last sentence just
the way we always use pcie_walk_rcec()?

If there's something *different* here about CXL, and it's important to
this patch, sure.  But I don't see that yet.  Maybe a comment in the
code if you think it's important to clarify something there.

Bjorn
