Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD98662024
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbjAIIhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjAIIhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:37:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAD513E15
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673253411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Kv0tKlHIz61BWkfNwfRuVbsf96Cqd8RpZSvBC6o6BQ=;
        b=Gd3sY3+pbTVH3aJnody8s4Yb15hby6uhEOjunQ29/PzvuUcbBVGXzOH171ZWTC2JWuYVGB
        NAAblMj2WvFlpJCUmdwgv7AVfsREWdBDf+9e8F1GMrHGyJ/rrhF8ydJX0XBdpBy7eyZt4Q
        B1lmwCwB8ic9fhRhNZrNUDf8oJwb9e0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-363-I6VlvfZVNGqhfZWdyQrD8w-1; Mon, 09 Jan 2023 03:36:50 -0500
X-MC-Unique: I6VlvfZVNGqhfZWdyQrD8w-1
Received: by mail-wm1-f71.google.com with SMTP id m8-20020a05600c3b0800b003d96bdce12fso4403023wms.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 00:36:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Kv0tKlHIz61BWkfNwfRuVbsf96Cqd8RpZSvBC6o6BQ=;
        b=Cip/ZvOHgkcEqG+wL3E56s9q/h8bxSpsrCCTbK2aTZBF/lcSYpL4//kl0T9HemPQdy
         dgDOvttJhtFbfqLyVuGYv/4P5DZ4JwhkVFKn7/2vvccEas6qAVODN3pg/bXg0PCP5jbK
         4vGq2IR/lkwfwYKriQi3c+jrlrbHTSs5yYEgmvbg2OJaFhIskS0fDZUn4cdTJeQyKgzM
         ddbsj8xkISiSty1SDPAZv10dVje1Pgc0zXxBvsAmsPjG2CYJscKm6+X4Pbia3WqcL4tZ
         cJIPlVJbzr46gNafw25X6bzJWWSKFpqoxrKq0NPZmYvVD2KSuRdmxg1Z5/GF5rEkvg+i
         iuzQ==
X-Gm-Message-State: AFqh2krWxwOhD0aL7J2N4ra7RHBNYCjU6tveWDX1JvH5nJO+e0TfnsGI
        r5BMIlxZxFo8Sd0UlXo/mDgUpTrKS4DY+kDubUVJLdvWyZxrAa+217rRrTGCnBV0NoNW2LeQZA/
        l2NQu7tjk2RE54HiTKWehZfLK
X-Received: by 2002:a05:600c:4da0:b0:3d2:3a53:2cd6 with SMTP id v32-20020a05600c4da000b003d23a532cd6mr46060678wmp.9.1673253409117;
        Mon, 09 Jan 2023 00:36:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvsvcEWlhawTW11dcgo7sA67lLcZ1eb9qozTyOzhskeQHRDFyAP00PQUHFOlV9jCORBScZ4jg==
X-Received: by 2002:a05:600c:4da0:b0:3d2:3a53:2cd6 with SMTP id v32-20020a05600c4da000b003d23a532cd6mr46060667wmp.9.1673253408848;
        Mon, 09 Jan 2023 00:36:48 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:8f00:ba3:7d27:204f:8e29? (p200300cbc7038f000ba37d27204f8e29.dip0.t-ipconnect.de. [2003:cb:c703:8f00:ba3:7d27:204f:8e29])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b003c70191f267sm15997370wmo.39.2023.01.09.00.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 00:36:48 -0800 (PST)
Message-ID: <c8f513ab-1258-d5aa-e0e6-5cf68f5223a9@redhat.com>
Date:   Mon, 9 Jan 2023 09:36:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/3] mm/uffd: Detect pgtable allocation failures
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230104225207.1066932-1-peterx@redhat.com>
 <20230104225207.1066932-4-peterx@redhat.com>
 <AF984D5D-DC66-4FD3-A749-5AF6B7289E0D@gmail.com>
 <cc6e17ad-1afd-5c52-a06e-1d89d1978368@redhat.com>
 <B38AB79D-51D7-4F1A-A5CB-A60A46A3E27F@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <B38AB79D-51D7-4F1A-A5CB-A60A46A3E27F@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.01.23 19:01, Nadav Amit wrote:
> 
> 
>> On Jan 5, 2023, at 12:59 AM, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 05.01.23 04:10, Nadav Amit wrote:
>>>> On Jan 4, 2023, at 2:52 PM, Peter Xu <peterx@redhat.com> wrote:
>>>>
>>>> Before this patch, when there's any pgtable allocation issues happened
>>>> during change_protection(), the error will be ignored from the syscall.
>>>> For shmem, there will be an error dumped into the host dmesg.  Two issues
>>>> with that:
>>>>
>>>>   (1) Doing a trace dump when allocation fails is not anything close to
>>>>       grace..
>>>>
>>>>   (2) The user should be notified with any kind of such error, so the user
>>>>       can trap it and decide what to do next, either by retrying, or stop
>>>>       the process properly, or anything else.
>>>>
>>>> For userfault users, this will change the API of UFFDIO_WRITEPROTECT when
>>>> pgtable allocation failure happened.  It should not normally break anyone,
>>>> though.  If it breaks, then in good ways.
>>>>
>>>> One man-page update will be on the way to introduce the new -ENOMEM for
>>>> UFFDIO_WRITEPROTECT.  Not marking stable so we keep the old behavior on the
>>>> 5.19-till-now kernels.
>>> I understand that the current assumption is that change_protection() should
>>> fully succeed or fail, and I guess this is the current behavior.
>>> However, to be more “future-proof” perhaps this needs to be revisited.
>>> For instance, UFFDIO_WRITEPROTECT can benefit from the ability to (based on
>>> userspace request) prevent write-protection of pages that are pinned. This is
>>> necessary to allow userspace uffd monitor to avoid write-protection of
>>> O_DIRECT’d memory, for instance, that might change even if a uffd monitor
>>> considers it write-protected.
>>
>> Just a note that this is pretty tricky IMHO, because:
>>
>> a) We cannot distinguished "pinned readable" from "pinned writable"
>> b) We can have false positives ("pinned") even for compound pages due to
>>    concurrent GUP-fast.
>> c) Synchronizing against GUP-fast is pretty tricky ... as we learned.
>>    Concurrent pinning is usually problematic.
>> d) O_DIRECT still uses FOLL_GET and we cannot identify that. (at least
>>    that should be figured out at one point)
> 
> My prototype used the page-count IIRC, so it had false-positives (but

I suspect GUP-fast is still problematic, I might be wrong.

> addressed O_DIRECT). And yes, precise refinement is complicated. However,
> if you need to uffd-wp memory, then without such a mechanism you need to
> ensure no kerenl/DMA write to these pages is possible. The only other
> option I can think of is interposing/seccomp on a variety of syscalls,
> to prevent uffd-wp of such memory.

The whole thing reminds me of MADV_DONTNEED+pinning: an application 
shouldn't do it, because you can only get it wrong :) I know, that's a 
bad answer.

-- 
Thanks,

David / dhildenb

