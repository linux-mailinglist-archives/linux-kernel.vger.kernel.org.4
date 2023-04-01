Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED73D6D2F82
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 11:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjDAJxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 05:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjDAJxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 05:53:08 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AF8FF0D;
        Sat,  1 Apr 2023 02:53:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 3DCFD604FD;
        Sat,  1 Apr 2023 11:53:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680342783; bh=aqqX5dY92q5o1FuDvow8C+7JmUObcJejQAMTK5X1dBs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rNEcJciLPOKF/obCcmIfpK52D1lTtmpeGbN9GqixO5QiF5mnrhvHbgtY7QREVdePI
         E3SK8mU81jLMDP1F15Coz3Ich0o4g39OCh2pmKT+P6zWr1i6iJ6BMKILfsz9Sh7H6s
         CkIoh7jfSeH5K41v3LwNU7vIVi+JQcc8Ag77Fv4/H5s1p+Oi3S2kt0GFH53++qCNh4
         zmybP6XWsq5H4d7nQvvYJhfIYJvFNwAooJzHsid3USerDLzjzBisHF7f6B0Aitwic3
         J7LQKL0k7PqF0H5DDD75qSPLbPi9JWbj8CB5dqZFw06+lXwWk6TsHHcZ1/xm9XsHOF
         Up4AICQ+DKm9A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NztcHPlyakHv; Sat,  1 Apr 2023 11:53:00 +0200 (CEST)
Received: from [192.168.1.3] (unknown [77.237.101.225])
        by domac.alu.hr (Postfix) with ESMTPSA id F2E0D604F0;
        Sat,  1 Apr 2023 11:52:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680342780; bh=aqqX5dY92q5o1FuDvow8C+7JmUObcJejQAMTK5X1dBs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hJEYRrWf0NRov0eMYHg/+t1o4+bztYYtTpHKdRb099FuqSOXgvdA4MSy1BZxZ9/br
         YKvI27Hm76J6mHD9MMyUfqZZK81cfComqjxItC6NdX1K4SVyG+k1slz4EWvjuxrYJR
         rZEzUnmCPM2DaeDQ+mEThOZx9LjWOHGe3ZS14KsJuuuYdyy9znANoq0LlFqp/MUCa9
         KH8AnAxtWKcwsS5SUOm7zSmNSIAsWW359M+WbHPZ9ES7G+RLnAdXngPxv7nDbOCXyw
         ob8rldO6EUytw/F+xNu2OBdHE9c5QfBGB9O0yeDVp3uv+2k1SSMUbFWIMewVjctGMh
         312ScTMa9+2aw==
Message-ID: <0611c29a-7dd1-a160-cc2b-e149531bfffa@alu.unizg.hr>
Date:   Sat, 1 Apr 2023 11:52:59 +0200
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
References: <7d873dd3-9bab-175b-8158-c458b61a7122@alu.unizg.hr>
 <f74219a7-1607-deb4-a6ae-7b73e2467ac7@alu.unizg.hr>
 <df560535-2a8e-de21-d45d-805159d70954@alu.unizg.hr>
 <2023033124-causing-cassette-4d96@gregkh>
 <4d80549f-e59d-6319-07fd-1fbed75d7a1c@alu.unizg.hr>
 <ZCfO90WwyS6JwaHi@kroah.com> <ZCfQQDkw3D_BXJaZ@kroah.com>
 <2023040127-untrue-obtrusive-1ea4@gregkh>
 <2023040112-immovably-cytoplasm-44ee@gregkh>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <2023040112-immovably-cytoplasm-44ee@gregkh>
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

On 01. 04. 2023. 11:23, Greg KH wrote:
> On Sat, Apr 01, 2023 at 11:18:19AM +0200, Greg KH wrote:
>> On Sat, Apr 01, 2023 at 08:33:36AM +0200, Greg KH wrote:
>>> On Sat, Apr 01, 2023 at 08:28:07AM +0200, Greg KH wrote:
>>>> On Sat, Apr 01, 2023 at 08:23:26AM +0200, Mirsad Goran Todorovac wrote:
>>>>>> This patch is implying that anyone who calls "dev_set_name()" also has
>>>>>> to do this hack, which shouldn't be the case at all.
>>>>>>
>>>>>> thanks,
>>>>>>
>>>>>> greg k-h
>>>>>
>>>>> This is my best guess. Unless there is dev_free_name() or kobject_free_name(), I don't
>>>>> see a more sensible way to patch this up.
>>>>
>>>> In sleeping on this, I think this has to move to the driver core.  I
>>>> don't understand why we haven't seen this before, except maybe no one
>>>> has really noticed before (i.e. we haven't had good leak detection tools
>>>> that run with removable devices?)
>>>>
>>>> Anyway, let me see if I can come up with something this weekend, give me
>>>> a chance...
>>>
>>> Wait, no, this already should be handled by the kobject core, look at
>>> kobject_cleanup(), at the bottom.  So your change should be merely
>>> duplicating the logic there that already runs when the struct device is
>>> freed, right?
>>>
>>> So I don't understand why your change works, odd.  I need more coffee...
>>
>> I think you got half of the change correctly.  This init code is a maze
>> of twisty passages, let me take your patch and tweak it a bit into
>> something that I think should work.  This looks to be only a memstick
>> issue, not a driver core issue (which makes me feel better.)
> 
> Oops, forgot the patch.  Can you try this change here and let me know if
> that solves the problem or not?  I have compile-tested it only, so I
> have no idea if it works.
> 
> If this does work, I'll make up a "real" function to replace the
> horrible dev.kobj.name mess that a driver would have to do here as it
> shouldn't be required that a driver author knows the internals of the
> driver core that well...
> 
> thanks,
> 
> greg k-h
> 
> --------------------
> 
> 
> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
> index bf7667845459..bbfaf6536903 100644
> --- a/drivers/memstick/core/memstick.c
> +++ b/drivers/memstick/core/memstick.c
> @@ -410,6 +410,7 @@ static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
>  	return card;
>  err_out:
>  	host->card = old_card;
> +	kfree_const(card->dev.kobj.name);
>  	kfree(card);
>  	return NULL;
>  }
> @@ -468,8 +469,10 @@ static void memstick_check(struct work_struct *work)
>  				put_device(&card->dev);
>  				host->card = NULL;
>  			}
> -		} else
> +		} else {
> +			kfree_const(card->dev.kobj.name);
>  			kfree(card);
> +		}
>  	}
>  
>  out_power_off:

I thought of this version, but I am not sure about tracking the device_register() and
device_unregister() calls?

put_device() calls put_kobject() which frees the const char *kobj.name ...

I thought how host cannot just be kfree()d when host->card is still allocated.
And it is a pointer. That also seems to me like a bug :-/

Kind regards,
Mirsad

---
diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index bf7667845459..46c7bda9715d 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -179,6 +179,8 @@ static void memstick_free(struct device *dev)
 {
        struct memstick_host *host = container_of(dev, struct memstick_host,
                                                  dev);
+       if (host->card && host->card->dev)
+               put_device(&host->card->dev);
        kfree(host);
 }
 
@@ -410,7 +412,7 @@ static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
        return card;
 err_out:
        host->card = old_card;
-       kfree(card);
+       put_device(&card->dev);
        return NULL;
 }
 
@@ -468,8 +470,9 @@ static void memstick_check(struct work_struct *work)
                                put_device(&card->dev);
                                host->card = NULL;
                        }
-               } else
-                       kfree(card);
+               } else {
+                       put_device(&card->dev);
+               }
        }
 
 out_power_off:


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

