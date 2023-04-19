Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535226E7655
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjDSJcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjDSJcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:32:47 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE51512CBE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:32:25 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3f1754e6ac2so4805115e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681896744; x=1684488744;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5a1BeLDyhZNZilZ/KK2GAKnGHlOBBbp1X8Ya2E3EHwU=;
        b=EOwZu2N21gCTz5E0gkFz52RgI9c586Pm3PnjJJe/NY3ArsxQPxMYu+oF/RV1vuzsYP
         U2XlivcfUX1T/rHMlXuRQXeX91kDMxESkarZupYAoDemFwZPQFU9y1pKf/fCxD9ar+cp
         JlcllXzpW26EG7GhAfR0c62uWZFEs5L6OPLrhBj/GzubSWDdfZVAiyecE6yFfCnFBaHd
         Yiq9OKytLadXgD+xZvEbHBPA/Fd9w8WH4jlcB/xpaO4+EjXw5m1+xgLq9+73hPO1I11B
         x5nNVJhk3hwvZCMIwmkd8y9XmG5g3iJulxHwRClkLgaNCQCiskEtaVkU6w3ORCIOWe1V
         XRDw==
X-Gm-Message-State: AAQBX9c3JaMAFsf0ueEbsJhzx9zeVa6usu3rSfqogDi5RXLJgyomCwY6
        azNgroFyqKgn8MDuoU5emV0=
X-Google-Smtp-Source: AKy350bvi3g5YtM/nCwPxpFZIzGbqVFhyRT4L17VakLrN1VwX/A9A90OQPmROaptfGqwrGiPG+6evw==
X-Received: by 2002:a05:600c:4ece:b0:3f1:7a4b:bf17 with SMTP id g14-20020a05600c4ece00b003f17a4bbf17mr4120868wmq.1.1681896744341;
        Wed, 19 Apr 2023 02:32:24 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m12-20020a7bca4c000000b003f173419e7asm1554214wml.43.2023.04.19.02.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 02:32:24 -0700 (PDT)
Message-ID: <03a47920-9165-1d49-1380-fb4c5061df67@grimberg.me>
Date:   Wed, 19 Apr 2023 12:32:22 +0300
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
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <E23A9D5C-35CF-412C-AE35-37389242BC71@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Hey Li,
>>
>>> The default worker affinity policy is using all online cpus, e.g. from 0
>>> to N-1. However, some cpus are busy for other jobs, then the nvme-tcp will
>>> have a bad performance.
>>> This patch adds a module parameter to set the cpu affinity for the nvme-tcp
>>> socket worker threads.  The parameter is a comma separated list of CPU
>>> numbers.  The list is parsed and the resulting cpumask is used to set the
>>> affinity of the socket worker threads.  If the list is empty or the
>>> parsing fails, the default affinity is used.
>>
>> I can see how this may benefit a specific set of workloads, but I have a
>> few issues with this.
>>
>> - This is exposing a user interface for something that is really
>> internal to the driver.
>>
>> - This is something that can be misleading and could be tricky to get
>> right, my concern is that this would only benefit a very niche case.
> Our storage products needs this feature~
> If the user doesn’t know what this is, they can keep it default, so I thinks this is
> not unacceptable.

It doesn't work like that. A user interface is not something exposed to
a specific consumer.

>> - If the setting should exist, it should not be global.
> V2 has fixed it.
>>
>> - I prefer not to introduce new modparams.
>>
>> - I'd prefer to find a way to support your use-case without introducing
>> a config knob for it.
>>
> I’m looking forward to it.

If you change queue_work_on to queue_work, ignoring the io_cpu, does it
address your problem?

Not saying that this should be a solution though.

How many queues does your controller support that you happen to use
queue 0 ?

Also, what happens if you don't pin your process to a specific cpu, does
that change anything?
