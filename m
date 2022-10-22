Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19638608CDB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJVLlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiJVLlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:41:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3664719C02;
        Sat, 22 Oct 2022 04:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64B6A60D29;
        Sat, 22 Oct 2022 11:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AE1C433C1;
        Sat, 22 Oct 2022 11:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666438465;
        bh=R2v7i0oPbHVVUSYJVj60rX725giKFYlsHnVzGNP3Pg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T7PWampF/olIPlKk02yh34ebg9Dj8+58S8jXVjVXDn8qkq5dU10TROD/fU8rxfY11
         z2W6zgEQf4CdfmAkHcVl410rD1SD9tcWq9b0/OshEWLrAA5kTURXpqwbG/aYmCWitT
         wpmhROPoyA5EndggplDvk/DYtzGcE4lVU60UR6nw=
Date:   Sat, 22 Oct 2022 13:34:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Vacura <w36195@motorola.com>
Cc:     linux-usb@vger.kernel.org,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jeff Vanhoof <qjv001@motorola.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Paul Elder <paul.elder@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 6/6] usb: gadget: uvc: add configfs option for sg
 support
Message-ID: <Y1PVP73LmYcgj5ph@kroah.com>
References: <20221018215044.765044-1-w36195@motorola.com>
 <20221018215044.765044-7-w36195@motorola.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018215044.765044-7-w36195@motorola.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 04:50:42PM -0500, Dan Vacura wrote:
> The scatter gather support doesn't appear to work well with some UDC hw.
> Add the ability to turn off the feature depending on the controller in
> use or other platform quirks. The default is for the uvc gadget to
> support sg as long as the UDC hw supports it.
> 
> The specific failure was with the dwc3 controller, but fixes and
> improvements are pending for those failures. This capability is now
> more intended for future unexpected failures or poor sg support on a
> given platform.
> 
> Signed-off-by: Dan Vacura <w36195@motorola.com>

Again, this should be dynamic.  Can't we detect this based on the packet
size and either do sg or not?

If the UDC hardware says it is supported, it should be supported.
Otherwise we need to fix the UDC hardware or it saying it is allowed.

> --- a/Documentation/usb/gadget-testing.rst
> +++ b/Documentation/usb/gadget-testing.rst
> @@ -796,6 +796,10 @@ The uvc function provides these attributes in its function directory:
>  	function_name       name of the interface
>  	req_int_skip_div    divisor of total requests to aid in calculating
>  			    interrupt frequency, 0 indicates all interrupt
> +	sg_supported        allow for scatter gather to be used if the UDC
> +			    hw supports it, this is default on and only
> +			    intended to be temporally turned off if a given
> +			    platform doesn't work well with scatter gather

How do you know if it "doesn't work well"?

That's vague and not good and nothing we want to support for forever,
sorry.

thanks,

greg k-h
