Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3314A6A1C7D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjBXMyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjBXMyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:54:39 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8535C175
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677243278; x=1708779278;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OfcCtz3rWxfP3amwIcGuVYvyjcWidfx9qLgTpByTuQ8=;
  b=ekZQL36wwd2pW8LiIeT7AM5MpJ3upNsYuV7VI8QMSrejVZjvlXYjMkis
   kXGsEDme/dWJzcT+oPiQ3UcldxUzn2VvNtixdvqzrDGuWuHQzT34Gd9na
   8I0j1YUHAyjkxGvfsxtCa7iVyfd3MNZFYHO9XMpVeMzXZol0ZFptXG14d
   59PfB0+W1Fp7I17GbyiP3FHvdELzm+eJB+JYarh7jFeBPahARsfmiwqZz
   MegD6vJ6gQZopVAsJ1vupu9p99xc8Lf+KiG3AQKEGWXDQMBHJjjboCFke
   Q8CzjdKRz4pRCXrbWThTN1etV8eZmp7kirMHm90pP08ShAeQSU7dpGA9v
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="395978778"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="395978778"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 04:54:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="761773297"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="761773297"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 04:54:35 -0800
Message-ID: <53119509-3365-f648-8c9b-335fe99eb0af@linux.intel.com>
Date:   Fri, 24 Feb 2023 13:54:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] firmware_loader: Add debug message with checksum for FW
 file
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Russ Weight <russell.h.weight@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20230224201918.411492-1-amadeuszx.slawinski@linux.intel.com>
 <Y/ixsjgkh8M10yKX@kroah.com>
Content-Language: en-US
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <Y/ixsjgkh8M10yKX@kroah.com>
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

On 2/24/2023 1:46 PM, Greg Kroah-Hartman wrote:
> On Fri, Feb 24, 2023 at 09:19:18PM +0100, Amadeusz Sławiński wrote:
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
>> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
>> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
>> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
>> ---
>>   drivers/base/firmware_loader/main.c | 45 ++++++++++++++++++++++++++++-
>>   1 file changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
>> index 017c4cdb219e..a6e1fb10763d 100644
>> --- a/drivers/base/firmware_loader/main.c
>> +++ b/drivers/base/firmware_loader/main.c
>> @@ -791,6 +791,47 @@ static void fw_abort_batch_reqs(struct firmware *fw)
>>   	mutex_unlock(&fw_lock);
>>   }
>>   
>> +#if defined(DEBUG) || defined(CONFIG_DYNAMIC_DEBUG)
>> +#include <crypto/hash.h>
>> +#include <crypto/sha2.h>
>> +#define SHA256_STRING_SIZE (SHA256_DIGEST_SIZE * 2)
>> +static void fw_log_firmware_info(const struct firmware *fw, const char *name, struct device *device)
>> +{
>> +	char outbuf[SHA256_STRING_SIZE + 1];
>> +	u8 sha256buf[SHA256_DIGEST_SIZE];
> 
> Nit, these are big, are you _SURE_ you can put them on the stack ok?
> Why not dynamically allocate them?
> 

Well, those arrays are not that big? First one is 65 bytes and other one 
32. Although now that I looked again at the header, there is 
SHA256_BLOCK_SIZE define for string size, so I will change 
SHA256_STRING_SIZE to that instead.

>> +	struct shash_desc *shash;
>> +	struct crypto_shash *alg;
>> +
>> +	alg = crypto_alloc_shash("sha256", 0, 0);
> 
> Do we need to select this in the .config as well?
> 

Most likely.

>> +	if (!alg)
>> +		return;
>> +
>> +	shash = kmalloc(sizeof(*shash) + crypto_shash_descsize(alg), GFP_KERNEL);
> 
> kmalloc_array()?
> 

Yes.

>> +	if (!shash)
>> +		goto out_alg;
>> +
>> +	shash->tfm = alg;
>> +
>> +	if (crypto_shash_digest(shash, fw->data, fw->size, sha256buf) < 0)
>> +		goto out_shash;
>> +
>> +	for (int i = 0; i < SHA256_DIGEST_SIZE; i++)
>> +		sprintf(&outbuf[i * 2], "%02x", sha256buf[i]);
>> +	outbuf[SHA256_STRING_SIZE] = 0;
>> +	dev_dbg(device, "Loaded FW: %s, sha256: %s\n", name, outbuf);
>> +
>> +out_shash:
>> +	kfree(shash);
>> +out_alg:
>> +	crypto_free_shash(alg);
> 
> Otherwise, just tiny comments, overall this looks nice, thanks for doing
> this.
> 
> greg k-h

