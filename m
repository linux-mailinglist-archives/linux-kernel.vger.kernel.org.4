Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA9F6CD723
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjC2J7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjC2J7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:59:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7072944B0;
        Wed, 29 Mar 2023 02:59:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1B6061C35;
        Wed, 29 Mar 2023 09:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C2FC433D2;
        Wed, 29 Mar 2023 09:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680083946;
        bh=7+VWB/mt5T/tZPFNs9VwH0Sj1WLPTU8VpwCh7VUS9+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZDsSU0uQ7wWbhvhOB0X1F9jR5vO6BaiOcCwYT122JKgTHOWTaOytd3z6o/jjsR23Z
         sf0QQ+4HBOxYPj0stA0mbVfStIcWiH3KBf3Xz3+MOfWU8tgPMlxLUn1QepAFYMpjCy
         qs3pHYeRg/ZY34KtpqOYWWw4yZqLHRQMEDkeXnG4=
Date:   Wed, 29 Mar 2023 11:59:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>
Cc:     arnd@arndb.de, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kumaravel.thiagarajan@microchip.com,
        tharunkumar.pasumarthi@microchip.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v8 char-misc-next 1/5] misc: microchip: pci1xxxx: Fix
 error handling path in probe function
Message-ID: <ZCQL55ST2ed3HL5Q@kroah.com>
References: <20230328144008.4113-1-vaibhaavram.tl@microchip.com>
 <20230328144008.4113-2-vaibhaavram.tl@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328144008.4113-2-vaibhaavram.tl@microchip.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 08:10:04PM +0530, Vaibhaav Ram T.L wrote:
> From: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> 
> Removed unnecessary header files.

That's not a "fix", it is a cleanup.

> Fix error handling path in probe function.
> Add pci_free_irq_vectors and auxiliary_device_delete in 
> error handling path.

All of these should be individual patches, right?

And you have trailing whitespace here :(

> 
> Fixes: 393fc2f5948f ("misc: microchip: pci1xxxx: load auxiliary bus driver for the PIO function in the multi-function endpoint of pci1xxxx device.")

Is this really a fix of that commit?  What was wrong there, just the
error handling?

> Reported by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Co-developed-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>

No blank line there please.

> Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> Signed-off-by: Vaibhaav Ram T.L <vaibhaavram.tl@microchip.com>
> ---
>  drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c | 104 +++++++++---------
>  1 file changed, 55 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
> index 32af2b14ff34..64302fdfbefc 100644
> --- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
> +++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
> @@ -1,16 +1,15 @@
>  // SPDX-License-Identifier: GPL-2.0
> -// Copyright (C) 2022 Microchip Technology Inc.
> +// Copyright (C) 2022-2023 Microchip Technology Inc.
>  
> -#include <linux/mfd/core.h>
> +#include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> -#include <linux/spinlock.h>
> -#include <linux/gpio/driver.h>
> -#include <linux/interrupt.h>
> -#include <linux/io.h>
>  #include <linux/idr.h>
> +#include <linux/io.h>
>  #include "mchp_pci1xxxx_gp.h"
>  
> +#define PCI_DRIVER_NAME			"PCI1xxxxGP"

This is not a "fix" but rather a new change.

All of the changes in here are not related, break this up into "one
logical change per patch" please.

thanks,

greg k-h
