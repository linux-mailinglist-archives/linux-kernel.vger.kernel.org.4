Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569F570945D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjESKCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjESKCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:02:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2AA9C
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684490486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VI5tgplCEt4jHAaMyiKalfapGPWMDCQqKZuSohEz4I8=;
        b=Eo7ucxjJ4tfxCxIPEEz4t4tsX1UaymPPSo0X7E9BhzZG4guufEtZjTsxOhcggaW0LtdkYn
        wbWuUkitvg6mhLtIhpU6sq4Tjwr2Rw4AuzQ0n+xxVaDZdM9z/2kkHI5fUXDb5YCeU364GH
        wFyLyf/SQ0R/CUzmpA1ZsyWG7i/tGPQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-YuaYiAncNeiBrx4FNJ0rpQ-1; Fri, 19 May 2023 06:01:24 -0400
X-MC-Unique: YuaYiAncNeiBrx4FNJ0rpQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3063287f1c9so1363809f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684490483; x=1687082483;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VI5tgplCEt4jHAaMyiKalfapGPWMDCQqKZuSohEz4I8=;
        b=VwSc/te+4y6fB1HjXQpmq7ebUaToHcJpME0zzlXTNy+qPIbSRfHvMT6YA+EVsP+9jP
         zqMMd5djrKWP6qzRCveF6A9ADeUUN1eLSn3TV6HNStBIdyor3zDijDI/Vpb2Ty55IWFG
         ZJyzKeC74e5qHzXULM7nQSFJOkL+9SaPi5Uc6rvBm47nlI5kEmPocYr00PTWtktrQC2e
         XUPH1xfAiwrNR5cdhDJpmuxPXEuU349PI06bYJ8fjjYPcBN0xxsm0i9xgA/1PSdUII/n
         5vcDVvibrJQqt0Guya80E8VM04RXmu9qfY/0Pb3WglrDUj8k8lsThl6MvVxCjGM04Ifu
         DGqg==
X-Gm-Message-State: AC+VfDxFZQmEw59yc/n6F2HaMhaGWwqptd8BXV9kHa9A4/62CjV4Hpu2
        G2hD83Oi/rkQWYwWgYedKTPK1KMzkjZtLwIzcOKrVA1OlYKMXpy3zt87TbPVzZlYRBbxPSArowX
        NhYTfw9E2BZMxVzOd0qZsXMYu
X-Received: by 2002:a5d:4b43:0:b0:309:5068:9ebe with SMTP id w3-20020a5d4b43000000b0030950689ebemr1226775wrs.50.1684490483439;
        Fri, 19 May 2023 03:01:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6bW0gym5bX5jcXG9w5DVs/9Wlup2M96haNB0vR03K3c+zLetIbvoA2UiOPc9NtNRwR6l97Vg==
X-Received: by 2002:a5d:4b43:0:b0:309:5068:9ebe with SMTP id w3-20020a5d4b43000000b0030950689ebemr1226745wrs.50.1684490482941;
        Fri, 19 May 2023 03:01:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c722:9d00:7421:54d8:9227:a3e8? (p200300cbc7229d00742154d89227a3e8.dip0.t-ipconnect.de. [2003:cb:c722:9d00:7421:54d8:9227:a3e8])
        by smtp.gmail.com with ESMTPSA id k13-20020a5d518d000000b00306344eaebfsm4801755wrv.28.2023.05.19.03.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 03:01:22 -0700 (PDT)
Message-ID: <83a846a9-8f88-3f66-b840-e84d072bb0fb@redhat.com>
Date:   Fri, 19 May 2023 12:01:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     =?UTF-8?B?WGlhb21pbmcgRGluZyAo5LiB5pmT5piOKQ==?= 
        <Xiaoming.Ding@mediatek.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>
Cc:     =?UTF-8?B?RmVpIFh1ICjlvpDpo54p?= <Fei.Xu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>,
        "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
References: <20230517031856.19660-1-xiaoming.ding@mediatek.com>
 <ZGSDoVKKVqCkbaCB@infradead.org>
 <CAFA6WYO+AvnbuAdWyBAQ8HkLaOno7PXdsPb9SubxrGNvAm4UnQ@mail.gmail.com>
 <ZGSLiiK/JzD5KMd7@infradead.org>
 <CAFA6WYPOMwmrA3J84AHzoD2eAtNkpMxr754qHpc-j6XRkgFFvQ@mail.gmail.com>
 <ZGSgCZrg+RjAbGO1@infradead.org>
 <CAFA6WYO+EpiECFxdVgmd-Ey9jq1Ybt78WupK_bW5+oDcW-soVQ@mail.gmail.com>
 <781d993204fbbdf30a6ca495b59b3b0aa7a2e496.camel@mediatek.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] tee: add FOLL_LONGTERM for CMA case when alloc shm
In-Reply-To: <781d993204fbbdf30a6ca495b59b3b0aa7a2e496.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.05.23 08:40, Xiaoming Ding (丁晓明) wrote:
>  From 35fd062d5cbc4d182eee0183843cd6350d126788 Mon Sep 17 00:00:00 2001
> From: Xiaoming Ding <xiaoming.ding@mediatek.com>
> Date: Wed, 10 May 2023 10:15:23 +0800
> Subject: [PATCH v2] tee: add FOLL_LONGTERM for CMA case when alloc shm
> 
> CMA is widely used on insufficient memory platform for
> secure media playback case, and FOLL_LONGTERM will
> avoid tee_shm alloc pages from CMA region.
> without FOLL_LONGTERM, CMA region may alloc failed since
> tee_shm has a chance to use it in advance.
> 
> modify is verified on OPTEE XTEST and kinds of secure + clear playback
> 
> 
> Fixes: 033ddf12bcf5 ("tee: add register user memory")
> Signed-off-by: Xiaoming Ding <xiaoming.ding@mediatek.com>
> ---
> v1 -> v2: take off the ifdef and apply FOLL_LONGTERM by default
> 
>   drivers/tee/tee_shm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 673cf0359494..38878e549ca4 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -257,7 +257,7 @@ register_shm_helper(struct tee_context *ctx,
> unsigned long addr,
>   	}
>   
>   	if (flags & TEE_SHM_USER_MAPPED)
> -		rc = pin_user_pages_fast(start, num_pages, FOLL_WRITE,
> +		rc = pin_user_pages_fast(start, num_pages, FOLL_WRITE |
> FOLL_LONGTERM,
>   					 shm->pages);
>   	else
>   		rc = shm_get_kernel_pages(start, num_pages, shm-
>> pages);

I didn't dive deeply into that code, but I can spot that we can end up 
long-term pinning multiple pages -- possibly unbound or is there any 
sane limit on the number of pages?

Take a look at io_uring/rsrc.c and how we account long-term pinned pages 
against user->locked_vm/ctx->mm_account->pinned_vm in io_account_mem().

If user space could only end up pinning one or two pages via that 
interface, ok. But it looks like this interface could be abused to 
create real real trouble by unprivileged users that should be able to 
long-term pin that many pages.

Am I missing something important (i.e., interface is only accessible by 
privileged users) or should there be proper accounting and 
RLIMIT_MEMLOCK checks?

-- 
Thanks,

David / dhildenb

