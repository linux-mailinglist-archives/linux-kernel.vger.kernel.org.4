Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55678611EEE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 03:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiJ2BNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 21:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJ2BNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 21:13:17 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id CEC781D4406
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 18:13:15 -0700 (PDT)
Received: (qmail 100580 invoked by uid 1000); 28 Oct 2022 21:13:14 -0400
Date:   Fri, 28 Oct 2022 21:13:14 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: ehci-pci: Set PROBE_PREFER_ASYNCHRONOUS
Message-ID: <Y1x+KmXhzikbEm8U@rowland.harvard.edu>
References: <20221028141821.1.I9a5353f81d1509f85f3a04f0cdc9099f6fe60811@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028141821.1.I9a5353f81d1509f85f3a04f0cdc9099f6fe60811@changeid>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 02:19:07PM -0700, Brian Norris wrote:
> This driver often takes on the order of 8ms to start, but every little
> bit counts. It shouldn't have many cross-device dependencies to
> race with, nor racy access to shared state with other drivers, so this
> should be a relatively low risk change.
> 
> This driver was pinpointed as part of a survey of top slowest initcalls
> (i.e., are built in, and probing synchronously) on a lab of ChromeOS
> systems.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

However, I'm curious to know why this patch makes ehci-pci use 
PROBE_PREFER_ASYNCHRONOUS even when CONFIG_PM isn't set, whereas the 2/2 
patch makes xhci-pci use PROBE_PREFER_ASYNCHRONOUS only when CONFIG_PM 
is set.

Alan Stern

>  drivers/usb/host/ehci-pci.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
> index 17f8b6ea0c35..4b148fe5e43b 100644
> --- a/drivers/usb/host/ehci-pci.c
> +++ b/drivers/usb/host/ehci-pci.c
> @@ -411,11 +411,12 @@ static struct pci_driver ehci_pci_driver = {
>  	.remove =	ehci_pci_remove,
>  	.shutdown = 	usb_hcd_pci_shutdown,
>  
> -#ifdef CONFIG_PM
>  	.driver =	{
> -		.pm =	&usb_hcd_pci_pm_ops
> -	},
> +#ifdef CONFIG_PM
> +		.pm =	&usb_hcd_pci_pm_ops,
>  #endif
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
>  };
>  
>  static int __init ehci_pci_init(void)
> -- 
> 2.38.1.273.g43a17bfeac-goog
> 
