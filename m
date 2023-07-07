Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8AB74A8D1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 04:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjGGCQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 22:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjGGCQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 22:16:56 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 7B8721709
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 19:16:54 -0700 (PDT)
Received: (qmail 1198458 invoked by uid 1000); 6 Jul 2023 22:16:52 -0400
Date:   Thu, 6 Jul 2023 22:16:52 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     richard.yu@hpe.com
Cc:     verdun@hpe.com, nick.hawkins@hpe.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] usb: gadget: udc: gxp-udc: add HPE GXP USB support
Message-ID: <9171a00d-9ce5-4aca-8f81-2ad2b6961e17@rowland.harvard.edu>
References: <20230706215910.78772-1-richard.yu@hpe.com>
 <20230706215910.78772-3-richard.yu@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706215910.78772-3-richard.yu@hpe.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 04:59:09PM -0500, richard.yu@hpe.com wrote:
> From: Richard Yu <richard.yu@hpe.com>
> 
> The HPE GXP vEHCI controller presents a four port EHCI compatible PCI
> function to host software. Each vEHCI port is logically connected to a
> corresponding set of virtual device registers.

What makes the vEHCI controller virtual?  Presenting a "PCI function"
certainly seems to indicate it is a physical device, indeed, a PCI
device.

> 
> Signed-off-by: Richard Yu <richard.yu@hpe.com>
> ---
>  drivers/usb/gadget/udc/Kconfig   |    6 +
>  drivers/usb/gadget/udc/Makefile  |    1 +
>  drivers/usb/gadget/udc/gxp-udc.c | 1401 ++++++++++++++++++++++++++++++
>  3 files changed, 1408 insertions(+)
>  create mode 100644 drivers/usb/gadget/udc/gxp-udc.c
> 
> diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
> index 83cae6bb12eb..c01eb2a2c7db 100644
> --- a/drivers/usb/gadget/udc/Kconfig
> +++ b/drivers/usb/gadget/udc/Kconfig
> @@ -461,6 +461,12 @@ config USB_ASPEED_UDC
>  	  dynamically linked module called "aspeed_udc" and force all
>  	  gadget drivers to also be dynamically linked.
>  
> +config USB_GXP_UDC
> +        bool "GXP UDC Driver"
> +        depends on ARCH_HPE_GXP || COMPILE_TEST
> +        help
> +          Say "y" to add support for GXP UDC driver

Now hang on a second.  What sort of driver is this patch adding support 
for: a GXP vEHCI controller driver or a GXP UDC controller driver?  The 
patch description says the first, but the code says the second.

It sounds like this thing actually is a PCI device that appears to the 
OS as an actual EHCI controller, but with virtual (rather than physical) 
downstream ports, and it includes a virtual UDC for each port.  As such, 
it requires a driver for the virtual UDCs, which is what this patch 
provides.  (No new driver is needed for the EHCI controller part, since 
the kernel already has an EHCI driver.)

Is that a correct description?  And if it is, what is the purpose of 
this device?  To act as a testing ground for gadget drivers?

Alan Stern
