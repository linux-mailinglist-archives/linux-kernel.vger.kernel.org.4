Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117766E68BC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjDRP4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjDRP4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:56:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4FECC00
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681833352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bu2WXyCBFn70BrFOAHD2w7CCSZ5K+Kah1HWaszqXR7M=;
        b=JTuPOcXQh518fSbRLym8JHR86xWfD2zXJlJsIMd/IYhWlazoIJRop4xrrg/G/BXPCgNBUo
        3Z4gqBxFo1Ngruih+WUulkY5I/29ktSSp5iYq0enbiVq+Yt9M8wOcGUI63KdoAg91K4NpN
        gPhVbY0spu8+Gpm6VVReLASh1Cbl9pI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-ftZy9QJ0OTSzjntg34nKBg-1; Tue, 18 Apr 2023 11:55:51 -0400
X-MC-Unique: ftZy9QJ0OTSzjntg34nKBg-1
Received: by mail-wm1-f70.google.com with SMTP id p4-20020a05600c468400b003f140953152so5251959wmo.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681833350; x=1684425350;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bu2WXyCBFn70BrFOAHD2w7CCSZ5K+Kah1HWaszqXR7M=;
        b=fgnbkimUIR4ogfpta900NboMT98fGFbq44RWl7yYgBidVl94drRLvAMdpzr6fDPths
         Cpwg8V8egVhxm+UDKUKAZ0hbp4O4R6kz5aOhQZW7IyQJ48nWTxr2NmGICWwCPIKJLE2u
         K37kdN9AO6YHeuA8K5clYRp3r+ghvPOOQSy6BgDNPggZDQrFgnXLd+zio4kiDdeouXyS
         6nxxNXBizbFxMR/Yr1lrM8vdNYvDEe5yVmLjUXaVUivQBtICs1r9Xjb69Zns/bp5iOq/
         0RTmyP0agU2zIgGYh9UhoniOIVnfEHmZiunkaTxs2Riqo4dnb6F0FYN2tG945wn2O4cv
         ddcw==
X-Gm-Message-State: AAQBX9fHq478ekIi5yOxMsP/7B4oVCepnXNcO6xGG1qroot2Fv0cy0SS
        i7j4fWZOkTPZZnirauMLbaia+zforO5DaeQMjc8CSHj7ct4Q5UZD7uVB3LATWuMo5W26WCHJN+P
        9PdVQLTumnYLWDBusdkHdVJqS
X-Received: by 2002:a7b:c7cb:0:b0:3f1:72e2:5d13 with SMTP id z11-20020a7bc7cb000000b003f172e25d13mr5852122wmk.16.1681833350225;
        Tue, 18 Apr 2023 08:55:50 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z1j/eqSrGsLGiAtdPfeIYhyQjZeuM76uEuc4151AByxVjGqnHN1YQGTPrOF+yr1m2bfY1Bnw==
X-Received: by 2002:a7b:c7cb:0:b0:3f1:72e2:5d13 with SMTP id z11-20020a7bc7cb000000b003f172e25d13mr5852102wmk.16.1681833349870;
        Tue, 18 Apr 2023 08:55:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:3f00:7545:deb6:f2f4:27ef? (p200300cbc7153f007545deb6f2f427ef.dip0.t-ipconnect.de. [2003:cb:c715:3f00:7545:deb6:f2f4:27ef])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003ee20b4b2dasm15205166wmc.46.2023.04.18.08.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 08:55:49 -0700 (PDT)
Message-ID: <7fabe6ee-ba8f-6c48-c9f7-90982e2e258c@redhat.com>
Date:   Tue, 18 Apr 2023 17:55:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 4/6] io_uring: rsrc: avoid use of vmas parameter in
 pin_user_pages()
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org
References: <cover.1681831798.git.lstoakes@gmail.com>
 <956f4fc2204f23e4c00e9602ded80cb4e7b5df9b.1681831798.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <956f4fc2204f23e4c00e9602ded80cb4e7b5df9b.1681831798.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.04.23 17:49, Lorenzo Stoakes wrote:
> We are shortly to remove pin_user_pages(), and instead perform the required
> VMA checks ourselves. In most cases there will be a single VMA so this
> should caues no undue impact on an already slow path.
> 
> Doing this eliminates the one instance of vmas being used by
> pin_user_pages().
> 
> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>   io_uring/rsrc.c | 55 ++++++++++++++++++++++++++++---------------------
>   1 file changed, 31 insertions(+), 24 deletions(-)
> 
> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> index 7a43aed8e395..3a927df9d913 100644
> --- a/io_uring/rsrc.c
> +++ b/io_uring/rsrc.c
> @@ -1138,12 +1138,37 @@ static int io_buffer_account_pin(struct io_ring_ctx *ctx, struct page **pages,
>   	return ret;
>   }
>   
> +static int check_vmas_locked(unsigned long addr, unsigned long len)

TBH, the whole "_locked" suffix is a bit confusing.

I was wondering why you'd want to check whether the VMAs are locked ...

> +{
> +	struct file *file;
> +	VMA_ITERATOR(vmi, current->mm, addr);
> +	struct vm_area_struct *vma = vma_next(&vmi);
> +	unsigned long end = addr + len;
> +
> +	if (WARN_ON_ONCE(!vma))
> +		return -EINVAL;
> +
> +	file = vma->vm_file;
> +	if (file && !is_file_hugepages(file))
> +		return -EOPNOTSUPP;

You'd now be rejecting vma_is_shmem() here, no?


-- 
Thanks,

David / dhildenb

