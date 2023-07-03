Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712EF745A8C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjGCKrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGCKrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:47:40 -0400
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880D1B2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 03:47:38 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso6660799e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 03:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688381257; x=1690973257;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q0pgiVTiJV85KYdFZsn/u4+OjbChkIzO5jipDAA2eIs=;
        b=RiRUN5KUB84Fk1RLhAeNRwm7oA+sd9MiftQSInZKLHo67OmCR6vcIy6//ANBeOr9YP
         XVOaP4Xs+bFuxNDpeHCGEtCMaZu3oLcykqeltC7CNL0wt2aCiLplY8wqQpSEe74yrbsD
         GkSBse30BvplzawfuBE0X6QWq91KoQvUcdA+CnntXQ4Jr02/YwvuIlXDZ4v6pEXIf/7K
         eq5+uB3RWwLreC8nOgSlrVaqy7BvwQtBz1QdjU2JabIS/AfXscqHR13X5gN9j6A63A8Y
         o95/4IwcNmuPO44+LGtltDpvk9X3ecO6fLWlSvYMaatq3jLVPuQvGPbwOqLheIOn7fgd
         sroQ==
X-Gm-Message-State: ABy/qLYKXzoLlumBPyMX1Og7P7d7deKJdZW3mAtUI/2QezVWcRe9E53a
        z25c5nT404cyfkqsKNIK+kw=
X-Google-Smtp-Source: APBJJlHQ/cbXe9ha7CIPXP3O2bAfXoMcUZ/X0EY7P046JU2Y4R8qaIbjyO02AceXRYrZ0C013Zie2w==
X-Received: by 2002:a05:6512:3e29:b0:4fb:73b5:e1cf with SMTP id i41-20020a0565123e2900b004fb73b5e1cfmr8329655lfv.64.1688381256424;
        Mon, 03 Jul 2023 03:47:36 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id y17-20020a1c4b11000000b003f90a604885sm26673425wma.34.2023.07.03.03.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 03:47:35 -0700 (PDT)
Message-ID: <2f150512-e460-a9ae-65db-39dc54fe99d6@kernel.org>
Date:   Mon, 3 Jul 2023 12:47:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 29/33] x86/mm: try VMA lock-based page fault handling
 first
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        jacobly.alt@gmail.com
References: <20230227173632.3292573-1-surenb@google.com>
 <20230227173632.3292573-30-surenb@google.com>
 <dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel.org>
 <CAJuCfpF7LweMwpvXavjJZhAciK7wK-bdLz2aFhOZGSHeK5tA9A@mail.gmail.com>
 <9a8d788c-b8ba-1b8a-fd79-0e25b1b60bed@kernel.org>
 <f7ad7a42-13c8-a486-d0b7-01d5acf01e13@kernel.org>
 <f8864bb0-3d76-20d5-8a25-aab9726354f2@kernel.org>
 <CAJuCfpGLozRzxE9KZehgW1dAYpNxe4b+nnjH+ppbeAuFtRNGBQ@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CAJuCfpGLozRzxE9KZehgW1dAYpNxe4b+nnjH+ppbeAuFtRNGBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc Jacob Young (from kernel bugzilla)

On 30. 06. 23, 19:40, Suren Baghdasaryan wrote:
> On Fri, Jun 30, 2023 at 1:43 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>>
>> On 30. 06. 23, 10:28, Jiri Slaby wrote:
>>>   > 2348
>>> clone3({flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, child_tid=0x7fcaa5882990, parent_tid=0x7fcaa5882990, exit_signal=0, stack=0x7fcaa5082000, stack_size=0x7ffe00, tls=0x7fcaa58826c0} => {parent_tid=[2351]}, 88) = 2351
>>>   > 2350  <... clone3 resumed> => {parent_tid=[2372]}, 88) = 2372
>>>   > 2351  <... clone3 resumed> => {parent_tid=[2354]}, 88) = 2354
>>>   > 2351  <... clone3 resumed> => {parent_tid=[2357]}, 88) = 2357
>>>   > 2354  <... clone3 resumed> => {parent_tid=[2355]}, 88) = 2355
>>>   > 2355  <... clone3 resumed> => {parent_tid=[2370]}, 88) = 2370
>>>   > 2370  mmap(NULL, 262144, PROT_READ|PROT_WRITE,
>>> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <unfinished ...>
>>>   > 2370  <... mmap resumed>)               = 0x7fca68249000
>>>   > 2372  <... clone3 resumed> => {parent_tid=[2384]}, 88) = 2384
>>>   > 2384  <... clone3 resumed> => {parent_tid=[2388]}, 88) = 2388
>>>   > 2388  <... clone3 resumed> => {parent_tid=[2392]}, 88) = 2392
>>>   > 2392  <... clone3 resumed> => {parent_tid=[2395]}, 88) = 2395
>>>   > 2395  write(2, "runtime: marked free object in s"..., 36 <unfinished
>>> ...>
>>>
>>> I.e. IIUC, all are threads (CLONE_VM) and thread 2370 mapped ANON
>>> 0x7fca68249000 - 0x7fca6827ffff and go in thread 2395 thinks for some
>>> reason 0x7fca6824bec8 in that region is "bad".
> 
> Thanks for the analysis Jiri.
> Is it possible from these logs to identify whether 2370 finished the
> mmap operation before 2395 tried to access 0x7fca6824bec8? That access
> has to happen only after mmap finishes mapping the region.

Hi,

it's hard to tell, but I assume so.

For now, forget about this go's overly complicated, hard to reproduce 
case and concentrate on the very nice reduced testcase in:
  https://bugzilla.kernel.org/show_bug.cgi?id=217624
;)

FWIW, I can reproduce using the test case too.

thanks,
-- 
js
suse labs

