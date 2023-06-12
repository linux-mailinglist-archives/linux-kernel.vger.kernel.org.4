Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530A172BC63
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjFLJ3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjFLJ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:28:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDE749E1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686561727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jmiYL5ekUeYsbYDrWaIYmx1UrfmarTSRZzI2A2Eq1R4=;
        b=U1KPCiolCD/ZJ9XsuFwFN3uisY8a1Pbw7L091tl9HocvxfKXuZqoHI7Wm8wxMjUBQpLDP5
        RArq8JtEIyGD1KDYSPONjhDGsv/Or/nrqyspI/ppTNATT3n6xcX7qbD05iRIrhHU+HLPLt
        DKlSkfijP0fgL2N5ovMfkZhbcC3qau8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-weMTkgLzMS6YjZD8Fl7U5Q-1; Mon, 12 Jun 2023 05:22:05 -0400
X-MC-Unique: weMTkgLzMS6YjZD8Fl7U5Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f7e835ce65so17402135e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561724; x=1689153724;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmiYL5ekUeYsbYDrWaIYmx1UrfmarTSRZzI2A2Eq1R4=;
        b=W9D+N0Pu7/Qb34SXrv/AquWdvSj0OIgrM//lvkHPRn6A0eBgIJqWWdPwWMf28RTUoN
         x2WDAEnHbeTfJsIbpVTbp45lJ0Jr6VehxR0uWXNjgYp9UWtMDZIhbEbh+K6fUX4BVJen
         Dm3snHIfGFFnl2ftAmPD/6vFQdRNKPl6vwEadP04IyKVk3fo+kGQ4D/DMs7wtEHuxuud
         lRiueIwdb6TzeSTLNBtdRj8uOu3ZxCojiCQaaBIHs4lNGhTaEgIfOU/m30ukV9iWC+ys
         LpgRMCOCUK0ZNXzLQkMhUxQxKwEBQkSMp6IxHXEGDgt7t2U2sJ7i2XU/zICo/QFNyMjU
         aBoA==
X-Gm-Message-State: AC+VfDyZbfbvCiIUx+Bt3pJHLs0xCjB6Yf5jS2kkbWyXo8LiJwHnnZib
        d+2ndfHv9UDX4XhgaadZmHNXbGaRRtoN1XALDkGqf0CK/k0+75RineEdA5Mav3iWsIbiVV2dqkP
        KFz8sU8a0xvdSITvTUFP5ZqXL
X-Received: by 2002:adf:f84e:0:b0:30a:e66d:25b7 with SMTP id d14-20020adff84e000000b0030ae66d25b7mr3699347wrq.13.1686561724450;
        Mon, 12 Jun 2023 02:22:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4aSaKMrUoLClL2yCKclHi5IHBVSe5TPx0z3eq3RsU4ebM4GMlPhs7avKHXJFSTqWa8aRrulg==
X-Received: by 2002:adf:f84e:0:b0:30a:e66d:25b7 with SMTP id d14-20020adff84e000000b0030ae66d25b7mr3699326wrq.13.1686561724064;
        Mon, 12 Jun 2023 02:22:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e? (p200300cbc74e16004f6725b23e8c2a4e.dip0.t-ipconnect.de. [2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d5281000000b0030aded83385sm11909047wrv.27.2023.06.12.02.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 02:22:03 -0700 (PDT)
Message-ID: <7e2144b1-23f3-68ec-b4b1-f4ed9025b476@redhat.com>
Date:   Mon, 12 Jun 2023 11:22:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] mm/vmalloc: Replace the ternary conditional operator
 with min()
Content-Language: en-US
To:     Lu Hongfei <luhongfei@vivo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "open list:VMALLOC" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230609092602.26412-1-luhongfei@vivo.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230609092602.26412-1-luhongfei@vivo.com>
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

On 09.06.23 11:26, Lu Hongfei wrote:
> It would be better to replace the traditional ternary conditional
> operator with min() in zero_iter
> 
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>   mm/vmalloc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 29077d61ff81..6125ed506895
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3571,7 +3571,7 @@ static size_t zero_iter(struct iov_iter *iter, size_t count)
>   	while (remains > 0) {
>   		size_t num, copied;
>   
> -		num = remains < PAGE_SIZE ? remains : PAGE_SIZE;
> +		num = min_t(size_t, remains, PAGE_SIZE);
>   		copied = copy_page_to_iter_nofault(ZERO_PAGE(0), 0, num, iter);
>   		remains -= copied;
>   

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

