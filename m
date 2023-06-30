Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04ECF7437AB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 10:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjF3Inq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 04:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjF3InN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 04:43:13 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776483C02
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 01:43:06 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-992ca792065so109660566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 01:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688114585; x=1690706585;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5B4IVr8Ja8HmXEBGoLMWf9UwelCEFdj8Ikbkk9A1VuU=;
        b=N4u63ZGmpj5k2FEasVogQJ5eTmmFbG02eurGZ0aBtBKkN5UuiyaVx4hAa5IKPb7oyZ
         Jgi9K7KSNSsHHy7VwJpeBtxOr7BWbovOkixnx6eznckqvXjbt8ozQQYsc9RNCJRUtmD5
         mEdgEoS5OxNBiS/MlIVygJb279KtEzXrpuArTqOS5XvZIGuEvFnXK4iLe2UhaHkZDIfy
         hB7b/XLl+O9aSkP9swZ60bZXNy96kCp0RlV7muNdVa54fqi1GuIRbn63kicqr0kQLRPL
         1ZVBgVNp4wXqoMa6wVCwtPQUOolh0h6rsaJZ7c+YjtHHqSIRRj7aIpdcmWeOTwwdbrBk
         oSmQ==
X-Gm-Message-State: ABy/qLbd7eR5ZqdMn0Jsytus4ixyFaL4pKEln5mOpdtjTXslwzz4nv39
        HqYb0fAApl3OA6spA5y4JNE=
X-Google-Smtp-Source: APBJJlFeNIVHPqaAGPftDvBSqiTQ4Tr/AXjHL5jLgbaPc4SKjWIPk0fOpqH5cRG+2Lv/IuCHmqm3Mg==
X-Received: by 2002:a17:906:e48:b0:988:882b:9a3 with SMTP id q8-20020a1709060e4800b00988882b09a3mr1415031eji.36.1688114585311;
        Fri, 30 Jun 2023 01:43:05 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id t14-20020a170906948e00b0098d2f703408sm7724415ejx.118.2023.06.30.01.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 01:43:04 -0700 (PDT)
Message-ID: <f8864bb0-3d76-20d5-8a25-aab9726354f2@kernel.org>
Date:   Fri, 30 Jun 2023 10:43:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 29/33] x86/mm: try VMA lock-based page fault handling
 first
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
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
        linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20230227173632.3292573-1-surenb@google.com>
 <20230227173632.3292573-30-surenb@google.com>
 <dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel.org>
 <CAJuCfpF7LweMwpvXavjJZhAciK7wK-bdLz2aFhOZGSHeK5tA9A@mail.gmail.com>
 <9a8d788c-b8ba-1b8a-fd79-0e25b1b60bed@kernel.org>
 <f7ad7a42-13c8-a486-d0b7-01d5acf01e13@kernel.org>
In-Reply-To: <f7ad7a42-13c8-a486-d0b7-01d5acf01e13@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30. 06. 23, 10:28, Jiri Slaby wrote:
>  > 2348 
> clone3({flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, child_tid=0x7fcaa5882990, parent_tid=0x7fcaa5882990, exit_signal=0, stack=0x7fcaa5082000, stack_size=0x7ffe00, tls=0x7fcaa58826c0} => {parent_tid=[2351]}, 88) = 2351
>  > 2350  <... clone3 resumed> => {parent_tid=[2372]}, 88) = 2372
>  > 2351  <... clone3 resumed> => {parent_tid=[2354]}, 88) = 2354
>  > 2351  <... clone3 resumed> => {parent_tid=[2357]}, 88) = 2357
>  > 2354  <... clone3 resumed> => {parent_tid=[2355]}, 88) = 2355
>  > 2355  <... clone3 resumed> => {parent_tid=[2370]}, 88) = 2370
>  > 2370  mmap(NULL, 262144, PROT_READ|PROT_WRITE, 
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <unfinished ...>
>  > 2370  <... mmap resumed>)               = 0x7fca68249000
>  > 2372  <... clone3 resumed> => {parent_tid=[2384]}, 88) = 2384
>  > 2384  <... clone3 resumed> => {parent_tid=[2388]}, 88) = 2388
>  > 2388  <... clone3 resumed> => {parent_tid=[2392]}, 88) = 2392
>  > 2392  <... clone3 resumed> => {parent_tid=[2395]}, 88) = 2395
>  > 2395  write(2, "runtime: marked free object in s"..., 36 <unfinished 
> ...>
> 
> I.e. IIUC, all are threads (CLONE_VM) and thread 2370 mapped ANON 
> 0x7fca68249000 - 0x7fca6827ffff and go in thread 2395 thinks for some 
> reason 0x7fca6824bec8 in that region is "bad".

As I was noticed, this might be as well be a fail of the go's 
inter-thread communication (or alike) too. It might now be only more 
exposed with vma-based locks as we can do more parallelism now.

There are older hard to reproduce bugs in go with similar symptoms (we 
see this error sometimes now too):
https://github.com/golang/go/issues/15246

Or this 2016 bug is a red herring. Hard to tell...

>> thanks,
-- 
js
suse labs

