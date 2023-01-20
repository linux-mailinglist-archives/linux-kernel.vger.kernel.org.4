Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECC2675358
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjATLVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjATLVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:21:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F22CDE3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 03:21:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62BC461F27
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 11:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B82C433EF;
        Fri, 20 Jan 2023 11:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674213706;
        bh=c698I8b60d+IpbwpeBjjjlgXUrKgUBK9GfqLJSDZgi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z+i6ECoZe5lFVwKiQdBBu9u4kYOILJKbUCs/TYiBU9oxnUEh8czgexnMk8Lwj2mfF
         YW0GUBejroLNEMt/i+1ezCQ3gdK5H4nzfZ1iX6bbzTysHIZkCbfb3XgeuUTUYSn0yl
         qqExB6LySJHqCbLeE4pNzHR5sIfP6khO9B8IKMT8=
Date:   Fri, 20 Jan 2023 12:21:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     alexander komrakov <alexander.komrakov@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, giometti@enneenne.com
Subject: Re: [PATCH v2] pps: Add elapsed realtime timestamping
Message-ID: <Y8p5SFf1cMEibX9k@kroah.com>
References: <20221221054707.234998-1-alexander.komrakov@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221054707.234998-1-alexander.komrakov@broadcom.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 09:47:07PM -0800, alexander komrakov wrote:
> Some applications like Android needs elapsed realtime timestamping
> to PPS pulse for its clock management. Add sysfs node for this.
> 
> Signed-off-by: alexander komrakov <alexander.komrakov@broadcom.com>

Nit, you should use "A" and "K" here and in your email "From:" line as
you use that in the change below.

> ---
> Changes in v2:
>   - Remove "staging",wrap changelog text at 72 columns and use sysfs_emit().
> 
>  Documentation/ABI/testing/sysfs-pps | 27 +++++++++++++++++++
>  drivers/pps/kapi.c                  | 38 ++++++++++++++++++++++++---
>  drivers/pps/sysfs.c                 | 40 ++++++++++++++++++++++++++---
>  include/linux/pps_kernel.h          |  2 ++
>  4 files changed, 101 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-pps b/Documentation/ABI/testing/sysfs-pps
> index 25028c7bc37d..e5fd7bc89ea9 100644
> --- a/Documentation/ABI/testing/sysfs-pps
> +++ b/Documentation/ABI/testing/sysfs-pps
> @@ -1,3 +1,30 @@
> +What:		/sys/class/pps/pps0/assert_elapsed
> +Date:		October 2021
> +Contact:	Alexander Komrakov <alexander.komrakov@broadcom.com>
> +Description:
> +		The /sys/class/pps/ppsX/assert_elapsed file reports the 
> +		elapsed real-time assert events and the elapsed 
> +		real-time assert sequence number of the X-th source 
> +		in the form:

Trailing whitespace :(

> +
> +			<secs>.<nsec>#<sequence>
> +
> +		If the source has no elapsed real-time assert events 
> +		the content of this file is empty.

The file should not be present if there is no such events, please fix
that up in the code.


> +
> +What:		/sys/class/pps/ppsX/clear_elapsed
> +Date:		October 2021
> +Contact:	Alexander Komrakov <alexander.komrakov@broadcom.com>
> +Description:
> +		The /sys/class/pps/ppsX/clear_elapsed file reports the elapsed
> +		real-time clear events and the elapsed real-time clear 
> +		sequence number of the X-th source in the form:
> +
> +			<secs>.<nsec>#<sequence>
> +
> +		If the source has no elapsed real-time clear events the 
> +		content of this file is empty.
> +
>  What:		/sys/class/pps/
>  Date:		February 2008
>  Contact:	Rodolfo Giometti <giometti@linux.it>
> diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
> index d9d566f70ed1..c4c6e885b768 100644
> --- a/drivers/pps/kapi.c
> +++ b/drivers/pps/kapi.c
> @@ -23,6 +23,26 @@
>  /*
>   * Local functions
>   */
> + #define NANOSEC_PER_SEC 1000000000 /* 10^9 */

This should go into a core include file instead.

> +
> +/**
> + * clock_gettime - get the monotonic clock in pps_ktime format
> + * @kt:		pointer to the pps_ktime to be set to raw monotonic time
> + *
> + * The function calculates the monotonic clock from the timespec clock and
> + * stores the result in pps_ktime format in the variable pointed to by @kt.
> + *
> + * The function returns the monotonic clock normalized format in nanosec.
> + */
> +static __u64 clock_gettime(struct pps_ktime *kt)
> +{
> +	struct timespec64 ts = { .tv_sec = 0, .tv_nsec = 0 };
> +
> +	ktime_get_boottime_ts64(&ts);
> +	kt->sec = ts.tv_sec;
> +	kt->nsec = ts.tv_nsec;
> +	return (__u64) ts.tv_sec * NANOSEC_PER_SEC + ts.tv_nsec;
> +}

We don't already have this in a core function?

And why __u64?  This does not cross the user/kernel boundry, right?

>  
>  static void pps_add_offset(struct pps_ktime *ts, struct pps_ktime *offset)
>  {
> @@ -162,11 +182,15 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
>  	unsigned long flags;
>  	int captured = 0;
>  	struct pps_ktime ts_real = { .sec = 0, .nsec = 0, .flags = 0 };
> +	struct pps_ktime ts_real_elapsed = { .sec = 0, .nsec = 0, .flags = 0 };
>  
>  	/* check event type */
>  	BUG_ON((event & (PPS_CAPTUREASSERT | PPS_CAPTURECLEAR)) == 0);
> +	clock_gettime(&ts_real_elapsed);
> +	dev_dbg(pps->dev, "PPS event (monotonic) at %lld.%09d\n",
> +			(s64)ts_real_elapsed.sec, ts_real_elapsed.nsec);
>  
> -	dev_dbg(pps->dev, "PPS event at %lld.%09ld\n",
> +	dev_dbg(pps->dev, "PPS event (timestamp) at %lld.%09ld\n",
>  			(s64)ts->ts_real.tv_sec, ts->ts_real.tv_nsec);
>  
>  	timespec_to_pps_ktime(&ts_real, ts->ts_real);
> @@ -181,11 +205,15 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
>  	pps->current_mode = pps->params.mode;
>  	if (event & pps->params.mode & PPS_CAPTUREASSERT) {
>  		/* We have to add an offset? */
> -		if (pps->params.mode & PPS_OFFSETASSERT)
> +		if (pps->params.mode & PPS_OFFSETASSERT) {
> +			pps_add_offset(&ts_real_elapsed,
> +					&pps->params.assert_off_tu);
>  			pps_add_offset(&ts_real,
>  					&pps->params.assert_off_tu);
> +		}
>  
>  		/* Save the time stamp */
> +		pps->assert_elapsed_tu = ts_real_elapsed;
>  		pps->assert_tu = ts_real;
>  		pps->assert_sequence++;
>  		dev_dbg(pps->dev, "capture assert seq #%u\n",
> @@ -195,11 +223,15 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
>  	}
>  	if (event & pps->params.mode & PPS_CAPTURECLEAR) {
>  		/* We have to add an offset? */
> -		if (pps->params.mode & PPS_OFFSETCLEAR)
> +		if (pps->params.mode & PPS_OFFSETCLEAR)	{
> +			pps_add_offset(&ts_real_elapsed,
> +					&pps->params.clear_off_tu);
>  			pps_add_offset(&ts_real,
>  					&pps->params.clear_off_tu);
> +		}
>  
>  		/* Save the time stamp */
> +		pps->clear_elapsed_tu = ts_real_elapsed;
>  		pps->clear_tu = ts_real;
>  		pps->clear_sequence++;
>  		dev_dbg(pps->dev, "capture clear seq #%u\n",
> diff --git a/drivers/pps/sysfs.c b/drivers/pps/sysfs.c
> index 134bc33f6ad0..d905ac78da7e 100644
> --- a/drivers/pps/sysfs.c
> +++ b/drivers/pps/sysfs.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/string.h>
>  #include <linux/pps_kernel.h>
> +#include <linux/sysfs.h> 

Trailing whitespace.  Please fix your editor to highlight this in
bright-red or something like that.

checkpatch would have also caught all of this, why didn't you run that
on your patch before sending it out?

>  
>  /*
>   * Attribute functions
> @@ -23,12 +24,27 @@ static ssize_t assert_show(struct device *dev, struct device_attribute *attr,
>  	if (!(pps->info.mode & PPS_CAPTUREASSERT))
>  		return 0;
>  
> -	return sprintf(buf, "%lld.%09d#%d\n",
> -			(long long) pps->assert_tu.sec, pps->assert_tu.nsec,
> -			pps->assert_sequence);
> +	return sysfs_emit(buf, "%lld.%09d#%d\n",
> +			   (long long) pps->assert_tu.sec, pps->assert_tu.nsec,
> +			   pps->assert_sequence);

Why change this now?  It should be a separate patch, right?

>  }
>  static DEVICE_ATTR_RO(assert);
>  
> +static ssize_t assert_elapsed_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	struct pps_device *pps = dev_get_drvdata(dev);
> +
> +	if (!(pps->info.mode & PPS_CAPTUREASSERT))
> +		return 0;
> +
> +	return sysfs_emit(buf, "%lld.%09d#%d\n",
> +			    (long long) pps->assert_elapsed_tu.sec,

No extra ' ' before the variable, right?

> +			    pps->assert_elapsed_tu.nsec,
> +			    pps->assert_sequence);
> +}
> +static DEVICE_ATTR_RO(assert_elapsed);
> +
>  static ssize_t clear_show(struct device *dev, struct device_attribute *attr,
>  			  char *buf)
>  {
> @@ -43,6 +59,22 @@ static ssize_t clear_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(clear);
>  
> +static ssize_t clear_elapsed_show(struct device *dev,
> +			  struct device_attribute *attr,
> +			  char *buf)
> +{
> +	struct pps_device *pps = dev_get_drvdata(dev);
> +
> +	if (!(pps->info.mode & PPS_CAPTURECLEAR))
> +		return 0;

No, don't have this file if it's not possible for this to have a valid
value.

> +
> +	return sprintf(buf, "%lld.%09d#%d\n",
> +			(long long) pps->clear_elapsed_tu.sec,
> +			pps->clear_elapsed_tu.nsec,
> +			pps->clear_sequence);

No sysfs_emit()?  Odd...

thanks,

greg k-h
