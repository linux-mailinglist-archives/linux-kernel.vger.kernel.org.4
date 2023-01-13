Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BE6669EE4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjAMQ6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjAMQ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:58:08 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755903D5D9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673629087; x=1705165087;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tKkhXL/CiEfev998YmSa7nRCf0L1IHc+S/472iAqBP8=;
  b=YB0R4dvnoD6wgCImyBK9G0v/uxwqWTi0dhQ6kHnJagIq04Jn03smbItd
   M1Kncv6Jl7hQDZmJsbJ2wWnReMfbVpaS65WNYYZg7X3eD2Bu1QHa0l+Dw
   o3OgB0uHoR670AmmWi2H5UCaVYyZqgkcQ59dbhhp1rmuSk2AbB20/Nw8z
   LkvniBZH3YFQvCYtmnjVInwk134Bj+tYPPrsbS6oZi4Agr/1KX7PRlT1l
   KSBxWWuYrKwWOMFWPzzXKCMUrbAqWJ2RdC3HiSh+XzuvOhmaTwrBtei+T
   P3oI5IUSy9NFXzTN0ExLWbodvRoYzNLJI9kI2ADFtyjJkwCwxauLxw9Fs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="326095899"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="326095899"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 08:57:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="608219679"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="608219679"
Received: from rerayess-mobl.amr.corp.intel.com (HELO [10.212.13.223]) ([10.212.13.223])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 08:57:40 -0800
Message-ID: <487b7647-8304-8e36-00f2-c9ba3aa50004@linux.intel.com>
Date:   Fri, 13 Jan 2023 10:57:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] regmap: sdw: Remove 8-bit value size restriction
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
References: <20230112171840.2098463-1-ckeepax@opensource.cirrus.com>
 <20230112171840.2098463-3-ckeepax@opensource.cirrus.com>
 <756fcb2d-d571-18cb-985e-d907ab682275@linux.intel.com>
 <Y8BOCpXyOyF3igfG@sirena.org.uk>
 <3320e6b8-28c7-d028-3c4c-2b4b25a963fb@linux.intel.com>
 <Y8BkiF8sfqPifYTO@sirena.org.uk>
 <4a6ae9b4-2748-c751-aec6-05979de95cfe@linux.intel.com>
 <20230113110252.GK36097@ediswmail.ad.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230113110252.GK36097@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/23 05:02, Charles Keepax wrote:
> On Thu, Jan 12, 2023 at 02:19:29PM -0600, Pierre-Louis Bossart wrote:
>> On 1/12/23 13:50, Mark Brown wrote:
>>> On Thu, Jan 12, 2023 at 12:43:46PM -0600, Pierre-Louis Bossart wrote:
>>>> On 1/12/23 12:14, Mark Brown wrote:
>>>
>>>>> The regmap gather_write() operation allows the bus to take two buffers,
>>>>> one for the register and one for the value, rather than requiring the
>>>>> core combine everything into a single buffer (mainly useful for large
>>>>> transfers like firmware downloads).
>>>
>>>> Right, but that's not supported in SoundWire. sdw_nwrite() will only
>>>> work with consecutive addresses - and the auto-increment is handled in
>>>> software, not hardware.
>>>
>>> No, that's exactly what this is for.  It's for the *register address*
>>> being in a separate buffer, the data is then a sequence of consecutive
>>> register values.>
>>>> What's suggested here is to use the first element of reg_buf, which begs
>>>> the question how different this is from a regular write. If there was a
>>>> discontinuity in reg_buf then this wouldn't work at all.
>>>
>>> reg_buf contains the address of exactly one register.
>>
>> So what's the difference with a plain write() of N data?
> 
> There are two back end interfaces in regmap, the reg_write/read
> and the plain write/read. Both have currently have some
> limitations when dealing with SoundWire.
> 
> The reg_write/reg_read can only deal with a single register
> at a time, which is really far from ideal, since it means
> all transactions will be broken up into individual registers
> at the regmap level, mostly depriving the SoundWire side
> of the opportunity to do things like a BRA transfer if it
> deems that suitable. And denying users the ability to use the
> regmap_raw_read/write API at all.
> 
> The write/read interface allows us to pass the full transaction
> through, but does have the downside it copies the address around
> a bit more and does some pointless endian swaps on big endian
> systems. This interface is generally used by buses like I2C/SPI
> where there is no actual concept of a register address only a
> buffer of bytes to be sent/read, thus prefers to pass a single
> working buffer if it sensibly can. I went with this solution
> because it enables all the functionality and the downside is
> fairly minimal, apart from looking a little clunky as you note.

The change from reg_write/read_reg to write/read seems ok, what I was
asking about was the gather_write.

+	.write = regmap_sdw_write,
+	.gather_write = regmap_sdw_gather_write,
+	.read = regmap_sdw_read,

what happens if you only have .write and .read? What does the
.gather_write help with if you only use only address?
