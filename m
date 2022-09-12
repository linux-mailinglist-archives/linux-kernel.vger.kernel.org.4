Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49B25B5F6B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiILRgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiILRgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:36:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7764237F9B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663004163; x=1694540163;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FcBcnGvzARlKI6nqPOAWcfgoQk755nH6VQ0v7eG9aK0=;
  b=F+y8kow1yMTq4eZRO1pVQKXUN2v3DQEtWfZ6qTf6xuP876F6Squ7VPgd
   20LtR6muDePjHpUYGGg/gxpkYi+Vqkm0wl5A4M+XIypipCxQkVBtjNUCX
   kGhIK7Ln8LQsp2wHwj5L3WALt1GDoiAMN4GHZL80PiyaQMUJt/d02w8+t
   ph3qhBf+XQLReBJEuH62I9p9A3roWCwtzI4G/ylsRdU6j0Rl2gIi3FKo6
   qGw+1jnfxOSDkwYi2g979EyCguGW3hCJgmRith6EPqVJpoa9esDYPJiwb
   ine4EyT6l9H+5y+gRSZ00Ttd95RvAlxHFINUAm3PLLBL+m/wPYL/IUipF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="296662321"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="296662321"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 10:36:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="705236481"
Received: from vtsymbal-mobl.ger.corp.intel.com (HELO [10.252.32.67]) ([10.252.32.67])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 10:35:58 -0700
Message-ID: <9055c565-8616-8480-ea49-8db1b8707b34@linux.intel.com>
Date:   Mon, 12 Sep 2022 19:12:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 5/7] soundwire: intel: Don't disable interrupt until
 children are removed
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com,
        sanyog.r.kale@intel.com, broonie@kernel.org
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20220907101402.4685-1-rf@opensource.cirrus.com>
 <20220907101402.4685-6-rf@opensource.cirrus.com>
 <c83fb25e-ef59-63e1-4223-648dab9885ea@linux.intel.com>
 <9de21235-c77d-f53f-3426-4a5927f484c9@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <9de21235-c77d-f53f-3426-4a5927f484c9@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/22 17:36, Richard Fitzgerald wrote:
> On 12/09/2022 11:53, Pierre-Louis Bossart wrote:
>>
>>
>> On 9/7/22 12:14, Richard Fitzgerald wrote:
>>> The cadence_master code needs the interrupt to complete message
>>> transfers.
>>> When the bus driver is being removed child drivers are removed, and
>>> their
>>> remove actions might need bus transactions.
>>>
>>> Use the sdw_master_ops.remove callback to disable the interrupt handling
>>> only after the child drivers have been removed.
>>>
>>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>>> ---
>>>   drivers/soundwire/intel.c | 9 ++++++++-
>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
>>> index 01be62fa6c83..d5e723a9c80b 100644
>>> --- a/drivers/soundwire/intel.c
>>> +++ b/drivers/soundwire/intel.c
>>> @@ -1255,6 +1255,13 @@ static int intel_prop_read(struct sdw_bus *bus)
>>>       return 0;
>>>   }
>>>   +static void intel_bus_remove(struct sdw_bus *bus)
>>> +{
>>> +    struct sdw_cdns *cdns = bus_to_cdns(bus);
>>> +
>>> +    sdw_cdns_enable_interrupt(cdns, false);
>>
>> don't you need to check for any on-going transactions on the bus?
>>
> 
> As all the child drivers have removed, I think the only other place that
> can generate bus transactions is the PING handler but
> sdw_cdns_enable_interrupt(false) calls cancel_work_sync() to
> cancel the cdns->work and it sets a flag so that it will not be
> re-queued.
> 
>> I wonder if there could be a corner case where there are no child
>> devices but still a device physically attached to the bus. I am not sure
>> if the 'no devices left' is a good-enough indication of no activity on
>> the bus.
>>
> 
> As above - yes there could, but sdw_cdns_enable_interrupt(false) will
> cancel the work and stop it being re-queued.

Ah yes, I forgot that part, thanks!

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

