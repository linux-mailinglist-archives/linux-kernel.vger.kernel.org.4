Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF55A68CF31
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 06:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjBGF4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 00:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBGF41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 00:56:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA7613D5C;
        Mon,  6 Feb 2023 21:56:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 140F4B816C6;
        Tue,  7 Feb 2023 05:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D254C433EF;
        Tue,  7 Feb 2023 05:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675749383;
        bh=8o4vzFjzdFOLEYSSzryg6DYepJ6g64Y08XDskPcpOcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BH+uHW9EfqVTI1QQXVdAPbGO3TrQ+4q78RqN7GB9t3DfvkyBod++XAtJIuddwtbsj
         Md8VqlE/Ap+Ndeq7b0oxYLRSjoOuQiIbZscSIF7VBhJrQ30EdURlR2z2z+rNthE0cx
         8L7ZrL3Y1sYxJncavxE5//00mycVV/g1WWd01vws=
Date:   Tue, 7 Feb 2023 06:56:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
Cc:     Thinh.Nguyen@synopsys.com, balbi@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com
Subject: Re: [PATCH v3 3/5] usb: gadget: Add function wakeup support
Message-ID: <Y+HoBPM6a64erF3z@kroah.com>
References: <1675710806-9735-1-git-send-email-quic_eserrao@quicinc.com>
 <1675710806-9735-4-git-send-email-quic_eserrao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675710806-9735-4-git-send-email-quic_eserrao@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 11:13:24AM -0800, Elson Roy Serrao wrote:
> A function which is in function suspend state has to send a
> function wake notification to the host in case it needs to
> exit from this state and resume data transfer. Add support to
> handle such requests by exposing a new gadget op.
> 
> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
> ---
>  drivers/usb/gadget/composite.c | 26 ++++++++++++++++++++++++++
>  drivers/usb/gadget/udc/core.c  | 19 +++++++++++++++++++
>  include/linux/usb/composite.h  |  6 ++++++
>  include/linux/usb/gadget.h     |  4 ++++
>  4 files changed, 55 insertions(+)
> 
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> index e459fb0..aa243d8 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -492,6 +492,32 @@ int usb_interface_id(struct usb_configuration *config,
>  }
>  EXPORT_SYMBOL_GPL(usb_interface_id);
>  
> +int usb_func_wakeup(struct usb_function *func)
> +{
> +	int ret, id;
> +
> +	if (!func->func_rw_armed) {
> +		ERROR(func->config->cdev, "func remote wakeup not enabled\n");
> +		return -EINVAL;
> +	}
> +
> +	DBG(func->config->cdev, "%s function wakeup\n", func->name);
> +
> +	for (id = 0; id < MAX_CONFIG_INTERFACES; id++)
> +		if (func->config->interface[id] == func)
> +			break;
> +
> +	if (id == MAX_CONFIG_INTERFACES) {
> +		ERROR(func->config->cdev, "Invalid function id:%d\n", id);
> +		return -EINVAL;
> +	}
> +
> +	ret = usb_gadget_func_wakeup(func->config->cdev->gadget, id);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(usb_func_wakeup);

EXPORT_SYMBOL_GPL() please.

thanks,

greg k-h
