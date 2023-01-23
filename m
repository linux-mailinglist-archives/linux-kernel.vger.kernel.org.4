Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EA1678074
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjAWPuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjAWPuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:50:19 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5F213D65
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674489017; x=1706025017;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q/p7R22Dwd1VnE4UdAz1vguL9rsClepsQ5XC723K8bw=;
  b=TZwgMFvttfOgpKOFNvJecRMsFvH3WZkN6er8B967l6BRQ5HXGr32Wc3R
   Wz0aNFT+05kzRBqNZt/ac2QyX+KWF8KuxZTYUy2VBBSktdCaW0XF73ebz
   8cB1nX1Eb4npYb2aEYYXtv6eF4/AGK0D27t8cqbRh4ysazu+ePea/wykJ
   sxOOTn6rwW5k5sDa4H/t/bQpBUe3zHpO08w7eqd1CTO/osLA/XTWTyovW
   pYeI+J773xa4Yvks+J3vZrPu/B/nQPMXsdh/ibwxEeLa3JcqiyZYqgegH
   QtaffJ9mzQOZV8RGe2NJW45OOj/i4ugUU6A4VPsQiGBbHwprhtq389gz8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="309647185"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="309647185"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 07:50:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="693952499"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="693952499"
Received: from rgrachek-mobl.amr.corp.intel.com (HELO [10.212.113.123]) ([10.212.113.123])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 07:50:16 -0800
Message-ID: <034245f8-50b7-e801-7961-58c77dbc00b1@linux.intel.com>
Date:   Mon, 23 Jan 2023 09:50:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] soundwire: bus: Allow SoundWire peripherals to
 register IRQ handlers
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com
References: <20230119165104.3433290-1-ckeepax@opensource.cirrus.com>
 <20230119165104.3433290-2-ckeepax@opensource.cirrus.com>
 <c05a6791-96a7-2b10-d353-eb7b316aefc8@linux.intel.com>
 <20230120095941.GL36097@ediswmail.ad.cirrus.com>
 <881088ad-95d7-2462-20d2-72a6a9d3ba68@linux.intel.com>
 <20230123145353.GX36097@ediswmail.ad.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230123145353.GX36097@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/23 08:53, Charles Keepax wrote:
> On Fri, Jan 20, 2023 at 10:20:50AM -0600, Pierre-Louis Bossart wrote:
>> On 1/20/23 03:59, Charles Keepax wrote:
>>> On Thu, Jan 19, 2023 at 11:12:04AM -0600, Pierre-Louis Bossart wrote:
>>>> There should be an explanation and something checking that both are not
>>>> used concurrently.
>>>
>>> I will try to expand the explanation a litte, but I dont see any
>>> reason to block calling both handlers, no ill effects would come
>>> for a driver having both and it is useful if any soundwire
>>> specific steps are needed that arn't on other control buses.
>>
>> I think it's problematic if the peripheral tries to wake-up the manager
>> from clock-stop with both an in-band wake (i.e. drive the data line
>> high) and a separate GPIO-based interrupt. It's asking for trouble IMHO.
>> We spent hours in the MIPI team to make sure there were no races between
>> the manager-initiated restarts and peripheral-initiated restarts, adding
>> a 3rd mechanism in the mix gives me a migraine already.
> 
> Apologies but I am struggling see why this has any bearing on
> the case of a device that does both an in-band and out-of-band
> wake. The code we are adding in this patch will only be called in the
> in-band case. handle_nested_irq doesn't do any hardware magic or
> schedule any threads, it just calls a function that was provided
> when the client called request_threaded_irq. The only guarantee
> of atomicity you have on the interrupt_callback is sdw_dev_lock
> and that is being held across both calls after the patch.
> 
> Could you be a little more specific on what you mean by this
> represents a 3rd mechanism, to me this isn't a new mechanism just
> an extra callback? Say for example this patch added an
> interrupt_callback_early to sdw_slave_ops that is called just
> before interrupt_callback.

Well, the main concern is exiting the clock-stop. That is handled by the
manager and could be done
a) as the result of the framework deciding that something needs to be
done (typically as a result of user/applications starting a stream)
b) by the device with an in-band wake in case of e.g. jack detection or
acoustic events detected
c) same as b) but with a separate out-of-band interrupt.

I'd like to make sure b) and c) are mutually-exclusive options, and that
the device will not throw BOTH an in-band wake and an external interrupt.
