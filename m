Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C836E4635
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjDQLRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjDQLRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:17:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4252D76BD
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681730042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zAUqMMR70hs25oMWjXxlhHN7VAFevFPXHxG6Ef3AXlI=;
        b=CLxQcjFz0zTzXu/O4TJseblZdQU/Bdha9ZlHyPcGsiAk2zgC8gcQZUnjTDD+0tHNUo/jWx
        FUGoyXSPqLnqdRgvdxZljqTZxnZLpGt8HS0T9CdhfsC2xrBi0ypG+Liw8SO6uPYh4SqLMC
        LxWgE5jaJT1hNTjBs2spqdG9ndwqSME=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-AVtucXeTMIOioSHuQsteKg-1; Mon, 17 Apr 2023 07:14:01 -0400
X-MC-Unique: AVtucXeTMIOioSHuQsteKg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-2fbb99cb2easo4407f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681730040; x=1684322040;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAUqMMR70hs25oMWjXxlhHN7VAFevFPXHxG6Ef3AXlI=;
        b=Nf8ZL4ouIxv5VuZWkmYnxQrA6DOGpkR7XQzu0DLKbMYAZZs93TfLhOBRTCJPUoctTb
         5/cbeGJp8NdSkNmHpmZGHL5XG/1M6tIu2fvp+9yK7D71qunko8B16I0T4VNrjQ5SY6Z0
         pubq6vuXQip9NefNsC5Mi2hSeQ73RAfwqnYBHzqEyZ+aoxPD+yqE2tUHlnoj4KgH2jNS
         pPlombElITnYweboNXD4DD5GeWQ7meAvnkeYO94X+3UdDZRCCmWYupwzMp5Tszzg+xQz
         iaxiI2dXF5pCQkSj9XH8tISq6arotQ94PEGKdSbj6kQzeu1KepufvslZ3ZUP3WR0mzlX
         MAlw==
X-Gm-Message-State: AAQBX9eEtwlBEymot2oJuWns33hy3Wu8JY3UNw51TTayaG9/82tZ+Vhf
        6xttuKAU1UfbHD17V+3LSBXZoreWgMuGhI5xRGVN2Ff1MsNUaUQ26SfIpIhfJ2AVF6zfLyxrwV4
        Mf8/Ai2ybqS+ats86dskh7YJy
X-Received: by 2002:adf:f285:0:b0:2d8:4e4:8cf1 with SMTP id k5-20020adff285000000b002d804e48cf1mr4136249wro.21.1681730040585;
        Mon, 17 Apr 2023 04:14:00 -0700 (PDT)
X-Google-Smtp-Source: AKy350ax7wuZ0Iz3BSuaDK/61BajmIrYjRyEbJKqxJkNyFbcymWg3m+sbjevfS9itJuunEOl+2y01A==
X-Received: by 2002:adf:f285:0:b0:2d8:4e4:8cf1 with SMTP id k5-20020adff285000000b002d804e48cf1mr4136237wro.21.1681730040201;
        Mon, 17 Apr 2023 04:14:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:db07:68a9:6af5:ecdf? (p200300cbc700fc00db0768a96af5ecdf.dip0.t-ipconnect.de. [2003:cb:c700:fc00:db07:68a9:6af5:ecdf])
        by smtp.gmail.com with ESMTPSA id b2-20020adfe302000000b002fae2a08089sm1583630wrj.70.2023.04.17.04.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 04:13:59 -0700 (PDT)
Message-ID: <e4087551-c5d3-e82d-3c4e-dcfa476a971e@redhat.com>
Date:   Mon, 17 Apr 2023 13:13:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>
References: <cover.1681558407.git.lstoakes@gmail.com>
 <2feedd2bad6fd1ec4bc4639f9d9012c5ae2faf1f.1681558407.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 4/7] mm/gup: introduce the FOLL_SAME_FILE GUP flag
In-Reply-To: <2feedd2bad6fd1ec4bc4639f9d9012c5ae2faf1f.1681558407.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.04.23 14:09, Lorenzo Stoakes wrote:
> This flag causes GUP to assert that all VMAs within the input range possess
> the same vma->vm_file. If not, the operation fails.
> 
> This is part of a patch series which eliminates the vmas parameter from the
> GUP API, implementing the one remaining assertion within the entire kernel
> that requires access to the VMAs associated with a GUP range.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

[...]

> ---
>   						&start, &nr_pages, i,
> @@ -1595,7 +1603,7 @@ long faultin_vma_page_range(struct vm_area_struct *vma, unsigned long start,
>   	 * We want to report -EINVAL instead of -EFAULT for any permission
>   	 * problems or incompatible mappings.
>   	 */
> -	if (check_vma_flags(vma, gup_flags))
> +	if (check_vma_flags(vma, vma->vm_file, gup_flags))
>   		return -EINVAL;

FOLL_SAME_FILE is never set here, just pass NULL instead of vma->vm_file.


As we're not allowing to drop the mmap lock, why can't io_uring simply 
go over all VMAs once, after pinning succeeded, and make sure that the 
files match (or even before pinning)?

In most cases, we're dealing with a single VMA only, it's not like the 
common case is that io_uring pins accross 100s of VMAs.

So I really wonder if the GUP complexity is justified by something. 
(removing the VMAs is certainly a welcome surprise -- as it doesn't make 
any sense when used with FOLL_UNLOCKABLE).

-- 
Thanks,

David / dhildenb

