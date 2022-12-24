Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97620655987
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 09:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiLXI7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 03:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXI7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 03:59:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159766412;
        Sat, 24 Dec 2022 00:59:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E20EB8219D;
        Sat, 24 Dec 2022 08:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC371C433D2;
        Sat, 24 Dec 2022 08:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671872344;
        bh=OWn0iyjXQA4osiRZXNzPvFeyEY2peMtzlmChCk/B1AE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BSM+RJb0WFZjgsl6DnOps+gPMkSjyGJ3HZ9ToI6Q570dArlOPMXDs9XUkcaNVe9+y
         zunC7x6Yj1WhFxiozY8o5u2f3k5Y+PgffAnr4TF879V7fuzvHVvP2poQ/tw5V8EEAp
         iHCn5AIpnijkg4h0eWQWsn6Se1CDvO98RkZX3CXk=
Date:   Sat, 24 Dec 2022 09:59:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com, tiwai@suse.com,
        robh+dt@kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
Subject: Re: [RFC PATCH 10/14] sound: usb: card: Check for support for
 requested audio format
Message-ID: <Y6a/VWOg4mBMtUOr@kroah.com>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-11-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223233200.26089-11-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 03:31:56PM -0800, Wesley Cheng wrote:
> Allow for checks on a specific USB audio device to see if a requested PCM
> format is supported.  This is needed for support for when playback is
> initiated by the ASoC USB backend path.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  sound/usb/card.c | 19 +++++++++++++++++++
>  sound/usb/card.h |  3 +++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index 396e5a34e23b..9b8d2ed308c8 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -133,6 +133,25 @@ int snd_usb_unregister_vendor_ops(void)
>  }
>  EXPORT_SYMBOL_GPL(snd_usb_unregister_vendor_ops);
>  
> +struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
> +			struct snd_pcm_hw_params *params, int direction)
> +{
> +	struct snd_usb_stream *as;
> +	struct snd_usb_substream *subs = NULL;
> +	const struct audioformat *fmt;
> +
> +	if (usb_chip[card_idx] && enable[card_idx]) {
> +		list_for_each_entry(as, &usb_chip[card_idx]->pcm_list, list) {
> +			subs = &as->substream[direction];
> +			fmt = find_substream_format(subs, params);
> +			if (fmt)
> +				return as;
> +		}
> +	}

Where is the locking here?  How can you walk a list that can be changed
as you walk it?

And what about reference counting?  You are returning a pointer to a
structure, who now "owns" it?  What happens if it is removed from the
system after you return it?

> +	return 0;

Didn't sparse complain about this?  You can't return "0" as a pointer,
it should be NULL.

Always run basic tools like sparse on code before submitting it so that
we don't have to find errors like this.

thanks,

greg k-h
