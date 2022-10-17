Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02BE6010DF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiJQOO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiJQOOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:14:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E89B6A;
        Mon, 17 Oct 2022 07:14:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57D60B81632;
        Mon, 17 Oct 2022 14:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83438C433C1;
        Mon, 17 Oct 2022 14:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666016058;
        bh=W1OZR9rX5R0Jg1nEu7Pmdr4d7IiTgkSuQYWHCdiGUy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hnhwEAM9f2tiXubb7wbIdvhJE+QFdOduFDtkrhYFxxiGpnPe90FTBgJZzHCNcmYlZ
         HN9UcdT4yRlWZwhMhM/cz3kF9qiLURLroLyGz1s1HJ3iOTRBEQaQAmdrrvDLKS1s1d
         vHOcM7ukfF+toajrKBJSi0iWVh0B7wshUDWH8fa8=
Date:   Mon, 17 Oct 2022 16:14:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Lin <jilin@nvidia.com>
Cc:     jonathanh@nvidia.com, thierry.reding@gmail.com,
        mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] xhci: tegra: USB2 pad power controls
Message-ID: <Y01jNqAZrx0uA2xe@kroah.com>
References: <20221017122531.9923-1-jilin@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017122531.9923-1-jilin@nvidia.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 08:25:31PM +0800, Jim Lin wrote:
> Program USB2 pad PD controls during port connect/disconnect, port
> suspend/resume, and test mode, to reduce power consumption on
> disconnect or suspend.
> 
> Signed-off-by: Jim Lin <jilin@nvidia.com>
> ---
> v2: Fix issue that wrong tegra->phys[] may be accessed on tegra124
> v3: No change on copyright
> v4: Remove hcd_to_tegra_xusb() function which is used only once.
> 
>  drivers/usb/host/xhci-tegra.c | 134 +++++++++++++++++++++++++++++++++-
>  1 file changed, 133 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
> index c8af2cd2216d..a47454503d9e 100644
> --- a/drivers/usb/host/xhci-tegra.c
> +++ b/drivers/usb/host/xhci-tegra.c
> @@ -189,6 +189,13 @@ struct tegra_xusb_context_soc {
>  	} fpci;
>  };
>  
> +enum tegra_xhci_phy_type {
> +	USB3_PHY,
> +	USB2_PHY,
> +	HSIC_PHY,
> +	MAX_PHY_TYPES,
> +};
> +
>  struct tegra_xusb_soc {
>  	const char *firmware;
>  	const char * const *supply_names;
> @@ -274,9 +281,12 @@ struct tegra_xusb {
>  
>  	bool suspended;
>  	struct tegra_xusb_context context;
> +	u32 enable_utmi_pad_after_lp0_exit;
>  };
>  
>  static struct hc_driver __read_mostly tegra_xhci_hc_driver;
> +static int (*original_xhci_hub_control)(struct usb_hcd *hcd, u16 typeReq, u16 wValue, u16 wIndex,
> +	    char *buf, u16 wLength);

That does not work when you have multiple devices in the system, right?
You should not have _any_ static data in a driver.

thanks,

greg k-h
