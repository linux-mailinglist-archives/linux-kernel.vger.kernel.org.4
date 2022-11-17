Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5430B62D9D8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbiKQLuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbiKQLtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:49:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BD310C6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668685706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VkDO0tN0QVhq9+4ytiHH1Q+NQsFL/NHOuSBEb6Cn4GU=;
        b=fNlklGim0uUS/UAACh64KERu17mjwMaf3cgd8MXEw9m12N68kgyCoOdesXVJh9izX6gTk/
        99QpsoyBLXks1/Orf7pF3qjedJenvf5+tzH27nI6L9qb4GG59AerPbQ1kpA8WdmzX19LfR
        e496LKayy2nResyxDLF4kxo5MEeLmYQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-231-KDlrVyq0Ol6licUxnymqYA-1; Thu, 17 Nov 2022 06:48:24 -0500
X-MC-Unique: KDlrVyq0Ol6licUxnymqYA-1
Received: by mail-wr1-f72.google.com with SMTP id r23-20020adfa157000000b00241bcae980cso15528wrr.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:48:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VkDO0tN0QVhq9+4ytiHH1Q+NQsFL/NHOuSBEb6Cn4GU=;
        b=a/no2Ow4BdBO96/2XabSSEt9zVY9jCnAchGU3m4pbXAxJz4yyrsH/bTyrLR9OHW9nu
         +cgOhqwajaNH15XIIUx3y68ETL6XOHIG1tLYozdmVFUUQctM3FfNpGMiVhcSOV/JMTRN
         qdc3wEskT4qLB8PuyvVO0OVCEnx/n8BQzrYo+/16+0YtWZxQFU45UqqnoCD+enqwRgfc
         GEbwBY6YOK4yc79hlgY1bQ75vSzVxVMIcDzjixQsCPq/X8ry9zRliijNw4lszp+E9mS1
         PsJ5wkXLHWRNUQIeARs1qZvvY3gVac9krjgSPY5LQ3+geLTPRyIMaUnh0UHRcBV4ny+8
         +Oww==
X-Gm-Message-State: ANoB5pm2awpJ2fatuBIqCe9PPxWO/ZdroLjfnBMo+u49bblWchRDnJCW
        eUEuHsPlqQpj41ybXPEbgZVg3Vlx9kkIzHtJpwhLwrSfQ9wPlfvXzLCGpSTQBh+0hZTkogGIYCh
        I5d8PPMaP9GoRXb/+qveznE5A
X-Received: by 2002:adf:e4cf:0:b0:241:a047:d011 with SMTP id v15-20020adfe4cf000000b00241a047d011mr1264609wrm.258.1668685702239;
        Thu, 17 Nov 2022 03:48:22 -0800 (PST)
X-Google-Smtp-Source: AA0mqf674QznTApmbdD3nTnBkGQgOC8JsrJmb13qrGrKOFNYUOmLozHLVWFFRxtSD6QXoicjTAAZRQ==
X-Received: by 2002:adf:e4cf:0:b0:241:a047:d011 with SMTP id v15-20020adfe4cf000000b00241a047d011mr1264600wrm.258.1668685702040;
        Thu, 17 Nov 2022 03:48:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:5200:39a9:b834:27c1:4ede? (p200300cbc707520039a9b83427c14ede.dip0.t-ipconnect.de. [2003:cb:c707:5200:39a9:b834:27c1:4ede])
        by smtp.gmail.com with ESMTPSA id l8-20020adfa388000000b002417f35767asm824276wrb.40.2022.11.17.03.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 03:48:21 -0800 (PST)
Message-ID: <7379a953-5a87-7978-b413-3d52b9b55795@redhat.com>
Date:   Thu, 17 Nov 2022 12:48:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH -next] migrate: stop using 0 as NULL pointer
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20221116012345.84870-1-yang.lee@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221116012345.84870-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.11.22 02:23, Yang Li wrote:
> mm/migrate.c:1198:24: warning: Using plain integer as NULL pointer
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3080
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   mm/migrate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 15dc56a3da7a..e50b3c42e6ad 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1195,7 +1195,7 @@ static int unmap_and_move(new_page_t get_new_page,
>   		return -ENOMEM;
>   	dst = page_folio(newpage);
>   
> -	dst->private = 0;
> +	dst->private = NULL;
>   	rc = __unmap_and_move(src, dst, force, mode);
>   	if (rc == MIGRATEPAGE_SUCCESS)
>   		set_page_owner_migrate_reason(&dst->page, reason);

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

