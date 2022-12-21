Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6386537B8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 21:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiLUUne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 15:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiLUUna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 15:43:30 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7E81DD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:43:28 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id i7so16106894wrv.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f2IQLZGlT7yhkKQbuMJYkAG86xxOo83aPEdZnsUHwEc=;
        b=L8yGES2m8qfdje+sg6Bttv7uJNZRNv0Qt1jO2DYzZolmGJpdZgAvp4JVEConERyj7c
         oZoFJ942umf3ZoCpr7sWeYTgwTnQFY5dG1swYCiuW4ggoj0NTzj+17CmEguxyGFdDE06
         qojG6GoucyhCXu21XttSfxY/TPE035JVLI4fUqcBnfgvRUeCpIt1cuI8eoaNDnX7/Be+
         I+RO32lnM8C+xbmj7IruIOhMiZqBWLSFK4WvrIBGdo958hIDTJAjordFyditV9paLumH
         6TFaE74R7GgmJvD+SsNgjW1tlvIfjxS4tZLjSoa+TJV0ZG9195niA5fDwlyTkbWaHkiz
         NB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2IQLZGlT7yhkKQbuMJYkAG86xxOo83aPEdZnsUHwEc=;
        b=KKld93mU6VOgUVuRKE33WPKv/0fu0V5CVdaMHAAfzdT4jUTGM5jvFy9AK7RTTRBnFW
         04kk8eOj0Pn4mVod0903ytWmornUh1IqlOwVvAIuf4OO0+48o5+EbXpsSVeiyIdrf+Qt
         04GeEysLALGqeJk2hmsFpW3mbXnFwpkbI49eeoPXd/8pnfcmVjocQr/WwInH6/hxbCGX
         QHL7s4/NdYo0DL+l2nf/QOq546uCcHYbnCgHaGO7P149MRyC8/JVbq3vzzR7kf4l9qOL
         q5YbuX5ontz/ibHi00/gsrId144v+ushUnOz+MdVzYWK/fsR04KQopOiPkNbFnRCD7Rr
         89Iw==
X-Gm-Message-State: AFqh2kp+frmM2l+tzZcy5dq6yV2PqNvNggbniIUdiGrzcyGIgndTx+1O
        HDj9mhafaLbKqPvvbNVPRnLd0Q==
X-Google-Smtp-Source: AMrXdXtuPBW+mzLCSwiREgz/5nS5iLmvzAbGtF5RHR5KkYF6cprT0yoBbMzvJ1089yCTeGo8BFDrGw==
X-Received: by 2002:a5d:440f:0:b0:24a:acbe:4105 with SMTP id z15-20020a5d440f000000b0024aacbe4105mr2114018wrq.53.1671655407083;
        Wed, 21 Dec 2022 12:43:27 -0800 (PST)
Received: from [192.168.175.23] ([37.167.18.49])
        by smtp.googlemail.com with ESMTPSA id k2-20020a5d5242000000b0024287d9d4a8sm16166850wrc.74.2022.12.21.12.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 12:43:26 -0800 (PST)
Message-ID: <8ebd3fba-f2a1-9fbd-917e-05d5d1a41735@linaro.org>
Date:   Wed, 21 Dec 2022 21:43:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC][PATCH] thermal/idle_inject: Support 100% idle injection
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221209013640.943210-1-srinivas.pandruvada@linux.intel.com>
 <5276e5b8-8596-2811-e03f-c4f3f0d3ab5b@linaro.org>
 <838cf73badd8e0c1126dbc64db3aed2f20cbfe9c.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <838cf73badd8e0c1126dbc64db3aed2f20cbfe9c.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 21:36, srinivas pandruvada wrote:
> On Wed, 2022-12-21 at 14:43 +0100, Daniel Lezcano wrote:
>>
>> Hi Srinivas,
>>
>>
>> On 09/12/2022 02:36, Srinivas Pandruvada wrote:
>>> The users of idle injection framework allow 100% idle injection.
>>> For
>>> example: thermal/cpuidle_cooling.c driver. When the ratio set to
>>> 100%,
>>> the runtime_duration becomes zero.
>>>
>>> In the function idle_inject_set_duration() in idle injection
>>> framework
>>> run_duration_us == 0 is silently ignored, without any error (it is
>>> a
>>> void function). So, the caller will assume that everything is fine
>>> and
>>> 100% idle is effective. But in reality the idle inject will be
>>> whatever
>>> set before.
>>
>> Good catch
>>
>>> There are two options:
>>> - The caller change their max state to 99% instead of 100% and
>>> document that 100% is not supported by idle inject framework
>>> - Support 100% idle support in idle inject framework
>>
>> Yes, from my POV a CPU being impossible to cool down for any reason
>> should end up by staying off.
>>
>>> Since there are other protections via RT throttling, this framework
>>> can
>>> allow 100% idle. The RT throttling will be activated at 95% idle by
>>> default. The caller disabling RT throttling and injecting 100%
>>> idle,
>>> should be aware that CPU can't be used at all.
>>
>> Would it make sense to write a trace in this case ?
> 
> There is one printk already:
> printk_deferred_once("sched: RT throttling activated\n")
> You mean we should add
> 
> trace_sched_* for this?


I meant the CPU is going 100% idle


>>> The idle inject timer is started for (run_duration_us +
>>> idle_duration_us)
>>> duration. Hence replace (run_duration_us && idle_duration_us) with
>>> (run_duration_us + idle_duration_us) in the function
>>> idle_inject_set_duration().
>>
>> Sounds good to me
>>
> I will submit a patch for this.
> 
> Thanks,
> Srinivas
> 
>>> Signed-off-by: Srinivas Pandruvada
>>> <srinivas.pandruvada@linux.intel.com>
>>> ---
>>>    drivers/powercap/idle_inject.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/powercap/idle_inject.c
>>> b/drivers/powercap/idle_inject.c
>>> index f48e71501429..4a4fe60d2563 100644
>>> --- a/drivers/powercap/idle_inject.c
>>> +++ b/drivers/powercap/idle_inject.c
>>> @@ -184,7 +184,7 @@ void idle_inject_set_duration(struct
>>> idle_inject_device *ii_dev,
>>>                                unsigned int run_duration_us,
>>>                                unsigned int idle_duration_us)
>>>    {
>>> -       if (run_duration_us && idle_duration_us) {
>>> +       if (run_duration_us + idle_duration_us) {
>>>                  WRITE_ONCE(ii_dev->run_duration_us,
>>> run_duration_us);
>>>                  WRITE_ONCE(ii_dev->idle_duration_us,
>>> idle_duration_us);
>>>          }
>>
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

