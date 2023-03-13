Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DF16B7D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCMQcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjCMQcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:32:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0630A5C117
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678724997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HOm3guk3Pbgw64RxprbmHoVswDtw90OzL9pI+grILUI=;
        b=WuMOll3tYdtx+cUY+oR3lMrexuil7qS6b7+kyvipbr2msYH02dr5CkAewSh97mMXfvlBIm
        AGLqIOvrIkuZWZNJVyfv6ie4BpID9/YgYykNrutwI8Vb0A5ckXFI49VlVVBPe2htSyJrXW
        qQzdoe3c8swwHqsOEvEs6s8z26+5WB8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-tjZCzPkZMfG1Azk5n9zKoQ-1; Mon, 13 Mar 2023 12:29:56 -0400
X-MC-Unique: tjZCzPkZMfG1Azk5n9zKoQ-1
Received: by mail-ed1-f72.google.com with SMTP id r9-20020a05640251c900b004d4257341c2so17722590edd.19
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678724995;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HOm3guk3Pbgw64RxprbmHoVswDtw90OzL9pI+grILUI=;
        b=qkUDTf1AfZjYNBVQ2wvSFt94SZ6Nv90gAh+l4eDSftj/jUgpVNMmeMoBk8YGA3hUq4
         EP/hzj9eeLKlWsgrSkyMinn3nce1g65U6kQco1PyGlvFxbX8uwXCMZgeVTTPt85AZqdH
         AZXqCU13NWiGE69Go5n6M1Gr3ywlWgE2M7FQo3akI3AlNl4PLjWQgsRovW8tFKXzzP0L
         mpw8e4FXcYO/HWf+oq1kzE1RUDzxLc49HusNuGkiR7V4U0GBOD8hecB4x9oPCXiWk0ra
         s93s6gAbb/IERP6KRQjcHOfLH1MucNRkWGxfJEDVI6NJ5Tdp/y0iPOZN6fA5Bzviml/j
         1JeA==
X-Gm-Message-State: AO0yUKXvMgltTxhmnkIYHCTvSsj5M6B0seirRBX58hCMB22RDWWFm1AN
        M7dd4fipLIvvdySdMgFOlYRFnjnUtgp81PBzNOerhuZL2MGPz9aGZV3fMgBbkciy52nt7Dv7Rdz
        HARnSFz5N0bDae1lJr9e0oo25
X-Received: by 2002:a17:907:c084:b0:92b:dff5:42b1 with SMTP id st4-20020a170907c08400b0092bdff542b1mr1516913ejc.66.1678724995146;
        Mon, 13 Mar 2023 09:29:55 -0700 (PDT)
X-Google-Smtp-Source: AK7set+VS+Y85uZk6qp9b2gAOcQLH+Dtwf4zqrCKuPrFVBSiIGCAFRUYpJLEk1mf1rOhsezT1N2Biw==
X-Received: by 2002:a17:907:c084:b0:92b:dff5:42b1 with SMTP id st4-20020a170907c08400b0092bdff542b1mr1516882ejc.66.1678724994855;
        Mon, 13 Mar 2023 09:29:54 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id re2-20020a170906d8c200b00926d614b890sm1941649ejb.204.2023.03.13.09.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 09:29:54 -0700 (PDT)
Message-ID: <275d2f04-782f-2c9d-187a-7a510bf34f41@redhat.com>
Date:   Mon, 13 Mar 2023 17:29:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 4/8] platform/x86/intel/ifs: Introduce Array Scan test
 to IFS
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jithu Joseph <jithu.joseph@intel.com>, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, rostedt@goodmis.org,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
References: <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230301015942.462799-1-jithu.joseph@intel.com>
 <20230301015942.462799-5-jithu.joseph@intel.com>
 <7f82f241-39ee-15e0-1ae7-e98e50730c95@redhat.com>
In-Reply-To: <7f82f241-39ee-15e0-1ae7-e98e50730c95@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/13/23 17:10, Hans de Goede wrote:
> Hi,
> 
> On 3/1/23 02:59, Jithu Joseph wrote:
>> Array BIST is a new type of core test introduced under the Intel Infield
>> Scan (IFS) suite of tests.
>>
>> Emerald Rapids (EMR) is the first CPU to support Array BIST.
>> Array BIST performs tests on some portions of the core logic such as
>> caches and register files. These are different portions of the silicon
>> compared to the parts tested by the first test type
>> i.e Scan at Field (SAF).
>>
>> Make changes in the device driver init flow to register this new test
>> type with the device driver framework. Each test will have its own
>> sysfs directory (intel_ifs_0 , intel_ifs_1) under misc hierarchy to
>> accommodate for the differences in test type and how they are initiated.
>>
>> Upcoming patches will add actual support.
>>
>> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> ---
>>  drivers/platform/x86/intel/ifs/ifs.h  |  3 +
>>  drivers/platform/x86/intel/ifs/core.c | 85 +++++++++++++++++++--------
>>  2 files changed, 62 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
>> index ab168ddf28f1..b8b956e29653 100644
>> --- a/drivers/platform/x86/intel/ifs/ifs.h
>> +++ b/drivers/platform/x86/intel/ifs/ifs.h
>> @@ -137,6 +137,9 @@
>>  #define SCAN_TEST_PASS				1
>>  #define SCAN_TEST_FAIL				2
>>  
>> +#define IFS_TYPE_SAF			0
>> +#define IFS_TYPE_ARRAY_BIST		1
>> +
>>  /* MSR_SCAN_HASHES_STATUS bit fields */
>>  union ifs_scan_hashes_status {
>>  	u64	data;
>> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
>> index 62c44dbae757..2237aaba7078 100644
>> --- a/drivers/platform/x86/intel/ifs/core.c
>> +++ b/drivers/platform/x86/intel/ifs/core.c
>> @@ -16,6 +16,7 @@
>>  
>>  static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
>>  	X86_MATCH(SAPPHIRERAPIDS_X),
>> +	X86_MATCH(EMERALDRAPIDS_X),
>>  	{}
>>  };
>>  MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
> 
> Note you can add driver_data to a match table like this. What you should
> do here is use the driver data to point to the const ifs_hw_caps discussed
> before, so what you get here is:
> 
> #define X86_MATCH(model, data)                          \
>         X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,    \
>                 INTEL_FAM6_##model, X86_FEATURE_CORE_CAPABILITIES, (unsigned long)(data))
> 
> static const struct ifs_hw_caps saphire_rapids_caps = {
> 	.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
> 	.test_num = 0,
> };
> 
> static const struct ifs_hw_caps emerald_rapids_caps = {
> 	.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
> 	.test_num = 0,
> };
> 
> static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
> 	X86_MATCH(SAPPHIRERAPIDS_X, &saphire_rapids_caps),
> 	X86_MATCH(EMERALDRAPIDS_X, &emerald_rapids_caps),
> 	{}
> };
> MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
> 
> and then drop all the code related to having an array of ifs_device structs
> (of which only 1 will ever get used) and instead at the beginning of
> ifs_init(void), after:
> 
>         m = x86_match_cpu(ifs_cpu_ids);
>         if (!m)
>                 return -ENODEV;
> 
> add:
> 
> 	ifs_device.hwcaps = (const struct ifs_hw_caps *)m->driver_data;
> 
> And then you can pretty much drop all the rest of this patch and we
> end up with much nicer code for differentiating between the models :)

Upon reading the rest of the series, I think the above might be based
on me misunderstanding this bit.

If I understand things correctly then what is new with emerald_rapids
is support for a second set/type of tests called " Array Scan test"
and the old test method / test-type is also still supported.

And you have chosen to register 2 misc-devices , one per supported
test type ?

Have I understood that correcty?

May I ask why use 1 misc device per test-type. Why not just add
a single new sysfs_attr to the existing misc device to trigger
the new test-type ?

Regards,

Hans


>> @@ -24,23 +25,51 @@ ATTRIBUTE_GROUPS(plat_ifs);
>>  
>>  bool *ifs_pkg_auth;
>>  
>> -static struct ifs_device ifs_device = {
>> -	.ro_data = {
>> -		.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
>> -		.test_num = 0,
>> +static struct ifs_device ifs_devices[] = {
>> +	[IFS_TYPE_SAF] = {
>> +		.ro_data = {
>> +			.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
>> +			.test_num = IFS_TYPE_SAF,
>> +		},
>> +		.misc = {
>> +			.name = "intel_ifs_0",
>> +			.minor = MISC_DYNAMIC_MINOR,
>> +			.groups = plat_ifs_groups,
>> +		},
>>  	},
>> -	.misc = {
>> -		.name = "intel_ifs_0",
>> -		.minor = MISC_DYNAMIC_MINOR,
>> -		.groups = plat_ifs_groups,
>> +	[IFS_TYPE_ARRAY_BIST] = {
>> +		.ro_data = {
>> +			.integrity_cap_bit = MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT,
>> +			.test_num = IFS_TYPE_ARRAY_BIST,
>> +		},
>> +		.misc = {
>> +			.name = "intel_ifs_1",
>> +			.minor = MISC_DYNAMIC_MINOR,
>> +		},
>>  	},
>>  };
>>  
>> +#define IFS_NUMTESTS ARRAY_SIZE(ifs_devices)
>> +
>> +static void ifs_cleanup(void)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < IFS_NUMTESTS; i++) {
>> +		if (ifs_devices[i].misc.this_device) {
>> +			misc_deregister(&ifs_devices[i].misc);
>> +			kfree(ifs_devices[i].rw_data);
>> +		}
>> +	}
>> +	kfree(ifs_pkg_auth);
>> +}
>> +
>>  static int __init ifs_init(void)
>>  {
>>  	const struct x86_cpu_id *m;
>>  	struct ifs_data *ifsd;
>>  	u64 msrval;
>> +	int i, ret;
>>  
>>  	m = x86_match_cpu(ifs_cpu_ids);
>>  	if (!m)
>> @@ -55,35 +84,39 @@ static int __init ifs_init(void)
>>  	if (rdmsrl_safe(MSR_INTEGRITY_CAPS, &msrval))
>>  		return -ENODEV;
>>  
>> -	if (!(msrval & BIT(ifs_device.ro_data.integrity_cap_bit)))
>> -		return -ENODEV;
>> -
>>  	ifs_pkg_auth = kmalloc_array(topology_max_packages(), sizeof(bool), GFP_KERNEL);
>>  	if (!ifs_pkg_auth)
>>  		return -ENOMEM;
>>  
>> -	ifsd = kzalloc(sizeof(*ifsd), GFP_KERNEL);
>> -	if (!ifsd)
>> -		return -ENOMEM;
>> -
>> -	ifsd->ro_info = &ifs_device.ro_data;
>> -	ifs_device.rw_data = ifsd;
>> -
>> -	if (misc_register(&ifs_device.misc)) {
>> -		kfree(ifsd);
>> -		kfree(ifs_pkg_auth);
>> -		return -ENODEV;
>> +	for (i = 0; i < IFS_NUMTESTS; i++) {
>> +		ifsd = NULL;
>> +		if (!(msrval & BIT(ifs_devices[i].ro_data.integrity_cap_bit)))
>> +			continue;
>> +
>> +		ifsd = kzalloc(sizeof(*ifsd), GFP_KERNEL);
>> +		if (!ifsd) {
>> +			ret = -ENOMEM;
>> +			goto err_exit;
>> +		}
>> +		ifsd->ro_info = &ifs_devices[i].ro_data;
>> +		ifs_devices[i].rw_data = ifsd;
>> +
>> +		if (misc_register(&ifs_devices[i].misc)) {
>> +			ret = -ENODEV;
>> +			kfree(ifsd);
>> +			goto err_exit;
>> +		}
>>  	}
>> -
>>  	return 0;
>>  
>> +err_exit:
>> +	ifs_cleanup();
>> +	return ret;
>>  }
>>  
>>  static void __exit ifs_exit(void)
>>  {
>> -	misc_deregister(&ifs_device.misc);
>> -	kfree(ifs_device.rw_data);
>> -	kfree(ifs_pkg_auth);
>> +	ifs_cleanup();
>>  }
>>  
>>  module_init(ifs_init);

