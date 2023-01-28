Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E4F67F806
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 14:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbjA1N21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 08:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjA1N2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 08:28:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3238442ED;
        Sat, 28 Jan 2023 05:28:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D948960BF9;
        Sat, 28 Jan 2023 13:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38D9C433EF;
        Sat, 28 Jan 2023 13:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674912502;
        bh=gbVb0kAg5hpJyj539xNOunFy+rh05joLI900TjEcRZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fSLeRYssvJmeBHQiGEXXJSK1YvT9JuojmLmMCIAGjbqnWXt62447VxdkmVtMrlbyC
         pln3GTfSA4rybbKVaD1iFxIH7MJP6AWuCG0EfX13nCvZKlaTOWGY1d/ozFi510duVK
         jHzl1CQzPu1lQxZgElaWHbIaNlpXQoXf9JcOnmFY=
Date:   Sat, 28 Jan 2023 14:28:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, lgirdwood@gmail.com, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Thinh.Nguyen@synopsys.com,
        broonie@kernel.org, bgoswami@quicinc.com, tiwai@suse.com,
        robh+dt@kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
Subject: Re: [RFC PATCH v2 12/22] sound: usb: card: Introduce USB SND
 platform op callbacks
Message-ID: <Y9Ui82OaI54Qx8Ft@kroah.com>
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
 <20230126031424.14582-13-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126031424.14582-13-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 07:14:14PM -0800, Wesley Cheng wrote:
> Allow for different platforms to be notified on USB SND connect/disconnect
> seqeunces.  This allows for platform USB SND modules to properly initialize
> and populate internal structures with references to the USB SND chip
> device.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  sound/usb/card.c | 28 ++++++++++++++++++++++++++++
>  sound/usb/card.h | 20 ++++++++++++++++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index 26268ffb8274..803230343c16 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -117,6 +117,24 @@ MODULE_PARM_DESC(skip_validation, "Skip unit descriptor validation (default: no)
>  static DEFINE_MUTEX(register_mutex);
>  static struct snd_usb_audio *usb_chip[SNDRV_CARDS];
>  static struct usb_driver usb_audio_driver;
> +static struct snd_usb_platform_ops *platform_ops;

You can not have a single "platform_ops" pointer, this HAS to be
per-bus.

And what is a "platform operations" anyway?  Shouldn't this be a driver
type or something like that?  "offload_operations"?

> +
> +int snd_usb_register_platform_ops(struct snd_usb_platform_ops *ops)
> +{
> +	if (platform_ops)
> +		return -EEXIST;
> +
> +	platform_ops = ops;
> +	return 0;

No locking?  not good.

But again, this has to be per-USB-bus, it can NOT be system wide for
obvious reasons.

thanks,

greg k-h
