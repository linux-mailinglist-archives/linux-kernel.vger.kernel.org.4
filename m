Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248726322D4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiKUMtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKUMtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:49:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E816B6B07
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669034929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aHf92GqKpS09QwwfFT9qcxPp2ZW8/6FXVgc85jLdYtQ=;
        b=cNaFqOLn20NZ0PeXcLNpY3D7lRmy//VvsQEwIceD8vTH8D+7imL7oRUjrc9d/pRDxHG00n
        9HpDeHP96guQaV2t/63MR/CGI8rLu8IZ7cyJSZ6HGlyg9xzBGa4eCS7b3ZiJIn1scvr3A8
        IkYisTIXQT3i5MlJT3rVotEblb1boI0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-596-fJHa28yzNQWgY7AJDLoQKg-1; Mon, 21 Nov 2022 07:48:47 -0500
X-MC-Unique: fJHa28yzNQWgY7AJDLoQKg-1
Received: by mail-wm1-f72.google.com with SMTP id m34-20020a05600c3b2200b003cf549cb32bso9242379wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:48:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHf92GqKpS09QwwfFT9qcxPp2ZW8/6FXVgc85jLdYtQ=;
        b=P5sbaHOd/7Ol+JQHQD/L8c9n86PZaWtt3s2tEqUSqMtRIUi87Week0mRsYuUn0ozZZ
         W6CO2sgbyu7E5vPYE9WJ5Ymqoz4+b7v/KI5rpWidCR+UYeV+17PS6jbCZggzH5K34P7T
         nNB06zO1sJ7x0pdwv3pGnuL3rhXc6T1oWUynQ67+1ChE1eWkBBLVRYW0LzJ3eQBATFf5
         KNi55YXmeJ4XnbPTP0Em6iK3c9saz5s3SDNet8B1QMQ5EhK68o+KPWpjORFR3czDSrMg
         IJ5K9ytPwJuDQJOYcgeUzw22N3U7k05Dsp+TtM3wpFtDtTyJvOw/wdMVx5eSHSq52BJh
         Mrew==
X-Gm-Message-State: ANoB5pnrcqwrprt2+3vcB8SVNifyTxna2+Rz0xxUHsfbJdaB3M3FKTpE
        vXs4aIo4kMV95N8pPwjpoHAouc+3srLrGF/dcYVn3mGuDklLKHaY4vptgO8Qkm+/jgkrAOvwOrz
        Rx2uv4eMcPDdh/j0UVGDvXUkV
X-Received: by 2002:adf:e2c9:0:b0:241:db86:176d with SMTP id d9-20020adfe2c9000000b00241db86176dmr1463205wrj.40.1669034926684;
        Mon, 21 Nov 2022 04:48:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4P9jvmww0P1quzMMscjBvUsyD5TxdE1CgpVjmHjZzvQrrZef/mUpNWvrKeTlgogAZ2QpjMAA==
X-Received: by 2002:adf:e2c9:0:b0:241:db86:176d with SMTP id d9-20020adfe2c9000000b00241db86176dmr1463185wrj.40.1669034926351;
        Mon, 21 Nov 2022 04:48:46 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:dc00:2571:c3c2:c6ea:84ef? (p200300cbc702dc002571c3c2c6ea84ef.dip0.t-ipconnect.de. [2003:cb:c702:dc00:2571:c3c2:c6ea:84ef])
        by smtp.gmail.com with ESMTPSA id q2-20020adffec2000000b00241d544c9b1sm3880875wrs.90.2022.11.21.04.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 04:48:45 -0800 (PST)
Message-ID: <208d4106-97e9-79b7-4077-788cdafa1b16@redhat.com>
Date:   Mon, 21 Nov 2022 13:48:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH -next] mm/hugetlb: stop using 0 as NULL pointer
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, mike.kravetz@oracle.com
Cc:     songmuchun@bytedance.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20221121102037.75307-1-yang.lee@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221121102037.75307-1-yang.lee@linux.alibaba.com>
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

On 21.11.22 11:20, Yang Li wrote:
> mm/hugetlb.c:1531:37: warning: Using plain integer as NULL pointer
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3224
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   mm/hugetlb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 222937d512c4..b6c2fc882f21 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1528,7 +1528,7 @@ static void add_hugetlb_folio(struct hstate *h, struct folio *folio,
>   	}
>   
>   	folio_set_compound_dtor(folio, HUGETLB_PAGE_DTOR);
> -	folio_change_private(folio, 0);
> +	folio_change_private(folio, NULL);
>   	/*
>   	 * We have to set HPageVmemmapOptimized again as above
>   	 * folio_change_private(folio, 0) cleared it.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

