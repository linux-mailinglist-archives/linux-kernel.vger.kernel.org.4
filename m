Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC89679504
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjAXKSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjAXKSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:18:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614B05272
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674555467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=krTIstqgNa3Jm9HB44XJKCzpTg02BS6CTQidrfRJNkk=;
        b=HsszXucBABpDD81Tnv2GAsJREOM4SOGtbxVli/ydxPpBWstQQFXVleuBvJ7tCtDvwmVomF
        XcIBilsLbP/Fpy0iXeGruEsRKmeOBjmyuW0gI9RYjeOL8y4oS6vCsTrguaHfSrVsC1uy7R
        kDRuQeM8vQVYwoJJ8vUWNedARf3fRzc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-526-yKUgytIPPMGMJmq069MAXQ-1; Tue, 24 Jan 2023 05:17:46 -0500
X-MC-Unique: yKUgytIPPMGMJmq069MAXQ-1
Received: by mail-wm1-f70.google.com with SMTP id bg25-20020a05600c3c9900b003da1f6a7b2dso10960832wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:17:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krTIstqgNa3Jm9HB44XJKCzpTg02BS6CTQidrfRJNkk=;
        b=2hhUUVFNv8Tn5PXUH3Dl1lMCImnEEdPnlYT/XNPWFnw4i9iZsn4AGxJL6CS975i1fW
         1dDVYpL8XHJtx7KBidwqUXnwOstSeSsxyy+T9q9DU+KgHkaCL3ihtC11VKrz3FwMX4y4
         PPELEoIDZs1QDHUX0J18Nk/TxTFKK/affmMjcWAl186WqqJrea19WoDN0prKZmm3ZKoA
         htuo0fEAn44goe41WYakdUyDQmJiFM8tsxYLcMfrivkD25zLy2iROI8KCM1PD2aEBfTw
         kusJIDEgua5/4ETOmco+vBAX55RB20eVCLt8Qw0Jp5d5kw8DraVnn6NR2sDmYgewNDHZ
         sp/Q==
X-Gm-Message-State: AFqh2kpRD1mBhl9BtwxH0VobI71fu+hLEJ7T4HLtCbgI3ydb3MWWjvJE
        h66WtrAwPX6gifqT5RjnTpp3mm5H+jlvEvV0du/MlL+ZZ9vJISzOUHyc0aYKCHTEvW6IxuBwE3r
        rs/cMZSgqp44pOtudKbIVyXlS
X-Received: by 2002:a05:6000:98d:b0:2be:129c:2920 with SMTP id by13-20020a056000098d00b002be129c2920mr27495242wrb.13.1674555464973;
        Tue, 24 Jan 2023 02:17:44 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt9sDIeFrtTARrl/I71l7DcQiEq4TDVriQ6laxq8SGedjpnBZM2KMiVZYGJTUJw+EoXZAGnrw==
X-Received: by 2002:a05:6000:98d:b0:2be:129c:2920 with SMTP id by13-20020a056000098d00b002be129c2920mr27495226wrb.13.1674555464678;
        Tue, 24 Jan 2023 02:17:44 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id j8-20020adff008000000b00297dcfdc90fsm1541164wro.24.2023.01.24.02.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 02:17:44 -0800 (PST)
Message-ID: <cd51d200-b3c5-0f1c-bae0-ef9903051e7a@redhat.com>
Date:   Tue, 24 Jan 2023 11:17:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] mm/memory_hotplug: remove head page reference in
 do_migrate_range
To:     Matthew Wilcox <willy@infradead.org>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, osalvador@suse.de
References: <20230123202347.317065-1-sidhartha.kumar@oracle.com>
 <Y87wJ6ERhdujjo6P@casper.infradead.org>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y87wJ6ERhdujjo6P@casper.infradead.org>
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

On 23.01.23 21:37, Matthew Wilcox wrote:
> On Mon, Jan 23, 2023 at 12:23:46PM -0800, Sidhartha Kumar wrote:
>> @@ -1637,14 +1637,13 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>>   			continue;
>>   		page = pfn_to_page(pfn);
>>   		folio = page_folio(page);
>> -		head = &folio->page;
>>   
>> -		if (PageHuge(page)) {
>> -			pfn = page_to_pfn(head) + compound_nr(head) - 1;
>> +		if (folio_test_hugetlb(folio)) {
>> +			pfn = folio_pfn(folio) + folio_nr_pages(folio) - 1;
>>   			isolate_hugetlb(folio, &source);
>>   			continue;
>> -		} else if (PageTransHuge(page))
>> -			pfn = page_to_pfn(head) + thp_nr_pages(page) - 1;
>> +		} else if (folio_test_transhuge(folio))
>> +			pfn = folio_pfn(folio) + thp_nr_pages(page) - 1;
> 
> I'm pretty sure those two lines should be...
> 
> 		} else if (folio_test_large(folio))
> 			pfn = folio_pfn(folio) + folio_nr_pages(folio) - 1;
> 
> But, erm ... we're doing this before we have a refcount on the page,
> right?  So this is unsafe because the page might change which folio
> it is in.  And the folio we found earlier might become a tail page
> of a different folio.  (As the comment below explains, HWPoison pages
> won't, so it's not unsafe for them).
> 
> Also, thp_nr_pages(page) is going to return 1 for tail pages.  So this
> is a noop, unless page is a head page.
> 
> It's all a bit confusing, and being memory-hotplug, it's not well
> tested.  More thought needed.

Ehm, it is fairly well tested ;)

As memory offlining keeps retrying, temporarily making wrong assumptions 
about a folio is acceptable, as long as we don't run into BUGs.

It's certainly worth a big comment in a code, that this is all racy and 
that page migration code will stabilize.

Now, we could temporarily take a reference, but ... common migration 
code will try taking its own ref to stabilize the page and would be 
confused about yet another ref (-> migration will fail).

So we have to be careful about grabbing references on these pages, and 
how long we're going to hold them. Otherwise we'll break memory 
offlining completely :)

-- 
Thanks,

David / dhildenb

