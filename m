Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5679C6E76BD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjDSJuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjDSJuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:50:14 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6189759F5;
        Wed, 19 Apr 2023 02:50:13 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f18176ea3aso693075e9.0;
        Wed, 19 Apr 2023 02:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681897812; x=1684489812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2N2hb9fQX6BxeQJJ0ZtV3DN7BTyeH4WlP1z3pQfLoc=;
        b=X3BT/rl1osGwDNzGF7zbl87LJyuz/Xpd1YWoENZ901+5dZNMY3FUsYjdVqYdxHQXT5
         awvtgVN+3QhI40UwWFjmJKnFLES9usmCBUzDtrHhXGdXhtu0L6IBAYgevJLuvrxPXIUR
         2iP1JSHDywhRRjPnbgViRlP5caQoWEI2+xiAofzp3laQd/QXj6Vwua8KkkdWvn5ndRyN
         JvI5lCy4V6BIVA5+Nklx62soUouNfvO5Te8IdqqWd3g0HdSerKf94BotG9KPOs7RUNGr
         qIQp02jSWKafJ/A7r9gELm713MuJiw7Bx6qeoUddU12MFiwiKhbZwJpTHK/q+EN37VYr
         b+MQ==
X-Gm-Message-State: AAQBX9cYPzPUB+ReYvewIV5ahKJZc9uHJA0oMtLQ/RyzsL4fYiPGHK4A
        S0iTZyxNif+AkPRPadWnWf0=
X-Google-Smtp-Source: AKy350YUwQJmtEoIRyfXQD/byB/r6Y3aSQT4xySXr4lC8OwtZSeUBvaym/FcGBjHfDQ3253Byj30JA==
X-Received: by 2002:a05:600c:4709:b0:3f1:8278:8d81 with SMTP id v9-20020a05600c470900b003f182788d81mr439223wmo.4.1681897811766;
        Wed, 19 Apr 2023 02:50:11 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x17-20020a05600c21d100b003edef091b17sm1640098wmj.37.2023.04.19.02.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 02:50:11 -0700 (PDT)
Message-ID: <9a1f1709-baaf-5661-2cbf-c34e2da9e42e@grimberg.me>
Date:   Wed, 19 Apr 2023 12:50:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC v1 0/1] nvme testsuite runtime optimization
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
References: <20230419085643.25714-1-dwagner@suse.de>
 <f0d2ddd5-37d6-8fba-a5e3-965fb9f41474@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f0d2ddd5-37d6-8fba-a5e3-965fb9f41474@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


>> While testing the fc transport I got a bit tired of wait for the I/O jobs to
>> finish. Thus here some runtime optimization.
>>
>> With a small/slow VM I got following values:
>>
>> with 'optimizations'
>>     loop:
>>       real    4m43.981s
>>       user    0m17.754s
>>       sys     2m6.249s

How come loop is doubling the time with this patch?
ratio is not the same before and after.

>>
>>     rdma:
>>       real    2m35.160s
>>       user    0m6.264s
>>       sys     0m56.230s
>>
>>     tcp:
>>       real    2m30.391s
>>       user    0m5.770s
>>       sys     0m46.007s
>>
>>     fc:
>>       real    2m19.738s
>>       user    0m6.012s
>>       sys     0m42.201s
>>
>> base:
>>     loop:
>>       real    7m35.061s
>>       user    0m23.493s
>>       sys     2m54.866s
>>
>>     rdma:
>>       real    8m29.347s
>>       user    0m13.078s
>>       sys     1m53.158s
>>
>>     tcp:
>>       real    8m11.357s
>>       user    0m13.033s
>>       sys     2m43.156s
>>
>>     fc:
>>       real    5m46.615s
>>       user    0m12.819s
>>       sys     1m46.338s
>>
>>
> 
> Those jobs are meant to be run for at least 1G to establish
> confidence on the data set and the system under test since SSDs
> are in TBs nowadays and we don't even get anywhere close to that,
> with your suggestion we are going even lower ...

Where does the 1G boundary coming from?

> we cannot change the dataset size for slow VMs, instead add
> a command line argument and pass it to tests e.g.
> nvme_verification_size=XXX similar to nvme_trtype but don't change
> the default values which we have been testing for years now
> 
> Testing is supposed to be time consuming especially verification jobs..

I like the idea, but I think it may need to be the other way around.
Have shortest possible runs by default.
