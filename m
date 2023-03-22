Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96B86C51CC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjCVREj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjCVREG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:04:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CA6274BF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679504561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kti/JzF4VrmbjBlfDUl4YhHuHDPglfNgmyzJ2qiaCg8=;
        b=APfe+PxHHNSF8JM3GjuuqeNqOEiuvkFtb0xQL9b3jwW819fpJRwT+BtDRpGykBX2Y7y6CX
        DwS270zudJuaoueCXWOdEdzoCEcM+Mo4yUuCIXvYixDDL6hVj8N+KfNKh7d4qABzKDcaK/
        sXq+JVuo7+5joIQJbmls5k02JyIrFYw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-gnMLPuvkNXKcYrYogAkQhA-1; Wed, 22 Mar 2023 13:02:39 -0400
X-MC-Unique: gnMLPuvkNXKcYrYogAkQhA-1
Received: by mail-wm1-f70.google.com with SMTP id m27-20020a05600c3b1b00b003ee502f1b16so1837617wms.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679504557;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kti/JzF4VrmbjBlfDUl4YhHuHDPglfNgmyzJ2qiaCg8=;
        b=jL5MLTFLmwLL2DRRbDmK0rp/GaoRnfzeWlNHF3Afl3jbz1HwzlIDpYxD+3foNzEqDC
         /eUtFwYp42BG1rgNPyUMCfBgl7LDjzoIwKFbQjs3m9JzQ+RtQoGGksdtvypSiQk623i5
         ZISCVOkVQa87zBdPKVO7ONF82ibCitOW9d8NshKmZ2ppMyRfX+jBhPrNbvnkSt3oZsWJ
         63rFaoC2+QLhIoHKl8X78C3LIbNFOb0FDFuYN6FLF5aFB1fR+njCyuLI7a/bjpJ9w3nY
         aQAC9W1YJkYArFj2tWL0rlMorQT2IfNdmuoIMzIWjhf6qP8To250wGUYuAdJmLp/hz0W
         iN5A==
X-Gm-Message-State: AO0yUKVtOGkLpdEDaUNNno+f1U79WpWEi9XxiaVZd+3BztYiurhkpwqM
        eJWpiE3WLpMrwoHAF0WhN0U4v3FndfU8+t6xl8rKF6TdkSS259X7NTOfvlVDFeoyoLYzjbz9ywF
        7IFLAnGvdYasVP8beDY3jWM/kXAtOKrOC
X-Received: by 2002:a7b:c3d9:0:b0:3ed:9212:b4fe with SMTP id t25-20020a7bc3d9000000b003ed9212b4femr226871wmj.0.1679504556816;
        Wed, 22 Mar 2023 10:02:36 -0700 (PDT)
X-Google-Smtp-Source: AK7set9dJZMsZOALzIB5M3pFL0KeOCwU/SYEhVYAv7bjUiaycrkDQ6K8T+5vVFFkHWfhMUYDnRvCcA==
X-Received: by 2002:a7b:c3d9:0:b0:3ed:9212:b4fe with SMTP id t25-20020a7bc3d9000000b003ed9212b4femr226838wmj.0.1679504556502;
        Wed, 22 Mar 2023 10:02:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:d00:ca74:d9ea:11e0:dfb? (p200300cbc7030d00ca74d9ea11e00dfb.dip0.t-ipconnect.de. [2003:cb:c703:d00:ca74:d9ea:11e0:dfb])
        by smtp.gmail.com with ESMTPSA id s11-20020adff80b000000b002d6f285c0a2sm8066858wrp.42.2023.03.22.10.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 10:02:36 -0700 (PDT)
Message-ID: <3e2d1f69-5cd8-8824-0a2e-a1c2c9029f66@redhat.com>
Date:   Wed, 22 Mar 2023 18:02:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 4/4] mm: vmalloc: convert vread() to vread_iter()
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <cover.1679496827.git.lstoakes@gmail.com>
 <4f1b394f96a4d1368d9a5c3784ebee631fb8d101.1679496827.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <4f1b394f96a4d1368d9a5c3784ebee631fb8d101.1679496827.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.03.23 15:55, Lorenzo Stoakes wrote:
> Having previously laid the foundation for converting vread() to an iterator
> function, pull the trigger and do so.
> 
> This patch attempts to provide minimal refactoring and to reflect the
> existing logic as best we can, for example we continue to zero portions of
> memory not read, as before.
> 
> Overall, there should be no functional difference other than a performance
> improvement in /proc/kcore access to vmalloc regions.
> 
> Now we have eliminated the need for a bounce buffer in read_kcore_iter(),
> we dispense with it, and try to write to user memory optimistically but
> with faults disabled via copy_page_to_iter_nofault(). We already have
> preemption disabled by holding a spin lock.
> 
> If this fails, we fault in and retry a single time. This is a conservative
> approach intended to avoid spinning on vread_iter() if we repeatedly
> encouter issues reading from it.

I have to ask again: Can you comment why that is ok? You might end up 
signaling -EFAULT to user space simply because swapping/page 
migration/whatever triggered at the wrong time.

That could break existing user space or which important part am I missing?

-- 
Thanks,

David / dhildenb

