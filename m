Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A9373F8FD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjF0JsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjF0JsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E7AE54
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 02:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687859236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8KWqvFP3RMVD+rxH2vS5PnYCDtTX1f6aQy7ktvp8gp4=;
        b=L7AhjdLs1sOhlNCY2KZDw0961ZBCsKeZiTf0vqHD/kgYkCFhmH1Hq/x2rP+4GkBE8jOCrE
        RARF8eJPMPT/YsImEQ8WZ42eSb3dwPNr8JYlzuQ/2tn/GTKyzzVf7SgBcVJW3ynDvOfDM6
        z4xXBC+Dcd3pLfYeo1K+kNpBk6Xh7oc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-wHoMOovtP9SuCRhQo8Qp8A-1; Tue, 27 Jun 2023 05:47:14 -0400
X-MC-Unique: wHoMOovtP9SuCRhQo8Qp8A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3111a458cfbso2653697f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 02:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687859233; x=1690451233;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8KWqvFP3RMVD+rxH2vS5PnYCDtTX1f6aQy7ktvp8gp4=;
        b=RHvSMCLe2Tx7S4Sl5OzlwDBTeRQuYP9JggdXJ8Mmj5hjmk/OdDhY4IO5DBM8iT4Kje
         5h0A736xqjH2CG9/E1ScieT04kzYJhI5exVuUpKo/hA8W6aqBdcnR/RQtD6BNG+bCHrB
         VVgTz5WUzf3Nyqq2WeQxHLCvJB5cVsGVCKCklp/CVOgUSnGTAmpxY+tpLTgWFyB9T6mH
         iLgIs70rKppISdm1HHRL1dbzXOGv/m59dN7AUFcaELJPtrNSLeSb3yT2B26tD7jfLKfi
         eKCBaWx0CTF0ZgYXS7t8Xsyp7MDTcP4hpXD8u2ivo/NZu59qqY4GTxTtp1bq67S2/dHc
         sO9w==
X-Gm-Message-State: AC+VfDxGN3Iqq0HoSzCsNzrTX11U5zXW2lZJ+k3jtpdUH4sm2qN0wJOa
        PYOdu4iAL33CcWbxO9+GHk0O8jIw1t5+HzQvOiJAO3spz6jldwMZZi/+7QD37JyKOqbH/5kc1p4
        U3O0xgaw5DbXnYhA6B8gxQU0Y
X-Received: by 2002:adf:ec45:0:b0:30f:af06:7320 with SMTP id w5-20020adfec45000000b0030faf067320mr13469838wrn.23.1687859233412;
        Tue, 27 Jun 2023 02:47:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ602Nh5U2pPY8nzxMhl5L4+SJfbJEWPSY9F9428eTN/iN2W9V8vT4WGQIDuk62lVf6Wj0QcXA==
X-Received: by 2002:adf:ec45:0:b0:30f:af06:7320 with SMTP id w5-20020adfec45000000b0030faf067320mr13469824wrn.23.1687859233083;
        Tue, 27 Jun 2023 02:47:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:4900:68b3:e93b:e07a:558b? (p200300cbc737490068b3e93be07a558b.dip0.t-ipconnect.de. [2003:cb:c737:4900:68b3:e93b:e07a:558b])
        by smtp.gmail.com with ESMTPSA id b3-20020adfe303000000b0030fd03e3d25sm9916716wrj.75.2023.06.27.02.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 02:47:12 -0700 (PDT)
Message-ID: <a339954e-a061-3cd6-78bf-47286a9374eb@redhat.com>
Date:   Tue, 27 Jun 2023 11:47:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm/hugetlb: remove hugetlb_set_page_subpool()
Content-Language: en-US
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, tsahu@linux.ibm.com,
        muchun.song@linux.dev, mike.kravetz@oracle.com
References: <20230623054635.279495-1-sidhartha.kumar@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230623054635.279495-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.23 07:46, Sidhartha Kumar wrote:
> All users have been converted to hugetlb_set_folio_subpool() so we can
> safely remove this function.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>   include/linux/hugetlb.h | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index beb7c63d28716..d14676b6d144f 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -761,11 +761,6 @@ static inline void hugetlb_set_folio_subpool(struct folio *folio,
>   	folio->_hugetlb_subpool = subpool;
>   }
>   
> -static inline void hugetlb_set_page_subpool(struct page *hpage,
> -					struct hugepage_subpool *subpool)
> -{
> -	hugetlb_set_folio_subpool(page_folio(hpage), subpool);
> -}
>   
>   static inline struct hstate *hstate_file(struct file *f)
>   {

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

