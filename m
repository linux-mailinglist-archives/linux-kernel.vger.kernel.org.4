Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4546BEBAA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjCQOrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjCQOrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:47:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA2CCC2C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679064419; x=1710600419;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Pj6nvi9PVNL4ZNHSvZho8gFZuRB6VbRyQSHU8LDHi8U=;
  b=QajVqBWna5zO/t+S3GTTYuAuHHR2RZcDIHHJ0RMbEvyu7vLk/fiqciys
   71dRnBMENIuSLQ0AmG4zPu/9Y878oPHfyXNldr2R7famh8a2hsKhvRdrJ
   al9gCW+1kh7464C9oRVdQpNLTJHYyWTRCasPfq9ufM4LXVfYqs8eADlg/
   2rJw6jQrqEGeo6Y9CzMZgfs0RewcZ2DdogH7+QUNrJmCQbCCwvhSmQyHZ
   C3u9KPof55NW6ZJtHlfB1fIL64mloRShNpoeSZVzvictD5Y9GU0Xh4LIr
   /GypMEE+e3Sdg9Oq0C1x4qbA9QiE+yn1ELqX1io/emqI0b4hC7a/FYWbr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="317929443"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="317929443"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 07:46:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="657583300"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="657583300"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 07:46:57 -0700
Message-ID: <0bcb1439-7a76-9f24-21be-2139b8e5c06d@linux.intel.com>
Date:   Fri, 17 Mar 2023 15:46:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] firmware_loader: Add debug message with checksum for
 FW file
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Russ Weight <russell.h.weight@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20230310140459.2972793-1-amadeuszx.slawinski@linux.intel.com>
 <ZBR15Qy0F6bianXR@kroah.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <ZBR15Qy0F6bianXR@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/2023 3:15 PM, Greg Kroah-Hartman wrote:
> On Fri, Mar 10, 2023 at 03:04:59PM +0100, Amadeusz Sławiński wrote:
>> Enable dynamic-debug logging of firmware filenames and SHA256 checksums
>> to clearly identify the firmware files that are loaded by the system.
>>
>> Example output:
>> [   34.944619] firmware_class:_request_firmware: i915 0000:00:02.0: Loaded FW: i915/kbl_dmc_ver1_04.bin, sha256: 2cde41c3e5ad181423bcc3e98ff9c49f743c88f18646af4d0b3c3a9664b831a1
>> [   48.155884] firmware_class:_request_firmware: snd_soc_avs 0000:00:1f.3: Loaded FW: intel/avs/cnl/dsp_basefw.bin, sha256: 43f6ac1b066e9bd0423d914960fbbdccb391af27d2b1da1085eee3ea8df0f357
>> [   49.579540] firmware_class:_request_firmware: snd_soc_avs 0000:00:1f.3: Loaded FW: intel/avs/rt274-tplg.bin, sha256: 4b3580da96dc3d2c443ba20c6728d8b665fceb3ed57223c3a57582bbad8e2413
>> [   49.798196] firmware_class:_request_firmware: snd_soc_avs 0000:00:1f.3: Loaded FW: intel/avs/hda-8086280c-tplg.bin, sha256: 5653172579b2be1b51fd69f5cf46e2bac8d63f2a1327924311c13b2f1fe6e601
>> [   49.859627] firmware_class:_request_firmware: snd_soc_avs 0000:00:1f.3: Loaded FW: intel/avs/dmic-tplg.bin, sha256: 00fb7fbdb74683333400d7e46925dae60db448b88638efcca0b30215db9df63f
>>
>> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
>> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
>> ---
>>
>> Changes in v4:
>>   * update menuconfig prompt and help message (Russ)
>>
>> Changes in v3:
>>   * add DYNAMIC_DEBUG and FW_LOADER as dependencies before option can be
>> enabled (kernel test robot)
>>
>> Changes in v2:
>>   * allocate buffers (Greg)
>>   * introduce CONFIG_ option to allow for CONFIG_CRYPTO and CONFIG_CRYPTO_SHA256
>> dependencies without introducing circular dependency (Greg)
>>   * add new line between includes and function name (Cezary)
>>
>> ---
>>   drivers/base/firmware_loader/Kconfig | 13 ++++++++
>>   drivers/base/firmware_loader/main.c  | 48 +++++++++++++++++++++++++++-
>>   2 files changed, 60 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
>> index 5166b323a0f8..6520e8c9cb38 100644
>> --- a/drivers/base/firmware_loader/Kconfig
>> +++ b/drivers/base/firmware_loader/Kconfig
>> @@ -3,6 +3,7 @@ menu "Firmware loader"
>>   
>>   config FW_LOADER
>>   	tristate "Firmware loading facility" if EXPERT
>> +	select FW_LOADER_DEBUG if DYNAMIC_DEBUG
> 
> Why the select?  that prevents anyone from actually choosing this if
> they want to or not.  It also prevents them from disabling this option
> if they want to, while still keeping DYNAMIC_DEBUG enabled.
> 
> So please don't make this change.
>
Indeed it seems unnecessary, I removed it in v5.

Thanks,

Amadeusz

