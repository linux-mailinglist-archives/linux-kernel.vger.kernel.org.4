Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5496F057D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243797AbjD0MMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243624AbjD0MMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:12:40 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FD56197
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 05:12:10 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-2f4130b898cso884213f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 05:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682597487; x=1685189487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Uxca9pe/yGj61Xn7b0qdaKHJXvzXZBitlFHQ2EJ9gg=;
        b=Rt4xbvmCZT+SuYk9v0Ojf1fo4IKua2QhL+pcZtKG2Z/k7Yl+YTCeFL8VCWdNfLf7A2
         kqJrgT8oDPmqm5aSY0ZO5P8vtFjJLgpylbG6sWmM788aEH/zueN05TRLVW7T7sF/gBDS
         CMwN6d5QPkMBZmMkAxm67JJSiFg2vp4DI6OMalpGjXDS4C8cLg84YlsuE2pwLOnCXCom
         eUtcENn78EXj/Q4ziGJRd+wRG8VKnJpSYzoEAb6XQENnogvEro5cbfjH6jJ5pC/EsqmR
         kS+KsJOuLTIyn2TRtgQbeUOlZTbxIxJrcn1dYrnT2Gwl4Jtf2EyTjIQUJyPiB/MUsudw
         5NhQ==
X-Gm-Message-State: AC+VfDwR51p5goZbpQV819eygVoi7lLxQMH99aFngt98tGzKZFOtWSKf
        pC9WpSGg5z9CgWvJsMQUdVY=
X-Google-Smtp-Source: ACHHUZ7T+CF99CWVFJwXPakc8HIfF+FoSAfxQMp9U3Ks3QprWHCOwT1Ng0PXhjS5LNYHLzCSURsqPA==
X-Received: by 2002:adf:f349:0:b0:2ef:9699:f906 with SMTP id e9-20020adff349000000b002ef9699f906mr1036242wrp.7.1682597487098;
        Thu, 27 Apr 2023 05:11:27 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e8-20020adfdbc8000000b003047d5b8817sm9370339wrj.80.2023.04.27.05.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 05:11:26 -0700 (PDT)
Message-ID: <4517d754-1594-9913-cf7f-da58a7cb23a8@grimberg.me>
Date:   Thu, 27 Apr 2023 15:11:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nvme/tcp: Add support to set the tcp worker cpu affinity
Content-Language: en-US
To:     Li Feng <fengli@smartx.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413063317.2455680-1-fengli@smartx.com>
 <7f553d34-9ada-426c-4847-c7cd1aba64a8@grimberg.me>
 <E23A9D5C-35CF-412C-AE35-37389242BC71@smartx.com>
 <03a47920-9165-1d49-1380-fb4c5061df67@grimberg.me>
 <CAHckoCzBBmn8kCuD+ssRKApvFYNxedj_RkqsvgDis+iwV8g-oA@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHckoCzBBmn8kCuD+ssRKApvFYNxedj_RkqsvgDis+iwV8g-oA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi Sagi,
> 
> On Wed, Apr 19, 2023 at 5:32 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>>
>>
>>>> Hey Li,
>>>>
>>>>> The default worker affinity policy is using all online cpus, e.g. from 0
>>>>> to N-1. However, some cpus are busy for other jobs, then the nvme-tcp will
>>>>> have a bad performance.
>>>>> This patch adds a module parameter to set the cpu affinity for the nvme-tcp
>>>>> socket worker threads.  The parameter is a comma separated list of CPU
>>>>> numbers.  The list is parsed and the resulting cpumask is used to set the
>>>>> affinity of the socket worker threads.  If the list is empty or the
>>>>> parsing fails, the default affinity is used.
>>>>
>>>> I can see how this may benefit a specific set of workloads, but I have a
>>>> few issues with this.
>>>>
>>>> - This is exposing a user interface for something that is really
>>>> internal to the driver.
>>>>
>>>> - This is something that can be misleading and could be tricky to get
>>>> right, my concern is that this would only benefit a very niche case.
>>> Our storage products needs this feature~
>>> If the user doesn’t know what this is, they can keep it default, so I thinks this is
>>> not unacceptable.
>>
>> It doesn't work like that. A user interface is not something exposed to
>> a specific consumer.
>>
>>>> - If the setting should exist, it should not be global.
>>> V2 has fixed it.
>>>>
>>>> - I prefer not to introduce new modparams.
>>>>
>>>> - I'd prefer to find a way to support your use-case without introducing
>>>> a config knob for it.
>>>>
>>> I’m looking forward to it.
>>
>> If you change queue_work_on to queue_work, ignoring the io_cpu, does it
>> address your problem?
> Sorry for the late response, I just got my machine back.
> Replace the queue_work_on to queue_work, looks like it has a little
> good performance.
> The  busy worker is `kworker/56:1H+nvme_tcp_wq`, and fio binds to
> 90('cpus_allowed=90'),
> I don't know why the worker 56 is selected.
> The performance of 256k read up from 1.15GB/s to 1.35GB/s.

The question becomes what would be the impact for multi-threaded
workloads and different NIC/CPU/App placements... This is the
tricky part of touching this stuff.

>> Not saying that this should be a solution though.
>>
>> How many queues does your controller support that you happen to use
>> queue 0 ?
> Our controller only support one io queue currently.

I don't think I ever heard of a fabrics controller that supports
a single io queue.

>>
>> Also, what happens if you don't pin your process to a specific cpu, does
>> that change anything?
> If I don't pin the cpu, the performance has no effect.

Which again, makes this optimization point a niche.
