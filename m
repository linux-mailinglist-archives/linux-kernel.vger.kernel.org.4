Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A846B7AD0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjCMOrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjCMOrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:47:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6BF60D6E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678718777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q8FnhFWhsWcQReYEr7jTipBhtAk4faTQb7wPHi4ycFw=;
        b=HOsvMqFmkefnpSsJ0aw1SNnaLU0F291OmH3w93i3CFT2NxECgTtLcuIfRHnH2Pl4fseaJ+
        v8HImeQNWvynjzxcJkWOOjeWECLnbFxM7x7yqfYjBx8T2PTwTUC+QJqNOOXppNyzhldmei
        g9PN7jf7Wn3BXwyzC2xjHt0B8oyF/cA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-G5F-j_ORNUykaiDgnjHwiA-1; Mon, 13 Mar 2023 10:46:16 -0400
X-MC-Unique: G5F-j_ORNUykaiDgnjHwiA-1
Received: by mail-ed1-f70.google.com with SMTP id fi8-20020a056402550800b004a26cc7f6cbso17307295edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678718775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q8FnhFWhsWcQReYEr7jTipBhtAk4faTQb7wPHi4ycFw=;
        b=eE4Fy7xuenMvnStNdKEjNGTqi+MZCbY7nW0WyShMoX4FaVvTh4kaHqR9hVqNzeXhM2
         lEOfgv053eJBYfB5PwFQ7M7QzMpOSPxmgFvEKNbf7I7hKkUEC0tiWN9EbFbPoJVMZ0+L
         HK1bKYdmvHM2r7+64fdhDmFrH+RKd34yB4WLlT+M9XAvw1JiXxbO4DXi03SZvs+FeZ0x
         gUdL2Jiw9EpGdtpDm24Co2zjDxyhzbvPLnjF03X+UkBfStwRCsb05dneXIHOy1MQuMsH
         6XFJmdG8QrD+fGCCwSCVg4MrKRoshiSEipogmkgaiRilg9G8GowY+eB9jUiNzSOoGmCU
         1w7g==
X-Gm-Message-State: AO0yUKXvanpB2PLayv9hnPofqsSrqaIolpCaUuNxDEIJS0WYHH00sdOj
        2GUzULthqFkifZG1HAvPhCfDgw2j0M6/aN8q5mLyJcvZAphFz1eUJ5iQkgx0DJHTIhEsri64zSK
        vbvzUdOH08wCTnoBsfIfOrT2r
X-Received: by 2002:a17:907:2beb:b0:921:5cce:6599 with SMTP id gv43-20020a1709072beb00b009215cce6599mr6627237ejc.41.1678718774934;
        Mon, 13 Mar 2023 07:46:14 -0700 (PDT)
X-Google-Smtp-Source: AK7set9mWKhtvFCDOfwoqyOCMDtxZp3GkDaz+ur2PErEi3oBFcgfP69Um9N3lOdwHyLX8448a9pzCA==
X-Received: by 2002:a17:907:2beb:b0:921:5cce:6599 with SMTP id gv43-20020a1709072beb00b009215cce6599mr6627192ejc.41.1678718774607;
        Mon, 13 Mar 2023 07:46:14 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id gx3-20020a1709068a4300b009200601ea12sm3298802ejc.208.2023.03.13.07.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 07:46:13 -0700 (PDT)
Message-ID: <a6ae936e-effd-3794-e6fb-11b33a4d6eb1@redhat.com>
Date:   Mon, 13 Mar 2023 15:46:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 1/8] platform/x86/intel/ifs: Reorganize driver data
Content-Language: en-US
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
 <20230301015942.462799-2-jithu.joseph@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230301015942.462799-2-jithu.joseph@intel.com>
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

On 3/1/23 02:59, Jithu Joseph wrote:
> The struct holding device driver data contained both read only(ro)
> and read write(rw) fields.
> 
> Separating ro fields from rw fields was recommended as
> a preferable design pattern during review[1].
> 
> Group the rw fields into a separate struct whose memory is allocated
> during driver_init(). Associate it to the miscdevice being registered
> by keeping it in the same container struct as the miscdevice.
> 
> Also in prepration to supporting additional tests, move ifs_pkg_auth
> to a global as it is only applicable for the first test type.

If you are writing "Also ..." into a commit message and the
changes for the "Also ..." are more then a single line change,
then that change really should be split out into a separate patch.

Please split the "move ifs_pkg_auth to a global" changes into their
own separate patch.

> 
> Link: https://lore.kernel.org/lkml/Y+9H9otxLYPqMkUh@kroah.com/ [1]
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/ifs.h  | 19 +++++++++-------
>  drivers/platform/x86/intel/ifs/core.c | 31 ++++++++++++++++++---------
>  drivers/platform/x86/intel/ifs/load.c |  8 +++----
>  3 files changed, 36 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> index 046e39304fd5..e07463c794d4 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -197,22 +197,23 @@ union ifs_status {
>  #define IFS_SW_TIMEOUT				0xFD
>  #define IFS_SW_PARTIAL_COMPLETION		0xFE
>  
> +struct ifs_const_data {
> +	int	integrity_cap_bit;
> +	int	test_num;
> +};
> +

This is a description of the specific capabilties / bits of
the IFS on e.g. Saphire Rapids, so please name this appropriately
for example:

struct ifs_hw_caps  {
	int	integrity_cap_bit;
	int	test_num;
};


>  /**
>   * struct ifs_data - attributes related to intel IFS driver
> - * @integrity_cap_bit: MSR_INTEGRITY_CAPS bit enumerating this test
>   * @loaded_version: stores the currently loaded ifs image version.
> - * @pkg_auth: array of bool storing per package auth status
>   * @loaded: If a valid test binary has been loaded into the memory
>   * @loading_error: Error occurred on another CPU while loading image
>   * @valid_chunks: number of chunks which could be validated.
>   * @status: it holds simple status pass/fail/untested
>   * @scan_details: opaque scan status code from h/w
>   * @cur_batch: number indicating the currently loaded test file
> - * @test_num: number indicating the test type
> + * @ro_info: ptr to struct holding fixed details
>   */
>  struct ifs_data {
> -	int	integrity_cap_bit;
> -	bool	*pkg_auth;
>  	int	loaded_version;
>  	bool	loaded;
>  	bool	loading_error;
> @@ -220,7 +221,7 @@ struct ifs_data {
>  	int	status;
>  	u64	scan_details;
>  	u32	cur_batch;
> -	int	test_num;
> +	struct ifs_const_data *ro_info;
>  };
>  
>  struct ifs_work {
> @@ -229,7 +230,8 @@ struct ifs_work {
>  };
>  
>  struct ifs_device {
> -	struct ifs_data data;
> +	struct ifs_const_data ro_data;
> +	struct ifs_data *rw_data;
>  	struct miscdevice misc;
>  };
>  

You got this exactly the wrong way around, there should be a single

static const struct ifs_hw_caps saphire_rapids_caps = {
	.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
	.test_num = 0,
};

And then struct ifs_device { } should have a "const struct ifs_hw_caps *hw_caps"
which gets initialized to point to &saphire_rapids_caps. So that your const
data is actually const.

Where as since the r/w data's lifetime is couple to the misc-device lifetime
there is no need to dynamically allocate it just keep that embedded, so that
together you get:

struct ifs_device {
	const struct ifs_hw_caps *hw_caps;
	struct ifs_data data;
	struct miscdevice misc;
};

Regards,

Hans


> @@ -238,9 +240,10 @@ static inline struct ifs_data *ifs_get_data(struct device *dev)
>  	struct miscdevice *m = dev_get_drvdata(dev);
>  	struct ifs_device *d = container_of(m, struct ifs_device, misc);
>  
> -	return &d->data;
> +	return d->rw_data;
>  }
>  
> +extern bool *ifs_pkg_auth;
>  int ifs_load_firmware(struct device *dev);
>  int do_core_test(int cpu, struct device *dev);
>  const struct attribute_group **ifs_get_groups(void);
> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
> index 206a617c2e02..b518b661daf0 100644
> --- a/drivers/platform/x86/intel/ifs/core.c
> +++ b/drivers/platform/x86/intel/ifs/core.c
> @@ -20,8 +20,10 @@ static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
>  };
>  MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
>  
> +bool *ifs_pkg_auth;
> +
>  static struct ifs_device ifs_device = {
> -	.data = {
> +	.ro_data = {
>  		.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
>  		.test_num = 0,
>  	},
> @@ -35,8 +37,8 @@ static struct ifs_device ifs_device = {
>  static int __init ifs_init(void)
>  {
>  	const struct x86_cpu_id *m;
> +	struct ifs_data *ifsd;
>  	u64 msrval;
> -	int ret;
>  
>  	m = x86_match_cpu(ifs_cpu_ids);
>  	if (!m)
> @@ -53,26 +55,35 @@ static int __init ifs_init(void)
>  
>  	ifs_device.misc.groups = ifs_get_groups();
>  
> -	if (!(msrval & BIT(ifs_device.data.integrity_cap_bit)))
> +	if (!(msrval & BIT(ifs_device.ro_data.integrity_cap_bit)))
>  		return -ENODEV;
>  
> -	ifs_device.data.pkg_auth = kmalloc_array(topology_max_packages(), sizeof(bool), GFP_KERNEL);
> -	if (!ifs_device.data.pkg_auth)
> +	ifs_pkg_auth = kmalloc_array(topology_max_packages(), sizeof(bool), GFP_KERNEL);
> +	if (!ifs_pkg_auth)
> +		return -ENOMEM;
> +
> +	ifsd = kzalloc(sizeof(*ifsd), GFP_KERNEL);
> +	if (!ifsd)
>  		return -ENOMEM;
>  
> -	ret = misc_register(&ifs_device.misc);
> -	if (ret) {
> -		kfree(ifs_device.data.pkg_auth);
> -		return ret;
> +	ifsd->ro_info = &ifs_device.ro_data;
> +	ifs_device.rw_data = ifsd;
> +
> +	if (misc_register(&ifs_device.misc)) {
> +		kfree(ifsd);
> +		kfree(ifs_pkg_auth);
> +		return -ENODEV;
>  	}
>  
>  	return 0;
> +
>  }
>  
>  static void __exit ifs_exit(void)
>  {
>  	misc_deregister(&ifs_device.misc);
> -	kfree(ifs_device.data.pkg_auth);
> +	kfree(ifs_device.rw_data);
> +	kfree(ifs_pkg_auth);
>  }
>  
>  module_init(ifs_init);
> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
> index c5c24e6fdc43..cdec3316c08d 100644
> --- a/drivers/platform/x86/intel/ifs/load.c
> +++ b/drivers/platform/x86/intel/ifs/load.c
> @@ -192,7 +192,7 @@ static int scan_chunks_sanity_check(struct device *dev)
>  	struct ifs_work local_work;
>  	int curr_pkg, cpu, ret;
>  
> -	memset(ifsd->pkg_auth, 0, (topology_max_packages() * sizeof(bool)));
> +	memset(ifs_pkg_auth, 0, (topology_max_packages() * sizeof(bool)));
>  	ret = validate_ifs_metadata(dev);
>  	if (ret)
>  		return ret;
> @@ -204,7 +204,7 @@ static int scan_chunks_sanity_check(struct device *dev)
>  	cpus_read_lock();
>  	for_each_online_cpu(cpu) {
>  		curr_pkg = topology_physical_package_id(cpu);
> -		if (ifsd->pkg_auth[curr_pkg])
> +		if (ifs_pkg_auth[curr_pkg])
>  			continue;
>  		reinit_completion(&ifs_done);
>  		local_work.dev = dev;
> @@ -215,7 +215,7 @@ static int scan_chunks_sanity_check(struct device *dev)
>  			ret = -EIO;
>  			goto out;
>  		}
> -		ifsd->pkg_auth[curr_pkg] = 1;
> +		ifs_pkg_auth[curr_pkg] = 1;
>  	}
>  	ret = 0;
>  out:
> @@ -263,7 +263,7 @@ int ifs_load_firmware(struct device *dev)
>  	int ret = -EINVAL;
>  
>  	snprintf(scan_path, sizeof(scan_path), "intel/ifs_%d/%02x-%02x-%02x-%02x.scan",
> -		 ifsd->test_num, boot_cpu_data.x86, boot_cpu_data.x86_model,
> +		 ifsd->ro_info->test_num, boot_cpu_data.x86, boot_cpu_data.x86_model,
>  		 boot_cpu_data.x86_stepping, ifsd->cur_batch);
>  
>  	ret = request_firmware_direct(&fw, scan_path, dev);

