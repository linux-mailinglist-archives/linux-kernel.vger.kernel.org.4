Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392BF6DA1F7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbjDFTuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbjDFTuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:50:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F6E4209;
        Thu,  6 Apr 2023 12:50:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7338162C3D;
        Thu,  6 Apr 2023 19:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C19C4339B;
        Thu,  6 Apr 2023 19:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680810646;
        bh=32/ERBuCPLg73Wp+3UJTiBuxgUhs/B+tC/Mg3mw9sJY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mI5rb8Kqbexq5Sn0CO12HTVYh67g8aNr3I4vWR7XOtjcr/2qK8eLNe4N9yrReytaa
         0yOep1u/DSfnBp9+6NLfRaBIxrMZxgnp7jyF5Bayn0bahU8w2wOdJ/95rwIW3sADPM
         LyToKoIPQI6HgU7Fews06dS6yBdd6OE1bW68Msw2DBXRlyLI/2tn7QKdT/3vXRiqOz
         YGSfra0HW+4hnWKkr97Tvrcdf/jprBkk53H57H8E5LyaqbGOlvuPuD0TRUspyiCe3e
         pyrprNIIz1Xmk7JgGwWskIZjsG7uHgqEXr4VOS4AMXWTK/q/YgDfTGhIv8Ot6/gNM/
         BFs+KFWxmBdCA==
Date:   Thu, 6 Apr 2023 14:50:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Grant Grundler <grundler@chromium.org>
Cc:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O 'Halloran <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rajat Jain <rajatja@chromium.org>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCHv2 pci-next 2/2] PCI/AER: Rate limit the reporting of the
 correctable errors
Message-ID: <20230406195045.GA3729127@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317175109.3859943-2-grundler@chromium.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 10:51:09AM -0700, Grant Grundler wrote:
> From: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> 
> There are many instances where correctable errors tend to inundate
> the message buffer. We observe such instances during thunderbolt PCIe
> tunneling.
> 
> It's true that they are mitigated by the hardware and are non-fatal
> but we shouldn't be spamming the logs with such correctable errors as it
> confuses other kernel developers less familiar with PCI errors, support
> staff, and users who happen to look at the logs, hence rate limit them.
> 
> A typical example log inside an HP TBT4 dock:
> [54912.661142] pcieport 0000:00:07.0: AER: Multiple Corrected error received: 0000:2b:00.0
> [54912.661194] igc 0000:2b:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
> [54912.661203] igc 0000:2b:00.0:   device [8086:5502] error status/mask=00001100/00002000
> [54912.661211] igc 0000:2b:00.0:    [ 8] Rollover
> [54912.661219] igc 0000:2b:00.0:    [12] Timeout
> [54982.838760] pcieport 0000:00:07.0: AER: Corrected error received: 0000:2b:00.0
> [54982.838798] igc 0000:2b:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
> [54982.838808] igc 0000:2b:00.0:   device [8086:5502] error status/mask=00001000/00002000
> [54982.838817] igc 0000:2b:00.0:    [12] Timeout

The timestamps don't contribute to understanding the problem, so we
can omit them.

> This gets repeated continuously, thus inundating the buffer.
> 
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> Signed-off-by: Grant Grundler <grundler@chromium.org>
> ---
>  drivers/pci/pcie/aer.c | 42 ++++++++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index cb6b96233967..b592cea8bffe 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -706,8 +706,8 @@ static void __aer_print_error(struct pci_dev *dev,
>  			errmsg = "Unknown Error Bit";
>  
>  		if (info->severity == AER_CORRECTABLE)
> -			pci_info(dev, "   [%2d] %-22s%s\n", i, errmsg,
> -				info->first_error == i ? " (First)" : "");
> +			pci_info_ratelimited(dev, "   [%2d] %-22s%s\n", i, errmsg,
> +					     info->first_error == i ? " (First)" : "");

I don't think this is going to reliably work the way we want.  We have
a bunch of pci_info_ratelimited() calls, and each caller has its own
ratelimit_state data.  Unless we call pci_info_ratelimited() exactly
the same number of times for each error, the ratelimit counters will
get out of sync and we'll end up printing fragments from error A mixed
with fragments from error B.

I think we need to explicitly manage the ratelimiting ourselves,
similar to print_hmi_event_info() or print_extlog_rcd().  Then we can
have a *single* ratelimit_state, and we can check it once to determine
whether to log this correctable error.

>  		else
>  			pci_err(dev, "   [%2d] %-22s%s\n", i, errmsg,
>  				info->first_error == i ? " (First)" : "");
> @@ -719,7 +719,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  {
>  	int layer, agent;
>  	int id = ((dev->bus->number << 8) | dev->devfn);
> -	const char *level;
>  
>  	if (!info->status) {
>  		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
> @@ -730,14 +729,21 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
>  	agent = AER_GET_AGENT(info->severity, info->status);
>  
> -	level = (info->severity == AER_CORRECTABLE) ? KERN_INFO : KERN_ERR;
> +	if (info->severity == AER_CORRECTABLE) {
> +		pci_info_ratelimited(dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
> +				     aer_error_severity_string[info->severity],
> +				     aer_error_layer[layer], aer_agent_string[agent]);
>  
> -	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
> -		   aer_error_severity_string[info->severity],
> -		   aer_error_layer[layer], aer_agent_string[agent]);
> +		pci_info_ratelimited(dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
> +				     dev->vendor, dev->device, info->status, info->mask);
> +	} else {
> +		pci_err(dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
> +			aer_error_severity_string[info->severity],
> +			aer_error_layer[layer], aer_agent_string[agent]);
>  
> -	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
> -		   dev->vendor, dev->device, info->status, info->mask);
> +		pci_err(dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
> +			dev->vendor, dev->device, info->status, info->mask);
> +	}
>  
>  	__aer_print_error(dev, info);
>  
> @@ -757,11 +763,19 @@ static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
>  	u8 bus = info->id >> 8;
>  	u8 devfn = info->id & 0xff;
>  
> -	pci_info(dev, "%s%s error received: %04x:%02x:%02x.%d\n",
> -		 info->multi_error_valid ? "Multiple " : "",
> -		 aer_error_severity_string[info->severity],
> -		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
> -		 PCI_FUNC(devfn));
> +	if (info->severity == AER_CORRECTABLE)
> +		pci_info_ratelimited(dev, "%s%s error received: %04x:%02x:%02x.%d\n",
> +				     info->multi_error_valid ? "Multiple " : "",
> +				     aer_error_severity_string[info->severity],
> +				     pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
> +				     PCI_FUNC(devfn));
> +	else
> +		pci_info(dev, "%s%s error received: %04x:%02x:%02x.%d\n",
> +			 info->multi_error_valid ? "Multiple " : "",
> +			 aer_error_severity_string[info->severity],
> +			 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
> +			 PCI_FUNC(devfn));
> +
>  }
>  
>  #ifdef CONFIG_ACPI_APEI_PCIEAER
> -- 
> 2.40.0.rc1.284.g88254d51c5-goog
> 
