Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2206748A14
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjGERZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjGERZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCFCE41
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 10:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688577896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v27EJolWd9vgnA83/Nkc58pSBSJkYYfnU44c9IwfWFY=;
        b=W8aOYvbbsar9tqJ7q27C0IrXHlPgR6pdjhHlyPANCSEmeoC6HTZawAW//Ui1HFDOrWNgrA
        ELDZ3R2tbm4FtVzch9X1a1hsvYsFnW2Cr59WZYEP2b5ctnrGWO0pbLoyRMg9STA1P4ALKa
        TxO39wSSOnipPXZf65NtjcPg7iAJ8SA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-Qwe8n7yFOoST1_yvnD9PGA-1; Wed, 05 Jul 2023 13:24:55 -0400
X-MC-Unique: Qwe8n7yFOoST1_yvnD9PGA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fb89482cd6so6970207e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 10:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688577893; x=1691169893;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v27EJolWd9vgnA83/Nkc58pSBSJkYYfnU44c9IwfWFY=;
        b=g37GUA3kLfH9UaAi4XvVy1njsCsbEsK9aFwtsIRHcCtHUpp5FF/J7qtqIWVdgqk/Nv
         Zpuo/2l8QdCI2tciBILUCZkHkMCrXRvMkve7EJxXjiYmOhaJ3whIVFHCOBFIf5dOq8A0
         A8SfaLx05h+T3QkM3OzATHjoMkUQTwMnx5cH9i7pL55w2ynl1dzs6Im4Cyy5TeLjzE2E
         oiDYaM9oTyAtfrBLwbtVw48LbQ34fPznmE4oUbDi1zI1kBD2YSL5j7y7rUhUJ6Pm3xnI
         B/0jwdf8Iy+iBO8gWCfZ2tRSbnoAdx2/4+UkstI/6p5MET1rhCMgubK+hFZbRDA/n243
         wENw==
X-Gm-Message-State: ABy/qLaZNbSzENLuvlbaT6jYEaM1TeAyoGfm7f6qKNazqC7e+PlOORbq
        hG9IV8LZFiUkNH77xujJH36Dc7aTm4HZfwc1IGeWjh3Folyz0E0l6ts2nH7MRUjsNo8YDPa1NWg
        NT5qNkr081YAZbKypyZgerpdi
X-Received: by 2002:a05:6512:3bc:b0:4f7:6775:2a66 with SMTP id v28-20020a05651203bc00b004f767752a66mr10546761lfp.53.1688577893205;
        Wed, 05 Jul 2023 10:24:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFwWvdb9CtRtlyPDaCglyB2byse00H+L5+2mWlx0zEDsjYRPwa8pgXijw9uCV1C55NL7pPWSw==
X-Received: by 2002:a05:6512:3bc:b0:4f7:6775:2a66 with SMTP id v28-20020a05651203bc00b004f767752a66mr10546722lfp.53.1688577892764;
        Wed, 05 Jul 2023 10:24:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:1c00:e2b1:fc33:379b:a713? (p200300cbc71a1c00e2b1fc33379ba713.dip0.t-ipconnect.de. [2003:cb:c71a:1c00:e2b1:fc33:379b:a713])
        by smtp.gmail.com with ESMTPSA id x16-20020a1c7c10000000b003fbe4cecc3bsm2682371wmc.16.2023.07.05.10.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 10:24:51 -0700 (PDT)
Message-ID: <e4f64aa8-93f5-e731-5d6f-e37ae373c006@redhat.com>
Date:   Wed, 5 Jul 2023 19:24:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/2] mm: disable CONFIG_PER_VMA_LOCK until its fixed
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, jirislaby@kernel.org,
        jacobly.alt@gmail.com, holger@applied-asynchrony.com,
        hdegoede@redhat.com, michel@lespinasse.org, jglisse@google.com,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20230705171213.2843068-1-surenb@google.com>
 <20230705171213.2843068-3-surenb@google.com>
 <3cdaa7d4-1293-3806-05ce-6b7fc4382458@redhat.com>
 <CAJuCfpGTNF9BWBxZoqYKSDrtq=iJoN1n8oTc=Yu0pPzW8cs8rQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAJuCfpGTNF9BWBxZoqYKSDrtq=iJoN1n8oTc=Yu0pPzW8cs8rQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.07.23 19:22, Suren Baghdasaryan wrote:
> On Wed, Jul 5, 2023 at 10:16 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 05.07.23 19:12, Suren Baghdasaryan wrote:
>>> A memory corruption was reported in [1] with bisection pointing to the
>>> patch [2] enabling per-VMA locks for x86.
>>> Disable per-VMA locks config to prevent this issue while the problem is
>>> being investigated. This is expected to be a temporary measure.
>>>
>>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=217624
>>> [2] https://lore.kernel.org/all/20230227173632.3292573-30-surenb@google.com
>>>
>>> Reported-by: Jiri Slaby <jirislaby@kernel.org>
>>> Closes: https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel.org/
>>> Reported-by: Jacob Young <jacobly.alt@gmail.com>
>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217624
>>> Fixes: 0bff0aaea03e ("x86/mm: try VMA lock-based page fault handling first")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>> ---
>>>    mm/Kconfig | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>> index 09130434e30d..0abc6c71dd89 100644
>>> --- a/mm/Kconfig
>>> +++ b/mm/Kconfig
>>> @@ -1224,8 +1224,9 @@ config ARCH_SUPPORTS_PER_VMA_LOCK
>>>           def_bool n
>>>
>>>    config PER_VMA_LOCK
>>> -     def_bool y
>>> +     bool "Enable per-vma locking during page fault handling."
>>>        depends on ARCH_SUPPORTS_PER_VMA_LOCK && MMU && SMP
>>> +     depends on BROKEN
>>>        help
>>>          Allow per-vma locking during page fault handling.
>>>
>> Do we have any testing results (that don't reveal other issues :) ) for
>> patch #1? Not sure if we really want to mark it broken if patch #1 fixes
>> the issue.
> 
> I tested the fix using the only reproducer provided in the reports
> plus kernel compilation and my fork stress test. All looked good and
> stable but I don't know if other reports had the same issue or
> something different.

Can you point me at the other reports, so I can quickly scan them?

-- 
Cheers,

David / dhildenb

