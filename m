Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13926816C5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbjA3Qp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237032AbjA3Qpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:45:53 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F08FC17F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675097152; x=1706633152;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4VDTGYM1+byb/e3AIkz0KQQE+tIgA/0Y7EvVgLJaKbU=;
  b=ZKpHx0jUxpZWRyc01m9zeArVJvYNRCSHJ8b7uIbRqmV+iRThD5C8lqNx
   6+3WSUT4wLSsd25XbYYEGTBBz6wapgJ8zFSxcOJPVLN8ziX/HCqqkEUrr
   DAGl6ETgZhT38t0jbaqa39nsVDB7HWmRHOcStFn+n3qlZKfyuUsOn6vZT
   IK6Tnz+i8Yowh0EL+szXtUWDms/4IoXm8MIOgekbfztxw+LXHcDGfPbYB
   TkGgYcXU863sccfVm6Dahm/GlyVYK7i0ZOf3jYTGs8hTCfVnVXuwmo1NM
   HseSmMhX/k6U3TjQb++bOGrr0JFBZLgq7xfFkJkJFPLnMU4uQkBZ0M2/w
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="307260857"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="307260857"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 08:45:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="732763627"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="732763627"
Received: from inuber-mobl5.amr.corp.intel.com (HELO [10.212.58.60]) ([10.212.58.60])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 08:45:51 -0800
Message-ID: <7b61ac00-74af-5816-79bb-39eb208ab738@linux.intel.com>
Date:   Mon, 30 Jan 2023 10:39:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v3 6/8] ASoC: cs42l42: Add SoundWire support
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>
References: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
 <20230127165111.3010960-7-sbinding@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230127165111.3010960-7-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/23 10:51, Stefan Binding wrote:
> From: Richard Fitzgerald <rf@opensource.cirrus.com>
> 
> This adds support for using CS42L42 as a SoundWire device.
> 
> SoundWire-specifics are kept separate from the I2S implementation as
> much as possible, aiming to limit the risk of breaking the I2C+I2S
> support.
> 
> There are some important differences in the silicon behaviour between
> I2S and SoundWire mode that are reflected in the implementation:
> 
> - ASP (I2S) most not be used in SoundWire mode because the two interfaces
>   share pins.
> 
> - The SoundWire capture (record) port only supports 1 channel. It does
>   not have left-to-right duplication like the ASP.
> 
> - DP2 can only be prepared if the HP has powered-up. DP1 can only be
>   prepared if the ADC has powered-up. (This ordering restriction does
>   not exist for ASPs.) The SoundWire core port-prepare step is
>   triggered by the DAI-link prepare(). This happens before the
>   codec DAI prepare() or the DAPM sequence so these cannot be used
>   to enable HP/ADC. Instead the HP/ADC enable/disable are done during
>   the port_prep callback.
> 
> - The SRCs are an integral part of the audio chain but in silicon their
>   power control is linked to the ASP. There is no equivalent power link
>   to SoundWire DPs so the driver must take "manual" control of SRC power.
> 
> - The SoundWire control registers occupy the lower part of the SoundWire
>   address space so cs42l42 registers are offset by 0x8000 (non-paged) in
>   SoundWire mode.
> 
> - Register addresses are 8-bit paged in I2C mode but 16-bit unpaged in
>   SoundWire.
> 
> - Special procedures are needed on register read/writes to (a) ensure
>   that the previous internal bus transaction has completed, and
>   (b) handle delayed read results, when the read value could not be
>   returned within the SoundWire read command.
> 
> There are also some differences in driver implementation between I2S
> and SoundWire operation:
> 
> - CS42L42 I2S does not runtime_suspend, but runtime_suspend/resume support
>   has been added into the driver in SoundWire mode as the most convenient
>   way to power-up the bus manager and to handle the unattach_request
>   condition, though the CS42L42 chip does not itself suspend or resume.
> 
> - Intel SoundWire host controllers have a low-power clock-stop mode that
>   requires resetting all peripherals when resuming. This means that the
>   interrupt registers will be reset in between the interrupt being
>   generated and the interrupt being handled, and since the interrupt
>   status is debounced, these values may not be accurate immediately,
>   and may cause spurious unplug events before settling.
> 
> - As in I2S mode, the PLL is only used while audio is active because
>   of clocking quirks in the silicon. For SoundWire the cs42l42_pll_config()
>   is deferred until the DAI prepare(), to allow the cs42l42_bus_config()
>   callback to set the SCLK.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> +static int cs42l42_sdw_dai_set_sdw_stream(struct snd_soc_dai *dai, void *sdw_stream,
> +					  int direction)
> +{
> +	if (!sdw_stream)
> +		return 0;
> +
> +	if (direction == SNDRV_PCM_STREAM_PLAYBACK)
> +		dai->playback_dma_data = sdw_stream;
> +	else
> +		dai->capture_dma_data = sdw_stream;

This may need to be updated to
snd_soc_dai_dma_data_set(dai, direction, stream);

which is being introduced by Morimoto-san

To avoid dependencies this could be updated later.

