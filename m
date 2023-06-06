Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1AD724809
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238647AbjFFPlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238654AbjFFPkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:40:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B048710D7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686066039; x=1717602039;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=I2633yDyTf08CYs+GWR0b+lShf5xiYi7UgFoFUgHPII=;
  b=XhYn09WS6R7vWOeQpxCvAO/WTZkUAtfuZJ7ArvPuOQ5GCnsX09ocZQ50
   IM1wTGhjiJ93kaI9n/xNxJ93YRfNms73SIrGL3a4xZmw+Q+gchv+TQ/KR
   YH3kw4FjX3BIq4EnJwQIPkBnAdUfg2nc5J/nQYrmZJ3SWunFkrT8ZWpQK
   T2S/YiNVLY5ardnVxZcVzW6iIy8Z2N5GYr+5qY/Uo4ZJhtv288sHD5VYm
   nZqenY1hs/yAViy70/251ATUxiqwmVKgn7Hy4JhSxapJ1FdakouH5pGtX
   WbCuNI/uQQzygixKiZH+OozG5ziIBFrsIKMNVkx7WYn4TGb1jQGtXAwvm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="422550300"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="422550300"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 08:39:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="955816533"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="955816533"
Received: from pdonvalk-mobl2.amr.corp.intel.com (HELO [10.255.231.168]) ([10.255.231.168])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 08:39:17 -0700
Message-ID: <7ed3e421-ad04-746a-e252-45bc83f76256@linux.intel.com>
Date:   Tue, 6 Jun 2023 10:38:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH V3 4/9] ASoC: amd: ps: add SoundWire dma driver dma ops
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, mario.limonciello@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230606060724.2038680-1-Vijendar.Mukunda@amd.com>
 <20230606060724.2038680-5-Vijendar.Mukunda@amd.com>
Content-Language: en-US
In-Reply-To: <20230606060724.2038680-5-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static int acp63_sdw_dma_start(struct snd_pcm_substream *substream, void __iomem *acp_base)
> +{
> +	struct acp_sdw_dma_stream *stream;
> +	u32 stream_id;
> +	u32 sdw_dma_en_reg;
> +	u32 sdw_dma_en_stat_reg;
> +	u32 sdw_dma_stat;
> +
> +	stream = substream->runtime->private_data;
> +	stream_id = stream->stream_id;
> +	switch (stream->instance) {
> +	case ACP_SDW0:
> +		sdw_dma_en_reg = sdw0_dma_enable_reg[stream_id];
> +		break;
> +	case ACP_SDW1:
> +		sdw_dma_en_reg = sdw1_dma_enable_reg[stream_id];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	writel(0x01, acp_base + sdw_dma_en_reg);
> +	sdw_dma_en_stat_reg = sdw_dma_en_reg + 4;
> +	return readl_poll_timeout(acp_base + sdw_dma_en_stat_reg, sdw_dma_stat,
> +				  (sdw_dma_stat & BIT(0)), ACP_DELAY_US, ACP_COUNTER);
> +}
> +
> +static int acp63_sdw_dma_stop(struct snd_pcm_substream *substream, void __iomem *acp_base)
> +{
> +	struct acp_sdw_dma_stream *stream;
> +	u32 stream_id;
> +	u32 sdw_dma_en_reg;
> +	u32 sdw_dma_en_stat_reg;
> +	u32 sdw_dma_stat;
> +
> +	stream = substream->runtime->private_data;
> +	stream_id = stream->stream_id;
> +	switch (stream->instance) {
> +	case ACP_SDW0:
> +		sdw_dma_en_reg = sdw0_dma_enable_reg[stream_id];
> +		break;
> +	case ACP_SDW1:
> +		sdw_dma_en_reg = sdw1_dma_enable_reg[stream_id];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	writel(0, acp_base + sdw_dma_en_reg);
> +	sdw_dma_en_stat_reg = sdw_dma_en_reg + 4;
> +	return readl_poll_timeout(acp_base + sdw_dma_en_stat_reg, sdw_dma_stat, !sdw_dma_stat,
> +				  ACP_DELAY_US, ACP_COUNTER);
> +}

these start/stop routines look mostly the same, except for the value to
be written in the register. Maybe they can be factored with a common
helper, e.g. acp63_sdw_dma_enable(true/false).
> +
> +static int acp63_sdw_dma_trigger(struct snd_soc_component *comp,
> +				 struct snd_pcm_substream *substream,
> +				 int cmd)
> +{
> +	struct sdw_dma_dev_data *sdw_data;
> +	int ret;
> +
> +	sdw_data = dev_get_drvdata(comp->dev);
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +		ret = acp63_sdw_dma_start(substream, sdw_data->acp_base);
> +		break;
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_STOP:
> +		ret = acp63_sdw_dma_stop(substream, sdw_data->acp_base);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +	if (ret)
> +		dev_err(comp->dev, "trigger %d failed: %d", cmd, ret);
> +	return ret;
> +}
