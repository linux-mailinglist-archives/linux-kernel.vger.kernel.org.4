Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97F8723A88
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbjFFHwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237621AbjFFHvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:51:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EFA2110
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686037601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K+ftB1AtLtWCxNKATngTgU3r2NR8B5iI1sR85GtAmY8=;
        b=K6FEbE6m1I9kZWWlOl3OFdweEihxqKqeu4TOnK0wUDam5IqKcIL1MH3BL48+ZTKygcJpzx
        lJnPQlSzllZ1yJlcuuPTOj7Rv9iI8Ekrimi1oozfKq8l8zWgyGF2TUAH1Ys66h0APgTHIW
        WwMB2UospvovBl66VL9fbqnZr9N2p6Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-eDS5VGbcOFqcbpYeI0ZOYA-1; Tue, 06 Jun 2023 03:46:39 -0400
X-MC-Unique: eDS5VGbcOFqcbpYeI0ZOYA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30ae9cf0178so2696484f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 00:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686037598; x=1688629598;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+ftB1AtLtWCxNKATngTgU3r2NR8B5iI1sR85GtAmY8=;
        b=Xc60qYfmzq4apb4FpFmHwZujGmJE2dIha15IvwKHvCQkhyB9BD0MUVO1EAatL0dY5q
         9ICGMh+C8MBwWTvjDFaAOKbBCnUv1FoP1X0TAb6Yz6giQwPxwIHwYqxafh6zFt4fCwTF
         k51+0LbShTwtp4e3AObjhPIuiKS78ofCOpM4QisGY/Cf8JlCRAWh96yWWdKx8cOWvV1W
         0TP2MlzC/DJ43W+hSvunjQe0am95AN+TauK+YJ7+Nu6g8nrz7iiC4wNkGuxvb68GQkaL
         GD4qH3tmC/ylKKNeW8AO3S6tzw4bxu0KVDR/xoduNzGnwWY9ZWrjPuzdJJjqwaJQrr5i
         9B/g==
X-Gm-Message-State: AC+VfDw0aozCfoUwMBxWAvePMrrfDSwD3xriOsTbpFtd0z4ZHDwsi6P9
        wK9VZb++BFfndWHzn59g+61lhLAcbvw/t9+qXJuDBjP0PURF9jvH/6vObuyjGpZOb8xUs+tOkvo
        DsBYke6vkNzJ3106CflIBxyMU
X-Received: by 2002:adf:ec85:0:b0:30d:7c09:b60a with SMTP id z5-20020adfec85000000b0030d7c09b60amr1046086wrn.7.1686037598031;
        Tue, 06 Jun 2023 00:46:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6PBV2xw4U1FJGo7FdD6XmO3fOATDMZs6zxD5xLIB9J6jwTw90CqBsVPEYdFp3go5usd1er8Q==
X-Received: by 2002:adf:ec85:0:b0:30d:7c09:b60a with SMTP id z5-20020adfec85000000b0030d7c09b60amr1046066wrn.7.1686037597664;
        Tue, 06 Jun 2023 00:46:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:d100:ce7e:d566:43f8:2b24? (p200300cbc709d100ce7ed56643f82b24.dip0.t-ipconnect.de. [2003:cb:c709:d100:ce7e:d566:43f8:2b24])
        by smtp.gmail.com with ESMTPSA id e35-20020a5d5963000000b00306c5900c10sm11817915wri.9.2023.06.06.00.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 00:46:37 -0700 (PDT)
Message-ID: <160264d0-8110-bda3-eb77-381ac9482dd6@redhat.com>
Date:   Tue, 6 Jun 2023 09:46:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] mm/migrate_device: Try to handle swapcache pages
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     mpenttil@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Alistair Popple <apopple@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Huang, Ying" <ying.huang@intel.com>
References: <20230606050149.25699-1-mpenttil@redhat.com>
 <5a3a4025-9dff-713b-8891-fef2bd450b01@redhat.com>
Organization: Red Hat
In-Reply-To: <5a3a4025-9dff-713b-8891-fef2bd450b01@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.06.23 09:44, David Hildenbrand wrote:
> On 06.06.23 07:01, mpenttil@redhat.com wrote:
>> From: Mika Penttilä <mpenttil@redhat.com>
>>
>> Migrating file pages and swapcache pages into device memory is not supported.
>> The decision is done based on page_mapping(). For now, swapcache pages are not migrated.
>>
>> Things can however be improved, for swapcache pages. Try to get rid of the swap cache,
>> and if successful, go ahead as with other anonymous pages.
>>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: John Hubbard <jhubbard@nvidia.com>
>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>> Cc: "Huang, Ying" <ying.huang@intel.com>
>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>> Reviewed-by: Alistair Popple <apopple@nvidia.com>
>> Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
>> ---
>>
>> v3:
>>     - Adjust comments
>>     - Add Reviewed-bys
>>
>> v2:
>>     - use folio_test_anon() (Huang, Ying)
>>
>>    mm/migrate_device.c | 22 ++++++++++++++++------
>>    1 file changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>> index d30c9de60b0d..f76ebccfe067 100644
>> --- a/mm/migrate_device.c
>> +++ b/mm/migrate_device.c
>> @@ -747,13 +747,23 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>>    
>>    		if (is_device_private_page(newpage) ||
>>    		    is_device_coherent_page(newpage)) {
>> -			/*
>> -			 * For now only support anonymous memory migrating to
>> -			 * device private or coherent memory.
>> -			 */
>> +
>>    			if (mapping) {
>> -				src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
>> -				continue;
>> +				struct folio *folio;
>> +
>> +				folio = page_folio(page);
>> +
>> +				/*
>> +				 * For now only support anonymous memory migrating to
>> +				 * device private or coherent memory.
>> +				 *
>> +				 * Try to get rid of swap cache if possible.
>> +				 *
>> +				 */
>> +				if (!folio_test_anon(folio) || !folio_free_swap(folio)) {
>> +					src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
>> +					continue;
> 
> I'm pretty sure the folio has to be locked in order to call
> folio_free_swap().
> 

Oh, staring at the bigger context, I assume we locked the folios via 
migrate_device_range(), correct?

-- 
Cheers,

David / dhildenb

