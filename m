Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08D46B0341
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjCHJnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCHJmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:42:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24BCB53C8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 01:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678268476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m7Td16p3TbD+kDYru97cnkRp6o+vBB7jl8z2uw+Ca3w=;
        b=aUNrwLAh9Pzu0jUqV79rsH5eNZJw5TQaw0JBUmgt8puYqfADOZQZArP0Lgn1qHZ0t3dhbU
        22jD6uje5Fo0YOXxbJ+bOVV960J5Zk/gv/XRcnhJOn68+nygmxZ3CcUpSZfrzRzSHvfLbW
        Rp11n1js5xexda1p4m+mQXEHUCOffjw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-ONKqIuTzM8e5LayvgClPiA-1; Wed, 08 Mar 2023 04:41:13 -0500
X-MC-Unique: ONKqIuTzM8e5LayvgClPiA-1
Received: by mail-wm1-f69.google.com with SMTP id l20-20020a05600c1d1400b003e10d3e1c23so735378wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 01:41:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678268472;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7Td16p3TbD+kDYru97cnkRp6o+vBB7jl8z2uw+Ca3w=;
        b=rPghSiEJTJp8daFGMea3yaIPO5TrDcja4stbR6XJXdk3E8+jB6PdvnxJNUlTj+++tO
         XFm1GRDbGdddn1lBGBTKrO0OEVKYE/pd1BdabzGLTpE12Q7JRWHDxjke71NRGWdAT5e0
         WRNlrg9FwF0uNE87Cn5OKWZp554vhQUndtd9Bt9DDVDLhUW638vni4p+fEsieopIXAIU
         GIP69tTIwtcINZHbk/+63KbNE1L+DhrSX6h7pS8t1gvMkB3iRw+DvvWTtzK7vJVR3ps8
         pi6CSuu+huV/KsiEeOQavrYGo3nf5fu4dLgA+qFtfEmBJRZdCBqyIv+wHjLQlztg1f54
         AaMw==
X-Gm-Message-State: AO0yUKVYR2zGB2UfpohbwNcPFtA6ztyJt70CxkEDtfDiFAsFpTlPl3YQ
        7Cb3rITPjsxXdgnpzTQL28c7bxoW8rveVVmKIH+AzTUjyrLv/aQ4VRSZKodVoHBPS42MLCdFhk8
        VgH0EXiZrz5DocqdyV2uYw8t/
X-Received: by 2002:adf:f048:0:b0:2c7:1757:3a8e with SMTP id t8-20020adff048000000b002c717573a8emr11809181wro.34.1678268472208;
        Wed, 08 Mar 2023 01:41:12 -0800 (PST)
X-Google-Smtp-Source: AK7set8Ymu+LXx9nCtK2pvrM5/lBSUM962NTfLkeMSnJCReM+FspgE/w457FUI4GWu9X+B6h9vVsRA==
X-Received: by 2002:adf:f048:0:b0:2c7:1757:3a8e with SMTP id t8-20020adff048000000b002c717573a8emr11809163wro.34.1678268471894;
        Wed, 08 Mar 2023 01:41:11 -0800 (PST)
Received: from ?IPV6:2003:cb:c71b:cb00:d372:1da8:9e9e:422d? (p200300cbc71bcb00d3721da89e9e422d.dip0.t-ipconnect.de. [2003:cb:c71b:cb00:d372:1da8:9e9e:422d])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4407000000b002c5503a8d21sm15012364wrq.70.2023.03.08.01.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 01:41:11 -0800 (PST)
Message-ID: <d6670aa7-37ee-85aa-1053-96284a2f6720@redhat.com>
Date:   Wed, 8 Mar 2023 10:41:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Pengfei Xu <pengfei.xu@intel.com>,
        syzbot+2ee18845e89ae76342c5@syzkaller.appspotmail.com,
        Matthew Wilcox <willy@infradead.org>, heng.su@intel.com,
        lkp@intel.com, Stable@vger.kernel.org
References: <20230307205951.2465275-1-Liam.Howlett@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/ksm: Fix race with ksm_exit() in VMA iteration
In-Reply-To: <20230307205951.2465275-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.23 21:59, Liam R. Howlett wrote:
> ksm_exit() may remove the mm from the ksm_scan between the unlocking of
> the ksm_mmlist and the start of the VMA iteration.  This results in the
> mmap_read_lock() not being taken and a report from lockdep that the mm
> isn't locked in the maple tree code.

I'm confused. The code does

mmap_read_lock(mm);
...
for_each_vma(vmi, vma) {
mmap_read_unlock(mm);

How can we not take the mmap_read_lock() ? Or am I staring at the wrong 
mmap_read_lock() ?

> 
> Fix the race by checking if this mm has been removed before iterating
> the VMAs. __ksm_exit() uses the mmap lock to synchronize the freeing of
> an mm, so it is safe to keep iterating over the VMAs when it is going to
> be freed.
> 
> This change will slow down the mm exit during the race condition, but
> will speed up the non-race scenarios iteration over the VMA list, which
> should be much more common.

Would leaving the existing check in help to just stop scanning faster in 
that case?

> 
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Link: https://lore.kernel.org/lkml/ZAdUUhSbaa6fHS36@xpf.sh.intel.com/
> Reported-by: syzbot+2ee18845e89ae76342c5@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=64a3e95957cd3deab99df7cd7b5a9475af92c93e
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: heng.su@intel.com
> Cc: lkp@intel.com
> Cc: <Stable@vger.kernel.org>
> Fixes: a5f18ba07276 ("mm/ksm: use vma iterators instead of vma linked list")
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>   mm/ksm.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 525c3306e78b..723ddbe6ea97 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -1044,9 +1044,10 @@ static int unmerge_and_remove_all_rmap_items(void)
>   
>   		mm = mm_slot->slot.mm;
>   		mmap_read_lock(mm);

Better add a comment:

/*
  * Don't iterate any VMAs if we might be racing against ksm_exit(),
  * just exit early.
  */

> +		if (ksm_test_exit(mm))
> +			goto mm_exiting;
> +
>   		for_each_vma(vmi, vma) {
> -			if (ksm_test_exit(mm))
> -				break;
>   			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
>   				continue;
>   			err = unmerge_ksm_pages(vma,
> @@ -1055,6 +1056,7 @@ static int unmerge_and_remove_all_rmap_items(void)
>   				goto error;
>   		}
>   
> +mm_exiting:
>   		remove_trailing_rmap_items(&mm_slot->rmap_list);
>   		mmap_read_unlock(mm);
>   



-- 
Thanks,

David / dhildenb

