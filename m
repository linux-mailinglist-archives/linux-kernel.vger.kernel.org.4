Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9CD65CF0C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbjADJFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238718AbjADJE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:04:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3687413F94
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672823050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3v5Qr9aSLQNkwvt7Qa+s/hSgVujW47TYO8SFPz2SG6c=;
        b=VlNTSyWKjesu8o48I+tXtaKd2x3uSIFX+tO67r7JKzFmG4qCUcAWVfuGMJbmJgPyDgvUJY
        qhCcZkqQA0jmkznAGGXavp8KE2BqFOJ1TtFvcJi7ntPqi94NzuzvabqO33fZATRjut5Rsk
        2ue42wyN+bMMqcOdu0v8qRD6/2LiQGg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-231-OUXjoY53Pdu2_vEVWvLhwA-1; Wed, 04 Jan 2023 04:04:08 -0500
X-MC-Unique: OUXjoY53Pdu2_vEVWvLhwA-1
Received: by mail-wm1-f69.google.com with SMTP id m7-20020a05600c4f4700b003d971a5e770so15779678wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 01:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3v5Qr9aSLQNkwvt7Qa+s/hSgVujW47TYO8SFPz2SG6c=;
        b=G4pwMMmL1GrRzDO99RO2QZK+aJrA87/BAQDzjUcjHk0fVa1OOVrAfZlH/b9uuSFqBU
         0XK2P3Tbf0so7dyzT/IgNnqAuMLcSC06o4Z9WfIj3c8zHw3Xl3QyN6tM8w1hOPrAPLTj
         xIPqqjHsoLgCZrUp343aLzaXPVe85sOoZs+7zm5wWxeatLCN5/Czjue8eq/GWnfAg7NX
         0YiV96O7LmsXoBKpErbLjwMAFlm4+cOWO2ptmyTovU1qRL6gE1Tr+7b01DQdMNlvBbTC
         Ov+iSdGYBrXu6J/KDlvfiS2cX3fQ7nH1KsSz34XHbpOIkWTuB5+XAN47tlZzyb4wfwDY
         XWcg==
X-Gm-Message-State: AFqh2kqdkTWvR2F8ARF+obgKLqObLhTm3U3TZNO09DSUZj10pMt+1ZFY
        k2tbMHFu5r0yMDUdPonCryHiQ1x/dCdDHk6lCFDJWoW4Gz0CkO0VSga0DGL44v2Gau9R7xP9xit
        8hazPK8CI5Lrp3IJ646ppZmnV
X-Received: by 2002:a05:600c:2d85:b0:3d0:7d89:2256 with SMTP id i5-20020a05600c2d8500b003d07d892256mr32189733wmg.13.1672823047441;
        Wed, 04 Jan 2023 01:04:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu6TKYF8n/sbH/DYFQlrGieorL58hStPNcoaQHix/JEwDP10q76ayzPzUHCuWo/AHMULsh+lA==
X-Received: by 2002:a05:600c:2d85:b0:3d0:7d89:2256 with SMTP id i5-20020a05600c2d8500b003d07d892256mr32189690wmg.13.1672823046983;
        Wed, 04 Jan 2023 01:04:06 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:f100:8100:5a6c:eb:fd3b? (p200300cbc703f10081005a6c00ebfd3b.dip0.t-ipconnect.de. [2003:cb:c703:f100:8100:5a6c:eb:fd3b])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c314900b003d99469ece1sm28460642wmo.24.2023.01.04.01.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 01:04:06 -0800 (PST)
Message-ID: <b3aec4d4-737d-255a-d25e-451222fc9bb9@redhat.com>
Date:   Wed, 4 Jan 2023 10:04:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/1] mm: fix vma->anon_name memory leak for anonymous
 shmem VMAs
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, hughd@google.com, hannes@cmpxchg.org,
        vincent.whitchurch@axis.com, seanjc@google.com, rppt@kernel.org,
        shy828301@gmail.com, pasha.tatashin@soleen.com,
        paul.gortmaker@windriver.com, peterx@redhat.com, vbabka@suse.cz,
        Liam.Howlett@oracle.com, ccross@google.com, willy@infradead.org,
        arnd@arndb.de, cgel.zte@gmail.com, yuzhao@google.com,
        bagasdotme@gmail.com, suleiman@google.com, steven@liquorix.net,
        heftig@archlinux.org, cuigaosheng1@huawei.com,
        kirill@shutemov.name, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
References: <20221228194249.170354-1-surenb@google.com>
 <6ddb468a-3771-92a1-deb1-b07a954293a3@redhat.com>
 <CAJuCfpGUpPPoKjAAmV7UK2H2o2NqsSa+-_M6JwesCfc+VRY2vw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAJuCfpGUpPPoKjAAmV7UK2H2o2NqsSa+-_M6JwesCfc+VRY2vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.01.23 20:53, Suren Baghdasaryan wrote:
> On Mon, Jan 2, 2023 at 4:00 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 28.12.22 20:42, Suren Baghdasaryan wrote:
>>> free_anon_vma_name() is missing a check for anonymous shmem VMA which
>>> leads to a memory leak due to refcount not being dropped. Fix this by
>>> adding the missing check.
>>>
>>> Fixes: d09e8ca6cb93 ("mm: anonymous shared memory naming")
>>> Reported-by: syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>> ---
>>>    include/linux/mm_inline.h | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
>>> index e8ed225d8f7c..d650ca2c5d29 100644
>>> --- a/include/linux/mm_inline.h
>>> +++ b/include/linux/mm_inline.h
>>> @@ -413,7 +413,7 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
>>>         * Not using anon_vma_name because it generates a warning if mmap_lock
>>>         * is not held, which might be the case here.
>>>         */
>>> -     if (!vma->vm_file)
>>> +     if (!vma->vm_file || vma_is_anon_shmem(vma))
>>>                anon_vma_name_put(vma->anon_name);
>>
>> Wouldn't it be me more consistent to check for "vma->anon_name"?
>>
>> That's what dup_anon_vma_name() checks. And it's safe now because
>> anon_name is no longer overloaded in vm_area_struct.
> 
> Thanks for the suggestion, David. Yes, with the recent change that
> does not overload anon_name, checking for "vma->anon_name" would be
> simpler. I think we can also drop anon_vma_name() function now
> (https://elixir.bootlin.com/linux/v6.2-rc2/source/mm/madvise.c#L94)
> since vma->anon_name does not depend on vma->vm_file anymore, remove
> the last part of this comment:
> https://elixir.bootlin.com/linux/v6.2-rc2/source/include/linux/mm_types.h#L584
> and use vma->anon_name directly going forward. If all that sounds
> good, I'll post a separate patch implementing all these changes.
> So, for this patch I would suggest keeping it as is because
> functionally it is correct and will change this check along with other
> corrections I mentioned above in a separate patch. Does that sound
> good?

Works for me.

Acked-by: David Hildenbrand <david@redhat.com>

for this one, as it fixes the issue.

-- 
Thanks,

David / dhildenb

