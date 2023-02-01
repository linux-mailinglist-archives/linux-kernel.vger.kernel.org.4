Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF739685EAF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 06:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjBAFEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 00:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBAFEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 00:04:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892614E53D;
        Tue, 31 Jan 2023 21:04:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40FCEB8205D;
        Wed,  1 Feb 2023 05:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520F8C4339B;
        Wed,  1 Feb 2023 05:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675227846;
        bh=RLaIix0nWRF9inMGPANhbNfy1fN3Q3H7JVqsMkSylhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A3EcFiTjRHjJCEg3v0sEKjOOeDfUs6A5mSVRr1ekyzN+KdixkOhRLQogIO19L42h/
         b+5U8R24DMk6J8cOnO+QQEo/fUR4l7Ts4yhXwOIM2NdMO9tFNrrUCOPS7l8IR8zMnj
         QmgoZAK5yTN2iSuJ0lDyh8MveBsUCUoj6dxp8Vw8=
Date:   Wed, 1 Feb 2023 06:04:04 +0100
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
Subject: Re: [PATCH 3/5] platform/x86/intel/ifs: Sysfs interface for Array
 BIST
Message-ID: <Y9nyxNesVHCUXAcH@kroah.com>
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
 <20230131234302.3997223-4-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131234302.3997223-4-jithu.joseph@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 03:43:00PM -0800, Jithu Joseph wrote:
> The interface to trigger Array BIST test and obtain its result
> is similar to the existing scan test. The only notable
> difference is that, Array BIST doesn't require any test content
> to be loaded. So binary load related options are not needed for
> this test.
> 
> Add sysfs interface array BIST test, the testing support will
> be added by subsequent patch.

What is "sysfs interface array" exactly?

Where is the new Documentation/ABI/ entries for these new sysfs files
you added?

> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/ifs.h     |  1 +
>  drivers/platform/x86/intel/ifs/core.c    | 18 +++++++++++++-----
>  drivers/platform/x86/intel/ifs/runtest.c | 11 ++++++++++-
>  drivers/platform/x86/intel/ifs/sysfs.c   | 17 ++++++++++++++++-
>  4 files changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> index 2cef88a88aa9..07423bc4e368 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -249,5 +249,6 @@ static inline struct ifs_data *ifs_get_data(struct device *dev)
>  int ifs_load_firmware(struct device *dev);
>  int do_core_test(int cpu, struct device *dev);
>  const struct attribute_group **ifs_get_groups(void);
> +const struct attribute_group **ifs_get_array_groups(void);
>  
>  #endif
> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
> index ab234620ef4c..2b7a49fd473d 100644
> --- a/drivers/platform/x86/intel/ifs/core.c
> +++ b/drivers/platform/x86/intel/ifs/core.c
> @@ -25,6 +25,7 @@ static struct ifs_device ifs_devices[] = {
>  	[IFS_SAF] = {
>  		.data = {
>  			.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
> +			.pkg_auth = NULL,
>  			.test_num = IFS_SAF,
>  		},
>  		.misc = {
> @@ -36,6 +37,7 @@ static struct ifs_device ifs_devices[] = {
>  	[IFS_ARRAY] = {
>  		.data = {
>  			.integrity_cap_bit = MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT,
> +			.pkg_auth = NULL,
>  			.test_num = IFS_ARRAY,
>  		},
>  		.misc = {
> @@ -72,11 +74,17 @@ static int __init ifs_init(void)
>  		if (!(msrval & BIT(ifs_devices[i].data.integrity_cap_bit)))
>  			continue;
>  
> -		ifs_devices[i].data.pkg_auth = kmalloc_array(topology_max_packages(),
> -							     sizeof(bool), GFP_KERNEL);
> -		if (!ifs_devices[i].data.pkg_auth)
> -			continue;
> -		ifs_devices[i].misc.groups = ifs_get_groups();
> +		switch (ifs_devices[i].data.test_num) {
> +		case IFS_SAF:
> +			ifs_devices[i].data.pkg_auth = kmalloc_array(topology_max_packages(),
> +								     sizeof(bool), GFP_KERNEL);
> +			if (!ifs_devices[i].data.pkg_auth)
> +				continue;
> +			ifs_devices[i].misc.groups = ifs_get_groups();
> +			break;
> +		case IFS_ARRAY:
> +			ifs_devices[i].misc.groups = ifs_get_array_groups();
> +		}
>  
>  		if (misc_register(&ifs_devices[i].misc))
>  			kfree(ifs_devices[i].data.pkg_auth);
> diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
> index 0bfd8fcdd7e8..65e08af70994 100644
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
> @@ -247,7 +248,15 @@ int do_core_test(int cpu, struct device *dev)
>  		goto out;
>  	}
>  
> -	ifs_test_core(cpu, dev);
> +	switch (ifsd->test_num) {
> +	case IFS_SAF:
> +		ifs_test_core(cpu, dev);
> +		break;
> +	case IFS_ARRAY:
> +	default:
> +		return -EINVAL;
> +	}
> +
>  out:
>  	cpus_read_unlock();
>  	return ret;
> diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
> index ee636a76b083..7cf32184ce6a 100644
> --- a/drivers/platform/x86/intel/ifs/sysfs.c
> +++ b/drivers/platform/x86/intel/ifs/sysfs.c
> @@ -75,7 +75,7 @@ static ssize_t run_test_store(struct device *dev,
>  	if (down_interruptible(&ifs_sem))
>  		return -EINTR;
>  
> -	if (!ifsd->loaded)
> +	if (ifsd->test_num != IFS_ARRAY && !ifsd->loaded)
>  		rc = -EPERM;
>  	else
>  		rc = do_core_test(cpu, dev);
> @@ -156,3 +156,18 @@ const struct attribute_group **ifs_get_groups(void)
>  {
>  	return plat_ifs_groups;
>  }
> +
> +/* global array sysfs attributes */
> +static struct attribute *plat_ifs_array_attrs[] = {
> +	&dev_attr_details.attr,
> +	&dev_attr_status.attr,
> +	&dev_attr_run_test.attr,
> +	NULL
> +};
> +
> +ATTRIBUTE_GROUPS(plat_ifs_array);
> +
> +const struct attribute_group **ifs_get_array_groups(void)
> +{
> +	return plat_ifs_array_groups;
> +}

Why do you need a function to get access to a static variable?  Just
make the variable not static.

thanks,

greg k-h
