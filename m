Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DF46B42F1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjCJOI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjCJOIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:08:37 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6969F1555E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678457293; x=1709993293;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nQESf9oaVXZHyXHYXROB5Etqj3sLQ9wxpjv9270ZNw4=;
  b=htqvC94RdHutjQOY/PBhqxnmOmQYvblHAF3z29mV7EWSYtuzdWF3HXhi
   YwK6a49xedDovKoi67z/XEeX3HgHjSicoRXWl4M1j8bWhPNT5lT7BjSDn
   NzELBD2EHZsl2uQ01sZtMgmXKv+9pAkV+ILpizPC3nHLZ8ZCo7kL//W4v
   U80idmORskoHvtMSdA4Heiz6IvS7LJUKQYy3UsCm/sPRUX8tZ5yGooyYv
   /EyJDxjNcpZMwX2CCnGYn4o08Ksr3HGZWEhgbLlZ3O/ig0j3nvOM59joq
   o7P6LBCW0o+kCY2++T4WwjXp7qqY+a3ATk9gu8aHfQM0rY8sZUTifjVwd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="339095237"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="339095237"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 06:07:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="680221992"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="680221992"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 06:07:38 -0800
Message-ID: <3cba545e-3abe-2234-7750-4a6b5f11ea55@linux.intel.com>
Date:   Fri, 10 Mar 2023 15:07:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] firmware_loader: Add debug message with checksum for
 FW file
Content-Language: en-US
To:     Russ Weight <russell.h.weight@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20230302184651.2028184-1-amadeuszx.slawinski@linux.intel.com>
 <542f9495-0216-a26e-3b53-5ccf419c8862@intel.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <542f9495-0216-a26e-3b53-5ccf419c8862@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/2023 2:17 AM, Russ Weight wrote:
> 
> 
> On 3/2/23 10:46, Amadeusz Sławiński wrote:
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
>>   drivers/base/firmware_loader/Kconfig | 12 +++++++
>>   drivers/base/firmware_loader/main.c  | 48 +++++++++++++++++++++++++++-
>>   2 files changed, 59 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
>> index 5166b323a0f8..a2f8f75e0718 100644
>> --- a/drivers/base/firmware_loader/Kconfig
>> +++ b/drivers/base/firmware_loader/Kconfig
>> @@ -3,6 +3,7 @@ menu "Firmware loader"
>>   
>>   config FW_LOADER
>>   	tristate "Firmware loading facility" if EXPERT
>> +	select FW_LOADER_DEBUG if DYNAMIC_DEBUG
>>   	default y
>>   	help
>>   	  This enables the firmware loading facility in the kernel. The kernel
>> @@ -24,6 +25,17 @@ config FW_LOADER
>>   	  You also want to be sure to enable this built-in if you are going to
>>   	  enable built-in firmware (CONFIG_EXTRA_FIRMWARE).
>>   
>> +config FW_LOADER_DEBUG
>> +	bool "Additional debug logs"
> 
> This is the prompt that shows up when I do "make menuconfig". How about
> something more descriptive?
> 
> "Log filenames and checksums for loaded firmware"
> 
>> +	depends on DYNAMIC_DEBUG
>> +	depends on FW_LOADER
>> +	depends on CRYPTO
>> +	depends on CRYPTO_SHA256
>> +	default FW_LOADER
>> +	help
>> +	  Select this if additional information about loaded firmware file in
>> +	  form of sha256sum should be dumped.
> 
> How about:
> 
> "Select this option to log firmware filenames and SHA256 checksums to the
> kernel log for each firmware file that is loaded."
> 
> Thanks,
> - Russ
> 

Thanks! I've send v4, adjusted sentence a bit to mention that it 
requires dynamic debug, so that user is not confused why no messages 
shows even if option is enabled.

Amadeusz
