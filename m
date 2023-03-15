Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE2D6BA9B2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjCOHqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjCOHqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:46:23 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Mar 2023 00:46:10 PDT
Received: from smtpcmd13147.aruba.it (smtpcmd13147.aruba.it [62.149.156.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C6F6232D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:46:09 -0700 (PDT)
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id cLoapvaAafh9HcLobpfOgx; Wed, 15 Mar 2023 08:44:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1678866293; bh=yoSSGYFU22O2ZazTZx+mbzO7CwYf2U/0MC+T7chl2JQ=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=V7O7V4Rgp54zf7uEsYCj5yUKRe9EuDJ9qj8Xl/7S6veTIdZwyToINF7+CjY2rb+xh
         oyoMow4bxkUoZjLhgk1LQchslyX21ZLVKbnAh7GU0fW7Bhg0t7vIpGWTjBoGNpG2mo
         YjaEK6jP71pqbE7Y9lwTarNkAMJ/YGvLH/zWu+VeTBR5WtUkHk4kpx/9I7gPTA0UM4
         6sAEIljIp88hN7+c1ztL3RYTyOtfXGOyKVygjbauQXjkymY5jruCEtBWttVgomEWgu
         +EiJOGa5Zw0nINKIy5/T7P2PpOZWprLj3jh7RGHchOfUSXHz4GsOWC4oJ7H0NBZHns
         //1Mi8N1j5FNg==
Message-ID: <62222431-2693-4130-03ea-e0fad5d272ce@enneenne.com>
Date:   Wed, 15 Mar 2023 08:44:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] pps: Add elapsed realtime timestamping
Content-Language: en-US
To:     Alexander Komrakov <alexander.komrakov@broadcom.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20230315005226.80347-1-alexander.komrakov@broadcom.com>
 <ZBFRUWumrQ0u2Sk4@kroah.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <ZBFRUWumrQ0u2Sk4@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMLkZ5B7OpHhwItKT+ZUT4QwM72MxrqubTYAjGp3ZiyDnL68hshRScXfLnLFD32DtDU9R1bv+fA8TpsIUl4uzzcSU+w3BOFeAEgTt+p/+Y6eGCSSgvXL
 hZIQ9OJllaMr94Ga+oayYd6Mmp2aB6UgbeNs3jCJy9P1cIJaUgVYnuSJkM6PM2qp7MZ2w0/WWIlLGhFRcLyqM9CuuUgofzitK1xQsJUypPeuKL6YzLR/E9Sn
 GbWflv2jDya5EAzW4owi6p1wM1cxeASt3t7tpjPd0zrt+fsLJ/Rz1VdwZOC59v/N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/23 06:02, Greg KH wrote:
> On Tue, Mar 14, 2023 at 05:52:26PM -0700, Alexander Komrakov wrote:
>> Some applications like Android needs elapsed realtime timestamping
>> to PPS pulse for its clock management. Add sysfs node for this.
> 
> What exact applications will use this?

You should also prove a little documentation about what a "realtime 
timestamping" is and why we need it.

>> Signed-off-by: Alexander Komrakov <alexander.komrakov@broadcom.com>
>> ---
>> Changes in v3:
>>    - Remove "staging",wrap changelog text at 72 columns and remove sysfs_emit()
> 
> Why are you not using sysfs_emit()?  That is the correct call to use.
> 
>>    - .gittconfg updated, clock_gettime removed, trailing whitespaces remvoved
> 
> What .gitconfig?
> 
>>    - COONFIG_ELAPSED_REALTIME_PPS added to enable elapsed assert/clear sysfs
> 
> "OO"?  And as I say below, just use the config option as-is, do not
> create a new one without a Kconfig change.

I suppose we can just drop this CONFIG entry.

>>   Documentation/ABI/testing/sysfs-pps | 27 ++++++++++++++++++
>>   drivers/pps/Makefile                |  4 +++
>>   drivers/pps/kapi.c                  | 24 ++++++++++++++--
>>   drivers/pps/sysfs.c                 | 44 +++++++++++++++++++++++++++--
>>   include/linux/pps_kernel.h          |  2 ++
>>   5 files changed, 96 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-pps b/Documentation/ABI/testing/sysfs-pps
>> index 25028c7bc37d..031ec89e1ed6 100644
>> --- a/Documentation/ABI/testing/sysfs-pps
>> +++ b/Documentation/ABI/testing/sysfs-pps
>> @@ -1,3 +1,30 @@
>> +What:		/sys/class/pps/pps0/assert_elapsed
>> +Date:		October 2021
>> +Contact:	Alexander Komrakov <alexander.komrakov@broadcom.com>
>> +Description:
>> +		The /sys/class/pps/ppsX/assert_elapsed file reports the
>> +		elapsed real-time assert events and the elapsed
>> +		real-time assert sequence number of the X-th source
>> +		in the form:
>> +
>> +			<secs>.<nsec>#<sequence>
>> +
>> +		If the source has no elapsed real-time assert events
>> +		the content of this file is empty.
> 
> What is a "real-time assert event"?

Please add these information to Documentation/driver-api/pps.rst too (maybe add 
a note a the end of the "SYSFS support" section.

>> +
>> +What:		/sys/class/pps/ppsX/clear_elapsed
>> +Date:		October 2021
>> +Contact:	Alexander Komrakov <alexander.komrakov@broadcom.com>
>> +Description:
>> +		The /sys/class/pps/ppsX/clear_elapsed file reports the elapsed
>> +		real-time clear events and the elapsed real-time clear
>> +		sequence number of the X-th source in the form:
>> +
>> +			<secs>.<nsec>#<sequence>
>> +
>> +		If the source has no elapsed real-time clear events the
>> +		content of this file is empty.
>> +
>>   What:		/sys/class/pps/
>>   Date:		February 2008
>>   Contact:	Rodolfo Giometti <giometti@linux.it>
>> diff --git a/drivers/pps/Makefile b/drivers/pps/Makefile
>> index ceaf65cc1f1d..443501310445 100644
>> --- a/drivers/pps/Makefile
>> +++ b/drivers/pps/Makefile
>> @@ -8,4 +8,8 @@ pps_core-$(CONFIG_NTP_PPS)	+= kc.o
>>   obj-$(CONFIG_PPS)		:= pps_core.o
>>   obj-y				+= clients/ generators/
>>   
>> +ifeq ($(CONFIG_ELAPSED_REALTIME_PPS),y)
>> +EXTRA_CFLAGS += -DENABLE_ELAPSED_REALTIME_PPS
> 
> Why are you defining a new flag just for a config option?  Why not just
> check that config option in the code instead?  That removes a different
> flag that will be impossible to track down over time.
> 
>> +endif
>> +
>>   ccflags-$(CONFIG_PPS_DEBUG) := -DDEBUG
>> diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
>> index d9d566f70ed1..69b432873ce7 100644
>> --- a/drivers/pps/kapi.c
>> +++ b/drivers/pps/kapi.c
>> @@ -23,6 +23,7 @@
>>   /*
>>    * Local functions
>>    */
>> + #define NANOSEC_PER_SEC 1000000000 /* 10^9 */
> 
> Why isn't this in units.h?  (hint, it is already, use that one.)
> 
> 
>>   
>>   static void pps_add_offset(struct pps_ktime *ts, struct pps_ktime *offset)
>>   {
>> @@ -162,11 +163,20 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
>>   	unsigned long flags;
>>   	int captured = 0;
>>   	struct pps_ktime ts_real = { .sec = 0, .nsec = 0, .flags = 0 };
>> +	struct pps_ktime ts_real_elapsed = { .sec = 0, .nsec = 0, .flags = 0 };
>> +	struct timespec64 ts64 = { .tv_sec = 0, .tv_nsec = 0 };
>>   
>>   	/* check event type */
>>   	BUG_ON((event & (PPS_CAPTUREASSERT | PPS_CAPTURECLEAR)) == 0);
> 
> You are willing to crash a system because of a tiny driver issue?  That
> is not good, please fix up in a later patch.

@Greg: I suppose you address this comment to me... :) Do you prefere a WARN_ON() 
here?

>> +	/* Calculate the monotonic clock from the timespec clock and stores the result in pps_ktime format
>> +	   ktime_get_boottime_ts64() : because elapsed realtime includes time spent in sleep */
>> +	ktime_get_boottime_ts64(&ts64);
>> +	timespec_to_pps_ktime(&ts_real_elapsed,ts64);
>>   
>> -	dev_dbg(pps->dev, "PPS event at %lld.%09ld\n",
>> +	dev_dbg(pps->dev, "PPS event (monotonic) at %lld.%09d\n",
>> +			(s64)ts_real_elapsed.sec, ts_real_elapsed.nsec);
>> +
>> +	dev_dbg(pps->dev, "PPS event (timestamp) at %lld.%09ld\n",
>>   			(s64)ts->ts_real.tv_sec, ts->ts_real.tv_nsec);
>>   
>>   	timespec_to_pps_ktime(&ts_real, ts->ts_real);
>> @@ -181,11 +191,15 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
>>   	pps->current_mode = pps->params.mode;
>>   	if (event & pps->params.mode & PPS_CAPTUREASSERT) {
>>   		/* We have to add an offset? */
>> -		if (pps->params.mode & PPS_OFFSETASSERT)
>> +		if (pps->params.mode & PPS_OFFSETASSERT) {
>> +			pps_add_offset(&ts_real_elapsed,
>> +					&pps->params.assert_off_tu);
>>   			pps_add_offset(&ts_real,
>>   					&pps->params.assert_off_tu);
>> +		}
>>   
>>   		/* Save the time stamp */
>> +		pps->assert_elapsed_tu = ts_real_elapsed;
>>   		pps->assert_tu = ts_real;
>>   		pps->assert_sequence++;
>>   		dev_dbg(pps->dev, "capture assert seq #%u\n",
>> @@ -195,11 +209,15 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
>>   	}
>>   	if (event & pps->params.mode & PPS_CAPTURECLEAR) {
>>   		/* We have to add an offset? */
>> -		if (pps->params.mode & PPS_OFFSETCLEAR)
>> +		if (pps->params.mode & PPS_OFFSETCLEAR)	{
>> +			pps_add_offset(&ts_real_elapsed,
>> +					&pps->params.clear_off_tu);
>>   			pps_add_offset(&ts_real,
>>   					&pps->params.clear_off_tu);
>> +		}
>>   
>>   		/* Save the time stamp */
>> +		pps->clear_elapsed_tu = ts_real_elapsed;
>>   		pps->clear_tu = ts_real;
>>   		pps->clear_sequence++;
>>   		dev_dbg(pps->dev, "capture clear seq #%u\n",
>> diff --git a/drivers/pps/sysfs.c b/drivers/pps/sysfs.c
>> index 134bc33f6ad0..9e100e287ba7 100644
>> --- a/drivers/pps/sysfs.c
>> +++ b/drivers/pps/sysfs.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/module.h>
>>   #include <linux/string.h>
>>   #include <linux/pps_kernel.h>
>> +#include <linux/sysfs.h>
> 
> Why is this now needed and it wasn't before?
> 
>>   
>>   /*
>>    * Attribute functions
>> @@ -24,11 +25,28 @@ static ssize_t assert_show(struct device *dev, struct device_attribute *attr,
>>   		return 0;
>>   
>>   	return sprintf(buf, "%lld.%09d#%d\n",
>> -			(long long) pps->assert_tu.sec, pps->assert_tu.nsec,
>> -			pps->assert_sequence);
>> +			   (long long) pps->assert_tu.sec, pps->assert_tu.nsec,
>> +			   pps->assert_sequence);
> 
> Why make this change?
> 
> 
> 
>>   }
>>   static DEVICE_ATTR_RO(assert);
>>   
>> +#ifdef ENABLE_ELAPSED_REALTIME_PPS
>> +static ssize_t assert_elapsed_show(struct device *dev,
>> +			   struct device_attribute *attr, char *buf)
>> +{
>> +	struct pps_device *pps = dev_get_drvdata(dev);
>> +
>> +	if (!(pps->info.mode & PPS_CAPTUREASSERT))
>> +		return 0;
>> +
>> +	return sprintf(buf, "%lld.%09d#%d\n",
> 
> sysfs files should be using sysfs_emit()
> 
>> +			   (long long) pps->assert_elapsed_tu.sec,
>> +			   pps->assert_elapsed_tu.nsec,
>> +			   pps->assert_sequence);
>> +}
>> +static DEVICE_ATTR_RO(assert_elapsed);
>> +#endif
>> +
>>   static ssize_t clear_show(struct device *dev, struct device_attribute *attr,
>>   			  char *buf)
>>   {
>> @@ -43,6 +61,24 @@ static ssize_t clear_show(struct device *dev, struct device_attribute *attr,
>>   }
>>   static DEVICE_ATTR_RO(clear);
>>   
>> +#ifdef ENABLE_ELAPSED_REALTIME_PPS
>> +static ssize_t clear_elapsed_show(struct device *dev,
>> +			  struct device_attribute *attr,
>> +			  char *buf)
>> +{
>> +	struct pps_device *pps = dev_get_drvdata(dev);
>> +
>> +	if (!(pps->info.mode & PPS_CAPTURECLEAR))
>> +		return 0;
>> +
>> +	return sprintf(buf, "%lld.%09d#%d\n",
>> +			(long long) pps->clear_elapsed_tu.sec,
>> +			pps->clear_elapsed_tu.nsec,
>> +			pps->clear_sequence);
>> +}
>> +static DEVICE_ATTR_RO(clear_elapsed);
>> +#endif
>> +
>>   static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
>>   			 char *buf)
>>   {
>> @@ -82,6 +118,10 @@ static DEVICE_ATTR_RO(path);
>>   static struct attribute *pps_attrs[] = {
>>   	&dev_attr_assert.attr,
>>   	&dev_attr_clear.attr,
>> +#ifdef ENABLE_ELAPSED_REALTIME_PPS
>> +	&dev_attr_assert_elapsed.attr,
>> +	&dev_attr_clear_elapsed.attr,
>> +#endif
> 
> Don't use #ifdef in a .c file, these attributes should only show up if
> you determine at runtime they should not be there.
> 
> But why woudn't they just always be there all the time anyway?  Why do
> you need a new config option?
> 
> 
>>   	&dev_attr_mode.attr,
>>   	&dev_attr_echo.attr,
>>   	&dev_attr_name.attr,
>> diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
>> index 78c8ac4951b5..1fecaaf4c8b9 100644
>> --- a/include/linux/pps_kernel.h
>> +++ b/include/linux/pps_kernel.h
>> @@ -47,6 +47,8 @@ struct pps_device {
>>   
>>   	__u32 assert_sequence;			/* PPS assert event seq # */
>>   	__u32 clear_sequence;			/* PPS clear event seq # */
>> +	struct pps_ktime assert_elapsed_tu; /* PPS elapsed rt assert seq # */
>> +	struct pps_ktime clear_elapsed_tu;  /* PPS elapsed rt clear event seq */
> 
> no tabs?
> 
> thanks,
> 
> greg k-h

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

