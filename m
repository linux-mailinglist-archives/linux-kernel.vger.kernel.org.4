Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35880671FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjAROl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjAROkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:40:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C383669B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674052222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ATCg+L6zRopjEX6LUab1/FACjMsZIJLBQDIkLO38aUE=;
        b=DDwZT+ad35kwF/QKXq5f9/Zze3iUIKfPiwJOzd1fk1cL1cFhFiYFv0wnQ5mZ5r34zpmnBr
        d5lXtN73l4Qylnq5b878IW88lPwXnJD4N5X/ttrClansYSdh+uaPx6KZAGnLR2jahv0bz1
        osy1LOXJzhK6izGSZ0lqiLZ7F8P/AtE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-322-KA6UnrZ9MsCtbm_PxiRLkA-1; Wed, 18 Jan 2023 09:30:21 -0500
X-MC-Unique: KA6UnrZ9MsCtbm_PxiRLkA-1
Received: by mail-wr1-f72.google.com with SMTP id m12-20020adfa3cc000000b002b881cb0cb4so6900324wrb.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:30:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ATCg+L6zRopjEX6LUab1/FACjMsZIJLBQDIkLO38aUE=;
        b=KNX3xoAe4pOAEgnmyKGnGQYvvWLQfOlp4Hlnv4IO2XByEoz0YSRK65h6/xQJiyN2n+
         xNjjJ4W2TqFMRe5BzE8kVPVbiiktzxiDqfZLfT+hczkgTltfluoZqdNNnZPyK4JRM3fb
         qCmkNzJpovEURUwfsKEGvUstwSDyNLzVT5/WY+TzFfie00ylsdCTjayGGmZgV0HY+P1o
         cX5frO1Y1pOIeODZOH+EFXdvha8Tt8Pq/F+fTjWuZhrVpwZ9iFJxyiN0Gz/rpypQunQB
         SEIFEzwbepfG1Z/WFX7x/Qmdf2ZspLsYRk4jQbI77kIGhMlZRNHN3LcpaClNxVFRa8kA
         8ApQ==
X-Gm-Message-State: AFqh2kqzF2EIc1xa0COiTv/vs8/h/tH6uwdxf81nelcgl79lFJ4dpPBE
        E2iARsgi5cUqwWJaNXJhTapu1zk/1URBOlY3rB0WFdmEKNRU8ajIot6CdMFy9+BYo/YdBibVZq8
        MbnIwUvF5/knKaZyz43fpOP1v
X-Received: by 2002:a05:600c:4256:b0:3da:2a78:d7a3 with SMTP id r22-20020a05600c425600b003da2a78d7a3mr6694797wmm.33.1674052220155;
        Wed, 18 Jan 2023 06:30:20 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvaEDQVQrq5HLpu2PxnTSuh82aIZTg6hKaP3xJa1tSsUxEC5aAwuEmteA1uHokqQeysawEfcg==
X-Received: by 2002:a05:600c:4256:b0:3da:2a78:d7a3 with SMTP id r22-20020a05600c425600b003da2a78d7a3mr6694772wmm.33.1674052219877;
        Wed, 18 Jan 2023 06:30:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:800:1a88:f98a:d223:c454? (p200300cbc70508001a88f98ad223c454.dip0.t-ipconnect.de. [2003:cb:c705:800:1a88:f98a:d223:c454])
        by smtp.gmail.com with ESMTPSA id e7-20020a056000120700b00241dd5de644sm31418655wrx.97.2023.01.18.06.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 06:30:19 -0800 (PST)
Message-ID: <305a756b-b977-8d08-fd7c-d41ec5dfe5d1@redhat.com>
Date:   Wed, 18 Jan 2023 15:30:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 3/6] ksm: count all zero pages placed by KSM
Content-Language: en-US
To:     yang.yang29@zte.com.cn, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, jiang.xuexin@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn
References: <202212300915147801864@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <202212300915147801864@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.12.22 02:15, yang.yang29@zte.com.cn wrote:
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
> So we add zero_pages_sharing under /sys/kernel/mm/ksm/ to show the number
> of all zero pages placed by KSM.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
> 
>   v4->v5:
>   fix warning  mm/ksm.c:3238:9: warning: no previous prototype for
>   'zero_pages_sharing_show' [-Wmissing-prototypes].
> ---
>   mm/ksm.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 652c088f9786..72c0722be280 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -276,6 +276,9 @@ static unsigned int zero_checksum __read_mostly;
>   /* Whether to merge empty (zeroed) pages with actual zero pages */
>   static bool ksm_use_zero_pages __read_mostly;
> 
> +/* The number of zero pages placed by KSM use_zero_pages */
> +static unsigned long ksm_zero_pages_sharing;

Does this count how many zero pages are currently placed or how many 
rmap items with ZERO_PAGE_FLAG are in the system?

IOW, if someone triggers MADV_DONTNEED on such a zeropage, the counter 
will not get updated, correct?


-- 
Thanks,

David / dhildenb

