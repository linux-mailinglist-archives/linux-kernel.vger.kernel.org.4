Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFF26E9792
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjDTOti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjDTOtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:49:35 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 42A4049FA
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:49:34 -0700 (PDT)
Received: (qmail 502434 invoked by uid 1000); 20 Apr 2023 10:49:33 -0400
Date:   Thu, 20 Apr 2023 10:49:33 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, tonywwang@zhaoxin.com,
        weitaowang@zhaoxin.com
Subject: Re: [PATCH] =?utf-8?B?VUhDSe+8mmFkanVz?= =?utf-8?Q?t?= zhaoxin UHCI
 controllers OverCurrent bit value
Message-ID: <95017e76-d029-4e55-af4f-4c7be0a14576@rowland.harvard.edu>
References: <20230420111445.5028-1-WeitaoWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420111445.5028-1-WeitaoWang-oc@zhaoxin.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 07:14:45PM +0800, Weitao Wang wrote:
> Over Current condition is not standardized in the UHCI spec.
> Zhaoxin UHCI controllers report OverCurrent bit active off.
> Intel controllers report it active on, so we'll adjust the bit value.

The last sentence is irrelevant.  You should say instead that the 
uhci-hcd driver needs to be told to expect the active-off behavior.

> 
> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
> ---
>  drivers/usb/host/uhci-pci.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/host/uhci-pci.c b/drivers/usb/host/uhci-pci.c
> index 3592f757fe05..177e3c2aa287 100644
> --- a/drivers/usb/host/uhci-pci.c
> +++ b/drivers/usb/host/uhci-pci.c
> @@ -126,6 +126,10 @@ static int uhci_pci_init(struct usb_hcd *hcd)
>  	if (to_pci_dev(uhci_dev(uhci))->vendor == PCI_VENDOR_ID_VIA)
>  		uhci->oc_low = 1;
>  
> +	/* ZHAOXIN controllers report OverCurrent bit active off. */
> +	if (to_pci_dev(uhci_dev(uhci))->vendor == PCI_VENDOR_ID_ZHAOXIN)
> +		uhci->oc_low = 1;

This is really just a matter of taste, but IMO it would be better to 
combine this comment and test with the preceding one.  Something like:

	/*
	 * Intel controllers report the OverCurrent bit active on.  VIA
	 * and ZHAOXIN controllers report it active off, so we'll adjust
	 * the bit value.  (It's not standardized in the UHCI spec.)
	 */
	if (to_pci_dev(uhci_dev(uhci))->vendor == PCI_VENDOR_ID_VIA ||
	    to_pci_dev(uhci_dev(uhci))->vendor == PCI_VENDOR_ID_ZHAOXIN)
		uhci->oc_low = 1;

Alan Stern
