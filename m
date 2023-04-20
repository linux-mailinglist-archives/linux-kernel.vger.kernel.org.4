Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D696E9A61
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjDTRN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDTRN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:13:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A982D5A;
        Thu, 20 Apr 2023 10:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682010835; x=1713546835;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CpNS7XI9BQe8K3LeHWubyKhCrbeBsS/W8whIme5h4yY=;
  b=Bw6+GkNTlQqVtxJ4CuBBoMbCAxJILWyblSFtHoyPiy1S54Y6UWEBUD2R
   qoV3jEO5mPR2ONQ6HCiGkw5Nu1khxEJZTKeb+IOWaVbFCpIFMTHvux+S9
   gWc9QpXl2zpWKqXjlpEgUsTr/D32FhrYAoobJIwLY0FHtf+5o2qPnFeMs
   QCy+djvvV6GwsK8asNW/AGVXuf1Wn3S3MjWJhcNRQyu1qo/rNrF1qeCY2
   aQ6j1qQVe/wQQdSC/XNIoHiFsy3+bmEdug46l6m11eq5YcwvAV2+WW9fj
   0ifXZ+W8nlzwqAjQeH5MWD7HkPATT4GR87RWsSgbIzVqtKolasB5aysYk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="348574399"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="348574399"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 09:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="1021622651"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="1021622651"
Received: from mprabhug-mobl.amr.corp.intel.com (HELO [10.209.102.50]) ([10.209.102.50])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 09:42:46 -0700
Message-ID: <dfe88b94-215b-a86f-60b4-25d2f9ea0e5f@linux.intel.com>
Date:   Thu, 20 Apr 2023 09:18:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 3/6] ASoC: codecs: wcd938x: Check for enumeration before
 using TX device
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Patrick Lai <quic_plai@quicinc.com>
References: <20230420101617.142225-1-krzysztof.kozlowski@linaro.org>
 <20230420101617.142225-4-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230420101617.142225-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/23 05:16, Krzysztof Kozlowski wrote:
> Qualcomm WCD938x Soundwire codecs come as two Soundwire devices - TX
> and RX - on two Soundwire buses.  In DTS they are represented as three
> device nodes: Soundwire TX, Soundwire RX and the platform codec node
> (binding to this driver).
> 
> Probing (and Soundwire enumeration) of all devices can happen in any
> order, but only the Soundwire TX WCD938x device is used for accessing
> actual WCD938x registers.  It is possible that component bind() in the
> platform driver will be called too early, before the Soundwire TX device
> is fully enumerated.  This might work or might not, but we cannot handle
> it correctly from the codec driver.  It's job for Soundwire master to
> bring up devices in correct order.

That last sentence isn't aligned with the way enumeration works in
general for SoundWire.

The Manager starts the clock, usually after a bus reset, and waits for
Peripherals to signal their presence with Device0 Attached.

If multiple Peripherals are attached as Device0, the enumeration will
resolve conflicts at the hardware level, and the Manager *cannot*
control the order of enumeration; the order is defined by the values in
the devID registers, whichever Peripheral has the highest value in the
DevID registers wins the enumeration, and others have to back-off and be
enumerated later.

Probing and enumeration are also different concepts. The SoundWire
design allows for drivers to be probed even in the absence of any active
hardware. This was added on purpose so that the driver could e.g.
program a GPIO or talk to a power-management chip to allow SoundWire
devices to start interacting with the bus.

see also suggestion below...

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Patrick Lai <quic_plai@quicinc.com>
> ---
>  sound/soc/codecs/wcd938x.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
> index 212667a7249c..e8e07e120fa1 100644
> --- a/sound/soc/codecs/wcd938x.c
> +++ b/sound/soc/codecs/wcd938x.c
> @@ -77,6 +77,8 @@
>  #define WCD938X_MBHC_MOISTURE_RREF      R_24_KOHM
>  #define WCD_MBHC_HS_V_MAX           1600
>  
> +#define WCD938X_ENUM_TIMEOUT_MS		500
> +
>  #define WCD938X_EAR_PA_GAIN_TLV(xname, reg, shift, max, invert, tlv_array) \
>  {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
>  	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
> @@ -4425,6 +4427,15 @@ static int wcd938x_bind(struct device *dev)
>  	wcd938x->sdw_priv[AIF1_PB]->slave_irq = wcd938x->virq;
>  	wcd938x->sdw_priv[AIF1_CAP]->slave_irq = wcd938x->virq;
>  
> +	/*
> +	 * Before any TX slave regmap usage, be sure the TX slave is actually
> +	 * enumerated.
> +	 */

...

the alternative is to move regmap to be cache-only in the probe and
remove the cache-only property when the device is enumerated.

That's a trick that's used for all resume cases in codecs in Intel
platforms, and we need to extend it for the startup cases as well.

> +	ret = wait_for_completion_timeout(&wcd938x->tx_sdw_dev->enumeration_complete,
> +					  msecs_to_jiffies(WCD938X_ENUM_TIMEOUT_MS));
> +	if (!ret)
> +		dev_warn(dev, "Enumeration timeout in bind, possible failures in accessing registers\n");
> +
>  	ret = wcd938x_set_micbias_data(wcd938x);
>  	if (ret < 0) {
>  		dev_err(dev, "%s: bad micbias pdata\n", __func__);
