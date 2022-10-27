Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9210C60EE26
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 04:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiJ0C5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 22:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ0C5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 22:57:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277D517587
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 19:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666839426; x=1698375426;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bf2paH8sGyUfEw1cg7Z4uilrA3dFquFMe+m0DHeulpU=;
  b=T880nBdgsITIa1afeAB+XKQ1fc64JJ3W+m2irLYksAPQHHWp0XldJGlE
   XKzpmSdCS/1+WGxXhxI0MmFLcbwVLq0ju3m1HOSWDWN7YPXiVC8eaBGoH
   7JlDPSGjNlUcsWS248Dd0jNFRtwSBk4vAdD56H0ulfUIRYHhxssIap1lf
   fqdBgBCsTlDh4ibmLNcioKWIh0zniYdK/Y7fsN75VKgWDgFuJlXsaCfAj
   T9N4qIOxZn/3p1UG+KA1WYiua3R5pjVCnFYmwdw80k1iu+1fPYTLo4uXD
   dAwlAoZlJ0orvPcEZXu/XZjjfyp0sn9fi8w8qXcOy/BaPMmG5XZ8HcvJ4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="305730005"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="305730005"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 19:57:05 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="632248942"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="632248942"
Received: from bcoan-mobl2.amr.corp.intel.com (HELO [10.209.189.197]) ([10.209.189.197])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 19:57:03 -0700
Message-ID: <bba5dc19-c0c4-2409-6cd2-c8fa91950444@linux.intel.com>
Date:   Wed, 26 Oct 2022 20:30:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] ASoC: Intel: sof_rt5682: quirk auto detection
To:     "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     "C, Balamurugan" <balamurugan.c@intel.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Chao Song <chao.song@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "Wang, Rander" <rander.wang@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        "Song, Gongjun" <gongjun.song@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        "Reddy, Muralidhar" <muralidhar.reddy@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Ajye Huang <ajye.huang@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        "Gopal, Vamshi Krishna" <vamshi.krishna.gopal@intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>
References: <20221026071409.3235144-1-brent.lu@intel.com>
 <20221026071409.3235144-3-brent.lu@intel.com>
 <6916c126-c710-330a-ffcd-50dd3cdc47d3@linux.intel.com>
 <CY5PR11MB6257D168A60B712088BC7CF797339@CY5PR11MB6257.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CY5PR11MB6257D168A60B712088BC7CF797339@CY5PR11MB6257.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/22 19:13, Lu, Brent wrote:
>>
>> This is a bit confusing: this quirk does not work for Volteer
>>
>> 	{
>> 		.callback = sof_rt5682_quirk_cb,
>> 		.matches = {
>> 			DMI_MATCH(DMI_PRODUCT_FAMILY,
>> "Google_Volteer"),
>> 			DMI_MATCH(DMI_OEM_STRING, "AUDIO-
>> MAX98373_ALC5682I_I2S_UP4"),
>> 		},
>> 		.driver_data = (void *)(SOF_RT5682_MCLK_EN |
>> 					SOF_RT5682_SSP_CODEC(0) |
>> 					SOF_SPEAKER_AMP_PRESENT |
>>
>> 	SOF_MAX98373_SPEAKER_AMP_PRESENT |
>> 					SOF_RT5682_SSP_AMP(2) |
>> 					SOF_RT5682_NUM_HDMIDEV(4)),
>> 	},
> 
> I checked Volteer reference kit, it should use SSP1 for amplifier. It seems to me 
> this quirk is for some customer variants which implements MAX98373 on SSP2.
> 
>>
>> Same for Brya and all usages of SSP_AMP(2)
>>
>>
> 
> It's a compromise that Google implements amplifiers on SSP2 on Brya so they can 
> connect SDW codec to SSP1 pins, but we asked customers to implement amplifiers 
> on SSP1 to reserve BT offload capability.

I appreciate what you are trying to suggest, and I am all for trying to
put this proliferation of quirks under control, but the autodetection
based on rules seems out-of-reach if we don't first cleanup the existing
quirks.

If "volteer" and "brya" mean different things to different people, and
reference and derivatives are not well identified, the odds of
regressions seem very high to me.

> 
>>> -	{
>>> -		.name = "adl_rt1019_rt5682s",
>>> -		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
>>> -					SOF_RT5682_SSP_CODEC(0) |
>>> -
>> 	SOF_RT5682S_HEADPHONE_CODEC_PRESENT |
>>
>> and HEADPHONE_CODEC_PRESENT is not handled either.
>>
> 
> Headphone type will be detected later in the sof_audio_probe().
> 
>>> -					SOF_SPEAKER_AMP_PRESENT |
>>> -					SOF_RT1019_SPEAKER_AMP_PRESENT
>> |
>>> -					SOF_RT5682_SSP_AMP(1) |
>>> -					SOF_RT5682_NUM_HDMIDEV(4)),
>>> -	},
>>
>> Overall I doubt that the SOC alone can tell you what the quirk is.
>>
>> Maybe it's a default to avoid repeats of the same baseline configuration, but
>> there's not much else that can be infer from an SOC definition in light of the
>> creativity of our hardware friends who routinely swap interfaces.
> 
> I'm thinking about using kernel module parameters for those boards which do not
> use default SSP port allocation. Not sure it's doable for machine driver module.

That's not a working solution IMHO, the kernel parameters should be used
by expert developers only for specific and short-term debug. It's not
possible to add a dependency on kernel parameters, that would prevent a
kernel update.
