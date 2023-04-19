Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B2C6E7F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 18:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjDSQBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 12:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjDSQBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 12:01:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5634E3593
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 09:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681920031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+sZluiJicHRPmewxL0TuLmGz2UnSlgfjskB8rwD+xpo=;
        b=Py8piR7ikcFXgUmxz8GNLXEMGMMPJmvWFWkdrp+NuXH0771ODYNvmB85PgZ8I0vo0ALM/G
        d1ao4h8vbkmoZMj4EqIgOrhYKzjMtQOUJgLf0WFS9d8bEc/6/ZqSsNynI90Qn9FkOmPxE7
        p2Iwzi8pHax5ne2RLJiknWDnGbYH0d8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-xEKMImL4MVSEhklFeLe41w-1; Wed, 19 Apr 2023 12:00:29 -0400
X-MC-Unique: xEKMImL4MVSEhklFeLe41w-1
Received: by mail-qv1-f71.google.com with SMTP id a9-20020a0ccdc9000000b005df3eac4c0bso74328qvn.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 09:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681920029; x=1684512029;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+sZluiJicHRPmewxL0TuLmGz2UnSlgfjskB8rwD+xpo=;
        b=j1633AY8X/hgQo4A05sT48ZPsc/Md8155ZYiKjH28fpC01vDis/gIWPZiVpGKOxjsB
         4Z0/fiFukjJm9q6gYczmvbpoBPdJT5NeVZqctTsAh17ZRlEljfSHiIuMeDiTPCaIhW2i
         UCTjkNSWyu6sV7VfUdKS2KylZ3bV8wmfdHwIXLqDmsmUkoUYUptyeEnAeqQJsnaBh1WR
         o1AnoraZ09cXh+1Wr+ZSJHsPbOqqFYmiDueJRTJFY/LIuUiq0utRU4eNoqsxFlW+hVv9
         L4X3U5vekQf4KvHXecvggpo7/NoG5+hwyMLT+7dv4V0QnA3m5ea7vi4cHJYijloqGT6O
         q2Iw==
X-Gm-Message-State: AAQBX9e4LJn3JPpZI//ANaBDsnlNsPENy9euElW1imdwF3Gf7Rv+2I1F
        A4M+6BxN/XgdF3xyaek7l/YNnZ+BDZTtY8xDnq5xfBS/0xaejA+iLfNZPxnirq4hKi5UAA9HqS4
        usZLG4qDbg9wcKV4kAnnDIrjF
X-Received: by 2002:a05:622a:1787:b0:3ef:3b04:b8d8 with SMTP id s7-20020a05622a178700b003ef3b04b8d8mr6864767qtk.0.1681920029402;
        Wed, 19 Apr 2023 09:00:29 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZYUF3kcHxcm6ckUgKE4jJPmLKrZgKfEBTezTAcSg78TFUYNH1zoGoLr0UVt3eFwnqd/vm0zw==
X-Received: by 2002:a05:622a:1787:b0:3ef:3b04:b8d8 with SMTP id s7-20020a05622a178700b003ef3b04b8d8mr6864705qtk.0.1681920028817;
        Wed, 19 Apr 2023 09:00:28 -0700 (PDT)
Received: from [192.168.1.86] (pool-173-76-171-62.bstnma.fios.verizon.net. [173.76.171.62])
        by smtp.gmail.com with ESMTPSA id d9-20020ac81189000000b003eb136bec50sm4108983qtj.66.2023.04.19.09.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 09:00:27 -0700 (PDT)
Message-ID: <10e453df-6911-e40d-8758-66caf9c59dbe@redhat.com>
Date:   Wed, 19 Apr 2023 12:00:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] mm/mmap: Map MAP_STACK to VM_STACK
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Barry Marson <bmarson@redhat.com>,
        Rafael Aquini <aquini@redhat.com>
References: <20230418210230.3495922-1-longman@redhat.com>
 <20230418141852.75e551e57e97f4b522957c5c@linux-foundation.org>
 <6c3c68b1-c4d4-dd82-58e8-f7013fb6c8e5@redhat.com>
 <ZD9kKTsPVlzlEZLp@casper.infradead.org>
 <9f92d530-1cfc-6e50-a717-321ac64ed1c2@redhat.com>
 <ZEAEDqVhS0qz6Wx1@casper.infradead.org>
From:   Joe Mario <jmario@redhat.com>
In-Reply-To: <ZEAEDqVhS0qz6Wx1@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/23 11:09 AM, Matthew Wilcox wrote:
> On Wed, Apr 19, 2023 at 11:07:04AM -0400, Waiman Long wrote:
>> On 4/18/23 23:46, Matthew Wilcox wrote:
>>> On Tue, Apr 18, 2023 at 09:16:37PM -0400, Waiman Long wrote:
>>>>   1) App runs creating lots of threads.
>>>>   2) It mmap's 256K pages of anonymous memory.
>>>>   3) It writes executable code to that memory.
>>>>   4) It calls mprotect() with PROT_EXEC on that memory so
>>>>      it can subsequently execute the code.
>>>>
>>>> The above mprotect() will fail if the mmap'd region's VMA gets merged with
>>>> the VMA for one of the thread stacks.  That's because the default RHEL
>>>> SELinux policy is to not allow executable stacks.
>>> By the way, this is a daft policy.  The policy you really want is
>>> EXEC|WRITE is not allowed.  A non-writable stack is useless, so it's
>>> actually a superset of your current policy.  Forbidding _simultaneous_
>>> write and executable is just good programming.  This way, you don't need
>>> to care about the underlying VMA's current permissions, you just need
>>> to do:
>>>
>>> 	if ((prot & (PROT_EXEC|PROT_WRITE)) == (PROT_EXEC|PROT_WRITE))
>>> 		return -EACCESS;
>>
>> I am not totally sure if the application changes the VMA to read-only first.
>> Even if it does that, it highlights another possible issue when an anonymous
>> VMA is merged with a stack VMA. Either the mprotect() to write-protect the
>> VMA will fail or the application will segfault if it writes stuff to the
>> stack. This particular issue is not related to SELinux. It provides another
>> good idea why we should avoid merging stack VMA to anonymous VMA.
> 
> mprotect will split the VMA into two VMAs, one that is
> PROT_READ|PROT_WRITE and one the is PROT_READ|PROT_EXEC.
> 

But in this case, the latter still has PROT_WRITE.  

This was reported by a large data analytics customer.  They started getting infrequent random crashes in code they haven't touched in 10 years.

One of the threads in their program mmaps a large region using PROT_READ|PROT_WRITE, and that region just happens to be merged with the thread's stack.

Then they copy a small snipit of code to a location somewhere within that mapped region. For the one page that contains that code, they mprotect it to PROT_READ|PROT_WRITE|PROT_EXEC.  I recall they're still reading and writing data elsewhere on that page.

Joe




  

