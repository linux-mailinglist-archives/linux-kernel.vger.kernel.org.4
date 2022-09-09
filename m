Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D349C5B4030
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiIITvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiIITvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:51:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D2A72EF4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 12:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662753063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q+wm7Eo2Yr7AD9iwL2+g7KrCUNvwbpesY0K27ORU+aw=;
        b=A21nPPVDlyeoY67sqawvQTleIw7wTekx6WWoghSEeMgtImEZ6nWUAclYk1wIFzWalPT4eb
        nWdRpZ2rbVRjKeRKYz+NVO/wFKOY0z0C0M81zcWmjg6n6VXKB9lv7ahtBLP11pJOjRY/24
        HN8TTVF9tzQPXbk6DhduuY7M5E/Hbkk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-270-nXKbdokpOpuwPFVnzVtr4g-1; Fri, 09 Sep 2022 15:51:02 -0400
X-MC-Unique: nXKbdokpOpuwPFVnzVtr4g-1
Received: by mail-ed1-f71.google.com with SMTP id b16-20020a056402279000b0044f1102e6e2so1990760ede.20
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 12:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=q+wm7Eo2Yr7AD9iwL2+g7KrCUNvwbpesY0K27ORU+aw=;
        b=okYKtFf+S3v+iZsLEaISeugYvWpsKCIYnU31vpq3enbA+UexfIB9b765A3T9HW26SH
         iheaoo4YmSjaooDLrCuydmrcAmJnEEH5h/dKdZ08MeIqYCxl8LXD36juh2Zdk+8snjx9
         4kIlDUQ3wNHEGMD9m9rI+EjnHqES0YEoE5M/Sn1uRfE2UaLgS2VdBVrP2zEB32fKJhJZ
         ww2j8Ipjir3O9XtQPX0Y+To37Z4+RrInULXTSj/86pvfdZkx09UrCTKM14EAWo4yRvid
         Ut7oZ/2iinNcZqmf/tuAq5v8yTSCGqBOd1Q/6GbUyZoMTw173t+935wR8xs46NMJm2Ve
         Dx4A==
X-Gm-Message-State: ACgBeo2tozzBqgBEPCqR1LrZiAAH4gFrsDRtUfayjc70gCE7Uo9yyZDs
        yE98zfq5LlkUJAR+fbxs0tS8NqchYRz5DB44e9kWDBEojv8Sock8jeZp+m/CmRUJH6ESM2DzGYE
        dwXMA9QcMynVGfJvvj3gSXXV/
X-Received: by 2002:a05:6402:3550:b0:451:473a:5ca3 with SMTP id f16-20020a056402355000b00451473a5ca3mr131144edd.48.1662753061128;
        Fri, 09 Sep 2022 12:51:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5Vso8bpKVMDO699EX9vhB/cW1yiElo/He9QsG0equOmtqcamWmkHiyBfP7TFutBfDAmBTBaw==
X-Received: by 2002:a05:6402:3550:b0:451:473a:5ca3 with SMTP id f16-20020a056402355000b00451473a5ca3mr131133edd.48.1662753060921;
        Fri, 09 Sep 2022 12:51:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id v17-20020aa7d9d1000000b0044f21c69608sm907722eds.10.2022.09.09.12.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 12:51:00 -0700 (PDT)
Message-ID: <574909f0-09c2-9d41-96a0-37315f4bd81d@redhat.com>
Date:   Fri, 9 Sep 2022 21:50:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [pdx86-platform-drivers-x86:review-hans 59/65]
 drivers/platform/x86/toshiba_acpi.c:2937:9: warning: no previous prototype
 for 'toshiba_acpi_hwmon_is_visible'
Content-Language: en-US
To:     Arvid Norlander <lkml@vorpal.se>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <202209100300.LjCie4bn-lkp@intel.com>
 <695c3c05-d6c9-8717-4cca-2119542f2f43@vorpal.se>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <695c3c05-d6c9-8717-4cca-2119542f2f43@vorpal.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/9/22 21:47, Arvid Norlander wrote:
> Hi,
> 
> On 2022-09-09 21:19, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git review-hans
>> head:   79e8f8235a1686d0656b60cf72f7fda5530ee1cf
>> commit: b5f3665e82591d465357f4a69196f46b3d30e997 [59/65] platform/x86: toshiba_acpi: Add fan RPM reading (hwmon interface)
>> config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220910/202209100300.LjCie4bn-lkp@intel.com/config)
>> compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
>> reproduce (this is a W=1 build):
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=b5f3665e82591d465357f4a69196f46b3d30e997
>>         git remote add pdx86-platform-drivers-x86 https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
>>         git fetch --no-tags pdx86-platform-drivers-x86 review-hans
>>         git checkout b5f3665e82591d465357f4a69196f46b3d30e997
>>         # save the config file
>>         mkdir build_dir && cp config build_dir/.config
>>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/
>>
>> If you fix the issue, kindly add following tag where applicable
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> drivers/platform/x86/toshiba_acpi.c:2937:9: warning: no previous prototype for 'toshiba_acpi_hwmon_is_visible' [-Wmissing-prototypes]
>>     2937 | umode_t toshiba_acpi_hwmon_is_visible(const void *drvdata,
>>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> drivers/platform/x86/toshiba_acpi.c:2944:5: warning: no previous prototype for 'toshiba_acpi_hwmon_read' [-Wmissing-prototypes]
>>     2944 | int toshiba_acpi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>>          |     ^~~~~~~~~~~~~~~~~~~~~~~
>>
>>
>> vim +/toshiba_acpi_hwmon_is_visible +2937 drivers/platform/x86/toshiba_acpi.c
>>
>>   2934	
>>   2935	/* HWMON support for fan */
>>   2936	#if IS_ENABLED(CONFIG_HWMON)
>>> 2937	umode_t toshiba_acpi_hwmon_is_visible(const void *drvdata,
>>   2938					      enum hwmon_sensor_types type,
>>   2939					      u32 attr, int channel)
>>   2940	{
>>   2941		return 0444;
>>   2942	}
>>   2943	
>>> 2944	int toshiba_acpi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>>   2945				    u32 attr, int channel, long *val)
> 
> Oops, clearly these are missing "static". Hans de Goede: Can you apply that
> fix locally easily, or should I send a patch? I must have forgotten to
> build with W=1.

I can write a fix for this and squash it into the commits in my review-hans branch,
actually i was just about to do that :)

So you can considered this fixed.

Regards,

hans



> 
>>   2946	{
>>   2947		/*
>>   2948		 * There is only a single channel and single attribute (for the
>>   2949		 * fan) at this point.
>>   2950		 * This can be replaced with more advanced logic in the future,
>>   2951		 * should the need arise.
>>   2952		 */
>>   2953		if (type == hwmon_fan && channel == 0 && attr == hwmon_fan_input) {
>>   2954			u32 value;
>>   2955			int ret;
>>   2956	
>>   2957			ret = get_fan_rpm(toshiba_acpi, &value);
>>   2958			if (ret)
>>   2959				return ret;
>>   2960	
>>   2961			*val = value;
>>   2962			return 0;
>>   2963		}
>>   2964		return -EOPNOTSUPP;
>>   2965	}
>>   2966	
>>
> 
> Best regards,
> Arvid Norlander
> 

