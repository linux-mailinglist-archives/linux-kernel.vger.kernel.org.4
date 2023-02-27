Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA226A46A2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjB0QB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjB0QBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:01:52 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A397F21A21
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677513709; x=1709049709;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=1HxtfCeo+rkfKleHDzlRp4nRdNNYNBBKYk/rttQqvrQ=;
  b=BBI3c4XYIZK6Nsg+eN+vT2A1ascHPdap+aY8hufn0G0AmYFseuJUTNeV
   XRwXC2BiNUUZKqEjlyjktcHC8iIlHDdwoKkxJPCWf31aW3lu+qEtCoaHy
   q75VTI3zUs9sEe0v/HyaHGO4hphq/lr1bBeWxtvLkaWx3dO6uNc4u5rml
   HoMgIUdhFgCV4xFTpZXFJHzdrjPzmrfp8g1LjbtKzNpcFXusmEHUEw1nU
   RIasisSpYZHgXZJaHwHlNftFCVhHM31w8+bDWKO7zuWKwgN0Yf7kRjQ5C
   8Ob5TwtzWiPvILrQVWR8qX9cprHkXUTRp2adER5efL227G9OGcdks9CnD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="314315745"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="314315745"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 08:01:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="919398125"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="919398125"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 08:01:43 -0800
Message-ID: <acfbb60b-21ab-c164-ccb4-82bc6aab26b5@linux.intel.com>
Date:   Mon, 27 Feb 2023 17:01:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] firmware_loader: Add debug message with checksum for FW
 file
Content-Language: en-US
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Russ Weight <russell.h.weight@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20230224201918.411492-1-amadeuszx.slawinski@linux.intel.com>
 <Y/ixsjgkh8M10yKX@kroah.com>
 <53119509-3365-f648-8c9b-335fe99eb0af@linux.intel.com>
In-Reply-To: <53119509-3365-f648-8c9b-335fe99eb0af@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/2023 1:54 PM, Amadeusz Sławiński wrote:
> On 2/24/2023 1:46 PM, Greg Kroah-Hartman wrote:
>> On Fri, Feb 24, 2023 at 09:19:18PM +0100, Amadeusz Sławiński wrote:
>>> Enable dynamic-debug logging of firmware filenames and SHA256 checksums
>>> to clearly identify the firmware files that are loaded by the system.
>>>
>>> Example output:
>>> [   34.944619] firmware_class:_request_firmware: i915 0000:00:02.0: 
>>> Loaded FW: i915/kbl_dmc_ver1_04.bin, sha256: 
>>> 2cde41c3e5ad181423bcc3e98ff9c49f743c88f18646af4d0b3c3a9664b831a1
>>> [   48.155884] firmware_class:_request_firmware: snd_soc_avs 
>>> 0000:00:1f.3: Loaded FW: intel/avs/cnl/dsp_basefw.bin, sha256: 
>>> 43f6ac1b066e9bd0423d914960fbbdccb391af27d2b1da1085eee3ea8df0f357
>>> [   49.579540] firmware_class:_request_firmware: snd_soc_avs 
>>> 0000:00:1f.3: Loaded FW: intel/avs/rt274-tplg.bin, sha256: 
>>> 4b3580da96dc3d2c443ba20c6728d8b665fceb3ed57223c3a57582bbad8e2413
>>> [   49.798196] firmware_class:_request_firmware: snd_soc_avs 
>>> 0000:00:1f.3: Loaded FW: intel/avs/hda-8086280c-tplg.bin, sha256: 
>>> 5653172579b2be1b51fd69f5cf46e2bac8d63f2a1327924311c13b2f1fe6e601
>>> [   49.859627] firmware_class:_request_firmware: snd_soc_avs 
>>> 0000:00:1f.3: Loaded FW: intel/avs/dmic-tplg.bin, sha256: 
>>> 00fb7fbdb74683333400d7e46925dae60db448b88638efcca0b30215db9df63f
>>>
>>> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
>>> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
>>> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
>>> ---
>>>   drivers/base/firmware_loader/main.c | 45 ++++++++++++++++++++++++++++-
>>>   1 file changed, 44 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/base/firmware_loader/main.c 
>>> b/drivers/base/firmware_loader/main.c
>>> index 017c4cdb219e..a6e1fb10763d 100644
>>> --- a/drivers/base/firmware_loader/main.c
>>> +++ b/drivers/base/firmware_loader/main.c
>>> @@ -791,6 +791,47 @@ static void fw_abort_batch_reqs(struct firmware 
>>> *fw)
>>>       mutex_unlock(&fw_lock);
>>>   }
>>> +#if defined(DEBUG) || defined(CONFIG_DYNAMIC_DEBUG)
>>> +#include <crypto/hash.h>
>>> +#include <crypto/sha2.h>
>>> +#define SHA256_STRING_SIZE (SHA256_DIGEST_SIZE * 2)
>>> +static void fw_log_firmware_info(const struct firmware *fw, const 
>>> char *name, struct device *device)
>>> +{
>>> +    char outbuf[SHA256_STRING_SIZE + 1];
>>> +    u8 sha256buf[SHA256_DIGEST_SIZE];
>>
>> Nit, these are big, are you _SURE_ you can put them on the stack ok?
>> Why not dynamically allocate them?
>>
> 
> Well, those arrays are not that big? First one is 65 bytes and other one 
> 32. Although now that I looked again at the header, there is 
> SHA256_BLOCK_SIZE define for string size, so I will change 
> SHA256_STRING_SIZE to that instead.
> 
>>> +    struct shash_desc *shash;
>>> +    struct crypto_shash *alg;
>>> +
>>> +    alg = crypto_alloc_shash("sha256", 0, 0);
>>
>> Do we need to select this in the .config as well?
>>
> 
> Most likely.
> 

So I'm having a bit of problem here, as something like:
diff --git a/drivers/base/firmware_loader/Kconfig 
b/drivers/base/firmware_loader/Kconfig
index 5166b323a0f8..95cf2d8af5c4 100644
--- a/drivers/base/firmware_loader/Kconfig
+++ b/drivers/base/firmware_loader/Kconfig
@@ -3,6 +3,8 @@ menu "Firmware loader"

  config FW_LOADER
         tristate "Firmware loading facility" if EXPERT
+       select CRYPTO_SHA256 if DYNAMIC_DEBUG
+       select CRYPTO if DYNAMIC_DEBUG
         default y
         help
           This enables the firmware loading facility in the kernel. The 
kernel
being the most simple potential fix doesn't seem to work due to circular 
dependencies. Seems like quite a few cryptography accelerators require 
FW_LOADER and it causes problems.

I tried few more things, but none of them seem to work. Any advice on 
what I can do here?

>>> +    if (!alg)
>>> +        return;
>>> +
>>> +    shash = kmalloc(sizeof(*shash) + crypto_shash_descsize(alg), 
>>> GFP_KERNEL);
>>
>> kmalloc_array()?
>>
> 
> Yes.
> 

And taking one more look, it isn't array allocation but struct followed 
by VLA used to store additional data, so it will stay as is.

