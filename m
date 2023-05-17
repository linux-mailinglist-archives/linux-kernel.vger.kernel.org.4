Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029EF706100
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjEQHVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjEQHVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:21:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8950F19BD
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684308021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lX9THAjBRRvTJDvL9/RTj01gjyTGzt4OdK7dq/0zryA=;
        b=BSm2+G49E4IMn8V9MuNApZT6OntVKOKJjQ6u04Cdv1xBgccF4Dxtm01uAScaYxy6NWKJ+S
        E5FT+Mso+Piaw2VroG5fwcKX/ZmBjJ++wIXDrujdm+3NPb0gHmOvi8Bm/GnHE2d8pbCqkZ
        a+hOw2QkhPxyUyLfv343G9KTS1GTgEc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-nR-CVmaWNvqVYCTB5WTYZw-1; Wed, 17 May 2023 03:20:20 -0400
X-MC-Unique: nR-CVmaWNvqVYCTB5WTYZw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f4245ffbb4so2365665e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684308019; x=1686900019;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lX9THAjBRRvTJDvL9/RTj01gjyTGzt4OdK7dq/0zryA=;
        b=PimTPg6i+v+BTmTvnK2ckpzH2j2c8B5DbUJ5HLAc5WVDzjGPYfqUBTaEIXvBQ8ttnA
         wnhyxZw5D+4+iiqqSov7KJEOcnfTj09s2T8YDKvRYWudm8XvvI95Y6G6edxoJmZlRhdH
         rfmdFJGIf2STCdUP3J428Ylc3lhWZR1qAO29sZBMLtUvZ02givxbOS4lZnAOQwBrMn4T
         P1NWnAmxrGhlH1SDieUn1L6RXOlxmhllmH6vaFLg1/nZ7Tr6GJkbjq1f6KpjqRRRvIl0
         WXlqsAScZcxI3eaq+xm29uJMm4AODlg/kgOkcjf4dIU6v/tvGuFoUPiAYNQKSGMCC2Xw
         ujEA==
X-Gm-Message-State: AC+VfDxe1EcxZZswgYL0Q3A9VB0PXXP4FZ7QPFLpGKVeXka4HGboUE4c
        FGMNc3bFIrkH3O9U5/HKEC/xxRBAW3CBE6Hdm1d88mLhpqY/6jMgh5EUikP8mcxo0JsrzxTA3+K
        bTnhfFcyAP1Py8YRTXyhnFnyoJ9w921q9
X-Received: by 2002:a7b:cb97:0:b0:3f4:2c71:b9ad with SMTP id m23-20020a7bcb97000000b003f42c71b9admr22412720wmi.30.1684308019192;
        Wed, 17 May 2023 00:20:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7cVZ8I/6wargKKFrizFw4sXbko4IAyzuhu4M0IR8C+EKbw7dIvkODBqskSfpxg4oU9SN/tsg==
X-Received: by 2002:a7b:cb97:0:b0:3f4:2c71:b9ad with SMTP id m23-20020a7bcb97000000b003f42c71b9admr22412699wmi.30.1684308018847;
        Wed, 17 May 2023 00:20:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3900:757e:83f8:a99d:41ae? (p200300cbc7073900757e83f8a99d41ae.dip0.t-ipconnect.de. [2003:cb:c707:3900:757e:83f8:a99d:41ae])
        by smtp.gmail.com with ESMTPSA id s2-20020a1cf202000000b003f50876905dsm1246894wmc.6.2023.05.17.00.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 00:20:18 -0700 (PDT)
Message-ID: <04428bad-4044-ef59-8dfe-381741164148@redhat.com>
Date:   Wed, 17 May 2023 09:20:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mm/hugetlb: remove hugetlb_page_subpool()
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org
References: <20230516225205.1429196-1-sidhartha.kumar@oracle.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230516225205.1429196-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.23 00:52, Sidhartha Kumar wrote:
> All users of hugetlb_page_subpool() have been converted to use the folio
> equivalent. This function can be safely removed.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>   include/linux/hugetlb.h | 13 -------------
>   1 file changed, 13 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index b2b698f9a2ecb..21f942025fecd 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -755,14 +755,6 @@ static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio
>   	return folio->_hugetlb_subpool;
>   }
>   
> -/*
> - * hugetlb page subpool pointer located in hpage[2].hugetlb_subpool
> - */
> -static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
> -{
> -	return hugetlb_folio_subpool(page_folio(hpage));
> -}
> -
>   static inline void hugetlb_set_folio_subpool(struct folio *folio,
>   					struct hugepage_subpool *subpool)
>   {
> @@ -1029,11 +1021,6 @@ static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio
>   	return NULL;
>   }
>   
> -static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
> -{
> -	return NULL;
> -}
> -
>   static inline int isolate_or_dissolve_huge_page(struct page *page,
>   						struct list_head *list)
>   {


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

