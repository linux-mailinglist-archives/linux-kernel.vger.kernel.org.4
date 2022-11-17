Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF7962E69B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240658AbiKQVPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbiKQVO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:14:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AD513D6A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668719640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CYKL+6rrRc5GVtwh++2sB1/roBLPi3DO0Ubr0DLuNSA=;
        b=Rm3qjzWHgI8SSohtuzRQ+i4tCdE6dKpf4Y7rxI1f6PJVvEJPGccnFy1w5CrBKHIPLWx6qb
        i8LJC72OcV9vfOhbnwPZaZpR7Zju5quZpXVAgC0HRgAx2ukuwUeRMjxjvxl66tsagQkteq
        yBwxaU59cTigA6WwCOUa2UuKwym3KfM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-564-D7dFNhTiMqGMRWlEZ0uzoQ-1; Thu, 17 Nov 2022 16:13:59 -0500
X-MC-Unique: D7dFNhTiMqGMRWlEZ0uzoQ-1
Received: by mail-ej1-f72.google.com with SMTP id nc4-20020a1709071c0400b0078a5ceb571bso1765643ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:13:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYKL+6rrRc5GVtwh++2sB1/roBLPi3DO0Ubr0DLuNSA=;
        b=IEaDEtwWkJ/l6A4f/o9xI7jTAL3HeJ2TOb6PTgzm0Spvd721vSXVx/3bukO9iyPEci
         jTQSLOGWgOGq76eYwDh6PCNFP3IRsFCJ8MCt9ghvWakaa+MGnN+WbpU/16C1SvmefRzV
         lJQcsK+mXNY40edMzzdD2HVg6ljCr0NxQI3A6L0k3vTskygvmRvMViRVBkfAhtK0ywu4
         ySXeIjYcQH3bgzXXiORHnNEbY/4fhBxgDSDUjA+7MLtMymhUARFIARR3pA2/l0aGg2KA
         +Tx3sbHPf2txDDcjBRBtuqu6nrTvdJ3iYZ+FNgp23+wTn0ZHb9w6hkcJYCpatlOkSWj6
         m16g==
X-Gm-Message-State: ANoB5pmGAelyqPNUp+Zxz8qjE0HJibSD3pE02apynyINTKI5QFXs1qPk
        v/rGGUk6XbaM6UHNqKnxcvWWxEsQ6OS3jwwkwn5d+WXa7M7HCaziP2xBDKBbij+TIGZXju/f8H0
        /H9XNKM8CkKhmdTfRJLJeKmpX
X-Received: by 2002:a17:906:3c4d:b0:78d:f2d8:4623 with SMTP id i13-20020a1709063c4d00b0078df2d84623mr3762446ejg.274.1668719638059;
        Thu, 17 Nov 2022 13:13:58 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7IpvHWtK/azxuoQv2CclLwTDexK4tJ0QY5dLrjUQoKQkCXDyR+d+2VdUNORz3sBfjtgOXcIg==
X-Received: by 2002:a17:906:3c4d:b0:78d:f2d8:4623 with SMTP id i13-20020a1709063c4d00b0078df2d84623mr3762421ejg.274.1668719637865;
        Thu, 17 Nov 2022 13:13:57 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id x7-20020aa7d6c7000000b004623028c594sm990066edr.49.2022.11.17.13.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 13:13:57 -0800 (PST)
Message-ID: <75da80a5-f727-2ef2-f0f5-939cce9b2b87@redhat.com>
Date:   Thu, 17 Nov 2022 22:13:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 04/16] platform/x86/intel/ifs: Remove memory allocation
 from load path
To:     Jithu Joseph <jithu.joseph@intel.com>, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, thiago.macieira@intel.com,
        athenas.jimenez.gonzalez@intel.com, sohil.mehta@intel.com
References: <c7414e8b-c113-eff8-b435-ddde705a6f6c@redhat.com>
 <20221117195957.28225-1-jithu.joseph@intel.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221117195957.28225-1-jithu.joseph@intel.com>
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

On 11/17/22 20:59, Jithu Joseph wrote:
> IFS requires tests to be authenticated once for each CPU socket
> on a system.
> 
> scan_chunks_sanity_check() was dynamically allocating memory
> to store the state of whether tests have been authenticated on
> each socket for every load operation.
> 
> Move the memory allocation to init path and store the pointer
> in ifs_data struct.
> 
> Also rearrange the adjacent error checking in init for a
> more simplified and natural flow.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> ---
>  - Replaced global pkg_auth pointer to struct ifs_data (Hans)
>  - Rearrange the adjacent error checking flow in ifs_init (Hans)
>  - With this change there are conflicts in patches 11 and 12 (I will
>     post the updated 11 and 12 if this is satisfactory)

Thanks, this patch looks good to me now:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> 
>  drivers/platform/x86/intel/ifs/ifs.h  |  2 ++
>  drivers/platform/x86/intel/ifs/core.c | 20 ++++++++++++++++----
>  drivers/platform/x86/intel/ifs/load.c | 14 ++++----------
>  3 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> index 3ff1d9aaeaa9..8de1952a1b7b 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -191,6 +191,7 @@ union ifs_status {
>   * struct ifs_data - attributes related to intel IFS driver
>   * @integrity_cap_bit: MSR_INTEGRITY_CAPS bit enumerating this test
>   * @loaded_version: stores the currently loaded ifs image version.
> + * @pkg_auth: array of bool storing per package auth status
>   * @loaded: If a valid test binary has been loaded into the memory
>   * @loading_error: Error occurred on another CPU while loading image
>   * @valid_chunks: number of chunks which could be validated.
> @@ -199,6 +200,7 @@ union ifs_status {
>   */
>  struct ifs_data {
>  	int	integrity_cap_bit;
> +	bool	*pkg_auth;
>  	int	loaded_version;
>  	bool	loaded;
>  	bool	loading_error;
> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
> index 5fb7f655c291..943eb2a17c64 100644
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
> @@ -34,6 +35,7 @@ static int __init ifs_init(void)
>  {
>  	const struct x86_cpu_id *m;
>  	u64 msrval;
> +	int ret;
>  
>  	m = x86_match_cpu(ifs_cpu_ids);
>  	if (!m)
> @@ -50,16 +52,26 @@ static int __init ifs_init(void)
>  
>  	ifs_device.misc.groups = ifs_get_groups();
>  
> -	if ((msrval & BIT(ifs_device.data.integrity_cap_bit)) &&
> -	    !misc_register(&ifs_device.misc))
> -		return 0;
> +	if (!(msrval & BIT(ifs_device.data.integrity_cap_bit)))
> +		return -ENODEV;
> +
> +	ifs_device.data.pkg_auth = kmalloc_array(topology_max_packages(), sizeof(bool), GFP_KERNEL);
> +	if (!ifs_device.data.pkg_auth)
> +		return -ENOMEM;
> +
> +	ret = misc_register(&ifs_device.misc);
> +	if (ret) {
> +		kfree(ifs_device.data.pkg_auth);
> +		return ret;
> +	}
>  
> -	return -ENODEV;
> +	return 0;
>  }
>  
>  static void __exit ifs_exit(void)
>  {
>  	misc_deregister(&ifs_device.misc);
> +	kfree(ifs_device.data.pkg_auth);
>  }
>  
>  module_init(ifs_init);
> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
> index 89ce265887ea..8423c486d11b 100644
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
> +	memset(ifsd->pkg_auth, 0, (topology_max_packages() * sizeof(bool)));
>  	metadata_size = ifs_header_ptr->metadata_size;
>  
>  	/* Spec says that if the Meta Data Size = 0 then it should be treated as 2000 */
> @@ -150,7 +145,7 @@ static int scan_chunks_sanity_check(struct device *dev)
>  	cpus_read_lock();
>  	for_each_online_cpu(cpu) {
>  		curr_pkg = topology_physical_package_id(cpu);
> -		if (package_authenticated[curr_pkg])
> +		if (ifsd->pkg_auth[curr_pkg])
>  			continue;
>  		reinit_completion(&ifs_done);
>  		local_work.dev = dev;
> @@ -161,12 +156,11 @@ static int scan_chunks_sanity_check(struct device *dev)
>  			ret = -EIO;
>  			goto out;
>  		}
> -		package_authenticated[curr_pkg] = 1;
> +		ifsd->pkg_auth[curr_pkg] = 1;
>  	}
>  	ret = 0;
>  out:
>  	cpus_read_unlock();
> -	kfree(package_authenticated);
>  
>  	return ret;
>  }

