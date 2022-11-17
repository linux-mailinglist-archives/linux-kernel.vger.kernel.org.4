Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1501C62E3AF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240272AbiKQSCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbiKQSCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:02:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2DD7FC20
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668708079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HWUPnZjpAAiyG7WtckU2rsuHVVx+xGUGdmvEJKTgSfg=;
        b=JQmPL0kb3dPa9sF9VTkz3C4F81Lq+ud1vc6pACGmz1zVvVWC4cZXZ6wJclzylHaL4GELmj
        I+eOLXOiWL6LY9s3cK+BE0k8vBNAE2ba7Duk9cl5fPlQJI58lobTOMV9HbYiUrxc/2lf+c
        qkYcQgKmg/KKuftUWp6UCKmQwFRPbjk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-296-OpTRnOumNGKQ0dH9aDptnA-1; Thu, 17 Nov 2022 13:01:18 -0500
X-MC-Unique: OpTRnOumNGKQ0dH9aDptnA-1
Received: by mail-ej1-f71.google.com with SMTP id dn14-20020a17090794ce00b007ae5d040ca8so1525778ejc.17
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:01:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HWUPnZjpAAiyG7WtckU2rsuHVVx+xGUGdmvEJKTgSfg=;
        b=e0eWvgJPJbSDE69+SRUteYUkDWWocovHmGfLfZkEnKqV5Ip3ji79o5iAnisXelNs6y
         KVNfWyu3vBtdQIqB4TN9y6S34+Rdg7yf56NTIosURNjKJxobkHYVYA7dUnZNcDcmn170
         hBonWTgil/ZVW+WfwMWGCbJTu/Z+PlQ5mupbQ5GbK7TJR6YrAiC1m0UwDrsT3SAhwlWp
         5xr47psqYZwKLsiTDW0j5Lelaa8fm6ZaOt/VkJFvBgOI7NgnJKWm1vOWwXbczobDeJs/
         ocH+aFOn8MIW80EF49AymWAOJGPCArhugpf5XtehLCIxgfCUva1u9x1mRBY2Pa1z1kzp
         ROAQ==
X-Gm-Message-State: ANoB5pkrUHQe7Fm56WrtQvGKsxDScYSnu4/ddzEspQFQZlsHVMtSajxv
        hBq2/Z7epS74ezmG55fo8drj3pha8wGEwQxmRai7E1fRK61A0Wf0PbfbJalCoKbFBwxZgNnY1J6
        0yIHOQPkQIYdroAlacqDK5IYB
X-Received: by 2002:a05:6402:388e:b0:468:fb0d:2d8b with SMTP id fd14-20020a056402388e00b00468fb0d2d8bmr1299752edb.124.1668708076561;
        Thu, 17 Nov 2022 10:01:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5sDdSnb1q5z/1hVRdNRsWV26PsKbc/HV7QuBMYEclJnt3H9XCU+Is9uh8bSS79OjtqPxKCQQ==
X-Received: by 2002:a05:6402:388e:b0:468:fb0d:2d8b with SMTP id fd14-20020a056402388e00b00468fb0d2d8bmr1299692edb.124.1668708075973;
        Thu, 17 Nov 2022 10:01:15 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id l4-20020aa7cac4000000b00461bacee867sm819311edt.25.2022.11.17.10.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 10:01:15 -0800 (PST)
Message-ID: <c7414e8b-c113-eff8-b435-ddde705a6f6c@redhat.com>
Date:   Thu, 17 Nov 2022 19:01:14 +0100
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
References: <77e9d0f2-12d9-fc7a-2161-c579b7bbd673@redhat.com>
 <20221117172958.4172029-1-jithu.joseph@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221117172958.4172029-1-jithu.joseph@intel.com>
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

Hi Jithu,

On 11/17/22 18:29, Jithu Joseph wrote:
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
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> ---
>  - Replaced global pkg_auth pointer to struct ifs_data (Hans)
>  - With this change there are conflicts in patches 11 and 12 (I will
>     post the updated 11 and 12 if this is satisfactory)
> 
>  drivers/platform/x86/intel/ifs/ifs.h  |  2 ++
>  drivers/platform/x86/intel/ifs/core.c | 12 ++++++++++--
>  drivers/platform/x86/intel/ifs/load.c | 14 ++++----------
>  3 files changed, 16 insertions(+), 12 deletions(-)
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
> index 5fb7f655c291..6980a31e9786 100644
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
> @@ -51,8 +52,14 @@ static int __init ifs_init(void)
>  	ifs_device.misc.groups = ifs_get_groups();
>  
>  	if ((msrval & BIT(ifs_device.data.integrity_cap_bit)) &&
> -	    !misc_register(&ifs_device.misc))
> -		return 0;
> +	    !misc_register(&ifs_device.misc)) {
> +		ifs_device.data.pkg_auth = kmalloc_array(topology_max_packages(),
> +							 sizeof(bool), GFP_KERNEL);

Thank you for the new version, but as I mentioned in my review, this kmalloc
must be done *before* the misc_register(&ifs_device.misc), because as soon
as that is done the other code may get triggered creating a race condition.

More in general && the misc_register to gether with the integrity_cap_bit
is not really nice. If someone does not pay close attention they may
mis that the check of the if has the pretty big side-effect of
registering the actual misc device.

Generally speaking test-conditions for if-s should not have side
effects if possible.

> +		if (!ifs_device.data.pkg_auth)
> +			return -ENOMEM;
> +		else
> +			return 0;
> +	}
>  
>  	return -ENODEV;
>  }

This also makes me realize that you have your -ENODEV error exit and
your normal success exit paths switched around from what is normal.

Why not just write the above as (can be done as part of this
patch since you need to touch it all anyways):

	if (!(msrval & BIT(ifs_device.data.integrity_cap_bit))
		return -ENODEV;

	ifs_device.data.pkg_auth = kmalloc_array(topology_max_packages(), sizeof(bool), GFP_KERNEL);
	if (!ifs_device.data.pkg_auth)
		return -ENOMEM

	ret = misc_register(&ifs_device.misc);
	if (ret) {
		kfree(ifs_device.data.pkg_auth);
		return ret;
	}

	return 0;
}

That makes this all look much more like a normal probe() function
with the success 0 return at the end.

Where as your version has the success 0 return nested 2 levels
deep in the else of a kmalloc() error check...

Regards,

Hans



> @@ -60,6 +67,7 @@ static int __init ifs_init(void)
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

