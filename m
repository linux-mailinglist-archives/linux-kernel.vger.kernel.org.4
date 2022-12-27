Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3636568C9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 10:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiL0JN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 04:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiL0JNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 04:13:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8388FE6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 01:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672132386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Jx6o34uyqpu/PSUYQD9I3JF4UvYdpXWHh4RWvb/DkI=;
        b=jOWGCQHDmLJ1BPzyR3iquygrvg/87/Se39DTvKhIHpxraCY5xJU2tBUlH+Y9ReyrfpTx1V
        8Eqv7IkKaqXTDvewQSuE9lor81IhwKoWR16ejiN6Un4nc3r8xGaNs+/wLpmXIiUGPjR2c1
        Zz+o/NYpJEETVnaiCLM4NYXp2XTscog=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-493-tbQNy4_mMXGjGVlyRCgGmA-1; Tue, 27 Dec 2022 04:13:04 -0500
X-MC-Unique: tbQNy4_mMXGjGVlyRCgGmA-1
Received: by mail-pj1-f69.google.com with SMTP id mn20-20020a17090b189400b0021941492f66so9699789pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 01:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Jx6o34uyqpu/PSUYQD9I3JF4UvYdpXWHh4RWvb/DkI=;
        b=E7U3rWELbxM4cgc2uWk2iem4/0HKMnRNaaGxv1TeAc/n4fYpUs7Cek+C1ItIJPR3WB
         kEiBisAhKVMx8bCCPZ1mpOlmww1xiMeId9IZBkZcNkofUSsTgSMnt0TCC8JEVekJQ7LR
         ykPqThjWN0twskn1zDPXpYYUNCnfOa4BNKrC6d2Gb8VTc8w9xhb0Y8eLubST6iDMLtEs
         q5cRQ5lg6ZlFYk2KeCrvUYVDXGTixKXW0x/KtOvbVDBhkUbP6LJeWLUiMUMIV1YOdpx4
         wkROasMvazr8Nv5zAu3cMEf1iWd8KcRNycQKDBZBLrhCDD2eV0zcfQ+ICzmInaN4Gapr
         rWNQ==
X-Gm-Message-State: AFqh2kqib5PWem62CcplYamftiQMaYr53yape7VqeMWFu+qIkaSM1RvW
        xzuWl0+UKpAa1Y9pbJXCRioJPnS6b89Y/TOojB7/VUDtkcpOl8hWMNSqBkuc9xrJgj9g/DXZsJ2
        0ahVxxG7de9ykQxYcWQA/duRd
X-Received: by 2002:aa7:960d:0:b0:56c:3fba:c5ca with SMTP id q13-20020aa7960d000000b0056c3fbac5camr38459828pfg.16.1672132383920;
        Tue, 27 Dec 2022 01:13:03 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs0uW6pvl7WTQFTWTYhpvNudCBZ3Vz1d8332wzs1ANd1EMyd8E6UvZETJjAdYG2CpgZ74SUjQ==
X-Received: by 2002:aa7:960d:0:b0:56c:3fba:c5ca with SMTP id q13-20020aa7960d000000b0056c3fbac5camr38459804pfg.16.1672132383657;
        Tue, 27 Dec 2022 01:13:03 -0800 (PST)
Received: from [10.72.13.143] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7960d000000b005752b9fec48sm8142551pfg.204.2022.12.27.01.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 01:13:03 -0800 (PST)
Message-ID: <d77bc1ce-b73f-1ba8-f04f-b3bffeb731c3@redhat.com>
Date:   Tue, 27 Dec 2022 17:12:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com, alvaro.karsz@solid-run.com,
        eperezma@redhat.com
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-4-jasowang@redhat.com>
 <20221226183705-mutt-send-email-mst@kernel.org>
 <CACGkMEuNZLJRnWw+XNxJ-to1y8L2GrTrJkk0y0Gwb5H2YhDczQ@mail.gmail.com>
 <20221227022255-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20221227022255-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/12/27 15:33, Michael S. Tsirkin 写道:
> On Tue, Dec 27, 2022 at 12:30:35PM +0800, Jason Wang wrote:
>>> But device is still going and will later use the buffers.
>>>
>>> Same for timeout really.
>> Avoiding infinite wait/poll is one of the goals, another is to sleep.
>> If we think the timeout is hard, we can start from the wait.
>>
>> Thanks
> If the goal is to avoid disrupting traffic while CVQ is in use,
> that sounds more reasonable. E.g. someone is turning on promisc,
> a spike in CPU usage might be unwelcome.


Yes, this would be more obvious is UP is used.


>
> things we should be careful to address then:
> 1- debugging. Currently it's easy to see a warning if CPU is stuck
>     in a loop for a while, and we also get a backtrace.
>     E.g. with this - how do we know who has the RTNL?
>     We need to integrate with kernel/watchdog.c for good results
>     and to make sure policy is consistent.


That's fine, will consider this.


> 2- overhead. In a very common scenario when device is in hypervisor,
>     programming timers etc has a very high overhead, at bootup
>     lots of CVQ commands are run and slowing boot down is not nice.
>     let's poll for a bit before waiting?


Then we go back to the question of choosing a good timeout for poll. And 
poll seems problematic in the case of UP, scheduler might not have the 
chance to run.


> 3- suprise removal. need to wake up thread in some way. what about
>     other cases of device breakage - is there a chance this
>     introduces new bugs around that? at least enumerate them please.


The current code did:

1) check for vq->broken
2) wakeup during BAD_RING()

So we won't end up with a never woke up process which should be fine.

Thanks


>
>

