Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAAA6781A3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbjAWQij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbjAWQif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:38:35 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5AC193FF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674491914; x=1706027914;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DydKb/Cc6DkRtiifXYwNuoYwd4pFiGSEMa44FhZi+Gg=;
  b=VCobGnrcWllo8KVgiEqSr8cq2Wk2Q5563e6VKrWtDI4MOb7mc5k08vS9
   gpzzabYJ/1oOXpwD6vj2WS9/yC43J/fvgPTuP9wT1yT6QWvWSjRL1/4Mq
   V+5ph3Jb2rADN9mnThLVi8C2GVQEVLG+NpZ+dPZ5TJQTF/AmjPrvL5clz
   JmzITK9Abo2oNbKw9U80GBuW7MkI2rRa90Jg4lyfxKHDK6H+TcoGP5hsi
   o+sBWn2zqZcdFMbMQhM01DTWjbuHyAHa1m5qYeHxbxq7l6jIOug/t1hOV
   fmxf6YOrD2U5uu4d/CtPXU8Vsm55srJYNMceRTDRxf9K1h5kd7QlHvyHK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="388435236"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="388435236"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 08:38:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="730338815"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="730338815"
Received: from rgrachek-mobl.amr.corp.intel.com (HELO [10.212.113.123]) ([10.212.113.123])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 08:38:33 -0800
Message-ID: <638af695-3874-7c1f-830a-09cf353f45fb@linux.intel.com>
Date:   Mon, 23 Jan 2023 10:38:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] soundwire: bus: Allow SoundWire peripherals to
 register IRQ handlers
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com
References: <20230119165104.3433290-1-ckeepax@opensource.cirrus.com>
 <20230119165104.3433290-2-ckeepax@opensource.cirrus.com>
 <c05a6791-96a7-2b10-d353-eb7b316aefc8@linux.intel.com>
 <20230120095941.GL36097@ediswmail.ad.cirrus.com>
 <881088ad-95d7-2462-20d2-72a6a9d3ba68@linux.intel.com>
 <20230123145353.GX36097@ediswmail.ad.cirrus.com>
 <034245f8-50b7-e801-7961-58c77dbc00b1@linux.intel.com>
 <05a00da2-2ff8-b234-3959-b451849b8cdb@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <05a00da2-2ff8-b234-3959-b451849b8cdb@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/23 10:08, Richard Fitzgerald wrote:
> On 23/01/2023 15:50, Pierre-Louis Bossart wrote:
>>
>>
>> On 1/23/23 08:53, Charles Keepax wrote:
>>> On Fri, Jan 20, 2023 at 10:20:50AM -0600, Pierre-Louis Bossart wrote:
>>>> On 1/20/23 03:59, Charles Keepax wrote:
>>>>> On Thu, Jan 19, 2023 at 11:12:04AM -0600, Pierre-Louis Bossart wrote:
>>>>>> There should be an explanation and something checking that both
>>>>>> are not
>>>>>> used concurrently.
>>>>>
>>>>> I will try to expand the explanation a litte, but I dont see any
>>>>> reason to block calling both handlers, no ill effects would come
>>>>> for a driver having both and it is useful if any soundwire
>>>>> specific steps are needed that arn't on other control buses.
>>>>
>>>> I think it's problematic if the peripheral tries to wake-up the manager
>>>> from clock-stop with both an in-band wake (i.e. drive the data line
>>>> high) and a separate GPIO-based interrupt. It's asking for trouble
>>>> IMHO.
>>>> We spent hours in the MIPI team to make sure there were no races
>>>> between
>>>> the manager-initiated restarts and peripheral-initiated restarts,
>>>> adding
>>>> a 3rd mechanism in the mix gives me a migraine already.
>>>
>>> Apologies but I am struggling see why this has any bearing on
>>> the case of a device that does both an in-band and out-of-band
>>> wake. The code we are adding in this patch will only be called in the
>>> in-band case. handle_nested_irq doesn't do any hardware magic or
>>> schedule any threads, it just calls a function that was provided
>>> when the client called request_threaded_irq. The only guarantee
>>> of atomicity you have on the interrupt_callback is sdw_dev_lock
>>> and that is being held across both calls after the patch.
>>>
>>> Could you be a little more specific on what you mean by this
>>> represents a 3rd mechanism, to me this isn't a new mechanism just
>>> an extra callback? Say for example this patch added an
>>> interrupt_callback_early to sdw_slave_ops that is called just
>>> before interrupt_callback.
>>
>> Well, the main concern is exiting the clock-stop. That is handled by the
>> manager and could be done
>> a) as the result of the framework deciding that something needs to be
>> done (typically as a result of user/applications starting a stream)
>> b) by the device with an in-band wake in case of e.g. jack detection or
>> acoustic events detected
>> c) same as b) but with a separate out-of-band interrupt.
>>
>> I'd like to make sure b) and c) are mutually-exclusive options, and that
>> the device will not throw BOTH an in-band wake and an external interrupt.
> 
> Why would it be a problem if the device did (b) and (c)?
> (c) is completely invisible to the SoundWire core and not something
> that it has to handle. The handler for an out-of-band interrupt must
> call pm_runtime_get_sync() or pm_runtime_resume_and_get() and that
> would wake its own driver and the host controller.

The Intel hardware has a power optimization for the clock-stop, which
leads to different paths to wake the system. The SoundWire IP can deal
with the data line staying high, but in the optimized mode the wakes are
signaled as DSP interrupts at a higher level. That's why we added this
intel_link_process_wakeen_event() function called from
hda_dsp_interrupt_thread().

So yes on paper everything would work nicely, but that's asking for
trouble with races left and right. In other words, unless you have a
very good reason for using two wake-up mechanisms, pick a single one.

(a) and (c) are very similar in that all the exit is handled by
pm_runtime so I am not worried too much. I do worry about paths that
were never tested and never planned for.
