Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55806B1B78
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjCIG31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCIG3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:29:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A4784F46;
        Wed,  8 Mar 2023 22:29:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CF7C616B3;
        Thu,  9 Mar 2023 06:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BA9C433D2;
        Thu,  9 Mar 2023 06:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678343361;
        bh=Tcpfab2JI0O5gEZfjlyY40W1mTdC6WtNopP6Eni/ckg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v5FVmknkEuFfLZlBtpznXxjLEvesG63Cy7ilBoLMdtslhz32tEIiZraNRsf5/hJHr
         eAVk1U3GmJcAeFnQvKZHOQEzjch6XzBIYPgh1TSOyl/10hkKRGnmFCLG3LU5ibyOfq
         tNracjlV8quqiZc6FuZtWE8k7D+QvTOSksSJWTfU=
Date:   Thu, 9 Mar 2023 07:29:18 +0100
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
Subject: Re: [PATCH v3 10/28] sound: usb: Export USB SND APIs for modules
Message-ID: <ZAl8vtmoISvQYLJd@kroah.com>
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <20230308235751.495-11-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308235751.495-11-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 03:57:33PM -0800, Wesley Cheng wrote:
> -static const struct audioformat *
> +const struct audioformat *
>  find_format(struct list_head *fmt_list_head, snd_pcm_format_t format,
>  	    unsigned int rate, unsigned int channels, bool strict_match,
>  	    struct snd_usb_substream *subs)
> @@ -147,8 +147,9 @@ find_format(struct list_head *fmt_list_head, snd_pcm_format_t format,
>  	}
>  	return found;
>  }
> +EXPORT_SYMBOL_GPL(find_format);

This is a horrible name for the global symbol namespace, right?
It needs a "snd_" prefix at the very least, maybe even more.

>  
> -static const struct audioformat *
> +const struct audioformat *
>  find_substream_format(struct snd_usb_substream *subs,
>  		      const struct snd_pcm_hw_params *params)
>  {
> @@ -156,6 +157,7 @@ find_substream_format(struct snd_usb_substream *subs,
>  			   params_rate(params), params_channels(params),
>  			   true, subs);
>  }
> +EXPORT_SYMBOL_GPL(find_substream_format);

Same here.

>  
>  bool snd_usb_pcm_has_fixed_rate(struct snd_usb_substream *subs)
>  {
> @@ -446,7 +448,7 @@ int snd_usb_pcm_resume(struct snd_usb_stream *as)
>  	return 0;
>  }
>  
> -static void close_endpoints(struct snd_usb_audio *chip,
> +void close_endpoints(struct snd_usb_audio *chip,
>  			    struct snd_usb_substream *subs)
>  {
>  	if (subs->data_endpoint) {
> @@ -460,6 +462,7 @@ static void close_endpoints(struct snd_usb_audio *chip,
>  		subs->sync_endpoint = NULL;
>  	}
>  }
> +EXPORT_SYMBOL(close_endpoints);

Same here.

thanks,

greg k-h
