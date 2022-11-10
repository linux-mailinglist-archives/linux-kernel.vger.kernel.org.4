Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAB2624D16
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiKJVez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiKJVew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:34:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32D41144A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668116029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7RI5BKz23FmqvQ7VAhYbMyIli/VTPtKGez0QkkgnZ5I=;
        b=TWFRMX6v4UDa6iaOVr80UAB6Bb/AjokwX3lT1dFJf7+2boqq4Bm/7KBSyZQftC92huV3Lh
        AEsEoi2RcBZXWfZTaJMLexKAlAnOOMD157k3x4gCpR9FnZXDO+ZDW8n5u2R+qoXWmxaqhB
        vWQIwMh2wJfLOlUDX4gOdGSxPKEaI/4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-396-gZWmTxXsOU-KqQL6PabCgw-1; Thu, 10 Nov 2022 16:33:47 -0500
X-MC-Unique: gZWmTxXsOU-KqQL6PabCgw-1
Received: by mail-ed1-f72.google.com with SMTP id f17-20020a056402355100b00466481256f6so2312178edd.19
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:33:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RI5BKz23FmqvQ7VAhYbMyIli/VTPtKGez0QkkgnZ5I=;
        b=AnzFSBfebh3Ud85UaxsNrdK7F8CHM94nFUWUpMUgdnEqnv/T5ANhg3h132v8p0g+A+
         x2iEUfZSW365yXSkm6viliWWsIfhI9H4anIZVkA2LHYlnWHYS92HSNcT/eURk3PGNeng
         eOrSKgQMboYfYOF4e8SCjv7f3gNCsxVkHawLadkhEeGPFSySFLkTDYJWAULAZ+xwZ075
         lc/C/9VtRRA97QBu2InuplCc0KyLwxy5SZiEqf+iiwy3cAXi7P5vGuQQFhTopPqYekvf
         GBFvJ83S9AwgPZR0IbGIKXagLB3WYOlutqBA01iduTPfE5htTLsu/yXVna/EzTRGFPM9
         WoAQ==
X-Gm-Message-State: ACrzQf2S/WV8YCdHD02O3wV/0+zt6mK1XqSXt2cnDd/M/n3No8RK7vkv
        gLPCNgkNzj9EyhFdJIc0vmHmfhZToa/y5IvHiXiWMOziGWoDIGUMnSpaxKla06uoDseGF13SlZh
        kfzuKDYIgLANiEmyM/rM8czBP
X-Received: by 2002:a50:d6c2:0:b0:457:791d:8348 with SMTP id l2-20020a50d6c2000000b00457791d8348mr3599534edj.306.1668116026180;
        Thu, 10 Nov 2022 13:33:46 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5LdE7ke0gG0B+K9EaDdQ0GkBpuzo73ltN3fDfUFNvNYFmDeFqfNt6r2Qa8Xl1i09cGVyjVYg==
X-Received: by 2002:a50:d6c2:0:b0:457:791d:8348 with SMTP id l2-20020a50d6c2000000b00457791d8348mr3599511edj.306.1668116025980;
        Thu, 10 Nov 2022 13:33:45 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id o5-20020a056402038500b004619f024864sm284825edv.81.2022.11.10.13.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 13:33:45 -0800 (PST)
Message-ID: <d60c475e-89c2-37e1-15f6-502598f36156@redhat.com>
Date:   Thu, 10 Nov 2022 22:33:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 13/14] Documentation/ABI: Update IFS ABI doc
Content-Language: en-US, nl
To:     Jithu Joseph <jithu.joseph@intel.com>, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, thiago.macieira@intel.com,
        athenas.jimenez.gonzalez@intel.com, sohil.mehta@intel.com
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-14-jithu.joseph@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221107225323.2733518-14-jithu.joseph@intel.com>
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

On 11/7/22 23:53, Jithu Joseph wrote:
> Remove reload documentation and add current_batch documentation.
> Update the kernel version and date for all the entries.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  .../ABI/testing/sysfs-platform-intel-ifs      | 30 ++++++++++---------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-intel-ifs b/Documentation/ABI/testing/sysfs-platform-intel-ifs
> index 486d6d2ff8a0..f74df3abee57 100644
> --- a/Documentation/ABI/testing/sysfs-platform-intel-ifs
> +++ b/Documentation/ABI/testing/sysfs-platform-intel-ifs
> @@ -1,39 +1,41 @@
>  What:		/sys/devices/virtual/misc/intel_ifs_<N>/run_test
> -Date:		April 21 2022
> -KernelVersion:	5.19
> +Date:		Sept 30 2022
> +KernelVersion:	6.2
>  Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
>  Description:	Write <cpu#> to trigger IFS test for one online core.
>  		Note that the test is per core. The cpu# can be
>  		for any thread on the core. Running on one thread
>  		completes the test for the core containing that thread.
>  		Example: to test the core containing cpu5: echo 5 >
> -		/sys/devices/platform/intel_ifs.<N>/run_test
> +		/sys/devices/virtual/misc/intel_ifs_<N>/run_test
>  
>  What:		/sys/devices/virtual/misc/intel_ifs_<N>/status
> -Date:		April 21 2022
> -KernelVersion:	5.19
> +Date:		Sept 30 2022
> +KernelVersion:	6.2
>  Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
>  Description:	The status of the last test. It can be one of "pass", "fail"
>  		or "untested".
>  
>  What:		/sys/devices/virtual/misc/intel_ifs_<N>/details
> -Date:		April 21 2022
> -KernelVersion:	5.19
> +Date:		Sept 30 2022
> +KernelVersion:	6.2
>  Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
>  Description:	Additional information regarding the last test. The details file reports
>  		the hex value of the SCAN_STATUS MSR. Note that the error_code field
>  		may contain driver defined software code not defined in the Intel SDM.
>  
>  What:		/sys/devices/virtual/misc/intel_ifs_<N>/image_version
> -Date:		April 21 2022
> -KernelVersion:	5.19
> +Date:		Sept 30 2022
> +KernelVersion:	6.2
>  Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
>  Description:	Version (hexadecimal) of loaded IFS binary image. If no scan image
>  		is loaded reports "none".
>  
> -What:		/sys/devices/virtual/misc/intel_ifs_<N>/reload
> -Date:		April 21 2022
> -KernelVersion:	5.19
> +What:		/sys/devices/virtual/misc/intel_ifs_<N>/current_batch
> +Date:		Sept 30 2022
> +KernelVersion:	6.2
>  Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
> -Description:	Write "1" (or "y" or "Y") to reload the IFS image from
> -		/lib/firmware/intel/ifs/ff-mm-ss.scan.
> +Description:	Write a number less than or equal to 0xff to load an IFS test image.
> +		The number written treated as the 2 digit suffix in the following file name:
> +		/lib/firmware/intel/ifs_<N>/ff-mm-ss-02x.scan
> +		Reading the file will provide the suffix of the currently loaded IFS test image.

