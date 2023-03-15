Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B5E6BB64B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjCOOi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjCOOiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:38:50 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4625A916
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678891121; x=1710427121;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rNfYVw1Y+3DpMigD974Ti51cxEjaa+Bxwr0aNjinN1I=;
  b=hFRY6+sUY2xOG10LQ6claBDK57GNGBs1PlD1e9KL1AKumoTniD8yU4zD
   43SaxRhsdkkzdt6C2k23Qah8XaQZwsSDjYKrlVvDE5Nogm1mQClQ63EVg
   lKaV8SHY+Ik39HZZVXzRrNztH2OtcPBKDu45v6uA98ZinLbJaG3qXCbHl
   rSPb3azN25MJ2i1IyYC+g1Lel+dVIbiZeD7Jt47Hl57JkFQB2dEAYnH8B
   lbuHgS6a2moE8k7GJhiaT9sbOkWQUZ4OZftbL/XAMjuChWWZh2TBgvU1N
   C6Ab63XMywe3zeo62YjZc9/LKiuyEXAvYHoiTnc6mkTfrMEQgGTxMiMYB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="423990089"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="423990089"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:38:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="681872352"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="681872352"
Received: from rperez12-mobl.amr.corp.intel.com (HELO [10.255.35.81]) ([10.255.35.81])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:38:41 -0700
Message-ID: <c40192e9-6207-3204-819f-abbabc320c38@linux.intel.com>
Date:   Wed, 15 Mar 2023 09:38:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH] soundwire: stream: uniquify dev_err() logs
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bard.liao@intel.com
References: <20230309054905.21507-1-yung-chuan.liao@linux.intel.com>
 <ZBGZR2ACa8AbNmvy@matsya>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <ZBGZR2ACa8AbNmvy@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/23 05:09, Vinod Koul wrote:
> On 09-03-23, 13:49, Bard Liao wrote:
>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>> There are a couple of duplicate logs which makes harder than needed to
>> follow the error flows. Add __func__ or make the log unique.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
>> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>> ---
>>  drivers/soundwire/stream.c | 18 ++++++++++--------
>>  1 file changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
>> index 2e39587ed1de..dd09855caac9 100644
>> --- a/drivers/soundwire/stream.c
>> +++ b/drivers/soundwire/stream.c
>> @@ -1389,7 +1389,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
>>  
>>  	ret = do_bank_switch(stream);
>>  	if (ret < 0) {
>> -		dev_err(bus->dev, "Bank switch failed: %d\n", ret);
>> +		pr_err("%s: do_bank_switch failed: %d\n", __func__, ret);
> 
> why make it pr_ and loose the dev name? There is a trick to emit
> function for dev_err too using dynamic debug

a stream can be cased on multiple managers/buses.

It's incorrect to use bus->dev in this case, see all other error cases
in stream.c, they all use pr_err already for the same reason. bus->dev
is only valid when dealing with a single bus, typically in loops in that
file.

That said we could have split the two changes where dev_err() is changed
as pr_err() for clarity.

