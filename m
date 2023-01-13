Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4523066A13F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjAMR4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjAMRzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:55:47 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0E9DFEF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673632099; x=1705168099;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vXZYegqr0r8VoEKtaFQ41Pd2O25X43DEDShZ7ZuY//c=;
  b=n/0gFD/auYBas5LEA3kIcy5UthY4Sja8unq/nx8HK7iRq5E+p0Ot+9xO
   Zj+0dSD/bsNxyEvXBsT00RkjRINi3Mp7bXSY+A31NPMiz2V8vaWrQjlJw
   D1jCnVUw17ZTQTm1hTFRv/AHHmIUoN4OyT1/d6UctKUZm9+Lh562rMoZJ
   Nv0CDWhZBalvXX+bbxUcw20Bq/vSd/AqUz0nXh+VIkBpMMWCyyQ9TDRtN
   wBH/855ltG+hiOeFTmNpq16WxHu/clnYQl5hrclCa4t4QfE2m0J4Jiu5f
   bf7VWmg5qyKknBCCzX94TlzBlCG7of3N73sr25BVh1lF/GMu5Z1jLnkaY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="326111268"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="326111268"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 09:48:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="635854356"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="635854356"
Received: from rerayess-mobl.amr.corp.intel.com (HELO [10.212.13.223]) ([10.212.13.223])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 09:48:12 -0800
Message-ID: <202c4f36-77b0-44a2-a77d-b989040dafc6@linux.intel.com>
Date:   Fri, 13 Jan 2023 11:48:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 1/5] soundwire: stream: uniquify dev_err() logs
Content-Language: en-US
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, bard.liao@intel.com,
        linux-kernel@vger.kernel.org
References: <20230113093532.3872113-1-yung-chuan.liao@linux.intel.com>
 <20230113093532.3872113-2-yung-chuan.liao@linux.intel.com>
 <d2c6f43a-e166-a201-4662-ba726347f2da@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <d2c6f43a-e166-a201-4662-ba726347f2da@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/23 04:22, Amadeusz Sławiński wrote:
> On 1/13/2023 10:35 AM, Bard Liao wrote:
>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>> There are a couple of duplicate logs which makes harder than needed to
>> follow the error flows. Add __func__ or make the log unique.
>>
>> Signed-off-by: Pierre-Louis Bossart
>> <pierre-louis.bossart@linux.intel.com>
>> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
>> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>> ---
>>   drivers/soundwire/stream.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
>> index df3b36670df4..e0eae0b98267 100644
>> --- a/drivers/soundwire/stream.c
>> +++ b/drivers/soundwire/stream.c
>> @@ -1389,7 +1389,7 @@ static int _sdw_prepare_stream(struct
>> sdw_stream_runtime *stream,
>>         ret = do_bank_switch(stream);
>>       if (ret < 0) {
>> -        dev_err(bus->dev, "Bank switch failed: %d\n", ret);
>> +        dev_err(bus->dev, "do_bank_switch failed: %d\n", ret);
>>           goto restore_params;
>>       }
> 
> This one seems bit unrelated to the change and makes error message
> inconsistent with:
> https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git/tree/drivers/soundwire/stream.c?h=next&id=545c365185a47672b1d5cc13c84057a1e874993c#n1498
> and
> https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git/tree/drivers/soundwire/stream.c?h=next&id=545c365185a47672b1d5cc13c84057a1e874993c#n1575
> which actually brings me to another suggestion, can this error message
> perhaps be just moved into do_bank_switch() function itself, instead of
> being duplicated multiple times or alternatively just also prefix all of
> them with function name?

well, as you correctly pointed out, there are multiple users of
'do_bank_switch' so we don't want to put the message in the function itself.

We could indeed use __func__ instead, that'd be fine.

Looking at the code, there are also inconsistencies with the use of
pr_err and dev_err. dev_err(bus->dev is wrong actually, this would use
the bus variable assigned in the previous loop, this makes no sense for
multi-segment topologies.

Let's drop this patch and revisit all this, hope Vinod can deal with
patch 1..4 otherwise we'll resend the set.

Thanks Amadeusz for the feedback.
