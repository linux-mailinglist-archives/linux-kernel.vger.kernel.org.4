Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A530B70EF28
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239737AbjEXHPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239522AbjEXHOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:14:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90712116
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684912227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c7W4kKUrKww3i4YHP5BikZBW/DFzxyE6jRqcfs4KX3M=;
        b=jTk4ljsNaUdgi7B5BaNoPH3k4Q6fwCwfDUCM3lFNU/u8RaNkdp5nPwcv3AomAmpZKuego1
        tdH7gDsol0B916kiRcxfqiTwHyY7fOJDgyF1SnHiQHjF9FIJtq8TAF1cvb8HSKkK2LP4oo
        pVC1NLsdP1nxEcu6lau4rZJs9RnmsTY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-pAfFNmbPMJSiLO47lzMKlQ-1; Wed, 24 May 2023 03:10:25 -0400
X-MC-Unique: pAfFNmbPMJSiLO47lzMKlQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-307814dd87eso181330f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684912224; x=1687504224;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7W4kKUrKww3i4YHP5BikZBW/DFzxyE6jRqcfs4KX3M=;
        b=JxebUOpTDd7y5uRRL8WXXUo7Gkolf2sD0UIL4W5TelyXe36odftOPFVxAtfcisHKdS
         TOMDTlJTM+yaFZ9eT7ZCBqtRCBjuf9zN8ZQSs7gc7F1FgNucGnboMCNV6l4vEJ5iJF8i
         tsKSy77KuSdxrpKdg1SG/mXcELRg1w1x7Ff+jZH5LKh6L4VpEgAeYGsfamaDHrHl85yP
         stFx5E42i8dGsXZ2lMseiZMN18iH1sJy6XUsvR6dzlKTD2RP3ymP1aWkD7IY8dCK3HoO
         P5rNBmG9OyHzqfnuoqFERkU4OzIeAm+VEa1CdBDH0O5R4Z9GhabMAXAapGEefP8noRDk
         ctlg==
X-Gm-Message-State: AC+VfDxJUALMjTHkggRcfyWIT7PAjvKdbu4vSzotMWNNmVQiRNTo2eOH
        E7Z0QdWYRfcNlR2tlU1WYXITmxZJO7mUCnuRhGgzaz7UI4Aoqwn4cXdwodMltImR9V1lNn99rc/
        Owj1SS7C7o7et2qCC81qZKn/Q
X-Received: by 2002:adf:db4c:0:b0:306:3bf0:f1ec with SMTP id f12-20020adfdb4c000000b003063bf0f1ecmr12454469wrj.7.1684912224454;
        Wed, 24 May 2023 00:10:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7MEbvztYm5p7SZb/6thbPR2FN9FGcCKVe2wtzf/n5zm+kqEHKNziQMBQjoUxZvVTrGYehjLw==
X-Received: by 2002:adf:db4c:0:b0:306:3bf0:f1ec with SMTP id f12-20020adfdb4c000000b003063bf0f1ecmr12454445wrj.7.1684912224064;
        Wed, 24 May 2023 00:10:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:f700:24cd:855:1c60:1ff4? (p200300cbc70df70024cd08551c601ff4.dip0.t-ipconnect.de. [2003:cb:c70d:f700:24cd:855:1c60:1ff4])
        by smtp.gmail.com with ESMTPSA id m13-20020adfe94d000000b002fda1b12a0bsm13620683wrn.2.2023.05.24.00.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 00:10:23 -0700 (PDT)
Message-ID: <d2bbd95c-ccb2-b4db-7c1c-a3b344b1a125@redhat.com>
Date:   Wed, 24 May 2023 09:10:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v9 1/5] ksm: support unsharing KSM-placed zero pages
Content-Language: en-US
To:     Yang Yang <yang.yang29@zte.com.cn>, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, jiang.xuexin@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn
References: <202305241351365661923@zte.com.cn>
 <20230524055711.20387-1-yang.yang29@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230524055711.20387-1-yang.yang29@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.05.23 07:57, Yang Yang wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> When use_zero_pages of ksm is enabled, madvise(addr, len, MADV_UNMERGEABLE)
> and other ways (like write 2 to /sys/kernel/mm/ksm/run) to trigger
> unsharing will *not* actually unshare the shared zeropage as placed by KSM
> (which is against the MADV_UNMERGEABLE documentation). As these KSM-placed
> zero pages are out of the control of KSM, the related counts of ksm pages
> don't expose how many zero pages are placed by KSM (these special zero
> pages are different from those initially mapped zero pages, because the
> zero pages mapped to MADV_UNMERGEABLE areas are expected to be a complete
> and unshared page).
> 
> To not blindly unshare all shared zero_pages in applicable VMAs, the patch
> use pte_mkdirty (related with architecture) to mark KSM-placed zero pages.
> Thus, MADV_UNMERGEABLE will only unshare those KSM-placed zero pages.
> 
> In addition, we'll reuse this mechanism to reliably identify KSM-placed
> ZeroPages to properly account for them (e.g., calculating the KSM profit
> that includes zeropages) in the latter patches.
> 
> The patch will not degrade the performance of use_zero_pages as it doesn't
> change the way of merging empty pages in use_zero_pages's feature.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
>   include/linux/ksm.h |  8 ++++++++
>   mm/ksm.c            | 11 ++++++++---
>   2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> index 899a314bc487..4fd5f4a50bac 100644
> --- a/include/linux/ksm.h
> +++ b/include/linux/ksm.h
> @@ -26,6 +26,12 @@ int ksm_disable(struct mm_struct *mm);
>   
>   int __ksm_enter(struct mm_struct *mm);
>   void __ksm_exit(struct mm_struct *mm);
> +/*
> + * To identify zeropages that were mapped by KSM, we reuse the dirty bit
> + * in the PTE. If the PTE is dirty, the zeropage was mapped by KSM when
> + * deduplicating memory.
> + */
> +#define is_ksm_zero_pte(pte)	(is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte))
>   
>   static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>   {
> @@ -95,6 +101,8 @@ static inline void ksm_exit(struct mm_struct *mm)
>   {
>   }
>   
> +#define is_ksm_zero_pte(pte)	0
> +

Not required in this patch (and AFAIKS in the others). So you can drop that.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

