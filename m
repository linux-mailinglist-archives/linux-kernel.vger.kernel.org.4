Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5829A72BC02
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbjFLJXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbjFLJWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:22:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882DE4C28
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686561302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ddtqvQOlKG9g77NyVakbRMl+OTaGq4kB/lzy17Rd0KE=;
        b=JF2WKL3DYgQtFoBe1pFaBaGean0ZFfbwN29QlwmJ8HtkupMfbSyMhuodDLh9f4ZJ3RwlKO
        fGMhN5kG6DWJi2pzzZmS6q0AsPANEM80GoMEnocQVRDYRolwTCdQvEGWVhqlfFTDHmQj+0
        LR1nTlYTvPuAIa7nN9okK5ofnucHtbc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-eIuqGKscMVWbdJOTRbJADQ-1; Mon, 12 Jun 2023 05:15:01 -0400
X-MC-Unique: eIuqGKscMVWbdJOTRbJADQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f81bdf4716so2644295e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561300; x=1689153300;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddtqvQOlKG9g77NyVakbRMl+OTaGq4kB/lzy17Rd0KE=;
        b=PYWQX9dzNYrT57lBljBBKmy9FG9UUx3LQE8ykCxxY1XGnDlLkVtV2mX/fadsbeBigc
         yG+CJ7shKFOjXDLxbGzvzNH+/+/0h2gHQUOaldEki3bx7BOPo4ordV07+w/9xk6sb0ft
         tpVVmkAqwgAGWV98JKt3LZZgmWt1WsgFb7F56vzl+78b/0hmW2rWMIkqFRHmqu4s81zU
         NqcmyI+1RpX4bVPP9xOZWs1nJE3ncoNVzmMWKmG5+sv1KH1ZStxJib1P4roCS56IISMA
         HBCw1ak/P6qNx8twxkYsdW27E1d2wX+n48tKsFe6c89BbeHkd6oMkmggBFxetjsYDa7f
         kGuQ==
X-Gm-Message-State: AC+VfDxkYWmfREvXUGsoA9V0DNslwwN+d1oBAAUzR03zAm+H3H8IVgLk
        TxO1wZi4soqmTvCI/+Zn0JE40e3CQdXBzZ+h8QyTQ0rw907v4pTgCNG8prqsrzO7/qtVRSo7cqf
        7vd00Y0DNa891RNIsU5VhxAzI
X-Received: by 2002:a7b:c00d:0:b0:3f1:731e:cdb1 with SMTP id c13-20020a7bc00d000000b003f1731ecdb1mr7095433wmb.6.1686561300279;
        Mon, 12 Jun 2023 02:15:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4VWm5/FLy2C5UROjZAJjwvqbuVZiWP2Qi/rUUG+qsi/ggVP2kjNBG8UkEn0nJg4f50vHSOfQ==
X-Received: by 2002:a7b:c00d:0:b0:3f1:731e:cdb1 with SMTP id c13-20020a7bc00d000000b003f1731ecdb1mr7095419wmb.6.1686561299929;
        Mon, 12 Jun 2023 02:14:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e? (p200300cbc74e16004f6725b23e8c2a4e.dip0.t-ipconnect.de. [2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c204700b003f7a562ff31sm10779189wmg.6.2023.06.12.02.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 02:14:59 -0700 (PDT)
Message-ID: <ab62da22-e4f2-da99-bcb8-5238ee638c87@redhat.com>
Date:   Mon, 12 Jun 2023 11:14:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH -next] mm: Remove unused vma_init_lock()
Content-Language: en-US
To:     YueHaibing <yuehaibing@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230610101956.20592-1-yuehaibing@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230610101956.20592-1-yuehaibing@huawei.com>
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

On 10.06.23 12:19, YueHaibing wrote:
> commit c7f8f31c00d1 ("mm: separate vma->lock from vm_area_struct")
> left this behind.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   include/linux/mm.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0db09639dd2d..1970772c07bb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -725,7 +725,6 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>   
>   #else /* CONFIG_PER_VMA_LOCK */
>   
> -static inline void vma_init_lock(struct vm_area_struct *vma) {}
>   static inline bool vma_start_read(struct vm_area_struct *vma)
>   		{ return false; }
>   static inline void vma_end_read(struct vm_area_struct *vma) {}

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

