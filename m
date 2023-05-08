Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD5E6FAFB5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbjEHMOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjEHMOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:14:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E502037C4C;
        Mon,  8 May 2023 05:14:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A4C8615DB;
        Mon,  8 May 2023 12:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6775DC433D2;
        Mon,  8 May 2023 12:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683548061;
        bh=s0zYPiwZHS3OcIOtGvMLCWYR3x28j1/vGt0bpuO02PQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SuLyFmnRPQ8HSTYXu5AEsp6Wn/XI0ma1kVo03Q2oUu5rViW7vpjzFgMROC6KfpkWx
         xpmMeiH6AoSvPF9m3iMbvxaIBcIRZdluEruwSt7zYdONg8UeKo2FMGPIZD99W+CDWT
         StIYIPqp9Q+Z4iFKaEG4J8lxlI7rNvBx8N2paQl0=
Date:   Mon, 8 May 2023 14:14:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     AKASH KUMAR <quic_akakum@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jing Leng <jleng@ambarella.com>,
        Pratham =?iso-8859-1?Q?Pratap=A0?= <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_uac2: uevent changes for uac2
Message-ID: <2023050801-handshake-refusing-0367@gregkh>
References: <20230508120535.31472-1-quic_akakum@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508120535.31472-1-quic_akakum@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 05:35:35PM +0530, AKASH KUMAR wrote:
> Adding uvent from usb audio gadget driver for

What is a "uvent"?

> uac2 playback/capture events, which userspace reads
> and later reads sysfs entry to know if playback
> or capture has stopped or started by host
> application.

Please use your full 72 columns please.

> 
> /config/usb_gadget/g1/functions/uac2.0 # cat c_status
> 1  --> capture started
> 0  --> capture stopped
> /config/usb_gadget/g1/functions/uac2.0 # cat p_status
> 1 --> playback started
> 0 --> playback stopped

You need to document these new files in Documentation/ABI/ right?

> 
> Signed-off-by: AKASH KUMAR <quic_akakum@quicinc.com>

No need to UPPER CASE your name :)

> ---
>  drivers/usb/gadget/function/f_uac2.c | 57 ++++++++++++++++++++++++++++
>  drivers/usb/gadget/function/u_uac2.h |  7 ++++
>  2 files changed, 64 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
> index 0219cd79493a..d0a5fa6b49b8 100644
> --- a/drivers/usb/gadget/function/f_uac2.c
> +++ b/drivers/usb/gadget/function/f_uac2.c
> @@ -1423,6 +1423,8 @@ afunc_set_alt(struct usb_function *fn, unsigned intf, unsigned alt)
>  	struct usb_gadget *gadget = cdev->gadget;
>  	struct device *dev = &gadget->dev;
>  	int ret = 0;
> +	struct f_uac2_opts *audio_opts =
> +		container_of(fn->fi, struct f_uac2_opts, func_inst);
>  
>  	/* No i/f has more than 2 alt settings */
>  	if (alt > 1) {
> @@ -1454,6 +1456,7 @@ afunc_set_alt(struct usb_function *fn, unsigned intf, unsigned alt)
>  			ret = u_audio_start_capture(&uac2->g_audio);
>  		else
>  			u_audio_stop_capture(&uac2->g_audio);
> +		audio_opts->c_status = alt;
>  	} else if (intf == uac2->as_in_intf) {
>  		uac2->as_in_alt = alt;
>  
> @@ -1461,10 +1464,14 @@ afunc_set_alt(struct usb_function *fn, unsigned intf, unsigned alt)
>  			ret = u_audio_start_playback(&uac2->g_audio);
>  		else
>  			u_audio_stop_playback(&uac2->g_audio);
> +		audio_opts->p_status = alt;
>  	} else {
>  		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
>  		return -EINVAL;
>  	}
> +#ifdef CONFIG_USB_CONFIGFS_UEVENT
> +	schedule_work(&audio_opts->work);
> +#endif

Why the #ifdef?  Please never do that in .c files if at all possible.

>  
>  	return ret;
>  }
> @@ -1493,9 +1500,17 @@ static void
>  afunc_disable(struct usb_function *fn)
>  {
>  	struct f_uac2 *uac2 = func_to_uac2(fn);
> +	struct f_uac2_opts *audio_opts =
> +		container_of(fn->fi, struct f_uac2_opts, func_inst);
>  
>  	uac2->as_in_alt = 0;
>  	uac2->as_out_alt = 0;
> +	audio_opts->p_status = 0;//alt;
> +	audio_opts->c_status = 0; //alt;
> +
> +#ifdef CONFIG_USB_CONFIGFS_UEVENT
> +	schedule_work(&audio_opts->work);
> +#endif

Same here and elsewhere in this patch.

thanks,

greg k-h
