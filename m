Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD8974B1BB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjGGNZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGGNZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:25:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC620131
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 06:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688736278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VEFcRoCoXVLK+7VFfisj/fbzvaM26gsp7BfC99uuIKI=;
        b=c0l+D2V7deAe1B96RG+7qwxo2+P9ldiUhtSDGiSSgcw5eWws7FSJvba6viQFYFcGX7OviA
        gK/6As08bM1FCLojIZNsHVGKjFg5brF4DiUPzemRguA63illsVcDjDcURkNT2UowFB6eDo
        xRzEmPe8Ll029nXR6YAMr3oOg6t3FX8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-m8vFKfzLN2iLGf0FtcoQfQ-1; Fri, 07 Jul 2023 09:24:36 -0400
X-MC-Unique: m8vFKfzLN2iLGf0FtcoQfQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fbffd088a9so3103745e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 06:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688736275; x=1691328275;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VEFcRoCoXVLK+7VFfisj/fbzvaM26gsp7BfC99uuIKI=;
        b=EfBRSvBVi7f2ttj8kPFhagXD+B3ReECLwHAjP0XSWL6FyckhSkOEYMCEonuWVQB99i
         58TdRqPDwDm89eIY/pJvDLD/AnVbMLiWCKSaHfUjinQD9XTc2TKU5b5fz2STvJYjtqvg
         wIRmhho/FY5uu4dX/14RnNyIG2jRR/CiagD2MJ3ltXCyXKzvGJqx4Y/YJ6FKLePnA+ZP
         USdIQfbb57JjNcKXVMtPY2lW4KsNtqKDIhJcipmhb5aL6qELZ/P76GOl++Um31+zgnHY
         Svb1oP0RfCmFQdWD2IU9iqoqy3zsH+6QXU6nmcRpfGzf/fEwLD3a5FI8+n4G7rX04yqK
         P4Mw==
X-Gm-Message-State: ABy/qLaOX1Rp0tdehXKYo1tC+RODzht4Oo1iLjm8BIHVtFJCfxjufrmJ
        wnckRUipnb0tgvSGQexgsPjsux8IOTLBx7K7FnWT3nd/7aw6cdg5ERLYqne6f5lYMIlofUBRY+6
        1wC86ZXQ8TEorDarNsAupaXQ5XeL2sEjt
X-Received: by 2002:a1c:7207:0:b0:3f9:ba2:5d19 with SMTP id n7-20020a1c7207000000b003f90ba25d19mr2895764wmc.33.1688736275642;
        Fri, 07 Jul 2023 06:24:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGFVvL9q8yYSppFfRa1HCdHsC+rutktlC8PQkloBmNP9FEN51xRbZjnrVds18S/8Ffgzq8L4Q==
X-Received: by 2002:a1c:7207:0:b0:3f9:ba2:5d19 with SMTP id n7-20020a1c7207000000b003f90ba25d19mr2895750wmc.33.1688736275295;
        Fri, 07 Jul 2023 06:24:35 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f04:3c00:248f:bf5b:b03e:aac7? (p200300d82f043c00248fbf5bb03eaac7.dip0.t-ipconnect.de. [2003:d8:2f04:3c00:248f:bf5b:b03e:aac7])
        by smtp.gmail.com with ESMTPSA id s8-20020a7bc388000000b003fbfc61d36asm2396655wmj.5.2023.07.07.06.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 06:24:34 -0700 (PDT)
Message-ID: <bfa13f35-bca9-c4e8-25f3-e8021f85f223@redhat.com>
Date:   Fri, 7 Jul 2023 15:24:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <78159ed0-a233-9afb-712f-2df1a4858b22@redhat.com>
 <4d4c45a2-0037-71de-b182-f516fee07e67@arm.com>
 <d9cb4563-c622-9660-287b-a2f35121aec7@redhat.com>
 <ZKgPIXSrxqymWrsv@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 0/5] variable-order, large folios for anonymous memory
In-Reply-To: <ZKgPIXSrxqymWrsv@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.07.23 15:12, Matthew Wilcox wrote:
> On Fri, Jul 07, 2023 at 01:40:53PM +0200, David Hildenbrand wrote:
>> On 06.07.23 10:02, Ryan Roberts wrote:
>> But can you comment on the page migration part (IOW did you try it already)?
>>
>> For example, memory hotunplug, CMA, MCE handling, compaction all rely on
>> page migration of something that was allocated using GFP_MOVABLE to actually
>> work.
>>
>> Compaction seems to skip any higher-order folios, but the question is if the
>> udnerlying migration itself works.
>>
>> If it already works: great! If not, this really has to be tackled early,
>> because otherwise we'll be breaking the GFP_MOVABLE semantics.
> 
> I have looked at this a bit.  _Migration_ should be fine.  _Compaction_
> is not.

Thanks! Very nice if at least ordinary migration works.

> 
> If you look at a function like folio_migrate_mapping(), it all seems
> appropriately folio-ised.  There might be something in there that is
> slightly wrong, but that would just be a bug to fix, not a huge
> architectural problem.
> 
> The problem comes in the callers of migrate_pages().  They pass a
> new_folio_t callback.  alloc_migration_target() is the usual one passed
> and as far as I can tell is fine.  I've seen no problems reported with it.
> 
> compaction_alloc() is a disaster, and I don't know how to fix it.
> The compaction code has its own allocator which is populated with order-0
> folios.  How it populates that freelist is awful ... see split_map_pages()

Yeah, all that code was written under the assumption that we're moving 
order-0 pages (which is what the anon+pagecache pages part).

 From what I recall, we're allocating order-0 pages from the high memory 
addresses, so we can migrate from low memory addresses, effectively 
freeing up low memory addresses and filling high memory addresses.

Adjusting that will be ... interesting. Instead of allocating order-0 
pages from high addresses, we might want to allocate "as large as 
possible" ("grab what we can") from high addresses and then have our own 
kind of buddy for allocating from that pool a compaction destination 
page, depending on our source page. Nasty.

What should always work is the split->migrate. But that's definitely not 
what we want in many cases.

> 
>> Is swapping working as expected? zswap?
> 
> Suboptimally.  Swap will split folios in order to swap them.  Somebody
> needs to fix that, but it should work.

Good!

It would be great to have some kind of a feature matrix that tells us 
what works perfectly, sub-optimally, barely, not at all (and what has 
not been tested). Maybe (likely!) we'll also find things that are 
sub-optimal for ordinary THP (like swapping, not even sure about).

I suspect that KSM should work mostly fine with flexible-thp. When 
deduplciating, we'll simply split the compound page and proceed as 
expected. But might be worth testing as well.

-- 
Cheers,

David / dhildenb

