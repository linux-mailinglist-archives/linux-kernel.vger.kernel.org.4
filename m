Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5471C63AE4A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbiK1RB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiK1RBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:01:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B18E29
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669654858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=niIYnEoa6K6pf1uBHi1CqtcM+got95SLckIarkh2eow=;
        b=azTa8T0s397lMOkFN/PloN+s3kGLrgHnsc2vepdLeZSahorVcz8BmQwPcAHi4NQ0S8yWbQ
        F5/mkYTxbB7TvorRrK3Rzun6L2jHh3+LQw5BQ8CNVK7mEj/FS5bLK0uiLddf+kE1BH1w34
        r4tJdq6JHsdXcFkU2h6dyDLhvnqy9Gg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-240-ABe_a7S2P8y5b6lMCzSipg-1; Mon, 28 Nov 2022 12:00:57 -0500
X-MC-Unique: ABe_a7S2P8y5b6lMCzSipg-1
Received: by mail-wm1-f71.google.com with SMTP id b47-20020a05600c4aaf00b003d031aeb1b6so8799419wmp.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:00:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=niIYnEoa6K6pf1uBHi1CqtcM+got95SLckIarkh2eow=;
        b=kDfgUeKRx5Un+43y00R/kEwzO0Xw2kSNnIvyZDGGbxjR/dbkDmgU6SWpyiyerbrtdB
         99E3FBMwLfz03yvZF4FTGY7Sg7GQtDaNvdAJg0PSTGsvVFf4PzqiuO4QFESQdwoW/j5c
         1fwggo9I4hNR6yv+mOoTovCY1X5KfgLHVlQsmuX3QRSLrGCbTFbEt+dkyimXmuN31fGE
         YtSjeprxm8UAtQIA4B2ReimXeA5fvRgwpIlob+BuYlRXXWDAiCNgYD0ZXZewKaTAWtMa
         9IM8047Wy29Y4/XXYt8TWp9ck8G5z48qgUSQ94AHD5CwsDZ+BI+ISaLFrRldGeSH/T8N
         nhgA==
X-Gm-Message-State: ANoB5pnFzOXnlbmChqL+odRYWjf0J+BazBbv894KtcZcPsH7EhxPEJlK
        0iY8AjSK0VLHNY9ETENLHDmMqQQPKzMaTwV7zXG+DsZ4BQO63U33lFryFNhtf2Tzb1rpEQt09Tt
        5vjNrJBCE4jR9O+Bcnrskvj97
X-Received: by 2002:a5d:55c9:0:b0:242:1057:40b8 with SMTP id i9-20020a5d55c9000000b00242105740b8mr6057972wrw.182.1669654851582;
        Mon, 28 Nov 2022 09:00:51 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5P6EXV8vknZ/VB0z9CvB+AAHtH91yCE36sEEDpxvAlBEOmBeNr9B+bXhdcWZP3VqcmuW4adQ==
X-Received: by 2002:a5d:55c9:0:b0:242:1057:40b8 with SMTP id i9-20020a5d55c9000000b00242105740b8mr6057946wrw.182.1669654851304;
        Mon, 28 Nov 2022 09:00:51 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:9000:3d6:e434:f8b4:80cf? (p200300cbc702900003d6e434f8b480cf.dip0.t-ipconnect.de. [2003:cb:c702:9000:3d6:e434:f8b4:80cf])
        by smtp.gmail.com with ESMTPSA id az26-20020a05600c601a00b003d01b84e9b2sm15850167wmb.27.2022.11.28.09.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 09:00:50 -0800 (PST)
Message-ID: <9ae67ddb-d2b0-57bb-a181-d35a7af51c67@redhat.com>
Date:   Mon, 28 Nov 2022 18:00:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 2/3] mm/khugepaged: Fix GUP-fast interaction by sending
 IPI
Content-Language: en-US
To:     Jann Horn <jannh@google.com>
Cc:     security@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20221125213714.4115729-1-jannh@google.com>
 <20221125213714.4115729-2-jannh@google.com>
 <ea2a2311-0a7e-cc81-0b82-5de45acba8f5@redhat.com>
 <CAG48ez02g3ind9p9op-t_k3eruANE4idhjT044rK5+qK8_-EFA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAG48ez02g3ind9p9op-t_k3eruANE4idhjT044rK5+qK8_-EFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.11.22 17:58, Jann Horn wrote:
> On Mon, Nov 28, 2022 at 2:46 PM David Hildenbrand <david@redhat.com> wrote:
>> On 25.11.22 22:37, Jann Horn wrote:
>>> Since commit 70cbc3cc78a99 ("mm: gup: fix the fast GUP race against THP
>>> collapse"), the lockless_pages_from_mm() fastpath rechecks the pmd_t to
>>> ensure that the page table was not removed by khugepaged in between.
>>>
>>> However, lockless_pages_from_mm() still requires that the page table is not
>>> concurrently freed.
>>
>> That's an interesting point. For anon THPs, the page table won't get
>> immediately freed, but instead will be deposited in the "pgtable list"
>> stored alongside the THP.
>>
>>   From there, it might get withdrawn (pgtable_trans_huge_withdraw()) and
>>
>> a) Reused as a page table when splitting the THP. That should be fine,
>> no garbage in it, simply a page table again.
> 
> Depends on the definition of "fine" - it will be a page table again,
> but deposited page tables are not associated with a specific address,
> so it might be reused at a different address. If GUP-fast on address A
> races with a page table from address A being deposited and reused at
> address B, and then GUP-fast returns something from address B, that's
> not exactly great either.

The "PMD changed" check should catch that. We only care about not 
dereferencing something that's garbage and not a page/folio if I 
remember the previous discussions on that correctly.

Anyhow, feel free to add my

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

