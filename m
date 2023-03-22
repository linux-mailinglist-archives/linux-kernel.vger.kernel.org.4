Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF186C400D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjCVB6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCVB62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:58:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32D5126F0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 18:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679450305; x=1710986305;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3Gh9EtYgNBOUaS3nSeIeyhsENXuq+d6Y7mIFyooKfiY=;
  b=MG9wJvy8YgvF2P6i23S9x15Ao07gYDv00wetGnJaG/2fdf3thMVpfvZ9
   bdMnqoCS2/BfteHtHRvpSZQNRQsS4bMZTsLH0VvbuCcBOllrNH9BCakSi
   1BpHX/hBnOzjMfsbkOPKz67wnqWa5fC+nq6XjdGx0CNc3S/np5glDsDMx
   qNNuvS11/3DFoD6GEFM1UueVia9QlKalTMc/+TfeXEaC7vtKxalv+xwGG
   W+2fTfMCv2AKr5lQ/r7xHU1RHC0rqv1/v8wLspS0rqR/ZUjvi7CQ4wGhT
   UMrbugWmrg1rGH3Ym5PXpj4K+usvBc6+JA2tM/X3OrckUR+rAElvxeln+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="319492599"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="319492599"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 18:58:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="750867887"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="750867887"
Received: from bkerker-mobl.amr.corp.intel.com (HELO [10.212.160.104]) ([10.212.160.104])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 18:58:24 -0700
Message-ID: <cf458a5a-a0c0-ded7-1819-a85e548cb491@linux.intel.com>
Date:   Tue, 21 Mar 2023 20:58:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH 3/4] ASoC: amd: acp: Add machine driver that enables sound
 for systems with a ES8336 codec
Content-Language: en-US
To:     Marian Postevca <posteuca@mutex.one>,
        Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20230320203519.20137-1-posteuca@mutex.one>
 <20230320203519.20137-4-posteuca@mutex.one>
 <141a3320-ff65-459f-9d00-c8bed691dcfc@sirena.org.uk>
 <87lejpwxzf.fsf@mutex.one>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <87lejpwxzf.fsf@mutex.one>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




>>> +static int acp3x_es83xx_speaker_power_event(struct snd_soc_dapm_widget *w,
>>> +					    struct snd_kcontrol *kcontrol, int event)
>>> +{
>>> +	struct acp3x_es83xx_private *priv = get_mach_priv(w->dapm->card);
>>> +
>>> +	dev_dbg(priv->codec_dev, "speaker power event: %d\n", event);
>>> +	if (SND_SOC_DAPM_EVENT_ON(event))
>>> +		acp3x_es83xx_set_gpios_values(priv, 1, 0);
>>> +	else
>>> +		acp3x_es83xx_set_gpios_values(priv, 0, 1);
>>
>> Why are these two GPIOs tied together like this?
>>
> 
> These GPIOs represent the speaker and the headphone switches. When
> activating the speaker GPIO you have to deactivate the headphone GPIO
> and vice versa. The logic is taken from the discussion on the sofproject
> pull request:
> https://github.com/thesofproject/linux/pull/4112/commits/810d03e0aecdf0caf580a5179ee6873fb33485ab
> and
> https://github.com/thesofproject/linux/pull/4066

These threads didn't exactly lead to a firm conclusion on how the GPIOs
should be used, IIRC there are cases where the levels are inverted and
all kinds of issues still not clear at all even after reading the tables
from ACPI _DSM methods.

I personally gave up, and I would recommend you take these threads as
inputs rather than firm directions.
