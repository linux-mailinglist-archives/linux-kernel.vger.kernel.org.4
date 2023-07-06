Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB48749654
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjGFHZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjGFHZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:25:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F651BD8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688628336; x=1720164336;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d/JeGf4O7nqV9K0UCQyS7h7C0MLtL6IXNPzF10Io+yo=;
  b=FZBGoNGKaE6nWyXmkCMdYjF2X9qA4MaZkkrO7/lV+gJ7phyt7e1SDZqs
   exjxcSnA1IqfzoRtAlPv06Ze7Vt7ldel1cJi1/NFWyYyjxm9btrbp+mgw
   u+XxpJcWs7sPvVPsbwkAPasAX3+wrHbjeJlVs0Jh0uOwxoYQuwBn3KLEx
   oCYfWMep4ZZ1gpGBnJKYJ70XyG7gmkWfSzmcsz/x5lGNvaUMrHJI+ENIt
   JozZRx9u7U/btJVY/fEo0lB4i/eSIxmCEZ9CmhcBkGxhTKcYFGhgzoYE2
   ONqK1mMVUstRWl2HlQh5oRyyNR9gHEJSrRTCJ8zArJgqgtQHxngiAqIxi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="363556025"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="363556025"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 00:25:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="713450911"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="713450911"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 00:25:29 -0700
Message-ID: <f464d5b1-c708-4b3f-f1d1-031c5def5b38@linux.intel.com>
Date:   Thu, 6 Jul 2023 09:25:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 7/8] ASoC: topology: suppress probe deferral errors
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Alex Elder <elder@linaro.org>
References: <20230705123018.30903-1-johan+linaro@kernel.org>
 <20230705123018.30903-8-johan+linaro@kernel.org>
 <ac232872-734f-d192-d46c-555ebe3625c5@linux.intel.com>
 <ZKZbzctgLpV-67hJ@hovoldconsulting.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <ZKZbzctgLpV-67hJ@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/2023 8:14 AM, Johan Hovold wrote:
> On Wed, Jul 05, 2023 at 05:07:22PM +0200, Amadeusz Sławiński wrote:
>> On 7/5/2023 2:30 PM, Johan Hovold wrote:
>>> Suppress probe deferral error messages when loading topologies and
>>> creating frontend links to avoid spamming the logs when a component has
>>> not yet been registered:
>>>
>>>       snd-sc8280xp sound: ASoC: adding FE link failed
>>>       snd-sc8280xp sound: ASoC: topology: could not load header: -517
>>>
>>> Note that dev_err_probe() is not used as the topology component can be
>>> probed and removed while the underlying platform device remains bound to
>>> its driver.
>>
>> I'm not sure that I understand that argument... what's wrong with
>> dev_err_probe(tplg->dev, err, "ASoC: adding FE link failed\n");
>> instead of
>> dev_err(tplg->dev, "ASoC: adding FE link failed\n");
>> ?
> 
> In short, it is not correct to use dev_err_probe() here as this is not a
> probe function.
> 
> dev_err_probe() is tied to driver core and will specifically allocate
> and associate an error message with the struct device on probe
> deferrals, which is later freed when the struct device is bound to a
> driver (or released).
> 

I guess you mean call to: device_set_deferred_probe_reason(dev, &vaf);
perhaps functionality could be extended to allow to skip this call and 
just do prints? Or just add separate dev_err_defer function without this 
step, although it would be best if they could share parts of code.

