Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE0062D585
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbiKQIwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbiKQIwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:52:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676272BF1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668675094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Myyg+bLdQelD4D9kVUB3s2sr8LVncKivkUt152IISU=;
        b=a2sGszdLYLEoU0zVjpjv/YhLb03AazPQUqjE1DPsP2Md/7HpYlp7jrY5Q5Y0ReKl8jYYy8
        W06lP+AK9qBVu0H1c1zpRBiQ4HHUJDNeCqmBZMO0m4tM1yWjYcRcLpgMMBqaMmkasgyUOW
        dgNU5LiIS/LKiZKHb5qd5J6nuxoVvIs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-524-B4QBw-jOPBiFSGulc8MLXw-1; Thu, 17 Nov 2022 03:51:33 -0500
X-MC-Unique: B4QBw-jOPBiFSGulc8MLXw-1
Received: by mail-ed1-f69.google.com with SMTP id z9-20020a05640235c900b0046358415c4fso783304edc.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:51:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Myyg+bLdQelD4D9kVUB3s2sr8LVncKivkUt152IISU=;
        b=hldrKVu6KxkOBAkGWpZHZmF/NTlPArzOCjwW862SU5g09Bh6ovFL9d9YGBckqICD1z
         X2mYVBqSNini3DWQ5FNMTj5RVzZGpBcGU4ib+treJQgh50Np8UXVCqMXkjxFNDUPQqRF
         CPpvjActMGrpMF3UW40H5lMSzbHUBFZtVOTuWTd1GkSDV7gcrBiCmarLsYcDjh+pqpko
         FA2eNC97oNaMkO9wfu23CLDWjEja3DP7MUQQ7bUNzzAnneQDD2ZsNxIj73R+iNDjTmU6
         7UqPKb2/59rhYCm6ypKGZaTv6mImmfuY2LkV1jfAGTSSaQjgbGC6bvZdyNlCnNAGVa2F
         OGPA==
X-Gm-Message-State: ANoB5pmBiwlkSlu7AUtTmdCv7TilgCGyKkzAbp5+TVAGXxL9ZShz0TiX
        hWkD+BI7FpwVee6qWc8GKlGVcT3v5iT+S1fBHyo7cXX6GRs3kN5vvlE/fdxgs7OpXK1gwLBfjUv
        B6bu+qt3/drTQlfHdvXant1Sf
X-Received: by 2002:aa7:d8ca:0:b0:463:4dd8:d6ea with SMTP id k10-20020aa7d8ca000000b004634dd8d6eamr1288377eds.426.1668675092079;
        Thu, 17 Nov 2022 00:51:32 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4AbtghDuouRfYwOLZ7J+FiQixeQt31XlxfhiSlzeSAYIlyHGD8PPjDd5Mjma+532HHuV7GAw==
X-Received: by 2002:aa7:d8ca:0:b0:463:4dd8:d6ea with SMTP id k10-20020aa7d8ca000000b004634dd8d6eamr1288357eds.426.1668675091923;
        Thu, 17 Nov 2022 00:51:31 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709061da900b007317f017e64sm73516ejh.134.2022.11.17.00.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 00:51:31 -0800 (PST)
Message-ID: <77e9d0f2-12d9-fc7a-2161-c579b7bbd673@redhat.com>
Date:   Thu, 17 Nov 2022 09:51:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 04/16] platform/x86/intel/ifs: Remove memory allocation
 from load path
Content-Language: en-US, nl
To:     Jithu Joseph <jithu.joseph@intel.com>, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, thiago.macieira@intel.com,
        athenas.jimenez.gonzalez@intel.com, sohil.mehta@intel.com
References: <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221117035935.4136738-1-jithu.joseph@intel.com>
 <20221117035935.4136738-5-jithu.joseph@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221117035935.4136738-5-jithu.joseph@intel.com>
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

On 11/17/22 04:59, Jithu Joseph wrote:
> IFS requires tests to be authenticated once for each CPU socket
> on a system.
> 
> scan_chunks_sanity_check() was dynamically allocating memory
> to store the state of whether tests have been authenticated on
> each socket for every load operation.
> 
> Move the memory allocation to init path.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/ifs.h  |  2 ++
>  drivers/platform/x86/intel/ifs/core.c | 13 +++++++++++--
>  drivers/platform/x86/intel/ifs/load.c | 14 ++++----------
>  3 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> index 3ff1d9aaeaa9..3a051890d9e7 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -229,4 +229,6 @@ void ifs_load_firmware(struct device *dev);
>  int do_core_test(int cpu, struct device *dev);
>  const struct attribute_group **ifs_get_groups(void);
>  
> +extern bool *ifs_pkg_auth;
> +

This is not necessary and ugly, nack for this patch as-is (sorry).

You can simply add this pointer to "struct ifs_data" and then
alloc it in ifs_init() before the misc_register call.

scan_chunks_sanity_check() already has a "struct ifs_data *ifsd",
so it can easily access ifs_pkg_auth through that when you make
ifs_pkg_auth part of "struct ifs_data".

Regards,

Hans
\


>  #endif
> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
> index 5fb7f655c291..4b39f2359180 100644
> --- a/drivers/platform/x86/intel/ifs/core.c
> +++ b/drivers/platform/x86/intel/ifs/core.c
> @@ -4,6 +4,7 @@
>  #include <linux/module.h>
>  #include <linux/kdev_t.h>
>  #include <linux/semaphore.h>
> +#include <linux/slab.h>
>  
>  #include <asm/cpu_device_id.h>
>  
> @@ -30,6 +31,8 @@ static struct ifs_device ifs_device = {
>  	},
>  };
>  
> +bool *ifs_pkg_auth;
> +
>  static int __init ifs_init(void)
>  {
>  	const struct x86_cpu_id *m;
> @@ -51,8 +54,13 @@ static int __init ifs_init(void)
>  	ifs_device.misc.groups = ifs_get_groups();
>  
>  	if ((msrval & BIT(ifs_device.data.integrity_cap_bit)) &&
> -	    !misc_register(&ifs_device.misc))
> -		return 0;
> +	    !misc_register(&ifs_device.misc)) {
> +		ifs_pkg_auth = kmalloc_array(topology_max_packages(), sizeof(bool), GFP_KERNEL);
> +		if (!ifs_pkg_auth)
> +			return -ENOMEM;
> +		else
> +			return 0;
> +	}
>  
>  	return -ENODEV;
>  }
> @@ -60,6 +68,7 @@ static int __init ifs_init(void)
>  static void __exit ifs_exit(void)
>  {
>  	misc_deregister(&ifs_device.misc);
> +	kfree(ifs_pkg_auth);
>  }
>  
>  module_init(ifs_init);
> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
> index 89ce265887ea..c914e4d359db 100644
> --- a/drivers/platform/x86/intel/ifs/load.c
> +++ b/drivers/platform/x86/intel/ifs/load.c
> @@ -3,7 +3,6 @@
>  
>  #include <linux/firmware.h>
>  #include <asm/cpu.h>
> -#include <linux/slab.h>
>  #include <asm/microcode_intel.h>
>  
>  #include "ifs.h"
> @@ -118,16 +117,12 @@ static void copy_hashes_authenticate_chunks(struct work_struct *work)
>   */
>  static int scan_chunks_sanity_check(struct device *dev)
>  {
> -	int metadata_size, curr_pkg, cpu, ret = -ENOMEM;
> +	int metadata_size, curr_pkg, cpu, ret;
>  	struct ifs_data *ifsd = ifs_get_data(dev);
> -	bool *package_authenticated;
>  	struct ifs_work local_work;
>  	char *test_ptr;
>  
> -	package_authenticated = kcalloc(topology_max_packages(), sizeof(bool), GFP_KERNEL);
> -	if (!package_authenticated)
> -		return ret;
> -
> +	memset(ifs_pkg_auth, 0, (topology_max_packages() * sizeof(bool)));
>  	metadata_size = ifs_header_ptr->metadata_size;
>  
>  	/* Spec says that if the Meta Data Size = 0 then it should be treated as 2000 */
> @@ -150,7 +145,7 @@ static int scan_chunks_sanity_check(struct device *dev)
>  	cpus_read_lock();
>  	for_each_online_cpu(cpu) {
>  		curr_pkg = topology_physical_package_id(cpu);
> -		if (package_authenticated[curr_pkg])
> +		if (ifs_pkg_auth[curr_pkg])
>  			continue;
>  		reinit_completion(&ifs_done);
>  		local_work.dev = dev;
> @@ -161,12 +156,11 @@ static int scan_chunks_sanity_check(struct device *dev)
>  			ret = -EIO;
>  			goto out;
>  		}
> -		package_authenticated[curr_pkg] = 1;
> +		ifs_pkg_auth[curr_pkg] = 1;
>  	}
>  	ret = 0;
>  out:
>  	cpus_read_unlock();
> -	kfree(package_authenticated);
>  
>  	return ret;
>  }

