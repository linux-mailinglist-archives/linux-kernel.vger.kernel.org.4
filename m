Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4176BEB82
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCQOke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCQOkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:40:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E842CC4E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679064031; x=1710600031;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gYikGmjqXd8yRH3n31ijvSNc3r4gAamacT5gAoDTbZ8=;
  b=ZxNa/pk7sAkqilxANv6nxhaeIDO3yUXF9kmjTOVtvxlbEu/JD61O9Uz4
   co0JDmkOotCyncCHWMCAwPFATxRgcvqag+MYuHrjxlX5TkwzClswhOkz5
   ywAfx7Z/pGll1wEpXfLkhBYRrrq4qEJYp6Nkj/exmEpQhec5EnrQjQ0oT
   3NB+v/burGFhYq0rcQ4WvNuYsDJagG8JvkSeB5zKzdHGPdjkhlwWhm0kN
   bCfb7zxi1VHx9QPRf7yOsNI6KcWv5uiDKBWAttl7QP+msOG4qYaH5CRW7
   rZMdES1H6jXn438FSaE6bFoFwsLUa0DwKXMPUNUYmP8M49FzeeW/7RN+E
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="336973494"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="336973494"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 07:40:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="712777754"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="712777754"
Received: from subhraka-mobl2.amr.corp.intel.com (HELO [10.255.39.136]) ([10.255.39.136])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 07:40:30 -0700
Message-ID: <2ca6aa55-c367-8d5e-702a-9fb1a518310a@linux.intel.com>
Date:   Fri, 17 Mar 2023 09:29:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] soundwire: bus: Update sdw_nread/nwrite_no_pm to
 handle page boundaries
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com,
        sanyog.r.kale@intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
References: <20230316155734.3191577-1-ckeepax@opensource.cirrus.com>
 <20230316155734.3191577-2-ckeepax@opensource.cirrus.com>
 <447cac77-4cc7-b2a3-23e7-978e1641a401@linux.intel.com>
 <20230317140807.GI68926@ediswmail.ad.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230317140807.GI68926@ediswmail.ad.cirrus.com>
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



On 3/17/23 09:08, Charles Keepax wrote:
> On Thu, Mar 16, 2023 at 01:46:57PM -0500, Pierre-Louis Bossart wrote:
>>
>>
>> On 3/16/23 10:57, Charles Keepax wrote:
>>> Currently issuing a sdw_nread/nwrite_no_pm across a page boundary
>>> will silently fail to write correctly as nothing updates the page
>>> registers, meaning the same page of the chip will get rewritten
>>> with each successive page of data.
>>>
>>> As the sdw_msg structure contains page information it seems
>>> reasonable that a single sdw_msg should always be within one
>>> page. It is also mostly simpler to handle the paging at the
>>> bus level rather than each master having to handle it in their
>>> xfer_msg callback.
>>>
>>> As such add handling to the bus code to split up a transfer into
>>> multiple sdw_msg's when they go across page boundaries.
>>
>> This sounds good but we need to clarify that the multiple sdw_msg's will
>> not necessarily be sent one after the other, the msg_lock is held in the
>> sdw_transfer() function, so there should be no expectation that e.g. one
>> big chunk of firmware code can be sent without interruption.
>>
> 
> I will update the kdoc for nread/nwrite to specify that
> transactions that cross a page boundry are not expected to be
> atomic.

Sounds good.

>> I also wonder if we should have a lower bar than the page to avoid
>> hogging the bus with large read/write transactions. If there are
>> multiple devices on the same link and one of them signals an alert
>> status while a large transfer is on-going, the alert handling will
>> mechanically be delayed by up to a page - that's 32k reads/writes, isn't it?
>>
> 
> I think its 16k, but I would be inclined to say this is a
> separate fix. The current code will tie up the bus for longer
> than my fix does, since it only calls sdw_transfer once, and it
> will write the wrong registers whilst doing it. Also to be clear
> this wasn't found with super large transfers just medium sized
> ones that happened to cross a page boundry.
> 
> If we want to add some transaction size capping that is really
> a new feature, this patch a bug fix. I would also be inclined
> to say if we are going to add transaction size capping, we
> probably want some property to specify what we are capping to.

Yes indeed, this would be a new feature. I think this should be a
manager property, depending on which peripherals are integrated and what
latencies are expected.
