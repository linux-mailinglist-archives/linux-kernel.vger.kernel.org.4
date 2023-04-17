Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83CC6E4556
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjDQKfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjDQKfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:35:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1021A1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 03:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681727585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xfhFkFEXd/Fa/v20KkaXF/K4tKRiXQWpPAFsCwHLV14=;
        b=fShVyHmMsQWsG6oZY/gen6ivuG94+OOrNgyA9QkZSgRIQF7RUXml8JvlegVCLquhjynSmu
        uP6JbgHvEI3rOKKZqGRIcv1f9RXMGWRZVNi3eIDf3qFed/9LwZc1uhKETvlbSbUvXJQeUP
        ZgdVtNJty+XkOYjTRPBHz1G0Tn6XWng=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-8heKboPNP3y_8_-9YpdEjg-1; Mon, 17 Apr 2023 06:33:04 -0400
X-MC-Unique: 8heKboPNP3y_8_-9YpdEjg-1
Received: by mail-wm1-f72.google.com with SMTP id hg24-20020a05600c539800b003f066c0b044so16411717wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 03:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681727583; x=1684319583;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfhFkFEXd/Fa/v20KkaXF/K4tKRiXQWpPAFsCwHLV14=;
        b=dPj0eamiba8LG7Xr7XjYvurpYf9yMar9sAL8wMtMDp5WYbw2zZyPAhWB0xe6V6yFji
         si/NyKUCyQEXoNqJDmkYlyCPj7hjGLSmVxlSYChVV2ZGJGfpTPbu0DYnyHFf8X3R57Wo
         j2LPwJQyTD6BSVpboX0nC4EWIFK/hJKXdL8/Ap62aGlIKf58x53dli04o6qDtsNon8iI
         bms6ctfsSBo/oxz+GV7KOCLXVcrmYYEmMOdtka70s+n3Ecm7Ps1FdiZxOpBIw13GIqeu
         s6m27YsyG3hTSG3hzomXUIZj/nLJwTJRIHmpnQnMlMlHwIOEIaXkHkID3z6kmhExEqjh
         p9+A==
X-Gm-Message-State: AAQBX9cB3TTtRYyjDgZhXmwMKDzaKbdrNnuY1SVFfYb8B7BktxdM8EaA
        HkYq/uh+JP2brvLTJsxBWnktXIuzSxm5qnl2ZFZBH+B+iO4GwffR9JXYLCXP2xF51bMXvbOtcvn
        RrDzFOFZU2f3hvJtKYr+Zn6dKjvLs23wG
X-Received: by 2002:a1c:7503:0:b0:3f0:683d:224d with SMTP id o3-20020a1c7503000000b003f0683d224dmr10259143wmc.9.1681727583534;
        Mon, 17 Apr 2023 03:33:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350YlRgN48Ut0i+E/LSX71GzFA10WpzH2YXeQC4oarpyBOopbIwKkr0lyoQSMvsGjH2bHHX2PMQ==
X-Received: by 2002:a1c:7503:0:b0:3f0:683d:224d with SMTP id o3-20020a1c7503000000b003f0683d224dmr10259126wmc.9.1681727583198;
        Mon, 17 Apr 2023 03:33:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:db07:68a9:6af5:ecdf? (p200300cbc700fc00db0768a96af5ecdf.dip0.t-ipconnect.de. [2003:cb:c700:fc00:db07:68a9:6af5:ecdf])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c471500b003ef5bb63f13sm15221389wmo.10.2023.04.17.03.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 03:33:02 -0700 (PDT)
Message-ID: <e77ba42b-a2a4-5cdc-7038-287c28ef8cd7@redhat.com>
Date:   Mon, 17 Apr 2023 12:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] userfaultfd: use helper function range_in_vma()
Content-Language: en-US
To:     Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     mike.kravetz@oracle.com, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
References: <20230417003919.930515-1-zhangpeng362@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230417003919.930515-1-zhangpeng362@huawei.com>
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

On 17.04.23 02:39, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> We could use range_in_vma() to check if dst_start, dst_start + len are
> within the dst_vma range. Minor readability improvement.
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> ---
>   mm/userfaultfd.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 11cfd82c6726..e97a0b4889fc 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -31,11 +31,7 @@ struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
>   	struct vm_area_struct *dst_vma;
>   
>   	dst_vma = find_vma(dst_mm, dst_start);
> -	if (!dst_vma)
> -		return NULL;
> -
> -	if (dst_start < dst_vma->vm_start ||
> -	    dst_start + len > dst_vma->vm_end)
> +	if (!range_in_vma(dst_vma, dst_start, dst_start + len))
>   		return NULL;
>   
>   	/*

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

