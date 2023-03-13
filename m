Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7876B7D36
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjCMQPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjCMQPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:15:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F5257D24
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678724102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ws1SKL/K67zDuXgdbFjDrhPnbdtyJngtDK2xx31A/eo=;
        b=F8buy8nswhl1qZt6tvu0WkEk+HyiznMxLoHsht2LkXBSiOsbVgYEiY8do2JS/5dcfcHpW6
        cfOuQcHf6RGsd/9UU/V+yFy9iuYbzblhR1U9H+93nIh3ODcpfPZp7JwZ3fuJhUVO69PoTC
        R2eWYFtAGKqI44b/+xArqvuqE8ZonFs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-PG0YNYzcNbuhkNhdtM7rzA-1; Mon, 13 Mar 2023 12:15:00 -0400
X-MC-Unique: PG0YNYzcNbuhkNhdtM7rzA-1
Received: by mail-ed1-f72.google.com with SMTP id en6-20020a056402528600b004fa01232e6aso9240764edb.16
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678724099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ws1SKL/K67zDuXgdbFjDrhPnbdtyJngtDK2xx31A/eo=;
        b=Uz7td9y3BY4rBmYbTt8t6KC2gc4QDxXPqmzgNXibSyCro4lQMn6MjWLPY517986iJ+
         x3vhLXmKcPGFipvQI1Jt844I1hraW8VPk9lIia6bl3BY+Ye345MUI6xn2eQ2DxA+6apt
         jMdLiY7j5n81Oh60gOkgY3VGWalv8hEHN/jubgN7POv44VWRoZZ2nCsbv7IQQyMh6Ho1
         Ib7CDkj7vQvZhONDie+IvW59xt4TQfcySG+Aev/1ic8dWiDadtIcqbbWOaLEJFNKPH1Y
         TvzAzq+Pl/vBsUG7phCG8Qv6h6LlJN7JfSzLMbWTPZNT/BRcBpM5iqypgmvA7mqP3MH0
         eYtg==
X-Gm-Message-State: AO0yUKW1QtRY/K+Qm2piyqO2B1GzTrQxckSsYyAGoel9OWwC3CPu5sGe
        XIiU+2VZZ7nT7BQZ0lEXQQfTUSuPbGeEhzEZdFnr3bNpBOwG458gQpMTl6zU07w9zjwsTDxZw1o
        WuLJ69I9xbGRYF2jevxNohp4o
X-Received: by 2002:aa7:db98:0:b0:4fa:3b3:c867 with SMTP id u24-20020aa7db98000000b004fa03b3c867mr8192493edt.17.1678724099084;
        Mon, 13 Mar 2023 09:14:59 -0700 (PDT)
X-Google-Smtp-Source: AK7set+N7kEiDS7l9wQqQd4q23+Cgq+bRflHviOTibCD9K2XjusWKbv0h3GdLd5hJWENNIVJE/OlqA==
X-Received: by 2002:aa7:db98:0:b0:4fa:3b3:c867 with SMTP id u24-20020aa7db98000000b004fa03b3c867mr8192473edt.17.1678724098821;
        Mon, 13 Mar 2023 09:14:58 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id e1-20020a50a681000000b004c06f786602sm3411491edc.85.2023.03.13.09.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 09:14:58 -0700 (PDT)
Message-ID: <7587c722-6bfe-f543-a115-1ebd6f94a678@redhat.com>
Date:   Mon, 13 Mar 2023 17:14:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 5/8] platform/x86/intel/ifs: Sysfs interface for Array
 BIST
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
 <20230301015942.462799-6-jithu.joseph@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230301015942.462799-6-jithu.joseph@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/1/23 02:59, Jithu Joseph wrote:
> The interface to trigger Array BIST test and obtain its result
> is similar to the existing scan test. The only notable
> difference is that, Array BIST doesn't require any test content
> to be loaded. So binary load related options are not needed for
> this test.
> 
> Add sysfs interface for array BIST test, the testing support will
> be added by subsequent patch.
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/ifs.h     |  1 +
>  drivers/platform/x86/intel/ifs/core.c    |  2 ++
>  drivers/platform/x86/intel/ifs/runtest.c | 10 +++++++++-
>  drivers/platform/x86/intel/ifs/sysfs.c   | 10 +++++++++-
>  4 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> index b8b956e29653..f31966e291df 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -250,5 +250,6 @@ extern bool *ifs_pkg_auth;
>  int ifs_load_firmware(struct device *dev);
>  int do_core_test(int cpu, struct device *dev);
>  extern struct attribute *plat_ifs_attrs[];
> +extern struct attribute *plat_ifs_array_attrs[];
>  
>  #endif
> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
> index 2237aaba7078..c74accedfc8d 100644
> --- a/drivers/platform/x86/intel/ifs/core.c
> +++ b/drivers/platform/x86/intel/ifs/core.c
> @@ -22,6 +22,7 @@ static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
>  MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
>  
>  ATTRIBUTE_GROUPS(plat_ifs);
> +ATTRIBUTE_GROUPS(plat_ifs_array);
>  
>  bool *ifs_pkg_auth;
>  
> @@ -45,6 +46,7 @@ static struct ifs_device ifs_devices[] = {
>  		.misc = {
>  			.name = "intel_ifs_1",
>  			.minor = MISC_DYNAMIC_MINOR,
> +			.groups = plat_ifs_array_groups,
>  		},
>  	},
>  };
> diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
> index 0bfd8fcdd7e8..969b3e0946d5 100644
> --- a/drivers/platform/x86/intel/ifs/runtest.c
> +++ b/drivers/platform/x86/intel/ifs/runtest.c
> @@ -236,6 +236,7 @@ static void ifs_test_core(int cpu, struct device *dev)
>   */
>  int do_core_test(int cpu, struct device *dev)
>  {
> +	struct ifs_data *ifsd = ifs_get_data(dev);
>  	int ret = 0;
>  
>  	/* Prevent CPUs from being taken offline during the scan test */
> @@ -247,7 +248,14 @@ int do_core_test(int cpu, struct device *dev)
>  		goto out;
>  	}
>  
> -	ifs_test_core(cpu, dev);
> +	switch (ifsd->ro_info->test_num) {
> +	case IFS_TYPE_SAF:
> +		ifs_test_core(cpu, dev);
> +		break;
> +	case IFS_TYPE_ARRAY_BIST:
> +	default:
> +		return -EINVAL;
> +	}
>  out:
>  	cpus_read_unlock();
>  	return ret;
> diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
> index 2007d8054f04..88234798080a 100644
> --- a/drivers/platform/x86/intel/ifs/sysfs.c
> +++ b/drivers/platform/x86/intel/ifs/sysfs.c
> @@ -75,7 +75,7 @@ static ssize_t run_test_store(struct device *dev,
>  	if (down_interruptible(&ifs_sem))
>  		return -EINTR;
>  
> -	if (!ifsd->loaded)
> +	if (ifsd->ro_info->test_num != IFS_TYPE_ARRAY_BIST && !ifsd->loaded)
>  		rc = -EPERM;
>  	else
>  		rc = do_core_test(cpu, dev);
> @@ -149,3 +149,11 @@ struct attribute *plat_ifs_attrs[] = {
>  	&dev_attr_image_version.attr,
>  	NULL
>  };
> +
> +/* global array sysfs attributes */
> +struct attribute *plat_ifs_array_attrs[] = {
> +	&dev_attr_details.attr,
> +	&dev_attr_status.attr,
> +	&dev_attr_run_test.attr,
> +	NULL
> +};

Since you need 2 different groups now, please:

1. Add a "struct attribute **groups" member to struct ifs_hw_caps
2. Set it to the right attrs[] array for the CPU type in the
   2 const struct if_hw_caps instances.
3. in probe() add:

	ifs_device.misc_device.groups = ifs_device.hw_caps->groups;

before registering the misc_device.

Regards,

Hans

