Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58466C7007
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjCWSLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWSLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:11:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A5AA270
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 11:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679595073; x=1711131073;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rUn3oqJLeZ+PcZAIu66R71ASeFhwezXaOFWYnk+LTbQ=;
  b=f68jjA8wOk+7OJiYpzO32CmnDy55jT//pz/LnE/WWpnmzVyaCJ+6BEIx
   oLQwmXSRgR76tLHDkioD6RvEjik+o0cWOSRAXlShvTOaJdiFBwvMnflhR
   Qf5ikxxHLFoMqDm0bOlRGNg7FO62l/LO6I4CH0R0t0O9YUt9qCoptygAr
   9EHF2wiWEDb06Iaq3yq5SiF8feACfF/42kqyVKr2nJsdZ7mcSWPpG6kMc
   gfN/1i5Mu+cqYv3TRblxtPo/sz76zOsTnVhXwL0K5eiq3QxabcXi/lGdI
   TKSWQI2rpmCr7aBY0XoCjb6M3hY1tGIzvzjrpadPhQALM1rvSC5bzVt75
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="319239497"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="319239497"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 11:11:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="682390296"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="682390296"
Received: from dsamoylo-mobl.amr.corp.intel.com (HELO [10.209.65.26]) ([10.209.65.26])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 11:11:12 -0700
Message-ID: <5dc11c47-bae6-2f4e-4ffd-58c4f462fd68@linux.intel.com>
Date:   Thu, 23 Mar 2023 13:11:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH 3/4] ASoC: codecs: wsa883x: mute/unmute PA in correct
 sequence
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, johan+linaro@kernel.org,
        steev@kali.org, dmitry.baryshkov@linaro.org
References: <20230323164403.6654-1-srinivas.kandagatla@linaro.org>
 <20230323164403.6654-4-srinivas.kandagatla@linaro.org>
 <ff3eb88a-6941-4303-a4ba-17cad3842b88@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <ff3eb88a-6941-4303-a4ba-17cad3842b88@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +static int wsa883x_trigger(struct snd_pcm_substream *s, int cmd,
>> +			   struct snd_soc_dai *dai)
>> +{
>> +	switch (cmd) {
>> +	case SNDRV_PCM_TRIGGER_START:
>> +	case SNDRV_PCM_TRIGGER_RESUME:
>> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>> +		wsa883x_digital_mute(dai, false, 0);
>> +		break;
> 
>>  static const struct snd_soc_dai_ops wsa883x_dai_ops = {
>> +	.startup = wsa883x_startup,
>>  	.hw_params = wsa883x_hw_params,
>>  	.hw_free = wsa883x_hw_free,
>> -	.mute_stream = wsa883x_digital_mute,
>> +	.trigger = wsa883x_trigger,
> 
> The trigger is run in atomic context, can you really write safely to a
> SoundWire device there?

Mark, I've seen that comment from you several times, and I wonder if I
am missing something: the triggers for SoundWire managers and dailinks
are typically nonatomic - at least for the Cadence-based solution the
trigger is based on a bank switch that may happen with a delay and with
a wait_for_completion(). Sending a command over the SoundWire channel is
also typically not atomic, there's usually a wait_for_completion() as well.
