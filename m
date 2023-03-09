Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80346B1BB7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjCIGo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjCIGoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:44:23 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108505FA7F;
        Wed,  8 Mar 2023 22:44:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A48F6CE21A4;
        Thu,  9 Mar 2023 06:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80510C433EF;
        Thu,  9 Mar 2023 06:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678344256;
        bh=Gla20dVFtwcmsJDIAEDLkVJjHhYsTxUuqXoz/zhlRZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hB45rpj6auN1lvLcMx7FccHj36FkHW2EiQNnC1Cch8WJPq6nVBtzVN407174rNmDf
         hS7AypxF0/at9zgv8L/hTLhQ1YQxgyqJ1zjO1d8cLBrD/3opMnBOnKHyz7YstkrAGS
         NRuQx2nCvslh48jhroPy7gN0+61Mu2N/rU+u3McM=
Date:   Thu, 9 Mar 2023 07:44:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com,
        andersson@kernel.org, robh+dt@kernel.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
Subject: Re: [PATCH v3 09/28] sound: usb: card: Introduce USB SND platform op
 callbacks
Message-ID: <ZAmAPX6Q1m0HU/Qo@kroah.com>
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <20230308235751.495-10-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308235751.495-10-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 03:57:32PM -0800, Wesley Cheng wrote:
> Allow for different platforms to be notified on USB SND connect/disconnect
> seqeunces.  This allows for platform USB SND modules to properly initialize
> and populate internal structures with references to the USB SND chip
> device.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  sound/usb/card.c | 36 ++++++++++++++++++++++++++++++++++++
>  sound/usb/card.h | 20 ++++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index 26268ffb8274..9bcbaa0c0a55 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -117,6 +117,30 @@ MODULE_PARM_DESC(skip_validation, "Skip unit descriptor validation (default: no)
>  static DEFINE_MUTEX(register_mutex);
>  static struct snd_usb_audio *usb_chip[SNDRV_CARDS];
>  static struct usb_driver usb_audio_driver;
> +static struct snd_usb_platform_ops *platform_ops;

As I've said before, you can not just have one of these.  They need to
be per-bus structure.  Or per-device, something dynamic, not static like
this.

> +int snd_usb_register_platform_ops(struct snd_usb_platform_ops *ops)
> +{
> +	if (platform_ops)
> +		return -EEXIST;
> +
> +	mutex_lock(&register_mutex);
> +	platform_ops = ops;
> +	mutex_unlock(&register_mutex);

Your locking is odd for a single pointer, why is it needed at all?

Also you check the pointer before using the lock, which defeats the lock
in the first place.

thanks,

greg k-h
