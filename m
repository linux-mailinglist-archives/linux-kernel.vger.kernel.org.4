Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53086F42D6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 13:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbjEBLbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 07:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjEBLay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 07:30:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1469761BF
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 04:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683026959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d6aVfBAvC6NPqJutohdZRgZHqJFIUz73CuJW91t7YXY=;
        b=aIFck+VJjz3PX2aZZvkJ907Ee+NAQ9QOQ+UPuX+2LyngSz4uXZhoN2bk0G4ncCwYZT7GrO
        EAp3fY2JqUNnlvpLAEfDgBKPnFubMcozyjzZw03TxEWAQcMD/IkCu3vGRnAJNczQDVTg1C
        ziZHnCEVj80grd/Mv0phZ429fnw90gg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-kQvKpZMqMFixecXc4IKvWw-1; Tue, 02 May 2023 07:29:18 -0400
X-MC-Unique: kQvKpZMqMFixecXc4IKvWw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3063287f1c9so472777f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 04:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683026957; x=1685618957;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6aVfBAvC6NPqJutohdZRgZHqJFIUz73CuJW91t7YXY=;
        b=i1PLTP9HpPfNbPwvjDIPEVFr+WPN2UM5MrNlhGNT30/hoah9QGKxBPAhMWIKJJpG67
         iBv0vJBWrfz9+ec8kgCcCPQiz4TlntTBWCIOxdWmbZzWdDx5b8+nAtbMC2Jv6rDeGCjK
         9OebbT2vW2WWrCcXGF6mySkhOeBstTHQFoEDiifF4390q/3+4SJfHGtF5GVH53Gc4nE5
         WgvRuIfTvGqFQdzJ+fkNKaBE6a2NTILZxjQoSE3XPW1td9hnd/hbBOlQEfh3JOEWjGkM
         uCwFi/q9y9TRvRHFSOVoC5zcN87DWg/mikpk6kb/YzodXySI9+mbJAZRpKhpXti89FAr
         A6bg==
X-Gm-Message-State: AC+VfDxHPwO0UEQlqJ9Hkb5g/VE4UVyXP+geVf+A5xGj7JceiY2OE5I6
        95RzukJBz3bydCOPRdQkdAGm5OXlH9/R2xDFn0DfDJr3BUuf2VY2hVW1HYbcLy+My+l9jfQ++Gq
        P4TcxIxyKwkRlQLlM5qdIzMuZ
X-Received: by 2002:adf:fc06:0:b0:2f6:c5bd:ba13 with SMTP id i6-20020adffc06000000b002f6c5bdba13mr11674101wrr.42.1683026956946;
        Tue, 02 May 2023 04:29:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6bEO/bFsCBL4jjeOERe16Ibe/XR3jODjkuD+y3N9E8JZP4WIpgsT8/4D+NHBTnn88co0L8Bg==
X-Received: by 2002:adf:fc06:0:b0:2f6:c5bd:ba13 with SMTP id i6-20020adffc06000000b002f6c5bdba13mr11674084wrr.42.1683026956636;
        Tue, 02 May 2023 04:29:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:2400:6b79:2aa:9602:7016? (p200300cbc70024006b7902aa96027016.dip0.t-ipconnect.de. [2003:cb:c700:2400:6b79:2aa:9602:7016])
        by smtp.gmail.com with ESMTPSA id c10-20020adffb0a000000b00306344eaebfsm2359522wrr.28.2023.05.02.04.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 04:29:16 -0700 (PDT)
Message-ID: <06301913-9289-6654-5851-16cf8066c6b4@redhat.com>
Date:   Tue, 2 May 2023 13:29:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mm/mmap/vma_merge: always check invariants
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <df548a6ae3fa135eec3b446eb3dae8eb4227da97.1682885809.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <df548a6ae3fa135eec3b446eb3dae8eb4227da97.1682885809.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.04.23 22:19, Lorenzo Stoakes wrote:
> We may still have inconsistent input parameters even if we choose not to
> merge and the vma_merge() invariant checks are useful for checking this
> with no production runtime cost (these are only relevant when
> CONFIG_DEBUG_VM is specified).
> 
> Therefore, perform these checks regardless of whether we merge.
> 
> This is relevant, as a recent issue (addressed in commit "mm/mempolicy:
> Correctly update prev when policy is equal on mbind") in the mbind logic
> was only picked up in the 6.2.y stable branch where these assertions are
> performed prior to determining mergeability.
> 
> Had this remained the same in mainline this issue may have been picked up
> faster, so moving forward let's always check them.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>   mm/mmap.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 5522130ae606..13678edaa22c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -960,17 +960,17 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>   		merge_next = true;
>   	}
>   
> +	/* Verify some invariant that must be enforced by the caller. */
> +	VM_WARN_ON(prev && addr <= prev->vm_start);
> +	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
> +	VM_WARN_ON(addr >= end);
> +
>   	if (!merge_prev && !merge_next)
>   		return NULL; /* Not mergeable. */
>   
>   	res = vma = prev;
>   	remove = remove2 = adjust = NULL;
>   
> -	/* Verify some invariant that must be enforced by the caller. */
> -	VM_WARN_ON(prev && addr <= prev->vm_start);
> -	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
> -	VM_WARN_ON(addr >= end);
> -
>   	/* Can we merge both the predecessor and the successor? */
>   	if (merge_prev && merge_next &&
>   	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

