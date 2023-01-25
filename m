Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEAB67AF9E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbjAYKZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbjAYKZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:25:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF72B4489
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674642261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9rmVt0JSO6hvKk0SzHg2h2ntNFJVRDhgKcCcwj53bLU=;
        b=HFHhgV1BKT0AHND8wN8mClTt5fl9uY0Lxsf0v2s6N9T4zBIIwJuzxv5YQlmAYiNV7hi3yS
        gmh3XVyK2IDxnMl2aDHLHPailwb23j3ZOsVJpBc30jWLzwh60H9+chIiRpLVsgbeCJ6jBD
        ynpVSkaKTA+g86fgnlANdo049KFr0js=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-271-FIvzyxV9NcS8vB45628_Dw-1; Wed, 25 Jan 2023 05:24:19 -0500
X-MC-Unique: FIvzyxV9NcS8vB45628_Dw-1
Received: by mail-wr1-f69.google.com with SMTP id h17-20020a5d5491000000b002bfb1375c4eso767121wrv.17
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:24:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9rmVt0JSO6hvKk0SzHg2h2ntNFJVRDhgKcCcwj53bLU=;
        b=2Ql7udoMUIF//s/3yMPjAlbZEbgjfK9/I4bam5imgbcXCj2Njyna+SxD+5zKqUO1B9
         qX5Qrx61vRNKCQENCK916W+Oyx2YTB4/SW/u7NzdNgRckC24dpR4cWrQrNBzCmencx57
         EpgPDSFwdWDHwAudzHP5Bp0jNE8kDiq0dFb247RJWZMYGvSG6+7+8IcQHsX//M+Z4Gex
         5QDUdVM7q5IJ2DV1eqV9/0ynR9IvUnXpeD7SfY7RWE2SVZMP1uEJrZD4hd8+mCbEEX/H
         M7lK8kcfBe3WSTIh4kBv85e+9wnpQRMy6CPrDpdsPFlKMXfybl63C6LOFxJrvG0l3L4h
         9UUw==
X-Gm-Message-State: AO0yUKVjuX9ifDb2nTeFnBUOSMihAc3m5P8WNIEPKO8zonbPKTW0R9Lc
        vm0GJCoopQ0HvmOs1iMLLMpksNB2DWfTiZQme9KU29iJi3Xk8ziF8x7Jpi8FrnTZiLkGPn2SJ1X
        45Cr9QzKmylqkwk/Q0w3GrEXS
X-Received: by 2002:adf:e3d2:0:b0:2bf:accc:b675 with SMTP id k18-20020adfe3d2000000b002bfacccb675mr6515360wrm.7.1674642257885;
        Wed, 25 Jan 2023 02:24:17 -0800 (PST)
X-Google-Smtp-Source: AK7set/x+9KcZGqQV0QB0Vb2JwNdlzE1lmMcxvd0ry5mRXsdTJ+8gVrL5BnIMsXBK4Ium4TyFUh4Bg==
X-Received: by 2002:adf:e3d2:0:b0:2bf:accc:b675 with SMTP id k18-20020adfe3d2000000b002bfacccb675mr6515345wrm.7.1674642257543;
        Wed, 25 Jan 2023 02:24:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:4c00:486:38e2:8ff8:a135? (p200300cbc7054c00048638e28ff8a135.dip0.t-ipconnect.de. [2003:cb:c705:4c00:486:38e2:8ff8:a135])
        by smtp.gmail.com with ESMTPSA id l4-20020adfa384000000b00241fab5a296sm4041061wrb.40.2023.01.25.02.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 02:24:17 -0800 (PST)
Message-ID: <526e5156-6c4b-9f2c-1637-2f83c1dfea1e@redhat.com>
Date:   Wed, 25 Jan 2023 11:24:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mm-unstable v2 1/6] mm: Add folio_estimated_mapcount()
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
References: <20230124012210.13963-1-vishal.moola@gmail.com>
 <20230124012210.13963-2-vishal.moola@gmail.com>
 <477bbc1e-a60a-cfce-d31e-0b4bdd5f6429@redhat.com>
Organization: Red Hat
In-Reply-To: <477bbc1e-a60a-cfce-d31e-0b4bdd5f6429@redhat.com>
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

On 25.01.23 11:20, David Hildenbrand wrote:
> On 24.01.23 02:22, Vishal Moola (Oracle) wrote:
>> folio_estimated_mapcount() takes in a folio and calls page_mapcount() on
>> the first page of that folio.
>>
>> This is necessary for folio conversions where we only care about either the
>> entire_mapcount of a large folio, or the mapcount of a not large folio.
>>
>> This is in contrast to folio_mapcount() which calculates the total
>> number of the times a folio and its subpages are mapped.
>>
>> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>> ---
>>    include/linux/mm.h | 5 +++++
>>    1 file changed, 5 insertions(+)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index c9db257f09b3..543c360f7ecc 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -875,6 +875,11 @@ static inline int page_mapcount(struct page *page)
>>    	return mapcount;
>>    }
>>    
>> +static inline int folio_estimated_mapcount(struct folio *folio)
>> +{
>> +	return page_mapcount(folio_page(folio, 0));
>> +}
>> +
>>    int folio_total_mapcount(struct folio *folio);
>>    
>>    /**
> 
> I'm sorry, but "estimated" as absolutely unclear semantics. You could
> have a THP mapped into 9999 processes using THP and the estimation would
> be "0".

... or would it be 9999 ? What about a PMD-mapped THP? What about a 
partially unmapped THP?

What are we estimating?

-- 
Thanks,

David / dhildenb

