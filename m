Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CB86D7537
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 09:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbjDEHW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 03:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjDEHWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 03:22:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58C726BA;
        Wed,  5 Apr 2023 00:22:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81A33623DC;
        Wed,  5 Apr 2023 07:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF82C433D2;
        Wed,  5 Apr 2023 07:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680679342;
        bh=DPAw5DuEIdFU/CkXqiRbYuxxbcoA718NeuTj8Rj8mlk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H0iqfYMm6zu6tPDbb9X3LbCmD6JbaLk+h+gp233MYcz9DRpgDFklnzcNhRSeYzxOz
         eziVYZCtFzH08KtpjGtdWlXKhUzSEnhsFOSgZT39gmKpbWNG+75hA9cc5c6URGxRT0
         82JkYjM6xjw7MlNLUiibcUN8O9CvxarRoyfbn4io=
Date:   Wed, 5 Apr 2023 09:22:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: host: xhci-plat: Use dev_is_pci() helper
Message-ID: <2023040503-catatonic-gazing-9830@gregkh>
References: <20230405070141.2028455-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405070141.2028455-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 04:01:41PM +0900, Nobuhiro Iwamatsu wrote:
> Use common dev_is_pci() helper for checking PCI devices.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  drivers/usb/host/xhci-plat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index b9f9625467d61e..2c95189424fa6e 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -363,7 +363,7 @@ static int xhci_generic_plat_probe(struct platform_device *pdev)
>  			is_acpi_device_node(sysdev->fwnode))
>  			break;
>  #ifdef CONFIG_PCI
> -		else if (sysdev->bus == &pci_bus_type)
> +		else if (dev_is_pci(sysdev))

With that change, you can also get rid of the #ifdef lines too, right?

thanks,

greg k-h
