Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340A369E558
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbjBUQ7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjBUQ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:59:00 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C3A61A8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676998738; x=1708534738;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WTbh+QTltW9ZxDQGN6CN4UCm0JeOXBIFh/h0RJ+P5Jc=;
  b=HgNyMciIF2zx/6GbTWdBnhfR7xY3aYtj6Sar5kADmvGoWkXWU719BMDr
   vpvhRGPlDkxNA0i0J+ycqzT2LLPMMCYgFm3L1fgFESWm3/6Q6jhsfm035
   JMPxAFazVJ9TOFzZlvGzoTz/qCjQs/JWwHLPI/B3K7ZEM/XLH/fTV6Pdp
   aotYIxwbi6oduJa8eeuPze3dELbtUhThvV5ZDUWtPqCtyX+7+Ys4hQfW0
   crtDp7jXPEQueyCm9xuVCNe4JmDfrK/eqgpH0JaKZFm2pfRlKQmHAq7LL
   4kUjxjR5Nsz4B9YyTrFDg4JSjGyzs85vTPPnKgGkBPbFQCXnLmNT0Lu4+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="334884715"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="334884715"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 08:58:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="814569137"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="814569137"
Received: from taevough-mobl.amr.corp.intel.com (HELO [10.209.174.213]) ([10.209.174.213])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 08:58:45 -0800
Message-ID: <dfebabad-4777-b5e3-8f58-1301faf97f7e@linux.intel.com>
Date:   Tue, 21 Feb 2023 11:49:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 09/10] ASoC: Intel: sof_sdw: Add support for Cirrus Logic
 CS35L56
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org,
        cezary.rojewski@intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, kai.vehmanen@linux.intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20230217161410.915202-1-rf@opensource.cirrus.com>
 <20230217161410.915202-10-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230217161410.915202-10-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static int cs35l56_init_multiple(struct snd_soc_pcm_runtime *rtd, int count)
> +{
> +	struct snd_soc_card *card = rtd->card;
> +	struct snd_soc_dai *codec_dai;
> +	int i, ret;
> +
> +	card->components = devm_kasprintf(card->dev, GFP_KERNEL,
> +					  "%s hs:cs35l56",

the string is wrong here, this is an amplifier so it should be
amp:cs35l56 or spk:cs36l56 (not sure which of the two we ended-up using).

> +					  card->components);
> +	if (!card->components)
> +		return -ENOMEM;
> +
> +	ret = snd_soc_dapm_new_controls(&card->dapm,
> +					cs35l56_sof_widgets, ARRAY_SIZE(cs35l56_sof_widgets));
> +	if (ret) {
> +		dev_err(card->dev, "Widgets add failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = snd_soc_dapm_add_routes(&card->dapm, cs35l56_sof_map, count);
> +	if (ret) {
> +		dev_err(card->dev, "Map add %d failed: %d\n", count, ret);
> +		return ret;
> +	}
> +
> +	/* Enable one feedback TX per amp on different slots */
> +	for_each_rtd_codec_dais(rtd, i, codec_dai) {
> +		ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x3, 1 << i, 4, 16);

TDM slots? Not getting how this would work with SoundWire?

> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
