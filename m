Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC8A65B1B4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 13:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjABMBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 07:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjABMB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 07:01:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC2ABE9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 04:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672660840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DcpgJX30wscykTQ9ii4gKeBqfxvD6fUqo095Fyay8SQ=;
        b=O2daqLDN+3gcL0mc70iRERTc63glq7BSjzvetkF0zDlVrOCINl/SomFFg0AMGN+4neL37N
        0gwvx/jw8lLcx3g//k89gd1eNPb6UNhY4uJfvmsvbypVhh+jh9YENSUJoV7Ch1ZKh/7Qxq
        IaM1jRoKAtt4y2F7fUezAR+u+11PxPk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-67-rcjYmesqOTuJUUveEZDjKg-1; Mon, 02 Jan 2023 07:00:39 -0500
X-MC-Unique: rcjYmesqOTuJUUveEZDjKg-1
Received: by mail-wm1-f71.google.com with SMTP id n18-20020a05600c4f9200b003d993e08485so7675259wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 04:00:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcpgJX30wscykTQ9ii4gKeBqfxvD6fUqo095Fyay8SQ=;
        b=B1FgySxwblzGbAlGc24H2jolWXesGxhh2hzziS/ugasvLbpigbEpQ9Iek3qmTA7LFS
         m9M70aX8HjFeJ5vPgMYCu9Qv5fbp7X6UIRyYgWQy+BoJretXHoZfv1nRCcrj7CZ/JHZl
         Yxj9NYqBnYsBAgVSU+9P7pXoz2+FTjcBKBc718ceMXTCDyuTovpT7NtzwsFQk+Wam2AB
         7mdIz4XFfNGE7WmO8soTNc+Grx/G5OfU8tD3lfOLVCoxaRC9D1XJoexoJGx/4TusOtEV
         +N1t7JyHJu1CgQygTKJe4rBWCT3jvf+3+MJjOuMxkI819g1CQTAvQkQxBFinqh8Vz9ZB
         7yxg==
X-Gm-Message-State: AFqh2koTP941vAjMpjQn/RsbzQpRjU7OUF1O6ayKdrtisPgZ0zO5T0+j
        0qhy5//8np6KAli8qodju8Ct5uoTc+0100rGXak1BH1eIG55xPpCHqH+H/4RvrtyPOvRpeqpTkA
        gWO6EzYocE/OXEofx8sTeLCTJ
X-Received: by 2002:a05:600c:358e:b0:3d9:9755:d659 with SMTP id p14-20020a05600c358e00b003d99755d659mr11087426wmq.22.1672660838569;
        Mon, 02 Jan 2023 04:00:38 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsIJE0L73xRyosk2B5P5nocn3N827sBpnbPLGg2GCquluuPM084Hu2VzkaNzcO0cHEpOqxkvg==
X-Received: by 2002:a05:600c:358e:b0:3d9:9755:d659 with SMTP id p14-20020a05600c358e00b003d99755d659mr11087392wmq.22.1672660838265;
        Mon, 02 Jan 2023 04:00:38 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:500:9382:2e5a:fea:8889? (p200300cbc703050093822e5a0fea8889.dip0.t-ipconnect.de. [2003:cb:c703:500:9382:2e5a:fea:8889])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003b47b80cec3sm42766964wmq.42.2023.01.02.04.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 04:00:37 -0800 (PST)
Message-ID: <6ddb468a-3771-92a1-deb1-b07a954293a3@redhat.com>
Date:   Mon, 2 Jan 2023 13:00:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/1] mm: fix vma->anon_name memory leak for anonymous
 shmem VMAs
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     hughd@google.com, hannes@cmpxchg.org, vincent.whitchurch@axis.com,
        seanjc@google.com, rppt@kernel.org, shy828301@gmail.com,
        pasha.tatashin@soleen.com, paul.gortmaker@windriver.com,
        peterx@redhat.com, vbabka@suse.cz, Liam.Howlett@Oracle.com,
        ccross@google.com, willy@infradead.org, arnd@arndb.de,
        cgel.zte@gmail.com, yuzhao@google.com, bagasdotme@gmail.com,
        suleiman@google.com, steven@liquorix.net, heftig@archlinux.org,
        cuigaosheng1@huawei.com, kirill@shutemov.name,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org,
        syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
References: <20221228194249.170354-1-surenb@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221228194249.170354-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.12.22 20:42, Suren Baghdasaryan wrote:
> free_anon_vma_name() is missing a check for anonymous shmem VMA which
> leads to a memory leak due to refcount not being dropped. Fix this by
> adding the missing check.
> 
> Fixes: d09e8ca6cb93 ("mm: anonymous shared memory naming")
> Reported-by: syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>   include/linux/mm_inline.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index e8ed225d8f7c..d650ca2c5d29 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -413,7 +413,7 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
>   	 * Not using anon_vma_name because it generates a warning if mmap_lock
>   	 * is not held, which might be the case here.
>   	 */
> -	if (!vma->vm_file)
> +	if (!vma->vm_file || vma_is_anon_shmem(vma))
>   		anon_vma_name_put(vma->anon_name);

Wouldn't it be me more consistent to check for "vma->anon_name"?

That's what dup_anon_vma_name() checks. And it's safe now because 
anon_name is no longer overloaded in vm_area_struct.

-- 
Thanks,

David / dhildenb

