Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CE7637476
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKXIvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKXIvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:51:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A6410CE87
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669279849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AlSq+R0UCGrzWTN2OI+5ccwHLBt+HswKEpfrCXKCBz8=;
        b=V3rFspKG7Lf/yR1JD+ycj4QhEinEyqB0iMSifRXJztUsRlNH0QgX76rsrNcyLuBz0iq0Ij
        fu1Vn9GpuxRX0Z+NEqXdoIKjwA7rC4IZv+wrGunBeuuZHjJW4XtGTQGadX8SGVQjLI7FBh
        5PFtOdMtOoERuo3pKmH7OQze+UoSsnk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-279-5pu2XqjYOfGNi2vqCt53cQ-1; Thu, 24 Nov 2022 03:50:48 -0500
X-MC-Unique: 5pu2XqjYOfGNi2vqCt53cQ-1
Received: by mail-wr1-f71.google.com with SMTP id r23-20020adfa157000000b00241bcae980cso207376wrr.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:50:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AlSq+R0UCGrzWTN2OI+5ccwHLBt+HswKEpfrCXKCBz8=;
        b=a5XeoEEnYovBbbCsR7AVjnJPctU0QFiWNoLtvagy8fmkDDeD0nomcNt83wtqW1V1+D
         gz6/GBGciH/WbXo1wByRD4KSLrWhtQ5U4JKTA1Szr9m0t8nx/bru2haI7GDQCNtBRk+w
         3Uy22ZOBRG43WaZS1VXxswJDZEHq/QKvW826U78SM/W86paNXzGV1sfrmGX6osP8zLTd
         chx/7tx/9CAyoYazipuYVSEWJbimocaZmktKVSC8Ja3XQRF3ufsHVu5eI6CA/rmGv748
         wQLvEJL/ZchArz5nvzp4TSZnaeQN+DSpnXj9ZxvaY1Dx8/TGE+TeYSvbEv00+0WYUdfw
         BqLg==
X-Gm-Message-State: ANoB5pnIpKvRpk+Fc4Ptt40chQ0TvDtyLTvLQdxylJMLEmjdefb7BcMe
        kkgVZ05jkQzvaWelA7/deH4UIp/mX63p+638ScXk1wF+zsJazhxoAUHMNGJadxc5YOxhNbdhZ8D
        53EQiDzYEYwl6ik4DnRV/HJjO
X-Received: by 2002:a05:600c:4f12:b0:3cf:e7bd:303a with SMTP id l18-20020a05600c4f1200b003cfe7bd303amr9934573wmq.151.1669279846788;
        Thu, 24 Nov 2022 00:50:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4lUOpm6GRem5reVbjhERXENobOIVrxKMIYsHMxEqh3Q90ezhbtAxzFjghfs6HhVnGK2ub/Ng==
X-Received: by 2002:a05:600c:4f12:b0:3cf:e7bd:303a with SMTP id l18-20020a05600c4f1200b003cfe7bd303amr9934560wmq.151.1669279846458;
        Thu, 24 Nov 2022 00:50:46 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:2200:bfcb:7212:1370:de13? (p200300cbc7042200bfcb72121370de13.dip0.t-ipconnect.de. [2003:cb:c704:2200:bfcb:7212:1370:de13])
        by smtp.gmail.com with ESMTPSA id k2-20020adfe3c2000000b00241bc209ae0sm755714wrm.32.2022.11.24.00.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 00:50:46 -0800 (PST)
Message-ID: <ce15b4a2-b35e-bc33-9610-567438982cf3@redhat.com>
Date:   Thu, 24 Nov 2022 09:50:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] mm: migrate: Fix THP's mapcount on isolation
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>, Gavin Shan <gshan@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        zhenyzha@redhat.com, shan.gavin@gmail.com, riel@surriel.com,
        apopple@nvidia.com
References: <20221123005752.161003-1-gshan@redhat.com>
 <e8a64b11-98f9-b571-dce9-a60df98e3e5@google.com>
 <c61612f7-b861-39cf-3e73-dbe4d134eec0@redhat.com>
 <Y35FLfDzZjMlwgF4@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y35FLfDzZjMlwgF4@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.11.22 17:07, Matthew Wilcox wrote:
> On Wed, Nov 23, 2022 at 09:56:38AM +0100, David Hildenbrand wrote:
>> But we do have an even better helper in place already:
>> mm/huge_memory.c:can_split_folio()
>>
>> Which cares about
>>
>> a) Swapcache for THP: each subpage could be in the swapcache
>> b) Requires the caller to hold one reference to be safe
>>
>> But I am a bit confused about the "extra_pins" for !anon. Where do the
>> folio_nr_pages() references come from?
> 
> When we add a folio to the page cache, we increment its refcount by
> folio_nr_pages() instead of by 1.  I suspect this is no longer needed
> (if it was ever needed) and it could be changed.  See
> __filemap_add_folio():
> 
>          long nr = 1;
>          if (!huge) {
>                  nr = folio_nr_pages(folio);
>          folio_ref_add(folio, nr);
> 
>> So *maybe* it makes sense to factor out can_split_folio() and call it
>> something like: "folio_maybe_additionally_referenced"  [to clearly
>> distinguish it from "folio_maybe_dma_pinned" that cares about actual page
>> pinning (read/write page content)].
>>
>> Such a function could return false positives/negatives due to races and the
>> caller would have to hold one reference and be able to deal with the
>> semantics.
> 
> I don't like the 'pextra_pins' parameter to a generic function ...

Right, that part should remain khugepaged specific. The assumption would 
be, that the caller of the generic function holds exactly one additional 
reference.

-- 
Thanks,

David / dhildenb

