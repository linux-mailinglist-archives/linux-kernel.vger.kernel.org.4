Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31466640BD7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbiLBRLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiLBRLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:11:03 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C09DEC821
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670001062; x=1701537062;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PTM4jMqtGOe4MZYpr8xDoOQAr18vNvgRXmZGINsD4lQ=;
  b=Opl/6fgL0aVLb1SHyuvKw52Gs/veaoDzKK8gdKhStoAJkwPYtbY3VtJr
   1jEeEd2T7iBjMskj69g5MpbC0BQ68ZWPebWMfIqBQwnG1NEnLz30QgyV+
   Ntf589MNu61yQds+TIfjzve0QEcv6VxRaSrqoIF73fg0kFzvsSR1J1pk2
   h0BddSlfWI9/+fLlVExoU8ZZuE5BPZizYkvzHoL0JmagTLehcDBhVEJQV
   5rDwNSPyHufy7QR7BMZroz4AD8xcy3DlhOgfHGymO+Q2+pbpWwZmIJpRO
   Px+yWNS3xouf0aevz4OtB6Ae2RFppZK7srEEvffIRPYSY5tvtoFpe935P
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="380286121"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="380286121"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 09:11:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="645091211"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="645091211"
Received: from ofaiz-mobl1.amr.corp.intel.com (HELO [10.212.59.186]) ([10.212.59.186])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 09:11:00 -0800
Message-ID: <08b9871d-54fa-bbef-a5ca-0be888312645@linux.intel.com>
Date:   Fri, 2 Dec 2022 10:45:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 0/2] soundwire: Remove redundant zeroing of page registers
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, sanyog.r.kale@intel.com,
        yung-chuan.liao@linux.intel.com
References: <20221201140813.4062146-1-rf@opensource.cirrus.com>
 <002826da-f22f-9ce2-1688-345fe4e3c7ed@linux.intel.com>
 <266bf397-4395-873b-c933-73a9e28f463c@opensource.cirrus.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <266bf397-4395-873b-c933-73a9e28f463c@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/2/22 05:26, Richard Fitzgerald wrote:
> On 01/12/2022 18:31, Pierre-Louis Bossart wrote:
>>
>>
>> On 12/1/22 08:08, Richard Fitzgerald wrote:
>>> Writing zero to the page registers after each message transaction can
>>> add
>>> up to a lot of overhead for codecs that need to transfer large amount of
>>> data - for example a firmware download.
>>>
>>> There's no spec reason I can see for this zeroing. The page registers
>>> are
>>> only used for a paged address. The bus code uses a non-paged address for
>>> registers in page 0. It always writes the page registers at the start of
>>> a paged transaction.
>>>
>>> If this zeroing was a workaround for anything, let me know and I will
>>> re-implement the zeroing as a quirk that can be enabled only when it is
>>> necessary.
>>
>> It's a feature, not a bug :-)
>>
>> The page registers have to be zeroed out so that any bus-management
>> command hits the page0 instead of using a value that was set by codec
>> driver for vendor-specific configurations.
>>
> 
> Why would these bus management commands set bit 15 to indicate a paged
> access? If they don't set bit 15 the page registers are not used and
> bits 15..31 of the register address must be 0. Table 78 in the Soundwire
> 1.2 spec. Table 71 in the 1.0 spec. Table 43 in the 0.6 draft spec.

I forgot about this magic BIT(15) and indeed the Addr_page1/2 values are
ignored when issuing non-paged register access. There's really no need
to zero-out the page registers, it's completely unnecessary. Nice catch!

For the series:

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>



>> The implementation is far from optimal though, and indeed if we have
>> long transactions that are not interrupted by anything else we could
>> avoid resetting the page registers.
>>
>> I tried to implement a 'lazy approach' some time back, but at the time I
>> didn't see any benefits due to the limited number of configurations.
>>
>> I can't remember where the code is, but the initial enhancement was
>> listed here: https://github.com/thesofproject/linux/issues/2881
>>
>>>
>>> Richard Fitzgerald (2):
>>>    soundwire: bus: Don't zero page registers after every transaction
>>>    soundwire: bus: Remove unused reset_page_addr() callback
>>>
>>>   drivers/soundwire/bus.c             | 23 -----------------------
>>>   drivers/soundwire/cadence_master.c  | 14 --------------
>>>   drivers/soundwire/cadence_master.h  |  3 ---
>>>   drivers/soundwire/intel_auxdevice.c |  1 -
>>>   include/linux/soundwire/sdw.h       |  3 ---
>>>   5 files changed, 44 deletions(-)
>>>
