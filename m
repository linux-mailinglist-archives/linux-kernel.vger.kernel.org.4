Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFF96739B2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjASNN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjASNMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:12:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77D07EE55;
        Thu, 19 Jan 2023 05:11:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FA1161183;
        Thu, 19 Jan 2023 13:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E82C433F0;
        Thu, 19 Jan 2023 13:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674133878;
        bh=+WUd9EObafUywcojsM8LfK6pT85+s9hI7lnX4+NBJxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M46MHZtT7wkkvTNP/RmwEKPgjTWdAlsrBGjJSs/IOOqKIIQvtST3w81VWVSVVWblT
         5J2HEr+Pe1H5E3D/zpMltIZa7sSQP9Stszi0Z/8WzeaSkE7HxUTf3k32uuPL1UlkBv
         yXZloXXWXAgA7RpEZ5qUNCbD//oz+5zxxldrTwvU=
Date:   Thu, 19 Jan 2023 14:11:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] usb: acpi: Switch to use acpi_evaluate_dsm_typed()
Message-ID: <Y8lBczJAXR4Hjl93@kroah.com>
References: <20230118080419.20880-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118080419.20880-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:04:19AM +0200, Andy Shevchenko wrote:
> The acpi_evaluate_dsm_typed() provides a way to check the type of the
> object evaluated by _DSM call. Use it instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/usb/core/usb-acpi.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
> index 533baa85083c..a34b22537d7c 100644
> --- a/drivers/usb/core/usb-acpi.c
> +++ b/drivers/usb/core/usb-acpi.c
> @@ -81,15 +81,11 @@ int usb_acpi_port_lpm_incapable(struct usb_device *hdev, int index)
>  		return -ENODEV;
>  	}
>  
> -	obj = acpi_evaluate_dsm(port_handle, &guid, 0,
> -				USB_DSM_DISABLE_U1_U2_FOR_PORT, NULL);
> -
> -	if (!obj)
> -		return -ENODEV;
> -
> -	if (obj->type != ACPI_TYPE_INTEGER) {
> +	obj = acpi_evaluate_dsm_typed(port_handle, &guid, 0,
> +				      USB_DSM_DISABLE_U1_U2_FOR_PORT, NULL,
> +				      ACPI_TYPE_INTEGER);
> +	if (!obj) {
>  		dev_dbg(&hdev->dev, "evaluate port-%d _DSM failed\n", port1);
> -		ACPI_FREE(obj);
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.39.0
> 

Fails to apply to my tree :(
