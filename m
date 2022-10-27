Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E36460FAD6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbiJ0OwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiJ0OwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:52:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB39D73D1;
        Thu, 27 Oct 2022 07:52:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8890F6236D;
        Thu, 27 Oct 2022 14:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A22C433D6;
        Thu, 27 Oct 2022 14:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666882334;
        bh=A1ZewOAYS+gc7csPzzBZUQX7V5JzEpABRbRsJocpbFc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=h832vFkjHAKdQNycljM0b4YURQasQy1dlYbrF9lgAURFxGlKgYSwtRIQJsSRwAc8/
         tTKBc6i8kyyqZQXYgyYCLOqU2xynh3At17UbWQ65FZLCMbISSfI8432UDJZ79E2s1x
         CNU1ywtsSmn/laVFQOaw/Y1d7LZIFK+j7B/GOXIsLtkyll+ahuwNBZrlM15enUaSGz
         2qGXC6bj1bdcVtYUB/9UaxDn/FRoYet42AHLp0dzg/eXsJrDIcy3piPCPJ26CEr351
         xlRENrYMEzyDN8iXooZvoJJFe2gnIaleGbFAakYTO9PNmrTacbmdMtgiZDqOjtaE98
         Z8VeXdAED6qGA==
Date:   Thu, 27 Oct 2022 09:52:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Terry Bowman <terry.bowman@amd.com>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        rafael@kernel.org, lenb@kernel.org, Jonathan.Cameron@huawei.com,
        dave@stgolabs.net, rrichter@amd.com
Subject: Re: [PATCH 2/5] cxl/pci: Discover and cache pointer to RCD dport's
 PCIe AER capability
Message-ID: <20221027145213.GA828055@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021185615.605233-3-terry.bowman@amd.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 01:56:12PM -0500, Terry Bowman wrote:
> CXL downport PCIe AER information needs to be logged during error handling.
> The RCD downport/upport does not have a BDF and is not PCI enumerable. As a
> result the CXL PCIe driver is not aware of the AER in 'PCI Express'
> capability located in the RCRB downport/upport. Logic must be introduced to
> use the downport/upport AER information.

I assume "downport" is the same as "dport" in "cxl_dport" and means
"Downstream Port".  Might be nice to reduce the number of variations
if feasible.

> +static resource_size_t cxl_get_dport_cap(struct cxl_memdev *cxlmd, int cap_id)
> +{
> +	resource_size_t offset, rcrb;
> +	void *rcrb_mapped;
> +	u32 cap_hdr;
> +
> +	rcrb = cxl_get_rcrb(cxlmd);
> +	if (!rcrb)
> +		return 0;
> +
> +	rcrb_mapped = ioremap(rcrb, SZ_4K);
> +	if (!rcrb_mapped)
> +		return 0;
> +
> +	offset = readl(rcrb_mapped + PCI_CAPABILITY_LIST);
> +	cap_hdr = readl(rcrb_mapped + offset);
> +
> +	while (PCI_CAP_ID(cap_hdr)) {
> +		if (PCI_CAP_ID(cap_hdr) == cap_id)
> +			break;
> +
> +		offset = PCI_CAP_NEXT(cap_hdr);
> +		if (offset == 0)
> +			break;
> +
> +		cap_hdr = readl(rcrb_mapped + offset);
> +	}
> +	iounmap((void *)rcrb_mapped);
> +
> +	if (PCI_CAP_ID(cap_hdr) != cap_id)
> +		return 0;
> +
> +	pr_debug("Found capability %X @ %llX (%X)\n",
> +		 cap_id, rcrb + offset, cap_hdr);

Would be nice to use dev_dbg() if possible here.

Is "%X" (upper-case hex) the convention in CXL?  Most places in Linux
seem to use "%x".  Also consider "%#x" (or "%#X") so it's obvious
these are hex.

> +void cxl_pci_aer_init(struct cxl_memdev *cxlmd)
> +{
> +	resource_size_t cap_base;
> +
> +	/* CXL2.0 is enumerable and will use AER attached to `struct pci_dev` */
> +	if (!is_rcd(cxlmd))
> +		return;
> +
> +	/*
> +	 * Read base address of the PCI express cap. Cache the cap's
> +	 * PCI_EXP_DEVCTL and PCI_EXP_DEVSTA for AER control and status.
> +	 */
> +	cap_base = cxl_get_dport_cap(cxlmd, PCI_CAP_ID_EXP);
> +	cxl_setup_dport_aer(cxlmd, cap_base);

I don't see anything about PCI_EXP_DEVCTL and PCI_EXP_DEVSTA in
cxl_get_dport_cap() or cxl_setup_dport_aer().  And I don't see any
caching, except for setting map->base in cxl_setup_dport_aer().

Caching those registers, especially PCI_EXP_DEVSTA, doesn't seem like
it would make much sense anyway since bits there are set by hardware
when things happen.
