Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8AA5EAB94
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbiIZPsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbiIZPsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D9810544
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664202845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+FbxJJgt3y17YKBT0+Ib2+k/YUWasKnHCMtA7UgjaQ=;
        b=GTahia8F+0bedS8o68bZCbqLHXlAn9K7E8r45kaYu1K93g9PU0TWIeYw077zs9Ne+Ce5ly
        W49k2aDrqFU56ZUpvD42/NjkLa2I0jFT9WKPcvuvlLBjw8i6tedkVy3NC8FOUasJf6lgYk
        117BvTN/uYCVgQCsgmOPkQGISHEJ+Zo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-294-f9AowDpvPJquAOWlXHumuA-1; Mon, 26 Sep 2022 10:34:03 -0400
X-MC-Unique: f9AowDpvPJquAOWlXHumuA-1
Received: by mail-wr1-f71.google.com with SMTP id e18-20020adfa452000000b00228a420c389so1238882wra.16
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=a+FbxJJgt3y17YKBT0+Ib2+k/YUWasKnHCMtA7UgjaQ=;
        b=cJEaF5Mmcm2HJVz0uhi136tzYN5eyBH54d+utecJGEfJMZSSkXiyvUBP1nAL5wvMYd
         FdlzoNzLGDo4VdtTHAgXSXPahsZ4fNWACoC15rkGuELstUznCraHqgdZ/xZryKYxQQ6z
         O//igcyvww0FYQDbEbm36sdf7wymcVN1/XnUwTrWvMYp95tGpHc+kLNbUtVshHZJcMeR
         rlQ6Zj8Qjtb0eR864QczAAPJjy66JCRK1ZkW/WgfOBAop4Hd02WG1XoBazdUlxfXCT5I
         BSdYlUid51Iz3q8qVIF2DA5QldFBsg5lokRqFte6PStTdi47/09Vg1oBPLhhnBQydXC1
         bb+A==
X-Gm-Message-State: ACrzQf1xhqBtMkiu93wXNTb28NLwHtahWMAhSTUAwWAlzAjMdSngU+9E
        EmZwFIlvV3BpgjIilh8xBjTWiYcPw4ZVO609bD9GobWN1K8hLW0b/PTWmDzQrJa9cC/uy4KvWwt
        EyCL309RUsT+AACdz1AL1NP3A
X-Received: by 2002:a5d:6dad:0:b0:22a:ec41:309c with SMTP id u13-20020a5d6dad000000b0022aec41309cmr13255072wrs.127.1664202842602;
        Mon, 26 Sep 2022 07:34:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM47qXl6c/bnzvFCKghYBKa/lZpTTAD7Qpzyx1A9Yjx7yK6jVwg6jBbBDTDTkeIxiqZnZnvovA==
X-Received: by 2002:a5d:6dad:0:b0:22a:ec41:309c with SMTP id u13-20020a5d6dad000000b0022aec41309cmr13255050wrs.127.1664202842258;
        Mon, 26 Sep 2022 07:34:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:4b00:e090:7fa6:b7d6:d4a7? (p200300cbc7034b00e0907fa6b7d6d4a7.dip0.t-ipconnect.de. [2003:cb:c703:4b00:e090:7fa6:b7d6:d4a7])
        by smtp.gmail.com with ESMTPSA id s6-20020adfdb06000000b0022ae4f8395dsm14423463wri.96.2022.09.26.07.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 07:34:01 -0700 (PDT)
Message-ID: <b5823e18-6139-c16e-a2df-1aa3e88927fa@redhat.com>
Date:   Mon, 26 Sep 2022 16:34:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2] mm: use update_mmu_tlb() on the second thread
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        muchun.song@linux.dev
Cc:     chris@zankel.net, jcmvbkbc@gmail.com, maobibo@loongson.cn,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Bibo Mao <maobibo@loongson.cn>
References: <20220926115621.13849-1-zhengqi.arch@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220926115621.13849-1-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.09.22 13:56, Qi Zheng wrote:
> As message in commit 7df676974359 ("mm/memory.c: Update local TLB
> if PTE entry exists") said, we should update local TLB only on the
> second thread. So in the do_anonymous_page() here, we should use
> update_mmu_tlb() instead of update_mmu_cache() on the second thread.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
> v1: https://lore.kernel.org/lkml/20220924053239.91661-1-zhengqi.arch@bytedance.com/
> 
> Changelog in v1 -> v2:
>   - change the subject and commit message (David)
> 
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


Staring at 7df676974359, it indeed looks like an accidental use [nothing 
else in that patch uses update_mmu_cache].

So it looks good to me, but a confirmation from Bibo Mao might be good.

-- 
Thanks,

David / dhildenb

