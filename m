Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E511A6BE257
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 08:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjCQH5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 03:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjCQH5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 03:57:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB51940ED
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 00:57:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C2BCB8249B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE310C433D2;
        Fri, 17 Mar 2023 07:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679039836;
        bh=dJU4/FLp0Jms5PV/coqZDNCkhu4bO9ncuk+t62NRHio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jo0WOBCJgrYGT6eV5J+CVFhn2oD3OSLJ5PsC/9yjvYvTZ7h0CMaaoP7X7XcXqL65Z
         qttZHb4Zbv87PHwldV2JOkwoXt6zUm0gQ45Az4TgyN7xyyklA2fbqgoT+t5O1w/gYM
         YG+sh1FZmwB0EZ9LHdnAuV7NSEZKq8umsxoYNN2g=
Date:   Fri, 17 Mar 2023 08:57:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexander Komrakov <alexander.komrakov@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, giometti@enneenne.com
Subject: Re: [PATCH v4] pps: Add elapsed realtime timestamping
Message-ID: <ZBQdWRHzakFLzSkb@kroah.com>
References: <20230317074739.193965-1-alexander.komrakov@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317074739.193965-1-alexander.komrakov@broadcom.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 12:47:39AM -0700, Alexander Komrakov wrote:
> Some applications like Android needs elapsed realtime timestamping
> to PPS pulse for its clock management. Add sysfs node for this.
> 
> Signed-off-by: Alexander Komrakov <alexander.komrakov@broadcom.com>
> ---
> Changes in v4:
>   - Remove "staging",wrap changelog text at 72 columns and remove sysfs_emit()

Why remove sysfs_emit()?  That's the correct thing to use, please use
it.

>   - clock_gettime removed, trailing whitespaces removed, <tab> added, spaces removed
>   - Information Real-time assert event added to Documentation/driver-api/pps.rst
> 
>  Documentation/ABI/testing/sysfs-pps | 27 +++++++++++++++++++++++
>  Documentation/driver-api/pps.rst    |  8 +++++++
>  drivers/pps/Makefile                |  4 ++++
>  drivers/pps/kapi.c                  | 23 ++++++++++++++++---
>  drivers/pps/sysfs.c                 | 34 +++++++++++++++++++++++++++++
>  include/linux/pps_kernel.h          |  2 ++
>  6 files changed, 95 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-pps b/Documentation/ABI/testing/sysfs-pps
> index 25028c7bc37d..031ec89e1ed6 100644
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
> +
> +			<secs>.<nsec>#<sequence>
> +
> +		If the source has no elapsed real-time assert events
> +		the content of this file is empty.
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
> diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/pps.rst
> index 2d6b99766ee8..80bd7bf048e8 100644
> --- a/Documentation/driver-api/pps.rst
> +++ b/Documentation/driver-api/pps.rst
> @@ -167,6 +167,14 @@ sequence number. Other files are:
>   * path: reports the PPS source's device path, that is the device the
>     PPS source is connected to (if it exists).
>  
> +Real-time assert event::
> +
> +   Calculate the monotonic clock from the timespec clock to generate PPS elapsed real-time event value and store the result into /sys/class/pps/pps0/assert_elapsed.
> +   Because we have requirements to make sure the delta between standard time, say the GPS Time, and elapsedRealtime < 1 millisecond,
> +   regular linux clock timestamp is not enough for our use case.
> +   The pin PPS will generate elapsedRealtime event at 1 sec boundary which is an exact value of the monotonic clock from the kernel PPS driver
> +   /sys/class/pps/pps0/assert_elapsed.

Please wrap your lines properly :(


> +
>  
>  Testing the PPS support
>  -----------------------
> diff --git a/drivers/pps/Makefile b/drivers/pps/Makefile
> index ceaf65cc1f1d..443501310445 100644
> --- a/drivers/pps/Makefile
> +++ b/drivers/pps/Makefile
> @@ -8,4 +8,8 @@ pps_core-$(CONFIG_NTP_PPS)	+= kc.o
>  obj-$(CONFIG_PPS)		:= pps_core.o
>  obj-y				+= clients/ generators/
>  
> +ifeq ($(CONFIG_ELAPSED_REALTIME_PPS),y)
> +EXTRA_CFLAGS += -DENABLE_ELAPSED_REALTIME_PPS
> +endif

Why do you need a new CFLAG?  Why not just look at the CONFIG entry
instead?  And your .c code does not use this new CFLAG at all, so why is
it even here?


> +
>  ccflags-$(CONFIG_PPS_DEBUG) := -DDEBUG
> diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
> index d9d566f70ed1..8a97f4cae9e1 100644
> --- a/drivers/pps/kapi.c
> +++ b/drivers/pps/kapi.c
> @@ -162,11 +162,20 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
>  	unsigned long flags;
>  	int captured = 0;
>  	struct pps_ktime ts_real = { .sec = 0, .nsec = 0, .flags = 0 };
> +	struct pps_ktime ts_real_elapsed = { .sec = 0, .nsec = 0, .flags = 0 };
> +	struct timespec64 ts64 = { .tv_sec = 0, .tv_nsec = 0 };
>  
>  	/* check event type */
>  	BUG_ON((event & (PPS_CAPTUREASSERT | PPS_CAPTURECLEAR)) == 0);
> +	/* Calculate the monotonic clock from the timespec clock and stores the result in pps_ktime format
> +	   ktime_get_boottime_ts64() : because elapsed realtime includes time spent in sleep */

Properly wrap your lines.

Also a blenk line after the BUG_ON()?


> +	ktime_get_boottime_ts64(&ts64);
> +	timespec_to_pps_ktime(&ts_real_elapsed,ts64);
>  
> -	dev_dbg(pps->dev, "PPS event at %lld.%09ld\n",
> +	dev_dbg(pps->dev, "PPS event (monotonic) at %lld.%09d\n",
> +			(s64)ts_real_elapsed.sec, ts_real_elapsed.nsec);
> +
> +	dev_dbg(pps->dev, "PPS event (timestamp) at %lld.%09ld\n",
>  			(s64)ts->ts_real.tv_sec, ts->ts_real.tv_nsec);
>  
>  	timespec_to_pps_ktime(&ts_real, ts->ts_real);
> @@ -181,11 +190,15 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
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
> @@ -195,11 +208,15 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
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
> index 134bc33f6ad0..24f505cd7233 100644
> --- a/drivers/pps/sysfs.c
> +++ b/drivers/pps/sysfs.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/string.h>
>  #include <linux/pps_kernel.h>
> +#include <linux/sysfs.h>

Why is this .h needed now and not previously?

>  
>  /*
>   * Attribute functions
> @@ -29,6 +30,21 @@ static ssize_t assert_show(struct device *dev, struct device_attribute *attr,
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

Why are you not returning an error?

> +
> +	return sprintf(buf, "%lld.%09d#%d\n",
> +			   (long long) pps->assert_elapsed_tu.sec,
> +			   pps->assert_elapsed_tu.nsec,
> +			   pps->assert_sequence);

sysfs_emit() please.

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

Again, why not an error?

And why are these sysfs files even present if the mode is not set
properly?  Can the mode be set while the device is attached or is this
only defined at probe time?  If at probe time, just never create these
files.

> +
> +	return sprintf(buf, "%lld.%09d#%d\n",
> +			(long long) pps->clear_elapsed_tu.sec,
> +			pps->clear_elapsed_tu.nsec,
> +			pps->clear_sequence);

Again, sysfs_emit() please.

thanks,

greg k-h
