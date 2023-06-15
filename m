Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D267313C1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241077AbjFOJ2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238877AbjFOJ1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:27:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639CB199D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686821224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zZrI8MJxkRt96MsBfDiNN0LAkuHZhh0+OjJ9xsZzehk=;
        b=efRYuKfb7RGqp3qih8onyGuITBi1R0BlaXWRKtGpn1himQ+OBDeqUMmgNja7e+a9x61CGC
        6X+lQAqrYHpgs4zm6qbwCso0FEfav5AhHhCvAzFD3p1rxVG8HRdtbAYMrNf2R8UYe5IGc6
        XT8iF0Sz7oL76yTP56515EpPgzJ06aE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-6Q292B_YOousiUOwUZcKGQ-1; Thu, 15 Jun 2023 05:27:03 -0400
X-MC-Unique: 6Q292B_YOousiUOwUZcKGQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f7ecc15771so2810535e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686821222; x=1689413222;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZrI8MJxkRt96MsBfDiNN0LAkuHZhh0+OjJ9xsZzehk=;
        b=ifmr/uzhqm4g/1zr6HyaSpRUalSGXX7K2XgsLNZ1wYQ44JxNe5oMnP7EKd4XNnCgNX
         RHICNRpt2RXZu+vVtOgGGNK2GVsc1EbCxxD2c9Sjw6O/0KGFAgfnJGPyzVfRW6H17t4G
         DYROCoYVkAJQnitKAOSErsmZgIg/5JjKHs1n8yoH8hSRjaQ16mWtodsM/bz2TEf+5TVV
         ZkAWycgvIzCw/K8P9ZCJkgwkmV4pAbSkOVy933NDYQbI6hPxRo0F4Xc794LWbaWaFNpT
         BmyPPi0UMS6AChA8CFvBhXGfgpv9vO+qMqV7vFZvdt5MP88w//Zk+DQdK79kEyn8oVLc
         CpeQ==
X-Gm-Message-State: AC+VfDxrlzc2UJI9HiVrnDiQp5DEcMsu8NLb6mbO9QDC1l0JqcE5gVb8
        aVmoMRGXqLpJuThhMd1J4CUswM9eznEAZijTLwq3evQUX5nFKjhZ8DYHvz6B2RbmbfIqgMrE7qx
        SdfOHZTdCazr/JqpDye+zXKKp
X-Received: by 2002:a05:600c:3659:b0:3f7:aee8:c23a with SMTP id y25-20020a05600c365900b003f7aee8c23amr3601811wmq.19.1686821221903;
        Thu, 15 Jun 2023 02:27:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ55eTeV6vXal0aLWeGUSfGS3HPQdBY6AlAP1O4LroxAtYmg/toLDFJGndpdgI/4s0l8ovy60g==
X-Received: by 2002:a05:600c:3659:b0:3f7:aee8:c23a with SMTP id y25-20020a05600c365900b003f7aee8c23amr3601793wmq.19.1686821221502;
        Thu, 15 Jun 2023 02:27:01 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id n18-20020a1c7212000000b003f604793989sm19928270wmc.18.2023.06.15.02.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 02:27:00 -0700 (PDT)
Message-ID: <d9b22eaa-00a1-6c5c-99a0-126b085f7cb0@redhat.com>
Date:   Thu, 15 Jun 2023 11:27:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>, minchan@kernel.org,
        senozhatsky@chromium.org, mhocko@suse.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 1/3] zram: charge the compressed RAM to the page's
 memcgroup
In-Reply-To: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.06.23 05:48, Zhongkun He wrote:
> The compressed RAM is currently charged to kernel, not to
> any memory cgroup, which is not satisfy our usage scenario.
> if the memory of a task is limited by memcgroup, it will
> swap out the memory to zram swap device when the memory
> is insufficient. In that case, the memory limit will have
> no effect.
> 
> So, it should makes sense to charge the compressed RAM to
> the page's memory cgroup.

Interesting. When looking at possible ways to achieve that in a clean 
way, my understanding was that the page might not always be accounted to 
a memcg (e.g., simply some buffer?). Besides the swap->zram case I was 
thinking about other fs->zram case, or just a straight read/write to the 
zram device.

The easiest way to see where that goes wrong I think is 
zram_bvec_write_partial(), where we simply allocate a temporary page.

Either I am missing something important, or this only works in some 
special cases.

I came to the conclusion that the only reasonable way is to assign a 
complete zram device to a single cgroup and have all memory accounted to 
that cgroup. Does also not solve all use cases (especially the 
swap->zram case that might be better offjust using zswap?) but at least 
the memory gets accounted in a more predictable way.

Happy to learn more.

-- 
Cheers,

David / dhildenb

