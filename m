Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C796106FF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 02:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbiJ1Ayv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 20:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbiJ1Ayr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 20:54:47 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335CE18B0F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 17:54:46 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-13bd2aea61bso4764284fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 17:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=A6gCh4ZYv30l/VnGu0TP6apPI78P3JKkBaYC4tXXpPk=;
        b=Ptxa1ZOCg5S3XOE5u2AaKjTZoeI/Ir8b/CXcNoMqlAgc55SaXImBYzkAjYV5D/m10b
         r8Hu0NQf/r/YNjZWOn6Y/itO3u2vYxGCZlxH6EzoB53e10T+PgnVm/q8t+mle4tFbygq
         8QHFI6LJNptl1Yx6J7y8kKkboivrgCbrYU2y9h5cARE31V5fjqCem6JWKO9CG3acjfis
         0JXSe1Wqp+twOCitMxC4uUR7AO0r/Od6MhqUaxTbkVQGSM+hdU/8xCg+KoD1gRsSjqSN
         06pK0EZk99OHoPuNyFQfr621vDXk5TP8Hu9b/1lVH+48uhE7kqJy28bMUqE2wY7RNHd2
         g2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6gCh4ZYv30l/VnGu0TP6apPI78P3JKkBaYC4tXXpPk=;
        b=PT2kBEaM9/zK6u7P+dlm6pNqSIhj4XhJ6IKtqYBCYn1fEFAAZXCCeuHnEHKYH2Z+Wt
         QNAbr4UYqpAO/GJ/mzr5LWivcewKAeEKC7kHie/CBmQfK1TddlrOhPErrhNRDoXMLIXv
         0mKPli3S59Wbr/M4vgd43BKh1P2COaSUEthTykBjptGp80E4NCOgeh3O0aanMcwP7340
         b/IijZiHk8wf7aUT9evpfOmTGWpuAXwhkrwJZBbXPPHn06p1hv8n1IIHFb6jjPJ474Zb
         XyIVrjbBaD0ymZHH5ku0c7jQrkL9nMrwkcuUgPsZnFJ0KfbEYf+jfRdme6CpH1u5acSd
         vl/Q==
X-Gm-Message-State: ACrzQf0lWuzBwyNap76oJnc2gsVXZ2vpg7/t6Uys+V04saS0RZ2x3Ri5
        0shE4CznfM9hmazMOlCHx4dWFlFNmyc=
X-Google-Smtp-Source: AMsMyM4VHM64hPELLvRoJYiYWeeLV7TAVr/b8Cso6JhU7ACWlOeMYMzTz9uCTBk+qfjvz1z7W/a35Q==
X-Received: by 2002:a05:6870:4798:b0:12c:fdf7:e948 with SMTP id c24-20020a056870479800b0012cfdf7e948mr7122154oaq.247.1666918485521;
        Thu, 27 Oct 2022 17:54:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n11-20020a056870558b00b0013ae5246449sm1348519oao.22.2022.10.27.17.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 17:54:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <72bc60b6-6fe1-9a7f-27ab-2f84832d62b1@roeck-us.net>
Date:   Thu, 27 Oct 2022 17:54:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC][PATCH v2 00/31] timers: Use del_timer_shutdown() before
 freeing timers
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
References: <20221027150525.753064657@goodmis.org>
 <20221027222404.GA3123386@roeck-us.net>
 <20221027185859.1087d3ca@gandalf.local.home>
 <20221027232442.GA279073@roeck-us.net>
 <20221027195509.6fb3793c@gandalf.local.home>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221027195509.6fb3793c@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 16:55, Steven Rostedt wrote:
> On Thu, 27 Oct 2022 16:24:42 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>>> This is probably just missing a switch to shutdown.
>>>    
>> Wild shot, and I don't really know what I am doing,
>> but I'll try
>>
>> iff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index e71b3b43927c..6c1cb4a219f0 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -767,6 +767,8 @@ static void blk_release_queue(struct kobject *kobj)
>>
>>          might_sleep();
>>
>> +       del_timer_shutdown(&q->timeout);
>> +
>>          percpu_ref_exit(&q->q_usage_counter);
>>
>>          if (q->poll_stat)
> 
> Or perhaps this:
> 

I think you are correct. Let me give it a try.

> -- Steve
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 17667159482e..69b1daa2e91a 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -227,7 +227,7 @@ const char *blk_status_to_str(blk_status_t status)
>    */
>   void blk_sync_queue(struct request_queue *q)
>   {
> -	del_timer_sync(&q->timeout);
> +	del_timer_shutdown(&q->timeout);
>   	cancel_work_sync(&q->timeout_work);
>   }
>   EXPORT_SYMBOL(blk_sync_queue);
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index e71b3b43927c..12a1e46536ed 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -769,6 +769,8 @@ static void blk_release_queue(struct kobject *kobj)
>   
>   	percpu_ref_exit(&q->q_usage_counter);
>   
> +	blk_sync_queue(q);
> +
This might not even be needed. I'll try without it first.

Thanks,
Guenter

>   	if (q->poll_stat)
>   		blk_stat_remove_callback(q, q->poll_cb);
>   	blk_stat_free_callback(q->poll_cb);

