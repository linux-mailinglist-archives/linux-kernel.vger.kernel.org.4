Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A514F74586E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjGCJcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjGCJcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:32:13 -0400
Received: from smtpdh17-1.aruba.it (smtpdh17-1.aruba.it [62.149.155.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F4FE4E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 02:32:08 -0700 (PDT)
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id GFufqlku0a6DNGFugqZ2g5; Mon, 03 Jul 2023 11:32:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1688376726; bh=Xf3gbhWB8daneTyX1ilBnLjWlqVA27bc3bXVzj9hk1M=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=n/hSl1zJPwBoQsJySSmKNJQGIviSWDDHoHc/q9M4Us8Xd+/hATBkgRhdSs2c+0deW
         xjkYzxCOR8Ug3HVw6wi/XiZco8SHFqT1jHerLWgiMI5iGUpxIdg/k6/FUewa6BEsfZ
         I6skMPXmsymtUkI4P2l0ji5G/vAYkzKKm3/DZfKUFOWj64znnprX4ygDTjdzFOtMFY
         6wPG5VD5W7g3gntktcxKKyTgsr+A8wX29aGnIRbysyhrwfT6GfqMFC6PwZ9e7IPO7n
         EdkFP+lbJAKYoxWCYL2zvPh4EQz84YTzdiEeEdn1zWtjC3xrMhq+OI19wR7a1UuLnz
         WZjPsWqukkgAA==
Message-ID: <1d4418a1-d91b-9558-7d7e-8d9940bf0470@enneenne.com>
Date:   Mon, 3 Jul 2023 11:32:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/5] pps: add pulse-width calculation in nsec
Content-Language: en-US
To:     "Farber, Eliav" <farbere@amazon.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ronenk@amazon.com, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, itamark@amazon.com, shellykz@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com
References: <20230625142134.33690-1-farbere@amazon.com>
 <20230625142134.33690-2-farbere@amazon.com>
 <6b6dd2ae-a30d-4f25-f696-c01f2e5a4a1e@enneenne.com>
 <98aeb2ce-7a3e-116b-f16d-6c6f98aa9ac3@amazon.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <98aeb2ce-7a3e-116b-f16d-6c6f98aa9ac3@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfL1Ewmckcf+nbkjBSqkOajb1V1EVAOULZu9iH+kz11M1jEZ2JrrV30zh2dDMFYcVAGFXtb+6VdF+EC4EUlwoz9oiMJdNAuf36SCjrnX+oaZ7rXIGJnDr
 YuQ93bODQ5P4YpcRCjGsWStIDBg5AOJfJmU6QLQuzHFjPdAArTf5PRgtYdXPiSat3+MDFgIPW1JQIRfH8xXcKb6NCCpAE2pIfTwS4oQ+LZg1uYXqmwsteCPs
 MRSWltvUiivkvp1bCXnHWr5kte/wsPYujV9zIwuVMV0sSJe8twH7lW4P0V0ajDNdBFXNwZkepQxeoMrhLDOAGPRd1uekt8Mb2uqxMQKk5cFoNXx/fvfMVSeK
 KY0GQW/HVSt5Pp/ItIdkXgiLP/Rl+teHqbTZnM7uYzJAU2bfumE4zKw+tO5uD/Y2TUDJIAd5XH68EP6T95VlAWA14X8A9Mx2Z1HjD/L5zd+TGFGaNxJbqtWk
 U1kBl+TJlp7BrKVwEay/7oK+Dum/x4CRqQHKOQsgJSuc/X+AfHuo/hA0sJMomX5jox3XMSk6QoiOjuYAJGGZe0CRI/DQQZx27Nvlvg2lJeQmKt7WkD961uSi
 M1eB6xupMnXTC78u//YaURzR
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/23 14:20, Farber, Eliav wrote:
> On 6/27/2023 5:27 PM, Rodolfo Giometti wrote:
>> On 25/06/23 16:21, Eliav Farber wrote:
>>> This change adds PPS pulse-width calculation in nano seconds.
>>> Width time can be calculated for both assert time and reset time.
>>>
>>> Calculation can be done only if capture ASSERT and capture CLEAR modes
>>> are both enabled.
>>>
>>> Assert width is calculated as:
>>>    clear-time - assert-time
>>> and clear width is calculated as:
>>>    assert-time - clear-time
>>>
>>> Read-only sysfs were added to get the last pulse-width time and event
>>> sequence.
>>> Examples:
>>>   * cat /sys/class/pps/pps0/pulse_width_assert
>>>     20001450#85
>>>   * cat /sys/class/pps/pps1/pulse_width_clear
>>>     979893314#16
>>>
>>> Signed-off-by: Eliav Farber <farbere@amazon.com>
>>> ---
>>>   drivers/pps/kapi.c         | 49 ++++++++++++++++++++++++++++++++++++++
>>>   drivers/pps/pps.c          |  9 +++++++
>>>   drivers/pps/sysfs.c        | 30 +++++++++++++++++++++++
>>>   include/linux/pps_kernel.h |  3 +++
>>>   include/uapi/linux/pps.h   | 19 +++++++++++++++
>>>   5 files changed, 110 insertions(+)
>>>
>>> diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
>>> index d9d566f70ed1..deeecfc0a3ee 100644
>>> --- a/drivers/pps/kapi.c
>>> +++ b/drivers/pps/kapi.c
>>> @@ -82,6 +82,14 @@ struct pps_device *pps_register_source(struct 
>>> pps_source_info *info,
>>>               goto pps_register_source_exit;
>>>       }
>>>
>>> +     if ((info->mode & PPS_WIDTHBOTH) &&
>>> +         ((info->mode & PPS_CAPTUREBOTH) != PPS_CAPTUREBOTH)) {
>>> +             pr_err("%s: width can't be calculated without both captures 
>>> (mode = 0x%x)\n",
>>> +                    info->name, info->mode);
>>> +             err = -EINVAL;
>>> +             goto pps_register_source_exit;
>>> +     }
>>
>> See the comment below where you define PPS_WIDTHBOTH.
>>
>>>       /* Allocate memory for the new PPS source struct */
>>>       pps = kzalloc(sizeof(struct pps_device), GFP_KERNEL);
>>>       if (pps == NULL) {
>>> @@ -143,6 +151,39 @@ void pps_unregister_source(struct pps_device *pps)
>>>   }
>>>   EXPORT_SYMBOL(pps_unregister_source);
>>>
>>> +static u64 pps_ktime_sub(struct pps_ktime *ts1, struct pps_ktime *ts2)
>>> +{
>>> +     if (ts1->sec == ts2->sec)
>>> +             return (ts1->nsec > ts2->nsec) ? (ts1->nsec - ts2->nsec) : 
>>> (ts2->nsec - ts1->nsec);
>>> +
>>> +     if (ts1->sec > ts2->sec)
>>> +             return (ts1->sec - ts2->sec) * NSEC_PER_SEC + ts1->nsec - 
>>> ts2->nsec;
>>> +
>>> +     return (ts2->sec - ts1->sec) * NSEC_PER_SEC + ts2->nsec - ts1->nsec;
>>> +}
>>> +
>>> +static void pps_calc_clear_width(struct pps_device *pps)
>>> +{
>>> +     if (pps->clear_sequence == 0)
>>> +             return;
>>> +
>>> +     pps->clear_width.sequence++;
>>
>> I don't understand the meaning of this field... regarding assert and clear it
>> states the n-th sample but in this case...? Why do you need it?
> 
> For assert and clear, the sequence parameter is basically the counter
> of assert/clear events.
> Similarly, I wanted to have a counter for the number of pulses which
> there width was counted.
> The sequence was used by me in the sysfs to show the pulse counter and
> pulse width in nano-seconds.
> Will counter make more sense instead of sequence?
> Initially, I used the assert_sequence and clear_sequence as the pulse
> counter, but there were few cases to handle.
> In case first interrupt happened during a pulse, then
> assert_sequence != clear_sequence, but if not then
> assert_sequence == clear_sequence.
> So I preferred to add an new independent value.

OK.

>>> +     pps->clear_width.nsec = pps_ktime_sub(&pps->assert_tu, &pps->clear_tu);
>>> +     dev_dbg(pps->dev, "PPS clear width = %llu#%u\n",
>>> +             pps->clear_width.nsec, pps->clear_width.sequence);
>>> +}
>>> +
>>> +static void pps_calc_assert_width(struct pps_device *pps)
>>> +{
>>> +     if (pps->assert_sequence == 0)
>>> +             return;
>>> +
>>> +     pps->assert_width.sequence++;
>>
>> Ditto.
>>
>>> +     pps->assert_width.nsec = pps_ktime_sub(&pps->clear_tu, &pps->assert_tu);
>>> +     dev_dbg(pps->dev, "PPS assert width = %llu#%u\n",
>>> +             pps->assert_width.nsec, pps->assert_width.sequence);
>>> +}
>>> +
>>>   /* pps_event - register a PPS event into the system
>>>    * @pps: the PPS device
>>>    * @ts: the event timestamp
>>> @@ -191,6 +232,10 @@ void pps_event(struct pps_device *pps, struct 
>>> pps_event_time *ts, int event,
>>>               dev_dbg(pps->dev, "capture assert seq #%u\n",
>>>                       pps->assert_sequence);
>>>
>>> +             /* Calculate clear pulse-width */
>>> +             if (pps->params.mode & PPS_WIDTHCLEAR)
>>> +                     pps_calc_clear_width(pps);
>>> +
>>>               captured = ~0;
>>>       }
>>>       if (event & pps->params.mode & PPS_CAPTURECLEAR) {
>>> @@ -205,6 +250,10 @@ void pps_event(struct pps_device *pps, struct 
>>> pps_event_time *ts, int event,
>>>               dev_dbg(pps->dev, "capture clear seq #%u\n",
>>>                       pps->clear_sequence);
>>>
>>> +             /* Calculate assert pulse-width */
>>> +             if (pps->params.mode & PPS_WIDTHASSERT)
>>> +                     pps_calc_assert_width(pps);
>>> +
>>>               captured = ~0;
>>>       }
>>>
>>> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
>>> index 5d19baae6a38..8299a272af11 100644
>>> --- a/drivers/pps/pps.c
>>> +++ b/drivers/pps/pps.c
>>> @@ -195,6 +195,11 @@ static long pps_cdev_ioctl(struct file *file,
>>>               fdata.info.clear_tu = pps->clear_tu;
>>>               fdata.info.current_mode = pps->current_mode;
>>>
>>> +             memcpy(&fdata.info.assert_width, &pps->assert_width,
>>> +                    sizeof(struct pps_kwidth));
>>> +             memcpy(&fdata.info.clear_width, &pps->clear_width,
>>> +                    sizeof(struct pps_kwidth));
>>> +
>>>               spin_unlock_irq(&pps->lock);
>>>
>>>               err = copy_to_user(uarg, &fdata, sizeof(struct pps_fdata));
>>> @@ -283,6 +288,10 @@ static long pps_cdev_compat_ioctl(struct file *file,
>>>                               sizeof(struct pps_ktime_compat));
>>>               memcpy(&compat.info.clear_tu, &pps->clear_tu,
>>>                               sizeof(struct pps_ktime_compat));
>>> +             memcpy(&compat.info.assert_width, &pps->assert_width,
>>> +                    sizeof(struct pps_kwidth_compat));
>>> +             memcpy(&compat.info.clear_width, &pps->clear_width,
>>> +                    sizeof(struct pps_kwidth_compat));
>>>
>>>               spin_unlock_irq(&pps->lock);
>>>
>>> diff --git a/drivers/pps/sysfs.c b/drivers/pps/sysfs.c
>>> index 134bc33f6ad0..3e34de77dba6 100644
>>> --- a/drivers/pps/sysfs.c
>>> +++ b/drivers/pps/sysfs.c
>>> @@ -79,6 +79,34 @@ static ssize_t path_show(struct device *dev, struct 
>>> device_attribute *attr,
>>>   }
>>>   static DEVICE_ATTR_RO(path);
>>>
>>> +static ssize_t pulse_width_assert_show(struct device *dev,
>>> +                                    struct device_attribute *attr,
>>> +                                    char *buf)
>>> +{
>>> +     struct pps_device *pps = dev_get_drvdata(dev);
>>> +
>>> +     if (!(pps->info.mode & PPS_WIDTHASSERT))
>>> +             return 0;
>>> +
>>> +     return sprintf(buf, "%llu#%u\n",
>>> +                    pps->assert_width.nsec, pps->assert_width.sequence);
>>> +}
>>> +static DEVICE_ATTR_RO(pulse_width_assert);
>>> +
>>> +static ssize_t pulse_width_clear_show(struct device *dev,
>>> +                                   struct device_attribute *attr,
>>> +                                   char *buf)
>>> +{
>>> +     struct pps_device *pps = dev_get_drvdata(dev);
>>> +
>>> +     if (!(pps->info.mode & PPS_WIDTHCLEAR))
>>> +             return 0;
>>> +
>>> +     return sprintf(buf, "%llu#%u\n",
>>> +                    pps->clear_width.nsec, pps->clear_width.sequence);
>>> +}
>>> +static DEVICE_ATTR_RO(pulse_width_clear);
>>> +
>>>   static struct attribute *pps_attrs[] = {
>>>       &dev_attr_assert.attr,
>>>       &dev_attr_clear.attr,
>>> @@ -86,6 +114,8 @@ static struct attribute *pps_attrs[] = {
>>>       &dev_attr_echo.attr,
>>>       &dev_attr_name.attr,
>>>       &dev_attr_path.attr,
>>> +     &dev_attr_pulse_width_assert.attr,
>>> +     &dev_attr_pulse_width_clear.attr,
>>>       NULL,
>>>   };
>>>
>>> diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
>>> index 78c8ac4951b5..15f2338095c6 100644
>>> --- a/include/linux/pps_kernel.h
>>> +++ b/include/linux/pps_kernel.h
>>> @@ -51,6 +51,9 @@ struct pps_device {
>>>       struct pps_ktime clear_tu;
>>>       int current_mode;                       /* PPS mode at event time */
>>>
>>> +     struct pps_kwidth assert_width;         /* PPS assert pulse-width time 
>>> and event seq # */
>>> +     struct pps_kwidth clear_width;          /* PPS clear pulse-width time 
>>> and event seq # */
>>> +
>>>       unsigned int last_ev;                   /* last PPS event id */
>>>       wait_queue_head_t queue;                /* PPS event queue */
>>>
>>> diff --git a/include/uapi/linux/pps.h b/include/uapi/linux/pps.h
>>> index 009ebcd8ced5..dd93dac0afc1 100644
>>> --- a/include/uapi/linux/pps.h
>>> +++ b/include/uapi/linux/pps.h
>>> @@ -64,12 +64,24 @@ struct pps_ktime_compat {
>>>   } __attribute__((packed, aligned(4)));
>>>   #define PPS_TIME_INVALID    (1<<0)  /* used to specify timeout==NULL */
>>>
>>> +struct pps_kwidth {
>>> +     __u64 nsec;
>>> +     __u32 sequence;
>>> +};
>>> +
>>> +struct pps_kwidth_compat {
>>> +     __u64 nsec;
>>> +     __u32 sequence;
>>> +} __attribute__((packed, aligned(4)));
>>
>> Why do you need a new type? Since both assert_width and clear_width are time
>> quantities as far as assert_tu and clear_tu, they can be of the same type, can't
>> they? Or, at least they can simply be __u64 since having an assert_width or
>> clear_width longer than 1 second is a non-sense...
> 
> For each pulse I wanted to save width in nsec (without sec) and
> counter.
> I need it twice for both assert and clear, hence I added a new
> structure for it.

I see, but I prefere you do as in struct pps_kinfo where times are times and 
sequence numbers are numbers, and not mixing them.

>>>   struct pps_kinfo {
>>>       __u32 assert_sequence;          /* seq. num. of assert event */
>>>       __u32 clear_sequence;           /* seq. num. of clear event */
>>>       struct pps_ktime assert_tu;     /* time of assert event */
>>>       struct pps_ktime clear_tu;      /* time of clear event */
>>>       int current_mode;               /* current mode bits */
>>> +     struct pps_kwidth assert_width; /* assert pulse-width time and seq. 
>>> num. */
>>> +     struct pps_kwidth clear_width;  /* clear pulse-width time and seq. num. */
>>>   };
>>
>> Altering this structure may break userspace code... also rfc2783 at section-3.2
>> states that:
>>
>>    The API defines these new data structures:
>>
>>       typedef struct {
>>           pps_seq_t   assert_sequence;        /* assert event seq # */
>>           pps_seq_t   clear_sequence;         /* clear event seq # */
>>           pps_timeu_t assert_tu;
>>           pps_timeu_t clear_tu;
>>           int         current_mode;           /* current mode bits */
>>       } pps_info_t;
>>
>> So, I'm not willing to change this structure just to add this new data that I
>> don't even know where it's used...
>>
>> If you just read these information via sysfs, please drop these part.
> 
> ACK. I'll drop this part.
> 
>>>   struct pps_kinfo_compat {
>>> @@ -78,6 +90,8 @@ struct pps_kinfo_compat {
>>>       struct pps_ktime_compat assert_tu;      /* time of assert event */
>>>       struct pps_ktime_compat clear_tu;       /* time of clear event */
>>>       int current_mode;                       /* current mode bits */
>>> +     struct pps_kwidth_compat assert_width;  /* assert pulse-width time and 
>>> seq. num. */
>>> +     struct pps_kwidth_compat clear_width;   /* clear pulse-width time and 
>>> seq. num. */
>>>   };
>>>
>>>   struct pps_kparams {
>>> @@ -96,6 +110,11 @@ struct pps_kparams {
>>>   #define PPS_CAPTURECLEAR    0x02    /* capture clear events */
>>>   #define PPS_CAPTUREBOTH             0x03    /* capture assert and clear 
>>> events */
>>>
>>> +/* Pulse-width calculation */
>>> +#define PPS_WIDTHASSERT              0x04    /* calculate assert width */
>>> +#define PPS_WIDTHCLEAR               0x08    /* calculate clear width */
>>> +#define PPS_WIDTHBOTH                0x0c    /* calculate assert and clear 
>>> width */
>>> +
>>
>> I don't understand why a process should ask for just PPS_WIDTHASSERT or
>> PPS_WIDTHCLEAR... I think you can avoid defining these values and just enabling
>> pulse width calculation when both assert and clear events are available. 
> 
> ACK. I'll drop the new defines and enable width calculation when
> PPS_CAPTUREASSERT and PPS_CAPTURECLEAR are both defined.
> 
>>>   #define PPS_OFFSETASSERT    0x10    /* apply compensation for assert event */
>>>   #define PPS_OFFSETCLEAR             0x20    /* apply compensation for clear 
>>> event */
>>
>> However, the real point is: since an userpsace program can retrieve the time of
>> assert and clear events, why it cannot compute the pulses width by itself? :)
> 
> The userpsace program can retrieve the time of assert and clear events,
> but it is not always clear how to compute it.
> Initially that was how I did it:
> Read both times, make sure sequence of both times was identical, and
> then compute: clear_time – assert_time.
> But as I mentioned, when using wide pulses, it might be that when
> driver starts, it is a the middle of a pulse.
> In that case clear_time will be captured first (seq #1).
> Then assert_time is captured (seq #1).
> However, assert pulse width can only be calculated for the second
> clear-time sequence and first assert-time sequence.
> So to simplify this for the user, I added the calculation to the
> driver.
> Hope this was clear.
> Please let me know if this satisfies you, and then I’ll share a second
> version of patches which fixes all the other comments you gave.

Mmm... kernel drivers should implement mechanisms and not policies and since 
RFC2783 doesn't state this computation I think you are implementing a policy.

Let me suggest to add this piece of code to the pps-utils (maybe within the 
ppstest.c utility).

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

