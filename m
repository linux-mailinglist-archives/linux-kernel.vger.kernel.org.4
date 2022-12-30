Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4EF655A7A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 16:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiLXP37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 10:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiLXP3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 10:29:55 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id E1309E44
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 07:29:53 -0800 (PST)
Received: (qmail 176898 invoked by uid 1000); 24 Dec 2022 10:29:52 -0500
Date:   Sat, 24 Dec 2022 10:29:52 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_jackp@quicinc.com, quic_plai@quicinc.com
Subject: Re: [RFC PATCH 06/14] usb: core: hcd: Introduce USB HCD APIs for
 interrupter management
Message-ID: <Y6ca8IKLK9g497Qv@rowland.harvard.edu>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-7-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223233200.26089-7-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 03:31:52PM -0800, Wesley Cheng wrote:
> For USB HCDs that can support multiple USB interrupters, expose functions
> that class drivers can utilize for setting up secondary interrupters.
> Class drivers can pass this information to its respective clients, i.e.
> a dedicated DSP.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  drivers/usb/core/hcd.c  | 86 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/usb.h     |  7 ++++
>  include/linux/usb/hcd.h | 16 +++++++-
>  3 files changed, 108 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 8300baedafd2..90ead90faf1d 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c

> +/**
> + * usb_hcd_stop_endpoint - Halt USB EP transfers
> + * @udev: usb device
> + * @ep: usb ep to stop
> + *
> + * Stop pending transfers on a specific USB endpoint.
> + **/
> +int usb_hcd_stop_endpoint(struct usb_device *udev,
> +					struct usb_host_endpoint *ep)
> +{
> +	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
> +	int ret = 0;
> +
> +	if (hcd->driver->stop_endpoint)
> +		ret = hcd->driver->stop_endpoint(hcd, udev, ep);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(usb_hcd_stop_endpoint);

You know, there already is a function that does this.  It's named 
usb_hcd_flush_endpoint().  No need to add another function that does the 
same thing.

Alan Stern
