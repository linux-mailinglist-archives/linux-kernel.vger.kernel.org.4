Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972EC67AF87
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbjAYKU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjAYKUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:20:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0165537577
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674642008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4bssfLw84Lb1N2+6RHiO1GbN0bUTWIhyPpZgbdiMIPk=;
        b=KOT0Dgs+USeIbyOEDfp0ZBPewL/V14U3LsI2G/4lzvuRtm/ICyhnTbi2OJ7A5h0gfSS3ud
        k3IaKCdk81T1vUuBx5Qjoxu8Xwl6s4CcnfOoeNAUS/ualVLklxz2sOYA3eNtnMBlTpskBH
        rsu0VE9PiH/CDxB8ys06RWM/AIfxqaM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-74ZlPW6mNd-KD-P37efcGA-1; Wed, 25 Jan 2023 05:20:06 -0500
X-MC-Unique: 74ZlPW6mNd-KD-P37efcGA-1
Received: by mail-wm1-f72.google.com with SMTP id p1-20020a05600c1d8100b003daff82f5edso10698144wms.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:20:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bssfLw84Lb1N2+6RHiO1GbN0bUTWIhyPpZgbdiMIPk=;
        b=RZouSxlz6JxdetnpjEPiyFkStXr0TnhoJgYwDeaVrP2U7gqM7M6dFYJcRegzJtAx8+
         g6619M3YSuMu5XYEKic8mBxPSubQD7Pwk9BqG2Qfn1XspLj8U57p2NgCACcP5erztnHl
         oKx4g4ePpkE0CUT+ojPKlKV0kOesgkXbOgYk5V3m0iFIkbc66GjU0DD3CuH0OAm9sGmu
         n52JZOgfQui2vypLFTui1Y/SD0bs8jQnfH+dJJlgxU/Ot/ZPvtuChtL+r3rgMuJnlvd/
         AgpTzfkpZZgNtzBwHXsM5gYxNyQFN6HfrQUOZj2Om6qd7ESNITNiGl5UGfkHezGUaSES
         pFLg==
X-Gm-Message-State: AFqh2kqH0llK4IPNoDGzoMBkBpoANI6dAZHy2Dc6WLekBEi+TxHmRJw6
        zjZVfpyNmPjEcQ1ee3ltH3Db8RtXt1nsBD/XT+x9pyC/0j89Hxof30RfKsW+BdQUHbevOU56gs8
        iuTCD76T9QnR0kdzA1CpDPPWz
X-Received: by 2002:a5d:468d:0:b0:242:63a3:2f20 with SMTP id u13-20020a5d468d000000b0024263a32f20mr26543596wrq.11.1674642005022;
        Wed, 25 Jan 2023 02:20:05 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsImpo4DVb+FWP/+3Gl+b6mHKQE0MrGjhKBUuXH/RHYpSJ+CP/A2OZOuIBI5/pbLvN7dkK3EQ==
X-Received: by 2002:a5d:468d:0:b0:242:63a3:2f20 with SMTP id u13-20020a5d468d000000b0024263a32f20mr26543579wrq.11.1674642004669;
        Wed, 25 Jan 2023 02:20:04 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:4c00:486:38e2:8ff8:a135? (p200300cbc7054c00048638e28ff8a135.dip0.t-ipconnect.de. [2003:cb:c705:4c00:486:38e2:8ff8:a135])
        by smtp.gmail.com with ESMTPSA id j7-20020adfb307000000b002be063f6820sm4904478wrd.81.2023.01.25.02.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 02:20:04 -0800 (PST)
Message-ID: <477bbc1e-a60a-cfce-d31e-0b4bdd5f6429@redhat.com>
Date:   Wed, 25 Jan 2023 11:20:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mm-unstable v2 1/6] mm: Add folio_estimated_mapcount()
Content-Language: en-US
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
References: <20230124012210.13963-1-vishal.moola@gmail.com>
 <20230124012210.13963-2-vishal.moola@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230124012210.13963-2-vishal.moola@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.01.23 02:22, Vishal Moola (Oracle) wrote:
> folio_estimated_mapcount() takes in a folio and calls page_mapcount() on
> the first page of that folio.
> 
> This is necessary for folio conversions where we only care about either the
> entire_mapcount of a large folio, or the mapcount of a not large folio.
> 
> This is in contrast to folio_mapcount() which calculates the total
> number of the times a folio and its subpages are mapped.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>   include/linux/mm.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c9db257f09b3..543c360f7ecc 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -875,6 +875,11 @@ static inline int page_mapcount(struct page *page)
>   	return mapcount;
>   }
>   
> +static inline int folio_estimated_mapcount(struct folio *folio)
> +{
> +	return page_mapcount(folio_page(folio, 0));
> +}
> +
>   int folio_total_mapcount(struct folio *folio);
>   
>   /**

I'm sorry, but "estimated" as absolutely unclear semantics. You could 
have a THP mapped into 9999 processes using THP and the estimation would 
be "0".

Huh? Absolutely unclear and confusing. No thanks.

-- 
Thanks,

David / dhildenb

