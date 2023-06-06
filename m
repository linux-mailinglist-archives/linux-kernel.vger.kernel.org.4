Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278BB723AE6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjFFIDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbjFFIDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:03:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82446E5D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686038404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nj+/2+U45d0koakh+NlVyOyMN8MxJqIXM/b39F3PwHg=;
        b=YrUIBkcBV0zWujqSIk6l3yG4Ua3CXBt3dz4MhtRgsHKretRfAWFFh/wHouER9oicxRcjEa
        +ZTC6LWxejJOV0VcC7trh2GMSo0EqznN7vy1yIHZi223iAFlTVEqk5DkOGzyBBQ0ne3gmE
        EFVi9N19P6Cj195Bga0UagX2bW/v/SY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-1R3AWikxOLGhVEk06aY9MQ-1; Tue, 06 Jun 2023 04:00:03 -0400
X-MC-Unique: 1R3AWikxOLGhVEk06aY9MQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4f01644f62eso3863466e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 01:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686038401; x=1688630401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nj+/2+U45d0koakh+NlVyOyMN8MxJqIXM/b39F3PwHg=;
        b=TAnilctCtdtWCfrvUYLr+kbIM/UdN/MTLciR8nE9zztVJYyzWSK3dxyWyM4UzNbhWA
         0dV70ernxJqlYPxWTGPUFFtS2SRLODrh6ceVaWf2zAYM6ZCd8xlLsbZtfkpMuHCnVWbI
         RnA1g1s1VK225lBAlt4Ierr17K8rczfRrgp3psSVsVetQcKYlj2o4UX50IYCgA0nQavl
         iRWuk1MYxMNHlW2WeSoO4+yeknO5TQTgU8lkOY1Tde0cN+g3CdDg+1PKUAua3QcnDQYo
         8VkZC9t/ym6s3qWXTl8DaBw6bgxp2gjcwWWqr0nnmxzx0Ktpn5eb+youRnhh3TJAIFtV
         448g==
X-Gm-Message-State: AC+VfDz5F3QfwLN0kgHbybOn4pxjjGCyDtxcg9FMSVhs3frW3NFoUyzT
        onOzXQC2g60iCxLgWibX75hAyOEeCDXyBprI2P0/n0jktqz6LrNIjL+xgiijbrt7WdMHHWvR0zk
        MebIpkGTjUKUZ45b5PQBSy3Rs8UxkTuIGzg==
X-Received: by 2002:a19:c20b:0:b0:4f6:2020:7c24 with SMTP id l11-20020a19c20b000000b004f620207c24mr630899lfc.5.1686038401034;
        Tue, 06 Jun 2023 01:00:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4rdFEtOXQLKdHTS5M50+JOQAeED9HVUUAeFvJDuZWtwyqTUOjbm6ZfWhLvH/9lC9CrAf4NkQ==
X-Received: by 2002:a19:c20b:0:b0:4f6:2020:7c24 with SMTP id l11-20020a19c20b000000b004f620207c24mr630889lfc.5.1686038400497;
        Tue, 06 Jun 2023 01:00:00 -0700 (PDT)
Received: from [192.168.1.121] (62-78-130-207.bb.dnainternet.fi. [62.78.130.207])
        by smtp.gmail.com with ESMTPSA id m21-20020ac24255000000b004f612dddaa8sm1364280lfl.101.2023.06.06.00.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 00:59:59 -0700 (PDT)
Message-ID: <b33de1f0-0f6f-5789-3f1e-6e43304d3c63@redhat.com>
Date:   Tue, 6 Jun 2023 10:59:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] mm/migrate_device: Try to handle swapcache pages
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Alistair Popple <apopple@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Huang, Ying" <ying.huang@intel.com>
References: <20230606050149.25699-1-mpenttil@redhat.com>
 <5a3a4025-9dff-713b-8891-fef2bd450b01@redhat.com>
 <160264d0-8110-bda3-eb77-381ac9482dd6@redhat.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
In-Reply-To: <160264d0-8110-bda3-eb77-381ac9482dd6@redhat.com>
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

Hi,

On 6.6.2023 10.46, David Hildenbrand wrote:
> On 06.06.23 09:44, David Hildenbrand wrote:
>> On 06.06.23 07:01, mpenttil@redhat.com wrote:
>>> From: Mika Penttilä <mpenttil@redhat.com>
>>>
>>> Migrating file pages and swapcache pages into device memory is not 
>>> supported.
>>> The decision is done based on page_mapping(). For now, swapcache 
>>> pages are not migrated.
>>>
>>> Things can however be improved, for swapcache pages. Try to get rid 
>>> of the swap cache,
>>> and if successful, go ahead as with other anonymous pages.
>>>
>>> Cc: Alistair Popple <apopple@nvidia.com>
>>> Cc: John Hubbard <jhubbard@nvidia.com>
>>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>>> Cc: "Huang, Ying" <ying.huang@intel.com>
>>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>>> Reviewed-by: Alistair Popple <apopple@nvidia.com>
>>> Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
>>> ---
>>>
>>> v3:
>>>     - Adjust comments
>>>     - Add Reviewed-bys
>>>
>>> v2:
>>>     - use folio_test_anon() (Huang, Ying)
>>>
>>>    mm/migrate_device.c | 22 ++++++++++++++++------
>>>    1 file changed, 16 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>> index d30c9de60b0d..f76ebccfe067 100644
>>> --- a/mm/migrate_device.c
>>> +++ b/mm/migrate_device.c
>>> @@ -747,13 +747,23 @@ static void __migrate_device_pages(unsigned 
>>> long *src_pfns,
>>>            if (is_device_private_page(newpage) ||
>>>                is_device_coherent_page(newpage)) {
>>> -            /*
>>> -             * For now only support anonymous memory migrating to
>>> -             * device private or coherent memory.
>>> -             */
>>> +
>>>                if (mapping) {
>>> -                src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
>>> -                continue;
>>> +                struct folio *folio;
>>> +
>>> +                folio = page_folio(page);
>>> +
>>> +                /*
>>> +                 * For now only support anonymous memory migrating to
>>> +                 * device private or coherent memory.
>>> +                 *
>>> +                 * Try to get rid of swap cache if possible.
>>> +                 *
>>> +                 */
>>> +                if (!folio_test_anon(folio) || 
>>> !folio_free_swap(folio)) {
>>> +                    src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
>>> +                    continue;
>>
>> I'm pretty sure the folio has to be locked in order to call
>> folio_free_swap().
>>
> 
> Oh, staring at the bigger context, I assume we locked the folios via 
> migrate_device_range(), correct?
> 

Yes either that, or when migrating via virtual addresses 
migrate_vma_collect_pmd() has trylock_page() and we migrate only pages 
which succeed locking.

--Mika


