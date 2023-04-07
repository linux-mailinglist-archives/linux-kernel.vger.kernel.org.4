Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C3E6DA9FF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 10:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjDGIYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 04:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjDGIYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 04:24:34 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031A06EAB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 01:24:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id C107F604F6;
        Fri,  7 Apr 2023 10:24:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680855867; bh=aSptWe2x+JTH/1bmiifexMg4polrb/x5sg/MEgptsF8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RMXF/8AQXfqhvPMyFaP0XuvjIR8Zrlp5anMq87prqgOf8JQ373DwxW3mOqK0X7rAo
         yOH0yYTaVDK1Kp4o75ir0li5nSfvUM6FR/846xBZjdrJaF0KgXk9KELrNdLJtBg8w6
         MpF+Eyyf46kbfV4DgNf9/N7fVf6pDuP2A/bwhoXLDRUeC5tX5FFt7lfQU/j13KRNWf
         G0vbQ3r8NwgXr2EcelAH2yRbIHKPIOd6NO3iUrtH+oWkUnsKHR/7dSYwP7I2ALLAqO
         6Z/urqpuOoYmsNAseHbAdaqjCS0FVYG0Yj8VzpXLwN4WCJaWmwvnFCS3yiL1JDTIXL
         HPXqY19HmjJgQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id d3joQPErXc0a; Fri,  7 Apr 2023 10:24:25 +0200 (CEST)
Received: from [10.0.1.26] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id C795F604F5;
        Fri,  7 Apr 2023 10:24:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680855865; bh=aSptWe2x+JTH/1bmiifexMg4polrb/x5sg/MEgptsF8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=i6WLs71aqn9B3iqJhb2LV1q4tSd4O0UfW89fZ2as+xwy691dHfXqw2SuIGgMsF5kd
         WAkJUNwRfJUh3G43Fe73yQkrlqZcsuAmb+JDE1kOjApPZge/SQp5/fe75wEdFmVpCG
         6kxq7W5M/zdbl1MuRhwVilvPwS3oqI9YVdhrUBtaQT3PupB4ZX35lU7ILYLj0Z28WD
         tlhuzRwmvhRi94GeakgzKj/Fancc6i/Yyb7hIU6SyT7lQfh10HwjynXrWahQijHsKn
         GkrSiTqsfkwu6HpMLiuv/t5j/NDOqGaWwmlKF2WwwFlmGmmsoW2iwRPhGa7MzZ1JhD
         SR1XY8PfkIP2Q==
Message-ID: <1f07fd79-b7db-9bd5-f281-8ba1ca71e195@alu.unizg.hr>
Date:   Fri, 7 Apr 2023 10:24:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 1/2] test_firmware: Fix some racing conditions in
 test_fw_config locking.
Content-Language: en-US, hr
To:     Dan Carpenter <error27@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
References: <20230406015315.31505-1-mirsad.todorovac@alu.unizg.hr>
 <eb117a50-79ad-4f5a-8ad9-73247107469e@kili.mountain>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <eb117a50-79ad-4f5a-8ad9-73247107469e@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.4.2023. 16:04, Dan Carpenter wrote:
> On Thu, Apr 06, 2023 at 03:53:17AM +0200, Mirsad Goran Todorovac wrote:
>> Some functions were called both from locked and unlocked context, so the lock
>> was dropped prematurely, introducing a race condition when deadlock was avoided.
>>
>> Having two locks wouldn't assure a race-proof mutual exclusion.
>>
>> test_dev_config_update_bool_unlocked(), test_dev_config_update_u8_unlocked()
>> and test_dev_config_update_size_t_unlocked() versions of the functions were
>> introduced to be called from the locked contexts as a workaround without
>> releasing the main driver's lock and causing a race condition, much like putc()
>> and putc_unlocked() in stdio glibc library.
>>
>> This should guarantee mutual exclusion and prevent any race conditions.
>>
> 
> Thanks for figuring this out!  It seems like a good approach to me.
> However, I feel like PATCH 1/1 needs some style changes.
> 
> The question you seem to be dealing with is how consistent to be and how
> much infrastructure to create.  Don't think about that.  Just fix the
> bug in the most minimal way possible and don't worry about being
> consistent.
> 
> (Probably the best way to make this consistent is to change the
>   test_dev_config_update_XXX functions into a single macro that calls the
>   correct kstroXXX function.  Then create a second macro that takes the
>   lock and calls the first macro.  But that is a clean up patch and
>   unrelated to this bug.)
> 
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: Russ Weight <russell.h.weight@intel.com>
>> Cc: Tianfei zhang <tianfei.zhang@intel.com>
>> Cc: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> Cc: Zhengchao Shao <shaozhengchao@huawei.com>
>> Cc: Colin Ian King <colin.i.king@gmail.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: Takashi Iwai <tiwai@suse.de>
>> Suggested-by: Dan Carpenter <error27@gmail.com>
>> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>> ---
>>   lib/test_firmware.c | 52 +++++++++++++++++++++++++++++++++------------
>>   1 file changed, 38 insertions(+), 14 deletions(-)
>>
>> diff --git a/lib/test_firmware.c b/lib/test_firmware.c
>> index 05ed84c2fc4c..272af8dc54b0 100644
>> --- a/lib/test_firmware.c
>> +++ b/lib/test_firmware.c
>> @@ -353,16 +353,26 @@ static ssize_t config_test_show_str(char *dst,
>>   	return len;
>>   }
>>   
>> -static int test_dev_config_update_bool(const char *buf, size_t size,
>> +static inline int test_dev_config_update_bool_unlocked(const char *buf, size_t size,
>>   				       bool *cfg)
>>   {
>>   	int ret;
>>   
>> -	mutex_lock(&test_fw_mutex);
>>   	if (kstrtobool(buf, cfg) < 0)
>>   		ret = -EINVAL;
>>   	else
>>   		ret = size;
>> +
>> +	return ret;
>> +}
> 
> This change can be left out completely.
> 
>> +
>> +static int test_dev_config_update_bool(const char *buf, size_t size,
>> +				       bool *cfg)
>> +{
>> +	int ret;
>> +
>> +	mutex_lock(&test_fw_mutex);
>> +	ret = test_dev_config_update_bool_unlocked(buf, size, cfg);
>>   	mutex_unlock(&test_fw_mutex);
>>   
>>   	return ret;
>> @@ -373,7 +383,8 @@ static ssize_t test_dev_config_show_bool(char *buf, bool val)
>>   	return snprintf(buf, PAGE_SIZE, "%d\n", val);
>>   }
>>   
>> -static int test_dev_config_update_size_t(const char *buf,
>> +static int test_dev_config_update_size_t_unlocked(
>> +					 const char *buf,
>>   					 size_t size,
>>   					 size_t *cfg)
>>   {
> 
> Do not rename this function.  Just add a comment that the mutext must be
> held.  Or a WARN_ONCE().
> 
> 	WARN_ON_ONCE(!mutex_is_locked(&test_fw_mutex));
> 
> 
>> @@ -384,9 +395,7 @@ static int test_dev_config_update_size_t(const char *buf,
>>   	if (ret)
>>   		return ret;
>>   
>> -	mutex_lock(&test_fw_mutex);
>>   	*(size_t *)cfg = new;
>> -	mutex_unlock(&test_fw_mutex);
>>   
>>   	/* Always return full write size even if we didn't consume all */
>>   	return size;
>> @@ -402,6 +411,21 @@ static ssize_t test_dev_config_show_int(char *buf, int val)
>>   	return snprintf(buf, PAGE_SIZE, "%d\n", val);
>>   }
>>   
>> +static int test_dev_config_update_u8_unlocked(const char *buf, size_t size, u8 *cfg)
>> +{
>> +	u8 val;
>> +	int ret;
>> +
>> +	ret = kstrtou8(buf, 10, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*(u8 *)cfg = val;
>> +
>> +	/* Always return full write size even if we didn't consume all */
>> +	return size;
>> +}
>> +
> 
> Just change the test_dev_config_update_u8() to not take the lock.
> Add the comment that the lock must be held.  Change both callers to take
> the lock.
> 
> 
> Otherwise we end up creating too much duplicate code.
> 
>>   static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
>>   {
>>   	u8 val;
> 
> regards,
> dan carpenter

Hi Mr. Carpenter,

Thank you for your review.

I will proceed according to your guidelines and issue the next version of the
patch set.

But I cannot promise it will be before the holidays - I do not want to make
the gods angry either ;-)

I cannot promise to try smart macros or inline functions with smart function
parameters just yet.

I would consider the real success if I hunt down the remaining leak and races
in this driver. Despite being considered a less important one.

As you have previously asserted, it is not a real security issue with a CVE,
however, for completeness sake I would like to see these problems fixed.

Best regards,
Mirsad

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union

Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

