Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364D55F0671
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiI3Iav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiI3Iar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:30:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C51BC910
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 01:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664526644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8CdgI6o1JPgGkTG2jpG4T+E2PTeCFnRXsC1gUO71n9I=;
        b=dD7fr+tJnkexZPMtfY4/LScqcl1+FoheTFb2vNRDCa5oiztBSLlpvaAhlq7rR0xt3NGB/i
        n7avFQBiHUZvX42Vrae+leBAJB99SyXR6rCx3eERgHQJlvKJvw9OCC1zSNTTYmKvMLk0zO
        R2mQNx//W+VxWbUSEUxFNdG61mGpZUc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-672-gVHviGZ8Pr6Z1SyuXWtUhQ-1; Fri, 30 Sep 2022 04:30:41 -0400
X-MC-Unique: gVHviGZ8Pr6Z1SyuXWtUhQ-1
Received: by mail-wr1-f72.google.com with SMTP id f9-20020adfc989000000b0022b3bbc7a7eso1311350wrh.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 01:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=8CdgI6o1JPgGkTG2jpG4T+E2PTeCFnRXsC1gUO71n9I=;
        b=SS+oskwDu4WHD5Nj0ugQl/e2rGATjcubXIjEIhiF1JB+B5GySCHzbJMa5Y5Cu1RcpI
         AZbV1su1kAVhia32Yz+3KZ5d9dgA9Ky6nxIsyuCIZ8BXNqMTXUu1AJ1jo2e/gcrk7Alo
         HQC/8m2pLu3WXC4abwGypx30Bk36cuy6syIrw63eLjicfzisLVSD7IVkSDEFnblkhuhW
         xXjHjSk3CZbZOj7sJCBvJKRNtkwZ/EPSJ2QpcteKnAOBHCMe6xTeWjj7zdo2Jtl8w4+m
         T47DW+ExBP10Iu7j7OZXcfCVPy+TB5De151YcVwfqfV/InReTnZcqbiCVMDkjLJJfZHG
         ZUzw==
X-Gm-Message-State: ACrzQf0izj09hiDHEt1iyPxXubTHQ9gmRf9WWvahTfOK/4Bf2X3HQUr3
        R92Yfxp5g7YMkjOxUQLzi0eFtdwy0FOwKQm9cf3eYtQLvZBCorATiMvMycJtoVCslBQyMHYmi+R
        he2vEdKUNOuGaBrxPUaW2wkn8
X-Received: by 2002:a05:600c:4606:b0:3b4:62b3:150b with SMTP id m6-20020a05600c460600b003b462b3150bmr5203342wmo.3.1664526640616;
        Fri, 30 Sep 2022 01:30:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4kmodJuSR/XONK5ttvI7YsCPMg21LO5DNNlzVaGbZhkWg+ApaqDuIWh4iZiTNEO8Ds1O8B1A==
X-Received: by 2002:a05:600c:4606:b0:3b4:62b3:150b with SMTP id m6-20020a05600c460600b003b462b3150bmr5203316wmo.3.1664526640331;
        Fri, 30 Sep 2022 01:30:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:c00:48b:b68a:f9e0:ebce? (p200300cbc70c0c00048bb68af9e0ebce.dip0.t-ipconnect.de. [2003:cb:c70c:c00:48b:b68a:f9e0:ebce])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c19cf00b003a2f2bb72d5sm8546677wmq.45.2022.09.30.01.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 01:30:39 -0700 (PDT)
Message-ID: <0fecbcdc-7324-2d76-8452-b60b4638d074@redhat.com>
Date:   Fri, 30 Sep 2022 10:30:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 1/2] mm: use update_mmu_tlb() on the second thread
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        maobibo@loongson.cn, chenhuacai@loongson.cn,
        songmuchun@bytedance.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        loongarch@lists.linux.dev, chris@zankel.net, jcmvbkbc@gmail.com
References: <20220929112318.32393-1-zhengqi.arch@bytedance.com>
 <20220929112318.32393-2-zhengqi.arch@bytedance.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220929112318.32393-2-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.22 13:23, Qi Zheng wrote:
> As message in commit 7df676974359 ("mm/memory.c: Update local TLB
> if PTE entry exists") said, we should update local TLB only on the
> second thread. So in the do_anonymous_page() here, we should use
> update_mmu_tlb() instead of update_mmu_cache() on the second thread.
> 

Maybe mention here "This only affects performance, but not correctness."

Acked-by: David Hildenbrand <david@redhat.com>

> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   mm/memory.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 118e5f023597..9e11c783ba0e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4122,7 +4122,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>   	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
>   			&vmf->ptl);
>   	if (!pte_none(*vmf->pte)) {
> -		update_mmu_cache(vma, vmf->address, vmf->pte);
> +		update_mmu_tlb(vma, vmf->address, vmf->pte);
>   		goto release;
>   	}
>   

-- 
Thanks,

David / dhildenb

