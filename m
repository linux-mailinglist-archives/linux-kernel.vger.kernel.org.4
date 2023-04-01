Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A926F6D2FAF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 12:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjDAKid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 06:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDAKic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 06:38:32 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEDFC646;
        Sat,  1 Apr 2023 03:38:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id C014C604FD;
        Sat,  1 Apr 2023 12:38:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680345508; bh=zfez76pr4C17QXaLT7/s2e7FjV7iO0tEdyPZWYJsuvc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=drZUwpp60pcdrm//RGjluWUlfF6emiNUv8p+DVHxLpVa0AenfvgWDXtmfcTwxvyZz
         gmUV8FIDtdGlUCV8Qh7/+gjtudIzXnqnc37cL7DmeAqSa/Dk8b3w5KhxBdfjqhqyH9
         h+1UgNe53IP7v9r9gxqde8BvzCBt/KNovtZGHK1Kc0VmR7VFRn2uGiBDA1cNl+ZKQy
         YfIdB9kxZctvnq6AX2f3uD2GuX3rAqfdgvTkJbPMWhIsfJThoBs29yFbkg827XYgz3
         CP+MMM6eyfP6xaATTCdTwNxSVblvqYO7ZzfviKbUr9FzE8JD/Bb4fjf3Rmdt+99QHL
         FCDgxOt7nhS7A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pNSFLYyQIbA3; Sat,  1 Apr 2023 12:38:26 +0200 (CEST)
Received: from [192.168.1.3] (unknown [77.237.101.225])
        by domac.alu.hr (Postfix) with ESMTPSA id BC925604F0;
        Sat,  1 Apr 2023 12:38:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680345506; bh=zfez76pr4C17QXaLT7/s2e7FjV7iO0tEdyPZWYJsuvc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Xcljmmh2xUm1ewq0x4fxR0gg1tHT+JOx0maOepNJcq6pA9sxD7yY5TXflMkUmPux7
         HeWqKd0C9HRzLm6iO7iQUacQJoyUzUgVQwAUgwIbeUr49sJbQojUdw9T4UO86ys0jz
         052Xg2C8RYh4V7d+p8Xf6NBPs0KiWJ5GneNo2Kboy3aER2FO4w4Lx3K4qHRb/lJMt1
         h8QeA347R+MH+hkiPSyzEB7YtPCUSgKA0p5wyhRp2CvB/i4dBuVvyyQH6re0lY6NGA
         pqHjeWDEIr8js0X2nKNxIzQw99RfhJkHAUIRXo7qdGUeqEYVL9CMRZpSTkYsXu+6mE
         j/w3zg6X17O6w==
Message-ID: <f4e312de-e1f1-7ed5-730f-1c314ed0262c@alu.unizg.hr>
Date:   Sat, 1 Apr 2023 12:38:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: BUG FIX: [PATCH RFC v3] memstick_check() memleak in kernel 6.1.0+
 introduced pre 4.17
Content-Language: en-US, hr
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hannes Reinecke <hare@suse.de>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        ye xingchen <ye.xingchen@zte.com.cn>, linux-mmc@vger.kernel.org
References: <f74219a7-1607-deb4-a6ae-7b73e2467ac7@alu.unizg.hr>
 <df560535-2a8e-de21-d45d-805159d70954@alu.unizg.hr>
 <2023033124-causing-cassette-4d96@gregkh>
 <4d80549f-e59d-6319-07fd-1fbed75d7a1c@alu.unizg.hr>
 <ZCfO90WwyS6JwaHi@kroah.com> <ZCfQQDkw3D_BXJaZ@kroah.com>
 <2023040127-untrue-obtrusive-1ea4@gregkh>
 <2023040112-immovably-cytoplasm-44ee@gregkh>
 <0611c29a-7dd1-a160-cc2b-e149531bfffa@alu.unizg.hr>
 <e9436b43-8bc8-e810-3529-44d1351385ca@alu.unizg.hr>
 <2023040117-skimmer-quaintly-d4b4@gregkh>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <2023040117-skimmer-quaintly-d4b4@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01. 04. 2023. 12:14, Greg KH wrote:
> On Sat, Apr 01, 2023 at 12:01:43PM +0200, Mirsad Goran Todorovac wrote:
>> On 01. 04. 2023. 11:52, Mirsad Goran Todorovac wrote:
>>> On 01. 04. 2023. 11:23, Greg KH wrote:
>>>> On Sat, Apr 01, 2023 at 11:18:19AM +0200, Greg KH wrote:
>>>>> On Sat, Apr 01, 2023 at 08:33:36AM +0200, Greg KH wrote:
>>>>>> On Sat, Apr 01, 2023 at 08:28:07AM +0200, Greg KH wrote:
>>>>>>> On Sat, Apr 01, 2023 at 08:23:26AM +0200, Mirsad Goran Todorovac wrote:
>>>>>>>>> This patch is implying that anyone who calls "dev_set_name()" also has
>>>>>>>>> to do this hack, which shouldn't be the case at all.
>>>>>>>>>
>>>>>>>>> thanks,
>>>>>>>>>
>>>>>>>>> greg k-h
>>>>>>>>
>>>>>>>> This is my best guess. Unless there is dev_free_name() or kobject_free_name(), I don't
>>>>>>>> see a more sensible way to patch this up.
>>>>>>>
>>>>>>> In sleeping on this, I think this has to move to the driver core.  I
>>>>>>> don't understand why we haven't seen this before, except maybe no one
>>>>>>> has really noticed before (i.e. we haven't had good leak detection tools
>>>>>>> that run with removable devices?)
>>>>>>>
>>>>>>> Anyway, let me see if I can come up with something this weekend, give me
>>>>>>> a chance...
>>>>>>
>>>>>> Wait, no, this already should be handled by the kobject core, look at
>>>>>> kobject_cleanup(), at the bottom.  So your change should be merely
>>>>>> duplicating the logic there that already runs when the struct device is
>>>>>> freed, right?
>>>>>>
>>>>>> So I don't understand why your change works, odd.  I need more coffee...
>>>>>
>>>>> I think you got half of the change correctly.  This init code is a maze
>>>>> of twisty passages, let me take your patch and tweak it a bit into
>>>>> something that I think should work.  This looks to be only a memstick
>>>>> issue, not a driver core issue (which makes me feel better.)
>>>>
>>>> Oops, forgot the patch.  Can you try this change here and let me know if
>>>> that solves the problem or not?  I have compile-tested it only, so I
>>>> have no idea if it works.
>>>>
>>>> If this does work, I'll make up a "real" function to replace the
>>>> horrible dev.kobj.name mess that a driver would have to do here as it
>>>> shouldn't be required that a driver author knows the internals of the
>>>> driver core that well...
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>>
>>>> --------------------
>>>>
>>>>
>>>> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
>>>> index bf7667845459..bbfaf6536903 100644
>>>> --- a/drivers/memstick/core/memstick.c
>>>> +++ b/drivers/memstick/core/memstick.c
>>>> @@ -410,6 +410,7 @@ static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
>>>>  	return card;
>>>>  err_out:
>>>>  	host->card = old_card;
>>>> +	kfree_const(card->dev.kobj.name);
>>>>  	kfree(card);
>>>>  	return NULL;
>>>>  }
>>>> @@ -468,8 +469,10 @@ static void memstick_check(struct work_struct *work)
>>>>  				put_device(&card->dev);
>>>>  				host->card = NULL;
>>>>  			}
>>>> -		} else
>>>> +		} else {
>>>> +			kfree_const(card->dev.kobj.name);
>>>>  			kfree(card);
>>>> +		}
>>>>  	}
>>>>  
>>>>  out_power_off:
>>>
>>> I thought of this version, but I am not sure about tracking the device_register() and
>>> device_unregister() calls?
>>>
>>> put_device() calls put_kobject() which frees the const char *kobj.name ...
>>>
>>> I thought how host cannot just be kfree()d when host->card is still allocated.
>>> And it is a pointer. That also seems to me like a bug :-/
>>>
>>> Kind regards,
>>> Mirsad
>>>
>>> ---
>>> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
>>> index bf7667845459..46c7bda9715d 100644
>>> --- a/drivers/memstick/core/memstick.c
>>> +++ b/drivers/memstick/core/memstick.c
>>> @@ -179,6 +179,8 @@ static void memstick_free(struct device *dev)
>>>  {
>>>         struct memstick_host *host = container_of(dev, struct memstick_host,
>>>                                                   dev);
>>> +       if (host->card && host->card->dev)
>>> +               put_device(&host->card->dev);
>>>         kfree(host);
>>>  }
>>>  
>>> @@ -410,7 +412,7 @@ static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
>>>         return card;
>>>  err_out:
>>>         host->card = old_card;
>>> -       kfree(card);
>>> +       put_device(&card->dev);
>>>         return NULL;
>>>  }
>>>  
>>> @@ -468,8 +470,9 @@ static void memstick_check(struct work_struct *work)
>>>                                 put_device(&card->dev);
>>>                                 host->card = NULL;
>>>                         }
>>> -               } else
>>> -                       kfree(card);
>>> +               } else {
>>> +                       put_device(&card->dev);
>>> +               }
>>>         }
>>>  
>>>  out_power_off:
>>
>> Thousand apologies, the previous version had a compilation error. I've sent the untested
>> version.
>>
>> I must have become over-confident. But they say that a mistake that makes you humbled
>> is better than success that makes you arrogant :-|
>>
>> I would like your opinion on the patch before I actually start the kernel, for I won't
>> be able to reboot clean that machine if it hangs in kernel until Tuesday :-(
>>
>> It seems that put_device() would call the release method of the device and kfree() in
>> it, but I cannot say anything about the side effects, for I do not know the source so
>> well ...
>>
>> Kind regards,
>> Mirsad
>>
>> ---
>> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
>> index bf7667845459..c63250322e26 100644
>> --- a/drivers/memstick/core/memstick.c
>> +++ b/drivers/memstick/core/memstick.c
>> @@ -179,6 +179,8 @@ static void memstick_free(struct device *dev)
>>  {
>>         struct memstick_host *host = container_of(dev, struct memstick_host,
>>                                                   dev);
>> +       if (host->card)
>> +               put_device(&host->card->dev);
> 
> This isn't going to work as at this moment in time, the last reference
> count has already happened, causing this release callback to be called,
> so that the bus driver can free the memory for the device.
> 
> So you would be calling put_device() on a device already has 0 for a
> reference count :)
> 
>>         kfree(host);
>>  }
>>  
>> @@ -410,7 +412,7 @@ static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
>>         return card;
>>  err_out:
>>         host->card = old_card;
>> -       kfree(card);
>> +       put_device(&card->dev);
> 
> No, the device was not registered here yet, right?  That would be
> required _IFF_ there was a call to device_register().
> 
>>         return NULL;
>>  }
>>  
>> @@ -468,8 +470,9 @@ static void memstick_check(struct work_struct *work)
>>                                 put_device(&card->dev);
>>                                 host->card = NULL;
>>                         }
>> -               } else
>> -                       kfree(card);
>> +               } else {
>> +                       put_device(&card->dev);
> 
> Same here, unless I'm reading this wrong, device_register() had not been
> called yet, which is why the kfree was required (same for the above
> call).
> 
> But hey, this driver really is a maze of twisty callbacks and workqueues
> and complexity, for no obvious reason to me (maybe because of some async
> requirement for memstick devices?  Thankfully I no longer have this
> hardware...)  So I might be totally wrong...
> 
> I would recommend trying my version first, it "shouldn't" cause anything
> worse to happen from what you have today, but hey, that's just my guess.
> 
> thanks,
> 
> greg k-h

Hi Mr. Greg,

Thank you for the additional insight.

I will build your patch ASAP and give feedback.

Kind regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

"I see something approaching fast ... Will it be friends with me?"

