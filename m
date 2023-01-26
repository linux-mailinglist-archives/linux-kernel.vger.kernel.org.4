Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012E367D153
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjAZQZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjAZQZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:25:21 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D9E6FD08;
        Thu, 26 Jan 2023 08:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674750276; x=1706286276;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=93H4NJ0aDtqwd3Naz7sPnC3imkr/4n5yoYxInWivNHg=;
  b=f5mEcLrLIP2KTBrKtEbg8tBuOHSMtCzN638QM8sj34z/v9PlYvsQCYgP
   HXAd0oOom+n1xtZjiZHTZ+aG3RvJvAJJGml/NwPvUN5IA2piPUdHxCk/1
   B/Lq+051+qE/zYjfPlh8tZcwTjDm3SeQM0NYxIA+CLarMlHWcLc7SbmJp
   u9B2ve6eBv/eUTwLL1RfIsa+g0qMy3W9L7UnGbCrSgPCNbbvYmnA8dQWC
   j6aOK5Lw8BxqDwHEQsk+oQkBdZRgpbwqeSb+01yoihs+JVWPrAIvLfaGL
   FgC3Cegq7LTWLWtjsT+PqLb9Q6PWCX4hDU+2JDGIiYLPG96Cm+LXNRGDf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="354154577"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="354154577"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 08:24:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="612855043"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="612855043"
Received: from nmani1-mobl2.amr.corp.intel.com (HELO [10.209.167.178]) ([10.209.167.178])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 08:24:28 -0800
Message-ID: <64b60c9a-5f9b-6377-1307-095a42d18dc3@linux.intel.com>
Date:   Thu, 26 Jan 2023 09:32:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [RFC PATCH v2 07/22] ASoC: Add SOC USB APIs for adding an USB
 backend
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, lgirdwood@gmail.com, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com, broonie@kernel.org,
        bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
        agross@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
 <20230126031424.14582-8-quic_wcheng@quicinc.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230126031424.14582-8-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/23 21:14, Wesley Cheng wrote:
> Some platforms may want to register its USB port to be handled by the ASoC
> framework.  Audio playback/capture support is also handled entirely by the
> vendor ASoC drivers.

Can you clarify what you mean by 'port'?

> +/**
> + * snd_soc_usb_add_port() - Add a USB backend port
> + * @dev: USB backend device
> + * @connection_cb: connection status callback
> + *
> + * Register a USB backend device to the SND USB SOC framework.  Memory is
> + * allocated as part of the USB backend device.
> + *
> + */
> +struct snd_soc_usb *snd_soc_usb_add_port(struct device *dev,
> +			int (*connection_cb)(struct snd_soc_usb *usb, int card_idx,
> +			int connected))
> +{
> +	struct snd_soc_usb *usb;
> +
> +	usb = devm_kzalloc(dev, sizeof(*usb), GFP_KERNEL);
> +	if (!usb)
> +		return ERR_PTR(-ENOMEM);
> +
> +	usb->connection_status_cb = connection_cb;
> +	usb->dev = dev;
> +
> +	mutex_lock(&ctx_mutex);
> +	list_add_tail(&usb->list, &usb_ctx_list);
> +	mutex_unlock(&ctx_mutex);
> +
> +	return usb;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_usb_add_port);

Can a backend have more than one ports?

Is there any relationship between port and USB endpoint, and if yes
where is this determined?

> +
> +/**
> + * snd_soc_usb_remove_port() - Remove a USB backend port
> + * @dev: USB backend device
> + *
> + * Remove a USB backend device from USB SND SOC.  Memory is freed when USB
> + * backend is removed.
> + *
> + */
> +int snd_soc_usb_remove_port(struct device *dev)
> +{
> +	struct snd_soc_usb *ctx, *tmp;
> +
> +	mutex_lock(&ctx_mutex);
> +	list_for_each_entry_safe(ctx, tmp, &usb_ctx_list, list) {
> +		if (ctx->dev == dev) {
> +			list_del(&ctx->list);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&ctx_mutex);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_usb_remove_port);

What happens if the ASoC driver probes/initialize AFTER the USB device
is plugged?

Likewise, can the ASoC driver be removed 'safely' with a fallback to
normal non-offloaded operation happening on remove?

> +
> +/**
> + * snd_soc_usb_connect() - Notification of USB device connection
> + * @usbdev: USB bus device
> + * @card_idx: USB SND card instance
> + *
> + * Notify of a new USB SND device connection.  The card_idx can be used to
> + * handle how the USB backend selects, which device to enable offloading on.
> + *
> + */
> +int snd_soc_usb_connect(struct device *usbdev, int card_idx)
> +{
> +	struct snd_soc_usb *ctx;
> +
> +	if (!usbdev)
> +		return -ENODEV;
> +
> +	ctx = snd_soc_find_usb_ctx(usbdev);
> +	if (!ctx)
> +		return -ENODEV;
> +
> +	if (ctx->connection_status_cb)
> +		ctx->connection_status_cb(ctx, card_idx, 1);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_usb_connect);
> +
> +/**
> + * snd_soc_usb_connect() - Notification of USB device connection
> + * @usbdev: USB bus device
> + *
> + * Notify of a new USB SND device disconnection to the USB backend.
> + *
> + */
> +int snd_soc_usb_disconnect(struct device *usbdev)
> +{
> +	struct snd_soc_usb *ctx;
> +
> +	if (!usbdev)
> +		return -ENODEV;
> +
> +	ctx = snd_soc_find_usb_ctx(usbdev);
> +	if (!ctx)
> +		return -ENODEV;
> +
> +	if (ctx->connection_status_cb)
> +		ctx->connection_status_cb(ctx, -1, 0);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_usb_disconnect);

Similar concern on connect/disconnect, does this assume any specific
order for the driver probe?
