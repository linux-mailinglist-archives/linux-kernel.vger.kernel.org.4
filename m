Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D7C72249E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjFELcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjFELcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:32:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB5CE5C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685964634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aSrwlwKsLDC/XZ8F+PVpqJf/W8s73iDP0Ab8rtITi0o=;
        b=jQYYGu7H827FnLDjY/IxwdxeJtZHukYIwoRcaZFAVuq8VRqvqlScmDD9Ab6z3lz7E53HU3
        +wyGHQRHELhan8uZO9zRIx4mvcqGZ6d7yHu94J9iFEIHaBQT/rLPFx+5sK93yt4Ea/g89l
        4kCn8JFi0jQVE488R90X0XAOjBSY4Dw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-PK5pATV6N-S9Yv3Llbx_nw-1; Mon, 05 Jun 2023 07:30:32 -0400
X-MC-Unique: PK5pATV6N-S9Yv3Llbx_nw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30af779d6e6so2204531f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 04:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685964632; x=1688556632;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aSrwlwKsLDC/XZ8F+PVpqJf/W8s73iDP0Ab8rtITi0o=;
        b=lUuH5fQbqSTiag9NvuO/cVb0wqiXtrk6Z/fQdRuPsLjSzb5r2wi5R7lwHR7jEUIv0v
         TqR/Ts5avf5ZpJoV8AzCWz338AOaUhxpOdcOOS2ZkqF6IHXZ/JtJsB5LyiXMbHUp/jkG
         uQCNZY8OE3rp7q2HM0Ys3SxlUuOUUWSuE8k1CLXenpqanMI4m8u5HEDpMrg5QmP+1PV6
         ZAWpp5U+5KZyabIK45cdaY4/rhW2HxENOuVOD4Rqd/DBL7dokW9mjWWKf36pdeJBUGiO
         T8v9C03UmQgmhBbw+WdjGzPyULgH++AaEfs+H5zP0XquBooso2Zt6kiNzK4a7/yogsMI
         Yeog==
X-Gm-Message-State: AC+VfDyqKNE51eRjDH52rh6EP4zPKgNqUHWzbHkfWtkMyflK/Uwni32R
        7l8K+Pc6y/8R7IOiD5WrAmZNTxBytZP5TFzH3xVs7lRILDRniXYAUuDRK/FJokNb9CMZKH8Ek6o
        hrvIpN1zUruS9DzXQ6tj0uss2
X-Received: by 2002:adf:d842:0:b0:306:43ad:b34e with SMTP id k2-20020adfd842000000b0030643adb34emr4607386wrl.18.1685964631769;
        Mon, 05 Jun 2023 04:30:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5aqLSQD553jBwXqrTh2NPsOrImkqbomv48/y0ceaMg9+sON63/TtOMkwFylzyfm02ix27oGA==
X-Received: by 2002:adf:d842:0:b0:306:43ad:b34e with SMTP id k2-20020adfd842000000b0030643adb34emr4607368wrl.18.1685964631458;
        Mon, 05 Jun 2023 04:30:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:8f00:ed9:16b8:4e22:5820? (p200300cbc7378f000ed916b84e225820.dip0.t-ipconnect.de. [2003:cb:c737:8f00:ed9:16b8:4e22:5820])
        by smtp.gmail.com with ESMTPSA id z12-20020a5d4d0c000000b003068f5cca8csm9504025wrt.94.2023.06.05.04.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 04:30:31 -0700 (PDT)
Message-ID: <ab065504-59da-2ec8-a333-3ad7f999d727@redhat.com>
Date:   Mon, 5 Jun 2023 13:30:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mm: remove obsolete alloc_migrate_target()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230603142513.787000-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230603142513.787000-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.06.23 16:25, Miaohe Lin wrote:
> There's only declaration left in the header file. Remove it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   include/linux/page-isolation.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
> index 0ab089e89db4..4ac34392823a 100644
> --- a/include/linux/page-isolation.h
> +++ b/include/linux/page-isolation.h
> @@ -45,7 +45,4 @@ void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>   
>   int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
>   			int isol_flags);
> -
> -struct page *alloc_migrate_target(struct page *page, unsigned long private);
> -
>   #endif

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

