Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445046F9F54
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 07:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjEHF64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 01:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjEHF6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 01:58:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214994ED7
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 22:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683525486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gC9s5ZRywHkmOsVozu0TaiLrTE/2gzpB0d9O9rvv8yk=;
        b=FNmoS216puNN2kHr7SeoGb+YEHBjzmI4Nf5WDObcNJFbsTfisFy9SHc8OnalzpUNP9X49f
        RFyTGd7YCjzHvirgJ6EqtpQpBRgdDTA7jSY7ifQys6ijX+vcNBgwKffUZ2pgJAgu/0xd4v
        BH/KL0jLkWLpHiSTH6Ua8t7sPTwF06g=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-i-6AB85yMtWMsKJp81VnIQ-1; Mon, 08 May 2023 01:58:05 -0400
X-MC-Unique: i-6AB85yMtWMsKJp81VnIQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4ef455ba5feso2115541e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 22:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683525483; x=1686117483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gC9s5ZRywHkmOsVozu0TaiLrTE/2gzpB0d9O9rvv8yk=;
        b=JaOWPgPZOVDtd+kwRgf4WCG0Lh3zg9ptOgKLsy2yOdVurD+YLNiK/1aEcBTLEmgu1a
         vkrKImeCpgow+uY8yOe8X3SukV8kq8ewd8qxRWrSXdy3nnCrPXYvmmE0dn5iFvfcG+ag
         elEFInjlCkcgvVOx5ymWTI1P+9i5T8HVo12wKZegqiZPQQwS9yI2fhom9GGJJDNdQbmP
         SvPprT6qqdx1qSNqhypcHBkiQBSAgk2jw7yrAgWz5hziFDe1SAVShRuUpl/ouBDKC7AQ
         Ml4QUjxojaRHkBnaGU3pILdhphqk2Wzhbz200z9hTONii91ICVHMMEcSci7knr7jN9uG
         Fh/A==
X-Gm-Message-State: AC+VfDy7hrqrJUJwltcoCyV5MeNX5txZUkz9C+aHpBlS2zDxeUF6Lu5P
        YxFQk1AGxXT6/4JdDOoTY2zBflR4miwofb3AKEnknKwDsnNOErg3BV1hMjAtqHSZ3hPqBajEysZ
        QLA8K2N4ipO6K9FvW7C1ikBc=
X-Received: by 2002:ac2:4556:0:b0:4f1:38f3:3769 with SMTP id j22-20020ac24556000000b004f138f33769mr2160565lfm.2.1683525483760;
        Sun, 07 May 2023 22:58:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/kOqMxfdOovc+AFvhciNXhZ1+H4MrFFq7DPX+hsFVb1Pw5b9R+Kh1rveUXByRmCBkIofTBg==
X-Received: by 2002:ac2:4556:0:b0:4f1:38f3:3769 with SMTP id j22-20020ac24556000000b004f138f33769mr2160525lfm.2.1683525480489;
        Sun, 07 May 2023 22:58:00 -0700 (PDT)
Received: from [192.168.1.121] (85-23-48-202.bb.dnainternet.fi. [85.23.48.202])
        by smtp.gmail.com with ESMTPSA id u28-20020ac24c3c000000b004f13cd61ebbsm1184679lfq.175.2023.05.07.22.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 22:57:59 -0700 (PDT)
Message-ID: <90bb07c3-6365-8dcf-7d0e-ef2c0163614f@redhat.com>
Date:   Mon, 8 May 2023 08:57:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mm/migrate_device: Try to handle swapcache pages.
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        apopple@nvidia.com, jhubbard@nvidia.com, rcampbell@nvidia.com
References: <20230507061726.13422-1-mpenttil@redhat.com>
 <87wn1ja793.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <f93c14f6-024d-4abc-7598-fa82cc3ea1a5@redhat.com>
 <87sfc79zg8.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
In-Reply-To: <87sfc79zg8.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 8.5.2023 8.14, Huang, Ying wrote:
> Mika Penttilä <mpenttil@redhat.com> writes:
> 
>> H,
>>
>>
>> On 8.5.2023 5.26, Huang, Ying wrote:
>>> mpenttil@redhat.com writes:
>>>
>>>> From: Mika Penttil <mpenttil@redhat.com>
>>>>
>>>> Migrating file pages and swapcache pages into device memory is not supported.
>>>> The decision is done based on page_mapping(). For now, swapcache pages are not migrated.
>>>>
>>>> Things can however be improved, for swapcache pages. Try to get rid of the swap cache,
>>>> and if successful, go ahead as with other anonymous pages.
>>>>
>>>> As a detail, do not mess with shmem pages, as they handle swap internally.
>>>>
>>>> Cc: Alistair Popple <apopple@nvidia.com>
>>>> Cc: John Hubbard <jhubbard@nvidia.com>
>>>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>>>> Signed-off-by: Mika Penttil <mpenttil@redhat.com>
>>>> ---
>>>>    mm/migrate_device.c | 12 ++++++++++--
>>>>    1 file changed, 10 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>>> index d30c9de60b0d..e8169c58c341 100644
>>>> --- a/mm/migrate_device.c
>>>> +++ b/mm/migrate_device.c
>>>> @@ -12,6 +12,7 @@
>>>>    #include <linux/mmu_notifier.h>
>>>>    #include <linux/oom.h>
>>>>    #include <linux/pagewalk.h>
>>>> +#include <linux/shmem_fs.h>
>>>>    #include <linux/rmap.h>
>>>>    #include <linux/swapops.h>
>>>>    #include <asm/tlbflush.h>
>>>> @@ -750,10 +751,17 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>>>>    			/*
>>>>    			 * For now only support anonymous memory migrating to
>>>>    			 * device private or coherent memory.
>>>> +			 *
>>>> +			 * Try to get rid of swap cache if possible.
>>>> +			 * Leave shmem pages alone, they handle swap internally
>>>> +			 *
>>>>    			 */
>>>>    			if (mapping) {
>>>> -				src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
>>>> -				continue;
>>>> +				if (shmem_mapping(mapping) ||
>>>> +				    !folio_free_swap(page_folio(page))) {
>>> Should we filter out file pages firstly?
>>
>> folio_free_swap() checks first and returns false if not swapcache page
>> (ie including normal file pages) so think that is enough,
> 
> You are right.  folio_free_swap() will call folio_test_swapcache(), and
> which will check folio_test_swapbacked().
> 
> And, IIUC, we don't need to check shmem too.  Because folio_free_swap()
> will not return true for shmem pages.

Ah yes true, for not written out shmem page folio_free_swap() returns 
false (because !swapcache). And written out (but in swap cache) returns 
false because folio_swapped() == true

> 
>> but maybe for clarity and not depending on it, could be good
>> explicitly check for swapcache before calling folio_free_swap().
> 
> Yes.  That will be more clear.  I suggest to use folio_test_anon(), that
> will filter out shmem pages too.

Agreed.

> 
>>>
>>>> +					src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
>>>> +					continue;
>>>> +				}
>>>>    			}
>>>>    		} else if (is_zone_device_page(newpage)) {
>>>>    			/*
> 
> Best Regards,
> Huang, Ying
> 

Thanks,
Mika

