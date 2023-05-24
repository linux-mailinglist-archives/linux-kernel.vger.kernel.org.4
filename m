Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959E970EF49
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbjEXHYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjEXHYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:24:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498E690
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684912998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QGVulM+7Dkm8yCOBQhzNwQ4gCPj3HR7YyVPPxi6Fqc8=;
        b=HMF9J2lAgE0M/J4kQsbHGEOVPHxJqiHzJeRBTJxyxvWNj9J4pRsOuAZL8jYghzt/OXvB5D
        BA9MhejUlI7dkdmqXsKbx0bAkkzXRJXhhbngF9xz2seJBourV8UD7dyVYkvVhlVALASarf
        ypkyFW50duMscPPdvuP8W3Ne9FlbSTk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395--Nmf_Ci3NGCuZw9JZdnvFg-1; Wed, 24 May 2023 03:23:15 -0400
X-MC-Unique: -Nmf_Ci3NGCuZw9JZdnvFg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30620ebd3c2so287026f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684912994; x=1687504994;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QGVulM+7Dkm8yCOBQhzNwQ4gCPj3HR7YyVPPxi6Fqc8=;
        b=AyzmigSvE7HGgeTTY8iYIhasZRTi5ncn3+Qhexa9l4MvftRSEMeS/g3xYVgdT7YOw/
         Wc56CH8U4+Kungnfq4obicU3WB9CSpLrtPWz7HRL1GFl4lKYR1HoB+lSgvvxKFDcNSDI
         HGFpZHH0lAe/0G+nfoAdlV+thScvq8HyXftsSkTagZU9L588wTZ5rTzJQK1saTdA60IZ
         xQ800skpArlInJLUq/L7tN8lLsPI0uvM7DIc4GCfb09uteBxxMMGCpD9lTttGlPCjOYs
         +fTDSAYenYaQyjG1TzjR4GuwfsWCNjDo16lYXLdTY/1nzLXZ5d8SebayJuzIhAM3ps0g
         vbhw==
X-Gm-Message-State: AC+VfDyVevxr/m6944jY7nUbiOlkzQCVwH9oyA8wBIJPrODHwjF4ZUtg
        IW4obsPW0FQb1dTc/igo4O0sUQ1W/cX+iXQt6tsmJqgdopMx52ZxUkUyGKbL4/WF/aO3wAz4Sew
        IxqOix0QyEkHeiraa4zgsLL0L
X-Received: by 2002:a5d:50d2:0:b0:2fa:36db:8060 with SMTP id f18-20020a5d50d2000000b002fa36db8060mr12095816wrt.60.1684912994599;
        Wed, 24 May 2023 00:23:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5JYlmtU36DomBA8uQD+JjqciUgm1OjppgMR3Vlzdb/MXvAvbZ4BAghFtZrgiMeC4eojaCbng==
X-Received: by 2002:a5d:50d2:0:b0:2fa:36db:8060 with SMTP id f18-20020a5d50d2000000b002fa36db8060mr12095797wrt.60.1684912994206;
        Wed, 24 May 2023 00:23:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:f700:24cd:855:1c60:1ff4? (p200300cbc70df70024cd08551c601ff4.dip0.t-ipconnect.de. [2003:cb:c70d:f700:24cd:855:1c60:1ff4])
        by smtp.gmail.com with ESMTPSA id k6-20020adfe8c6000000b003095a329e90sm13251545wrn.97.2023.05.24.00.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 00:23:13 -0700 (PDT)
Message-ID: <52bfd744-3086-a22a-e2e7-8b64d5fccfcc@redhat.com>
Date:   Wed, 24 May 2023 09:23:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Yang Yang <yang.yang29@zte.com.cn>, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, jiang.xuexin@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn
References: <202305241351365661923@zte.com.cn>
 <20230524055752.20449-1-yang.yang29@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v9 2/5] ksm: count all zero pages placed by KSM
In-Reply-To: <20230524055752.20449-1-yang.yang29@zte.com.cn>
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
> As pages_sharing and pages_shared don't include the number of zero pages
> merged by KSM, we cannot know how many pages are zero pages placed by KSM
> when enabling use_zero_pages, which leads to KSM not being transparent with
> all actual merged pages by KSM. In the early days of use_zero_pages,
> zero-pages was unable to get unshared by the ways like MADV_UNMERGEABLE so
> it's hard to count how many times one of those zeropages was then unmerged.
> 
> But now, unsharing KSM-placed zero page accurately has been achieved, so we
> can easily count both how many times a page full of zeroes was merged with
> zero-page and how many times one of those pages was then unmerged. and so,
> it helps to estimate memory demands when each and every shared page could
> get unshared.
> 
> So we add ksm_zero_pages under /sys/kernel/mm/ksm/ to show the number
> of all zero pages placed by KSM. Meanwhile, we update the Documentation.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
>   Documentation/admin-guide/mm/ksm.rst |  7 +++++++
>   include/linux/ksm.h                  | 12 ++++++++++++
>   mm/khugepaged.c                      |  2 ++
>   mm/ksm.c                             | 12 ++++++++++++
>   mm/memory.c                          |  5 ++++-
>   5 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
> index 7626392fe82c..6cc919dbfd55 100644
> --- a/Documentation/admin-guide/mm/ksm.rst
> +++ b/Documentation/admin-guide/mm/ksm.rst
> @@ -173,6 +173,13 @@ stable_node_chains
>           the number of KSM pages that hit the ``max_page_sharing`` limit
>   stable_node_dups
>           number of duplicated KSM pages
> +ksm_zero_pages
> +        how many zero pages that are still mapped into processes were mapped by
> +        KSM when deduplicating.
> +
> +When ``use_zero_pages`` is/was enabled, the sum of ``pages_sharing`` +
> +``ksm_zero_pages`` represents the actual number of pages saved by KSM.
> +if ``use_zero_pages`` has never been enabled, ``ksm_zero_pages`` is 0.
>   
>   A high ratio of ``pages_sharing`` to ``pages_shared`` indicates good
>   sharing, but a high ratio of ``pages_unshared`` to ``pages_sharing``
> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> index 4fd5f4a50bac..f2d98c53cfec 100644
> --- a/include/linux/ksm.h
> +++ b/include/linux/ksm.h
> @@ -33,6 +33,14 @@ void __ksm_exit(struct mm_struct *mm);
>    */
>   #define is_ksm_zero_pte(pte)	(is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte))
>   
> +extern unsigned long ksm_zero_pages;
> +
> +static inline void ksm_notify_unmap_zero_page(pte_t pte)
> +{
> +	if (is_ksm_zero_pte(pte))
> +		ksm_zero_pages--;
> +}
> +
>   static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>   {
>   	int ret;
> @@ -103,6 +111,10 @@ static inline void ksm_exit(struct mm_struct *mm)
>   
>   #define is_ksm_zero_pte(pte)	0
>   
> +static inline void ksm_notify_unmap_zero_page(pte_t pte)
> +{
> +}
> +

Having proposed that name ... I realize that we call this function 
whenever there might be a zeropage mapped (when we have !page after 
vm_normal_page()) -- but it could also not be the zeropage.

Not really able to come up with a better name :)

ksm_notify_maybe_unmap_zero_page ?

ksm_maybe_unmap_zero_page ?


Maybe someone else reading along has a better idea. In any case, the 
logic itself LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

