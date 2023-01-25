Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE5B67BE96
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbjAYVca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236699AbjAYVcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:32:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D0A6468E
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674682178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+3rznV8wx4X+yB1UWrWlqHy1SXTFiqs3a5IOR+yL6Xw=;
        b=cVgzYA5CCnREd0n5weQ5gSOPr7VNwfeDbU+0KutN3ugMoqLRG79F/W9+ZmyftJGImmpCs+
        H6N0s9diIE0TjEK81Kx9zVHyMyOeLoBdoK3887iVCnmcOWP/KSD+SvU09YyBVDr1WkDG3/
        qfaJgviPgn/3qNXNrrs6Wl8jDQnJ15I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-102-izhpywxYMlyJImJgEky89w-1; Wed, 25 Jan 2023 16:29:34 -0500
X-MC-Unique: izhpywxYMlyJImJgEky89w-1
Received: by mail-wm1-f71.google.com with SMTP id l5-20020a1ced05000000b003db300f2e1cso1030962wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:29:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3rznV8wx4X+yB1UWrWlqHy1SXTFiqs3a5IOR+yL6Xw=;
        b=K0r2H9qd+67E2JRyaZpCsxYARTsjF2yb1lqUDxD5JImR6ovf6CecfOL+WvsSLyNM1a
         vNrkziCTnJFMHS5Tg9YUS5oMkgls2cczJS1Tai/wUgkKpFfe14LS8i1/wJ19bDTLiDWG
         1ic9Y8nBn3CcsLWEqsCcfpjGuBycjZRGAenlhG1YB0D0uo1vexDJl7VkFyoQ/7n0N79w
         ppT/0yHbgI89mm/R2esQzNA6Vezhsv7zG3JdRfhj0TXRrSE2QaG/WLmJ40FI/EiFD8T+
         0yRjf4wwm8vR1QNjE7syGDBADY5NoNdahj931IEDhTPBKZbjOwb6TfpiMoKbC8eDPO7n
         rxUQ==
X-Gm-Message-State: AFqh2krm46Gs0haoRE3r+LF2a09arJAJINvhSESclaEVeMDi57OxJ6du
        iF1E/9ZBzUIV7fFZotcdxHCF1/xCYanf+Segie7X6L0pnGB6gzfGTb9tnmKqrCugVOZXyFkfmti
        +5VDaaRwLCWu68hFGdz2xscxc
X-Received: by 2002:a05:600c:214:b0:3db:30f:bd72 with SMTP id 20-20020a05600c021400b003db030fbd72mr30331262wmi.8.1674682173306;
        Wed, 25 Jan 2023 13:29:33 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtkN4Dh/SE5gudDftJKxz/TTCDl0jpnrgvCUJZS6K+ABEs0uNCh4SGXWeZs8mhjaTwMlPFkwA==
X-Received: by 2002:a05:600c:214:b0:3db:30f:bd72 with SMTP id 20-20020a05600c021400b003db030fbd72mr30331248wmi.8.1674682172989;
        Wed, 25 Jan 2023 13:29:32 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:4c00:486:38e2:8ff8:a135? (p200300cbc7054c00048638e28ff8a135.dip0.t-ipconnect.de. [2003:cb:c705:4c00:486:38e2:8ff8:a135])
        by smtp.gmail.com with ESMTPSA id o3-20020a05600c4fc300b003db1d9553e7sm3282961wmq.32.2023.01.25.13.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 13:29:32 -0800 (PST)
Message-ID: <53d86764-d155-8d97-1a4d-7e701848c950@redhat.com>
Date:   Wed, 25 Jan 2023 22:29:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mm-unstable v2 1/6] mm: Add folio_estimated_mapcount()
From:   David Hildenbrand <david@redhat.com>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
References: <20230124012210.13963-1-vishal.moola@gmail.com>
 <20230124012210.13963-2-vishal.moola@gmail.com>
 <477bbc1e-a60a-cfce-d31e-0b4bdd5f6429@redhat.com>
 <526e5156-6c4b-9f2c-1637-2f83c1dfea1e@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <526e5156-6c4b-9f2c-1637-2f83c1dfea1e@redhat.com>
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

On 25.01.23 11:24, David Hildenbrand wrote:
> On 25.01.23 11:20, David Hildenbrand wrote:
>> On 24.01.23 02:22, Vishal Moola (Oracle) wrote:
>>> folio_estimated_mapcount() takes in a folio and calls page_mapcount() on
>>> the first page of that folio.
>>>
>>> This is necessary for folio conversions where we only care about either the
>>> entire_mapcount of a large folio, or the mapcount of a not large folio.
>>>
>>> This is in contrast to folio_mapcount() which calculates the total
>>> number of the times a folio and its subpages are mapped.
>>>
>>> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>>> ---
>>>     include/linux/mm.h | 5 +++++
>>>     1 file changed, 5 insertions(+)
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index c9db257f09b3..543c360f7ecc 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -875,6 +875,11 @@ static inline int page_mapcount(struct page *page)
>>>     	return mapcount;
>>>     }
>>>     
>>> +static inline int folio_estimated_mapcount(struct folio *folio)
>>> +{
>>> +	return page_mapcount(folio_page(folio, 0));
>>> +}
>>> +
>>>     int folio_total_mapcount(struct folio *folio);
>>>     
>>>     /**
>>
>> I'm sorry, but "estimated" as absolutely unclear semantics. You could
>> have a THP mapped into 9999 processes using THP and the estimation would
>> be "0".
> 
> ... or would it be 9999 ? What about a PMD-mapped THP? What about a
> partially unmapped THP?
> 
> What are we estimating?

Thinking about mapcounts again, might not have been my smartest moment.

What we return here is the precise number of times the first subpage is 
mapped (via the large folio and directly). That's supposed to be an 
estimate for the number of times any subpage part of the folio is mapped.

I really don't know a better name, but folio_estimated_mapcount() does 
not feel completely right to me and triggere dmy confusion in the first 
place ... hm ...

-- 
Thanks,

David / dhildenb

