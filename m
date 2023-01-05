Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD99C65E730
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjAEJA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjAEJAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:00:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4F25005D
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 00:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672909172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=upIlYRm2nv0gvFeqvVRrj60R4AvxeIzZxQeMo5tjjPY=;
        b=Cuo2SQ7Ydvq/1+EyADCCw7Wy51EEcmATDYOZbio8kl5R87xR0KfydYvKmxAXWzwF6h2qBM
        bmLY/7moNL8C39PZY57oYYxCHOOXcmYvc95PcwyyFioXfD7L76ZaXnNYdty4ClTuvKRgcm
        MrIOXHY9N4zRfoLZg5rD1KqJrbZea1E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-528-u1EUIOHENsyLjorWXXIFeg-1; Thu, 05 Jan 2023 03:59:31 -0500
X-MC-Unique: u1EUIOHENsyLjorWXXIFeg-1
Received: by mail-wr1-f70.google.com with SMTP id i9-20020adfa509000000b0027df24b887fso3325345wrb.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 00:59:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upIlYRm2nv0gvFeqvVRrj60R4AvxeIzZxQeMo5tjjPY=;
        b=BBtSK3FGF47sRZ1zp16RF2FZIX5pLWeinpSf+4+P40Y7TqUWUyryN2E5+aIrCRImJ4
         bCV7P8qb2jdqDHjOzqv3R2tPbeltLh+dC+D50coD5coj+182ebC1sKt3vYT0k0jvVu+/
         B5lzEqfOl5MFfX7GZNTRAW21XbQgMI7mpCalIFlPhf81KQ3f5MbIGvkho8IwJbetkQyi
         t08W6gVnSU+dp65pJxCxl3s+mliNeBj2WfyTMS8c75pMVjMx61KXmvusEanBb09wWU6Q
         pjSstd91Rte+6SfJhoP2HL8cWt2yqSIzrJKCDcYLVo1blf6iu5JKR/M2fPQ+j8VChvvH
         66RQ==
X-Gm-Message-State: AFqh2kpuYmSheZXruGvQ3dFK/PbgLEHuxbQ9zAJ6fZfuzxi4T+z8tGk4
        x5sNk1xyyJo66uQaarjH2gTgosU3J84H5mR2SIfB7BWehgm15UgcfBPM5suEQ8WOIngPsInp6O2
        kJlX8WxdInqg/Sch2pXU0Ocw3
X-Received: by 2002:a05:600c:1d8e:b0:3d6:e23:76a2 with SMTP id p14-20020a05600c1d8e00b003d60e2376a2mr34894791wms.34.1672909170332;
        Thu, 05 Jan 2023 00:59:30 -0800 (PST)
X-Google-Smtp-Source: AMrXdXufXzUK1PvLXyja6eVL7x3NsrtqjQxHZ/PzP8Ui5ZNLCow91JB6b5Asg8rZLfuM7j2MW7r5vg==
X-Received: by 2002:a05:600c:1d8e:b0:3d6:e23:76a2 with SMTP id p14-20020a05600c1d8e00b003d60e2376a2mr34894783wms.34.1672909170069;
        Thu, 05 Jan 2023 00:59:30 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e? (p200300cbc7076e00ff02ec7aded5ec1e.dip0.t-ipconnect.de. [2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c510900b003c6f8d30e40sm1791442wms.31.2023.01.05.00.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 00:59:29 -0800 (PST)
Message-ID: <cc6e17ad-1afd-5c52-a06e-1d89d1978368@redhat.com>
Date:   Thu, 5 Jan 2023 09:59:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>, Peter Xu <peterx@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 3/3] mm/uffd: Detect pgtable allocation failures
In-Reply-To: <AF984D5D-DC66-4FD3-A749-5AF6B7289E0D@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.01.23 04:10, Nadav Amit wrote:
> 
>> On Jan 4, 2023, at 2:52 PM, Peter Xu <peterx@redhat.com> wrote:
>>
>> Before this patch, when there's any pgtable allocation issues happened
>> during change_protection(), the error will be ignored from the syscall.
>> For shmem, there will be an error dumped into the host dmesg.  Two issues
>> with that:
>>
>>   (1) Doing a trace dump when allocation fails is not anything close to
>>       grace..
>>
>>   (2) The user should be notified with any kind of such error, so the user
>>       can trap it and decide what to do next, either by retrying, or stop
>>       the process properly, or anything else.
>>
>> For userfault users, this will change the API of UFFDIO_WRITEPROTECT when
>> pgtable allocation failure happened.  It should not normally break anyone,
>> though.  If it breaks, then in good ways.
>>
>> One man-page update will be on the way to introduce the new -ENOMEM for
>> UFFDIO_WRITEPROTECT.  Not marking stable so we keep the old behavior on the
>> 5.19-till-now kernels.
> 
> I understand that the current assumption is that change_protection() should
> fully succeed or fail, and I guess this is the current behavior.
> 
> However, to be more “future-proof” perhaps this needs to be revisited.
> 
> For instance, UFFDIO_WRITEPROTECT can benefit from the ability to (based on
> userspace request) prevent write-protection of pages that are pinned. This is
> necessary to allow userspace uffd monitor to avoid write-protection of
> O_DIRECT’d memory, for instance, that might change even if a uffd monitor
> considers it write-protected.

Just a note that this is pretty tricky IMHO, because:

a) We cannot distinguished "pinned readable" from "pinned writable"
b) We can have false positives ("pinned") even for compound pages due to
    concurrent GUP-fast.
c) Synchronizing against GUP-fast is pretty tricky ... as we learned.
    Concurrent pinning is usually problematic.
d) O_DIRECT still uses FOLL_GET and we cannot identify that. (at least
    that should be figured out at one point)

I have a patch lying around for a very long time that removes that 
special-pinned handling from softdirty code, because of the above 
reasons (and because it forgets THP). For now I didn't send it because 
for softdirty, it's acceptable to over-indicate and it hasn't been 
reported to be an actual problem so far.

For existing UFFDIO_WRITEPROTECT users, however, it might be very 
harmful (especially for existing users) to get false protection errors. 
Failing due to ENOMEM is different to failing due to some temporary 
concurrency issues.

Having that said, I started thinking about alternative ways of detecting 
that in that past, without much outcome so far: that latest idea was 
indicating "this MM has had pinned pages at one point, be careful 
because any techniques that use write-protection (softdirty, mprotect, 
uffd-wp) won't be able to catch writes via pinned pages reliably".

Hm.

-- 
Thanks,

David / dhildenb

