Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9314473FDCD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjF0O2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjF0O2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:28:06 -0400
Received: from smtpcmd0642.aruba.it (smtpcmd0642.aruba.it [62.149.156.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065EC270F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:28:03 -0700 (PDT)
Received: from [192.168.200.80] ([193.43.24.34])
        by Aruba Outgoing Smtp  with ESMTPSA
        id E9fjqGyqJTdWxE9fjqTMkR; Tue, 27 Jun 2023 16:28:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1687876080; bh=pbAVQo6XnuEaX+ov1viwPyrySOMKT8apsf+be4jFI1A=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=LmR8t96HZ33S7Y1bK4aFv5YaGM9bBULHmbgbldCtzDeCw8HjBFpM452C3Q+kal3nT
         k2ESuOZegvLaioqM7iog5Vg2gGNz0Ask5Usp0XxR9YWzp1FNORmiuq7+4zop/TLKrM
         9wORauTz88dAWUyErFIP7vjKxgYaZdZwSCV33PGdT2UhBtUSr0oCK8Y6H9loMjnzgk
         QYiedPx+9A/LZGmpfPQKKwsHz/EEEVmNGb6vTCyMLxP/IY12FAPixEgICGtslPTs1N
         RkpzMgJF+noJg8XgulkKjJ6blvTUIlMfc+cTWa9y2Dv76TiNzCxdfYiLs9NFeYsFUN
         sTirFuAt44bQg==
Message-ID: <6b6dd2ae-a30d-4f25-f696-c01f2e5a4a1e@enneenne.com>
Date:   Tue, 27 Jun 2023 16:27:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/5] pps: add pulse-width calculation in nsec
Content-Language: en-US
To:     Eliav Farber <farbere@amazon.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ronenk@amazon.com, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, itamark@amazon.com, shellykz@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com
References: <20230625142134.33690-1-farbere@amazon.com>
 <20230625142134.33690-2-farbere@amazon.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20230625142134.33690-2-farbere@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDo3u8mDca6rgx2K5fq5eypS3Z5R4v4kaKPDUWp90ItxzojzDLsQUkmq/5CgCTGWH9pPX2J+ES47fwtnSA1ZguuNK/yOALHOBRvKtDvOGX10pTJFbJTG
 128O6fW0gv6aSJ8ihSvDMAU4vXcF3NPPAn2NJuUEQWUMKdXpkJy3v86ddP8358Ma5l3KI1Z47C3uIH0jNn+GBhWYbL/g4x6LidAEgIK3cXcYzUyxaJPluC+l
 +j40twrjMYP0TJvnd1lXCIsepMfl/i/3Xp0cVf82r7X+8xoh8jBkPV35HKu4yuU3EH0vW2tq8vTTWviSeyv5nNKnwXa7q7hVpVSbXu8d+JsqgPA+QLE1/f7X
 sUKEHmqfhwqoTe7/jkajOo+B/ZZKOyU4S9vAWOihQ6BxLDsI5NTiZlebmdLBIHOL3iwfYmhN+xa3/w3i2BQ6O/vT8v63jIw/UvQgqTZi5aqkweTcc5suSM56
 ONm1qgypQ/8MbN0W4+7I2hZc1eXYKU3ujhsMMzPV5wfhAR0adD0Z7gqtOn4Fr/8cbtKDkENTQG841S9ZmNfqHcQjODxlt/oGi6LGbGevzQFjt3tZ+qjjSNry
 oKFgtPpmH68rJnlX4Pm3gL5H
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/23 16:21, Eliav Farber wrote:
> This change adds PPS pulse-width calculation in nano seconds.
> Width time can be calculated for both assert time and reset time.
> 
> Calculation can be done only if capture ASSERT and capture CLEAR modes
> are both enabled.
> 
> Assert width is calculated as:
>    clear-time - assert-time
> and clear width is calculated as:
>    assert-time - clear-time
> 
> Read-only sysfs were added to get the last pulse-width time and event
> sequence.
> Examples:
>   * cat /sys/class/pps/pps0/pulse_width_assert
>     20001450#85
>   * cat /sys/class/pps/pps1/pulse_width_clear
>     979893314#16
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>   drivers/pps/kapi.c         | 49 ++++++++++++++++++++++++++++++++++++++
>   drivers/pps/pps.c          |  9 +++++++
>   drivers/pps/sysfs.c        | 30 +++++++++++++++++++++++
>   include/linux/pps_kernel.h |  3 +++
>   include/uapi/linux/pps.h   | 19 +++++++++++++++
>   5 files changed, 110 insertions(+)
> 
> diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
> index d9d566f70ed1..deeecfc0a3ee 100644
> --- a/drivers/pps/kapi.c
> +++ b/drivers/pps/kapi.c
> @@ -82,6 +82,14 @@ struct pps_device *pps_register_source(struct pps_source_info *info,
>   		goto pps_register_source_exit;
>   	}
>   
> +	if ((info->mode & PPS_WIDTHBOTH) &&
> +	    ((info->mode & PPS_CAPTUREBOTH) != PPS_CAPTUREBOTH)) {
> +		pr_err("%s: width can't be calculated without both captures (mode = 0x%x)\n",
> +		       info->name, info->mode);
> +		err = -EINVAL;
> +		goto pps_register_source_exit;
> +	}

See the comment below where you define PPS_WIDTHBOTH.

>   	/* Allocate memory for the new PPS source struct */
>   	pps = kzalloc(sizeof(struct pps_device), GFP_KERNEL);
>   	if (pps == NULL) {
> @@ -143,6 +151,39 @@ void pps_unregister_source(struct pps_device *pps)
>   }
>   EXPORT_SYMBOL(pps_unregister_source);
>   
> +static u64 pps_ktime_sub(struct pps_ktime *ts1, struct pps_ktime *ts2)
> +{
> +	if (ts1->sec == ts2->sec)
> +		return (ts1->nsec > ts2->nsec) ? (ts1->nsec - ts2->nsec) : (ts2->nsec - ts1->nsec);
> +
> +	if (ts1->sec > ts2->sec)
> +		return (ts1->sec - ts2->sec) * NSEC_PER_SEC + ts1->nsec - ts2->nsec;
> +
> +	return (ts2->sec - ts1->sec) * NSEC_PER_SEC + ts2->nsec - ts1->nsec;
> +}
> +
> +static void pps_calc_clear_width(struct pps_device *pps)
> +{
> +	if (pps->clear_sequence == 0)
> +		return;
> +
> +	pps->clear_width.sequence++;

I don't understand the meaning of this field... regarding assert and clear it 
states the n-th sample but in this case...? Why do you need it?

> +	pps->clear_width.nsec = pps_ktime_sub(&pps->assert_tu, &pps->clear_tu);
> +	dev_dbg(pps->dev, "PPS clear width = %llu#%u\n",
> +		pps->clear_width.nsec, pps->clear_width.sequence);
> +}
> +
> +static void pps_calc_assert_width(struct pps_device *pps)
> +{
> +	if (pps->assert_sequence == 0)
> +		return;
> +
> +	pps->assert_width.sequence++;

Ditto.

> +	pps->assert_width.nsec = pps_ktime_sub(&pps->clear_tu, &pps->assert_tu);
> +	dev_dbg(pps->dev, "PPS assert width = %llu#%u\n",
> +		pps->assert_width.nsec, pps->assert_width.sequence);
> +}
> +
>   /* pps_event - register a PPS event into the system
>    * @pps: the PPS device
>    * @ts: the event timestamp
> @@ -191,6 +232,10 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
>   		dev_dbg(pps->dev, "capture assert seq #%u\n",
>   			pps->assert_sequence);
>   
> +		/* Calculate clear pulse-width */
> +		if (pps->params.mode & PPS_WIDTHCLEAR)
> +			pps_calc_clear_width(pps);
> +
>   		captured = ~0;
>   	}
>   	if (event & pps->params.mode & PPS_CAPTURECLEAR) {
> @@ -205,6 +250,10 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
>   		dev_dbg(pps->dev, "capture clear seq #%u\n",
>   			pps->clear_sequence);
>   
> +		/* Calculate assert pulse-width */
> +		if (pps->params.mode & PPS_WIDTHASSERT)
> +			pps_calc_assert_width(pps);
> +
>   		captured = ~0;
>   	}
>   
> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
> index 5d19baae6a38..8299a272af11 100644
> --- a/drivers/pps/pps.c
> +++ b/drivers/pps/pps.c
> @@ -195,6 +195,11 @@ static long pps_cdev_ioctl(struct file *file,
>   		fdata.info.clear_tu = pps->clear_tu;
>   		fdata.info.current_mode = pps->current_mode;
>   
> +		memcpy(&fdata.info.assert_width, &pps->assert_width,
> +		       sizeof(struct pps_kwidth));
> +		memcpy(&fdata.info.clear_width, &pps->clear_width,
> +		       sizeof(struct pps_kwidth));
> +
>   		spin_unlock_irq(&pps->lock);
>   
>   		err = copy_to_user(uarg, &fdata, sizeof(struct pps_fdata));
> @@ -283,6 +288,10 @@ static long pps_cdev_compat_ioctl(struct file *file,
>   				sizeof(struct pps_ktime_compat));
>   		memcpy(&compat.info.clear_tu, &pps->clear_tu,
>   				sizeof(struct pps_ktime_compat));
> +		memcpy(&compat.info.assert_width, &pps->assert_width,
> +		       sizeof(struct pps_kwidth_compat));
> +		memcpy(&compat.info.clear_width, &pps->clear_width,
> +		       sizeof(struct pps_kwidth_compat));
>   
>   		spin_unlock_irq(&pps->lock);
>   
> diff --git a/drivers/pps/sysfs.c b/drivers/pps/sysfs.c
> index 134bc33f6ad0..3e34de77dba6 100644
> --- a/drivers/pps/sysfs.c
> +++ b/drivers/pps/sysfs.c
> @@ -79,6 +79,34 @@ static ssize_t path_show(struct device *dev, struct device_attribute *attr,
>   }
>   static DEVICE_ATTR_RO(path);
>   
> +static ssize_t pulse_width_assert_show(struct device *dev,
> +				       struct device_attribute *attr,
> +				       char *buf)
> +{
> +	struct pps_device *pps = dev_get_drvdata(dev);
> +
> +	if (!(pps->info.mode & PPS_WIDTHASSERT))
> +		return 0;
> +
> +	return sprintf(buf, "%llu#%u\n",
> +		       pps->assert_width.nsec, pps->assert_width.sequence);
> +}
> +static DEVICE_ATTR_RO(pulse_width_assert);
> +
> +static ssize_t pulse_width_clear_show(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	struct pps_device *pps = dev_get_drvdata(dev);
> +
> +	if (!(pps->info.mode & PPS_WIDTHCLEAR))
> +		return 0;
> +
> +	return sprintf(buf, "%llu#%u\n",
> +		       pps->clear_width.nsec, pps->clear_width.sequence);
> +}
> +static DEVICE_ATTR_RO(pulse_width_clear);
> +
>   static struct attribute *pps_attrs[] = {
>   	&dev_attr_assert.attr,
>   	&dev_attr_clear.attr,
> @@ -86,6 +114,8 @@ static struct attribute *pps_attrs[] = {
>   	&dev_attr_echo.attr,
>   	&dev_attr_name.attr,
>   	&dev_attr_path.attr,
> +	&dev_attr_pulse_width_assert.attr,
> +	&dev_attr_pulse_width_clear.attr,
>   	NULL,
>   };
>   
> diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
> index 78c8ac4951b5..15f2338095c6 100644
> --- a/include/linux/pps_kernel.h
> +++ b/include/linux/pps_kernel.h
> @@ -51,6 +51,9 @@ struct pps_device {
>   	struct pps_ktime clear_tu;
>   	int current_mode;			/* PPS mode at event time */
>   
> +	struct pps_kwidth assert_width;		/* PPS assert pulse-width time and event seq # */
> +	struct pps_kwidth clear_width;		/* PPS clear pulse-width time and event seq # */
> +
>   	unsigned int last_ev;			/* last PPS event id */
>   	wait_queue_head_t queue;		/* PPS event queue */
>   
> diff --git a/include/uapi/linux/pps.h b/include/uapi/linux/pps.h
> index 009ebcd8ced5..dd93dac0afc1 100644
> --- a/include/uapi/linux/pps.h
> +++ b/include/uapi/linux/pps.h
> @@ -64,12 +64,24 @@ struct pps_ktime_compat {
>   } __attribute__((packed, aligned(4)));
>   #define PPS_TIME_INVALID	(1<<0)	/* used to specify timeout==NULL */
>   
> +struct pps_kwidth {
> +	__u64 nsec;
> +	__u32 sequence;
> +};
> +
> +struct pps_kwidth_compat {
> +	__u64 nsec;
> +	__u32 sequence;
> +} __attribute__((packed, aligned(4)));

Why do you need a new type? Since both assert_width and clear_width are time 
quantities as far as assert_tu and clear_tu, they can be of the same type, can't 
they? Or, at least they can simply be __u64 since having an assert_width or 
clear_width longer than 1 second is a non-sense...

>   struct pps_kinfo {
>   	__u32 assert_sequence;		/* seq. num. of assert event */
>   	__u32 clear_sequence; 		/* seq. num. of clear event */
>   	struct pps_ktime assert_tu;	/* time of assert event */
>   	struct pps_ktime clear_tu;	/* time of clear event */
>   	int current_mode;		/* current mode bits */
> +	struct pps_kwidth assert_width;	/* assert pulse-width time and seq. num. */
> +	struct pps_kwidth clear_width;	/* clear pulse-width time and seq. num. */
>   };

Altering this structure may break userspace code... also rfc2783 at section-3.2 
states that:

    The API defines these new data structures:

       typedef struct {
           pps_seq_t   assert_sequence;        /* assert event seq # */
           pps_seq_t   clear_sequence;         /* clear event seq # */
           pps_timeu_t assert_tu;
           pps_timeu_t clear_tu;
           int         current_mode;           /* current mode bits */
       } pps_info_t;

So, I'm not willing to change this structure just to add this new data that I 
don't even know where it's used...

If you just read these information via sysfs, please drop these part.

>   struct pps_kinfo_compat {
> @@ -78,6 +90,8 @@ struct pps_kinfo_compat {
>   	struct pps_ktime_compat assert_tu;	/* time of assert event */
>   	struct pps_ktime_compat clear_tu;	/* time of clear event */
>   	int current_mode;			/* current mode bits */
> +	struct pps_kwidth_compat assert_width;	/* assert pulse-width time and seq. num. */
> +	struct pps_kwidth_compat clear_width;	/* clear pulse-width time and seq. num. */
>   };
>   
>   struct pps_kparams {
> @@ -96,6 +110,11 @@ struct pps_kparams {
>   #define PPS_CAPTURECLEAR	0x02	/* capture clear events */
>   #define PPS_CAPTUREBOTH		0x03	/* capture assert and clear events */
>   
> +/* Pulse-width calculation */
> +#define PPS_WIDTHASSERT		0x04	/* calculate assert width */
> +#define PPS_WIDTHCLEAR		0x08	/* calculate clear width */
> +#define PPS_WIDTHBOTH		0x0c	/* calculate assert and clear width */
> +

I don't understand why a process should ask for just PPS_WIDTHASSERT or 
PPS_WIDTHCLEAR... I think you can avoid defining these values and just enabling 
pulse width calculation when both assert and clear events are available.

>   #define PPS_OFFSETASSERT	0x10	/* apply compensation for assert event */
>   #define PPS_OFFSETCLEAR		0x20	/* apply compensation for clear event */

However, the real point is: since an userpsace program can retrieve the time of 
assert and clear events, why it cannot compute the pulses width by itself? :)

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

