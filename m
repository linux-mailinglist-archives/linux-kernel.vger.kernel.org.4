Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E124769948D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjBPMkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjBPMkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:40:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602CE1712;
        Thu, 16 Feb 2023 04:40:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E810D61FB9;
        Thu, 16 Feb 2023 12:40:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71FAC433D2;
        Thu, 16 Feb 2023 12:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676551240;
        bh=YukQlthcym8GuIt8JwP/G1usKq0bLhLvB1Scby/jETU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XxwQ5oLvB7oHwBALPfQG9fu0nlcan7zw5nBJa9jvxHB/WHNOx9jYIFcUSzwXOq6qq
         fyWdpI7afR1ZTgzxN13EpmWl/HpYKKK5gJSoLjoIllCDuj2O0PkcpgWon97cWXclDo
         lxWLSWNoOrnu5OzbhDkYgGmEdsJy6PHzvpIM1bVM=
Date:   Thu, 16 Feb 2023 13:40:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jithu Joseph <jithu.joseph@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, rostedt@goodmis.org,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
Subject: Re: [PATCH v2 2/7] platform/x86/intel/ifs: Introduce Array Scan test
 to IFS
Message-ID: <Y+4kQOtrHt5pdsSO@kroah.com>
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
 <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230214234426.344960-3-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214234426.344960-3-jithu.joseph@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 03:44:21PM -0800, Jithu Joseph wrote:
> Array BIST is a new type of core test introduced under the Intel Infield
> Scan (IFS) suite of tests.
> 
> Emerald Rapids (EMR) is the first CPU to support Array BIST.
> Array BIST performs tests on some portions of the core logic such as
> caches and register files. These are different portions of the silicon
> compared to the parts tested by the first test type
> i.e Scan at Field (SAF).
> 
> Make changes in the device driver init flow to register this new test
> type with the device driver framework. Each test will have its own
> sysfs directory (intel_ifs_0 , intel_ifs_1) under misc hierarchy to
> accommodate for the differences in test type and how they are initiated.
> 
> Upcoming patches will add actual support.
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/ifs.h  |  5 ++
>  drivers/platform/x86/intel/ifs/core.c | 70 ++++++++++++++++++---------
>  2 files changed, 52 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> index 046e39304fd5..2cef88a88aa9 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -137,6 +137,11 @@
>  #define SCAN_TEST_PASS				1
>  #define SCAN_TEST_FAIL				2
>  
> +enum test_types {
> +	IFS_SAF,
> +	IFS_ARRAY,

As you are using this enum to index an array, don't you need to set the
starting value to be sure it's 0?

But note, that's a horrid name of an enumerated type that is in a .h
file, either put it only in the .c file, or give it a name that makes
more sense that it belongs only to this driver.

Yes, naming is hard.

Wait, you don't even use the enumerated type anywhere in this patch
series only the value, did you mean for this to happen?  Why name it
anything?




> +};
> +
>  /* MSR_SCAN_HASHES_STATUS bit fields */
>  union ifs_scan_hashes_status {
>  	u64	data;
> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
> index 206a617c2e02..ab234620ef4c 100644
> --- a/drivers/platform/x86/intel/ifs/core.c
> +++ b/drivers/platform/x86/intel/ifs/core.c
> @@ -16,27 +16,44 @@
>  
>  static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
>  	X86_MATCH(SAPPHIRERAPIDS_X),
> +	X86_MATCH(EMERALDRAPIDS_X),
>  	{}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
>  
> -static struct ifs_device ifs_device = {
> -	.data = {
> -		.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
> -		.test_num = 0,
> +static struct ifs_device ifs_devices[] = {
> +	[IFS_SAF] = {
> +		.data = {
> +			.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
> +			.test_num = IFS_SAF,
> +		},
> +		.misc = {
> +			.name = "intel_ifs_0",
> +			.nodename = "intel_ifs/0",

I just noticed this, a device node called "0" is not good, why do you
need this in a subdir at all?

> +			.minor = MISC_DYNAMIC_MINOR,
> +		},
>  	},
> -	.misc = {
> -		.name = "intel_ifs_0",
> -		.nodename = "intel_ifs/0",
> -		.minor = MISC_DYNAMIC_MINOR,
> +	[IFS_ARRAY] = {
> +		.data = {
> +			.integrity_cap_bit = MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT,
> +			.test_num = IFS_ARRAY,
> +		},
> +		.misc = {
> +			.name = "intel_ifs_1",
> +			.nodename = "intel_ifs/1",

Again, a device node called "1"?

> +			.minor = MISC_DYNAMIC_MINOR,
> +		},
>  	},
>  };
>  
> +#define IFS_NUMTESTS ARRAY_SIZE(ifs_devices)

Don't do this, just have a list with a NULL entry at the end, makes
things much simpler and easier over time.


> +
>  static int __init ifs_init(void)
>  {
>  	const struct x86_cpu_id *m;
> +	int ndevices = 0;
>  	u64 msrval;
> -	int ret;
> +	int i;
>  
>  	m = x86_match_cpu(ifs_cpu_ids);
>  	if (!m)
> @@ -51,28 +68,35 @@ static int __init ifs_init(void)
>  	if (rdmsrl_safe(MSR_INTEGRITY_CAPS, &msrval))
>  		return -ENODEV;
>  
> -	ifs_device.misc.groups = ifs_get_groups();
> -
> -	if (!(msrval & BIT(ifs_device.data.integrity_cap_bit)))
> -		return -ENODEV;
> +	for (i = 0; i < IFS_NUMTESTS; i++) {
> +		if (!(msrval & BIT(ifs_devices[i].data.integrity_cap_bit)))
> +			continue;
>  
> -	ifs_device.data.pkg_auth = kmalloc_array(topology_max_packages(), sizeof(bool), GFP_KERNEL);
> -	if (!ifs_device.data.pkg_auth)
> -		return -ENOMEM;
> +		ifs_devices[i].data.pkg_auth = kmalloc_array(topology_max_packages(),
> +							     sizeof(bool), GFP_KERNEL);
> +		if (!ifs_devices[i].data.pkg_auth)
> +			continue;

You have a static array of a structure that contains both things that
describe the devices being used, as well as dynamic data with no real
lifespan rules.  Please don't perputate this common design pattern
mistake.

Always try to make static data constant and make dynamic data dynamic
with proper reference counted lifetime rules.  People converting this
code into rust in the future will thank you :)

thanks,

greg k-h
