Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0113569E6C8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjBUSEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjBUSEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:04:50 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7974A2F783
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677002688; x=1708538688;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ihZKaLNGSWG3qNYgbisyi+AvTv2NlMGpvPTE2WUE7c0=;
  b=TQcTg/a07lC+b0DZXNVyH/XEAwCkZg9QfGSiHxrks+hsYpaZ2VZHhoZh
   /fmElOlGfM21NCoGLfdpeibMVecTR+JDEbzbaHEg9/Nk+mL4KajNe5Y4C
   K8o8khKke2FuuEXYekkkQMvKuq3YFdT2YU7DjHIhfRpNRfx0aXsFMvPQP
   DH53Mrt5d4CNDp6UPHvl442Qs45gPFbALTJA9IXZEdB9nl5U5llLf5fYT
   EdRmmn8agbtiitOrmGNuoYM1dl3Jqy9SfQJFkdPd/9j2r57LV7xskOmAo
   9HZ+AU3xMwyJm2WxZnHRx+evwUdgXbVly86CucTK1OPoTfTuvVEAQlBM/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="397398176"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="397398176"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 10:04:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="740501480"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="740501480"
Received: from taevough-mobl.amr.corp.intel.com (HELO [10.209.174.213]) ([10.209.174.213])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 10:04:16 -0800
Message-ID: <273e1484-0285-29b6-4852-9f5bc2d24e2a@linux.intel.com>
Date:   Tue, 21 Feb 2023 13:03:12 -0500
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
 <dfebabad-4777-b5e3-8f58-1301faf97f7e@linux.intel.com>
 <f3d70939-49e5-1da2-c104-11b370888d7c@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <f3d70939-49e5-1da2-c104-11b370888d7c@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +                      card->components);
>>> +    if (!card->components)
>>> +        return -ENOMEM;
>>> +
>>> +    ret = snd_soc_dapm_new_controls(&card->dapm,
>>> +                    cs35l56_sof_widgets,
>>> ARRAY_SIZE(cs35l56_sof_widgets));
>>> +    if (ret) {
>>> +        dev_err(card->dev, "Widgets add failed: %d\n", ret);
>>> +        return ret;
>>> +    }
>>> +
>>> +    ret = snd_soc_dapm_add_routes(&card->dapm, cs35l56_sof_map, count);
>>> +    if (ret) {
>>> +        dev_err(card->dev, "Map add %d failed: %d\n", count, ret);
>>> +        return ret;
>>> +    }
>>> +
>>> +    /* Enable one feedback TX per amp on different slots */
>>> +    for_each_rtd_codec_dais(rtd, i, codec_dai) {
>>> +        ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x3, 1 << i, 4, 16);
>>
>> TDM slots? Not getting how this would work with SoundWire?
>>
> 
> Strictly speaking Soundwire is TDM (the frame time is divided up into
> slots for each sample...).
> 
> The problem is if you have N amps on the dailink all feeding back audio
> on the same bus. Their DP slots are all programmed to the same positions
> in the frame, same as for the playback. So you have 4 amps all trying to
> send 6 audio channels in the same positions in the frame and you'll just
> get a ton of bus clash interrupts.
> 
> So we use the set_tdm_slot() like we do with I2S TDM to set which slots
> are active for each amp.
> 
> I can't see that there's any obvious "generic" way that the manager code
> can automatically figure out how many channels to enable on each amp and
> what order to map them, so we do it here. Just as with I2S TDM - you
> have many slots and many codecs but the machine driver has to tell it
> how to map those.

IIRC Bard did the same thing recently, and the order of the feedback
channels is really defined by the order in which the peripheral devices
are added in the dailink. See
https://github.com/thesofproject/linux/pull/4108

There's also another open related to the number of channels, we need to
patch what the CPU DAI can handle, see
https://github.com/thesofproject/linux/pull/4136 or
https://github.com/thesofproject/linux/pull/4134
